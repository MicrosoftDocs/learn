You chose how data flows into your semantic model. Now design the star schema that organizes it for clear, performant queries. A star schema connects fact tables to dimension tables through relationships, creating the filter paths that reports and AI consumption depend on. If you're familiar with building star schema in Power BI Desktop, this unit focuses on the relationship design decisions that matter as models grow in complexity and scale.

## Star schema in a semantic model

In a star schema, fact tables store measurable business events (such as sales transactions, order lines, and web visits), and dimension tables provide the descriptive context (such as product details, customer information, and date attributes). Dimension tables filter fact tables through relationships, which allows users to slice metrics by any descriptive attribute.

:::image type="content" source="../media/model-frameworks-star-schema-design.png" alt-text="Diagram showing a fact table in the center and multiple dimension tables connected by relationships organized in a star-like shape.":::

In a Fabric semantic model, this pattern provides clean filter propagation for both reports and AI consumption. When Copilot or a data agent generates a natural language query, a well-organized star schema gives the AI clear paths to the right data. Ambiguous or circular relationships confuse both report consumers and AI tools.

## How storage mode affects relationships

Relationships in a semantic model behave differently depending on the storage mode. Understanding these differences is essential for designing star schema that performs well across different scenarios.

### Direct Lake relationships

In Direct Lake mode, the engine reads relationships directly from the Delta table metadata. Relationships perform best when:

- Dimension key columns have low cardinality relative to fact table rows.
- Referential integrity is maintained in the source data. When referential integrity holds, the engine uses INNER joins instead of LEFT OUTER joins, which improves query performance.
- Columns used in relationships are indexed in the underlying Delta tables.

> [!NOTE]
> If a query involves a relationship that causes the model to exceed memory limits or use unsupported operations, Direct Lake falls back to DirectQuery, and the relationship behavior changes to match DirectQuery semantics.

### Cross-source relationships

Fabric semantic models can connect tables from different data stores. A fact table from a lakehouse can have a relationship to a dimension table from a warehouse, or to a table accessed through a SQL analytics endpoint. These cross-source connections use composite model capabilities.

When tables come from different sources, the storage mode for each table determines how the relationship works at query time. The engine resolves each side independently and joins the results.

## Relationship types

### One-to-many relationships

One-to-many is the most common relationship type in a star schema. One unique value in a dimension table relates to many rows in a fact table. For example, one product row in the Product dimension matches thousands of order rows in the Sales fact table.

Configure one-to-many relationships with the filter direction flowing from the dimension (the "one" side) to the fact table (the "many" side). This is the standard star schema filter pattern.

### Many-to-many relationships

Many-to-many relationships are required when neither table has unique values for the relationship column. Use a bridge table to resolve these relationships. A bridge table sits between two tables and holds unique combinations of the keys from each side.

For example, if a customer can have multiple accounts and an account can belong to multiple customers, a Customer-Account bridge table resolves the relationship. The bridge table has one-to-many relationships to both the Customer and Account tables.

### Filter direction

In most star schema implementations, use single-direction filtering from dimension to fact. This provides predictable filter propagation and avoids ambiguity in query results.

Bi-directional filtering is sometimes necessary for many-to-many relationships or when dimension tables need to be filtered by values in the fact table. Use bi-directional filters sparingly because they can degrade query performance and create unexpected filter behavior in reports.

### Referential integrity

The **Assume referential integrity** setting tells the engine to use INNER joins rather than LEFT OUTER joins when querying across a relationship. In Direct Lake and DirectQuery modes, this setting can significantly improve performance because it reduces the number of rows the engine processes.

Enable this setting when you're confident that every foreign key value in the fact table has a matching value in the dimension table. If referential integrity is violated, rows with unmatched keys silently disappear from query results.

## Inactive relationships and USERELATIONSHIP

Only one active relationship can exist between two tables at a time. When you need multiple relationship paths (such as an order date and a ship date both relating to the same Date dimension), make one relationship active and the others inactive.

Use the `USERELATIONSHIP` function in DAX to activate an inactive relationship within a calculation:

```dax
Shipped Amount =
CALCULATE(
    SUM(Sales[Amount]),
    USERELATIONSHIP(Sales[ShipDate], 'Date'[Date])
)
```

This pattern keeps the model clean while supporting multiple analytical perspectives on the same data.

## Handle snowflake schema in semantic models

Source data often arrives in a normalized snowflake schema, where dimension tables are split into multiple related tables. For example, a Product dimension might be separated into Product, Subcategory, and Category tables, each linked through foreign keys.

In a semantic model, you have two options: flatten the snowflake into a star schema, or preserve the normalized structure.

### Flatten into star schema

Flattening means combining the normalized dimension tables into a single denormalized dimension table. The Product table would include Subcategory and Category columns directly, eliminating the extra tables and relationships.

Flatten when:

- The combined dimension table is still small relative to the fact table (which is almost always the case for dimensions).
- You want simpler filter paths from dimension to fact. Each filter travels through one relationship instead of a chain.
- AI consumption is a priority. Fewer tables and simpler relationships give Copilot and data agents clearer paths to the right data.

Flatten dimension tables during data preparation in lakehouses or dataflows, before the data reaches the semantic model. Use Power Query merges, SQL joins, or notebook transformations to combine the normalized tables into a single dimension.

### Preserve the snowflake structure

In some cases, keeping the normalized structure makes sense:

- The dimension hierarchy has multiple levels, and flattening would create dozens of redundant columns.
- Multiple fact tables share subdimension tables (such as a shared Category table used by both Sales and Inventory facts), and denormalization would create inconsistent copies.
- Row-level security needs to be applied at a specific level in the hierarchy.

When you preserve a snowflake structure, configure the relationships carefully. Each relationship in the chain must use single-direction filtering from the outermost table toward the fact table so that filters propagate correctly. A filter on Category needs to flow through Subcategory, then through Product, and into the fact table.

> [!NOTE]
> In most semantic model scenarios, flattening dimensions into a star schema is the better choice. Fewer tables mean fewer relationships, simpler DAX, faster queries, and better AI consumption. Preserve the snowflake structure only when there's a strong reason to keep it.

## When to use composite models for cross-source scenarios

Use composite models when your star schema spans multiple Fabric data stores or includes external sources. Common scenarios include:

- Fact tables in a lakehouse with dimension tables maintained in a warehouse.
- Real-time streaming data from an eventhouse combined with historical data in a lakehouse.
- Reference data from an external source (Import) combined with Fabric-native fact tables (Direct Lake).

In these scenarios, configure the storage mode for each table independently and verify that cross-source relationships perform acceptably at your expected data volumes.
