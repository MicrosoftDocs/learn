<!--Exercise - Configure streaming simulation for the IoT solution

	- Columnstore example
	- Data compression example?
	- Show a time-series example of aggregations
	- JSON example
    - Index example

-->

Optimizing the storage and retrieval of IoT data is important in maximizing ingestion rates and minimizing the time to insights.

Recall in the distributor scenario you are ingesting data from thousands of trucks across the country. You want to take advantage of the Azure SQL Database capabilities that can help like columnstore, indexing, JSON support and data compression. In this exercise, you will see how you can.

## Configure the database

In the previous exercise, you configured your `iot-db` using a script. Let's break down some of the key configuration choices by looking at what you deployed.

1. Run `TERM=dumb` in the bash window on the right-hand side of this page.

1. Update the code below and run the the Azure Cloud Shell (you may want to copy to a text file to easily modify). Note you'll need to add your server name and password. This sqlcmd command opens a connection to your database so you can query.

    ```bash
    sqlcmd -S [server-name].database.windows.net -P [password] -U cloudadmin -d iot-db
    ```

1. If asynchronous statistics update is enabled, `ASYNC_STATS_UPDATE_WAIT_AT_LOW_PRIORITY = ON` will help you avoid blocking other sessions in high concurrency scenarios liking ingesting high volumes of data from a large number of IoT devices. Confirm this is enabled by running the following in the Azure Cloud Shell.

    ```sql
    TODO
    ```

1. Explain/confirm why you should set a MAXDOP 8

    ```sql
    TODO
    ```

1. Explain/confirm `DATA_COMPRESSION = PAGE`

    ```sql
    TODO
    ```

1. Show and explain the clustered index clEvents

    ```sql
    TODO
    ```

1. Explain/view the timeseries view created

    ```sql
    TODO
    ```

1. Explain/view the nonclustered index

    ```sql
    TODO
    ```

## Review the captured events in Azure SQL Database

1. Run the following T-SQL to see the number of events in the data store.

    ```sql
    TODO
    ```

1. Run the following T-SQL to see latency of the data ingested.

    ```sql
    TODO
    ```

1. Run the following T-SQL to see a typical time series query.

    ```sql
    TODO
    ```

1. Run the following T-SQL to see the Azure SQL Database Hyperscale resource consumption.

    ```sql
    TODO
    ```
