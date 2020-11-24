Azure Synapse serverless SQL pools can be used for data transformations. If you are familiar with Transact-SQL syntax, you can craft a SELECT statement that executes the specific transformation you are interested in, and store the results of the SELECT statement in a selected file format.
You can use CREATE EXTERNAL TABLE AS SELECT (CETAS) in SQL pool or SQL on-demand (preview) to complete the following tasks:
* Create an external table.
* Export, in parallel, the results of a Transact-SQL SELECT statement to the data lake.

## CREATE EXTERNAL TABLE AS SELECT in serverless SQL pool

When using Azure Synapse SQL serverless, CREATE EXTERNAL TABLE AS SELECT is used to create an external table, which exports the query results to Azure Storage Blob or Azure Data Lake Storage Gen2, as shown in the following syntax.
```sql
CREATE EXTERNAL TABLE [ [database_name  . [ schema_name ] . ] | schema_name . ] table_name
    WITH (
        LOCATION = 'path_to_folder',  
        DATA_SOURCE = external_data_source_name,  
        FILE_FORMAT = external_file_format_name  
)
    AS <select_statement>  
[;]

<select_statement> ::=  
    [ WITH <common_table_expression> [ ,...n ] ]  
    SELECT <select_criteria>
```


### Arguments

**[ [ database_name . [ schema_name ] . ] | schema_name . ] table_name**

The one to three-part name of the table to create. For an external table, SQL on-demand stores only the table metadata. No actual data is moved or stored in SQL serverless.

**LOCATION = 'path_to_folder'**

Specifies where to write the results of the SELECT statement on the external data source. The root folder is the data location specified in the external data source. LOCATION must point to a folder and have a trailing /. Example: aggregated_data/

**DATA_SOURCE = external_data_source_name**

Specifies the name of the external data source object that contains the location where the external data will be stored. To create an external data source, use CREATE EXTERNAL DATA SOURCE (Transact-SQL).

**FILE_FORMAT = external_file_format_name**

Specifies the name of the external file format object that contains the format for the external data file. To create an external file format, use CREATE EXTERNAL FILE FORMAT (Transact-SQL). Only external file formats with FORMAT_TYPE=PARQUET and FORMAT_TYPE=DELIMITEDTEXT are currently supported.

**WITH <common_table_expression>**

Specifies a temporary named result set, known as a common table expression (CTE). For more information, see WITH common_table_expression (Transact-SQL).

**SELECT <select_criteria>**

Populates the new table with the results from a SELECT statement. select_criteria is the body of the SELECT statement that determines which data to copy to the new table. For information about SELECT statements, see SELECT (Transact-SQL).

> [!NOTE]
> The ORDER BY clause in SELECT part of the statement is not supported for CETAS.
> You need to have permissions to list folder content and write to the LOCATION folder for CETAS to work.

The following examples use CETAS to save total population aggregated by year and state to an aggregated_data folder that is in the population_ds datasource.
To save query results to a different folder in the same data source, change the LOCATION argument.
To save results to a different storage account, create and use a different data source for DATA_SOURCE argument.
> [!NOTE]
> The samples that follow use a public Azure Open Data storage account. It is read-only. To execute these queries, you need to provide the data source for which you have write permissions. Please fill in your destination storage path and accompanying SAS where noted in example below. 

```sql
-- you might need to execute following statement if you never did so on current database
-- CREATE MASTER KEY

CREATE DATABASE SCOPED CREDENTIAL destination_credential
WITH IDENTITY='SHARED ACCESS SIGNATURE',  
	SECRET = '' -- fill in your SAS key that will be used for CETAS destination
GO

CREATE EXTERNAL DATA SOURCE destination_ds
WITH
(    
	LOCATION         = 'https://<storage>.<dfs>.core.windows.net/<container>' – replace path to match root path for your CETAS destination
     , CREDENTIAL = destination_credential
)
GO

CREATE EXTERNAL FILE FORMAT parquet_file_format
WITH
(  
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)
GO

-- use CETAS to export select statement with OPENROWSET result to  storage
CREATE EXTERNAL TABLE aggregated_data
WITH (
    LOCATION = 'aggregated_data/',
    DATA_SOURCE = destination_ds,  
    FILE_FORMAT = parquet_file_format
)  
AS
SELECT decennialTime, stateName, SUM(population) AS population
FROM
    OPENROWSET(BULK 'https://azureopendatastorage.blob.core.windows.net/censusdatacontainer/release/us_population_county/year=*/*.parquet',
    FORMAT='PARQUET') AS [r]
GROUP BY decennialTime, stateName
GO

-- you can query the newly created external table
SELECT * FROM aggregated_data
```

## Supported data types

CETAS can be used to store result sets with following SQL data types:

- binary
- varbinary
- char
- varchar
- date
- time
- datetime2
- decimal
- numeric
- float
- real
- bigint
- int
- smallint
- tinyint
- bit
- nchar
- nvarchar
- datetime
- smalldatetime
- datetimeoffset

> [!NOTE]
> LOBs larger than 1MB can't be used with CETAS. 

The following data types cannot be used in the SELECT part of CETAS statement:
- money
- smallmoney
- uniqueidentifier
