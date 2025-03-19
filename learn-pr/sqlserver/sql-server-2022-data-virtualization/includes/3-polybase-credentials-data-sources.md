---
ms.custom:
  - build-2023
---
Now that you understand the principles of data virtualization and PolyBase, it's important to understand security and connectivity. This unit describes the objects and operators used with PolyBase.

Although the PolyBase feature is enabled on a SQL Server instance level, PolyBase objects and operators like OPENROWSET, CET, and CETAS work on a database level. Every data source, external file format, and external credential is tied to a particular database.

The following diagram illustrates the database relationship with PolyBase objects.

:::image type="content" source="../media/polybase-objects.png" alt-text="An image of PolyBase objects in SQL Server." border="false":::

- **Master key:** The database master key (DMK) is a symmetric key used to protect the private keys of certificates and asymmetric keys that are present in the database. The DMK is a security mechanism to safely store all the external credential and data source information. For more information, see [CREATE MASTER KEY (Transact-SQL)](/sql/t-sql/statements/create-master-key-transact-sql).

- **Database scoped credential:** The CREATE DATABASE SCOPED CREDENTIAL command creates a credential that holds the credential information used by the external data source. For more information, see [CREATE DATABASE SCOPED CREDENTIAL (Transact-SQL)](/sql/t-sql/statements/create-database-scoped-credential-transact-sql).

- **External data source:** The CREATE EXTERNAL DATA SOURCE command creates a data source that holds the required information to access an external data source. The external data source can be another database server, or a storage location such as Azure Blob storage, Azure Data Lake Storage, or S3-compatible object storage. For more information, see [CREATE EXTERNAL DATA SOURCE (Transact-SQL)](/sql/t-sql/statements/create-external-data-source-transact-sql).

- **External table:** The CREATE EXTERNAL TABLE command creates a virtual table pointing to the external data source that's either a file or another database table. Whenever this table is used, SQL Server fetches the data from the source. This command grants users and applications the same level of flexibility as working with a regular table without the complexity of administering the original data. For more information, see [CREATE EXTERNAL TABLE (Transact-SQL)](/sql/t-sql/statements/create-external-table-transact-sql).

- **External file format:** The CREATE EXTERNAL FILE FORMAT command defines how SQL Server works with a particular file type. External file format determines the type of file, field terminator, delimiter, compression, and encoding. For more information, see [CREATE EXTERNAL FILE FORMAT (Transact-SQL)](/sql/t-sql/statements/create-external-file-format-transact-sql).

Another way of understanding PolyBase workflow is through the following diagram:

:::image type="content" source="../media/polybase-workflow.png" alt-text="An image of PolyBase workflow." lightbox="../media/polybase-workflow.png" border="false":::

## Supported PolyBase data sources

The **Connector location prefix** informs SQL Server of the type of endpoint you expect to connect to. For example, if you want to connect to an Azure Blob storage account, you use `abs`, but to connect to an Oracle server, you use `oracle`.

| External data source | Connector location prefix | Location path | Authentication |
|--|--|--|--|
| Azure Blob Storage | `abs` | `abs://<storage_account_name>.blob.core.windows.net/<container_name>` | Shared access signature (SAS) |
| Azure Data Lake Storage | `adls` | `adls://<storage_account_name>.dfs.core.windows.net/<container_name>` | SAS |
| SQL Server | `sqlserver` | `<server_name>[\<instance_name>][:port]` | SQL authentication only |
| Oracle | `oracle` | `<server_name>[:port]` | Basic authentication only |
| Teradata | `teradata` | `<server_name>[:port]` | Basic authentication only |
| MongoDB or Azure Cosmos DB API for MongoDB | `mongodb` | `<server_name>[:port]` | Basic authentication only |
| Generic Open Database Connectivity (ODBC) | `odbc` | `<server_name>[:port]` | Basic authentication only |
| Bulk operations | `https` | `<storage_account>.blob.core.windows.net/<container>` | SAS |
| S3-compatible object storage | `s3` | `s3://<server_name>:<port>/` |  |

Some prefixes changed from previous version of SQL Server for compatibility reasons. For a complete list of data sources and corresponding prefixes, see [CREATE EXTERNAL DATA SOURCE](/sql/t-sql/statements/create-external-data-source-transact-sql?view=sql-server-ver16&preserve-view=true&tabs=dedicated#location--prefixpathport-3).

## Supported file formats for PolyBase

SQL Server 2022 supports the following file formats:

- CSV
- Parquet
- Delimited text
- Delta (read-only). SQL Server can read Delta files, but can't export a table result as Delta.

## OPENROWSET, CET, and CETAS

PolyBase uses three operators to query or virtualize data. This training module covers these commands and their use cases.

- **OPENROWSET** is a lightweight command that allows the SQL engine to access data outside of SQL Server, either a file or another database. OPENROWSET is optimized for ad-hoc execution and recommended for loading data or data exploration. For more information, see [OPENROWSET (Transact-SQL)](/sql/t-sql/functions/openrowset-transact-sql).

- **CREATE EXTERNAL TABLE (CET)** creates a table where the data stays in its original location outside of SQL Server. When the table is selected, the SQL engine provides the requested data to the user. The external table benefits from reusability and can use statistics for better performance. For more information, see [CREATE EXTERNAL TABLE (Transact-SQL)](/sql/t-sql/statements/create-external-table-transact-sql).

- **CREATE EXTERNAL TABLE AS SELECT (CETAS)** performs a combination of operations in a single command. First, CETAS allows SQL Server to transform and convert given data stored inside or outside the database. CETAS then exports the data to a different location, either a network location or Azure. Finally, CETAS creates an external table targeting the newly exported data. For more information, see [CREATE EXTERNAL TABLE AS SELECT (Transact-SQL)](/sql/t-sql/statements/create-external-table-as-select-transact-sql).
