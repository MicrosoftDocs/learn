---
ms.custom:
  - build-2023
---
This unit takes a closer look at the CREATE EXTERNAL TABLE AS SELECT (CETAS) command and the benefits it provides.

CETAS supports Azure Blob Storage, Azure Data Lake Storage, S3-compatible object storage, and external databases. CETAS also supports exporting file formats as either CSV or Parquet files.

CETAS' most powerful capability is to combine with other SELECT operations, such as combining with OPENROWSET or with other external tables. This combination allows CETAS to be used in different and flexible ways.

## Use cases for CETAS

There are many different use cases for CETAS, but the three major ones are:

- Reporting
- Data tiering or offloading
- Data export hub

### Reporting

The most obvious use case for CETAS is to simplify reporting by using all the capabilities of PolyBase and SQL Server flexibility. You can connect to any supported data source, table, or file, and use T-SQL to manipulate and export the results. For example, instead of connecting reporting tools to SQL Server, you can use CETAS to perform all the necessary queries, export the result as a Parquet file, and point the reporting tool to the exported data.

### Data tiering or offloading

Another common scenario is exporting archive or read-only data out of SQL Server tables to remote storage, but still querying it normally through external tables. This way, you can keep only the active data on SQL Server, saving resources, but still access the data in a transparent way whenever needed. From an application point of view, it's just like accessing a regular SQL Server table.

For example, imagine your `order` table has historical data of past years that doesn't change, but you still need it to be fully accessible. CETAS can help export all `order` table data to another location, reducing database size and required maintenance time. With an external table, the exported data behaves just like a regular table.

### Data export hub

By using SQL Server 2022 as a data hub, you can combine CETAS with all existing PolyBase capabilities, including connecting to other data sources like Oracle, Teradata, ODBC, or other versions of SQL Server.

## CETAS requirements

To use CETAS in SQL Server 2022, you need to enable the property `ALLOW POLYBASE EXPORT` by using `sp_configure`. For details, see the next exercise.

###  CETAS permissions

To use CETAS, you need three different levels of permission:

- Permission to access and read the data source.
  If the data resides outside of SQL Server, either on a network share or another database server, the SQL Server service account must have permission to access the data source.

- Permission on SQL Server 2022 to use the CETAS command.
  For the database user to execute the CETAS command, they need **ADMINISTER BULK OPERATIONS**, **ALTER ANY EXTERNAL DATA SOURCE**, and **ALTER ANY EXTERNAL FILE FORMAT** permissions.

- Write permission on the destination to write the CETAS results.
  To be able to write to the destination, Parquet, or CSV file, the user needs write permissions on the destination. For example, to write to Azure Blob Storage or Azure Data Lake Storage, the user needs **LIST**, **READ**, **CREATE**, and **WRITE** permissions on those destinations.

For more information about permissions for CETAS, see [CREATE EXTERNAL TABLE AS SELECT (CETAS) permissions](/sql/t-sql/statements/create-external-table-as-select-transact-sql#permissions).

## CETAS supported formats

CETAS receives a stream of data, using a SELECT command as input, and exports the results in CSV or Parquet format. The input supports the same formats as a SELECT command, including OPENROWSET results.

The input can be a table running locally on your SQL Server instance, a network file that's accessed through an OPENROWSET operation, a table in another database system, or a Delta file stored on Azure Blob Storage, Azure Data Lake Storage, or S3-compatible object storage.

- For a complete list of supported formats, see [CREATE EXTERNAL FILE FORMAT](/sql/t-sql/statements/create-external-file-format-transact-sql).
- For a complete list of supported data sources, see [CREATE EXTERNAL DATA SOURCE](/sql/t-sql/statements/create-external-data-source-transact-sql).
- To learn about accessing remote files by using OPENROWSET, see [OPENROWSET](/sql/t-sql/functions/openrowset-transact-sql).

## CETAS T-SQL structure

To better understand CETAS, you can break down the overall T-SQL syntax. CETAS T-SQL structure follows a bottom-up logic approach. It's easier to start at the end of the statement, and then work your way to the top of the T-SQL statement.

:::image type="content" source="../media/create-external-table-as-select-t-sql-structure.png" alt-text="Image of the T-SQL structure of CREATE EXTERNAL TABLE as SELECT statement." border="false":::

- The bottom of the CETAS structure contains a SELECT statement you use to define what data to export.
- In the middle, there are optional parameters you can use to reject data that you don't want to export.
- At the top of the CETAS statement, after declaring CREATE EXTERNAL TABLE, you add information about the destination location, filename, and file format.

This structure allows CETAS to be combined with any SELECT statement to query data outside SQL Server, within SQL Server, or from any other supported database. SQL Server 2022 automatically creates the file name and splits the results in multiple files for optimization. For example, a table exported as a Parquet can generate several files, depending on the exported data size. The select statement defines the external table column definition and type.

### Export a table from SQL Server as Parquet

The following example uses CETAS to export a table from SQL Server as Parquet:

```sql
CREATE EXTERNAL TABLE ext_sales
WITH (
      LOCATION = '/cetas',
      DATA_SOURCE = s3_eds,
      FILE_FORMAT = ParquetFileFormat
     ) AS
SELECT *
FROM AdventureWorks2022.[Sales].[SalesOrderDetail];
```

### Read a Delta file and export as Parquet

The following example uses CETAS to read a Delta file and export it as Parquet:

```sql
CREATE EXTERNAL TABLE Delta_to_Parquet
WITH (
        LOCATION = N'/backup/sales',
        DATA_SOURCE = s3_parquet,
        FILE_FORMAT = ParquetFileFormat
      ) AS
SELECT *
FROM OPENROWSET(BULK N'/delta/sales_fy22/',
FORMAT = 'DELTA',
DATA_SOURCE = 's3_delta') AS [r];
```
In the next exercise, you use CETAS to:

- Export a table as Parquet.
- Move cold data out of a database into storage.
- Create an external table to access stored data.
- Use views, wildcard search, folder elimination, and metadata as query strategies.
