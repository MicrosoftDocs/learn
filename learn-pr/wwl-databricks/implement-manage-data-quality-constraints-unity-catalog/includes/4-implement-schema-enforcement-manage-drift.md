Data pipelines often receive data from sources that evolve over time. New columns appear, others disappear, and the structure of incoming data changes as business requirements shift. Without proper controls, these changes can silently corrupt your data or break your pipelines entirely.

In this unit, you learn how to enforce schema constraints in Azure Databricks and implement strategies for detecting and managing schema drift in your data engineering workflows.

## Understand schema enforcement

Schema enforcement is the process of validating that incoming data matches the expected structure of your target table. Delta Lake enforces schema on write by default, which means every write operation validates the data structure before committing changes.

When you insert data into a Delta table, Azure Databricks enforces these rules:

- All columns in the incoming data must exist in the target table
- The source data must include all columns present in the target table
- Column names must match (schema enforcement is case-sensitive by default)

Consider what happens when you attempt to write data that doesn't match the expected schema:

```sql
-- Target table expects columns: customer_id, name, email
CREATE TABLE customers (
    customer_id INT,
    name STRING,
    email STRING
);

-- This insert fails because 'phone' column doesn't exist in target
INSERT INTO customers 
SELECT customer_id, name, email, phone FROM source_data;
```

The operation fails with an error indicating that the column `phone` doesn't exist in the target table. This fail-fast behavior prevents unexpected data from entering your tables.

> [!NOTE]
> Schema enforcement applies to Delta Lake tables by default. Tables backed by external data sources don't enforce schema automatically.

## Detect and respond to schema drift

Schema drift occurs when the structure of incoming data changes over time. Your data pipelines must detect these changes and respond appropriately—either by adapting to the new schema or by alerting operators to investigate.

Azure Databricks provides several approaches for handling schema drift depending on your requirements.

### Fail on schema mismatch

The strictest approach stops processing when schema drift is detected. This strategy works well when data structure changes require manual review before pipeline updates.

With Auto Loader, you can configure this behavior using the `failOnNewColumns` mode:

```python
(spark.readStream
    .format("cloudFiles")
    .option("cloudFiles.format", "json")
    .option("cloudFiles.schemaLocation", "/path/to/schema")
    .option("cloudFiles.schemaEvolutionMode", "failOnNewColumns")
    .load("/path/to/source")
    .writeStream
    .option("checkpointLocation", "/path/to/checkpoint")
    .toTable("target_table")
)
```

When Auto Loader encounters a new column not defined in the schema, the stream stops with an `UnknownFieldException`. You must update the schema or remove the offending data before the pipeline can resume.

### Automatically adapt to new columns

For scenarios where adding new columns is acceptable, you can enable schema evolution. This approach automatically adds new columns to the target table without manual intervention.

Enable schema evolution for write operations:

```python
(df.write
    .format("delta")
    .mode("append")
    .option("mergeSchema", "true")
    .saveAsTable("target_table")
)
```

For `MERGE` operations, use the schema evolution syntax:

```sql
MERGE WITH SCHEMA EVOLUTION INTO target_table t
USING source_data s
ON t.customer_id = s.customer_id
WHEN MATCHED THEN UPDATE SET *
WHEN NOT MATCHED THEN INSERT *
```

New columns from the source are automatically added to the target table. However, you should carefully consider when to use schema evolution—automatic changes might introduce columns you didn't expect.

### Rescue unexpected data

When you need to preserve data that doesn't match your schema without modifying the target structure, use the rescued data column. This approach captures mismatched data in a separate JSON column for later review.

```python
(spark.readStream
    .format("cloudFiles")
    .option("cloudFiles.format", "json")
    .option("cloudFiles.schemaEvolutionMode", "rescue")
    .option("rescuedDataColumn", "_rescued_data")
    .load("/path/to/source")
    .writeStream
    .option("checkpointLocation", "/path/to/checkpoint")
    .toTable("target_table")
)
```

Data that doesn't match the schema—including new columns, type mismatches, and case differences—is stored in the `_rescued_data` column. Your pipeline continues processing without interruption, and you can analyze rescued data to understand schema changes.

## Implement error handling strategies

Beyond automatic schema management, you need strategies for handling records that violate your data quality rules. Lakeflow Spark Declarative Pipelines provides expectations that let you define constraints and specify how to handle violations.

### Drop invalid records

Use expectations to filter out records that don't meet your structure requirements:

```python
import databricks.sdk.pipelines as dp

@dp.table
@dp.expect_or_drop("required_columns_present", 
    "customer_id IS NOT NULL AND email IS NOT NULL")
def validated_customers():
    return spark.readStream.table("raw_customers")
```

Records missing required columns are dropped before reaching the target table. The pipeline tracks metrics showing how many records were dropped.

### Fail on critical violations

When data structure issues indicate a serious problem, configure expectations to halt processing:

```sql
CREATE OR REFRESH STREAMING TABLE validated_orders (
    CONSTRAINT valid_structure 
    EXPECT (order_id IS NOT NULL AND product_id IS NOT NULL) 
    ON VIOLATION FAIL UPDATE
) AS SELECT * FROM STREAM(raw_orders);
```

The pipeline stops immediately when it encounters records missing required columns, preventing invalid data from propagating downstream.

### Quarantine problematic records

For a balanced approach, route invalid records to a separate quarantine table while allowing valid records to proceed:

```python
import databricks.sdk.pipelines as dp

@dp.table
def valid_transactions():
    return (
        spark.readStream.table("raw_transactions")
        .filter("amount IS NOT NULL AND transaction_date IS NOT NULL")
    )

@dp.table
def quarantine_transactions():
    return (
        spark.readStream.table("raw_transactions")
        .filter("amount IS NULL OR transaction_date IS NULL")
    )
```

This pattern lets you investigate problematic records without blocking your main data flow.

## Apply best practices for schema management

Managing schema effectively requires a combination of technical controls and operational practices.

Document your expected schemas explicitly. Store schema definitions in version control alongside your pipeline code. When source systems change, you have a clear reference for understanding the impact.

Implement alerting for schema drift. Configure your pipelines to send notifications when schema changes are detected, even if the pipeline handles them automatically. Early awareness helps you understand evolving data patterns.

Use consistent naming conventions. Standardize column names across your data estate to reduce case-sensitivity issues and make schema validation more predictable.

Test schema handling in development. Before deploying pipelines to production, verify that your schema enforcement and drift handling work as expected with test data that includes edge cases.

Consider the tradeoffs between strictness and flexibility. Strict schema enforcement catches problems early but requires more maintenance. Flexible approaches like schema evolution reduce operational overhead but might allow unexpected changes.

With these strategies in place, your data pipelines can maintain data quality while adapting to the inevitable changes in your source systems.
