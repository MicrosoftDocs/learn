PolyBase is the feature that SQL Server uses to enable the data virtualization concept. PolyBase was originally released in SQL Server 2016, and improved in each of the future versions of SQL Server. The general concept of accessing data remotely without the need of copying the data over however, dates back from SQL Server 7.0 with the introduction of Linked Server.

:::image type="content" source="../media/polybase-evolution.png" alt-text="An image of PolyBase enhancements in different versions of SQL Server, from 2016 to 2022.":::

## PolyBase enhancements in SQL Server 2022

SQL Server 2022 introduces the newest version of PolyBase, and with it the capability to query data where it lives, virtualize data, and use REST APIs. REST APIs enable SQL Server to be both more flexible and lightweight, while expanding its range of supported connectors and file formats.

SQL Server 2022 now supports CSV, Parquet, and Deltafiles stored on Azure Storage Account v2, Azure Data Lake Storage Gen2, or any simple storage service (S3)–compatible object storage. The S3-compatible object storage can be an on-premises offering or an offering in the cloud.

SQL Server 2022 can now use `Create External Table as Select` (CETAS), together with commands like `OPENROWSET`, `Create External Table`  (CET), and all the new T-SQL enhancements, making SQL Server 2022 a powerful data hub.

## PolyBase installation

PolyBase can be installed with the SQL Server installation executable during initial setup, or added as a feature later on. On the **Feature Selection** page of the SQL Server setup.exe, select **PolyBase Query Service for External Data**.

:::image type="content" source="../media/polybase-setup-during-sql-server-install.png" alt-text="Image of the setup executable of SQL Server showing the PolyBase option.":::

PolyBase services require firewall ports to be enabled in order to connect to external data sources.

By default, PolyBase uses ports ranging from 16450 to 16460.

:::image type="content" source="../media/polybase-port-ranges.png" alt-text="Image of the setup executable of SQL Server showing the PolyBase port range configuration.":::

After the feature installation, there's two PolyBase services installed:

- **SQL Server PolyBase Engine**, which:  
  - Service executable: `mpdwsvc.exe -dweng`
  - Parses queries
  - Generates query plans
  - Distribute work to compute nodes (SQL Server 2019)
  - Processes compute node results and results back to the client (SQL Server 2019)

- **SQL Server PolyBase Data Movement**, which:
  - Service executable: `mpdwsvc.exe -dms`
  - Transfer data between external data sources as well as between PolyBase head and compute nodes (SQL Server 2019)
  - Insert data into other data sources, such as Azure Storage

Once the service is installed, the PolyBase feature must be enabled on an instance level, using the following syntax:

```sql
exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
RECONFIGURE;
```

:::image type="content" source="../media/enable-polybase-t-sql.png" alt-text="An image of enabling PolyBase using T-SQL in SQL Server Management Studio.":::

For complete information and prerequisites on the PolyBase installation, see:

- [Install PolyBase on Windows](/sql/relational-databases/polybase/polybase-installation)

- [Install PolyBase on Linux](/sql/relational-databases/polybase/polybase-linux-setup)

- [PolyBase features and limitations](/sql/relational-databases/polybase/polybase-versioned-feature-summary)

## PolyBase services vs PolyBase feature

SQL Server 2022 adds support within the database engine using REST API interfaces to access data in Azure Blob storage, Azure Data Lake Storage Gen2, S3 compatible object storage providers (that includes file formats such as Parquet, Delta, and CSV).

This new architecture does not require PolyBase services to be running or configured, only PolyBase feature enabled on an instance-level using `sp_configure` option.

For all the other already existing data sources, such as SQL Server, Oracle, MongoDB, or ODBC-based data source, PolyBase will use PolyBase services.

|Data Source |PolyBase services |PolyBase feature REST API |
|---------|---------|---------|
|Azure Blob storage |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |
|Azure Data Lake Storage Gen2 |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |
|S3-compatible object storage |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |
|SQL Server |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No":: |
|Oracle |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No":: |
|Teradata |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No":: |
|MongoDB or CosmosDB API for MongoDB |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No":: |
|Generic ODBC |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No":: |
|Bulk Operations |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No":: |

Regardless of using PolyBase services-only data sources or PolyBase feature data sources, **PolyBase Query Service for External Data** feature needs to be installed.  
