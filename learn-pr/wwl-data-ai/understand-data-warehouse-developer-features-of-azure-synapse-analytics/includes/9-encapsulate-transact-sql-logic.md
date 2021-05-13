Azure Synapse SQL pools support placing complex data processing logic into Stored procedures. Stored procedures are great way of encapsulating one or more SQL statements or a reference to a Microsoft .NET framework Common Language Runtime (CLR) method.

Stored procedures can accept input parameters and return multiple values in the form of output parameters to the calling program. In the context of serverless SQL pools, you will perform data transformation using CREATE EXTERNAL TABLE AS SELECT (CETAS) statement as shown in the following example.

```sql
-- this sample references external data source and external file format defined in previous section
CREATE PROCEDURE usp_calculate_population_by_year_state
AS
BEGIN
    CREATE EXTERNAL TABLE population_by_year_state
    WITH (
        LOCATION = 'population_by_year_state/',
        DATA_SOURCE = destination_ds,  
        FILE_FORMAT = parquet_file_format
    )  
    AS
    SELECT decennialTime, stateName, SUM(population) AS population
    FROM
        OPENROWSET(BULK 'https://azureopendatastorage.blob.core.windows.net/censusdatacontainer/release/us_population_county/year=*/*.parquet',
        FORMAT='PARQUET') AS [r]
    GROUP BY decennialTime, stateName
END
GO
```

In addition to encapsulating Transact-SQL logic, stored procedures also provide the following additional benefits:

## Reduces client to server network traffic

The commands in a procedure are executed as a single batch of code. This can significantly reduce network traffic between the server and client because only the call to execute the procedure is sent across the network. 

## Provides a security boundary

Multiple users and client programs can perform operations on underlying database objects through a procedure, even if the users and programs do not have direct permissions on those underlying objects. The procedure controls what processes and activities are performed and protects the underlying database objects. This eliminates the requirement to grant permissions at the individual object level and simplifies the security layers.

## Eases maintenance

When client applications call procedures and keep database operations in the data tier, only the procedures must be updated for any changes in the underlying database. 

## Improved performance

Stored procedures are compiled the first time they are executed, and the subsequent execution plan is held in the cache and reused on subsequent execution of the same stored procedure. As a result, it takes less time to process the procedure
