You understand the medallion pattern — now let's make it concrete in Fabric. Three decisions shape your implementation: how your lakehouse is structured, which tools move data through each layer, and how the gold layer gets served to consumers.

## Structure your lakehouse

You can use a single lakehouse for all three layers, or give each layer its own lakehouse — or even its own workspace. The tradeoff is simplicity vs. isolation.

| Option | Best for |
| --- | --- |
| Single lakehouse with schemas | Simpler to manage; good for smaller teams or early-stage projects |
| Separate lakehouses | Clearer separation; apply different permissions per layer |
| Separate workspaces | Strongest isolation; required for regulatory or compliance scenarios |

Within a lakehouse, **schemas** help you stay organized. Schemas are enabled by default when you create a lakehouse in Fabric. Creating schemas named `bronze`, `silver`, and `gold` keeps tables grouped by layer, makes them easier to discover, and lets you set different access permissions per layer — without the overhead of managing separate lakehouses.

:::image type="content" source="../media/lakehouse-schemas.png" alt-text="Screenshot of a Fabric lakehouse showing bronze, silver, and gold schemas in the Tables section of the lakehouse explorer." lightbox="../media/lakehouse-schemas.png":::
## The bronze layer

The bronze layer is your raw data landing zone. Data arrives here exactly as it came from the source — no changes, no cleanup. This is intentional: if a transformation goes wrong downstream, you can always reprocess from bronze rather than going back to the source system.

How you get data into bronze depends on where it lives. If your source is already in cloud storage — OneLake, Azure Data Lake Storage Gen2, Amazon S3, or Google Cloud Storage — use a OneLake shortcut to reference it in place without copying. Shortcuts keep your bronze layer in sync with the source automatically, with no pipeline or ingestion code. For other sources, use pipelines, dataflows, or notebooks to load data into the bronze layer.

## The silver layer

The silver layer is where data gets cleaned and integrated. Transformations here focus on quality and consistency — standardizing formats, removing nulls, deduplicating records, and joining data from multiple bronze sources into a unified dataset. The goal is a reliable, integrated dataset that analysts and data scientists can use directly.

Fabric gives you three ways to do this:

**Dataflows (Gen2)** are a low-code option. They work well for straightforward transformations — filtering, renaming columns, changing data types — without writing code.

**Notebooks** give you full control using Python or SQL. They're the right choice for large datasets, complex logic, or anything a dataflow can't handle — custom calculations, API calls, or complex joins.

**Materialized lake views** let you define a transformation in SQL. You write a query that describes what your silver table should look like, and Fabric creates and saves the table for you.

For example, this view creates a clean `sales` table in the silver layer by selecting from bronze, standardizing formats, and filtering out rows with a missing order ID:

```sql
CREATE MATERIALIZED LAKE VIEW silver.sales
AS
SELECT
    order_id,
    customer_id,
    UPPER(TRIM(region))        AS region,
    CAST(order_date AS DATE)   AS order_date,
    unit_price * quantity      AS total_amount
FROM bronze.sales
WHERE order_id IS NOT NULL
```

The key difference from a regular SQL view: a regular view reruns its query every time someone queries it. A materialized lake view saves the results as a real table. When new data arrives in bronze, Fabric updates only the rows that changed — it doesn't reprocess the whole table. The table stays current automatically; you don't have to schedule or trigger anything. This works because all Fabric tables are stored in Delta format, which tracks every change as it happens. When new rows arrive in bronze, Fabric checks that log and updates only the new rows in silver.

The tradeoff: your transformation has to be expressible as SQL. If you need Python logic, use a notebook instead.

## The gold layer

The gold layer is where data is shaped for business consumption. A common pattern is to model it as a **star schema** — fact tables surrounded by dimension tables, aggregated to the granularity needed for reporting. But the shape depends on who's consuming it: a data science team might want a flat, wide table optimized for feature engineering, while a finance team might want pre-aggregated summaries. You can have multiple gold layers serving different audiences — same silver data underneath, each gold layer modeled differently for each team's needs.

You build the gold layer using the same tools as silver: dataflows, notebooks, or materialized lake views, coordinated by pipelines.

Consumers access the gold layer through the **SQL analytics endpoint** (direct T-SQL queries over the Delta tables) or a **Power BI semantic model** (a business-friendly layer with pre-defined measures and terminology). If your team primarily works in SQL, a **Fabric Data Warehouse** can serve as the gold layer instead of a lakehouse.
