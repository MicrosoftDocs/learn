In this section you will learn about what monitoring and troubleshooting capabilities exist for Azure SQL as compared to SQL Server.

## Monitoring and Troubleshooting Performance

Azure SQL provides monitoring and troubleshooting capabilities in the Azure ecosystem as well familiar tools that come with SQL Server. These include the following:

### Azure Monitor

Azure Monitor is part of the Azure ecosystem and Azure SQL is integrated to support Azure Metrics, Alerts, and Logs

### Dynamic Management Views (DMV)

Azure SQL provides the same DMV infrastructure as with SQL Server with a few differences. Learn more details about DMVs with Azure SQL later in this section of the module.

### Extended Events

Azure SQL provides the same Extended Events infrastructure as with SQL Server with a few differences. Learn more details about Extended Events with Azure SQL later in this section of the module.

### Lightweight Query Profiling

Lightweight Query Profiling is on by default and can be useful to examine the query plans and progress of active queries.

### Query Plan Debugging

All T-SQL SET statements such as SET SHOWPLAN and SET STATISTICS are available in Azure SQL

### Query Store

Query Store is on by default for Azure SQL and is used to provide capabilities such as Automatic Plan Correction and Automatic Tuning. SQL Server Management Studio (SSMS) reports for Query Store are available for Azure SQL

### Performance Visualizations

The Azure Portal can be used to view common metrics data for Azure SQL through Azure Metric Explorer.

Azure SQL Database uses the Query Store to provide performance visualization for query performance analysis including **Query Performance Insight**.

## Dynamic Management Views (DMV)

Dynamic Management Views (DMV) have been a driving force to monitor and troubleshoot performance for many years with SQL Server. Common DMVs for SQL Server are available with Azure SQL and some additional ones specific to Azure

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

### Geek out with these

These DMVs provide deeper insight into resource limits and resource governance for Azure SQL. They are not mean to be used for common scenarios but might be helpful when looking deep into a complex performance problem:

- **sys.dm_user_db_resource_governance_internal**
- **sys.dm_resource_governor_resource_pools_history_ex**
- **sys.dm_resource_governor_workload_groups_history_ex**

## Extended Events

Extended events is the de factor tracing mechanism for SQL Server. Extended events for Azure SQL is based on the SQL Server engine and therefore is the same with a few notable differences:

### Azure SQL Database

- Most commonly used Events and Actions are supported
- File, ring_buffer, and counter targets are supported. File
- File targets are supported with Azure Blob Storage

### Azure SQL Managed Instance

- All events, targets, and actions are supported
- File targets are supported with Azure Blog Storage
- Some specific events are added for Managed Instance