External tables are useful when you want to control access to external data in SQL serverless and is commonly used in PolyBase activities. If you want to use tools, such as Power BI, in conjunction with SQL serverless, then external tables are needed. External tables can access two types of storage: 

-	Public storage where users access public storage files. 
-	Protected storage where users access storage files using SAS credential, Azure AD identity, or Managed Identity of Synapse workspace. 

> [!VIDEO https://channel9.msdn.com/Shows/Learn-Azure/Introduction-to-Polybase/player?format=ny] 

## Prerequisites 
Your first step is to create a database where the tables will be created. Then initialize the objects by executing [setup script]( https://github.com/Azure-Samples/Synapse/blob/master/SQL/Samples/LdwSample/SampleDB.sql) on that database. This setup script will create the following objects that are used in this sample: 
- DATABASE SCOPED CREDENTIAL sqlondemand that enables access to SAS-protected 
- https://sqlondemandstorage.blob.core.windows.net Azure storage account. 

    ```sql
    CREATE DATABASE SCOPED CREDENTIAL [sqlondemand] 
    WITH IDENTITY='SHARED ACCESS SIGNATURE',   
    SECRET = 'sv=2018-03-28&ss=bf&srt=sco&sp=rl&st=2019-10-14T12%3A10%3A25Z&se=2061-12-31T12%3A10%3A00Z&sig=KlSU2ullCscyTS0An0nozEpo4tO5JAgGBvw%2FJX2lguw%3D' 
    ```

- EXTERNAL DATA SOURCE sqlondemanddemo that references demo storage account protected with SAS key, and EXTERNAL DATA SOURCE YellowTaxi that references publicly available Azure storage account on location `https://azureopendatastorage.blob.core.windows.net/nyctlc/yellow/` 

    ```sql
    CREATE EXTERNAL DATA SOURCE SqlOnDemandDemo WITH ( 
        LOCATION = 'https://sqlondemandstorage.blob.core.windows.net', 
        CREDENTIAL = sqlondemand 
    ); 
    GO 
    CREATE EXTERNAL DATA SOURCE YellowTaxi 
    WITH ( LOCATION = 'https://azureopendatastorage.blob.core.windows.net/nyctlc/yellow/') 
    ``` 
 
- Next you will create a file format named QuotedCSVWithHeaderFormat and FORMAT_TYPE of parquet that defines two file types. CSV and parquet. 

    ```sql
    CREATE EXTERNAL FILE FORMAT QuotedCsvWithHeaderFormat 
    WITH (   
        FORMAT_TYPE = DELIMITEDTEXT, 
        FORMAT_OPTIONS ( FIELD_TERMINATOR = ',', STRING_DELIMITER = '"', FIRST_ROW = 2   ) 
    ); 
    GO 
    CREATE EXTERNAL FILE FORMAT ParquetFormat WITH (  FORMAT_TYPE = PARQUET ); 
    ```

## Create an external table on protected data 

With the database scoped credential, external data source, and external file format defined.

You can create external tables that access data on an Azure storage account that allows access to users with some Azure AD identity or SAS key. You can create external tables the same way you create regular SQL Server external tables. The following query creates an external table that reads population.csv file from SynapseSQL demo Azure storage account that is referenced using sqlondemanddemo data source and protected with database scoped credential called sqlondemand.  The data source and database scoped credential are created in [setup script]( https://github.com/Azure-Samples/Synapse/blob/master/SQL/Samples/LdwSample/SampleDB.sql). 

> [!NOTE]
> Change the first line in the query, i.e. [mydbname], so you’re using the database you created. 

```sql
USE [mydbname]; 
GO 
CREATE EXTERNAL TABLE populationExternalTable 
( 
    [country_code] VARCHAR (5) COLLATE Latin1_General_BIN2, 
    [country_name] VARCHAR (100) COLLATE Latin1_General_BIN2, 
    [year] smallint, 
    [population] bigint 
) 
WITH ( 
    LOCATION = 'csv/population/population.csv', 
    DATA_SOURCE = sqlondemanddemo, 
    FILE_FORMAT = QuotedCSVWithHeaderFormat 
); 
```
 
## Create an external table on public data 

You can create external tables that read data from the files placed on publicly available Azure storage. This setup script will create public external data source and Parquet file format definition that is used in the following query: 

```sql
CREATE EXTERNAL TABLE Taxi ( 
    vendor_id VARCHAR(100) COLLATE Latin1_General_BIN2,  
    pickup_datetime DATETIME2,  
    dropoff_datetime DATETIME2, 
    passenger_count INT, 
    trip_distance FLOAT, 
    fare_amount FLOAT, 
    tip_amount FLOAT, 
    tolls_amount FLOAT, 
    total_amount FLOAT 
) WITH ( 
        LOCATION = 'puYear=*/puMonth=*/*.parquet', 
        DATA_SOURCE = YellowTaxi, 
        FILE_FORMAT = ParquetFormat 
); 
```
 
## Use an external table 

You can use external tables in your queries the same way you use them in SQL server queries. 
The following query demonstrates this using the population external table we created in previous section. It returns country/region names with their population in 2019 in descending order. 

> [!NOTE]
> Change the first line in the query, i.e. [mydbname], so you’re using the database you created. 

```sql
USE [mydbname]; 
GO 

SELECT 
    country_name, population 
FROM populationExternalTable 
WHERE 
    [year] = 2019 
ORDER BY 
    [population] DESC; 
    ```
