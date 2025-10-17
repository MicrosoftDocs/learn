Unity Catalog can govern data that lives outside Databricks—whether in cloud storage like Azure Data Lake Storage or in operational databases. This capability solves a common challenge: you have valuable data in multiple systems, and you need to query it without duplicating everything into Databricks.

This unit covers three ways Unity Catalog extends governance to external data:

- **External storage** – Govern access to data files in cloud storage like Azure Data Lake Storage, through storage credentials and external locations
- **Lakehouse Federation** – Query operational databases without moving data
- **Delta Sharing** – Securely share governed datasets with other organizations or workspaces

All three approaches maintain Unity Catalog's governance model: access control, auditing, and lineage tracking work the same whether data lives inside or outside Databricks.

## Configure storage credentials and external locations

When Databricks interacts with cloud storage, it needs two things: a way to authenticate, and a definition of where the data lives. Platform administrators handle this configuration through **Catalog Explorer**, the central interface for managing all Unity Catalog objects.

### Storage credentials

A **storage credential** defines how Databricks authenticates to external storage—think of it as the "key" to external data. In Azure environments, the storage credential references an Azure Databricks Access Connector that a Platform Administrator creates in the Azure portal. The Access Connector is an Azure resource with a managed identity that is granted permissions on your Azure storage account. Databricks uses this managed identity to access the storage on behalf of users. Once the Access Connector exists in Azure, you register it in Unity Catalog as a storage credential.

To register a storage credential in Catalog Explorer:

1. Navigate to **Catalog Explorer** in your Databricks workspace
2. Select on **External data** in the navigation menu
3. Select **Storage credentials** and select **Create credential**
4. Provide the resource ID of your Azure Databricks Access Connector
5. Grant appropriate permissions to users who need to create external locations using this credential

:::image type="content" source="../media/create-credential.png" alt-text="Screenshot of Databricks Catalog Explorer showing the Create storage credential dialog where Platform Admins register the Azure Databricks Access Connector." lightbox="../media/create-credential.png":::

> [!TIP]
> For instructions on creating an Azure Databricks Access Connector, see [Manage access connectors for Azure Databricks](/azure/databricks/connect/unity-catalog/cloud-storage/azure-managed-identities?azure-portal=true). Then, to register it as a storage credential in Unity Catalog, see [Create a storage credential for connecting to Azure Data Lake Storage](/azure/databricks/connect/unity-catalog/cloud-storage/storage-credentials?azure-portal=true).

### External locations

An **external location** combines a storage credential with a specific cloud storage path. This creates a governed access point that Unity Catalog can control. Only users with proper permissions can access the location, and all access is logged for auditing.

Platform administrators create external locations in Catalog Explorer by specifying:
- The cloud storage path to an existing Azure Data Lake Storage Gen2 storage account (for example, `abfss://finance@mydatalake.dfs.core.windows.net/`)
- Which storage credential to use for authentication
- Which users or groups should have access

:::image type="content" source="../media/external-location.png" alt-text="Screenshot of Databricks Catalog Explorer showing the Create external location dialog where Platform Admins define the storage path and associate it with a storage credential." lightbox="../media/external-location.png":::

Once configured, Unity Catalog enforces permissions on the external location and logs all access for auditing.

> [!TIP]
> For step-by-step instructions, see [Create an external location](/azure/databricks/connect/unity-catalog/cloud-storage/external-locations?azure-portal=true).

## Understand Lakehouse Federation

External storage works well for data files in cloud storage. But what about data in operational databases like SQL Server, or PostgreSQL? Lakehouse Federation enables Unity Catalog to query these systems directly without copying data.

This is valuable when operational systems contain important datasets that you need to combine with Delta tables in Databricks. Rather than extracting, transforming, and loading data into Databricks, you query it where it already lives.

The federation process begins with a **connection**, which stores the authentication details and endpoint of the external system. Once the connection exists, you create a **foreign catalog** that exposes the schemas and tables from that system inside Unity Catalog. To users, these foreign catalogs behave like native Databricks catalogs—queries can join across internal and external data seamlessly.

### Create connections and foreign catalogs

Platform administrators set up connections and foreign catalogs through Catalog Explorer:

1. In **Catalog Explorer**, navigate to **External data**
2. Select **Connections** and select **Create connection**
3. Choose the connection type
4. Provide connection details:
   - Host name
   - Port number
   - Database name
   - Authentication credentials
5. Test the connection to verify connectivity
6. Once the connection is created, select **Create foreign catalog**
7. Select the connection you just created
8. Name your foreign catalog (for example, `sales_sql_catalog`)

:::image type="content" source="../media/create-foreign-catalog.png" alt-text="Screenshot of Databricks Catalog Explorer showing the Create foreign catalog dialog where Platform Admins select a connection and name the foreign catalog that will expose external database schemas and tables." lightbox="../media/create-foreign-catalog.png":::

After the foreign catalog is created, it appears in Catalog Explorer alongside your other catalogs. You can expand it to see the schemas and tables from the external database—for example, a SQL Server foreign catalog might show schemas like `dbo`, `sales`, and `inventory` with their respective tables. All of this external data is now available for queries, subject to the same governance and permissions as internal Databricks data.

Once configured, you can query the foreign catalog using standard SQL, joining external database tables with internal Delta tables seamlessly.

## Share data securely with Delta Sharing

Delta Sharing is an open protocol for secure data exchange without data duplication. Unlike proprietary solutions, Delta Sharing isn't just for tables and isn't tied exclusively to Databricks. You can share schemas, views, notebooks, volumes, models, and even foreign schemas and tables.

Delta Sharing supports two core approaches:

**Databricks-to-Databricks sharing** – Share data and AI assets with other Unity Catalog-enabled workspaces, whether in your own account or across different Databricks accounts and cloud providers.

**Open sharing** – Share data with users on any computing platform using the open Delta Sharing protocol. Recipients can access shared data using various tools and connectors, including Power BI, Apache Spark, and pandas.

Platform administrators configure shares through Catalog Explorer. Recipients access the data in real-time without replication—you're not copying data over, just creating a pointer. Unity Catalog acts as the Delta Sharing server, applying your defined security policies including row-filtering and column-level masking in views.

> [!TIP]
> For detailed guidance, see [Share data using Delta Sharing](/azure/databricks/delta-sharing/?azure-portal=true).
