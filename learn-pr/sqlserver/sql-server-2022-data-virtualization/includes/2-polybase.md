---
ms.custom:
  - build-2023
---
PolyBase is the feature that SQL Server uses to enable the data virtualization concept. PolyBase was originally released in SQL Server 2016, and improved in each of the future versions of SQL Server. The general concept of accessing data remotely without the need of copying the data over however, dates back from SQL Server 7.0 with the introduction of Linked Server.

:::image type="content" source="../media/polybase-evolution.png" alt-text="An image of PolyBase enhancements in different versions of SQL Server, from 2016 to 2022.":::

## PolyBase enhancements in SQL Server 2022

SQL Server 2022 introduces the newest version of PolyBase, including the capability to query data where it lives, virtualize data, and use REST APIs. REST APIs enable SQL Server to be both more flexible and lightweight, while expanding its range of supported connectors and file formats.

SQL Server 2022 now supports CSV, Parquet, and Delta files stored on Azure Blob Storage, Azure Data Lake Storage Gen2, or any simple storage service (S3)–compatible object storage. The S3-compatible object storage can be an on-premises, in the cloud, or a hybrid solution.

SQL Server 2022 can now use `Create External Table as Select` (CETAS), together with commands like `OPENROWSET`, `Create External Table`  (CET), and all the new T-SQL enhancements, making SQL Server 2022 a powerful data hub.

## S3-compatible object storage

SQL Server 2022 now supports S3-compatible object storage, as well as Azure Storage. To enable this integration, SQL Server 2022 uses a new REST API connector framework architecture that follows the S3 framework. Any object storage that supports the S3 framework will also work with SQL Server 2022.

Object storage, also known as object-based storage, is a strategy that manages and manipulates data storage as distinct units, called objects. These objects are kept in a single storehouse and aren't ingrained in files inside other folders. Instead, object storage combines the pieces of data that make up a file, adds all its relevant metadata to that file, and attaches a custom identifier.

Some of the main differences of object storage compared to traditional file system are:

- Compared to file system, object storage keeps metadata embedded on the file.

- Files can have different attributes, like tags.

- Object storage is a more cost-effective solution to scale and easier to maintain.

- Object storage is optimized for large amounts of data, such as Big Data, Internet of Things (IoT), Machine Learning, and analytics.

- Object storage isn't recommended for high transactional workloads.

Amazon Web Services (AWS) established the S3 standard, the framework. Now S3-compatible object storage solutions are being offered by every major storage provider, like Cloudian, Dell, MinIO, PureStorage, just to name a few. If the solution offers compatibility with S3 REST APIs, it will be compatible with SQL Server 2022.  

Some object storage partners offer the ability to run their solution as software, capable of virtualizing your current storage. You can install and try on your own machine or virtual machine (VM).

Object storage can be used for data virtualization, and also for backup and restore scenarios by using the `BACKUP TO URL` command. For more information, see [SQL Server backup and restore with S3-compatible object storage](/sql/relational-databases/backup-restore/sql-server-backup-and-restore-with-s3-compatible-object-storage).

S3-compatible object storage solutions can run locally, in your network, in the cloud, or in a hybrid environment. For more information about object storage, benefits, how to install, guides and how to test it, check some of our storage partners websites:

| Provider | Solution |
|--|--|
| [Cloudian](https://cloudian.com/sql) | HyperStore |
| [Dell](https://www.dell.com/en-us/dt/products-solutions/trial-software-download/eula/isilonsoftwaredownload.htm) | Isildon OneFS |
| [Dell](https://github.com/EMCECS/ECS-CommunityEdition) | ECS Community Edition |
| [Hitachi](https://www.hitachivantara.com/en-us/pdf/white-paper/microsoft-sql-server-2022-with-hcp-backup-to-object-polybase-validation.pdf) | Hitachi Content Platform (HCP) |
| [MinIO](https://min.io/solutions/sqlserver) | Multi-Cloud Object Storage |
| [Pure Storage](https://www.purestorage.com/products/unstructured-data-storage/flashblade-s.html) | Pure FlashBlade |

For more information on object storage providers, see [Providers of S3-compatible object storage](/sql/relational-databases/backup-restore/sql-server-backup-and-restore-with-s3-compatible-object-storage#providers-of-s3-compatible-object-storage).

## PolyBase installation

PolyBase can be installed with the SQL Server installation executable during initial setup, or added as a feature later on. On the **Feature Selection** page of the SQL Server setup.exe, select **PolyBase Query Service for External Data**.

:::image type="content" source="../media/polybase-setup-during-sql-server-install.png" alt-text="Image of the setup executable of SQL Server showing the PolyBase option." lightbox="../media/polybase-setup-during-sql-server-install.png":::

PolyBase services require firewall ports to be enabled in order to connect to external data sources.

By default, PolyBase uses ports ranging from 16450 to 16460.

:::image type="content" source="../media/polybase-port-ranges.png" alt-text="Image of the setup executable of SQL Server showing the PolyBase port range configuration.":::

The setup wizard installs two PolyBase services:

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

SQL Server 2022 introduces the new architecture of PolyBase, REST API-based. This new architecture is used to access Azure Data Lake Storage Gen2, Azure Blob Storage, any S3-compatible object Storage, and file formats such as Parquet, Delta, and CSV files.

This new architecture doesn't require PolyBase services to be running or configured, only PolyBase feature enabled on an instance-level using the `sp_configure` option.

For all the other already existing data sources, such as SQL Server, Oracle, MongoDB, or ODBC-based data source, PolyBase uses PolyBase services.

|Data Source |PolyBase services |PolyBase feature REST API |
|---------|---------|---------|
|Azure Blob storage |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |
|Azure Data Lake Storage Gen2 |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |
|S3-compatible object storage |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |
|SQL Server |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: | :::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |
|Oracle |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |
|Teradata |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |
|MongoDB or Cosmos DB API for MongoDB |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |
|Generic ODBC |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |
|Bulk Operations |:::image type="content" source="../media/yes-icon.svg" border="false" alt-text="Yes"::: |:::image type="content" source="../media/no-icon.svg" border="false" alt-text="No"::: |

Regardless of using PolyBase services-only data sources or PolyBase feature data sources, **PolyBase Query Service for External Data** feature needs to be installed.  
