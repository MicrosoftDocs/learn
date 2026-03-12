Dimension tables provide the context that makes fact data meaningful. Dimensions answer the **who**, **what**, **when**, **where**, and **why** behind every measurement in a fact table. Without dimensions, facts are just numbers. With dimensions, those numbers become sales *by product*, *by region*, *by quarter*.

## Understand dimension table structure

A dimension table contains several types of columns:

- **Surrogate key** is a system-generated unique identifier that serves as the primary key. Surrogate keys insulate the data warehouse from changes in source systems and enable historical tracking.
- **Natural key** is the identifier from the source system (sometimes called a *business key*). It links the dimension back to its source data during extract, transform, and load (ETL) processes.
- **Dimension attributes** are descriptive columns used to filter, group, and label data in reports. Examples include product name, customer segment, and region.

## Use surrogate keys

Surrogate keys are a recommended practice for dimension tables, even when a natural key seems like a good candidate. Surrogate keys:

- Consolidate data from multiple source systems without key conflicts.
- Replace multi-column natural keys with a single, efficient column.
- Support slowly changing dimension (SCD) type 2 tracking, where multiple versions of the same entity need distinct keys.
- Reduce fact table storage by using small integer data types.

> [!NOTE]
> The date dimension is an accepted exception. Its surrogate key typically uses `YYYYMMDD` format stored as an integer, making the key both meaningful and efficient.

## Design common dimensions

Most dimensional models include a standard set of dimensions. Here are the most common:

| Dimension | Purpose | Example attributes |
|-----------|---------|-------------------|
| **Date** | Time-based analysis and calendar hierarchies | Year, quarter, month, day, fiscal year, is holiday |
| **Customer** | Customer demographics and segmentation | Name, segment, region, loyalty tier |
| **Product** | Product categorization and description | Category, subcategory, brand, SKU |
| **Geography** | Location-based analysis | City, state/province, country/region, postal code |
| **Employee** | Organizational structure | Department, title, manager, hire date |

> [!TIP]
> A good way to identify which dimensions you need is to listen for the word *by*. When stakeholders say they need sales *by* region *by* product category *by* month, they're telling you which dimensions and attributes the model requires.

## Denormalize for performance

In most cases, dimension tables should be *denormalized*. Denormalization flattens hierarchies and stores redundant data directly in the dimension table. For example, a product dimension stores the category name on every row rather than referencing a separate category table.

The storage cost of this redundancy is small compared to the performance benefit. Fewer joins mean faster queries, and users can filter and group by any attribute without complex multi-table lookups.

## Include hierarchies

Hierarchies enable drill-down analysis in reports. For instance, a date dimension with year, quarter, month, and day columns lets report consumers start with yearly totals and drill down to daily detail.

Common hierarchy types include:

- **Balanced hierarchies** have the same number of levels in every branch. Calendar hierarchies (year, quarter, month, day) are a typical example.
- **Unbalanced hierarchies** have branches with varying depth, often based on parent-child relationships like an organizational reporting structure.
- **Ragged hierarchies** have levels where some members skip intermediate levels. For example, a geography hierarchy where some regions don't have states or provinces.

## Use conformed dimensions

A *conformed dimension* is shared across multiple fact tables. The date dimension is the most common conformed dimension because almost every fact table records events by date.

Conformed dimensions deliver consistency. When the sales fact table and the inventory fact table share the same product dimension, analysts can compare product-level data across both business processes using a single, consistent set of attributes.

:::image type="content" source="../media/conformed-dimensions.svg" alt-text="Diagram showing two fact tables, Fact_Sales and Fact_Inventory, sharing conformed Dim_Date and Dim_Product dimensions, with Dim_Customer connected only to Fact_Sales and Dim_Store connected only to Fact_Inventory." lightbox="../media/conformed-dimensions.svg":::

## Apply role-playing dimensions

A *role-playing dimension* is a single dimension referenced multiple times in one fact table, each time representing a different context. For example, a sales fact table might reference the date dimension three times: once for order date, once for ship date, and once for delivery date.

Each reference represents a distinct *role*, but there's only one physical dimension table. Role-playing dimensions keep the model simple while supporting multiple analytical perspectives.

:::image type="content" source="../media/role-playing-dimensions.svg" alt-text="Diagram showing a single Dim_Date table connected to Fact_Orders three times as a role-playing dimension, serving as order date, ship date, and delivery date." lightbox="../media/role-playing-dimensions.svg":::

## Understand junk dimensions

When you have many small, independent dimensions with low cardinality (few values each), consider consolidating them into a *junk dimension*. A junk dimension stores the Cartesian product of all the attribute values in a single table with a surrogate key.

Good candidates for junk dimensions include flags, indicators, order status values, and demographic categories (like age group or gender). Junk dimensions reduce the number of dimension tables in the model and decrease the number of foreign keys in the fact table.

## Apply naming conventions

In a Fabric Warehouse, you typically prefix dimension table names with `d_` or `Dim_` to distinguish them from fact tables. For example, `d_Product` or `Dim_Customer`.

