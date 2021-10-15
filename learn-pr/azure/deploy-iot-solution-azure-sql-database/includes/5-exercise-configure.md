<!--Exercise - Configure streaming simulation for the IoT solution

	- Columnstore example
	- Data compression example?
	- Show a time-series example of aggregations
	- JSON example
    - Index example

-->

Optimizing the storage and retrieval of IoT data is important in maximizing ingestion rates and minimizing the time to insights.

Recall in the distributor scenario you are ingesting data from thousands of trucks across the country. You want to take advantage of the Azure SQL Database capabilities. In this exercise, you will see how you can configure and monitor your database for IoT scenarios.

## Confirm the configurations of the database

In the previous exercise, you configured your `iot-db` using a script. Let's break down some of the key configuration choices by looking at what you deployed.

For this exercise, you'll use the Query Editor in the Azure portal to query the database from a browser.

1. To confirm everything is configured properly, navigate to your Azure SQL Database called **iot-db** in the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true).

1. On the left-hand menu, select **Query editor (preview)**.

1. Log in with the username **cloudadmin** and the password you set earlier.

1. If asynchronous statistics update is enabled, `ASYNC_STATS_UPDATE_WAIT_AT_LOW_PRIORITY = ON` will help you avoid blocking other sessions in high concurrency scenarios liking ingesting high volumes of data from a large number of IoT devices. Confirm this is enabled by running the following query.

    ```sql
    SELECT *
    FROM sys.database_scoped_configurations
    WHERE name = 'ASYNC_STATS_UPDATE_WAIT_AT_LOW_PRIORITY';
    GO
    ```

1. The “max degree of parallelism” (referred to as MAXDOP) configuration option controls the ability of the database engine to use parallel threads during query processing. When MAXDOP is something besides 1, the database engine may execute queries using multiple concurrent threads. This often results in shorter query duration due to additional CPU resources used for query processing. The number of concurrently executing threads, and the resulting CPU utilization, depends on the MAXDOP value. Higher values generally result in more threads and higher resource utilization. After years of analyzing customer data, MAXDOP=8 has been set as the default for Azure SQL Database and Managed Instance. Confirm this setting by running the following query.

    ```sql
    SELECT *
    FROM sys.database_scoped_configurations
    WHERE name = 'MAXDOP';
    GO
    ```

1. The data compression feature exists to help reduce the size of the database. In addition to saving space, data compression can help improve performance of I/O intensive workloads, like in IoT scenarios, because the data is stored in fewer pages and queries need to read fewer pages from disk. Confirm this setting by running the following query.

    ```sql
    SELECT TOP 1 data_compression_desc
    FROM sys.partitions
    WHERE OBJECT_ID=(SELECT OBJECT_ID(N'[dbo].[events]') AS 'Object ID');  
    ```

1. For the events coming in, you may want to use Views to aggregate some of the raw data into insights. Review how the view was configured with the following query.

    ```sql
    SELECT definition, uses_ansi_nulls, uses_quoted_identifier,is_schema_bound
    FROM sys.sql_modules
    WHERE object_id = OBJECT_ID('[dbo].[vTimeSeriesBuckets]');
    GO
    ```

1. Both clustered and nonclustered indexes are used in the scenario. Explore the indexes with the following query.

    ```sql
    EXEC sys.sp_helpindex @objname = N'[dbo].[events]'
    GO
    ```

## Monitor the captured events in Azure SQL Database
In future scenarios, and also for the distribution scenario, you will want to monitor the data that is coming in. For this, you can use tools like Azure Log Analytics or Power BI. For the purposes of this exercise, you will simply query the database using the Query Editor in the Azure portal.

1. Run the following T-SQL to see the number of events in the data store.

    ```sql
    SELECT rowcnt, name, * 
    FROM sys.sysindexes 
    WHERE id = OBJECT_ID('dbo.events');
    GO
    ```

1. Run the following T-SQL to see latency of the data ingested. The result is the most recent piece of data inserted into the database.

    ```sql
    SELECT TOP 1 eventTime 
    FROM dbo.events 
    ORDER BY timestamp DESC;
    GO
    ```

1. Run the following T-SQL to see a typical time series query through the view. Note that these values are not the raw data but aggregated data per time slot.

    ```sql
    SELECT * 
    FROM vTimeSeriesBuckets 
    WHERE deviceid IN ('sim000001','sim000002','sim000004','sim000011') ORDER BY timeslot DESC, deviceid;
    GO
    ```

1. Run the following T-SQL to monitor the Azure SQL Database Hyperscale resource consumption.

    ```sql
    SELECT * 
    FROM sys.dm_db_resource_stats 
    ORDER BY end_time DESC;
    GO
    ```

You've now seen how to configure, monitor, and query Azure SQL Database in IoT scenarios like the distributor scenario.

> [!TIP]
> Want to go deeper? You can download this **[Power BI file](https://github.com/Azure-Samples/azure-sql-iot/blob/main/power_bi/IoTDashboard.pbix)** and update the connection settings so each query points to your database. Refreshing the dashboard will then give you deeper insights into latency, trends, and resource consumption.
