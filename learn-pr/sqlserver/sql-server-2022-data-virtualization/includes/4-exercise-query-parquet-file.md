---
ms.custom:
  - build-2023
---
In this exercise, you'll: 

- Enable the PolyBase feature.
- Create a database called `Demo1`.
- Create a database master key to secure the database scoped credential.
- Create a database scoped credential to access the data source.
- Create the data source.
- Query the data stored on the public data source.  

## Prerequisite

- Have a SQL Server 2022 instance with the **PolyBase Query Service for External Data** feature installed.
- SQL Server Management Studio (SSMS)

## Enable PolyBase

Run the following command using SQL Server Management Studio (SSMS) after connecting to your SQL Server 2022 instance to enable PolyBase.

```sql
EXEC SP_CONFIGURE @CONFIGNAME = 'POLYBASE ENABLED', @CONFIGVALUE = 1;
RECONFIGURE;
```

> [!NOTE]
> The optional feature, **PolyBase Query Service for External Data** must be installed. Refer to the unit on installing PolyBase.
>
> For this exercise, since we'll be querying parquet files using only PolyBase v3, SQL Server PolyBase Data Movement and SQL Server PolyBase Engine services does not need to be enabled or configured.

## Create a database

Run the following command in SSMS to create a database named `Demo1` for this exercise.

```sql
USE MASTER
GO
IF EXISTS (SELECT * FROM sys.databases WHERE [name] = 'Demo1')
BEGIN
    ALTER DATABASE Demo1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE IF EXISTS Demo1
END
GO
CREATE DATABASE Demo1
GO

USE Demo1
GO
```

If the database was already created before, the script will drop and recreate the database with the name `Demo1`.

## Create the database master key

A database master key must be created to ensure the database scoped credential security. This example creates the key with a randomly generated password, and a backup is required. For a better understanding and maintenance on a production environment of encryption keys, see [CREATE MASTER KEY (Transact-SQL)](/sql/t-sql/statements/create-master-key-transact-sql) and [Encryption Hierarchy](/sql/relational-databases/security/encryption/encryption-hierarchy).

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

The database scoped credential is responsible for storing the credentials that will be used by the soon-to-be-created data source to connect to the endpoint. In this example, we'll be using a public endpoint, so the credential doesn’t need a secret.

```sql
IF EXISTS (SELECT * FROM sys.database_scoped_credentials WHERE name = 'PublicCredential') 
    DROP DATABASE SCOPED CREDENTIAL PublicCredential
GO

CREATE DATABASE SCOPED CREDENTIAL PublicCredential
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = '<KEY>'; -- For this particular example the SECRET is not needed since the data source is public
GO
```

## Create the data source

We'll be using the publicly available COVID parquet dataset that is stored on Azure Blob storage (ABS). We'll also be using the previously created database scoped credential `PublicCredential` to establish the connection.

**LOCATION** values:

- Prefix: `abs`
- Azure Storage account: `pandemicdatalake`
- Azure Storage account full path: `pandemicdatalake.blob.core.windows.net`
- Container name: `public`
- Container full path: `public/curated/covid-19/bing_covid-19_data/latest`

For a complete list of data sources and corresponding prefixes, see the article on [CREATE EXTERNAL DATA SOURCE](/sql/t-sql/statements/create-external-data-source-transact-sql?view=sql-server-ver16&preserve-view=true&tabs=dedicated#location--prefixpathport-3).

```sql
IF EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'Public_Covid') DROP EXTERNAL DATA SOURCE Public_Covid
GO

CREATE EXTERNAL DATA SOURCE Public_Covid
WITH (
    LOCATION = 'abs://pandemicdatalake.blob.core.windows.net/public/curated/covid-19/bing_covid-19_data/latest',
    CREDENTIAL = [PublicCredential]
)
GO
```

## Query the data

To access and explore the data, we can use OPENROWSET. OPENROWSET is optimized for ad-hoc workload and data exploration scenarios.

**OPENROWSET** values:

- **BULK**: File name and extension, BULK will automatically append with the data information from the data source. This means the full file location is `abs://pandemicdatalake.blob.core.windows.net/public/curated/covid-19/bing_covid-19_data/latest/bing_covid-19_data.parquet`
- **FORMAT**: Since we'll be accessing a Parquet file, the format should be `PARQUET`.
- **DATA SOURCE**: This is the connection information. In this case, our newly created data source `Public_Covid`.

For more information on the public dataset, see [Bing COVID-19](/azure/open-datasets/dataset-bing-covid-19).

```sql
SELECT TOP 1000 *
FROM OPENROWSET 
     (BULK 'bing_covid-19_data.parquet'
     , FORMAT = 'PARQUET'
     , DATA_SOURCE = 'Public_Covid')
     AS [COVID_Dataset]
```

## Manipulate the data

Run the following command in SSMS:

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

We can see in this case that we can use all of T-SQL's flexibility and query the Parquet file in real-time, as if it's a regular table. As mentioned before, OPENROWSET is optimized for ad-hoc execution for data exploration. If recurring access is needed, external tables are best suited since they can also leverage statistics.

## Schema discovery of external table

To create an external table, the first step is to determine the columns and type. Since the schema comes from an external file, it might be time consuming to precisely determine the data types and ranges. Fortunately we can use the stored procedure, [sp_describe_first_result_set (Transact-SQL)](/sql/relational-databases/system-stored-procedures/sp-describe-first-result-set-transact-sql) to speed up this process.

```sql
DECLARE @tsql NVARCHAR(MAX) = 'SELECT  TOP 1000 *
FROM OPENROWSET 
    (BULK ''bing_covid-19_data.parquet''
    , FORMAT = ''PARQUET''
    , DATA_SOURCE = ''Public_Covid'')
    AS [COVID_Dataset]';
EXEC sys.sp_describe_first_result_set @tsql;
GO
```

:::image type="content" source="../media/schema-discovery.png" alt-text="Image of the schema results of the external Parquet data source in SQL Server Management Studio.":::

We can see that `sp_describe_first_result_set` returned the column names, types, length, precision and even the collation of the data source.

## Create external file format

Since we have to reference the Parquet file to the external table, we first need to run `CREATE EXTERNAL FILE FORMAT` to add the Parquet file format. The file format definition is important for external tables because it specifies the actual layout as well as compression type.

Run the following in SSMS:

```sql
IF EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'ParquetFileFormat')
	DROP EXTERNAL FILE FORMAT ParquetFileFormat

CREATE EXTERNAL FILE FORMAT ParquetFileFormat WITH(FORMAT_TYPE = PARQUET);
GO
```

## Create external table

Finally, with all the information we just acquired, and the external file format created, we can create the external table using the below script in SSMS:

```sql
IF EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'ParquetFileFormat')
	DROP EXTERNAL FILE FORMAT ParquetFileFormat

CREATE EXTERNAL FILE FORMAT ParquetFileFormat WITH(FORMAT_TYPE = PARQUET);
GO

-- 8.3 CREATE EXTERNAL TABLE
IF OBJECT_ID('ext_covid_data', 'ET') IS NOT NULL
	DROP EXTERNAL TABLE ext_covid_data
GO
CREATE EXTERNAL TABLE ext_covid_data 
( 
id					int,	
updated				date,
confirmed			int,
confirmed_change	int,
deaths				int,
deaths_change		smallint,
recovered			int,
recovered_change	int,
latitude			float,
longitude			float,
iso2				varchar(8000),
iso3				varchar(8000),
country_region		varchar(8000),
admin_region_1		varchar(8000),
iso_subdivision		varchar(8000),
admin_region_2		varchar(8000),
load_time			datetime2(7)
)
WITH 
(
LOCATION = 'bing_covid-19_data.parquet'
     , FILE_FORMAT = ParquetFileFormat
     , DATA_SOURCE = Public_Covid
)
GO
CREATE STATISTICS [Stats_ext_covid_data_updated] ON ext_covid_data([updated])
GO
SELECT TOP 1000 * FROM ext_covid_data
GO
```

> [!NOTE]
> The column name must match the columns that are stored in the Parquet file. Otherwise, SQL Server wouldn’t be able to identify the column and would return `NULL`.

After creating the external table `ext_covid_data`, we can also add statistics on the updated column for efficiency. For more information about statics on external table, see [CREATE STATISTICS (Transact-SQL)](/sql/t-sql/statements/create-statistics-transact-sql).
