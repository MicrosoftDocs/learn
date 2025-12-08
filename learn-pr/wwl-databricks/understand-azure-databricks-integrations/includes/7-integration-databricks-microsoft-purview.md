As organizations build data lakehouses in Azure Databricks, they face data governance challenges. Without integration between Databricks and governance tools, data engineers, business users, and compliance teams work in isolation, creating data silos and governance gaps.

Microsoft Purview provides unified data governance across multiple sources, including Azure Databricks. This integration enables a single catalog of data assets, lineage tracking, and consistent governance policies.

## How the integration works

The integration uses **metadata synchronization**. Purview reads metadata about databases, tables, columns, and relationships from Databricks without accessing actual data. This metadata is cataloged alongside other sources.

The process involves **registration** (establishing the connection and authentication) and **scanning** (extracting metadata at scheduled intervals or on demand).

:::image type="content" source="../media/databricks-purview-integration.svg" alt-text="Diagram explaining the Azure Databricks integration with Microsoft Purview." border="false" lightbox="../media/databricks-purview-integration.svg":::

## Scanning metadata sources

Purview can scan metadata from both Hive Metastore and Unity Catalog, each offering different capabilities based on the architectural differences between these metadata storage systems.

## Scanning Hive Metastore metadata

Purview scans workspace-scoped Hive metastores to discover databases, tables, views, and column definitions. For external tables, it captures **storage relationships** between logical tables and physical storage locations.

Hive metastore scanning captures **static lineage** from view definitions, showing dependencies between views and underlying tables. This requires a self-hosted integration runtime to connect to Databricks clusters.

> [!NOTE]
> Hive Metastore scanning does not support incremental scanning. Each scan performs a full extraction, unlike Unity Catalog which supports incremental synchronization.

## Scanning Unity Catalog metadata

Unity Catalog scanning extracts the complete hierarchy—metastores, catalogs, schemas, tables, and views. It supports **incremental synchronization**, processing only changes after the initial full scan, which improves efficiency for large environments.

Unlike Hive metastore, Unity Catalog scanning uses cloud-native Azure integration runtime to connect through SQL Warehouses, simplifying deployment.

### Understanding runtime lineage

Unity Catalog scanning captures **runtime lineage**—actual data transformations from notebook execution. When notebooks read, transform, and write data, Unity Catalog records these operations in system tables that Purview scans.

Runtime lineage provides:
- **Table lineage**: shows which tables feed into other tables
- **Column lineage**: traces specific columns from source to destination

Limitations: Only transformations logged by Unity Catalog appear in lineage. External orchestration tools like Azure Data Factory don't appear, and column-level lineage may not capture all complex transformations.

## Benefits of integration

### Unified data discovery

Integration eliminates catalog fragmentation. Databricks tables appear in Purview alongside other data sources, enabling users to find all relevant data regardless of origin. This reduces duplication and improves collaboration.

### Consistent governance

Governance teams apply classifications, ownership, and policies consistently across all data sources. Data classification and compliance reporting span the entire data estate using unified tools and processes.

### Lineage for impact analysis and compliance

Lineage enables **impact analysis** by showing which downstream assets depend on source data before making changes. For **compliance**, lineage automatically documents data flows required by certain regulations, transforming manual documentation into an automated process.

:::image type="content" source="../media/databricks-purview-integration-example.svg" alt-text="Screenshot of Microsoft Purview integration with Azure Databricks, showing lineage." border="false" lightbox="../media/databricks-purview-integration-example.svg":::

## Scanning approaches

Organizations choose between Hive Metastore and Unity Catalog scanning based on their architecture and governance maturity. During **migration** periods, Purview can scan both simultaneously without duplicating assets.

The approaches differ in infrastructure: Hive Metastore requires self-hosted infrastructure, while Unity Catalog uses cloud-native Azure services through SQL Warehouses. Choose based on network requirements and cloud-native preferences.
