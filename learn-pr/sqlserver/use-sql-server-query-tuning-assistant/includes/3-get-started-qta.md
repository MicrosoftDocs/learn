Suppose you work for a national/regional grocery chain, with many critical applications running on SQL Server. You want to migrate two production databases from SQL Server 2012 to a new SQL Server 2019 instance. The databases are heavily used throughout the working day, so you're going to leave the compatibility levels at the original settings and repoint the applications. You want to measure the performance of the queries before you change the compatibility level of the databases to SQL Server 2019, because the cardinality estimator has changed since SQL Server 2014.

You want to find and fix any queries that regress when the compatibility level is moved and the new cardinality estimator algorithm is applied. Using this approach creates a baseline for performance to be measured against after upgrading the compatibility level. Enabling the Query Store and using the Query Tuning Assistant (QTA) will gather the metrics needed to find regressing queries.

## What is the Query Store?

The Query Store feature was introduced in SQL Server 2016 to continuously collect information about the execution and performance of queries within a database. It operates like a flight-data recorder, by gathering runtime information on queries and plans. If you save this runtime data, you can track performance over time. By default, the Query Store isn't enabled on a database, but any database on an instance of SQL Server 2016 or higher can take advantage of it. This advantage includes databases with an earlier compatibility level than the instance. If you migrate a database from SQL Server 2012 to SQL Server 2019 and leave the compatibility level at 110, Query Store can still operate on the database.

After enabling the Query Store on a database, statistics are gathered for your queries and categorized as:

- Regressed Queries
- Overall Resource Consumption
- Top Resource Consuming Queries
- Queries with Forced Plans
- Queries with High Variation
- Tracked Queries

A regressed query occurs when the query optimizer uses a different query plan that causes the performance to degrade. This regression happens after an important change, like adding a new index, a dropped or altered index, an update to the statistics, or a change in the data cardinality. Before Query Store, identifying the issue was a problem for database developers and administrators, because SQL Server provided no insight into the cause. However, you can use the Query Store to find regressed queries and force the optimizer to use a particular plan from history.

It's common for a small number of queries—out of possibly thousands—to consume the most system resource. The Query Store identifies which queries have the highest consumption, either because of regression or because of poor tuning. Depending on the configuration, you can filter by duration, CPU, memory, I/O, or number of executions.

You use the Query Store to monitor ongoing performance and for A/B testing. An A/B test compares performance before and after applying a single change. For example, when you performance tune a query, you add an index to a table referenced by a query, so the join lookup is faster. A comparison of the statistics in the Query Store before and after the index is added informs you if the index has affected performance. You could also use it when new hardware is added or an application is updated.

## What is the QTA?

The Query Tuning Assistant (QTA) uses the data captured by the Query Store to find queries that are beginning to regress. The QTA automatically experiments to find a solution that will speed up the query before it underperforms to the point of affecting users. You can use the Query Store and the QTA to monitor your database after upgrading. After migrating a database to SQL Server 2016 or higher, leave the compatibility level of the database unchanged, then enable Query Store. It collects query performance statistics you'll use as a baseline. When you then change the compatibility level, you know if each query is doing better, equally as well, or worse than before.

When the compatibility level is moved to upgrade the database, SQL Server changes the version of the cardinality estimator that's used. The QTA can find possible patterns of query regression because of the change in cardinality estimator, and experiments to find performance improvements. You can then create plan guides for those queries that showed improvement.

The Query Store continuously measures the performance statistics of your queries, just as an aircraft's flight-data recorder captures activity. When something goes wrong, there's a history of information to discover the cause of the problem. The Query Store can be enabled on any database on SQL Server 2016 or higher, whatever the compatibility level. Use the Query Store to continuously monitor query performance, and for A/B testing where you measure the outcome of a single change.

When you upgrade a database to SQL Server 2014 or higher, any changes to the cardinality estimator algorithm might slow queries that were fast in the previous version of SQL Server. Ideally, you want to find and fix any regression before users or customers are affected. Enabling the Query Store on your databases means that statistics are continuously gathered on the queries. Used with the QTA, regressing queries can be identified and fixed before becoming a problem.
