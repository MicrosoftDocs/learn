# Implement data lineage in Unity Catalog

## Introduction

As your data platform grows, it becomes harder to keep track of where data comes from and what depends on it. Unity Catalog in Azure Databricks automatically captures data lineage — the flow of data across tables, views, notebooks, and pipelines.  

Lineage helps you answer key governance questions such as:
- Where did this data originate?
- Which reports or models depend on it?
- What will break if I change this table?

In this unit, you'll explore how to view lineage in Unity Catalog, understand what metadata it captures, and use lineage insights to plan safe changes to your data environment.

---

## View table lineage

Unity Catalog automatically tracks relationships between data assets. You can visualize these relationships directly from the Databricks workspace.

### Scenario

You need to understand the dependencies for a table before changing its schema or transformation logic.

### Steps

1. In your Databricks workspace, open **Catalog Explorer**.  
2. Navigate to your catalog (for example, `analytics_catalog`).  
3. Select a schema (for example, `sales`).  
4. Choose a table (for example, `customer_silver`).  
5. Select the **Lineage** tab.  

🟦 **UI image suggestion:** Add a screenshot of the **Lineage** tab in Catalog Explorer showing the table’s upstream and downstream objects.

:::image type="content" source="../media/lineage-graph.png" alt-text="Lineage graph showing upstream and downstream dependencies for a Unity Catalog table." lightbox="../media/lineage-graph.png":::

### What you’ll see

- **Upstream tables** – Sources feeding into this table (for example, `customer_bronze_clean`).  
- **Downstream objects** – Tables, views, or dashboards that depend on this table (for example, `customers_count_per_state`).  
- **Connection lines** – Arrows showing the flow of data between objects.  

Understanding these dependencies helps you avoid breaking downstream pipelines when making changes.

> [!NOTE]
> Lineage is only available for Unity Catalog–managed tables. Legacy Hive metastore tables don’t support lineage tracking.

---

## Understand what lineage captures

Unity Catalog automatically captures lineage for multiple asset types, providing full visibility into how data moves through your environment.

| **Asset type** | **What lineage captures** |
|----------------|----------------------------|
| Tables and views | Relationships created through SQL queries and Delta Live Tables |
| Columns | Transformations and column-level dependencies (available in detailed view) |
| Notebooks and workflows | Which notebooks or jobs read from or write to tables |
| Dashboards and reports | Dependencies between tables and Power BI or Databricks dashboards |
| External data sources | Tables imported through Lakehouse Federation |
| Machine learning models | Training data sources used by models |

🟦 **UI image suggestion:** Add a diagram or screenshot showing the lineage overview page, highlighting the toggle between *table*, *column*, and *asset* views.

The key benefit: you don’t have to manually document these relationships. Lineage is captured automatically as you query, transform, and visualize data.

---

## Use lineage for impact analysis

Lineage isn’t just for documentation — it’s a tool for safe change management.

### Scenario

You’re planning to rename a column in the `customer_silver` table and need to know which downstream objects will be affected.

### Steps

1. Open **Catalog Explorer** and navigate to the `customer_silver` table.  
2. Select the **Lineage** tab.  
3. Review all **downstream dependencies**.  

The lineage graph shows two dependent views:
- `customers_count_per_state` – Aggregates the column you plan to rename.  
- `email_updates` – References the column in a filter condition.  

>Insert image: screenshot of zoomed lineage view highlighting dependent objects after selecting a table

### Action plan

Update both downstream views when renaming the column, or create a compatibility view to preserve existing references.

> [!TIP]
> Always review lineage before schema or logic changes. It helps identify all affected assets — preventing broken pipelines, dashboards, and reports.

🟦 **UI image suggestion:** Add a screenshot zoomed in on a lineage graph highlighting downstream dependencies for a single column.

---

## Summary

Unity Catalog’s lineage tracking gives you visibility into how data flows through your lakehouse.  
By reviewing lineage before making changes, you can:
- Trace data origin and transformations.  
- Understand dependencies between datasets and analytics assets.  
- Prevent breaking downstream jobs or reports.  

Lineage turns your data estate from a black box into a transparent, maintainable system — a key foundation for secure and governed analytics.

