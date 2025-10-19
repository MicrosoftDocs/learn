# Migrate from Hive metastore to Unity Catalog in Azure Databricks

Before Unity Catalog, Azure Databricks relied on the Hive metastore to manage table metadata. While this approach supported basic operations, it operated at the workspace level. As organizations grew, they needed a more unified way to manage permissions, lineage, and compliance across workspaces.

Unity Catalog was introduced as a next-generation governance solution. It builds on the foundation of the Hive metastore while enabling centralized, fine-grained control over data assets. The key advantage is that you can enable Unity Catalog without disrupting existing workloads—both systems can coexist during migration.

---

## Understand Hive metastore coexistence

When you enable Unity Catalog, your existing Hive metastore doesn’t disappear. Instead, Databricks automatically registers it as a special catalog named **`hive_metastore`**.  
This coexistence allows you to transition to Unity Catalog gradually while maintaining compatibility with existing queries and notebooks.

**What you’ll do:**
- Explore how the Hive metastore appears alongside Unity Catalog
- Identify where existing and new tables reside
- Verify that Hive-based workloads continue to run

**Steps:**
1. Open **Catalog Explorer** in your Databricks workspace.  
2. In the left pane, you’ll see both:
   - A Unity Catalog metastore (for example, **`main`**)  
   - A legacy Hive catalog named **`hive_metastore`**  
3. Expand each catalog to view schemas and tables.

:::image type="content" source="../media/catalog-coexistence.png" alt-text="Diagram showing Catalog Explorer with main and hive_metastore side by side." lightbox="../media/catalog-coexistence.png":::

**Why this matters:**  
This design ensures that existing applications continue to function while you begin creating new assets in Unity Catalog.

---

## Query legacy Hive tables after enabling Unity Catalog

Even after enabling Unity Catalog, Hive tables remain accessible. You can reference them using a **three-level namespace**:

```sql
SELECT * FROM hive_metastore.default.customer_data;
If you prefer shorter references during a session, set the default catalog:

sql
Copy code
USE CATALOG hive_metastore;
SELECT * FROM default.customer_data;
Why this matters:
This allows you to enable Unity Catalog without breaking existing queries or notebooks. You can migrate tables at your own pace while continuing to query legacy data.

💡 Suggested UI image: Screenshot of the SQL query editor showing a Hive table query succeeding after Unity Catalog is enabled.

Understand phased migration
Because Unity Catalog and the Hive metastore can coexist, migration typically happens in stages. This approach prevents downtime and allows teams to adopt new features incrementally.

Phased approach:

Enable coexistence: Hive tables remain accessible in hive_metastore.

Create new tables in Unity Catalog: Use UC for all new development.

Migrate high-value tables first: Take advantage of lineage, fine-grained access, and centralized audit logging.

Retire Hive tables: Once validation is complete, update workloads to use Unity Catalog tables.

:::image type="content" source="../media/migration-timeline.png" alt-text="Timeline diagram showing coexistence, new development in UC, high-value table migration, and full transition." lightbox="../media/migration-timeline.png":::

💡 Suggested UI image: Catalog Explorer showing both Hive and UC tables before and after a migration.

Migrate a table to Unity Catalog and validate it
You can migrate a Hive table into Unity Catalog with a simple CREATE TABLE AS SELECT statement.

Steps:

Create the Unity Catalog table:

sql
Copy code
CREATE TABLE main.sales.customer_profiles AS
SELECT customer_id, name, email, registration_date
FROM hive_metastore.default.customers;
Validate the data by comparing row counts:

sql
Copy code
SELECT COUNT(*) FROM hive_metastore.default.customers;
SELECT COUNT(*) FROM main.sales.customer_profiles;
Update downstream references:

Replace hive_metastore.default.customers with main.sales.customer_profiles in notebooks and jobs.

Retain the Hive table for validation, then restrict or drop it after successful verification.

:::image type="content" source="../media/migration-steps.png" alt-text="Checklist graphic showing migration steps from Hive to Unity Catalog." lightbox="../media/migration-steps.png":::

💡 Suggested UI image: Screenshot of Catalog Explorer showing the new UC table next to the Hive table.

Synchronize data during transition
If dependent applications or pipelines still rely on Hive tables, you can maintain temporary synchronization while updates are rolled out.

sql
Copy code
MERGE INTO main.sales.customer_profiles AS uc
USING hive_metastore.default.customers AS hive
ON uc.customer_id = hive.customer_id
WHEN MATCHED THEN UPDATE SET *
WHEN NOT MATCHED THEN INSERT *;
Keep synchronization short-lived to avoid data drift or duplicate maintenance.

:::image type="content" source="../media/hive-uc-sync.png" alt-text="Flow diagram showing Hive to Unity Catalog data sync with short synchronization window." lightbox="../media/hive-uc-sync.png":::

💡 Suggested diagram: Arrows showing Hive → UC sync flow with a note indicating “temporary sync window.”

Key takeaway
Unity Catalog doesn’t replace the Hive metastore overnight—it builds on it.
By allowing both systems to coexist, Databricks enables a seamless transition to centralized governance, fine-grained security, and automated lineage without interrupting existing workloads.