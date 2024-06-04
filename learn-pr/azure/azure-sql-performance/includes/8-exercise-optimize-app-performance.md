In this exercise, you'll observe a new performance scenario and resolve it by optimizing the application and queries.

## Optimize application performance with Azure SQL

In some cases, migrating an existing application and SQL query workload to Azure can uncover opportunities to optimize and tune queries.

To support a new extension to a website for `AdventureWorks` orders to provide a rating system from customers, you need to add a new table for a heavy set of concurrent INSERT activity. You've tested the SQL query workload on a development computer with SQL Server 2022 that has a local SSD drive for the database and transaction log.

When you move your test to Azure SQL Database by using the general purpose tier (8 vCores), the INSERT workload is slower. Should you change the service objective or tier to support the new workload, or should you look at the application?

You can find all the scripts for this exercise in the *04-Performance\tuning_applications* folder in the GitHub repository you cloned or the zip file you downloaded.

## Create a new table for the application

In **Object Explorer**, select the **AdventureWorks** database. Use **File** > **Open** > **File** to open the **order_rating_ddl.sql** script to create a table in the `AdventureWorks` database. Your query editor window should look like the following text:

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

Select **Execute** to run the script.

## Load queries to monitor query execution

Let's now load some T-SQL queries for dynamic management views (DMVs) to observe query performance for active queries, waits, and I/O. Load all these queries in the context of the `AdventureWorks` database.

1. In **Object Explorer**, select the **AdventureWorks** database. Use **File** > **Open** > **File** to open the **sqlrequests.sql** script to look at active SQL queries. Your query editor window should look like the following text:

    ```sql
    SELECT er.session_id, er.status, er.command, er.wait_type, er.last_wait_type, er.wait_resource, er.wait_time
    FROM sys.dm_exec_requests er
    INNER JOIN sys.dm_exec_sessions es
    ON er.session_id = es.session_id
    AND es.is_user_process = 1;
    ```

1. In **Object Explorer**, select the **AdventureWorks** database. Use **File** > **Open** > **File** to open the **top_waits.sql** script to look at top wait types by count. Your query editor window should look like the following text:

    ```sql
    SELECT * FROM sys.dm_os_wait_stats
    ORDER BY waiting_tasks_count DESC;
    ```

1. In **Object Explorer**, select the **AdventureWorks** database. Use **File** > **Open** > **File** to open the **tlog_io.sql** script to observe latency for transaction log writes. Your query editor window should look like the following text:

    ```sql
    SELECT io_stall_write_ms/num_of_writes as avg_tlog_io_write_ms, * 
    FROM sys.dm_io_virtual_file_stats
    (db_id('AdventureWorks'), 2);
    ```

## Prepare the workload script for execution

Open and edit the **order_rating_insert_single.cmd** workload script.

- Substitute your `unique_id` you were given in the first exercise for the server name for the `-S parameter`.
- Substitute the password you provided in the database deployment from the first exercise for the `-P parameter`.
- Save the changes to the file.

## Run the workload

1. From a PowerShell command prompt, change to the directory for this module activity:

    ```powershell
    cd c:<base directory>\04-Performance\tuning_applications
    ```

1. Run the workload with the following command:

    ```Powershell
    .\order_rating_insert_single.cmd
    ```

    This script uses the ostress.exe program to run 25 concurrent users by running the following T-SQL statement (in the script **order_rating_insert_single.sql**):

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

    You can see from this script that it's not exactly a real depiction of data coming from the website. But it does simulate many order ratings being ingested into the database.

## Observe DMVs and workload performance

Now run the queries in SQL Server Management Studio (SSMS) that you previously loaded to observe performance. Run the queries for **sqlrequests.sql**, **top_waits.sql**, and **tlog_io.sql**.

With these queries, you can observe the following facts:

- Many requests constantly have a `wait_type` of WRITELOG, with a value > 0.
- The `WRITELOG` wait type is one of the highest counts for wait types.
- The average time to write to the transaction log (the `avg_tlog_io_write_ms` column in the **tlog_io.sql** result set) is somewhere around 2 ms.

The duration of this workload on a SQL Server 2022 instance with an SSD drive is approximately 10-12 seconds. The total duration on Azure SQL Database with a Gen5 v8 core is approximately 25 seconds.

`WRITELOG` wait types with higher wait times are indicative of latency flushing to the transaction log. A wait time of 2 ms per write doesn't seem like much, but on a local SSD drive these waits can be less than 1 ms.

## Decide on a resolution

The problem isn't a high percentage of log write activity. The Azure portal and `sys.dm_db_resource_stats` don't show any numbers higher than 20-25 percent (you don't need to query these). The problem isn't an IOPS limit either. The issue is that this application workload is sensitive to low latency for transaction log writes, and the general purpose tier isn't designed for this type of latency requirement. The expected I/O latency for Azure SQL Database is 5-7 ms.

> [!NOTE]
> General purpose Azure SQL Database documents approximate I/O latency averages as 5-7 (writes) and 5-10 (reads). You might experience latencies more like these numbers. Latencies for general purpose Azure SQL Managed Instance are similar. If your application is very sensitive to I/O latencies, consider Business Critical tiers.

Examine the **order_rating_insert_single.sql** workload T-SQL script. Each `INSERT` is a single transaction commit, which requires a transaction log flush.

One commit for each insert isn't efficient, but the application wasn't affected on a local SSD because each commit was very fast. The Business Critical pricing tier (service objective or SKU) provides local SSD drives with a lower latency. It's possible that there's an application optimization, so the workload isn't as sensitive to I/O latency for the transaction log.

You can change the T-SQL batch for the workload to wrap a `BEGIN TRAN/COMMIT TRAN` around the `INSERT` iterations.

## Run a modified, more efficient workload

Make edits to scripts and run them to see a more efficient I/O performance. You can find the modified workload in the **order_rating_insert.sql** script.

1. Prepare the workload script by editing **order_rating_insert.cmd** to use your correct server name and password.

1. Run the modified workload by using the **order_rating_insert.cmd** script, similar to how you ran the previous workload script.

## Observe the new results

1. Look at the results of the T-SQL script for **sqlrequests.sql** in SSMS. Notice far fewer WRITELOG waits, and overall less wait time for these waits.

    Now the workload runs much faster compared to the previous execution. This is an example of tuning an application for SQL queries that will run inside or outside of Azure.

    > [!NOTE]
    > This workload can run even faster against an instance of Azure SQL Database with a **Redirect** connection type. The deployment you've done in this exercise uses a default connection type, which is a proxy type because you are connected outside of Azure. Using Redirect can significantly speed up a workload like this, considering the round trips required from the client to the server.

1. Observe the workload duration. The workload runs so fast it might be difficult to observe diagnostic data from queries used previously in this activity.

   The concept of "batching" can help most applications, including those connected to Azure SQL.

> [!TIP]
> Resource governance on Azure can affect very large transactions, and the symptoms will be `LOG_RATE_GOVERNOR`. In this example, the `char(500)` not null column pads spaces and causes large transaction log records. You can optimize performance even more by making that column a variable length column.

In the next unit, you'll learn about intelligent performance in Azure SQL.
