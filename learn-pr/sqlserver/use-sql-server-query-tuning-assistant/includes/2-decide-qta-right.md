Suppose you support database applications for a large grocery company and you need to upgrade a number of production databases to SQL Server 2017. These databases run on old hardware and support for SQL Server has either run out or is about to expire. The performance of the systems is crucial to the operation of the company's stores, as orders placed with suppliers for perishable goods must be in line with the warehouse storage availability. There's limited space for storing fresh and frozen produce, so orders must be placed with exact precision.

To maintain performance after the upgrades, you want to find the best method for identifying regressed queries. You're aware of query plan regression following an upgrade and the potential for performance loss and are keen to ensure that performance doesn't become a serious issue. You want to discover the best way to mitigate regressing queries.

## Get started with the Query Tuning Assistant

The Query Tuning Assistant (QTA) depends on the data in the **Query Store** to find queries that have regressed since an upgrade. Though the Query Store was introduced in SQL Server 2016, the QTA is a new feature in SQL Server 2017, so you need an instance of SQL Server 2017 to take advantage of these two features. Both tools are integrated into SQL Server Management Studio, and operate at the database level.

The Query Store can gather data for any database version on an instance of SQL Server 2017, as can QTA. This enables you to collect metrics on older database versions prior to upgrade. The compatibility level of the database on the instance determines the version, and the version determines which cardinality estimator is used. The cardinality estimator predicts how many rows a query is likely to return.

QTA uses the baseline and observed query performance data for a database measured by the Query Store. While the Query Store reports regressed queries and queries consuming the most system resources, QTA uses the results from the Query Store to experiment on the queries to improve their performance.

## QTA and Automatic Plan Correction

When running a query, SQL Server analyzes possible plans that could be used to execute the Transact-SQL (T-SQL). Plans for queries that were successfully executed are cached for reuse when the query is executed again. SQL Server picks the optimal plan for the query and uses it until a circumstance forces it to pick a new one, such as when the database engine recompiles the plan, an index is added or removed, or statistics are changed. It is not always the case that the new plan is an improvement on the old one. You can run the following command to look for queries that have a regressed plan:

```sql
SELECT * FROM sys.dm_db_tuning_recommendations
```

Optionally, you can then use the **sp_force_plan** stored procedure to force SQL Server to use a specific plan:

```sql
EXEC sp_force_plan @query_id = 1187, @plan_id = 1975
```

 The sp_force_plan procedure is a manual process that is potentially tedious if many queries are regressing, for example on an upgraded database. However, SQL Server 2017 introduced another new feature to autotune queries, named **Automatic Plan Correction (APC)**. This removes the need for manual intervention, and works differently to the QTA. You can enable APC on a database by running the following statement:

```sql
ALTER DATABASE FreshFoods SET AUTOMATIC_TUNING (FORCE_LAST_GOOD_PLAN = ON)
```

Set at a database level, APC instructs SQL Server to use the last good plan, when regression is found while the current plan is executing. SQL Server continues to monitor the plan to ensure it delivers optimal performance. However, the using last good plan can mean rolling back to an earlier cardinality estimator. The QTA runs its experiments using the current version of the cardinality estimator mapped to the compatibility level.

## Summary

The QTA is available in SQL Server 2017 and depends on the Query Store to operate. QTA must have Query Store baseline data for a database at its previous compatibility level, so that it can observe queries and make comparisons after an upgrade. The APC introduced in SQL Server 2017 removes the manual identification and forcing of a query plan. It can be enabled at the database level, but may alter the version of the cardinality estimator.

The rest of this module focuses on using the Query Store and the QTA to measure the performance of your databases after upgrading to SQL Server 2017.