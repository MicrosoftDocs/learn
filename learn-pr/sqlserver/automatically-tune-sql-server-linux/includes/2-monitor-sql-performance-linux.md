To optimize the performance of SQL Server, you first have to measure it.

Suppose you're a system architect for a large wine retail company. You have a database that's hosted on SQL Server 2019, and runs on Red Hat Enterprise Linux (RHEL) servers. You want to ensure that the database server is doing as well as possible, given the server's hardware.

SQL Server administrators often use Dynamic Management Views (DMVs) as their primary source of performance data. The **dm_os_performance_counters** DMV includes many performance counters that profile the performance of the server under user demand. For example, when monitoring SQL Server performance, you can use counters such as **Batch requests per second** and **Buffer cache hit ratio** to diagnose problems.

In this unit, you'll learn how to use Azure Data Studio to gather data from SQL Server counters and display how those counters vary over time in a chart.

## Performance measurement tools in Linux

In Linux, there are many command-line and graphical tools that display the behavior of the server as a whole. They can, for example, display the percentage CPU usage and the percentage of physical memory that's in use. But these tools can't access or display SQL Server-specific counters, such as **Batch requests per second**.

You can write Transact-SQL queries that return performance counters from SQL Server DMVs. But SQL queries on their own show only a snapshot of performance at one moment. To see clearly how performance is varying over time and in response to changes in demand, it would be helpful to be able to plot a chart from these counters.

## What is Azure Data Studio?

Azure Data Studio is a free tool with a graphical user interface (GUI) that runs on Windows, macOS, and many different Linux distributions. You can use Azure Data Studio to connect to SQL Server wherever it's running and submit Transact-SQL queries. You can also use it to administer and query Azure SQL Database and Azure SQL Data Warehouse if you host databases in the Azure cloud.

Azure Data Studio includes the following features:

- A Transact-SQL code editor with IntelliSense
- Smart Transact-SQL code snippets
- Customizable dashboards that display information about databases and servers
- Server groups to organize connection information for the SQL servers you work with
- An integrated terminal you can use to execute PowerShell, Bash, or other shell commands

When you run a Transact-SQL query that returns numeric data in multiple rows, you can use the Chart Viewer feature of Azure Data Studio to display how that data varies over time. By collecting data from SQL performance counters in a global temporary table, then querying that data and displaying the results in Chart Viewer, you can see a graph of a performance counter against time. This kind of display highlights how performance and demand are changing and can help you to spot problems before they become bottlenecks. You'll use the feature to investigate performance in this module.

## Common SQL Server performance counters

Many performance counters are included with SQL Server 2019. Each counter can give detailed and precise information, and help to diagnose performance bottlenecks. But you must understand clearly what each counter means. The following list explains some of the most commonly used counters:

- **Batch Requests/Sec**. This counter measures the rate at which SQL Server is receiving requests from clients. Use this counter to measure demand on the server.
- **User Connections**. This counter measures the number of users currently connected to the database. Again, use this counter to measure demand on the server.
- **Buffer Cache Hit Ratio**. This counter measures the proportion of requests that SQL Server can satisfy by returning data pages from its buffer cache in memory. When the proportion is high, most requests are returned without obtaining data from the hard drives, which respond more slowly than memory. That's why a high value indicates optimal performance.
- **SQL Compilations/Sec**. This counter measures the rate at which SQL Server compiles execution plans. This process is resource-intensive. If this counter is more than 10% of the value of **Batch Requests/Sec**, then some complication may be lowering performance by rendering execution plans invalid.
- **Page Life Expectancy**. This counter measures the average time a page remains in the buffer cache. In general, a page life expectancy of less than 300 seconds might indicate that your server would do better with extra physical memory.

When diagnosing performance issues, it's often necessary to identify changes in demand or behavior over time. If your company is growing, for example, user demand on the database server might increase over months or years. That's why you should record values of common counters when you know that your server is doing well, as a baseline. Compare later measurements of these counters against the baseline to spot changes that might create bottlenecks.

## Writing scripts to collect performance data

To display performance data, you must first create a location where that data can be stored. The following code creates a global temporary table that stores the name of the counter, its value, and the time it was recorded:

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

Now you can start to record the values of your chosen counter. In the following code, a `WHILE` loop is used to store the value of the **Batch Requests/Sec** counter once every second:

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

To view a graph of the counter you chose to record and display how it varies over time, you must query the temporary global table you've created. You could use the following code:

```sql
SELECT top 70 counter_name, [retrieval_time],
    CASE WHEN LAG(cntr_value,1) OVER (ORDER BY [retrieval_time]) IS NULL THEN  
        cntr_value-cntr_value
        ELSE cntr_value - LAG(cntr_value,1) OVER (ORDER BY [retrieval_time]) END AS cntr_value
FROM ##tblPerfCount
ORDER BY [retrieval_time] DESC
GO
```

When you run such a query in Azure Data Studio, you use the **Chart Viewer** to display a time series graph. The chart shows how the counter varies over time.

![Screenshot of Azure Data Studio with query and results displaying a counter over time.](../media/2-display-counter-over-time.png)