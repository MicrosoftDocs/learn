T-SQL is available in both Fabric warehouses and lakehouses. A warehouse provides full read-write T-SQL support — you can use `SELECT`, `INSERT`, `UPDATE`, `DELETE`, and `CREATE TABLE AS SELECT` (CTAS) statements to shape data directly. A lakehouse also exposes its Delta tables through a SQL analytics endpoint, which supports T-SQL for querying and analysis but is read-only. This module focuses on transforming data in a warehouse, where the read-write capability lets you build transformation logic that persists results.

## Query data in the warehouse

You can run T-SQL queries in a Fabric warehouse by using the **SQL query editor** within the warehouse explorer. To open it, select **New SQL query** from the ribbon. The editor supports IntelliSense, syntax highlighting, and multiple query tabs, so you can write and iterate on complex queries without leaving the browser.

You can also connect to the warehouse from external tools like SQL Server Management Studio (SSMS) or Visual Studio Code with the MSSQL extension through the T-SQL connection string. This flexibility lets your team use whichever tool they're most comfortable with.

For users who prefer a no-code experience, the **Visual Query Editor** provides a drag-and-drop interface. You drag tables from the **Explorer** pane onto a canvas, then apply Power Query operations like merges, filters, and aggregations visually. The editor generates T-SQL behind the scenes, and you can switch to **View SQL** at any time to see the resulting query. You can also save the output as a new view or table directly from the visual editor.

> [!TIP]
> The Visual Query Editor is a good option for quick data exploration or when building simple joins. For complex transformations that involve window functions, CTEs, or conditional logic, use the SQL query editor.

## Filter and shape data

The most common transformation patterns start with filtering rows and selecting columns. In a warehouse with staging data, you typically need to narrow down a dataset before performing further processing. Filtering removes irrelevant rows early, which improves both clarity and performance of downstream operations.

```sql
SELECT
    customer_id,
    order_date,
    amount
FROM staging.orders
WHERE order_date >= '2024-01-01'
    AND status = 'Completed';
```

Beyond simple filtering, you often need to reshape data by adding calculated columns. Expressions and conditional logic create new columns that encode business rules directly in the query:

```sql
SELECT
    order_id,
    quantity,
    unit_price,
    quantity * unit_price AS line_total,
    CASE
        WHEN quantity * unit_price > 1000 THEN 'High'
        ELSE 'Standard'
    END AS order_tier
FROM staging.orders;
```

Commonly, you need to decide how to handle null values before the data moves to analytical tables. Use `ISNULL` to replace a null with a default, or `COALESCE` to pick the first non-null value from a list of columns:

```sql
SELECT
    ISNULL(discount, 0) AS discount,
    COALESCE(shipping_address, billing_address) AS address
FROM staging.orders;
```

Data type conversions are another common shaping task. Source data might arrive as strings that need to be converted to dates or numbers for proper sorting and aggregation:

```sql
SELECT
    CAST(order_date_text AS DATE) AS order_date,
    CONVERT(DECIMAL(10,2), amount_text) AS amount
FROM staging.raw_orders;
```

These patterns form the building blocks for more complex transformations. Each query shapes the data one step closer to its final analytical form.

## Combine data with joins and aggregations

Real-world transformations almost always require combining data from multiple tables. Source systems normalize data across many tables, but analytical consumers need a combined view. You can use joins to bring together related datasets, and aggregations to summarize the combined data into meaningful metrics.

A basic join combines columns from two tables based on a shared key:

```sql
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.segment
FROM staging.orders AS o
INNER JOIN staging.customers AS c
    ON o.customer_id = c.customer_id;
```

To summarize data by groups, combine `GROUP BY` with aggregate functions. This pattern is the foundation of most analytical queries, which turns detailed transactions into summary metrics:

```sql
SELECT
    c.region,
    YEAR(o.order_date) AS order_year,
    COUNT(*) AS order_count,
    SUM(o.amount) AS total_sales
FROM staging.orders AS o
INNER JOIN staging.customers AS c
    ON o.customer_id = c.customer_id
GROUP BY c.region, YEAR(o.order_date);
```

Use the `HAVING` clause to filter aggregated results. Unlike `WHERE` (which filters individual rows before grouping), `HAVING` filters groups after aggregation. This distinction matters when you want to find groups that meet a threshold:

```sql
SELECT
    region,
    YEAR(order_date) AS order_year,
    SUM(amount) AS total_sales
FROM staging.orders
GROUP BY region, YEAR(order_date)
HAVING SUM(amount) > 50000;
```

## Apply window functions

Window functions perform calculations across a set of rows related to the current row without collapsing the result set. Unlike `GROUP BY`, which produces one output row per group, window functions keep every row in the result and add calculated values alongside them. This feature makes them ideal for running totals, rankings, and comparisons with prior values.

```sql
SELECT
    customer_id,
    order_date,
    amount,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS order_sequence,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS running_total,
    LAG(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_amount
FROM staging.orders;
```

In this query, `ROW_NUMBER` assigns a sequential number within each customer's orders, which is useful for identifying the first or most recent order. `SUM ... OVER` computes a cumulative running total of sales amount per customer. `LAG` retrieves the previous row's value within the partition, enabling period-over-period change calculations without self-joins.

Other useful window functions include `RANK` (which handles ties differently from `ROW_NUMBER`), `DENSE_RANK`, and `LEAD` (which looks forward instead of backward).

## Structure complex queries with CTEs

Common table expressions (CTEs) break a complex query into readable, named steps. Each CTE defines an intermediate result that the next step can reference.

```sql
WITH monthly_totals AS (
    SELECT
        YEAR(order_date) AS yr,
        MONTH(order_date) AS mo,
        SUM(amount) AS monthly_total
    FROM staging.orders
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT
    yr,
    mo,
    monthly_total,
    SUM(monthly_total) OVER (ORDER BY yr, mo) AS ytd_total
FROM monthly_totals;
```

First, the CTE aggregates orders into monthly totals and then calculates a year-to-date running total. CTEs make your queries easier to debug and maintain, especially when a transformation involves multiple logical steps. You can chain multiple CTEs together by separating them with commas, building up the transformation layer by layer.

## Persist results with CREATE TABLE AS SELECT

When you have a transformation query that produces results you want to store, use `CREATE TABLE AS SELECT` (CTAS) to create a new table and populate it in a single statement:

```sql
CREATE TABLE gold.regional_sales_summary
AS
SELECT
    c.region,
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(o.amount) AS total_sales,
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM staging.orders AS o
INNER JOIN staging.customers AS c
    ON o.customer_id = c.customer_id
GROUP BY c.region, YEAR(o.order_date), MONTH(o.order_date);
```

CTAS is useful for one-time materializations. For example, creating a summary table during an initial data load. For recurring transformations, stored procedures (covered in a later unit) provide a better mechanism because they can be parameterized and scheduled.

You now have the core query techniques for transforming data in a Fabric warehouse. Next, you see how to make these queries reusable by saving them as views.
