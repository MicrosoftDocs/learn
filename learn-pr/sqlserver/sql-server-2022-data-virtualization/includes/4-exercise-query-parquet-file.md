---
ms.custom:
  - build-2023
---
In this exercise, you: 

- Install and enable PolyBase.
- Create a database.
- Create a database master key to secure the database scoped credential.
- Create a database scoped credential to access the data source.
- Create the data source.
- Query and manipulate data stored on the public data source.
- Create an external file format and external table.

## Install PolyBase

You can install PolyBase with the SQL Server installation executable during initial setup, or add it as a feature later. On the **Feature Selection** page of SQL Server *setup.exe*, select **PolyBase Query Service for External Data**.

:::image type="content" source="../media/polybase-setup-during-sql-server-install.png" alt-text="Image of the setup executable of SQL Server showing the PolyBase option." lightbox="../media/polybase-setup-during-sql-server-install.png":::

PolyBase services require firewall ports to be enabled in order to connect to external data sources. By default, PolyBase uses ports ranging from 16450 to 16460.

:::image type="content" source="../media/polybase-port-ranges.png" alt-text="Image of the setup executable of SQL Server showing the PolyBase port range configuration.":::

PolyBase setup installs two PolyBase services, **SQL Server PolyBase Engine** and **SQL Server PolyBase Data Movement**. For complete information and prerequisites for PolyBase installation, see:

- [Install PolyBase on Windows](/sql/relational-databases/polybase/polybase-installation)
- [Install PolyBase on Linux](/sql/relational-databases/polybase/polybase-linux-setup)

## Enable PolyBase

Once you install the service, connect to your SQL Server 2022 instance in SQL Server Management Studio (SSMS) and run the following command to enable PolyBase.

```sql
EXEC SP_CONFIGURE @CONFIGNAME = N'POLYBASE ENABLED', @CONFIGVALUE = 1;
RECONFIGURE;
```

:::image type="content" source="../media/enable-polybase-t-sql.png" alt-text="An image of enabling PolyBase using T-SQL in SQL Server Management Studio.":::

> [!NOTE]
> In this exercise, you query Apache Parquet files by using the PolyBase REST API, so you don't need to enable or configure the **SQL Server PolyBase Data Movement** or **SQL Server PolyBase Engine** services.

## Create a database

Run the following command in SSMS to create a database for this exercise named `Demo1`. If the database was already created, the script drops and recreates it.

```sql
USE MASTER;

IF EXISTS (SELECT * FROM sys.databases WHERE [name] = N'Demo1')
BEGIN
    ALTER DATABASE Demo1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE IF EXISTS Demo1
END;

CREATE DATABASE Demo1;

USE Demo1;
```

## Create the database master key

You must create a database master key to ensure database scoped credential security. The following example creates the key with a randomly generated password, and a backup is required.

```sql
DECLARE @randomWord VARCHAR(64) = NEWID();
DECLARE @createMasterKey NVARCHAR(500) = N'
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = ''##MS_DatabaseMasterKey##'')
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = '  + QUOTENAME(@randomWord, '''')
EXECUTE sp_executesql @createMasterKey;

SELECT * FROM sys.symmetric_keys;
```

To better understand and maintain encryption keys on a production environment, see:

- [CREATE MASTER KEY (Transact-SQL)](/sql/t-sql/statements/create-master-key-transact-sql)
- [Encryption hierarchy](/sql/relational-databases/security/encryption/encryption-hierarchy)

## Create the database scoped credential

The database scoped credential is responsible for storing the credentials the data source uses to connect to the endpoint. This example uses a public endpoint, so the credential doesn't need a secret.

```sql
IF EXISTS (SELECT * FROM sys.database_scoped_credentials WHERE name = N'PublicCredential')
    DROP DATABASE SCOPED CREDENTIAL PublicCredential;
 
CREATE DATABASE SCOPED CREDENTIAL PublicCredential
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = '<KEY>'; -- This example doesn't need the SECRET because the data source is public
```

## Create the data source

This example uses a publicly available COVID Parquet dataset stored in Azure Blob Storage. You use the database scoped `PublicCredential` you created to establish the connection.

LOCATION values:

- Prefix: `abs`
- Azure Storage account: `pandemicdatalake`
- Azure Storage account full path: `pandemicdatalake.blob.core.windows.net`
- Container name: `public`
- Container full path: `public/curated/covid-19/bing_covid-19_data/latest`

```sql
IF EXISTS (SELECT * FROM sys.external_data_sources WHERE name = N'Public_Covid') DROP EXTERNAL DATA SOURCE Public_Covid;
 
CREATE EXTERNAL DATA SOURCE Public_Covid
WITH (
    LOCATION = 'abs://pandemicdatalake.blob.core.windows.net/public/curated/covid-19/bing_covid-19_data/latest',
    CREDENTIAL = [PublicCredential]
);
```

- For a complete list of data sources and corresponding prefixes, see [CREATE EXTERNAL DATA SOURCE](/sql/t-sql/statements/create-external-data-source-transact-sql?view=sql-server-ver16&preserve-view=true&tabs=dedicated#location--prefixpathport-3).
- For more information on the public dataset, see [Bing COVID-19](/azure/open-datasets/dataset-bing-covid-19).

## Query the data with OPENROWSET

You can use OPENROWSET to access and explore the data. OPENROWSET is optimized for ad-hoc workload and data exploration scenarios.

OPENROWSET values:

- BULK: File name and extension. BULK automatically appends to the data source information, so the full file location is `abs://pandemicdatalake.blob.core.windows.net/public/curated/covid-19/bing_covid-19_data/latest/bing_covid-19_data.parquet`
- FORMAT: `PARQUET`
- DATA_SOURCE: Connection information, in this case your new data source `Public_Covid`

```sql
SELECT TOP 1000 *
FROM OPENROWSET 
     (BULK 'bing_covid-19_data.parquet'
     , FORMAT = 'PARQUET'
     , DATA_SOURCE = 'Public_Covid')
     AS [COVID_Dataset]
```

The following example uses T-SQL flexibility to query the Parquet file in real time, just like a regular table. To return the number of confirmed cases per US state in descending order, execute the following query:

```sql
SELECT [COVID_Dataset].admin_region_1, 
       SUM(CAST([COVID_Dataset].confirmed AS BIGINT)) AS Confirmed
FROM OPENROWSET 
     (BULK 'bing_covid-19_data.parquet'
     , FORMAT = 'PARQUET'
     , DATA_SOURCE = 'Public_Covid')
     AS [COVID_Dataset]
WHERE [COVID_Dataset].country_region = 'United States' AND 
      [COVID_Dataset].admin_region_1  IS NOT NULL
GROUP BY [COVID_Dataset].admin_region_1 
ORDER BY confirmed DESC
```

## Create and query an external table

OPENROWSET is optimized for ad-hoc execution and data exploration. External tables are better suited for recurring access, because they can also use statistics.

### Discover the schema of the external table

To create an external table, first determine the columns and type. The schema comes from an external file, so it might be time consuming to precisely determine the data types and ranges. Fortunately, you can use the stored procedure [sp_describe_first_result_set (Transact-SQL)](/sql/relational-databases/system-stored-procedures/sp-describe-first-result-set-transact-sql) to speed up this process.

```sql
DECLARE @tsql NVARCHAR(MAX) = 'SELECT TOP 1000 *
FROM OPENROWSET 
    (BULK ''bing_covid-19_data.parquet''
    , FORMAT = ''PARQUET''
    , DATA_SOURCE = ''Public_Covid'')
    AS [COVID_Dataset]';
EXEC sys.sp_describe_first_result_set @tsql;
```

:::image type="content" source="../media/schema-discovery.png" alt-text="Image of the schema results of the external Parquet data source in SQL Server Management Studio.":::

You can see that `sp_describe_first_result_set` returned the column names, types, length, precision, and even the collation of the data source.

### Create the external file format

Because you have to reference the Parquet file to the external table, you first need to run `CREATE EXTERNAL FILE FORMAT` to add the Parquet file format. The file format definition is important for external tables because it specifies the actual layout and compression type.

Run the following command:

```sql
IF EXISTS (SELECT * FROM sys.external_file_formats WHERE name = N'ParquetFileFormat')
      DROP EXTERNAL FILE FORMAT ParquetFileFormat;

CREATE EXTERNAL FILE FORMAT ParquetFileFormat WITH(FORMAT_TYPE = PARQUET);
```

### Create the external table

Finally, with all the information you just acquired, and the external file format created, you can create the external table by using the following script:

```sql
IF EXISTS (SELECT * FROM sys.external_file_formats WHERE name = N'ParquetFileFormat')
      DROP EXTERNAL FILE FORMAT ParquetFileFormat;
 
CREATE EXTERNAL FILE FORMAT ParquetFileFormat WITH(FORMAT_TYPE = PARQUET);
 
-- 8.3 CREATE EXTERNAL TABLE
IF OBJECT_ID(N'ext_covid_data', N'ET') IS NOT NULL
      DROP EXTERNAL TABLE ext_covid_data;
 
CREATE EXTERNAL TABLE ext_covid_data
(
id                            int,
updated                       date,
confirmed               int,
confirmed_change  int,
deaths                        int,
deaths_change           smallint,
recovered               int,
recovered_change  int,
latitude                float,
longitude               float,
iso2                    varchar(8000),
iso3                    varchar(8000),
country_region          varchar(8000),
admin_region_1          varchar(8000),
iso_subdivision         varchar(8000),
admin_region_2          varchar(8000),
load_time                     datetime2(7)
)
WITH
(
LOCATION = 'bing_covid-19_data.parquet'
     , FILE_FORMAT = ParquetFileFormat
     , DATA_SOURCE = Public_Covid
);
 
CREATE STATISTICS [Stats_ext_covid_data_updated] ON ext_covid_data([updated]);
 
SELECT TOP 1000 * FROM ext_covid_data;
```

> [!NOTE]
> The column names must match the columns that are stored in the Parquet file, or SQL Server can't identify the columns and returns `NULL`.

After you create the external table `ext_covid_data`, you can add statistics on the updated columns for efficiency. For more information about statistics on external table, see [CREATE STATISTICS (Transact-SQL)](/sql/t-sql/statements/create-statistics-transact-sql).

In this unit, you used PolyBase to connect to an external data source and used OPENROWSET or external table to query the Parquet file. In the next exercise, you use PolyBase services to connect to and create an external table from a database in Azure SQL Database.
