---
ms.custom:
  - build-2023
---
Now that we have a better understanding of the principles of data virtualization and its operators, it's important to understand how security and connectivity work. We'll go over the objects used with PolyBase.

Even though the PolyBase feature needs to be enabled on an instance level, PolyBase operators (for example, *OPENROWSET*, *CET*, and *CETAS*) and objects works on a database level. Every data source, external file format, and external credential are tied to a particular database.

The following illustrates the database relationship with PolyBase objects.

:::image type="content" source="../media/polybase-objects.png" alt-text="An image of PolyBase objects in SQL Server.":::

- **External file format:** The CREATE EXTERNAL FILE FORMAT command is used to define how SQL Server works with a particular file type. External file format determines the type of file, field terminator, delimiter, compression, encoding and much more. For more information, see [CREATE EXTERNAL FILE FORMAT (Transact-SQL)](/sql/t-sql/statements/create-external-file-format-transact-sql).

- **External table:** The CREATE EXTERNAL TABLE command creates a virtual table pointing to the external source of data that is either a file or another database table. Whenever this table is used, SQL Server fetches the data from the source. This grants both users and applications the same level of flexibility of working with a regular table without the complexity of administering the original data. For more information, see [CREATE EXTERNAL TABLE (Transact-SQL)](/sql/t-sql/statements/create-external-table-transact-sql).

- **External data source:** The CREATE EXTERNAL DATA SOURCE command creates a data source that holds the required information to access an external data source. The external data source can be a storage location (for example, Azure Blob storage, Azure Data Lake Storage Gen2, or S3-compatible object storage) or another database server. For more information, see [CREATE EXTERNAL DATA SOURCE (Transact-SQL)](/sql/t-sql/statements/create-external-data-source-transact-sql).

- **Database scoped credential:** The CREATE DATABASE SCOPED CREDENTIAL command creates a credential that holds the credential information used by the external data source. For more information, see
[CREATE DATABASE SCOPED CREDENTIAL (Transact-SQL)](/sql/t-sql/statements/create-database-scoped-credential-transact-sql).

- **Database master key:** The database master key (DMK) is a symmetric key used to protect the private keys of certificates and asymmetric keys that are present in the database. The DMK is used as a security mechanism to safely store all the external credential and data source information. For more information, see [CREATE MASTER KEY (Transact-SQL)](/sql/t-sql/statements/create-master-key-transact-sql).

Another way of understanding PolyBase workflow is through the diagram below:

:::image type="content" source="../media/polybase-workflow.png" alt-text="An image of PolyBase workflow.":::

## Supported PolyBase data sources

| External Data Source | Connector location prefix | Location path | Authentication |
|--|--|--|--|
| Azure Storage Account (V2) | abs | `abs://<storage_account_name>.blob.core.windows.net/<container_name>` | Shared access signature (SAS) |
| Azure Data Lake Storage Gen2 | adls | `adls://<storage_account_name>.dfs.core.windows.net/<container_name>` | Shared access signature (SAS) |
| SQL Server | sqlserver | `<server_name>[\<instance_name>][:port]` | SQL authentication only |
| Oracle | oracle | `<server_name>[:port]` | Basic authentication only |
| Teradata | teradata | `<server_name>[:port]` | Basic authentication only |
| MongoDB or Cosmos DB API for MongoDB | mongodb | `<server_name>[:port]` | Basic authentication only |
| Generic ODBC | odbc | `<server_name>[:port]` | Basic authentication only |
| Bulk Operations | https | `<storage_account>.blob.core.windows.net/<container>` | Shared access signature (SAS) |
| S3-compatible object storage | s3 | `s3://<server_name>:<port>/` |  |

It's important to understand that the **Connector location prefix** is what is used to inform SQL Server of the type of endpoint you're expected to connect to. For example, if you want to connect to an Azure Blob storage account, you’ll use `abs`, but to connect to an Oracle server, you'll use `oracle`.

Some prefixes changed from previous version of SQL Server for compatibility reasons. For more information, see [CREATE EXTERNAL DATA SOURCE (Transact-SQL)](/sql/t-sql/statements/create-external-data-source-transact-sql).

## Supported file formats for PolyBase

SQL Server 2022 supports the following file formats:

- CSV
- Parquet
- Delta (read-only)
- Delimited text

For Delta files, SQL Server can read it, but it can't export a table result as Delta.

## OPENROWSET, CET, and CETAS

PolyBase uses three operators to query or virtualize the data:

- **OPENROWSET**: OPENROWSET is a lightweight command that allows the SQL engine to access data outside of SQL Server, either a file or another database. OPENROWSET is recommended for loading data or data exploration, optimized for ad-hoc execution. For more information, see [OPENROWSET (Transact-SQL)](/sql/t-sql/functions/openrowset-transact-sql).

- **CREATE EXTERNAL TABLE (CET):** The CET command creates a table where the data stays in its original location outside of SQL Server. When the table is selected, the SQL engine provides the requested data to the user. External table benefits from reusability and can leverage the use of statistics for better performance. For more information, see [CREATE EXTERNAL TABLE (Transact-SQL)](/sql/t-sql/statements/create-external-table-transact-sql).

- **CREATE EXTERNAL TABLE as SELECT (CETAS):** CETAS performs a combination of operations in a single command. First, CETAS allows SQL Server to transform and convert a given data stored inside or outside the database. Second, it then exports the data to a different location, either a network location or Azure. Finally, it creates an external table targeting the newly exported data. We'll go over CETAS and its use cases in a later unit. For more information, see [CREATE EXTERNAL TABLE AS SELECT (Transact-SQL)](/sql/t-sql/statements/create-external-table-as-select-transact-sql).
