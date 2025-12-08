Reshaping data structure is a key part of building effective analytics solutions. **Denormalization**, **pivoting**, and **unpivoting** are transformation techniques that help you reorganize data between normalized and aggregated formats—each serving different analytical and modeling needs.

In this unit, you learn how to flatten normalized tables for faster queries, rotate rows into columns for cross-tabular analysis, and reverse that process when you need to normalize wide datasets.

## Understand denormalization

Normalized databases reduce data redundancy by splitting information across multiple related tables. While this design works well for transactional systems, it creates challenges for analytics. Queries must join many tables, which slows performance and increases complexity.

Denormalization addresses these challenges by flattening related tables into fewer, wider tables. You combine data from dimension tables directly into fact tables, eliminating the need for joins at query time.

![Diagram explaining what denormalization is.](../media/7-understand-flatten.png)

Consider a sales database with separate tables for orders, customers, and products. A normalized query requires multiple joins:

```sql
-- Normalized query with multiple joins
SELECT o.order_id,
       o.order_date,
       c.customer_name,
       c.region,
       p.product_name,
       p.category,
       o.quantity,
       o.total_price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;
```

A denormalized table stores this information together:

```sql
-- Create a denormalized orders table
CREATE OR REPLACE TABLE sales.orders_denormalized AS
SELECT o.order_id,
       o.order_date,
       c.customer_name,
       c.region,
       p.product_name,
       p.category,
       o.quantity,
       o.total_price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;
```

Queries against the denormalized table run faster because no joins are required. This approach is common when building star schemas and data marts for business intelligence tools. The tradeoff is increased storage and the need to refresh denormalized tables when source data changes.

> [!TIP]
> Denormalize data in your gold layer tables when query performance matters more than storage efficiency. Keep normalized structures in bronze and silver layers for flexibility.

## Pivot rows into columns

Pivoting transforms unique values from a column into separate columns, converting a "long" table format into a "wide" one. This transformation is particularly useful when preparing data for cross-tabular reports or dashboards.

![Diagram explaining what pivoting (rows to columns) is.](../media/7-pivot-rows-into-columns.png)

The `PIVOT` clause requires an aggregate function because multiple source rows might map to the same cell in the pivoted result. You specify which column values become new column names using the `FOR` and `IN` clauses.

Consider quarterly sales data stored in a long format:

```sql
-- Create sample sales data
CREATE OR REPLACE TEMP VIEW quarterly_sales(year, quarter, region, revenue) AS
VALUES (2024, 1, 'East', 150000),
       (2024, 2, 'East', 175000),
       (2024, 3, 'East', 160000),
       (2024, 4, 'East', 200000),
       (2024, 1, 'West', 180000),
       (2024, 2, 'West', 165000),
       (2024, 3, 'West', 190000),
       (2024, 4, 'West', 210000),
       (2025, 1, 'East', 165000),
       (2025, 2, 'East', 185000);

-- View data in long format
SELECT * FROM quarterly_sales;
```

This query returns revenue as separate rows for each quarter. To compare quarters side by side, pivot the data:

```sql
-- Pivot quarters into columns
SELECT year, region, Q1, Q2, Q3, Q4
FROM quarterly_sales
PIVOT (
  SUM(revenue)
  FOR quarter IN (1 AS Q1, 2 AS Q2, 3 AS Q3, 4 AS Q4)
);
```

The result shows each region's quarterly revenue as columns, making year-over-year comparisons straightforward:

| year | region | Q1     | Q2     | Q3     | Q4     |
|------|--------|--------|--------|--------|--------|
| 2024 | East   | 150000 | 175000 | 160000 | 200000 |
| 2024 | West   | 180000 | 165000 | 190000 | 210000 |
| 2025 | East   | 165000 | 185000 | null   | null   |

You can apply multiple aggregate functions in a single pivot operation:

```sql
-- Pivot with multiple aggregations
SELECT year, Q1_total, Q1_avg, Q2_total, Q2_avg
FROM (SELECT year, quarter, revenue FROM quarterly_sales)
PIVOT (
  SUM(revenue) AS total,
  AVG(revenue) AS avg
  FOR quarter IN (1 AS Q1, 2 AS Q2)
);
```

This creates columns for both the sum and average of each quarter's revenue.

## Unpivot columns into rows

Unpivoting performs the reverse transformation—it converts columns back into rows. Use unpivoting when you receive wide-format data that needs normalization for analysis or when preparing data for systems that expect a long format.

![Diagram explaing the process of unpivoting coluns into rows.](../media/7-pivot-rows-into-columns.png)

The `UNPIVOT` clause transforms specified columns into value-name pairs. You define a column to hold the values and another to hold the original column names.

```sql
-- Create wide-format data
CREATE OR REPLACE TEMP VIEW regional_targets(region, jan, feb, mar, apr) AS
VALUES ('North', 50000, 55000, 52000, 58000),
       ('South', 45000, 48000, 51000, 53000),
       ('East',  60000, 62000, 65000, 68000);

-- Unpivot monthly columns into rows
SELECT *
FROM regional_targets
UNPIVOT (
  target_amount FOR month IN (jan, feb, mar, apr)
);
```

The result converts each month column into rows:

| region | month | target_amount |
|--------|-------|---------------|
| North  | jan   | 50000         |
| North  | feb   | 55000         |
| North  | mar   | 52000         |
| North  | apr   | 58000         |
| South  | jan   | 45000         |
| ...    | ...   | ...           |

By default, `UNPIVOT` excludes null values. To include them, specify `INCLUDE NULLS`:

```sql
-- Unpivot while keeping null values
SELECT *
FROM regional_targets
UNPIVOT INCLUDE NULLS (
  target_amount FOR month IN (jan, feb, mar, apr)
);
```

You can also assign custom aliases to the unpivoted column names:

```sql
-- Unpivot with custom month labels
SELECT *
FROM regional_targets
UNPIVOT (
  target_amount FOR month IN (
    jan AS 'January',
    feb AS 'February',
    mar AS 'March',
    apr AS 'April'
  )
);
```

> [!NOTE]
> The `UNPIVOT` clause requires Databricks Runtime 12.2 LTS or later.

## Choose the right transformation

Each transformation serves specific analytical needs. Use denormalization when you need fast query performance for dashboards and reports. Choose pivot when analysts need side-by-side comparisons across categories. Apply unpivot when you need to normalize wide data for aggregation or machine learning pipelines.

These transformations often work together in data pipelines. You might unpivot source data to standardize its format, apply transformations, and then pivot results for final presentation—or denormalize the output into optimized tables for downstream consumers.
