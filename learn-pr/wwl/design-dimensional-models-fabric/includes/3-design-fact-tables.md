Fact tables form the center of a dimensional model. They capture business events and store the numeric measurements that drive analytical queries. Every time a sale occurs, an order ships, or inventory is counted, a fact table records that event along with references to the dimensions that provide context.

## Understand fact table structure

A fact table contains three types of columns:

- **Dimension keys** are foreign keys that reference related dimension tables. They determine the *dimensionality* of the facts and link each event to its context (who, what, when, where).
- **Measures** are numeric values that can be aggregated. Examples include quantity, revenue, cost, and duration.
- **Attributes** provide further detail about the event, such as order numbers or tracking codes. Attributes are sometimes called *degenerate dimensions* because they describe the event without needing a separate dimension table.

A well-designed fact table is narrow. It contains only keys, measures, and essential attributes. Descriptive information belongs in dimension tables.

:::image type="content" source="../media/fact-table-structure.svg" alt-text="Diagram showing the structure of a fact table with three column types: dimension keys in teal, measures in purple, and degenerate dimensions in orange." lightbox="../media/fact-table-structure.svg":::

## Define the grain

The most important design decision for a fact table is defining the **grain**. The grain specifies what one row in the fact table represents. For a sales fact table, the grain might be one row per sales order line item. For an inventory fact table, the grain might be one row per product per day.

Defining the grain early prevents common design errors:

- A grain that's **too high-level** loses detail you might need later. For example, if you store one row per daily sales total instead of one row per order line, you can't later break down sales by individual products or customers.
- A grain that's **too detailed** can increase storage and processing costs without providing analytical value. For example, storing one row per second for a sensor that only changes readings every hour creates unnecessary volume.

The grain also determines which dimension keys belong in the fact table. For example, if the grain of a sales fact is one row per order line, then the dimension keys should include customer, product, date, and salesperson. Each dimension key must align with the stated grain.

> [!IMPORTANT]
> Always define the grain before identifying dimensions and measures. The grain determines which dimension keys and measures belong in the table.

## Identify fact table types

There are three types of fact tables, each suited to a different analytical need:

:::image type="content" source="../media/fact-table-types.svg" alt-text="Comparison of three fact table types: transaction fact recording individual events, periodic snapshot capturing state at intervals, and accumulating snapshot tracking process milestones." lightbox="../media/fact-table-types.svg":::

### Transaction fact tables

A **transaction fact table** stores one row per business event. Each row is fully known when inserted and doesn't change (except to correct errors). Examples include individual sales order lines, website clicks, or support tickets.

Transaction fact tables typically store data at the lowest possible granularity, and their measures are additive across all dimensions.

### Periodic snapshot fact tables

A **periodic snapshot fact table** captures the state of something at regular intervals. Instead of recording individual events, it records a summary at a point in time. For example, an inventory fact table might record end-of-day stock levels for every product.

Periodic snapshots are useful for trend analysis and monitoring change over time. Their measures are typically *semi-additive*, meaning they can be summed across some dimensions but not across time.

### Accumulating snapshot fact tables

An **accumulating snapshot fact table** tracks the progress of a process through milestones. A row is created when the process begins and is updated as each milestone is reached. For example, an order fulfillment fact table might track the dates an order is placed, approved, shipped, and delivered.

These tables have multiple date dimension keys (one per milestone) and often include duration measures between milestones.

## Choose measure types

Measures fall into three categories based on how they can be aggregated:

| Type | Description | Example |
|------|-------------|---------|
| **Additive** | Can be summed across all dimensions | Revenue, quantity, cost |
| **Semi-additive** | Can be summed across some dimensions, but not all (typically not across time) | Account balance, inventory level |
| **Non-additive** | Can't be summed meaningfully across any dimension | Unit price, temperature, ratio |

> [!TIP]
> When you need a non-additive measure like a ratio, store the underlying values instead. For example, store discount amount and sales revenue rather than discount percentage so the ratio can be computed correctly at any level of aggregation.

## Apply naming conventions

In a Fabric Data Warehouse, you might prefix fact table names with `f_` or `Fact_` to identify them clearly. For example, `f_Sales` or `Fact_Inventory`. This naming convention makes it easy for analysts and tools to distinguish fact tables from dimension tables.

## Consider factless fact tables

Sometimes you need to record events that don't have any numeric measures. A **factless fact table** captures occurrences, such as a student attending a class or a promotion being applied to a product. You can still analyze these events by counting rows.

## Consider aggregate fact tables

An **aggregate fact table** stores precomputed summaries of a base fact table at a higher level of granularity or lower dimensionality. For example, you might create a monthly sales summary from a daily transaction fact table. The purpose is to accelerate commonly run queries. In Power BI, user-defined aggregations can achieve a similar result, or you can use the aggregate table directly through DirectQuery storage mode.
