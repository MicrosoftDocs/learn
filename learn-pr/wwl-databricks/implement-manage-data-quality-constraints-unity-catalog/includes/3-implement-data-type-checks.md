Every column in your dataset has an expected data type, and when incoming data doesn't match that expectation, problems cascade downstream. A string value where an integer belongs can break calculations, corrupt aggregations, or cause pipeline failures. Data type checks ensure that each field contains values of the correct type before they enter your tables.

In this unit, you learn how to implement data type checks using schema enforcement, explicit type casting, and validation constraints in Azure Databricks.

## Understand schema enforcement

Delta Lake validates data types automatically when you write data to a table. This built-in mechanism, called **schema enforcement**, compares the data types of incoming columns against the target table's schema. When a type mismatch occurs, Delta Lake attempts to safely cast the value. If the cast fails, the write operation raises an error.

Schema enforcement applies the following rules during insert operations:

- All inserted columns must exist in the target table
- All column data types must match or be safely castable to the target types

Consider a table with an integer column:

```sql
CREATE TABLE inventory (
    product_id INT,
    quantity INT,
    last_updated DATE
);
```

When you insert data where `quantity` is a string that represents a number, Delta Lake casts it to the target type:

```sql
-- This succeeds because '100' can be cast to INT
INSERT INTO inventory VALUES (1, '100', '2026-01-15');
```

However, inserting a string that can't be converted to an integer causes the operation to fail:

```sql
-- This fails because 'fifty' cannot be cast to INT
INSERT INTO inventory VALUES (2, 'fifty', '2026-01-15');
```

Schema enforcement provides a first line of defense against type mismatches. For more control over how mismatches are handled, you can use explicit casting.

## Use explicit type casting

The `cast` function converts values from one data type to another. When the conversion fails, an error is raised. The `try_cast` function works the same way but returns `NULL` instead of raising an error when the conversion fails.

Use `cast` when you want strict validation that stops processing on invalid data:

```sql
SELECT 
    cast(raw_amount AS DECIMAL(10,2)) AS amount,
    cast(raw_date AS DATE) AS transaction_date
FROM staging_data;
```

Use `try_cast` when you want to identify invalid values without failing the query:

```sql
SELECT 
    raw_amount,
    try_cast(raw_amount AS DECIMAL(10,2)) AS validated_amount,
    CASE 
        WHEN try_cast(raw_amount AS DECIMAL(10,2)) IS NULL 
        THEN 'Invalid amount format'
        ELSE 'Valid'
    END AS validation_status
FROM staging_data;
```

With `try_cast`, records with invalid values return `NULL` for the cast column. You can then filter, flag, or quarantine these records based on your data quality requirements.

## Implement type validation with constraints

**CHECK constraints** let you define custom validation rules that are enforced whenever data is inserted or updated. While typically used for value ranges and patterns, you can combine them with type-aware functions to create sophisticated type checks.

For example, you can validate that a string column contains only numeric characters:

```sql
CREATE TABLE orders (
    order_id INT,
    order_total STRING,
    CONSTRAINT valid_order_total CHECK (order_total REGEXP '^[0-9]+(\\.[0-9]+)?$')
);
```

This constraint ensures the `order_total` column contains values that look like valid numbers, catching malformed data before it enters the table.

For date validation, you can use the `try_cast` function within a constraint:

```sql
ALTER TABLE events 
ADD CONSTRAINT valid_event_date CHECK (try_cast(event_date_str AS DATE) IS NOT NULL);
```

This approach rejects records where `event_date_str` doesn't contain a valid date format.

> [!IMPORTANT]
> Before adding a constraint to an existing table, Azure Databricks verifies that all existing rows satisfy the constraint. Plan for this validation step, especially on large tables.

## Handle type mismatches in pipelines

When processing data from external sources, type mismatches are common. Implement a pattern that separates valid from invalid records, allowing you to process good data while quarantining problematic records for review:

```sql
-- Insert valid records into the target table
INSERT INTO silver_transactions
SELECT 
    transaction_id,
    cast(amount AS DECIMAL(10,2)) AS amount,
    cast(transaction_date AS DATE) AS transaction_date
FROM bronze_transactions
WHERE try_cast(amount AS DECIMAL(10,2)) IS NOT NULL
  AND try_cast(transaction_date AS DATE) IS NOT NULL;

-- Capture invalid records for investigation
INSERT INTO quarantine_transactions
SELECT 
    transaction_id,
    amount AS raw_amount,
    transaction_date AS raw_date,
    current_timestamp() AS quarantined_at,
    'Type validation failed' AS reason
FROM bronze_transactions
WHERE try_cast(amount AS DECIMAL(10,2)) IS NULL
   OR try_cast(transaction_date AS DATE) IS NULL;
```

This pattern ensures your pipeline continues processing valid data while preserving invalid records for later analysis.

## Use pipeline expectations for type checking

Lakeflow Spark Declarative Pipelines provides **expectations** that allow you to define data quality rules directly in your pipeline definitions. You can use expectations to check that values can be cast to expected types:

```python
from pyspark import pipelines as dp

@dp.table
@dp.expect_or_drop("valid_amount", "try_cast(amount AS DECIMAL(10,2)) IS NOT NULL")
@dp.expect_or_drop("valid_date", "try_cast(event_date AS DATE) IS NOT NULL")
def validated_transactions():
    return spark.readStream.table("raw_transactions")
```

With `expect_or_drop`, records that fail the type check are dropped before reaching the target table. Use `expect` to log violations without dropping records, or `expect_or_fail` to stop the pipeline when violations occur.

For SQL-based pipelines:

```sql
CREATE OR REFRESH STREAMING TABLE validated_transactions (
    CONSTRAINT valid_amount EXPECT (try_cast(amount AS DECIMAL(10,2)) IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT valid_date EXPECT (try_cast(event_date AS DATE) IS NOT NULL) ON VIOLATION DROP ROW
)
AS SELECT * FROM STREAM(raw_transactions);
```

Pipeline expectations integrate data type validation directly into your ETL logic, providing visibility into data quality metrics through the pipeline UI.

Implementing data type checks at multiple levels—schema enforcement, explicit casting, constraints, and pipeline expectations—creates defense in depth. Each layer catches issues that might slip past others, resulting in higher data quality in your Unity Catalog tables.
