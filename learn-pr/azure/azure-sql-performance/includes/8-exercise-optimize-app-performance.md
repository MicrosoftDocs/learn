You will now go through an exercise to observe a new performance scenario and resolve it by optimizing the application and queries.

## Optimize application performance with Azure SQL

In some cases, migrating an existing application and SQL query workload to Azure may uncover opportunities to optimize and tune queries.

Assume that to support a new extension to a website for AdventureWorks orders to provide a rating system from customers you need to add a new table for a heavy set of concurrent INSERT activity. You have tested the SQL query workload on a development computer with SQL Server 2019 that has a local SSD drive for the database and transaction log.

When you move your test to Azure SQL Database using the General Purpose tier (8 vCores), the INSERT workload is slower. You need to discover whether you need to change the service objective or tier to support the new workload or look at the application.

All scripts for this exercise can be found at *04-Performance\tuning_applications* in the GitHub repository or zip file you downloaded.

## Create a new table for the application

1. Click on the AdventureWorks database in Object Explorer and use the File/Open menu to open the **order_rating_ddl.sql** script to create a table in the AdventureWorks database. Your query editor window should look like the following text:

    ```sql
    DROP TABLE IF EXISTS SalesLT.OrderRating;
    GO
    CREATE TABLE SalesLT.OrderRating
    (OrderRatingID int identity not null,
    SalesOrderID int not null,
    OrderRatingDT datetime not null,
    OrderRating int not null,
    OrderRatingComments char(500) not null);
    GO
    ```

## Load queries to monitor query execution

Let's now load some T-SQL queries for DMVs to observe query performance for active queries, waits, and I/O. **Load all these queries in the context of the AdventureWorks database**.

1. Click on the AdventureWorks database in Object Explorer and use the File/Open menu to open the **sqlrequests.sql** script to look at active SQL queries. Your query editor window should look like the following text:

    ```sql
    SELECT er.session_id, er.status, er.command, er.wait_type, er.last_wait_type, er.wait_resource, er.wait_time
    FROM sys.dm_exec_requests er
    INNER JOIN sys.dm_exec_sessions es
    ON er.session_id = es.session_id
    AND es.is_user_process = 1;
    ```

1. Click on the AdventureWorks database in Object Explorer and use the File/Open menu to open the **top_waits.sql** script to look at top wait types by count. Your query editor window should look like the following text:

    ```sql
    SELECT * FROM sys.dm_os_wait_stats
    ORDER BY waiting_tasks_count DESC;
    ```

1. Click on the AdventureWorks database in Object Explorer and use the File/Open menu to open the **tlog_io.sql** script to observe latency for transaction log writes. Your query editor window should look like the following text:

    ```sql
    SELECT io_stall_write_ms/num_of_writes as avg_tlog_io_write_ms, * 
    FROM sys.dm_io_virtual_file_stats
    (db_id('AdventureWorks'), 2);
    ```

## Prepare the workload script for execution

1. Edit the workload script **order_rating_insert_single.cmd**

    - Substitute your **unique_id** you were given in the first exercise for the server name for the **-S parameter**.
    - Substitute the password you provided in the database deployment from the first exercise for the **-P parameter**.

## Run the workload

1. From a PowerShell command prompt, change to the directory for this module activity:

    ```powershell
    cd c:<base directory>\04-Performance\tuning_applications
    ```

1. Run the workload with the following command

    ```Powershell
    .\order_rating_insert_single.cmd
    ```

    This script uses the ostress.exe program to run 25 concurrent users running the following T-SQL statement (in the script **order_rating_insert_single.sql**):

    ```sql
    DECLARE @x int;
    SET @x = 0;
    WHILE (@x < 500)
    BEGIN
    SET @x = @x + 1;
    INSERT INTO SalesLT.OrderRating
    (SalesOrderID, OrderRatingDT, OrderRating, OrderRatingComments)
    VALUES (@x, getdate(), 5, 'This was a great order');
    END
    ```

    You can see from this script that it is not exactly a real depiction of data coming from the website but it does simulate many order ratings being ingested into the database.

## Observe DMVs and workload performance

1. Now run the queries in SSMS you previously loaded to observe performance. Run the queries for **sqlrequests.sql**, **top_waits.sql**, and **tlog_io.sql**

    Use these queries you can observe the following facts:

    - Many requests constantly have a wait_type of WRITELOG with a value > 0
    - The WRITELOG wait type is one of the highest counts for wait types.
    - The average time to write to the transaction log is somewhere around 2 ms.

    The duration of this workload on a SQL Server 2019 instance with an SSD drive is somewhere around 10-12 seconds. The total duration on Azure SQL Database using a Gen5 v8 core is around ~25 seconds.

    WRITELOG wait types with higher wait times are indicative of latency flushing to the transaction log. 2 ms per write doesn't seem like much but on a local SSD drive these waits may be less than 1 ms.

## Decide on a resolution

The problem is not a high percentage of log write activity. The Azure portal and **sys.dm_db_resource_stats** don't show any numbers higher than 20-25% (this is information only. There is not a need to query these). The problem is not an IOPS limit as well. The issue is that this application workload is sensitive to low latency for transaction log writes and the General Purpose tier is not designed for this type of latency requirements. In fact, the documentation for Azure SQL Database says the resource limits for I/O latency are between 5-7 ms.

> [!NOTE]
> General Purpose Azure SQL Database documents approximate I/O latency averages as 5-7 (writes) and 5-10 (reads) so you may experience latencies more like these numbers. Managed Instance General Purpose latencies are similar. If your application is very sensitive to I/O latencies you could consider Business Critical Tiers.

1. Examine the workload T-SQL script **order_rating_insert_single.sql**, you will see each INSERT is a single transaction commit, which requires a transaction log flush.

    One commit for each insert is not efficient but the application was not affected on a local SSD because each commit was very fast. The Business Critical pricing tier (service objective or SKU) provides local SSD drives with a lower latency but maybe there is an application optimization so the workload is not as sensitive to I/O latency for the transaction log.

    The T-SQL batch can be changed for the workload to wrap a BEGIN TRAN/COMMIT TRAN around the INSERT iterations.

## Run a modified more efficient workload

Make edits to scripts and execute them to see a more efficient I/O performance. The modified workload can be found in the script **order_rating_insert.sql**.

1. Prepare the workload script by editing **order_rating_insert.cmd** to put in your correct server name and password.

1. Run the modified workload using the script **order_rating_insert.cmd** similar to how you ran the previous workload script.

## Observe the new results

1. Look at the results of the T-SQL script for **sqlrequests.sql** in SSMS. You will see from these results far less WRITELOG waits and overall less wait time for these waits.

    Now the workload runs much faster compared to the previous execution. This is an example of tuning an application for SQL queries that will run after in or outside of Azure.

    > [!NOTE]
    > This workload can run even faster against an Azure SQL Database with a connection type of **Redirect**. The deployment you have done in this exercise uses a Default connection type which will be a Proxy type because you are connected outside of Azure. Using Redirect can significantly speed up a workload like this given the round trips required from the client to the server.

1. Observe the workload duration. The workload runs so fast it may be difficult to observe diagnostic data from queries used previously in this activity.

    It is important to note that sys.dm_os_wait_stats cannot be cleared in Azure SQL Database using DBCC SQLPERF as it can be with SQL Server.

    The concept of "batching" can help most applications including those connected to Azure SQL.

> [!TIP]
> Very large transactions can be affected by resource governance on Azure and the symptoms will be LOG_RATE_GOVERNOR. In this example, the char(500) not null column pads spaces and causes large transaction log records. Performance can even be more optimized by making that column a variable length column.

In the next unit, you will learn about the amazing capabilities of Intelligent Performance in Azure SQL, which can help you go even farther with performance for Azure SQL.
