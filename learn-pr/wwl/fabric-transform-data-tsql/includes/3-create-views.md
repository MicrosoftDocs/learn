You can transform data with queries, but every time you need the same result, you have to rewrite or copy the query. Views solve this problem by letting you define a query once and reference it by name, similar to saving a reusable function that returns a table.

## What views provide

A view is a named `SELECT` statement stored as a database object. When you query a view, the warehouse runs the underlying query and returns the results. Views don't store data themselves, so they always reflect the current state of the source tables.

Views provide three key benefits:

- **Reusability**: Define transformation logic once and reference it from multiple queries, reports, and semantic models. When the logic changes, you update the view definition in one place.
- **Abstraction**: Hide complex joins and calculations behind a simple name. Consumers query the view without knowing the underlying table structure, which reduces errors and makes onboarding new team members faster.
- **Security**: Expose only specific columns or filtered rows to different user groups, restricting access to sensitive data without duplicating tables.

## Create views in a warehouse

You create a view with the `CREATE VIEW` statement. The following example creates a view that joins fact and dimension tables to produce a monthly sales summary:

```sql
CREATE VIEW gold.vw_monthly_sales
AS
SELECT
    d.fiscal_year,
    d.fiscal_month,
    p.category,
    SUM(f.sales_amount) AS total_sales,
    COUNT(*) AS transaction_count
FROM fact.sales AS f
INNER JOIN dim.date AS d
    ON f.date_key = d.date_key
INNER JOIN dim.product AS p
    ON f.product_key = p.product_key
GROUP BY d.fiscal_year, d.fiscal_month, p.category;
```

After creating this view, any user or tool can query it with a simple `SELECT * FROM gold.vw_monthly_sales` instead of rewriting the join and aggregation logic. If the business later changes how it calculates `total_sales`, you update the view definition and every consumer gets the updated logic automatically.

To modify an existing view, use `ALTER VIEW` with the same syntax:

```sql
ALTER VIEW gold.vw_monthly_sales
AS
SELECT
    d.fiscal_year,
    d.fiscal_month,
    p.category,
    p.subcategory,
    SUM(f.sales_amount) AS total_sales,
    COUNT(*) AS transaction_count
FROM fact.sales AS f
INNER JOIN dim.date AS d
    ON f.date_key = d.date_key
INNER JOIN dim.product AS p
    ON f.product_key = p.product_key
GROUP BY d.fiscal_year, d.fiscal_month, p.category, p.subcategory;
```

> [!NOTE]
> Fabric warehouses support custom schemas. Organize views into schemas like `gold` or `reporting` to separate them from staging and intermediate objects.

## Common view patterns

The pattern you choose for a view depends on the type of transformation it encapsulates:

| Pattern | Purpose | Example |
|---|---|---|
| **Transformation view** | Apply business rules and calculations | Convert currency, classify tiers, compute derived columns |
| **Aggregation view** | Summarize data at a specific grain | Monthly sales by region, daily order counts |
| **Denormalized view** | Flatten joins for reporting tools | Combine fact and dimension tables into a single wide result set |

You can also save a query as a view directly from the **Visual Query Editor** by selecting the **Save as view** button. This approach is useful when you want to persist a visual query for reuse without writing T-SQL.

## Choose between views and tables

Views and tables serve different purposes. The right choice depends on how the data is consumed and how frequently it changes.

| Factor | Views | Tables |
|---|---|---|
| **Data freshness** | Always current (runs the query live) | Snapshot at load time |
| **Performance** | Depends on query complexity | Already computed for faster results |
| **Storage cost** | No extra storage | Consumes storage |
| **Best for** | Simple to moderate aggregations, security filtering, abstraction | Performance-critical dashboards, large result sets, complex multi-step transforms |

If a transformation is straightforward and consumers need the latest data, a view is the right choice. If the transformation is expensive to compute, produces a large result, or queried frequently by dashboards, consider materializing the results into a table. Stored procedures, which are covered in the next unit, provide the mechanism to materialize results into tables in a repeatable, automated way.
