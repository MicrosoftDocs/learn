Performance optimization in Azure SQL Database is a systematic process. You start with infrastructure decisions, work through concurrency controls, and apply diagnostic tools to find and fix the problems that affect your users.

In this module, you learned how to:

- **Recommend database configurations**: Evaluate vCore versus DTU resource models. Choose among General Purpose, Business Critical, and Hyperscale service tiers based on I/O latency, storage, and availability needs. Select provisioned or serverless compute to match workload patterns.
- **Preserve data integrity with isolation levels**: Understand the trade-off between consistency and concurrency across six isolation levels. Use RCSI and optimized locking (both enabled by default in Azure SQL Database) to minimize blocking.
- **Evaluate query performance**: Read execution plans to identify scans, row estimate errors, Key Lookups, and warnings. Query DMVs to find the most expensive queries, currently running requests, and missing indexes.
- **Monitor and tune with Query Store**: Force previous plans for immediate fixes. Apply Query Store hints without modifying application code. Visualize performance in the Azure portal with Query Performance Insight.
- **Identify and resolve blocking and deadlocks**: Find head blockers with `sys.dm_exec_requests`. Capture deadlock graphs through Extended Events. Prevent concurrency issues by keeping transactions short, accessing objects in consistent order, and implementing retry logic for error 1205.

## Learn more

- [vCore purchasing model - Azure SQL Database](/azure/azure-sql/database/service-tiers-sql-database-vcore)
- [Transaction locking and row versioning guide](/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide)
- [Execution plan overview](/sql/relational-databases/performance/execution-plans)
- [Monitor performance by using the Query Store](/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store)
- [Query Performance Insight for Azure SQL Database](/azure/azure-sql/database/query-performance-insight-use)
- [Understand and resolve blocking in Azure SQL Database](/azure/azure-sql/database/understand-resolve-blocking)
- [Deadlocks guide](/sql/relational-databases/sql-server-deadlocks-guide)
