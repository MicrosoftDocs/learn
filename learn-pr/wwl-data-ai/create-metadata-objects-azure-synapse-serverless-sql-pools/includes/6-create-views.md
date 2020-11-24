Views will allow you to reuse queries that you create. Views are also needed if you want to use tools such as Power BI to access the data in conjunction with SQL serverless. 

## Prerequisites 

Your first step is to create a database where you will execute the queries. Then initialize the objects by executing [setup script]( https://github.com/Azure-Samples/Synapse/blob/master/SQL/Samples/LdwSample/SampleDB.sql) on that database. This setup script will create the data sources, database scoped credentials, and external file formats that are used in these samples. 

## Create a view 

You can create views the same way you create regular SQL Server views. The following query creates view that reads population.csv file. 

> [!NOTE]
> Change the first line in the query, i.e., [mydbname], so you're using the database you created. 

```sql
USE [mydbname]; 
GO 
 
DROP VIEW IF EXISTS populationView; 
GO 
 
CREATE VIEW populationView AS 
SELECT *  
FROM OPENROWSET( 
        BULK 'csv/population/population.csv', 
        DATA_SOURCE = 'SqlOnDemandDemo', 
        FORMAT = 'CSV',  
        FIELDTERMINATOR =',',  
        ROWTERMINATOR = '\n' 
    ) 
WITH ( 
    [country_code] VARCHAR (5) COLLATE Latin1_General_BIN2, 
    [country_name] VARCHAR (100) COLLATE Latin1_General_BIN2, 
    [year] smallint, 
    [population] bigint 
) AS [r];
``` 

The view in this example uses OPENROWSET function that uses absolute path to the underlying files. If you have EXTERNAL DATA SOURCE with a root URL of your storage, you can use OPENROWSET with DATA_SOURCE and relative file path: 

```sql
CREATE VIEW TaxiView 
AS SELECT *, nyc.filepath(1) AS [year], nyc.filepath(2) AS [month] 
FROM 
    OPENROWSET( 
        BULK 'parquet/taxi/year=*/month=*/*.parquet', 
        DATA_SOURCE = 'sqlondemanddemo', 
        FORMAT='PARQUET' 
    ) AS nyc 
 ```

## Use a view 

You can use views in your queries the same way you use views in SQL Server queries. 

The following query demonstrates using the population_csv view we created in Create a view. It returns country/region names with their population in 2019 in descending order. 

> [!NOTE]
>  Change the first line in the query, i.e., [mydbname], so you're using the database you created. 

```sql
USE [mydbname]; 
GO 
 
SELECT 
    country_name, population 
FROM populationView 
WHERE 
    [year] = 2019 
ORDER BY 
    [population] DESC; 
```