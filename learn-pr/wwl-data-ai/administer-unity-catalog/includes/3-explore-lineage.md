Unity Catalog in Azure Databricks automatically captures data lineage—the flow of data across tables, views, notebooks, and pipelines. This allows you to track where data comes from and what depends on it.  

Lineage helps you answer key governance questions such as:

- Where did this data originate?
- Which reports or models depend on it?
- What will break if I change this table?

In this unit, you explore how to view lineage in Unity Catalog, understand what metadata it captures, and use lineage insights to plan safe changes to your data environment.

## View and use lineage for change analysis

Unity Catalog automatically tracks relationships between data assets. Let's walk through a practical scenario using the lineage graph to understand dependencies and plan safe changes.

### Follow along: Analyze the customer_silver table

Imagine you're a data engineer who needs to add a new column to the `customer_silver` table in a medallion architecture. Before making changes, you want to understand what depends on this table.

1. In your Databricks workspace, open **Catalog Explorer**.  
2. Navigate to your catalog and schema.  
3. Select the `customer_silver` table.  
4. Select the **Lineage** tab, then **See lineage graph**.
5. The following graph appears.  

:::image type="content" source="../media/data-lineage-graph.png" alt-text="Lineage graph showing upstream and downstream dependencies for a Unity Catalog table." lightbox="../media/data-lineage-graph.png":::

### Interpret the lineage graph

Looking at the lineage visualization above, you can see the complete data flow for `customer_silver`:

**Upstream dependency:**

- `customer_bronze_clean` → Feeds raw customer data into your table (columns: customer_id, name, state)

**Downstream consumers:**

- `customer_count_per_state` → A view that counts customers by state (columns: state, customer_count)

**Data flow direction:** Arrows show data flows from left to right: bronze → silver → analytics view

### Perform an impact analysis

Based on this lineage, here's what adding a column to `customer_silver` affects:

1. **Safe change** – Adding a column won't break the existing `customer_count_per_state` view since it only uses the `state` column for aggregation.
2. **Upstream compatibility** – Ensure the transformation from `customer_bronze_clean` can populate the new column.
3. **Downstream opportunities** – Consider if the `customer_count_per_state` view could benefit from the new column for additional analytics.

> [!NOTE]
> Lineage is only available for Unity Catalog–managed tables. Legacy Hive metastore tables don't support lineage tracking.

## Understand what lineage captures

Now that you've seen how to use lineage for a table, let's explore the full range of assets that Unity Catalog tracks automatically.

| **Asset type** | **What lineage captures** |
|----------------|----------------------------|
| Tables and views | Relationships created through SQL queries and Delta Live Tables |
| Columns | Transformations and column-level dependencies (available in detailed view) |
| Notebooks and workflows | Which notebooks or jobs read from or write to tables |
| Dashboards and reports | Dependencies between tables and Power BI or Databricks dashboards |
| External data sources | Tables imported through Lakehouse Federation |
| Machine learning models | Training data sources used by models |

Lineage is captured automatically as you query, transform, and visualize data. You don't have to manually document these relationships.
