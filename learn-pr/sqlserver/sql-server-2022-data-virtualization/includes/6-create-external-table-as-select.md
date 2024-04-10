---
ms.custom:
  - build-2023
---
In this unit, we want to take a closer look at the command, CREATE EXTERNAL TABLE as SELECT (CETAS) and the benefits it provides.

CETAS supports Azure Blob Storage, Azure Data Lake Storage Gen 2, and S3-compatible object storage. CETAS also supports exporting file formats as either a CSV or Parquet file. CETAS most powerful capability relies on combining it with other SELECT operations, such as in combination with OPENROWSET, or other external tables. This combination allows CETAS to be used in different and flexible ways.

## Use cases for CETAS

There are many different use cases for CETAS, but the three major ones are:

- Reporting
- Data tiering or off-loading
- Data exporting hub

### Reporting

The most obvious use case for CETAS is to simplify data export by using all the already discussed capabilities of PolyBase and SQL Server flexibility. You can connect to any supported data source, table or file, and use T-SQL to manipulate and export the results. For example, instead of having reporting tools connecting to SQL Server, you can use CETAS to perform all the necessary queries, export the result as a Parquet file, and point the reporting tool to the exported data.

### Data tiering or off-loading

Another common scenario is exporting archive or read-only data out of SQL Server's tables to a remote storage, but still query it normally through external tables. This way, you can keep only the active data on SQL Server, saving resources, but still access the data whenever needed and in a transparent way. From an application point of view, it's just like accessing a regular SQL Server table. For example, let’s say your `order` table has historical data of past years that don't change, but it's still needed to be fully accessible when needed. CETAS can help export all `order` table data to another location, helping reduce the database size, and the required maintenance time. With an external table, the exported data would behave just like a regular table.

### Data exporting hub

By using SQL Server 2022 as a data hub, you can combine CETAS capabilities with all the other known PolyBase capabilities, including the ability to connect to other data sources. Data sources like Oracle, Teradata, ODBC, or even other versions of SQL Server.

## How to enable CETAS

Before we can use CETAS, we need to enable the property `allow polybase export` through `sp_configure`:

```sql
sp_configure 'allow polybase export', 1
RECONFIGURE
GO
sp_configure 'allow polybase export'
```

:::image type="content" source="../media/allow-polybase-export.png" alt-text="Screenshot of SSMS configuring the option allow polybase export.":::

### Permissions for CETAS

In order to use CETAS, you need permission on three different levels:

- Permission to access and read the source of the data.
  - If the data resides outside of SQL Server, either on a network share or another database server, the SQL Server service account must have permissions to access the data source.
- Permission on SQL Server 2022 for the user to use the CETAS command.
  - In order for the database user to execute the CETAS command, they need the **ADMINISTER BULK OPERATIONS**, **ALTER ANY EXTERNAL DATA SOURCE**, and **ALTER ANY EXTERNAL FILE FORMAT** permissions.
- Permission on the destination in which you'll write the result of CETAS.
  - To be able to write to the destination of the CETAS command, Parquet, or CSV file, you'll need *write* permissions on the destination. For example, to write to an Azure Blob Storage or Azure Data Lake Storage Gen2, you'll need the **LIST**, **READ**, **CREATE**, and **WRITE** permissions on those destinations.

For more information about permissions for CETAS, see [CREATE EXTERNAL TABLE AS SELECT (CETAS) Permissions](/sql/t-sql/statements/create-external-table-as-select-transact-sql#permissions).

## CETAS supported formats

As previously mentioned, CETAS receives a stream of data, using a SELECT command as an input, and exports the results. CETAS exports the results in CSV or Parquet format, but the input supports all formats that a SELECT command would, including using OPENROWSET results.

The input can be a table running locally on your SQL Server instance, a network file that is accessed through an OPENROWSET operation, a table in another database system, or even the Delta file stored on Azure Blob Storage, Azure Data Lake Storage Gen2, or an S3-compatible object storage.

- For a complete list of supported format, see [CREATE EXTERNAL FILE FORMAT](/sql/t-sql/statements/create-external-file-format-transact-sql).

- For a complete list of supported data sources, see [CREATE EXTERNAL DATA SOURCE](/sql/t-sql/statements/create-external-data-source-transact-sql).

- To learn about accessing remote files using OPENROWSET, see the article [OPENROWSET](/sql/t-sql/functions/openrowset-transact-sql).

## CETAS T-SQL structure

CETAS T-SQL structure follows a bottom-up logic approach. That means it's easier to start by the end the statement, and then work our way to the top of the T-SQL statement. To better understand CETAS, let's break down the overall T-SQL syntax.

:::image type="content" source="../media/create-external-table-as-select-t-sql-structure.png" alt-text="Image of the T-SQL structure of CREATE EXTERNAL TABLE as SELECT statement.":::

1. The bottom of the CETAS structure contains a SELECT statement, and is used to define what data will be exported.
   - In the middle, there's optional parameters that can be used to reject data that we don't want to export.
1. At the top of the CETAS statement, after declaring CREATE EXTERNAL TABLE, you'll add information about the destination location, filename, and file format.

As we can see, this structure allows CETAS to be combined with any SELECT statement, querying data outside SQL Server, within SQL Server, or any other supported database. SQL Server 2022 will automatically create the file name, and split the results in multiple files for optimization purposes. For example, a table when exported as a Parquet can generate several files depending on the exported data size. Also, the external table column definition and type will be defined by the select statement itself.

### Exporting table from SQL Server as Parquet

Here's an example of using CETAS to export a table from SQL Server as Parquet:

```sql
CREATE EXTERNAL TABLE ext_sales
WITH (
      LOCATION = '/cetas',
      DATA_SOURCE = s3_eds,
      FILE_FORMAT = ParquetFileFormat
     ) AS

SELECT *
FROM AdventureWorks2019.[Sales].[SalesOrderDetail];
GO
```

### Reading a delta file and exporting as Parquet

Here's an example of using CETAS to read a delta file and exporting as Parquet:

```sql
CREATE EXTERNAL TABLE Delta_to_Parquet
WITH (
        LOCATION = '/backup/sales',
        DATA_SOURCE = s3_parquet,
        FILE_FORMAT = ParquetFileFormat
      ) AS

SELECT *
FROM OPENROWSET(BULK '/delta/sales_fy22/', 
FORMAT = 'DELTA', 
DATA_SOURCE = 's3_delta') AS [r];
GO
```
