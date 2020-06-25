### Optimizing application performance with Azure SQL

You will now go through an exercise to observe a performance problem and resolve it by optimizing the application

In some cases, migrating an existing application and SQL query workload to Azure may uncover opportunities to optimize and tune queries.

Assume that to support a new extension to a website for AdventureWorks orders to support a rating system from customers you need to add a new table to support a heavy set of concurrent INSERT activity for ratings. You have tested the SQL query workload on a development computer that has a local SSD drive for the database and transaction log.

When you move your test to Azure SQL Database using the General Purpose tier (8 vCores), the INSERT workload is slower. You need to discover whether you need to change the service objective or tier to support the new workload.

All scripts for this exercise can be found at *04-Performance\tuning_applications* in the GitHub repository or zip file you downloaded.

1. Create a new table

Run the following T-SQL statement (or use the script **order_rating_ddl.sql**) to create a table in the AdventureWorks database you have used in the first two activities:

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

2. Load queries to monitor query execution

- Use the following query or script **sqlrequests.sql** to look at active SQL queries *in the context of the AdventureWorks database*:

```sql
SELECT er.session_id, er.status, er.command, er.wait_type, er.last_wait_type, er.wait_resource, er.wait_time
FROM sys.dm_exec_requests er
INNER JOIN sys.dm_exec_sessions es
ON er.session_id = es.session_id
AND es.is_user_process = 1;
```
- Use the following query or script **top_waits.sql** to look at top wait types by count *in the context of the AdventureWorks database*:

```sql
SELECT * FROM sys.dm_os_wait_stats
ORDER BY waiting_tasks_count DESC;
```
- Use the following query or script **tlog_io.sql** to observe latency for transaction log writes:

```sql
SELECT io_stall_write_ms/num_of_writes as avg_tlog_io_write_ms, * 
FROM sys.dm_io_virtual_file_stats
(db_id('AdventureWorks<ID>'), 2);
```

3. Prepare the workload script

Edit the workload script **order_rating_insert_single.cmd**.

Substitute your Azure Database Server created in Module 2 for the **-S parameter**<br>
Substitute the login name created for the Azure SQL Database Server created in Module 2 for the **-U parameter**
Substitute the database you deployed in Module 2 for the **-d parameter**<br>
Substitute the password for the login for the Azure SQL Database Server created in Module 2 for the **-P parameter**.

4. Run the workload

Run the test INSERT workload using the script **order_rating_insert_single.cmd**. This script uses ostress to run 25 concurrent users running the following T-SQL statement (in the script **order_rating_insert_single.sql**):

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

From a powershell command prompt, change to the directory for this module activity: 

[vmusername] is the name of the user in your Windows Virtual Machine. Substitute in the path for c:\users\\[vmusername] where you have cloned the GitHub repo.

<pre>
cd c:\users\[vmusername]\sqlworkshops-azuresqlworkshop\azuresqlworkshop\04-Performance\tuning_applications
</pre>

Run the workload with the following command

```Powershell
.\order_rating_insert_single.cmd
```

5. Observe query results and duration

Using the queries in Step 2 you should observe the following:

- Many requests constantly have a wait_type of WRITELOG with a value > 0
- The WRITELOG wait type is one of the highest count for wait types.
- The avg time to write to the transaction log is somewhere around 2ms.

The duration of this workload on a SQL Server 2019 instance with a SSD drive is somewhere around 15 seconds. The total duration using this on Azure SQL Database using a Gen5 v8core ~20 seconds. 

WRITELOG wait types are indicative of latency flushing to the transaction log. 2ms per write doesn't seem like much but on a local SSD drive these waits may < 1ms.

6. Decide on a resolution

The problem is not a high % of log write activity. The Azure Portal and **sys.dm_db_resource_stats** don't show any numbers higher than 20-25% (this is information only. There is not a need to query these). The problem is not an IOPS limit as well. The issue is that this application workload is sensitive to low latency for transaction log writes and the General Purpose tier is not designed for this type of latency requirements. In fact, the documentation for Azure SQL Database says the resource limits for I/O latency is between 5-7ms.

>**NOTE:** General Purpose Azure SQL Database documents approximate I/O latency averages as 5-7 (writes) and 5-10 (reads) so you may experience latencies more like these numbers. Managed Instance General Purpose latencies are similar. If your application is very sensitive to I/O latencies you should consider Business Critical Tiers.

If you examine the workload, you will see each INSERT is a single transaction commit which requires a transaction log flush.

One commit for each insert is not efficient but the application was not affected on a local SSD because each commit was very fast. The Business Critical pricing tier (service objective or SKU) provides local SSD drives with a lower latency but maybe there is an application optimization so the workload is not as sensitive to I/O latency for the transaction log.

The T-SQL batch can be changed for the workload to wrap a BEGIN TRAN/COMMIT TRAN around the INSERT iterations.

7. Prepare and run the modified workload and observe

The modified workload can be found in the script **order_rating_insert.sql**. Prepare the workload script with edits **order_rating_insert.cmd** as you did in Step 3.

Run the modified workload using the script with ostress called **order_rating_insert.cmd** similar to how you ran the workload script in Step 3.

Now the workload runs in almost 2-5 seconds compared to even 18-19 seconds with a local SSD using singleton transactions. This is an example of tuning an application for SQL queries that will run after in or outside of Azure.

The workload runs so fast it may be difficult to observe diagnostic data from queries used previously in this activity. It is important to note that sys.dm_os_wait_stats cannot be cleared using DBCC SQLPERF as it can be with SQL Server.

The concept of "batching" can help most applications including Azure.

>**TIP:** Very large transactions can be affected by resource governance on Azure and the symptoms will be LOG_RATE_GOVERNOR. In this example, the char(500) not null column pads spaces and causes large tlog records. Performance can even be more optimized by making that column a variable length column.