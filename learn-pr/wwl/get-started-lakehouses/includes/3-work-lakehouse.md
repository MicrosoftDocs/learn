Now that you understand the core capabilities of a Microsoft Fabric Lakehouse, let's explore how to work with one.

## Create and explore a lakehouse

Before you can create a lakehouse, you create a workspace in the Microsoft Fabric platform. Configure your workspace to allow Fabric resources.

You create and configure a new lakehouse in the Data Engineering workload. Each L produces three named items in the Fabric-enabled workspace:

- **Lakehouse** is the lakehouse storage and metadata, where you interact with files, folders, and table data.
- **Semantic model (default)** is an automatically created data model based on the tables in the lakehouse. Power BI reports can be built from the semantic model.
- **SQL Endpoint** is a read-only SQL endpoint through which you can connect and query data with Transact-SQL.

![Screenshot of the three lakehouse items as described.](../media/lakehouse-items.png)

You can work with the data in the lakehouse in two modes:

- **Lakehouse** enables you to add and interact with tables, files, and folders in the lakehouse.
- **SQL analytics endpoint** enables you to use SQL to query the tables in the lakehouse and manage its relational data model.

![Screenshot of the two Lakehouse Explorer modes.](../media/explorer-modes.png)

## Access data using shortcuts

**Shortcuts** enable you to integrate data into your lakehouse while keeping it stored in external storage.

Shortcuts are useful when you need data in your lakehouse from a different storage account or even a different cloud provider. Create shortcuts to different storage accounts, and other Fabric items like data warehouses, KQL databases, and other lakehouses.

Source data permissions and credentials are all managed by OneLake. When accessing data through a shortcut to another OneLake location, the identity of the calling user will be used to authorize access to the data in the target path of the shortcut. The user must have permissions in the target location to read the data.

Shortcuts can be created in both lakehouses and KQL databases, and appear as a folder in the lake. Spark, SQL, Real-Time Analytics, and Analysis Services can access data via shortcuts when querying data.

Shortcuts have limited data source connectors, so when you can't use shortcuts, you can ingest data directly into your lakehouse.

> [!NOTE]
> For more information on how to use shortcuts, see [OneLake shortcuts documentation](/fabric/onelake/onelake-shortcuts) in the Microsoft Fabric documentation.

## Ingest data into a lakehouse

There are many ways to load data into a Fabric lakehouse, including:

- **Upload**: Upload local files or folders to the lakehouse. You can then explore and process the file data, and load the results into tables.

- **Dataflows (Gen2)**: Import and transform data from a range of sources using Power Query Online, and load it directly into a table in the lakehouse.

- **Notebooks**: Use notebooks in Fabric to ingest and transform data, and load it into tables or files in the lakehouse.

- **Data Factory pipelines**: Copy data and orchestrate data processing activities, loading the results into tables or files in the lakehouse.

## Grant access to a lakehouse

Fabric lakehouse permissions are granted either at the workspace or item level. In the **Workspace settings**, you can choose between four different roles. These permissions should be reserved for collaboration for all items within the workspace, not only the lakehouse.

The lakehouse is a single item within the workspace, so access is controlled at this level as well. You can grant access directly to the lakehouse within Fabric or you can grant access to only be used via the SQL analytics endpoint. This access means users can connect to the SQL analytics endpoint with other tools like SQL Server Management Studio (SSMS) to query the data.

You can also grant object-level security by using the SQL analytics endpoint to further control what users can access.

> [!IMPORTANT]
> Security is an important aspect of the Microsoft Fabric environment. To understand what data access is available and how to grant or revoke, please review the full [Security in Microsoft Fabric documentation](/fabric/security/security-overview#access-data).
