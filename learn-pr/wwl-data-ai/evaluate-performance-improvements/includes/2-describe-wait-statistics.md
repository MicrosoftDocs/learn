A comprehensive approach to monitoring server performance involves evaluating what the server is waiting on. Wait statistics are intricate, and SQL Server is equipped with hundreds of wait types that monitor each running thread and log what the thread is waiting for.

To effectively detect and troubleshoot SQL Server performance issues, it's essential to understand how wait statistics work and how the database engine utilizes them while processing requests. This knowledge allows you to pinpoint bottlenecks and optimize performance more accurately.

:::image type="content" source="../media/module-55-optimize-queries-final-18.png" alt-text="Screenshot of how wait statistics work.":::

Wait statistics are broken down into three types of waits: **resource waits**, **queue waits**, and **external waits**.

- **Resource waits** occur when a worker thread in SQL Server requests access to a resource that is currently being used by a thread. Examples of resources wait are locks, latches, and disk I/O waits.
- **Queue waits** occur when a worker thread is idle and waiting for work to be assigned. Example queue waits are deadlock monitoring and deleted record cleanup.
- **External waits** occur when SQL Server is waiting on an external process like a linked server query to complete. An example of an external wait is a network wait related to returning a large result set to a client application.

You can check `sys.dm_os_wait_stats` system view to explore all the waits encountered by threads that executed, and `sys.dm_db_wait_stats` for Azure SQL Database. The `sys.dm_exec_session_wait_stats` system view lists active waiting sessions.

These system views allow you to get an overview of the performance of the server, and to readily identify configuration or hardware issues. This data is persisted from the time of instance startup, but the data can be cleared as needed to identify changes.

Wait statistics are evaluated as a percentage of the total waits on the server.

:::image type="content" source="../media/module-55-optimize-queries-final-17.png" alt-text="Screenshot of the top 10 waits by percentage.":::

The result of this query from `sys.dm_os_wait_stats` shows the wait type, and the aggregation of percent of time waiting (*Wait Percentage* column) and the average wait time in seconds for each wait type.

In this case, the server has Always On Availability Groups in place, as indicated by the **REDO_THREAD_PENDING_WORK** and **PARALLEL_REDO_TRAN_TURN** wait types. The relatively high percentage of **CXPACKET** and **SOS_SCHEDULER_YIELD** waits indicates that this server is under some CPU pressure.

As DMVs provide a list of wait types with the highest time accumulated since the last SQL Server startup, collecting and storing wait statistic data periodically could help you understand and correlate performance problems with other database events.

Considering that DMVs provide you with a list of wait types with the highest time accumulated since the last SQL Server startup, collecting and storing wait statistics periodically might help you understand and correlate performance problems with other database events.

There are several types of waits available in SQL Server, but some of them are common.

- **RESOURCE_SEMAPHORE**—indicates that queries are waiting for memory to become available, often due to excessive memory grants to certain queries. This issue typically manifests as long query runtimes or even time-outs. Causes of these wait types can include out-of-date statistics, missing indexes, and high query concurrency.

- **LCK_M_X**—frequently indicates a blocking problem. This issue can be resolved by changing to the `READ COMMITTED SNAPSHOT` isolation level, optimizing indexing to reduce transaction times, or improving transaction management within T-SQL code.

- **PAGEIOLATCH_SH**—this wait type can indicate issues with indexes or the absence of useful indexes, causing SQL Server to scan excessive amounts of data. Alternatively, if the wait count is low but the wait time is high, it may suggest storage performance problems. You can observe this behavior by analyzing the data in the `waiting_tasks_count` and `wait_time_ms` columns in the [`sys.dm_os_wait_stats`](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql) system view to calculate the average wait time for a given wait type.

- **SOS_SCHEDULER_YIELD**—this wait type can indicate high CPU utilization, which is correlated with either high number of large scans, or missing indexes, and often with high numbers of **CXPACKET** waits.

- **CXPACKET**—A high occurrence of this wait type can indicate improper configuration. Before SQL Server 2019, the default setting for the [max degree of parallelism (MAXDOP)](/en-us/azure/azure-sql/database/configure-max-degree-of-parallelism) was to use all available CPUs for queries. Additionally, the cost threshold for parallelism was set to 5, which could cause small queries to be executed in parallel, limiting throughput. To reduce this wait type, you can lower the MAXDOP setting and increase the cost threshold for parallelism. However, the **CXPACKET** wait type can also indicate high CPU utilization, which is typically resolved through index tuning.

- **PAGEIOLATCH_UP**—This wait type on data pages *2:1:1* can indicate TempDB contention on Page Free Space (PFS) data pages. Each data file has one PFS page per 64 MB of data. This wait is typically caused by only having one TempDB file, as prior to SQL Server 2016, the default behavior was to use one data file for TempDB. The [best practice for TempDB](/sql/relational-databases/databases/tempdb-database) is to use one file per CPU core, up to eight files. It's also important to ensure your TempDB data files are the same size and have the same autogrowth settings to ensure they're used evenly. SQL Server 2016 and higher control the growth of TempDB data files to ensure they grow in a consistent, simultaneous fashion.

In addition to the DMVs mentioned earlier, the [Query Store](/sql/relational-databases/performance/manage-the-query-store) also tracks waits associated with specific queries. Although the waits data tracked by the Query Store isn't as granular as the data in the DMVs, it still provides a useful overview of what a query is waiting on.
