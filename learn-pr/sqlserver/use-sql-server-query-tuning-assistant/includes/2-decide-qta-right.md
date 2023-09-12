Suppose you support database applications for a large grocery company and you need to upgrade some production databases to SQL Server 2019. These databases run on old hardware and support for SQL Server has expired, or will soon.

System performance is crucial to the operation of the company's stores. Orders placed with suppliers for perishable goods must be in line with warehouse storage availability. There's limited space for storing fresh and frozen produce, so orders must be placed precisely.

To maintain performance after the upgrades, you want to find the best method for identifying regressed queries. You're aware of query plan regression following an upgrade and the potential for performance loss. You want to ensure that performance doesn't become a serious issue. Also, you need to find the best way to mitigate regressing queries.

## Get started with the Query Tuning Assistant

The Query Tuning Assistant (QTA) depends on the data in the **Query Store** to find queries that have regressed since an upgrade. The Query Store was introduced in SQL Server 2016, and QTA was introduced in SQL Server 2017, so SQL Server 2019 uses both these features. These tools are integrated into SQL Server Management Studio, and operate at the database level.

The Query Store can gather data for any database version on an instance of SQL Server 2019, as can QTA. This feature enables you to collect metrics on older database versions before you upgrade. The compatibility level of the database on the instance determines the version. The version then determines which cardinality estimator is used. The cardinality estimator predicts how many rows a query is likely to return.

QTA uses the baseline and observed query performance data for a database measured by the Query Store. Query Store reports regressed queries and queries that consume the most system resources. QTA uses the results from the Query Store to experiment on the queries and improve performance.

## QTA and Automatic Plan Correction (APC)

When SQL Server runs a query, it analyzes possible plans that could be used to execute the Transact-SQL (T-SQL). Plans for queries that were successfully executed are cached for reuse when the query is executed again. SQL Server picks the optimal plan for the query and uses it until a circumstance forces it to pick a new one; for example, when the database engine recompiles the plan, an index is added or removed, or statistics are changed. It's not always the case that the new plan is an improvement on the old one. You can run the following command to look for queries that have a regressed plan:

```sql
SELECT * FROM sys.dm_db_tuning_recommendations
```

Optionally, you could use the **sp_force_plan** stored procedure to force SQL Server to use a specific plan:

```sql
EXEC sp_force_plan @query_id = 1187, @plan_id = 1975
```

 The sp_force_plan procedure is a manual process that's potentially tedious if many queries are regressing; for example, on an upgraded database. However, SQL Server 2017 introduced another new feature to autotune queries, named **Automatic Plan Correction (APC)**. This feature removes the need for manual intervention, and works differently to the QTA. You enable APC on a database by running the following statement:

```sql
ALTER DATABASE FreshFoods SET AUTOMATIC_TUNING (FORCE_LAST_GOOD_PLAN = ON)
```

Set at a database level, APC instructs SQL Server to use the last good plan. Regression is found while the current plan is executing. SQL Server continues to monitor the plan to ensure it delivers optimal performance. However, this "using last good" plan can mean rolling back to an earlier cardinality estimator. The QTA runs its experiments using the current version of the cardinality estimator mapped to the compatibility level.

The QTA is available in SQL Server 2019 and depends on the Query Store to operate. QTA must have Query Store baseline data for a database at its previous compatibility level, so it can observe queries and make comparisons after an upgrade. The APC introduced in SQL Server 2017 removes the manual identification and forcing of a query plan. It can be enabled at the database level, but might alter the version of the cardinality estimator.
