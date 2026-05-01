After shaping individual tables, you often need to combine data from multiple sources and calculate summary statistics. Joins bring together related tables, aggregations summarize data into meaningful metrics, and window functions compute values across related rows without collapsing the detail. These patterns form the core of most analytics transformations.

Continuing with the cleaned sales data from the previous unit, you now have 10 unique rows with consistent columns, no nulls, and calculated fields like `line_total` and `value_tier`. The following transformations combine this data with customer and product tables, then summarize it for analysis.

## Join tables

Joins combine rows from two or more tables based on a shared column. Use joins to enrich transaction data with customer details, product names, or geographic information.

# [Spark SQL](#tab/sparksql)

```sql
SELECT
    s.order_id,
    s.amount,
    c.customer_name,
    c.region
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
```

# [PySpark](#tab/pyspark)

```python
joined_df = sales_df.join(customers_df, "customer_id", "inner")
```

---

Before the join, the sales table had `customer_id` values like "C001" but no customer names. After the inner join, each row now includes the matching `customer_name` and `region` from the customers table. If a sales row had a `customer_id` that didn't exist in the customers table, an inner join would exclude it. The result might look like this:

| order_id | amount | customer_name | region |
|----------|--------|---------------|--------|
| 1 | 149.95 | Contoso Ltd | East |
| 3 | 199.99 | Contoso Ltd | East |
| 2 | 99.98 | Fabrikam Inc | West |
| 4 | 299.90 | Northwind Traders | North |

Spark supports the same join types you know from standard SQL:

| Join type | Returns |
|-----------|---------|
| **INNER** | Rows that match in both tables |
| **LEFT** | All rows from the left table, with matches from the right |
| **RIGHT** | All rows from the right table, with matches from the left |
| **FULL OUTER** | All rows from both tables, with nulls where no match exists |
| **CROSS** | Every combination of rows from both tables |

Choose the join type based on your data requirements. For most fact-to-dimension joins, inner or left joins are appropriate.

## Aggregate data with grouping

Aggregations collapse rows into summary values. Use `GROUP BY` to calculate totals, averages, counts, and other metrics by category. To filter aggregated results, use `HAVING` in Spark SQL or `.filter()` after aggregation in PySpark.

# [Spark SQL](#tab/sparksql)

```sql
-- Basic aggregation by region
SELECT
    region,
    COUNT(*) AS order_count,
    SUM(amount) AS total_sales,
    AVG(amount) AS avg_order_value
FROM sales
GROUP BY region

-- Filter aggregated results with HAVING
SELECT region, SUM(amount) AS total_sales
FROM sales
GROUP BY region
HAVING SUM(amount) > 10000
```

# [PySpark](#tab/pyspark)

```python
from pyspark.sql.functions import count, sum, avg, col

# Basic aggregation by region
agg_df = sales_df.groupBy("region").agg(
    count("*").alias("order_count"),
    sum("amount").alias("total_sales"),
    avg("amount").alias("avg_order_value")
)

# Filter aggregated results with .filter()
agg_df = sales_df.groupBy("region") \
    .agg(sum("amount").alias("total_sales")) \
    .filter(col("total_sales") > 10000)
```

---

The 10 detail rows are now collapsed into one row per region. A result set might look like this:

| region | order_count | total_sales | avg_order_value |
|--------|-------------|-------------|-----------------|
| East | 3 | 509.92 | 169.97 |
| West | 3 | 195.94 | 65.31 |
| North | 2 | 359.84 | 179.92 |
| South | 1 | 399.98 | 399.98 |
| Unknown | 1 | 49.99 | 49.99 |

Notice how the row count changed from 10 individual orders to 5 summary rows. Each row represents a region with its aggregated metrics.

## Apply window functions

Window functions calculate values across a set of rows related to the current row, without collapsing the data into groups. Use them for rankings, running totals, and comparisons between rows.

# [Spark SQL](#tab/sparksql)

```sql
SELECT
    customer_id,
    order_date,
    amount,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id ORDER BY order_date
    ) AS order_sequence,
    SUM(amount) OVER (
        PARTITION BY customer_id ORDER BY order_date
    ) AS running_total
FROM orders
```

# [PySpark](#tab/pyspark)

```python
from pyspark.sql.window import Window
from pyspark.sql.functions import row_number, sum

window_spec = Window.partitionBy("customer_id").orderBy("order_date")

result_df = orders_df \
    .withColumn("order_sequence", row_number().over(window_spec)) \
    .withColumn("running_total", sum("amount").over(window_spec))
```

---

Unlike aggregation, window functions keep all original rows. The result adds new columns alongside the existing detail:

| customer_id | order_date | amount | order_sequence | running_total |
|-------------|------------|--------|----------------|---------------|
| C001 | 2024-01-15 | 149.95 | 1 | 149.95 |
| C001 | 2024-02-10 | 199.99 | 2 | 349.94 |
| C001 | 2024-03-15 | 119.96 | 3 | 469.90 |
| C002 | 2024-01-20 | 99.98 | 1 | 99.98 |
| C002 | 2024-03-01 | 47.97 | 2 | 147.95 |

Each customer's orders are numbered sequentially, and the running total accumulates within each customer's partition. The original row count stays the same.

The `PARTITION BY` clause defines the group of rows for the calculation. The `ORDER BY` clause determines the sequence within each partition. Common window functions include:

- `ROW_NUMBER()` assigns a sequential number within each partition
- `RANK()` assigns rank with gaps for ties
- `LAG()` and `LEAD()` access values from previous or next rows
- `SUM()`, `AVG()`, `COUNT()` over a window calculate running or sliding aggregates

## Use common table expressions

Common table expressions (CTEs) let you break complex queries into named, readable steps. Each CTE defines a temporary result set you can reference in subsequent steps. In PySpark, you achieve the same result by chaining DataFrame operations, where each variable holds an intermediate result.

# [Spark SQL](#tab/sparksql)

```sql
WITH monthly_sales AS (
    SELECT
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        SUM(amount) AS total
    FROM sales
    GROUP BY YEAR(order_date), MONTH(order_date)
),
ranked AS (
    SELECT *,
        RANK() OVER (ORDER BY total DESC) AS sales_rank
    FROM monthly_sales
)
SELECT * FROM ranked WHERE sales_rank <= 5
```

# [PySpark](#tab/pyspark)

```python
from pyspark.sql.functions import year, month, rank

monthly_sales = sales_df.groupBy(
    year("order_date").alias("year"),
    month("order_date").alias("month")
).agg(sum("amount").alias("total"))

ranked = monthly_sales.withColumn(
    "sales_rank",
    rank().over(Window.orderBy(col("total").desc()))
)

result_df = ranked.filter(col("sales_rank") <= 5)
```

---

The CTE approach first summarizes sales by month, then ranks the months. Only the top 5 months by total sales survive the final filter. A result might look like:

| year | month | total | sales_rank |
|------|-------|-------|------------|
| 2024 | 2 | 499.89 | 1 |
| 2024 | 4 | 449.96 | 2 |
| 2024 | 3 | 217.93 | 3 |
| 2024 | 1 | 249.93 | 4 |

## Pivot data

Pivoting reshapes data from rows to columns, which is useful for creating cross-tabulation summaries. For example, you can transform quarterly sales rows into columns for side-by-side comparison. Specifying the pivot values (like `Q1` through `Q4`) improves performance because Spark doesn't need to scan the data first to discover the distinct values.

# [Spark SQL](#tab/sparksql)

```sql
SELECT * FROM (
    SELECT product, quarter, amount FROM sales
)
PIVOT (
    SUM(amount) FOR quarter IN ('Q1', 'Q2', 'Q3', 'Q4')
)
```

# [PySpark](#tab/pyspark)

```python
pivot_df = sales_df.groupBy("product") \
    .pivot("quarter", ["Q1", "Q2", "Q3", "Q4"]) \
    .sum("amount")
```

---

The pivot transforms multiple rows per product into a single row with one column per quarter:

| product | Q1 | Q2 | Q3 | Q4 |
|---------|------|------|------|------|
| Widget A | 389.87 | 89.97 | null | null |
| Widget B | 99.98 | null | null | null |
| Premium Device | 199.99 | 399.98 | null | null |

Null values appear where a product had no sales in that quarter. This format is useful for reports that compare performance across time periods side by side.

> [!TIP]
> When building complex transformations, start simple and build up. Test each step in a separate cell before combining them into a complete pipeline.

Your transformations are ready. In the next unit, you learn how to write the results to Delta tables with appropriate sizing and partitioning.
