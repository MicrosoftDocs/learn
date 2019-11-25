Suppose you're a database administrator for a law firm, and over the weekend you've  migrated a number of databases to SQL Server 2017, including the Customer Relationship Management (CRM) database. You get into your office early on Monday morning, and are expecting the sales team to arrive within a couple of hours and begin making and receiving customer phone calls. The sales team is dependent on the CRM database and, in order for them to engage effectively with customers, the application must respond instantly.

After migrating the databases, you left the compatibility level at the previous setting. The CRM applications are connected to the new server, and you want to measure the performance of the queries in the new system against a typical Monday workload, before you alter the compatibility level. Maintaining the performance of queries is a crucial aspect when upgrading your databases. Rather than wait for the sales team to discover that the CRM application is slow, you want a process to automatically measure the workload and performance, and provide reassurance that you can fix any slow queries after changing the compatibility level.  

## Query Store

The **Query Store** feature was launched in SQL Server 2016 to continuously gather information about your queries. Query Store collects information that you can use to troubleshoot under-performing queries and works with both on-premise and cloud installations. Cached query plans are stored in the procedure cache but SQL Server only stores the most recent execution plan. In all likelihood, the execution plans for a query will change over time due to schema changes or the addition or deletion of indexes. Furthermore, pressures on memory can cause plans to be evicted from the plan cache.

By default, Query Store is not enabled when you create or migrate a database to SQL Server 2016 or SQL Server 2017. However, the Query Store feature can be enabled before you update the database compatibility level on your migrated database. You can enable Query Store by right-clicking on the database in **Object Explorer**, selecting **Properties**, then clicking on the **Query Store** page. In the **Operation Mode (Requested)** select list, you can choose from **Off**, **Read Only**, or **Read Write**. Query Store can also be enabled using Transact-SQL. To enable Query Store for a database named **CustomerServices**, you would run the following command:

```sql
ALTER DATABASE CustomerServices SET QUERY_STORE = ON
```

When a query is initially compiled, the query text and first plan are passed to the Query Store. If a query is recompiled, the plan in the Query Store is updated. If a new plan is created, Query Store adds the plan and saves it alongside previous plans, as well as the execution statistics. As the query is executed, Query Store saves the runtime statistics. During compilation or recompilation, SQL Server checks if a plan exists in the Query Store that should be applied to the query. When a forced plan differs from the plan in the procedure cache, the query is recompiled.

Until you change the compatibility level, the database is not exposed to the latest **Query Optimizer** changes, so you can collect a typical workload and create a baseline for measuring, on the existing compatibility level. After collecting enough query information to have your performance baseline, you can change the database compatibility level to the server version.

To create an adequate baseline, ensure you collect enough data from a typical period of business activity. When you move to the current server compatibility level, the workload is then exposed to the latest Query Optimizer. Query performance will likely improve because the new Query Optimizer should produce better plans. Sometimes SQL Server will use a less than optimal query plan, so it suddenly starts executing slowly and with no apparent reason. This problem can be fixed by forcing a previous plan in Query Store. Using Query Store is similar to using the **USE PLAN** query hint, but requires no change to user applications.

After moving the compatibility level, the Query Store continues to provide query support to maintain optimum performance. It measures and audits **Regressed Queries**, **Overall Resource Consumption**, **Top Resource Consuming Queries**, **Queries with Forced Plans**, **Queries with High Variation**, and **Tracked Queries**.

## Automatic query tuning

The role of the **Cardinality Estimator (CE)** in SQL Server is to estimate the number of rows returned in a query. The Query Optimizer uses the result of the CE to generate an execution plan. Up until SQL Server 2014, the Cardinality Estimator remained very much unchanged. The release of SQL Server 2014 saw an overhaul to the CE algorithms to improve estimates and deliver the quickest query results. However, the compatibility level of the database determines which CE will be used.

While query performance should very much be improved in SQL Server 2014 onwards, a migrated database with an updated compatibility level may suffer degraded performance. **Automatic Query Tuning** is a new feature in SQL Server 2017. You can use it in tandem with the Query Store to find and automatically fix regressing queries. After migrating your database and capturing the workload of the database at the previous compatibility level, you then upgrade the compatibility level and continue to run the Query Store. Automatic Tuning uses the data in the Query Store to find queries that are beginning to regress due to changes in the Cardinality Estimator after moving the compatibility level. Automatic Tuning experiments on the regressing queries to improve performance, enabling you to create plan guides where improvement has been made.

## How to tune query performance in SQL Server 2017

In the example of your law firm, because you have upgraded the database servers to SQL Server 2017, you can use both the Query Store and the Automatic Tuning to optimize performance and ensure that the change in compatibility level does not cause regressions. The recommended process is as follows:

1. Upgrade the database server to SQL Server 2017 but do not change the compatibility level.
1. Enable the Query Store.
1. Allow the Query Store to collect performance data across normal business hours.
1. Upgrade the database compatibility level.
1. Check to see if the Query Store has found regressions. If so, you can force the last-known-good query plan to return to the higher performance level.

## Summary

The Query Store automates the process of monitoring the performance of your queries. This is a useful tool to run in the background to ensure your database continually delivers results in the fastest possible time. Combined with the Query Store, the Query Tuning Assistant leverages the data in the Query Store to find regressed queries in your upgraded databases. After migrating a database and upgrading the compatibility level to SQL Server 2014 or higher, the new Cardinality Estimator is used for guessing the number of rows returned by a query. You can use the QTA to find and fix queries that regress with the switch to the newer CE.