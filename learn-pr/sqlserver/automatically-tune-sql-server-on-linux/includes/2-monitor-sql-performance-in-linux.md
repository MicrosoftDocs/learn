In order to optimize the performance of SQL Server, it is first necessary to be able to measure that performance.

Suppose you are a system architect for a large wine retail company. You have a database that is hosted on SQL Server 2017, which runs on Red Hat Enterprise Linux (RHEL) servers. You want to be sure that the database server is performing as well as possible, given the server's hardware.

When monitoring SQL Server performance on Windows servers, you use counters such as **Batch requests per second** and **Buffer cache hit ratio** to diagnose problems in the Windows Performance Monitor tool. On the RHEL servers, because Windows Performance Monitor is not available, you cannot measure these counters and view how they change over time.

In this unit, you will learn how to use Azure Data Studio to gather data from SQL Server counters and display how those counters vary over time.

## Performance measurement tools in Linux

When you use SQL Server 2017 on Windows Server, database administrators use the Windows Performance Monitor tool to collect and display performance data from SQL counters. You can create displays that show how SQL counters vary over time alongside Windows counters and counters from other installed software.

You can install SQL Server 2017 and later versions on Linux distributions. However, Windows Performance Monitor is not available on Linux servers.

In Linux, there are many command-line and graphical tools that can display the behavior of the server as a whole. For example, they can display the percentage CPU usage and the percentage of physical memory that is in use. However, they cannot access or display SQL Server-specific counters, such as **Batch requests per second**.

## What is Azure Data Studio?

Administrators with Windows computers can use SQL Server Management Studio (SSMS) to connect to, administer, and query SQL Server databases. If you are using a Linux or macOS client computer, you cannot run this tool. Instead, you can use Azure Data Studio.

Azure Data Studio is a free tool with a Graphical User Interface (GUI) that runs on Windows, macOS, and many different Linux distributions. You can use it to connect to SQL Server wherever it is running. You can also use it to administer and query Azure SQL Database and Azure SQL Data Warehouse if you host databases in the Azure cloud.

Azure Data Studio includes the following features:

- A Transact-SQL code editor with IntelliSense
- Smart Transact-SQL code snippets
- Customizable dashboards that display information about databases and servers
- Server groups to organize connection information for the SQL servers you work with
- An integrated terminal that you can use to execute PowerShell, Bash, or other shell commands

When you run a Transact-SQL query that returns numeric data in multiple rows, you can use the Chart Viewer feature of Azure Data Studio to display how that data varies over time. By collecting data from SQL performance counters in a global temporary table, then querying that data and displaying the results in Chart Viewer, you can see a graph of a performance counter against time that is similar to the displays presented in Windows Performance Monitor. You will use this feature to investigate performance in this module.

## Common SQL Server performance counters

There are many performance counters included with SQL Server 2017. Each can give detailed and precise information and help to diagnose performance bottlenecks, but you must understand clearly what each counter means. The following list explains some of the most commonly used counters:

- **Batch Requests/Sec**. This counter measures the rate at which SQL Server is receiving requests from clients. Use this counter to measure demand on the server.
- **User Connections**. This counter measures the number of users currently connected to the database. Again, use this counter to measure demand on the server.
- **Buffer Cache Hit Ratio**. This counter measures the proportion of requests that SQL Server can satisfy by returning data pages from its buffer cache in memory. When the proportion is high, most requests are returned without obtaining data from the hard drives, which respond more slowly than memory. Therefore a high value indicates optimal performance.
- **SQL Compilations/Sec**. This counter measures the rate at which SQL Server compiles execution plans. This process is resource-intensive. If this counter is more that 10% of the value of **Batch Requests/Sec**, then some complication may be lowering performance by rendering execution plans invalid.
- **Page Life Expectancy**. This counter measures the average time a page remains in the buffer cache. In general, a page life expectancy of less than 300 seconds may indicate that your server would perform better with extra physical memory.

When diagnosing performance issues, it is often necessary to identify changes in demand or behavior over time. For example, if your company is growing, user demand on the database server may increase over months or years. Therefore, you should record values of common counters when you know that your server is performing well, as a baseline. Compare later measurements of these counters against the baseline to spot changes that might create bottlenecks.

## Writing scripts to collect performance data

In order to display performance data, you must first create a location where that data can be stored. The following code creates a global temporary table that stores the name of the counter, its value, and the time it was recorded:

```sql
IF NOT EXISTS (SELECT [object_id] FROM tempdb.sys.objects (NOLOCK) WHERE [object_id] = OBJECT_ID('tempdb.dbo.##tblPerfCount'))
CREATE TABLE ##tblPerfCount (
   [counter_name] [NVARCHAR](128),
   [retrieval_time] [datetime],
   [cntr_value] float NULL,
   );

SET NOCOUNT ON
GO
```

Now you can start to record the values of your chosen counter. In the following code, a `WHILE` loop is used to store the value of the **Batch Requests/Sec** counter once a second:

```sql
WHILE 1=1
BEGIN
   INSERT INTO ##tblPerfCount
   SELECT counter_name, GETDATE(), cntr_value
   FROM sys.dm_os_performance_counters pc0 (NOLOCK)
   WHERE counter_name LIKE 'Batch Requests/sec%';

WAITFOR DELAY '00:00:01'
END;
```

While this loop continues to run, performance data is collected in the temporary table for later analysis and display.

## Writing scripts to display performance data

To view a graph of the counter you chose to record and display how it varies over time, you must query the temporary global table you have created, as in the following code:

```sql
SELECT top 70 counter_name, [retrieval_time],
    CASE WHEN LAG(cntr_value,1) OVER (ORDER BY [retrieval_time]) IS NULL THEN  
        cntr_value-cntr_value
        ELSE cntr_value - LAG(cntr_value,1) OVER (ORDER BY [retrieval_time]) END AS cntr_value
FROM ##tblPerfCount
ORDER BY [retrieval_time] DESC
GO
```

When you run such a query in Azure Data Studio, you can use the **Chart Viewer** to display a time series graph. The chart will show how the counter varies over time.

![Displaying a Counter Over Time](../media/2-display-counter-over-time.png)