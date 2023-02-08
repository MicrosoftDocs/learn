SQL Server 2022 provides data virtualization capabilities to access data stored in formats such as parquet and delta tables over sources such as Azure Blob Storage, Azure Data Lake Storage, and S3 compatible object storage providers. In addition, SQL Server 2022 enhances remote backup and restore capabilities by supporting S3 compatible object storage providers.

## Data virtualization in SQL Server

Polybase, introduced with SQL Server 2016, supports accessing data outside of SQL Server using Transact-SQL (T-SQL) statements like **OPENROWSET** and **CREATE EXTERNAL TABLE**. This concept is known as *data virtualization*, since users can access data outside of SQL Server without moving the data into SQL Server. SQL Server 2019 added support for data virtualization using ODBC drivers. This data access uses software called Polybase services. SQL Server 2022 adds support within the database engine using REST API interfaces to access data in Azure Blob Storage, Azure Data Lake Storage, and S3 compatible object storage providers.

The following figure shows the full extent of data virtualization support in SQL Server 2022.

:::image type="content" source="../media/sql-server-2022-data-virtualization.png" alt-text="Diagram of the data virtualization options in SQL Server 2022.":::

## Data virtualization with REST API connectors

SQL Server 2022 data virtualization now includes access to new data source connectors using REST API interfaces built into the SQL Server engine. These new data source connectors are often used to support a large set of files to build a *data lake*. SQL Server can now be used as a *data hub* to query files in a data lake without moving the data.

### REST API connectors

The following new connectors are supported using REST API:

- Azure Blob Storage

  Using the data source connector `abs`, you can access files stored in Azure Blob Storage containers. Azure Blob Storage is scalable, highly available, redundant, cost effective with tiered storage, secured, and optimized for data lakes. For more information, see [data virtualization with Azure Blob Storage](/sql/relational-databases/polybase/virtualize-csv).

- Azure Data Lake Storage

  Using the data source connector `adls`, you can access file stored in Azure Data Lake Storage (ADLS). ADLS is built on top of Azure Blob Storage and provides file system semantics, file-level security, and scale. All these capabilities are built on top of Azure Blob Storage providing low cost, tiered access, high security, high availability, and durability. For more information, see [data virtualization with Azure Data Lake Storage](/sql/relational-databases/polybase/virtualize-delta).

- S3 compatible object storage providers

  Using the data source connector **s3** you can access file stored in S3 compatible object storage. S3 has become a popular object storage protocol and is supported by many providers, both in clouds and on-premises. S3 object storage offers scale, lower cost, geo-distribution, and a reliable data transport. For more information, see [data virtualization with S3 compatible object storage providers](/sql/relational-databases/polybase/polybase-configure-s3-compatible).

### Using T-SQL for data virtualization

T-SQL provides the following statements to support data virtualization with REST API connectors:

- **OPENROWSET**

  The T-SQL statement **OPENROWSET** allows you to access any REST API data connector ad-hoc, where you supply information about how to connect to the specific data source, file, or folder information.

- **CREATE EXTERNAL TABLE**

  You can use the T-SQL statement **CREATE EXTERNAL TABLE** to create a virtual table that is a mapping to files in any REST API data connector. You can then access the external table just like a SQL Server table except the data is stored in the remote data source. The metadata of the external table is stored in SQL Server system tables.

- **CREATE EXTERNAL TABLE AS SELECT**

  A new capability in SQL Server 2022 is to create an external table based on a query from an existing SQL Server table (or another external table) also known as **CREATE EXTERNAL TABLE AS SELECT**. The result of the query will be a new external table and files will be created to the remote data source based on the results of the SELECT statement. You can use this method to export SQL Server data to files in a remote data source.

### New native file format support

SQL Server allows you to create a file format to define the structure of a file in a remote data source. You would use file formats to define the structure of a JSON file, since JSON isn't a native supported file format. SQL Server 2022 now recognizes native file formats **parquet** and **delta tables**.

- **Parquet**

  Parquet is an open-source binary file format with the schema built into the file. Parquet files use a columnar storage format making them efficient for compression and retrieval. For more information and examples, see [Virtualize parquet file in a S3-compatible object storage with PolyBase](/sql/relational-databases/polybase/polybase-virtualize-parquet-file).

- **Delta tables**

  Delta lake is an open-source storage architecture using delta tables. Delta tables are files based on parquet but also offer basic transaction and log support. For more information on how to use delta tables with Azure Data Lake Storage, see [Virtualize delta table with PolyBase](/sql/relational-databases/polybase/virtualize-delta).

## Backup and restore with S3 compatible object storage providers

SQL Server 2022 extends the **BACKUP TO URL** and **RESTORE FROM URL** T-SQL statements to support S3 compatible object storage providers. Most backup and restore options are available using this new capability. For more information, see [SQL Server backup to URL for S3-compatible object storage](/sql/relational-databases/backup-restore/sql-server-backup-to-url-s3-compatible-object-storage). 

For a list of common S3 compatible object storage providers, see [Providers of S3-compatible object storage](/sql/relational-databases/backup-restore/sql-server-backup-and-restore-with-s3-compatible-object-storage#providers-of-s3-compatible-object-storage).
