---
ms.custom:
  - build-2023
---
PolyBase is the feature that SQL Server uses to enable the data virtualization concept. PolyBase was originally released in SQL Server 2016 and is improved in each later version of SQL Server. However, the general concept of accessing data remotely without having to copy the data dates from SQL Server 7.0 with the introduction of Linked Server.

The following table lists the first SQL Server version to support various PolyBase features.

|SQL Server 2016|SQL Server 2017|SQL Server 2019|SQL Server 2022|
|-----|-----|-----|-----|
|• Hadoop<br>• Azure Blob Storage|• OPENROWSET enhancements<br>• CSV for Azure Blob Storage<br>• Database Scoped Credential|• SQL Server<br>• Oracle<br>• Azure Cosmos DB<br>• MongoDB<br>• Teradata<br>• Linux support<br>• Generic ODBC|• New connector framework<br>• Object storage integration<br>• CSV<br>• Parquet<br>• Delta<br>• CETAS|

For more information about PolyBase, see [PolyBase features and limitations](/sql/relational-databases/polybase/polybase-versioned-feature-summary).

## PolyBase enhancements in SQL Server 2022

SQL Server 2022 introduces the newest version of PolyBase, including the capability to query data where it lives, virtualize data, and use REST APIs.

- REST APIs enable SQL Server to be both more flexible and lightweight, while expanding its range of supported connectors and file formats.

- SQL Server 2022 now supports CSV, Parquet, and Delta files stored in Azure Blob Storage, Azure Data Lake Storage, or any simple storage service (S3)-compatible object storage.

- SQL Server 2022 can use commands like CREATE EXTERNAL TABLE AS SELECT (CETAS), OPENROWSET, CREATE EXTERNAL TABLE (CET), and all new T-SQL enhancements, making it a powerful data hub.

## S3-compatible object storage

SQL Server 2022 now supports S3-compatible object storage. To enable this integration, SQL Server 2022 uses a new REST API connector framework architecture that follows the S3 framework. Any object storage that supports the S3 framework now also works with SQL Server 2022. S3-compatible object storage solutions can run locally, in your network, in the cloud, or in a hybrid environment.

Object storage, also known as object-based storage, is a strategy that manages and manipulates data storage as distinct units, called objects. These objects are kept in a single storehouse and aren't ingrained in files inside other folders. Instead, object storage combines the pieces of data that make up a file, adds all relevant metadata to that file, and attaches a custom identifier.

Some main features of object storage compared to a traditional file system are:

- Keeps metadata embedded in the file.
- Lets files have attributes like tags.
- More cost-effective to scale and easier to maintain.
- Optimized for large amounts of data, such as Big Data, Internet of Things (IoT), AI, Machine Learning, and analytics.
- Not recommended for high-transactional or online transaction processing (OLTP) workloads.

You can also use S3-compatible object storage for backup and restore scenarios by using the BACKUP TO URL command. For more information, see [SQL Server backup and restore with S3-compatible object storage](/sql/relational-databases/backup-restore/sql-server-backup-and-restore-with-s3-compatible-object-storage).

Amazon Web Services (AWS) established the S3 standard framework, and major storage providers like Cloudian, Dell, MinIO, and PureStorage now offer S3-compatible object storage solutions. If a solution offers compatibility with S3 REST APIs, it's compatible with SQL Server 2022.

For more information about object storage benefits, installation, and testing, see the following storage partner documentation. For more object storage providers, see [Providers of S3-compatible object storage](/sql/relational-databases/backup-restore/sql-server-backup-and-restore-with-s3-compatible-object-storage#providers-of-s3-compatible-object-storage).

- [Cloudian](https://cloudian.com/sql) HyperStore
- [Dell](https://www.dell.com/en-us/dt/products-solutions/trial-software-download/eula/isilonsoftwaredownload.htm) Isildon OneFS
- [Dell](https://github.com/EMCECS/ECS-CommunityEdition) ECS Community Edition
- [Hitachi](https://www.hitachivantara.com/en-us/pdf/white-paper/microsoft-sql-server-2022-with-hcp-backup-to-object-polybase-validation.pdf) Hitachi Content Platform (HCP)
- [MinIO](https://min.io/solutions/sqlserver) Multi-Cloud Object Storage
- [Pure Storage](https://www.purestorage.com/products/unstructured-data-storage/flashblade-s.html) Pure FlashBlade. The Pure Storage [SQL Server Test Drive](https://www.purestorage.com/solutions/applications/microsoft/sql/sql-test-drive.html) portal has virtual SQL Server 2022 labs with a full ledger data virtualization guided exercise and more.

Some object storage partners offer the ability to run their solution as software capable of virtualizing your current storage. You can install and try these solutions on your own machine or virtual machine (VM).

## PolyBase services vs. the PolyBase REST API feature

To use PolyBase, you must install the **PolyBase Query Service for External Data** and enable PolyBase at an instance level by using `sp_configure`. PolyBase setup installs two PolyBase services, **SQL Server PolyBase Engine** and **SQL Server PolyBase Data Movement**.

- **SQL Server PolyBase Engine**
  - Service executable: `mpdwsvc.exe -dweng`
  - Parses queries.
  - Generates query plans.
  - Distributes work to compute nodes (SQL Server 2019).
  - Processes compute node results and results back to the client (SQL Server 2019).

- **SQL Server PolyBase Data Movement**
  - Service executable: `mpdwsvc.exe -dms`
  - Transfers data between external data sources and between PolyBase head and compute nodes (SQL Server 2019).
  - Inserts data into other data sources, such as Azure Storage.

Data sources like SQL Server, Oracle, MongoDB, or ODBC-based sources use these PolyBase services. Data sources that use the new SQL Server 2022 REST API-based PolyBase architecture don't require these services to be running or configured, but the **PolyBase Query Service for External Data** must still be installed and enabled.

You can use the PolyBase REST APIs to access Azure Data Lake Storage, Azure Blob Storage, any S3-compatible object storage, and file formats such as Parquet, Delta, and CSV files. Previously supported data sources still use the **SQL Server PolyBase Engine** and **SQL Server PolyBase Data Movement** services.

|Data source |PolyBase services |PolyBase REST API feature|
|---------|---------|---------|
|Azure Blob Storage |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |
|Azure Data Lake Storage |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |
|S3-compatible object storage |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |
|SQL Server |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: | :::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |
|Oracle |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |
|Teradata |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |
|MongoDB or Azure Cosmos DB API for MongoDB |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |
|Generic Open Database Connectivity (ODBC) |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |
|Bulk operations |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |

