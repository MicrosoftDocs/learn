You're aware of potential query plan regression and performance loss following database version upgrades. To help maintain performance after database upgrades, you need to find the best method for identifying and mitigating regressed queries. You can use the Query Store and Query Tuning Assistant (QTA) to help ensure that reduced performance doesn't become an issue after the upgrades.

## Get started with the Query Store and QTA

The QTA depends on data in the Query Store to find queries that have regressed since an upgrade. The Query Store lets you collect metrics on older database versions before you upgrade.

The Query Store was introduced in SQL Server 2016, and the QTA was introduced in SQL Server 2017, so any database version running on an instance of SQL Server 2022 can use both these features. These tools are integrated into SQL Server Management Studio, and operate at the database level.

The compatibility level of the database determines the version, which determines the *cardinality estimator*. The cardinality estimator predicts how many rows a query is likely to return. SQL Server 2014 introduced an upgraded cardinality estimator algorithm that benefits most queries, but can rarely have a negative performance impact.

Query Store reports regressed queries and queries that consume the most system resources. QTA uses the Query Store baseline and observed query performance data to experiment on the queries and improve performance.

>[!NOTE]
>The QTA doesn't help with Azure SQL Database or SQL Managed Instance databases. Instead, consider using the [Azure SQL migration extension for Azure Data Studio](/sql/azure-data-studio/extensions/azure-sql-migration-extension).

## The QTA and automatic plan correction

When SQL Server runs a Transact-SQL (T-SQL) query, it analyzes possible plans that could be used to execute the query. SQL Server caches plans for queries that successfully execute and reuses them when the query is executed again.

SQL Server picks the optimal plan for the query and uses it until a circumstance forces it to pick a new one, such as when the database engine recompiles the plan, an index is added or removed, or statistics are changed. It's not always the case that the new plan is an improvement on the old one. You can run the following command to look for queries that have a regressed plan:

```sql
SELECT * FROM sys.dm_db_tuning_recommendations
```

You can optionally use the `sp_force_plan` stored procedure to force SQL Server to use a specific plan.

```sql
EXEC sp_force_plan @query_id = 1187, @plan_id = 1975
```

The `sp_force_plan` procedure is a manual process that's potentially tedious if many queries are regressing, such as on an upgraded database. SQL Server 2017 introduced a new feature named *automatic plan correction* to autotune queries and remove the need for manual intervention. You can enable automatic plan correction on a database by running the following statement:

```sql
ALTER DATABASE <database-name> SET AUTOMATIC_TUNING (FORCE_LAST_GOOD_PLAN = ON)
```

Automatic plan correction works differently from the QTA. When set at a database level, automatic plan correction instructs SQL Server to use the last good plan. SQL Server continues to monitor the current plan to ensure it delivers optimal performance and find regressions while the plan is executing.

However, using the last good plan can mean rolling back to an earlier cardinality estimator. Conversely, the QTA runs its experiments by using the current version of the cardinality estimator that's mapped to the compatibility level.

## Summary

The QTA is available in SQL Server 2022 and depends on the Query Store to operate. The QTA must have Query Store baseline data for a database at its previous compatibility level, so it can observe queries and make comparisons after an upgrade.

Automatic plan correction, introduced in SQL Server 2017, removes the manual identification and forcing of a query plan. Automatic plan correction can be enabled at the database level, but might alter the version of the cardinality estimator. The QTA uses the current version of the cardinality estimator that's mapped to the compatibility level.
