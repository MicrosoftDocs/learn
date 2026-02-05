>[!VIDEO https://learn-video.azurefd.net/vod/player?id=dff93cc3-d88e-4db3-844c-c0aef80e141e]

Understanding where your data comes from, how it transforms, and where it flows is essential for effective data governance. When you set up and manage **data lineage tracking** in Unity Catalog, you gain visibility into data dependencies, ownership, and history. This visibility helps you perform **impact analysis** before making changes, troubleshoot data quality issues, and meet compliance requirements.

In this unit, you learn how to use Catalog Explorer to view and manage data lineage, explore table history and ownership, and understand the connections between your data assets.

## Understand data lineage in Unity Catalog

Unity Catalog automatically captures **runtime data lineage** across queries run on Azure Databricks. This lineage tracking works across all languages and captures relationships down to the **column level**. Lineage data includes the notebooks, jobs, and dashboards that interact with your tables.

:::image type="content" source="../media/6-understand-lineage.png" alt-text="Screenshot of Unity Catalog lineage." lightbox="../media/6-understand-lineage.png":::

Consider a scenario where a sales analytics dashboard suddenly shows incorrect revenue figures. With lineage tracking, you can trace back through the data flow to identify which upstream table or transformation caused the issue. This capability transforms troubleshooting from guesswork into a systematic investigation.

### Configure compute to capture lineage

For Unity Catalog to capture lineage automatically, queries must run on **Unity Catalog-enabled compute**. This includes:

- **Compute clusters** configured with Unity Catalog access mode (shared, single user, or serverless)
- **SQL warehouses** that have Unity Catalog enabled
- **Jobs** running on Unity Catalog-enabled clusters

When you create a cluster with access to Unity Catalog, the compute automatically captures lineage for all queries that read from or write to Unity Catalog tables. This happens without requiring additional configuration or code changes, making lineage capture seamless and requiring minimal administrative effort.

Clusters that are not Unity Catalog-enabled, or queries that access tables by direct file path instead of catalog names, do not generate lineage data. To ensure comprehensive lineage coverage, configure all production workloads to use Unity Catalog-enabled compute and reference tables using their three-level namespace (`catalog.schema.table`).

Lineage is aggregated across all workspaces attached to a Unity Catalog metastore. When you capture lineage in one workspace, users in other workspaces that share the same metastore can view that lineage information. This **cross-workspace visibility** is particularly valuable for organizations with distributed data teams.

> [!NOTE]
> Lineage data is retained for **one year**. You can filter lineage data by time frame within this window to focus on specific periods.

## View data lineage using Catalog Explorer

**Catalog Explorer** provides a visual interface for exploring lineage relationships. To view lineage for a table:

1. In your Azure Databricks workspace, select **Catalog** in the sidebar.
2. Search or browse to locate your table.
3. Select the **Lineage** tab to display related tables in the lineage panel.
4. Select **See Lineage Graph** to open an interactive visualization of the data flow.

The lineage graph displays tables as nodes with arrows showing data flow direction. By default, one level of connections is visible. Select the **+** icon on any node to reveal more upstream or downstream connections.

When you select an arrow connecting two nodes, the **Lineage connection** panel opens. This panel shows details about the connection, including source and target tables, the notebooks that created the relationship, and the jobs that ran the transformations.

### Explore column-level lineage

**Column-level lineage** shows how individual columns derive from source columns. This granularity helps you understand complex transformations and identify which source fields contribute to a calculated column.

To view column-level lineage, select a column in the lineage graph. The visualization highlights the upstream columns that contribute to your selected column and the downstream columns that depend on it.

### View job and dashboard lineage

Beyond table relationships, Catalog Explorer shows which jobs and dashboards consume your data:

- To view **job lineage**, go to the table's **Lineage** tab, select **Jobs**, and choose **Downstream** to see jobs that consume the table.

- To view **dashboard lineage**, select **Dashboards** in the **Lineage** tab to see which dashboards query the table.

This information supports impact analysis. Before modifying a table schema, you can identify which downstream jobs and dashboards might be affected.

## Manage table ownership

Every securable object in Unity Catalog has an **owner**. The owner has full privileges on the object and can grant permissions to other users. Understanding and managing ownership is essential for governance accountability.

To view or change ownership in Catalog Explorer:

1. Navigate to the table in Catalog Explorer.
2. On the **Overview** tab, locate the current owner.
3. Select the edit icon next to **Owner**.
4. Search for and select a user, group, or service principal.
5. Select **Save**.

:::image type="content" source="../media/6-manage-table-ownership.png" alt-text="Screenshot of the set owner dialog." lightbox="../media/6-manage-table-ownership.png":::

Only the current owner or a **metastore admin** can transfer ownership. After transfer, the previous owner loses ownership privileges unless explicitly granted.

To view lineage, users need at least the `BROWSE` privilege on the parent catalog. Objects that a user doesn't have permission to access appear as **masked nodes** in the lineage graph. This security model ensures that lineage visibility respects your access control policies.

## View table history and version changes

For **Delta tables**, Catalog Explorer displays a complete history of all operations. The **History** tab shows each version with timestamps, operation types, and the user who made the change.

You can also query table history using SQL:

```sql
-- View full table history
DESCRIBE HISTORY sales.customers.orders;

-- View only the most recent operation
DESCRIBE HISTORY sales.customers.orders LIMIT 1;
```

The history includes detailed information about each operation:

| Column             | Description                                      |
| ------------------ | ------------------------------------------------ |
| `version`          | Table version number                             |
| `timestamp`        | When the operation occurred                      |
| `operation`        | Type of operation (WRITE, UPDATE, DELETE, MERGE) |
| `userName`         | User who performed the operation                 |
| `operationMetrics` | Metrics like rows affected and files modified    |

This history supports auditing and compliance by providing a complete record of who changed what and when.

## Query lineage data programmatically

For reporting and advanced analysis, you can query the **lineage system tables** directly. Unity Catalog provides two lineage tables:

- `system.access.table_lineage` records read and write events at the table level
- `system.access.column_lineage` tracks column-level dependencies

The following query finds the most frequently accessed tables in the past week:

```sql
SELECT
  source_table_full_name,
  COUNT(DISTINCT event_id) AS query_count
FROM system.access.table_lineage
WHERE event_date > CURRENT_DATE() - INTERVAL 7 DAYS
  AND source_table_full_name IS NOT NULL
GROUP BY source_table_full_name
ORDER BY query_count DESC
LIMIT 10;
```

You can also use *Databricks Assistant* to explore lineage interactively. From Catalog Explorer, select the Assistant icon and type:

- `/getTableLineages` to view upstream and downstream dependencies
- `/getTableInsights` to access metadata-driven insights like user activity patterns

These queries help answer questions such as "who queries this table most often" or "what are the downstream consumers of this data."

## Understand lineage limitations

Lineage tracking has certain constraints you should be aware of:

- Lineage is **not preserved for renamed objects**. If you rename a table, the lineage connection to its previous name is lost.

- Tables accessed by path rather than name (for example, `delta.'abfss://...'`) show only the path in lineage, not the table name.

- Global temporary views and system tables under `system.information_schema` are not captured in lineage.

- Some user-defined functions can obscure column-level lineage by hiding the mapping between source and target columns.

Despite these limitations, lineage tracking provides comprehensive visibility for most data engineering workflows. By understanding these constraints, you can design your pipelines to maximize lineage capture.

Effective data lineage management transforms how you govern and troubleshoot your data platform. With the visibility that Catalog Explorer and system tables provide, you can confidently manage dependencies, assess change impact, and maintain accountability across your data assets.
