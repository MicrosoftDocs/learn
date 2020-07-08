In this section you will learn about what monitoring and troubleshooting capabilities exist for Azure SQL as compared to SQL Server.

## Tools and features for performance

Azure SQL provides monitoring and troubleshooting capabilities in the Azure ecosystem as well familiar tools that come with SQL Server. These include the following:

### Azure Monitor

Azure Monitor is part of the Azure ecosystem and Azure SQL is integrated to support Azure Metrics, Alerts, and Logs.

### Dynamic Management Views (DMV)

Azure SQL provides the same DMV infrastructure as with SQL Server with a few differences. Learn more details about DMVs with Azure SQL later in this section of the module.

### Extended Events

Azure SQL provides the same Extended Events infrastructure as with SQL Server with a few differences. Learn more details about Extended Events with Azure SQL later in this section of the module.

### Lightweight Query Profiling

Lightweight Query Profiling is on by default and can be useful to examine the query plans and progress of active queries.

### Query Plan Debugging

All T-SQL SET statements such as SET SHOWPLAN and SET STATISTICS are available in Azure SQL.

### Query Store

Query Store is on by default for Azure SQL and is used to provide capabilities such as Automatic Plan Correction and Automatic Tuning. SQL Server Management Studio (SSMS) reports for Query Store are available for Azure SQL.

### Performance Visualizations

The Azure Portal can be used to view common metrics data for Azure SQL through Azure Metric Explorer.

Azure SQL Database uses the Query Store to provide performance visualization for query performance analysis including **Query Performance Insight**.

## Dynamic Management Views (DMV) details

Dynamic Management Views (DMV) have been a driving force to monitor and troubleshoot performance for many years with SQL Server. Common DMVs for SQL Server are available with Azure SQL and some additional ones specific to Azure.

### Azure SQL Managed Instance

- All DMVs for SQL Server are available for Managed Instance
- One DMV is specific to Azure called **sys.server_resource_stats** and shows historical resource usage for the Managed Instance.

### Azure SQL Database

- Most of the common DMVs you need for performance (Ex. **sys.dm_exec_requests**) are available
-**sys.dm_db_resource_stats** can be used to view a history of resource usage for the database
- **sys.elastic_pool_resource_stats** can be used to view resource usage for elastic pools.

### DMVs you will need

- **sys.dm_io_virtual_file_stats** is important for Azure SQL since you don't have direct access to operating system metrics for I/O performance per file.
- **sys.dm_os_performance_counters** is available for both Azure SQL Database and Managed Instance to see SQL Server common performance metrics.
- **sys.dm_instance_resource_governance** can be used to seem resource limits for a Managed Instance.
- **sys.dm_user_db_resource_governance** can be used to see common resource limits per the deployment option, service tier, and size for your Azure SQL deployment.

### DMVs for deep troubleshooting

These DMVs provide deeper insight into resource limits and resource governance for Azure SQL. They are not mean to be used for common scenarios but might be helpful when looking deep into a complex performance problem:

- **sys.dm_user_db_resource_governance_internal**
- **sys.dm_resource_governor_resource_pools_history_ex**
- **sys.dm_resource_governor_workload_groups_history_ex**

## Extended Events details

Extended Events is the tracing mechanism for SQL Server. Extended events for Azure SQL is based on the SQL Server engine and therefore is the same with a few notable differences:

### Extended Events for Azure SQL Database

- Most commonly used Events and Actions are supported
- File, ring_buffer, and counter targets are supported. File
- File targets are supported with Azure Blob Storage

### Extended Events for Azure SQL Managed Instance

- All events, targets, and actions are supported
- File targets are supported with Azure Blog Storage
- Some specific events are added for Managed Instance

## Performance Scenarios for Azure SQL

In order to decide how to apply monitoring and troubleshooting performance tools and capabilities, it is important to look at performance for Azure SQL through *scenarios*.

### Common Performance Scenarios

A common technique for SQL Server performance troubleshooting is to examine where the problem is Running (high CPU) or Waiting (Waiting on a Resource)

![runningvswaiting](../media/runningvswaiting.png)

#### Running vs Waiting

Running or waiting scenarios can often be determined by looking at overall resource usage. For Azure SQL this will involve viewing:

- sys.dm_db_resource_stats
- sys.server_resource_stats
- Azure Portal/Powershell/Alerts

#### Running

A running scenario can involve queries that consume resources through compilation or execution. Further analysis can be done looking at:

- Query Store
- sys.dm_exec_requests
- SOS_SCHEDULER_YIELD waits
- sys.dm_exec_query_stats
- sys.dm_exec_procedure stats

#### Waiting

Scenarios involving waiting on resources can involve waits such as:

- I/O Waits
- Lock Waits
- Latch Waits
- Buffer Pool limits
- Memory Grants
- Plan Cache Eviction
- Other Scenarios

To perform analysis on waiting scenarios you typically look at:

- sys.dm_os_wait_stats
- sys.dm_exec_requests
- sys.dm_os_waiting_tasks
- Query Store

### Scenarios specific to Azure SQL

There are some performance scenarios that are specific to Azure SQL including log governance, worker limits, waits encountered using Business Critical service tiers, and waits specific to a Hyperscale deployment.

#### Log governance

Azure SQL can put limits on transaction log usage called *log rate governance*. Log governance may be seen from the following types of waits:

- LOG_RATE_GOVERNOR - waits for Azure SQL Database
- POOL_LOG_RATE_GOVERNOR - waits for Elastic Pools
- INSTANCE_LOG_GOVERNOR - waits for Azure SQL Managed Instance
- HADR_THROTTLE_LOG_RATE* - waits for Business Critical and Geo-Replication latency

#### Worker limits

SQL Server uses a worker pool of threads but has limits on the maximum number of workers:

- Azure SQL Database has limits based on service tier and size. If you exceed this limit, a new query would receive an error.
- Azure SQL Managed Instance uses 'max worker threads' so workers past this limit may see THREADPOOL waits.

**Note**: Managed Instance in the future may enforce worker limits similar to Azure SQL Database.

#### Business Critical HADR Waits

If you use a Business Critical service tier you may unexpectedly see the following wait types:

- HADR_SYNC_COMMIT
- HADR_DATABASE_FLOW_CONTROL
- HADR_THROTTLE_LOG_RATE_SEND_RECV

Even though these waits may not slow down your application you may not be expecting to see these since they are specific to using an Always On Availability Group (AG). Business Critical (BC) tiers use AG technology behind the scenes to implement SLA and features of a BC service tier.

#### Hyperscale

The Hyperscale unique architecture can result in some unique performance wait types that are prefixed with **RBIO**

In addition, DMVs, catalog views, and Extended Events have been enhanced to show metrics for Page Server reads.

You will now learn in an exercise how to monitor and solve a performance problem for Azure SQL using the tools and knowledge you have gained in this unit.