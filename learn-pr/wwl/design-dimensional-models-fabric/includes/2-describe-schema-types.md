Dimensional modeling is a design technique that organizes data for analytical workloads. Unlike normalized models used in transactional systems, dimensional models prioritize query performance and user comprehension. The result is a data structure that reflects how business users think about their data and enables efficient reporting.

In Microsoft Fabric, you can implement dimensional models in both a Fabric Warehouse and a lakehouse. Understanding schema types helps you choose the right structure for your analytics requirements.

## Understand dimensional modeling

In a dimensional model, data is organized into two types of tables:

- **Fact tables** store measurements associated with business events or observations, such as sales amounts, order quantities, or temperature readings. Fact tables contain numeric values that can be aggregated.
- **Dimension tables** describe the entities relevant to your analytics requirements. They represent the *things* you model, such as products, customers, dates, or locations. Dimension tables provide the context for analyzing fact data.

This separation of measurements from descriptive context creates a structure that's intuitive for analysts and optimized for query engines.

## Compare schema types

There are several schema types you can use to arrange fact and dimension tables. Each type offers different tradeoffs between query simplicity, storage efficiency, and flexibility.

### Star schema

A star schema places a fact table at the center with dimension tables radiating outward. Each dimension table connects directly to the fact table through key relationships. The name comes from the visual appearance: a central fact table with dimension tables forming points of a star.

:::image type="content" source="../media/star-schema.svg" alt-text="Diagram that shows a star schema with a central Fact_Sales table connected to four dimension tables: Dim_Product, Dim_Customer, Dim_Date, and Dim_Store." lightbox="../media/star-schema.svg":::

Star schema is the recommended approach for most analytics workloads in Microsoft Fabric. It delivers several advantages:

- **Fewer joins** result in faster query performance. Queries typically need only one join per dimension.
- **Intuitive structure** maps to how business users think about data. Users filter and group by dimensions (who, what, when, where) and aggregate measures.
- **Foundation for semantic models** in Power BI. Star schemas are a prerequisite for enterprise semantic models and support Copilot and AI scenarios.
- **Low maintenance** as the data warehouse evolves. Adding a new attribute to a dimension or a new fact table is straightforward without restructuring existing tables.

A star schema often contains multiple fact tables, each representing a different business process. For example, a retail model might have separate stars for sales, inventory, and purchasing, all sharing common dimensions.

> [!TIP]
> Start with a star schema for most projects. Its simplicity and performance benefits outweigh the minor storage costs of denormalized dimension tables.

### Snowflake schema

A snowflake schema extends the star schema by normalizing dimension tables. Instead of storing all attributes in a single dimension table, related attributes are split into separate, related tables. For example, a product dimension might have separate tables for subcategory and category, each linked by foreign keys.

:::image type="content" source="../media/snowflake-schema.svg" alt-text="Diagram that shows a snowflake schema with a central fact table and normalized dimension tables branching outward into subcategory, category, and geography." lightbox="../media/snowflake-schema.svg":::

The term *snowflake* comes from the branching pattern that appears when you diagram the relationships. Each branch of the snowflake represents a level of normalization.

Consider a snowflake schema when:

- A dimension is extremely large and storage costs outweigh query performance needs.
- You need keys to relate dimension data to facts at different levels of granularity. For example, product-level sales and subcategory-level sales targets.
- You need to track historical changes at higher levels of granularity.

However, snowflake schemas require more joins, which can reduce query performance and add complexity to your queries. If you plan to build a semantic model, you should create a view that joins the snowflake tables back together because Power BI hierarchies require columns from a single table.

## Choose a schema type

Use the following guidance to choose the right schema type for your scenario:

| Schema type | Best for | Tradeoffs |
|-------------|----------|-----------|
| **Star** | Most analytics workloads, Power BI semantic models, AI scenarios | Minor storage redundancy from denormalized dimensions |
| **Snowflake** | Very large dimensions with shared hierarchies across different grain levels | Complex queries, more joins |

As your data warehouse grows, you naturally end up with multiple star schemas that share dimensions. For example, a retail model might have separate fact tables for sales, inventory, and purchasing that all reference the same product and date dimensions. This pattern emerges through conformed dimension design, which you learn about in a later unit.

## Dimensional models as a foundation for AI

The structure you choose for your dimensional model matters beyond traditional reporting. Copilot in Power BI generates better natural-language answers when the underlying data uses clear star schema relationships, because the separation of facts and dimensions maps directly to how questions are asked: *"Show me total sales by region by quarter."*

This same structure also feeds the Fabric IQ workload. The ontology item in Fabric IQ defines business concepts as entity types (like *Customer* and *Product*), properties, and relationships. These map naturally to dimensional model concepts: entity types correspond to dimensions, properties correspond to attributes, and relationships mirror the key-based connections between tables. You can generate an ontology directly from a Power BI semantic model built on your dimensional model, which means the design decisions you make here flow through to AI agents that reason about your data in business terms.

Now that you understand schema types, you can focus on designing the fact tables that sit at the center of your dimensional model.
