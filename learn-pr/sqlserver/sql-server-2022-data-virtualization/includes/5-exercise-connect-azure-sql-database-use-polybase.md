---
ms.custom:
  - build-2023
---
In this unit, you connect to and create an external table from a database in Azure SQL Database by using the PolyBase services. For this exercise, you:

- Create a database in SQL Server 2022.
- Create a database master key to secure the Azure SQL database scoped credential.
- Create a database scoped credential to access the Azure SQL Database data source.
- Create an external data source by using the database scoped credential.
- Query the external data source using OPENROWSET.
- Create an external table using the external data source.

## Prerequisites

- An Azure SQL database created by using the instructions in [Quickstart: Create a single database - Azure SQL Database](/azure/azure-sql/database/single-database-create-quickstart). For this exercise, name the Azure SQL server `polybaseserver` and the Azure SQL database `polybase2022test`. Be sure to select **Use existing data > Sample** under **Additional settings** when you create the database.

- A SQL Server 2022 instance with PolyBase installed and enabled as for the previous exercise. To connect to another database such as an Azure SQL database, you need to use PolyBase services. Open SQL Server Configuration Manager and make sure the **SQL Server PolyBase Data Movement** and **SQL Server PolyBase Engine** services are running.

## Create a database

In your SQL Server 2022 instance, create a database called `Demo2`, and switch to using that database.

```sql
USE MASTER;
 
IF EXISTS (SELECT * FROM sys.databases WHERE [name] = N'Demo2')
BEGIN
    ALTER DATABASE Demo2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE IF EXISTS Demo2;
END;
 
CREATE DATABASE Demo2;
 
USE Demo2;
```

## Create the database master key

Create a database master key for this new database, as in the previous exercise.

```sql
DECLARE @randomWord VARCHAR(64) = NEWID();
DECLARE @createMasterKey NVARCHAR(500) = N'
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = ''##MS_DatabaseMasterKey##'')
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = '  + QUOTENAME(@randomWord, '''')
EXEC sp_executesql @createMasterKey;
 
SELECT * FROM sys.symmetric_keys;
```

## Create the database scoped credential

Create the database scoped credential to use to connect to your Azure SQL logical server. Replace `<sql_user>` and `<password>` with the username and password for your Azure SQL server.

```sql
CREATE DATABASE SCOPED CREDENTIAL AzureSQLDB
WITH IDENTITY = '<sql_user>', Secret = '<password>';
```

## Create the external data source for Azure SQL Database

Create the external data source pointing to the Azure SQL logical server. You use the `sqlserver://` prefix to connect to the server. In this example, the fully qualified server name is `polybaseserver.database.windows.net`.

```sql
CREATE EXTERNAL DATA SOURCE AzureSQLDB
    WITH ( LOCATION = 'sqlserver://polybaseserver.database.windows.net',
    CREDENTIAL = AzureSQLDB);
```

## Enable ad hoc distributed queries

By default, SQL Server doesn't allow ad hoc distributed queries using OPENROWSET. Run the `sp_configure` command to enable ad hoc distributed queries. For more information, see [ad hoc distributed queries (server configuration option)](/sql/database-engine/configure-windows/ad-hoc-distributed-queries-server-configuration-option).

```sql
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC SP_CONFIGURE N'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
```

## Use OPENROWSET to access the Azure SQL database

Use [OPENROWSET](/sql/t-sql/functions/openrowset-transact-sql) to connect to the `polybase2022test` database in Azure SQL Database and query the `SalesLT.Customer` table. You need to specify a provider. This example uses the MSOLEDBSQL provider, which is installed with SQL Server 2022. You also need to specify the SQL authentication `<user>` and `<password>`

```sql
SELECT
*
FROM OPENROWSET(
N'MSOLEDBSQL',
'Server=polybaseserver.database.windows.net;database=polybase2022test;uid=<user>;pwd=<password>',
'SELECT * FROM SalesLT.Customer'
);
```

## Create an external table from SQL Server 2022 to Azure SQL Database

Now that you verified you can query the external data source, you can create and view an external table called `ext_tblCustomers` from that data source by using the database scoped credential and external data source.

```sql
CREATE EXTERNAL TABLE ext_tblCustomers(
   CustomerID INT
   ,LastName  NVARCHAR(50)
   ,EmailAddress  NVARCHAR(50)
)
WITH 
(LOCATION = N'polybase2022test.SalesLT.Customer'
,DATA_SOURCE = AzureSQLDB);
 
SELECT * FROM ext_tblCustomers;
```

In this unit, you used PolyBase on a SQL Server 2022 instance to query and create an external table from Azure SQL Database. Proceed to the next unit to learn about the CREATE EXTERNAL TABLE AS SELECT (CETAS) command and its benefits.
