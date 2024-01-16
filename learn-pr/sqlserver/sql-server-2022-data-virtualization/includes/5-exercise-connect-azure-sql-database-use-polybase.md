---
ms.custom:
  - build-2023
---
Continuing from the previous exercise, you'll now connect and create an external table from a database in Azure SQL Database using PolyBase. For this exercise, you'll:

- Create a database called `Demo2` in SQL Server 2022.
- Create a database master key to secure the database scoped credential.
- Create a database scoped credential to access the data source.
- Create the external data source using the database scoped credential.
- Query the data source using OPENROWSET.
- Create an external table using the external data source.  

## Prerequisite

- In addition to the prerequisites established in the previous exercise, you need to have an Azure SQL Database to complete this exercise. If you don't have a logical server and database in Azure SQL Database, you can create one using the article, [Quickstart: Create a single database - Azure SQL Database](/azure/azure-sql/database/single-database-create-quickstart).
- In order to connect to another database, we need the PolyBase services to be running. Make sure the **SQL Server PolyBase Data Movement** and **SQL Server PolyBase Engine** services are running in SQL Server Configuration Manager.

- For this exercise, we assume the following Azure SQL Database resource information:

  - Name of logical server in Azure SQL Database: `polybaseserver`
  - Name of database: `polybase2022test`
  - Name of table: `tblAuthors`

## Create a database

In your SQL Server 2022 instance, create another database called `Demo2` and switch to the context of using that database.

```sql
USE MASTER
GO
IF EXISTS (SELECT * FROM sys.databases WHERE [name] = 'Demo2')
BEGIN
    ALTER DATABASE Demo2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE IF EXISTS Demo2
END
GO
CREATE DATABASE Demo2
GO

USE Demo2
GO
```

## Create the database master key

We'll create a database master key, like we did in the previous exercise, but for this new database.

```sql
DECLARE @randomWord VARCHAR(64) = NEWID();
DECLARE @createMasterKey NVARCHAR(500) = N'
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = ''##MS_DatabaseMasterKey##'')
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = '  + QUOTENAME(@randomWord, '''')
EXECUTE sp_executesql @createMasterKey
GO
SELECT * FROM sys.symmetric_keys
GO
```

## Create the database scoped credential

Create the database scoped credential that will be used to connect to your logical server in Azure SQL Database. The username and password should be the SQL user and password used to access your logical server in Azure SQL Database.

```sql
CREATE DATABASE SCOPED CREDENTIAL AzureSQLDB
WITH IDENTITY = '<sql_user>', Secret = '<password>;
GO
```

## Create the external data source for Azure SQL Database

Create the external data source pointing to the logical server. We’ll use the `sqlserver://` prefix to connect to the logical server. In this example, the fully qualified server name is `polybaseserver.database.windows.net`.

```sql
CREATE EXTERNAL DATA SOURCE AzureSQLDB
    WITH ( LOCATION = 'sqlserver://polybaseserver.database.windows.net',
    CREDENTIAL = AzureSQLDB);
GO
```

## Enable ad hoc distributed queries

To enable ad hoc distributed queries, use the `sp_configure` command to change the setting. For more information, see [ad hoc distributed queries Server Configuration Option](/sql/database-engine/configure-windows/ad-hoc-distributed-queries-server-configuration-option)

```sql
SP_CONFIGURE 'Ad Hoc Distributed Queries',1
RECONFIGURE
```

## Use OPENROWSET to access the database in Azure SQL Database

We'll be using [OPENROWSET](/sql/t-sql/functions/openrowset-transact-sql) to connect to the `polybase2022test` database in Azure SQL Database, and query the `tblAuthors` table. We need to specify a provider. In this example, we're using the MSOLEDBSQL provider, which should be installed with SQL Server 2022. We also need to specify the SQL authentication user and password in this example.

```sql
SELECT 
* 
FROM OPENROWSET(
'MSOLEDBSQL',
'Server=polybaseserver.database.windows.net;database=polybase2022test;uid=<user>;pwd=<Password>',
'SELECT * FROM tblAuthors'
) 
GO
```

## Create an external table from SQL Server 2022 to Azure SQL Database

Now that we know that we can query the external data source using OPENROWSET, we can create an external table (`ext_tblAuthors`) from that data source using the database scoped credential and external data source created previously.

```sql
CREATE EXTERNAL TABLE ext_tblAuthors(
	id INT
	,Author_name  NVARCHAR(50)
	,country  NVARCHAR(50)
)
WITH
(LOCATION = 'polybase2022test.dbo.tblAuthors'
,DATA_SOURCE = AzureSQLDB)
GO
SELECT * FROM ext_tblAuthors
```

Congratulations, you've now used PolyBase on a SQL Server 2022 instance to query and create an external table from Azure SQL Database.
