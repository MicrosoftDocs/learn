In this section, you will learn about some of the common performance scenarios and scenarios specific to Azure SQL

## Common Performance Scenarios

A common technique for SQL Server performance troubleshooting is to examine where the problem is Running (high CPU) or Waiting (Waiting on a Resource)

![runningvswaiting](../media/runningvswaiting.png)

### Running vs Waiting

Running or waiting scenarios can often be determined by looking at overall resource usage. For Azure SQL this will involve viewing:

- sys.dm_db_resource_stats
- sys.server_resource_stats
- Azure Portal/Powershell/Alerts

### Running

A running scenario can involve queries that consume resources through compilation or execution. Further analysis can be done looking at:

- Query Store
- sys.dm_exec_requests
- SOS_SCHEDULER_YIELD waits
- sys.dm_exec_query_stats
- sys.dm_exec_procedure stats

### Waiting

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

## Scenarios specific to Azure SQL

There are some performance scenarios that are specific to Azure SQL.

### Log governance

Azure SQL can put limits on transaction log usage called *log rate governance*. Log governance may be seen from the following types of waits:

- LOG_RATE_GOVERNOR - waits for Azure SQL Database
- POOL_LOG_RATE_GOVERNOR - waits for Elastic Pools
- INSTANCE_LOG_GOVERNOR - waits for Azure SQL Managed Instance
- HADR_THROTTLE_LOG_RATE* - waits for Business Critical and Geo-Replication latency

### Worker limits

SQL Server uses a worker pool of threads but has limits on the maximum number of workers:

- Azure SQL Database has limits based on service tier and size. If you exceed this limit, a new query would receive an error.
- Azure SQL Managed Instance uses 'max worker threads' so workers past this limit may see THREADPOOL waits.

**Note**: Managed Instance in the future may enforce worker limits similar to Azure SQL Database.

### Business Critical HADR Waits

If you use a Business Critical service tier you may unexpectedly see the following wait types:

- HADR_SYNC_COMMIT
- HADR_DATABASE_FLOW_CONTROL
- HADR_THROTTLE_LOG_RATE_SEND_RECV

Even though these waits may not slow down your application you may not be expecting to see these since they are specific to using an Always On Availability Group (AG). Business Critical (BC) tiers use AG technology behind the scenes to implement SLA and features of a BC service tier.

### Hyperscale

The Hyperscale unique architecture can result in some unique performance wait types that are prefixed with **RBIO**

In addition, DMVs, catalog views, and Extended Events have been enhanced to show metrics for Page Server reads.

You will now learn in an exercise how to monitor and solve a performance problem for Azure SQL using the tools and knowledge you have gained to this point.