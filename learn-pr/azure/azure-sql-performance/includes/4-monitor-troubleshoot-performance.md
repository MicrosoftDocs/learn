Monitoring and troubleshooting are key elements to deliver consistent performance. Azure SQL has the same tools and features as SQL Server to monitor and troubleshoot performance, plus additional capabilities. This includes features like dynamic management views (DMVs), extended events, and Azure Monitor. It's also important to learn how to use these tools and capabilities across various performance scenarios for Azure SQL. These scenarios include high CPU or waiting on a resource.

## Tools and capabilities to monitor performance

Azure SQL provides monitoring and troubleshooting capabilities in the Azure ecosystem, as well familiar tools that come with SQL Server. The following sections briefly describe these.

### Azure Monitor

Azure Monitor is part of the Azure ecosystem, and Azure SQL is integrated to support Azure metrics, alerts, and logs. You can visualize Azure Monitor data in the Azure portal, applications can access this data through Azure Event Hubs or APIs. Much like Windows Performance Monitor, Azure Monitor helps you access resource usage metrics for Azure SQL without the use of SQL Server tools.

### Dynamic management views

Azure SQL provides the same DMV infrastructure as SQL Server, with a few differences. DMVs are crucial to performance monitoring because you can view key SQL Server performance data by using standard T-SQL queries. For example, you can view information such as active queries, resource usage, query plans, and resource wait types. Learn more details about DMVs with Azure SQL later in this unit.

### Extended events

Azure SQL provides the same extended events infrastructure as SQL Server, with a few differences. Extended events give you the ability to trace key events of execution within SQL Server that powers Azure SQL. For performance, extended events allow you to trace the execution of individual queries. Learn more details about extended events with Azure SQL later in this unit.

### Lightweight query profiling

You use lightweight query profiling to examine the query plan and running state of an active query. This is a key feature to debug query performance for statements as they are running. This capability cuts down the time for you to solve performance problems, compared to using tools like extended events to trace query performance. You access lightweight query profiling through DMVs, and it's on by default for Azure SQL as it is for SQL Server 2019.

### Query plan debug capabilities

In some situations, you might need additional details about query performance for an individual T-SQL statement. T-SQL SET statements, such as SHOWPLAN and STATISTICS, can provide these details and are fully supported for Azure SQL, as they are for SQL Server.

### Query Store

Query Store is a historical record of performance execution for queries stored in the user database. Query Store is on by default for Azure SQL, and is used to provide capabilities such as automatic plan correction and automatic tuning. SQL Server Management Studio (SSMS) reports for the store are available for Azure SQL. Use these reports to find top resource consuming queries, including query plan differences, and top wait types to look at resource wait scenarios.

### Performance visualizations

For Azure SQL Database, you can see integrated Query Store performance information in the Azure portal through visualizations. This way you can see some of the same information for Query Store as you would with a client tool like SSMS. Use the Azure portal options called Performance Overview and Query Performance Insight.

## DMV details

DMVs have been a driving force to monitor and troubleshoot performance for many years with SQL Server. Common DMVs for SQL Server are available with Azure SQL, and some additional ones are specific to Azure.

### Azure SQL Managed Instance

All DMVs for SQL Server are available for SQL Managed Instance. Key DMVs like **sys.dm_exec_requests** and **sys.dm_os_wait_stats** are commonly used to examine query performance.

**sys.server_resource_stats** is specific to Azure, and shows historical resource usage for the managed instance. This is an important DMV to see resource usage, because you don't have direct access to operating system tools like Performance Monitor.

### Azure SQL Database

Most of the common DMVs you need for performance, including **sys.dm_exec_requests** and **sys.dm_os_wait_stats**, are available. Note that these DMVs only provide information specific to the database, not information across all databases for a logical server.

**sys.dm_db_resource_stats** is a DMV specific to Azure SQL Database, and can be used to view a history of resource usage for the database. Use this DMV similar to how you would use `sys.server_resource_stats` for a managed instance.

**sys.elastic_pool_resource_stats** is similar to `sys.dm_db_resource_stats` but can be used to view resource usage for elastic pool databases.

### DMVs you need

You'll need the following DMVs to solve certain performance scenarios for Azure SQL:

- **sys.dm_io_virtual_file_stats** is important because you don't have direct access to operating system metrics for I/O performance per file.
- **sys.dm_os_performance_counters** is available for both Azure SQL Database and SQL Managed Instance to see SQL Server common performance metrics. Use this to view SQL Server performance counter information that is typically available in Performance Monitor.
- **sys.dm_instance_resource_governance** enables you to view resource limits for a managed instance. You can view this information to see what your expected resource limits should be without using the Azure portal.
- **sys.dm_user_db_resource_governance** enables you to see common resource limits per the deployment option, service tier, and size for your Azure SQL Database deployment. You can view this information to see what your expected resource limits should be without using the Azure portal.

### DMVs for deeper insights

These DMVs provide deeper insight into resource limits and resource governance for Azure SQL. They aren't meant to be used for common scenarios, but might be helpful when looking deep into complex performance problems. Consult the documentation for all the details of these DMVs:

- **sys.dm_user_db_resource_governance_internal** (SQL Managed Instance only)
- **sys.dm_resource_governor_resource_pools_history_ex**
- **sys.dm_resource_governor_workload_groups_history_ex**

## Extended events details

The extended events feature is the tracing mechanism for SQL Server. Extended events for Azure SQL are based on the SQL Server engine, and therefore is the same for Azure SQL, with a few notable differences. The next sections cover these differences.

### Extended events for Azure SQL Database

Extended events can be used for Azure SQL Database, just like SQL Server, by creating sessions and using events, actions, and targets. Keep these important points in mind when creating extended event sessions:

- Most commonly used events and actions are supported.
- File, `ring_buffer`, and counter targets are supported.
- File targets are supported with Azure Blob storage because you don't have access to the underlying operating system disks.

You can use SSMS or T-SQL to create and start sessions. You can use SSMS to view extended event session target data or the system function **sys.fn_xe_file_target_read_file**. 

> [!NOTE]
> It is not possible to use SSMS to view active data for Azure SQL Database.

It's important to know that any extended events fired for your sessions are specific to your database, and don't apply across the logical server.

### Extended events for Azure SQL Managed Instance

You can use extended events SQL Managed Instance, just like SQL Server, by creating sessions and using events, actions, and targets. Keep these important points in mind when creating extended event sessions:

- All events, targets, and actions are supported.
- File targets are supported with Azure Blob storage because you don't have access to the underlying operating system disks.
- Some specific events are added for SQL Managed Instance to trace events specific to the management and execution of the instance.

You can use SSMS or T-SQL to create and start sessions. You can use SSMS to view extended event session target data or the system function **sys.fn_xe_file_target_read_file**. The ability with SSMS to view live data is supported for SQL Managed Instance.

## Performance scenarios for Azure SQL

To decide how to apply monitoring and troubleshooting performance tools and capabilities, it's important to look at performance for Azure SQL through scenarios.

### Common performance scenarios

A common technique for SQL Server performance troubleshooting is to examine if a performance problem is **Running** (high CPU) or **Waiting** (waiting on a resource). The following diagram shows a decision tree to determine if a SQL Server performance issue is running or waiting, and how to use performance tools to determine the cause and solution.

:::image type="content" source="../media/4-running-vs-waiting-january-21.svg" alt-text="Diagram of running versus waiting." border="false":::

Let's dive more into the details of each aspect of the diagram.

#### Running vs. waiting

First, look at overall resource usage. For a standard SQL Server deployment you might use tools such as Performance Monitor in Windows, or top in Linux. For Azure SQL, you can use the following methods:

- Azure portal/PowerShell/alerts

    Azure Monitor has integrated metrics to view resource usage for Azure SQL. You can also set up alerts to look for resource usage conditions.

- `sys.dm_db_resource_stats`

    For Azure SQL Database, you can look at this DMV to see CPU, memory, and I/O resource usage for the database deployment. This DMV takes a snapshot of this data every 15 seconds.

- `sys.server_resource_stats`

    This DMV behaves just like `sys.dm_db_resource_stats`, but it's used to see resource usage for the SQL Managed Instance for CPU, memory, and I/O. This DMV also takes a snapshot every 15 seconds.

- `sys.dm_user_db_resource_governance`

    For Azure SQL Database, this DMV returns the actual configuration and capacity settings used by resource governance mechanisms in the current database or elastic pool.

- `sys.dm_instance_resource_governance`

    For Azure SQL Managed Instance, this DMV returns similar information as `sys.dm_user_db_resource_governance` but for the current SQL Managed Instance.

#### Running

If you have determined the problem is high CPU utilization, this is called a running scenario. A running scenario can involve queries that consume resources through compilation or execution. Use the following tools for further analysis:

- Query Store

    Use the Top Consuming Resource reports in SSMS, Query Store catalog views, or Query Performance Insight in the Azure portal (Azure SQL Database only) to find which queries are consuming the most CPU resources.

- `sys.dm_exec_requests`

    Use this DMV in Azure SQL to get a snapshot of the state of active queries. Look for queries with a state of RUNNABLE and a wait type of `SOS_SCHEDULER_YIELD` to see if you have enough CPU capacity.

- `sys.dm_exec_query_stats`

    This DMV can be used much like Query Store to find top resource consuming queries. Be aware that it's only available for query plans that are cached, whereas Query Store provides a persistent historical record of performance. This DMV also allows you to find the query plan for a cached query.

- `sys.dm_exec_procedure_stats`

    This DMV provides information much like `sys.dm_exec_query_stats`, except the performance information can be viewed at the stored procedure level.

    After you determine what query or queries are consuming the most resources, you might have to examine whether you have enough CPU resources for your workload. You might debug query plans with tools like lightweight query profiling, SET statements, Query Store, or extended events tracing.

#### Waiting

If your problem doesn't appear to be a high CPU resource usage, it might be that the performance problem involves waiting on a resource. Scenarios involving waiting on resources include:

- I/O waits
- Lock waits
- Latch waits
- Buffer pool limits
- Memory grants
- Plan cache eviction

To perform analysis on waiting scenarios, you typically look at the following tools:

- `sys.dm_os_wait_stats`

    Use this DMV to see the top wait types for the database or instance. This can guide you on what action to take next, depending on the top wait types.

- `sys.dm_exec_requests`

    Use this DMV to find specific wait types for active queries to see what resource they are waiting on. This can be a standard blocking scenario, waiting on locks from other users.

- `sys.dm_os_waiting_tasks`

    Queries that use parallelism use multiple tasks for a particular query. You might need to use this DMV to find wait types for a particular task for a specific query.

- Query Store

    Query Store provides reports and catalog views that show an aggregation of the top waits for query plan execution. It's important to know that a wait of **CPU** is equivalent to a *running* problem.

> [!TIP]
> You can use extended events for any running or waiting scenarios. To do so, you must set up an extended events session to trace queries. This method to debug a performance problem can be considered heavy.

### Scenarios specific to Azure SQL

There are some performance scenarios, both running and waiting, that are specific to Azure SQL. These include log governance, worker limits, waits encountered for Business Critical service tiers, and waits specific to a Hyperscale deployment.

#### Log governance

Azure SQL can use log rate governance to enforce resource limits on transaction log usage. You might need this enforcement to ensure resource limits and to meet promised SLA. Log governance might be seen from the following wait types:

- LOG_RATE_GOVERNOR - waits for Azure SQL Database
- POOL_LOG_RATE_GOVERNOR - waits for Elastic Pools
- INSTANCE_LOG_GOVERNOR - waits for Azure SQL Managed Instance
- HADR_THROTTLE_LOG_RATE* - waits for Business Critical and geo-replication latency

#### Worker limits

SQL Server uses a worker pool of threads but has limits on the maximum number of workers. Applications with a large number of concurrent users might need a certain number of workers. Keep these points in mind on how worker limits are enforced for Azure SQL Database and SQL Managed Instance:

- Azure SQL Database has limits based on service tier and size. If you exceed this limit, a new query receives an error.
- At the current time, SQL Managed Instance uses `max worker threads`, so workers past this limit might see THREADPOOL waits.

#### Business Critical HADR waits

If you use a Business Critical service tier, you might unexpectedly see the following wait types:

- HADR_SYNC_COMMIT
- HADR_DATABASE_FLOW_CONTROL
- HADR_THROTTLE_LOG_RATE_SEND_RECV

Even though these waits might not slow down your application, you might not be expecting to see these. They're normally specific to using an Always On availability group. Business Critical tiers use availability group technology to implement SLA and availability features of a Business Critical service tier, so these wait types are expected. Note that long wait times might indicate a bottleneck such as I/O latency or replica behind.

#### Hyperscale

The Hyperscale architecture can result in some unique wait types that are prefixed with **RBIO** (a possible indication of log governance). In addition, DMVs, catalog views, and extended events have been enhanced to show metrics for page server reads.

You will now learn in an exercise how to monitor and solve a performance problem for Azure SQL by using the tools and knowledge you have gained in this unit.
