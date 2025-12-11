Production data pipelines require reliability, maintainability, and clear data quality enforcement. As a data engineer, you likely spend significant time writing code to handle incremental processing, orchestrate dependencies, and validate data quality. **Lakeflow Declarative Pipelines** in Azure Databricks addresses these challenges by letting you define *what* your data should look like rather than *how* to process it step by step.

In this unit, you learn how to create data pipelines using the declarative approach, define streaming tables and materialized views, and apply data quality expectations to enforce constraints on your data.

## Understand the declarative approach

Traditional data pipelines require you to write imperative code that specifies every processing step. You handle incremental processing logic, manage checkpoint recovery, and orchestrate dependencies between tables. With Lakeflow Declarative Pipelines, you instead declare the **desired end state**, and the framework handles the execution details.

The declarative approach provides three key benefits for production pipelines:

- **Automatic orchestration**: The framework analyzes dependencies between your tables and determines the correct execution order. If you define a silver table that reads from a bronze table, the framework automatically processes the bronze table first.

- **Incremental processing**: Streaming tables process each record exactly once. Materialized views automatically identify and process only changed data when possible, avoiding expensive full recomputations.

- **Built-in retry logic**: When failures occur, the framework retries at the most granular level possible—first at the Spark task level, then at the flow level, and finally at the pipeline level.

Consider a scenario where you build an analytics pipeline for customer transactions. Instead of writing hundreds of lines of Structured Streaming code with checkpoint management and state handling, you declare your tables and let the framework manage the complexity.

## Define streaming tables for data ingestion

A **streaming table** is a Delta table optimized for append-only data processing. Each input record is processed **exactly once**, making streaming tables ideal for ingesting data from sources like cloud storage or message queues.

The following SQL example creates a streaming table that ingests JSON files from cloud storage using Auto Loader:

```sql
CREATE OR REFRESH STREAMING TABLE customers_bronze
AS SELECT * FROM STREAM read_files(
  "/Volumes/raw_data/customers",
  format => "json"
);
```

The `STREAM` keyword tells the pipeline to treat the source as a **streaming dataset**. On each pipeline update, only new files are processed and appended to the table.

You can achieve the same result with Python:

```python
from pyspark import pipelines as dp

@dp.table
def customers_bronze():
  return (
    spark.readStream.format("cloudFiles")
     .option("cloudFiles.format", "json")
     .option("cloudFiles.inferColumnTypes", "true")
     .load("/Volumes/raw_data/customers")
  )
```

The `@dp.table` decorator marks this function as a streaming table definition. The function returns a streaming DataFrame, which the framework processes incrementally with each update.

## Create materialized views for transformations

While streaming tables handle append-only ingestion, **materialized views** are better suited for transformations where you need to reason about aggregations or join dimensions that might change. A materialized view caches query results and automatically keeps them **synchronized with upstream changes**.

The following example creates a materialized view that joins customer and transaction data:

```sql
CREATE OR REPLACE MATERIALIZED VIEW customer_transactions
AS SELECT 
  c.customer_id,
  c.customer_name,
  c.region,
  t.transaction_date,
  t.amount
FROM customers c
INNER JOIN transactions t ON c.customer_id = t.customer_id;
```

Unlike streaming tables, materialized views handle complex queries including aggregations and joins. When upstream tables change, the framework determines the most efficient way to update the materialized view—often processing only the affected data rather than recomputing everything.

In Python, you use the `@dp.materialized_view` decorator:

```python
from pyspark import pipelines as dp

@dp.materialized_view
def regional_sales():
  customers_df = spark.read.table("customers")
  transactions_df = spark.read.table("transactions")
  
  return (
    customers_df.join(transactions_df, on="customer_id", how="inner")
    .groupBy("region")
    .agg({"amount": "sum"})
  )
```

> [!TIP]
> Use streaming tables when your source data is append-only and you need low-latency processing. Use materialized views when you need aggregations, complex joins, or must handle updates and deletes in source data.

## Apply data quality expectations

Production pipelines require data quality enforcement. **Expectations** are declarative constraints that validate records as they flow through your pipeline. You define what valid data looks like, and the framework tracks metrics and takes action when violations occur.

When a record fails validation, the framework can respond in different ways depending on the action you specify:

| Action | Behavior |
|--------|----------|
| `EXPECT` (default) | Retains invalid records, tracks violation counts in metrics |
| `ON VIOLATION DROP ROW` | Removes invalid records from the output |
| `ON VIOLATION FAIL UPDATE` | Stops the pipeline and rolls back the transaction |

Use `ON VIOLATION FAIL UPDATE` for critical constraints where any violation indicates a serious data problem that requires investigation before processing can continue.

> [!IMPORTANT]
> The Lakeflow Spark Declarative Pipelines **Advanced** product edition is required to use expectations. If your pipeline includes expectations with the Core or Pro editions, you receive an error.

## Develop pipelines with the Lakeflow Pipelines Editor

The Lakeflow Pipelines Editor provides an integrated development environment for creating and testing pipelines. When you create a new ETL pipeline in Azure Databricks, the editor provides a default folder structure with separate directories for transformation source code, exploratory notebooks, and utility modules.

> [!NOTE]
> The code examples in this unit are **pipeline definitions**, not interactive notebook code. You cannot run these statements directly in a regular notebook. The `pyspark.pipelines` module and streaming table DDL statements are only available within the Lakeflow pipeline runtime. To execute your pipeline code, use the **Dry run** feature to validate, then **run the pipeline** through the Jobs & Pipelines interface.

:::image type="content" source="../media/7-lakeflow-pipeline-editor.png" alt-text="Screenshot of Azure Databricks Lakeflow Pipelines Editor." lightbox="../media/7-lakeflow-pipeline-editor.png":::

The editor supports iterative development through several features:

- **Dry run**: Validates your pipeline code without processing data, allowing you to catch syntax errors and missing dependencies before execution.

- **Selective execution**: Run individual files or single table definitions rather than the entire pipeline, enabling faster iteration during development.

- **Interactive DAG**: Visualize the dependency graph between your tables, select multiple tables for targeted refreshes, and inspect execution metrics.

- **Data preview**: Sample data from streaming tables and materialized views directly in the editor to verify transformation logic.

With the declarative approach and integrated tooling, you build production-grade data pipelines that are maintainable, observable, and enforce consistent data quality. The framework handles the complexity of incremental processing and orchestration, so you can focus on defining the business logic that matters to your organization.
