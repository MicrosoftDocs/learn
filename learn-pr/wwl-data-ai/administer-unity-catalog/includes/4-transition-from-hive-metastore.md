Before Unity Catalog, Azure Databricks relied on the Hive metastore to manage table metadata, schemas, and basic access controls. The Hive metastore provided essential data catalog functionality, including table definitions, column schemas, partitioning information, and storage locations. However, it operated at the workspace level, which limited cross-workspace collaboration and centralized governance. As organizations scaled their data initiatives across multiple teams and departments, there was a need for a unified way to manage permissions, lineage, and compliance *across workspaces.*

Unity Catalog builds on the foundation of the Hive metastore while enabling centralized, fine-grained control over data assets. You can enable Unity Catalog without disrupting existing workloads that rely on tables in the Hive metastore—both systems can coexist.

## Working with both metastores

When you enable Unity Catalog, your existing Hive metastore doesn't disappear. Instead, Databricks automatically registers it as a special catalog named **`hive_metastore`**, allowing you to migrate at your own pace or maintain both systems for different use cases.

In the Catalog Explorer, you'll see both metastores. Unity Catalog catalogs appear alongside the legacy Hive catalog named **`hive_metastore`**. You can expand each catalog to view their respective schemas and tables, as shown in the following image.

:::image type="content" source="../media/catalog-coexistence.png" alt-text="Diagram showing Catalog Explorer with main and hive_metastore side by side." lightbox="../media/catalog-coexistence.png":::

This design ensures that existing applications continue to function while you begin creating new assets in Unity Catalog. Your migration can happen gradually, without disrupting day-to-day operations.

## Query legacy Hive tables after enabling Unity Catalog

Even after enabling Unity Catalog, Hive tables remain accessible. You can reference them using the **three-level namespace** of `catalog.schema.object`:

```sql
SELECT * FROM hive_metastore.default.customer_data;
```

If you prefer shorter references during a session, set the default catalog:

```sql
USE CATALOG hive_metastore;
SELECT * FROM default.customer_data;
```

This approach allows you to enable Unity Catalog without breaking existing queries or notebooks. You can migrate tables at your own pace while continuing to query legacy data.

## Plan your migration approach

When you're ready to migrate tables from Hive metastore to Unity Catalog, you have several options depending on your needs:

**For individual tables:** Use SQL commands to migrate specific tables with full control over the process.

**For bulk migration:** Use the Catalog Explorer upgrade wizard to migrate complete schemas or multiple tables at once through a guided interface.

## Migrate tables using SQL commands

When you need to migrate specific tables, you can use SQL commands for precise control. The method you choose depends on your table type:

**For managed Delta tables:**

```sql
-- Clone preserves all metadata, constraints, and properties
CREATE TABLE main.sales.customer_profiles
DEEP CLONE hive_metastore.default.customers;
```

**For any table type (basic data copy):**

```sql
-- Copy data and basic structure
CREATE TABLE main.sales.customer_profiles AS
SELECT customer_id, name, email, registration_date
FROM hive_metastore.default.customers;
```

**For external tables or bulk migration:**

```sql
-- Sync external tables quickly
SYNC TABLE main.sales.orders 
FROM hive_metastore.default.orders;
```

## Use the upgrade wizard for bulk migration

For migrating multiple tables or complete schemas, use the **Catalog Explorer upgrade wizard**:

1. In Databricks, select **Catalog** in the sidebar
2. Select **hive_metastore** and choose your schema
3. Select **Upgrade** and select the tables to migrate
4. Configure destination catalogs and owners
5. Run the upgrade or generate a notebook

The wizard provides a visual, guided approach that's ideal for bulk operations and teams who prefer UI-driven workflows.

Here's what the upgrade wizard looks like:

:::image type="content" source="../media/upgrade-wizard.png" alt-text="Screenshot of the Catalog Explorer upgrade wizard interface showing table selection and configuration options." lightbox="../media/upgrade-wizard.png":::

> [!TIP]
> For complete migration guidance, see [Upgrade Hive tables and views to Unity Catalog](/azure/databricks/data-governance/unity-catalog/migrate) and [Use the UCX utilities to upgrade your workspace to Unity Catalog](/azure/databricks/data-governance/unity-catalog/ucx).