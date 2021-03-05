In this module you learned about the performance capabilities of Azure SQL compared to SQL Server. You also learned performance tasks such as configuration and maintenance.

To deliver consistent performance, you need monitoring and troubleshooting. In this module, you learned the various methods and tools to monitor and troubleshoot performance with hands-on activities for a CPU scaling scenario. You then learned how to improve CPU scaling for your workload without any migration required for your database. Improving application performance doesn't always require a new scale in Azure, so you learned a common performance bottleneck scenario that you improved by tuning the query workload.

Finally, you learned the unique capabilities of intelligent performance in Azure SQL Database. This includes intelligent query processing, automatic plan correction, and automatic indexing.

## Learn more

Learn more about Azure SQL performance with these resources:

- Fixed capacities to choose from for CPU, memory, and I/O. Study the resource limits for [Azure SQL Managed Instance](https://docs.microsoft.com/azure/azure-sql/managed-instance/resource-limits?azure-portal=true) and [Databases](https://docs.microsoft.com/azure/azure-sql/database/resource-limits-vcore-single-databases?azure-portal=true).
- [I/O configuration](https://techcommunity.microsoft.com/t5/datacat/storage-performance-best-practices-and-considerations-for-azure/ba-p/305525?azure-portal=true) for SQL Managed Instance might improve performance.
- Familiar tools exist, like DMVs and [extended events](https://docs.microsoft.com/azure/azure-sql/database/xevent-db-diff-from-svr?azure-portal=true).
- [Query Store](https://docs.microsoft.com/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store?azure-portal=true) is on by default and powers features like Automatic Tuning.
- You can use [Azure Metrics](https://docs.microsoft.com/azure/azure-monitor/platform/data-platform-metrics?azure-portal=true) to replace functionality like Windows Performance Monitor.
- You can use [sys.dm_db_resource_stats](https://docs.microsoft.com/sql/relational-databases/system-dynamic-management-views/sys-dm-db-resource-stats-azure-sql-database?view=azuresqldb-current&azure-portal=true), which is designed for Azure.
- You can use wait types specific to Azure, such as [LOG_RATE_GOVERNOR](https://docs.microsoft.com/azure/azure-sql/database/resource-limits-logical-server#transaction-log-rate-governance?azure-portal=true).
- [Scale](https://docs.microsoft.com/azure/azure-sql/database/scale-resources?azure-portal=true) up and down without the need to migrate.
- Take advantage of intelligent performance to get faster. [Automatic tuning](https://docs.microsoft.com/azure/azure-sql/database/automatic-tuning-overview?azure-portal=true) uses machine learning to recommend important performance best practices, such as indexes.