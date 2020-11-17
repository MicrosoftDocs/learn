The Query Store can be thought of as a flight data recorder for SQL Server. It collects and permanently stores and aggregates performance information In older versions of SQL Server, this information was either transient or not collected at all. The Query Store captures run time information such as duration, logical I/O, CPU usage amongst other metrics for query executions in a specific user database. It also captures the estimated execution plan for each execution, which can allow you to quickly detect an execution plan that has regressed in performance. The catalog views that make up the Query Store are stored in the user database, and are shown in this image:

:::image type="content" source="../media/module-44-optimize-resources-final-20.png" alt-text="Relationships between Query Store Catalog Views":::

There are two types of data being captured. One is the data about the query itself (number of executions, the plan it used in execution, the query text) and the other is the performance information, which collects runtime statistics for each execution of the query. Each query execution has a large number of runtime metrics captured for each execution of the query.  

## Query Store reports

SQL Server Management Studio offers a number of out of the box reports that allow you to quickly gather information from the Query Store. The current list of built-in reports is shown in the image below. You can reach this menu by using SQL Server Management Studio, clicking on a user database in Object Explorer, and clicking on the Query Store folder to expand it.

:::image type="content" source="../media/module-44-optimize-resources-final-21.png" alt-text="Query Store Reports in SSMS 18":::

Most of these reports can be filtered by the following execution metrics:

- CPU Milliseconds

- Duration

- Logical Reads

- Logical Writes

- Physical Reads

- CLR Time

- Degree of Parallelism

- Memory Consumption

- Row Count

- Log Memory Used

- TempDB Memory Use

- Wait Time

In addition to these metrics, you can choose a statistic to further refine your data.

- Average

- Maximum

- Minimum

- Standard Deviation

- Total

You can further filter based on a time interval, which allows you to retroactively troubleshoot a performance problem that may have happened several days ago. The built-in reports include:

**Regressed Queries** - This report shows any queries where execution metrics have degraded in the period of time of interest (last hour, day, and week). This report is useful for evaluating the impact of minor or major changes in server configuration or database schema.

**Overall Resource Consumption** - This report allows you to quickly observe the most impactful queries in your database. This report allows click through to the “Top Resource Consuming Queries” report, which allows you to gather execution plan information.

**Top Resource Consuming Queries** - This report shows the query and query plan for the most impactful queries in a database for a time period. This data allows you to observe if a query has multiple execution plans, and whether or not those plans have high variability in performance.

**Queries with Forced Plans** — This report contains information about plan forcing, and any plan forcing failures (a situation where a forced execution plan was not honored).

**Queries with High Variation** - This report showcases queries that have a high degree of variance between executions and can be sorted by any of the above execution metrics.

**Query Wait Statistics** - This report allows you to see waits statistics aggregated, and drill-through to get further information on queries that spent the most time waiting. Note that this wait information is aggregated and not as detailed as what you might observe in the *sys.dm_os_wait_stats* DMV.

**Tracked Queries** - This report is filtered by query_Id and allows you to view the performance of a specific query and its execution plans. You can manually enter a query_id or you can add queries from the regressed or top resource consuming query reports. The query_id can be captured from the catalog *view sys.query_store_query*.

## Performance overhead of the Query Store

Collecting data in any system has an execution cost of CPU cycles, memory, and disk utilization that is known as observer overhead. The Query Store is designed to minimize the impact of its data collection. Data for the Query Store in written to memory for each new query, and each execution of an existing query. If this information was written to disk for each execution, the performance overhead would be significant, so SQL Server uses a setting called **DATA_FLUSH_INTERVAL_SECONDS** to control the frequency of flushing the Query Store data to disk. By default, the data is flushed every 15 minutes, but this value is a user configurable setting per database. This process of collecting the query and runtime information and writing it to disk is shown in the image below:

:::image type="content" source="../media/module-44-optimize-resources-final-22.png" alt-text="Query Store process plan":::

The other important setting to note in the Query Store options is **Max Size (MB)**, which sets the amount of storage for the data collected. The default value is 100 MB and is commonly increased to around 1-2 GB depending on the volume of queries executed against a database. Some workloads that have a high number of unique ad-hoc queries, which is characteristic of applications written in Entity Framework, may see high data volume. If the size of the data stored on disk exceeds the **Max Size (MB)** the Query Store will go into read-only mode until more space is added, or cleanup happens. The default value for time-based cleanup is 30 days, but the **size-based cleanup mode** option will remove older queries as the Query Store approaches its max size. You will want to strike a balance between the amount of data you keep and the amount of space being consumed on disk.

The other setting you should note is **Query_Capture_Mode** which defaults to Auto. This value means queries with insignificant compilation time and duration are ignored, along with infrequent queries. This default was changed in SQL Server 2019, and in Azure SQL. The older default was All, which captures all queries executed. There are also options of none (collect no queries) and Custom, which was also introduced in SQL Server 2019, which allows you to use metrics such as execution count, compile CPU time, and execution time to limit which queries are captured. This setting is useful for a database where most of the queries are unique, as these unique queries can cause the Query Store to grow rapidly in size.

## Plan forcing in the Query Store

Another benefit of the Query Store is the ability to force a given execution plan for a query. Plan forcing in the Query Store also drives the automatic tuning feature that was introduced in SQL Server 2017, which uses the last known good execution plan for a given query after a performance regression occurs. Since the query can store multiple execution plans for a given query, you can have the database engine force a known good plan for a given query. Plan forcing should be used for queries that have suddenly changed execution plans and have experienced significant regression in execution time. Plan forcing offers a quick mitigation for a performance problem, but you should always investigate what caused the performance regression and look to resolve the cause of the execution plan variability. Those fixes could be adding an index or looking to rewrite part of a query.
