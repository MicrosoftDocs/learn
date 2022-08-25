Azure Synapse Analytics is a high performing Massively Parallel Processing (MPP) engine that is built with loading and querying large datasets in mind. Many query performance enhancements are enabled by default for querying data from Azure Synapse Analytics, and additional capabilities and enhancements have both been inherited from the SQL Server product family, and have features also designed specifically to leverage the MPP capabilities within the dedicated SQL Pools architecture.

There are times though when performance expectations aren't met, and it's necessary then to know what aspects of the table structures and architecture can be reviewed and adapted to maximize query performance. Symptoms that indicate that there are performance issues related to tables include:

## Poor query performance

The first indication of a poor query performance issue is typically from business users who may report long running query times or queue times.  It's unlikely to run into an "unable to connect message" from a user standpoint unless the instance is paused.


## Poor load performance

Poor load performance may be reported by telemetry of the data loads through Azure Synapse pipelines, or users may be reporting that the data in the reports is out of date. 

## Low concurrency

With the implementation of workload groups the concept of concurrency slots no longer applies. Resources are allocated on a percentage basis and specified in the workload group definition. There are still minimum amounts of resourcees necessary for queries based upon the service level with a minimum of 4 concurrent queries at a service level of DW100c and 25 percent REQUEST_MIN_RESOURCE_GRANT_PERCENT.

Synapse SQL will still track resource utilization with the use of concurrency slots and a query will be queued based upon importance and available concurrency slots, they'll remain in the queue until enough concurrency slots are available. 

> [!Note]
> Importance and concurrency slots determine prioritization. There are five levels of importance including low, below_normal, normal, above_normal, and high without setting the request, it will default to normal.

The first response will be to ensure that the data warehouse is set to the appropriate service level range to ensure there's enough memory and concurrency slots available for multiple connections to the service. Scaling the service within the Azure portal, or Azure Synapse Studio, or issuing a Transact-SQL or the following PowerShell statement will address the issue of low priority.

```Powershell
Set-AzSqlDatabase -ResourceGroupName "resourcegroupname" -DatabaseName "mySampleDataWarehouse" -ServerName "sqlpoolservername" -RequestedServiceObjectiveName "DW300c"
```
To view queries and their assigned performance use sys.dm_pdw_exec_requests
> [!Note]
> sys.dm_pdw_exec_requests is not supported by serverless SQL pool in Azure Synapse Analytics, instead use sys.dm_exec_requests

Even with these changes, performance issue may not be resolved. The next step would be to explore other areas that will be explored later in this module to resolve the issue.
