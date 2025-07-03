To decide how to use performance tools and capabilities, it's important to look at performance for Azure SQL through scenarios.

## Understand common performance scenarios

A common technique for SQL Server performance troubleshooting is to examine whether a performance problem is **Running** (high CPU) or **Waiting** (waiting on a resource). The following diagram shows a decision tree to determine if a SQL Server performance issue is running or waiting, and how to use performance tools to determine the cause and solution.

:::image type="content" source="../media/4-running-vs-waiting-january-21.svg" alt-text="Diagram of running versus waiting." border="false":::

First, look at overall resource usage. For a standard SQL Server deployment, you might use tools such as Performance Monitor in Windows or top in Linux. For Azure SQL, you can use the following methods:

- Azure portal/PowerShell/alerts

    Azure Monitor has integrated metrics to view resource usage for Azure SQL. You can also set up alerts to look for resource usage conditions.

- `sys.dm_db_resource_stats`

    For Azure SQL Database, you can look at this DMV to see CPU, memory, and I/O resource usage for the database deployment. This DMV takes a snapshot of this data every 15 seconds.

- `sys.server_resource_stats`

    This DMV behaves just like `sys.dm_db_resource_stats`, but it's used to see resource usage for the SQL Managed Instance for CPU, memory, and I/O. This DMV also takes a snapshot every 15 seconds.

- `sys.dm_user_db_resource_governance`

    For Azure SQL Database, this DMV returns the actual configuration and capacity settings used by resource governance mechanisms in the current database or elastic pool.

- `sys.dm_instance_resource_governance`

    For Azure SQL Managed Instance, this DMV returns similar information as `sys.dm_user_db_resource_governance`, but for the current SQL Managed Instance.

### Running

If you have determined the problem is high CPU utilization, this is called a running scenario. A running scenario can involve queries that consume resources through compilation or execution. Use the following tools for further analysis:

- Query Store

    Use the Top Consuming Resource reports in SSMS, Query Store catalog views, or Query Performance Insight in the Azure portal (Azure SQL Database only) to find which queries are consuming the most CPU resources.

- `sys.dm_exec_requests`

    Use this DMV in Azure SQL to get a snapshot of the state of active queries. Look for queries with a state of `RUNNABLE` and a wait type of `SOS_SCHEDULER_YIELD` to see if you have enough CPU capacity.

- `sys.dm_exec_query_stats`

    This DMV can be used much like Query Store to find top resource consuming queries. It's only available for query plans that are cached, whereas Query Store provides a persistent historical record of performance. This DMV also allows you to find the query plan for a cached query.

- `sys.dm_exec_procedure_stats`

    This DMV provides information much like `sys.dm_exec_query_stats`, except the performance information can be viewed at the stored procedure level.

    After you determine what query or queries are consuming the most resources, you might have to examine whether you have enough CPU resources for your workload. You might debug query plans with tools like lightweight query profiling, SET statements, Query Store, or extended events tracing.

### Waiting

If your problem doesn't appear to be a high CPU resource usage, it might be that the performance problem involves waiting on a resource. Scenarios involving waiting on resources include:

- I/O waits
- Lock waits
- Latch waits
- Buffer pool limits
- Memory grants
- Plan cache eviction

To perform analysis on waiting scenarios, you'd typically look at the following tools:

- `sys.dm_os_wait_stats`

    Use this DMV to see the top wait types for the database or instance. This can guide you on what action to take next, depending on the top wait types.

- `sys.dm_exec_requests`

    Use this DMV to find specific wait types for active queries to see what resource they're waiting on. This can be a standard blocking scenario, waiting on locks from other users.

- `sys.dm_os_waiting_tasks`

    You can use this DMV to find wait types for a particular task for a specific query that is currently executing, perhaps to see why it's taking longer than normal. `sys.dm_os_waiting_tasks` contains the live wait stats that sys.dm_os_wait_stats aggregates over time.

- Query Store

    Query Store provides reports and catalog views that show an aggregation of the top waits for query plan execution. It's important to know that a wait of **CPU** is equivalent to a *running* problem.

## Scenarios specific to Azure SQL

There are some performance scenarios, both running and waiting, that are specific to Azure SQL. These include log governance, worker limits, waits encountered for Business Critical service tiers, and waits specific to a Hyperscale deployment.

### Log governance

Azure SQL can use log rate governance to enforce resource limits on transaction log usage. You might need this enforcement to ensure resource limits and to meet promised SLA. Log governance might be seen from the following wait types:

- `LOG_RATE_GOVERNOR`: waits for Azure SQL Database
- `POOL_LOG_RATE_GOVERNOR`: waits for Elastic Pools
- `INSTANCE_LOG_GOVERNOR`: waits for Azure SQL Managed Instance
- `HADR_THROTTLE_LOG_RATE*`: waits for Business Critical and geo-replication latency

### Worker limits

SQL Server uses a worker pool of threads but has limits on the maximum number of workers. Applications with a large number of concurrent users might approach the worker limits enforced for Azure SQL Database and SQL Managed Instance:

- Azure SQL Database has limits based on service tier and size. If you exceed this limit, a new query receives an error.
- At the current time, SQL Managed Instance uses `max worker threads`, so workers past this limit might see `THREADPOOL` waits.

### Business Critical HADR waits

If you use a Business Critical service tier, you might unexpectedly see the following wait types:

- `HADR_SYNC_COMMIT`
- `HADR_DATABASE_FLOW_CONTROL`
- `HADR_THROTTLE_LOG_RATE_SEND_RECV`

Even though these waits might not slow down your application, you might not be expecting to see these. They're normally specific to using an Always On availability group. Business Critical tiers use availability group technology to implement SLA and availability features of a Business Critical service tier, so these wait types are expected. Long wait times might indicate a bottleneck such as I/O latency or replica behind.

### Hyperscale

The Hyperscale architecture can result in some unique wait types that are prefixed with **RBIO** (a possible indication of log governance). In addition, DMVs, catalog views, and extended events are enhanced to show metrics for page server reads.

In the next exercise, you'll learn how to monitor and solve a performance problem for Azure SQL by using the tools and knowledge you've gained in this unit.