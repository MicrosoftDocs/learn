Views are reusable, but they're limited to read-only `SELECT` statements. Choose stored procedures when you need to write data and want that logic to be repeatable and parameterized.

## What stored procedures provide

A stored procedure is a named block of T-SQL that you save in the warehouse and execute on demand. Stored procedures offer several capabilities that go beyond what views provide:

- **Write operations**: Stored procedures can contain `INSERT`, `UPDATE`, `DELETE`, and `CREATE TABLE` statements, so they can materialize transformation results into tables.
- **Parameters**: You can pass values into a stored procedure to make it flexible. For example, a procedure that refreshes monthly data can accept a year and month as parameters, letting you refresh a specific period without changing the code.
- **Multi-step logic**: A single procedure can contain multiple statements that run sequentially, letting you orchestrate complex transformations in a controlled order. You can delete old data, insert new data, and update metadata all within one procedure.
- **Error handling**: Stored procedures support `TRY...CATCH` blocks, so you can handle errors gracefully and log issues without aborting the entire transformation process.

## Create a stored procedure

You create a stored procedure with the `CREATE PROCEDURE` statement. The following example creates a procedure that refreshes a monthly sales summary table for a specific period:

```sql
CREATE PROCEDURE gold.usp_refresh_monthly_sales
    @year INT,
    @month INT
AS
BEGIN
    -- Remove existing data for the target period
    DELETE FROM gold.monthly_sales
    WHERE fiscal_year = @year AND fiscal_month = @month;

    -- Insert fresh aggregated data
    INSERT INTO gold.monthly_sales
        (fiscal_year, fiscal_month, category, total_sales, transaction_count)
    SELECT
        d.fiscal_year,
        d.fiscal_month,
        p.category,
        SUM(f.sales_amount),
        COUNT(*)
    FROM fact.sales AS f
    INNER JOIN dim.date AS d
        ON f.date_key = d.date_key
    INNER JOIN dim.product AS p
        ON f.product_key = p.product_key
    WHERE d.fiscal_year = @year AND d.fiscal_month = @month
    GROUP BY d.fiscal_year, d.fiscal_month, p.category;
END;
```

To run the procedure, use the `EXEC` statement with parameter values:

```sql
EXEC gold.usp_refresh_monthly_sales @year = 2024, @month = 6;
```

Each time you execute this procedure, it deletes the existing rows for the specified month and replaces them with freshly aggregated data. The parameters let you target a specific period without modifying the procedure itself.

> [!TIP]
> Use a naming convention like `usp_` (user stored procedure) to distinguish your custom procedures from system procedures. This process makes it easier to identify and manage your transformation logic in the Explorer pane.

## Choose a loading pattern

Depending on your data volume and refresh requirements, choose from these common patterns:

| Pattern | Description | When to use |
|---|---|---|
| **Full refresh** | Delete all rows and reload the entire table | Small tables or when source data changes unpredictably |
| **Incremental load** | Process only new or changed data since the last run | Large tables where most data doesn't change between refreshes |
| **Merge (upsert)** | Insert new rows and update existing ones in a single operation | Dimension tables that need to stay current with source changes |

The **full refresh** pattern is the simplest: delete everything and reload. It works well for small to medium tables where the cost of a complete reload is acceptable.

The **incremental load** pattern is more efficient for large tables. It typically relies on a watermark column (like a `modified_date` or row version) to identify rows that changed since the last run.

The **merge** pattern uses a `MERGE` statement to handle inserts and updates together in a single atomic operation:

```sql
CREATE PROCEDURE staging.usp_merge_customers
AS
BEGIN
    MERGE dim.customer AS target
    USING staging.customers AS source
        ON target.customer_id = source.customer_id
    WHEN MATCHED THEN
        UPDATE SET
            target.customer_name = source.customer_name,
            target.segment = source.segment,
            target.region = source.region
    WHEN NOT MATCHED THEN
        INSERT (customer_id, customer_name, segment, region)
        VALUES (source.customer_id, source.customer_name,
                source.segment, source.region);
END;
```

This pattern is especially useful for dimension tables because a single execution handles both new records and updates to existing ones.

## Run stored procedures from pipelines

You don't have to run stored procedures manually every time new data arrives. Data Factory pipelines in Fabric can call stored procedures as activities in an automated data flow. This approach lets you schedule stored procedure execution. For example, you can run a nightly refresh after new data lands in the staging tables, or trigger a cascade of procedures that refresh tables in dependency order.

> [!NOTE]
> A later module on data pipelines covers pipeline orchestration of stored procedures in more detail.

By combining the techniques in this unit, you can build a complete transformation layer: stored procedures that read from staging tables, apply business logic, and write the results into clean, structured tables. In the next unit, you apply these patterns specifically to dimensional tables. Fact and dimension tables form the foundation of your analytical model.
