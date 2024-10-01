In this module, you learned how the Query Store feature offers data collection to continually monitor query performance. You can enable the Query Store on any database running on an instance of SQL Server 2016 or higher, regardless of the database compatibility level. The Query Store is also useful for A/B testing where you measure the effect of one change, like upgrading a database or adding or altering an index.

You learned about the cardinality estimator algorithm, which was rewritten in SQL Server 2014. When the compatibility level of a migrated database is upgraded, the new cardinality estimator is used. This change in estimator might cause performance issues that the Query Store and the Query Tuning Assistant (QTA) can help you resolve. The QTA identifies regressing queries and experiments to find the best performance fix. You can then use the fixes to create plan guides.

The combination of the Query Store and QTA is ideal for monitoring database performance after an upgrade. You learned how to migrate a database to SQL Server 2022, leave the compatibility level in place, and enable the Query Store to collect baseline data. After you gather enough statistics, you can change the database compatibility, and the Query Store continues to gather data on the upgraded database. The QTA compares the data from before and after the upgrade to address regressing queries.

For more information about using the Query Store and the QTA, see the following articles:

- [Monitor performance by using the Query Store](/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store)
- [Upgrade databases using the Query Tuning Assistant](/sql/relational-databases/performance/upgrade-dbcompat-using-qta)
- [Change the database compatibility level and use the Query Store](/sql/database-engine/install-windows/change-the-database-compatibility-mode-and-use-the-query-store)
- [Cardinality Estimation (SQL Server)](/sql/relational-databases/performance/cardinality-estimation-sql-server)
- [Azure SQL migration extension for Azure Data Studio](/sql/azure-data-studio/extensions/azure-sql-migration-extension)
