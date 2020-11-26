Azure Synapse Analytics is a high performing Massively Parallel Processing (MPP) engine that is built with loading and querying large datasets in mind. Many query performance enhancements are enabled by default for querying data from Azure Synapse Analytics, and additional capabilities and enhancements have both been inherited from the SQL Server product family, and have features also designed specifically to leverage the MPP capabilities within the dedicated SQL Pools architecture.

There are times though when performance expectations are not met, and it is necessary then to know what aspects of the table structures and architecture can be reviewed and adapted to maximize query performance. Symptoms that indicate that there are performance issues related to tables include:

## Poor query performance

The first indication of a poor query performance issue is typically from business users who may report that their business reports are slow, or sometime not even appearing.

## Poor load performance

Poor load performance may be reported by telemetry of the data loads through Azure Synapse pipelines, or you may get users reporting that the data in the reports is out of date. 

## Low concurrency

You may receive reports from your users that they may be unable to connect to the data warehouse to execute reports or queries.

The first response will be to ensure that the data warehouse is set to the appropriate service level range to ensure there is enough memory and concurrency slots available for multiple connections to the service. Scaling the service within the Azure portal, or Azure Synapse Studio, or issuing a Transact-SQL or the following PowerShell statement will address the issue of low concurrency.

```Powershell
Set-AzSqlDatabase -ResourceGroupName "resourcegroupname" -DatabaseName "mySampleDataWarehouse" -ServerName "sqlpoolservername" -RequestedServiceObjectiveName "DW300c"
```

Even with these changes, performance issue may not be resolved. Then you would have to explore other areas that we will explore in this module to resolve the issue.
