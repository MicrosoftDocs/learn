You're aware of potential query plan regression and performance loss following database version upgrades. To help maintain performance after database upgrades, you need to find the best method for identifying and mitigating regressed queries. This unit describes how you can use the Query Store and Query Tuning Assistant (QTA) to help ensure that reduced performance isn't an issue after the upgrades.

## Get started with the Query Store and Query Tuning Assistant

The QTA depends on Query Store data to find queries that regress after an upgrade. The Query Store lets you collect metrics on the older database version before you upgrade.

The Query Store was introduced in SQL Server 2016, and the QTA was introduced in SQL Server 2017. Any database version that runs on an instance of SQL Server 2022 can use both of these features. These tools are integrated into SQL Server Management Studio (SSMS), and operate at the database level.

The compatibility level of the database determines its version, which in turn determines the *cardinality estimator* version it uses. The cardinality estimator predicts how many rows a query is likely to return, so the query optimizer can select the lowest-cost plan. SQL Server 2014 introduced an upgraded cardinality estimator algorithm that benefits most queries, but can rarely have a negative performance impact.

To measure performance impact, the Query Store reports regressed queries and queries that consume the most system resources. The QTA compares the Query Store query performance data before and after database upgrade, and experiments on the queries to improve performance.

>[!NOTE]
>The QTA isn't available for Azure SQL Database or SQL Managed Instance databases. For these databases, consider using the [Azure SQL migration extension for Azure Data Studio](/sql/azure-data-studio/extensions/azure-sql-migration-extension).

## The QTA and automatic plan correction

When SQL Server runs a Transact-SQL (T-SQL) query, it analyzes possible plans that can execute the query. SQL Server caches plans for queries that successfully execute and reuses them when the queries are executed again.

SQL Server picks the optimal plan for a query and uses it until a circumstance forces it to pick a new one. These circumstances can include the database engine recompiling the plan, an index being added or removed, or statistics being changed.

It's not always the case that the new plan is an improvement on the old one. You can run the following command to look for queries that have a regressed plan.

```sql
SELECT * FROM sys.dm_db_tuning_recommendations
```

You can then use the `sp_force_plan` stored procedure to force SQL Server to use a recommended specific plan.

```sql
EXEC sp_force_plan @query_id = 1187, @plan_id = 1975
```

The `sp_force_plan` procedure is a manual process that's potentially tedious if many queries are regressing on an upgraded database. SQL Server 2017 introduced a new feature named *automatic plan correction* to autotune queries and remove the need for manual intervention. You can enable automatic plan correction on a database by running the following statement:

```sql
ALTER DATABASE <database-name> SET AUTOMATIC_TUNING (FORCE_LAST_GOOD_PLAN = ON)
```

When set at a database level, automatic plan correction instructs SQL Server to use the last good query plan. SQL Server continues to monitor the plan to find regressions while the plan is executing and to ensure it delivers optimal performance.

Automatic plan correction works differently from the QTA. Using the last good plan can mean rolling back to an earlier cardinality estimator. Conversely, the QTA does its experiments using the version of the cardinality estimator that's mapped to the target database compatibility level.

## Summary

The QTA is available in SQL Server 2022 and depends on the Query Store to operate. The QTA must have Query Store baseline data for a database at its previous compatibility level, so it can observe queries and make comparisons after an upgrade.

Automatic plan correction, introduced in SQL Server 2017, removes the need to manually identify and force a query plan. Automatic plan correction can be enabled at the database level, but might roll back the version of the cardinality estimator. The QTA uses the version of the cardinality estimator that's mapped to the target compatibility level.
