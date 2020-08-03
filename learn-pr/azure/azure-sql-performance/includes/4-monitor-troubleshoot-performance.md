Monitoring and troubleshooting is a key element to deliver consistent performance. Azure SQL has the same tools and features as SQL Server to monitor and troubleshoot performance plus additional capabilities. This includes features like Dynamic Management Views (DMV), Extended Events, and Azure Monitor. It is also important to learn how to use these tools and capabilities across various performance scenarios for Azure SQL like high CPU or waiting on a resource.

## Tools and capabilities to monitor performance

Azure SQL provides monitoring and troubleshooting capabilities in the Azure ecosystem as well familiar tools that come with SQL Server. These include the following:

### Azure Monitor

Azure Monitor is part of the Azure ecosystem and Azure SQL is integrated to support Azure Metrics, Alerts, and Logs. Azure Monitor data can be visualized in the Azure portal or accessed by applications through Azure Event Hub or APIs. An example of why Azure Monitor is important is accessing resource usage metrics for Azure SQL outside of SQL Server tools much like Windows Performance Monitor.

### Dynamic Management Views (DMV)

Azure SQL provides the same DMV infrastructure as with SQL Server with a few differences. DMVs are a crucial aspect to performance monitoring since you can view key SQL Server performance data using standard T-SQL queries. Information such as active queries, resource usage, query plans, and resource wait types. Learn more details about DMVs with Azure SQL later in this unit.

### Extended Events

Azure SQL provides the same Extended Events infrastructure as with SQL Server with a few differences. Extended Events is a method to trace key events of execution within SQL Server that powers Azure SQL. For performance, extended events allow you to trace the execution of individual queries. Learn more details about Extended Events with Azure SQL later in this unit.

### Lightweight Query Profiling

Lightweight Query Profiling is a capability to examine the query plan and running state of an active query. This is a key feature to debug query performance for statements as they are running. This capability cuts down the time for you to solve performance problems vs using tools like Extended Events to trace query performance. Lightweight Query Profiling is accessed through DMVs and is on by default for Azure SQL just like SQL Server 2019.

### Query Plan debug capabilities

In some situations, you may need additional details about query performance for an individual T-SQL statement. T-SQL SET statements such as SHOWPLAN and STATISTICS can provide these details and are fully supported for Azure SQL as they are for SQL Server.

### Query Store

Query Store is a historical record of performance execution for queries stored in the user database. Query Store is on by default for Azure SQL and is used to provide capabilities such as Automatic Plan Correction and Automatic Tuning. SQL Server Management Studio (SSMS) reports for Query Store are available for Azure SQL. These reports can be used to find top resource consuming queries including query plan differences and top wait types to look at resource wait scenarios.

### Performance Visualizations

For Azure SQL Database, we have integrated Query Store performance information into the Azure portal through visualizations. This way you can see some of the same information for Query Store as you would with a client tool like SSMS by just using the Azure portal options called **Performance Overview** and **Query Performance Insight**.

## Dynamic Management Views (DMV) details

Dynamic Management Views (DMV) have been a driving force to monitor and troubleshoot performance for many years with SQL Server. Common DMVs for SQL Server are available with Azure SQL and some additional ones specific to Azure.

### Azure SQL Managed Instance

All DMVs for SQL Server are available for Managed Instance. Key DMVs like **sys.dm_exec_requests** and **sys.dm_os_wait_stats** are commonly used to examine query performance.

One DMV is specific to Azure called **sys.server_resource_stats** and shows historical resource usage for the Managed Instance. This is an important DMV to see resource usage since you do not have direct access to OS tools like Performance Monitor.

### Azure SQL Database

Most of the common DMVs you need for performance including **sys.dm_exec_requests** and **sys.dm_os_wait_stats** are available. It is important to know that these DMVs only provide information specific to the database and not across all databases for a logical server.

**sys.dm_db_resource_stats** is a DMV specific to Azure SQL Database and can be used to view a history of resource usage for the database. Use this DMV similar to how you would use sys.server_resource_stats for a Managed Instance.

**sys.elastic_pool_resource_stats** is similar to sys.dm_db_resource_stats but can be used to view resource usage for elastic pool databases.

### DMVs you will need

There are a few DMVs worth calling out you will need to solve certain performance scenarios for Azure SQL including:

- **sys.dm_io_virtual_file_stats** is important for Azure SQL since you don't have direct access to operating system metrics for I/O performance per file.
- **sys.dm_os_performance_counters** is available for both Azure SQL Database and Managed Instance to see SQL Server common performance metrics. This can be used to view SQL Server Performance Counter information that is typically available in Performance Monitor.
- **sys.dm_instance_resource_governance** can be used to view resource limits for a Managed Instance. You can view this information to see what your expected resource limits should be without using the Azure portal.
- **sys.dm_user_db_resource_governance** can be used to see common resource limits per the deployment option, service tier, and size for your Azure SQL Database deployment. You can view this information to see what your expected resource limits should be without using the Azure portal.

### DMVs for deeper insights

These DMVs provide deeper insight into resource limits and resource governance for Azure SQL. They are not meant to be used for common scenarios but might be helpful when looking deep into complex performance problems. Consult the documentation for all the details of these DMVs:

- **sys.dm_user_db_resource_governance_internal** (Managed Instance only)
- **sys.dm_resource_governor_resource_pools_history_ex**
- **sys.dm_resource_governor_workload_groups_history_ex**

## Extended Events details

Extended Events is the tracing mechanism for SQL Server. Extended events for Azure SQL is based on the SQL Server engine and therefore is the same for Azure SQL with a few notable differences:

### Extended Events for Azure SQL Database

Extended Events can be used for Azure SQL Database just like SQL Server by creating sessions and using events, actions, and targets. Keep these important points in mind when creating extended event sessions:

- Most commonly used Events and Actions are supported
- File, ring_buffer, and counter targets are supported
- File targets are supported with Azure Blob Storage since you don't have access to the underlying operating system disks.

You can use SSMS or T-SQL to create and start sessions. You can use SSMS to view extended event session target data or the system function **sys.fn_xe_file_target_read_file**. 

> [!NOTE]
> Note that the ability with SSMS to View Live Data is not available for Azure SQL Database.

It is important to know that any extended events fired for your sessions are specific to your database and not across the logical server.

### Extended Events for Azure SQL Managed Instance

Extended Events can be used for Azure SQL Managed Instance just like SQL Server by creating sessions and using events, actions, and targets. Keep these important points in mind when creating extended event sessions:

- All events, targets, and actions are supported.
- File targets are supported with Azure Blob Storage since you don't have access to the underlying operating system disks.
- Some specific events are added for Managed Instance to trace events specific to the management and execution of the instance.

You can use SSMS or T-SQL to create and start sessions. You can use SSMS to view extended event session target data or the system function **sys.fn_xe_file_target_read_file**. The ability with SSMS to View Live Data is supported for Managed Instance.

## Performance scenarios for Azure SQL

In order to decide how to apply monitoring and troubleshooting performance tools and capabilities, it is important to look at performance for Azure SQL through *scenarios*.

### Common performance scenarios

A common technique for SQL Server performance troubleshooting is to examine if a performance problem is **Running** (high CPU) or **Waiting** (waiting on a resource). This is a way to "divide and conquer" a performance problem for SQL which can often be vague (i.e. "it is slow").

The following diagram shows a decision tree to determine if a SQL performance issue is running or waiting and how to use performance tools to determine the cause and solution.

:::image type="content" source="../media/4-running-vs-waiting.svg" alt-text="Diagram of running versus waiting." border="false":::

Let's dive more into the details of each aspect of the diagram.

#### Running vs waiting

Running or waiting scenarios can often be determined by looking at overall resource usage. For a standard SQL Server deployment you might use tools such as Performance Monitor in Windows or top in Linux. For Azure SQL, you can use the following methods:

- Azure portal/Powershell/Alerts

    Azure Monitor has integrated metrics to view resource usage for Azure SQL. You can also setup alerts to look for resource usage conditions.

- sys.dm_db_resource_stats

    For Azure SQL Database, you can look at this DMV to see CPU, memory, and I/O resource usage for the database deployment. This DMV takes a snapshot of this data every 15 seconds.

- sys.server_resource_stats

    This DMV behaves just like sys.dm_db_resource_stats but it used to see resource usage for the Managed Instance for CPU, memory, and I/O. This DMV also takes a snapshot every 15 seconds.

#### Running

If you have determined the problem is high CPU utilization, this is called a running scenario. A running scenario can involve queries that consume resources through compilation or execution. Further analysis to determine a solution can be done by using these tools:

- Query Store

    Use the Top Consuming Resource reports in SSMS, Query Store catalog views, or Query Performance Insight in the Azure portal (Azure SQL Database only) to find which queries are consuming the most CPU resources.

- sys.dm_exec_requests

    Use this DMV in Azure SQL to get a snapshot of the state of active queries. Look for queries with a state of RUNNABLE and a wait type of SOS_SCHEDULER_YIELD to see if you have enough CPU capacity.

- sys.dm_exec_query_stats

    This DMV can be used much like Query Store to find top resource consuming queries but only is available for query plans that are cached where Query Store provides a persistent historical record of performance. This DMV also allows you to find the query plan for a cached query.

- sys.dm_exec_procedure_stats

    This DMV provides information much like sys.dm_exec_query_stats except the performance information can be viewed at the stored procedure level.

    Once you determine what query or queries are consuming the most resources, you may have to examine whether you have enough CPU resources for your workload or debug query plans with tools like Lightweight Query Profiling, SET statements, Query Store, or Extended Events tracing.

#### Waiting

If your problem doesn't appear to be a high CPU resource usage, it could be the performance problem involves waiting on a resource. Scenarios involving waiting on resources include:

- I/O Waits
- Lock Waits
- Latch Waits
- Buffer Pool limits
- Memory Grants
- Plan Cache Eviction

To perform analysis on waiting scenarios you typically look at the following tools:

- sys.dm_os_wait_stats

    Use this DMV to see what are the top wait types for the database or instance. This can guide you on what action to take next depending on the top wait types.

- sys.dm_exec_requests

    Use this DMV to find specific wait types for active queries to see what resource they are waiting on. This could be a standard blocking scenario waiting on locks from other users.

- sys.dm_os_waiting_tasks

    Queries that use parallelism use multiple tasks for a given query so you may need to use this DMV to find wait types for a given task for a specific query.

- Query Store

    Query Store provides reports and catalog views that show an aggregation of the top waits for query plan execution. It is important to know that a wait of **CPU** is equivalent to a *running* problem.

> [!TIP]
> Extended Events can be used for any running or waiting scenarios but requires you to setup an extended events session to trace queries and can be considered a *heavier* method to debug a performance problem.

### Scenarios specific to Azure SQL

There are some performance scenarios, both running and waiting, that are specific to Azure SQL including log governance, worker limits, waits encountered using Business Critical service tiers, and waits specific to a Hyperscale deployment.

#### Log governance

Azure SQL can enforce resource limits on transaction log usage called *log rate governance*. This enforcement is often needed to ensure resource limits and to meet promised SLA. Log governance may be seen from the following wait types:

- LOG_RATE_GOVERNOR - waits for Azure SQL Database
- POOL_LOG_RATE_GOVERNOR - waits for Elastic Pools
- INSTANCE_LOG_GOVERNOR - waits for Azure SQL Managed Instance
- HADR_THROTTLE_LOG_RATE* - waits for Business Critical and Geo-Replication latency

#### Worker limits

SQL Server uses a worker pool of threads but has limits on the maximum number of workers. Applications with a large number of concurrent users may need a certain number of workers. Keep these points in mind on how worker limits are enforced for Azure SQL Database and Managed Instance:

- Azure SQL Database has limits based on service tier and size. If you exceed this limit, a new query would receive an error.
- At the current time, Azure SQL Managed Instance uses 'max worker threads' so workers past this limit may see THREADPOOL waits.

#### Business Critical HADR waits

If you use a Business Critical (BC) service tier you may *unexpectedly* see the following wait types:

- HADR_SYNC_COMMIT
- HADR_DATABASE_FLOW_CONTROL
- HADR_THROTTLE_LOG_RATE_SEND_RECV

Even though these waits may not slow down your application you may not be expecting to see these since they are specific to using an Always On Availability Group (AG). BC tiers use AG technology behind the scenes to implement SLA and availability features of a BC service tier so these wait types are expected (long wait times though may indicate a bottleneck such as I/O latency or replica behind).

#### Hyperscale

The Hyperscale architecture can result in some unique wait types that are prefixed with **RBIO** (a possible indication of log governance). In addition, DMVs, catalog views, and Extended Events have been enhanced to show metrics for Page Server reads.

You will now learn in an exercise how to monitor and solve a performance problem for Azure SQL using the tools and knowledge you have gained in this unit.