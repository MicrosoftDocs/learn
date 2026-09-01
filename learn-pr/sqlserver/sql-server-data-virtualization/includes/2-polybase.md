PolyBase is the feature that SQL Server uses to enable the data virtualization concept. PolyBase was originally released in SQL Server 2016 and is improved in each later version of SQL Server. However, the general concept of accessing data remotely without having to copy the data dates from SQL Server 7.0 with the introduction of Linked Server.

The following table lists the first SQL Server version to support various PolyBase features.

|SQL Server 2016|SQL Server 2017|SQL Server 2019|SQL Server 2022|SQL Server 2025|
|-----|-----|-----|-----|-----|
|• Hadoop (removed in 2022)<br>• Azure Blob Storage (`wasbs`)|• OPENROWSET enhancements<br>• CSV for Azure Blob Storage<br>• Database Scoped Credential|• SQL Server<br>• Oracle<br>• Azure Cosmos DB<br>• MongoDB<br>• Teradata<br>• Linux support<br>• Generic ODBC|• S3-compatible object storage<br>• Azure Blob Storage connector (`abs`)<br>• Azure Data Lake Storage connector (`adls`)<br>• Parquet<br>• Delta (read-only)<br>• CETAS<br>• Hadoop removed|• Native CSV, Parquet, & Delta without PolyBase services<br>• Managed Identity (Azure Arc or Azure VM)<br>• TDS 8.0 support<br>• Generic ODBC on Linux|

For more information about PolyBase, see [PolyBase features and limitations](/sql/relational-databases/polybase/polybase-versioned-feature-summary).

## PolyBase enhancements in SQL Server 2025

- **Native support for CSV, Parquet, & Delta**:  PolyBase Query Service for External Data installation is no longer required to use OPENROWSET, CREATE EXTERNAL TABLE, or CREATE EXTERNAL TABLE AS SELECT with the following types of external data: Parquet, Delta, Azure Blob Storage (ABS), Azure Data Lake Storage (ADLS), or S3-Compatible Object storage.

- **Use generic ODBC data sources on Linux**:  For more information, see [Configure PolyBase to access external data with ODBC generic types](/sql/relational-databases/polybase/polybase-configure-odbc-generic).

- **TDS 8.0 support**:  SQL Server 2025 defaults to Microsoft ODBC Driver 18 for SQL Server for PolyBase `sqlserver` data sources, and TDS 8.0 is now supported. PolyBase uses a secure-by-default configuration with `Encrypt=Yes` (Mandatory). To enforce TLS 1.3 and strict encryption, set `Encrypt=Strict` and `TrustServerCertificate=No` in `CONNECTION_OPTIONS`. For more information, see [TDS 8.0](/sql/relational-databases/security/networking/tds-8).

## S3-compatible object storage

SQL Server 2025 supports S3-compatible object storage. To enable this integration, SQL Server 2025 uses a REST API connector framework architecture that follows the S3 framework. Any object storage that supports the S3 framework also works with SQL Server 2025. S3-compatible object storage solutions can run locally, in your network, in the cloud, or in a hybrid environment.

Object storage, also known as object-based storage, is a strategy that manages and manipulates data storage as distinct units, called objects. These objects are kept in a single storehouse and aren't ingrained in files inside other folders. Instead, object storage combines the pieces of data that make up a file, adds all relevant metadata to that file, and attaches a custom identifier.

Some main features of object storage compared to a traditional file system are:

- Keeps metadata embedded in the file.
- Lets files have attributes like tags.
- More cost-effective to scale and easier to maintain.
- Optimized for large amounts of data, such as Big Data, Internet of Things (IoT), AI, Machine Learning, and analytics.
- Not recommended for high-transactional or online transaction processing (OLTP) workloads.

You can also use S3-compatible object storage for backup and restore scenarios by using the BACKUP TO URL command. For more information, see [SQL Server backup and restore with S3-compatible object storage](/sql/relational-databases/backup-restore/sql-server-backup-and-restore-with-s3-compatible-object-storage).

The S3 standard framework is widely adopted, and many major storage providers now offer S3-compatible object storage solutions. If a solution offers compatibility with S3 REST APIs, it's compatible with SQL Server 2025. For a list of supported object storage providers, see [Providers of S3-compatible object storage](/sql/relational-databases/backup-restore/sql-server-backup-and-restore-with-s3-compatible-object-storage#providers-of-s3-compatible-object-storage).

Some object storage partners offer the ability to run their solution as software capable of virtualizing your current storage. You can install and try these solutions on your own machine or virtual machine (VM).

## PolyBase services vs. the PolyBase REST API feature

To use PolyBase, you must install the **PolyBase Query Service for External Data** and enable PolyBase at an instance level by using `sp_configure`. PolyBase setup installs two PolyBase services, **SQL Server PolyBase Engine** and **SQL Server PolyBase Data Movement**.

- **SQL Server PolyBase Engine**
  - Service executable: `mpdwsvc.exe -dweng`
  - Parses queries.
  - Generates query plans.

- **SQL Server PolyBase Data Movement**
  - Service executable: `mpdwsvc.exe -dms`
  - Transfers data between SQL Server and external RDBMS data sources.
  - Inserts data into other data sources, such as Azure Storage.

Data sources like SQL Server, Oracle, MongoDB, or ODBC-based sources use these PolyBase services. Data sources that use the SQL Server 2025 REST API-based PolyBase architecture—Azure Blob Storage, Azure Data Lake Storage, and S3-compatible object storage—don't require these services to be running or configured. In SQL Server 2025, the **PolyBase Query Service for External Data** installation is also no longer required for file-based data sources (Parquet, Delta, and CSV). RDBMS data sources such as SQL Server, Oracle, Teradata, MongoDB, and ODBC still require PolyBase services to be installed and running.

You can use the PolyBase REST APIs to access Azure Data Lake Storage, Azure Blob Storage, any S3-compatible object storage, and file formats such as Parquet, Delta, and CSV files. Previously supported RDBMS data sources still use the **SQL Server PolyBase Engine** and **SQL Server PolyBase Data Movement** services.

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
