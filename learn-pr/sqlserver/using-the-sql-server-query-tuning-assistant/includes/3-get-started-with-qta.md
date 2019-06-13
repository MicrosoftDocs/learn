Suppose you work for a national grocery chain, with many critical applications running on SQL Server. You want to migrate two production databases from SQL Server 2005 and SQL Server 2008 R2 to a new SQL Server 2017 instance. The databases are heavily used throughout the working day, so you have decided to leave the compatibility levels at the original settings, and repoint the applications. You want to measure the performance of the queries before you change the compatibility level of the databases to SQL Server 2017, because the cardinality estimator has changed since SQL Server 2014.

You want to find and fix any queries that regress when the compatibility level is moved and the new cardinality estimator algorithm is applied. Using this approach creates a baseline for the performance to be measured against after upgrading the compatibility level. Enabling the Query Store and using the Query Tuning Assistant (QTA) will gather the metrics needed to find regressing queries.

## What is the Query Store?

The Query Store feature was introduced in SQL Server 2016 to continuously collect information about the execution and performance of queries within a database. It operates like a flight data recorder, by gathering runtime information on queries and plans. If you save this runtime data, you can track performance over time. By default, the Query Store isn't enabled on a database, but any database on an instance of SQL Server 2016 or higher can take advantage of it. This advantage includes databases with an earlier compatibility level than the instance, so if you migrate a database from SQL Server 2008 to SQL Server 2017 and leave the compatibility level at 100, Query Store can still operate on the database.

After enabling the Query Store on a database, statistics are gathered for your queries and categorized as:

- Regressed Queries
- Overall Resource Consumption
- Top Resource Consuming Queries
- Queries with Forced Plans
- Queries with High Variation
- Tracked Queries

A regressed query occurs when the query optimizer decides to use a different query plan that causes the performance to degrade. This regression happens when an important change has been made, such as the addition of a new index, a dropped or altered index, an update to the statistics, or a change in the data cardinality. Before Query Store, identifying the issue was a problem for database developers and administrators, as SQL Server provided no insight into the cause. However, using the Query Store enables you to find regressed queries and force the optimizer to use a particular plan from history.

It's common for a small number of queries, out of possibly thousands, to consume the most system resource. The Query Store identifies which queries have the highest consumption, either because of regression, or because of poor tuning. Depending on your configuration, you can filter by duration, CPU, memory, I/O, or number of executions.

As well as using the Query Store to monitor on-going performance, it is a useful tool for A/B testing. An A/B test compares performance before and after applying a single change. For example, when performance tuning a query, you decide to add an index to a table referenced by a query, so the join lookup is faster. A comparison of the statistics in the Query Store before and after the index is added informs you if the index has affected performance. It could also be used when new hardware is added or an application is updated.

## What is the QTA?

The Query Tuning Assistant (QTA) uses the data captured by the Query Store to find queries that are beginning to regress. The QTA automatically experiments to find a solution that will speed up the query before it under-performs to the point of affecting users. You can use the Query Store and the QTA to monitor your database after upgrading. After migrating a database to SQL Server 2016 or higher, leave the compatibility level of the database unchanged, and then enable Query Store. It collects query performance statistics that can be used as a baseline, so when you change the compatibility level, you know if each query is doing better, equally, or worse than before.

When the compatibility level is moved to upgrade the database, SQL Server then changes the version of the cardinality estimator that is used. The QTA can find possible patterns of query regression because of the change in cardinality estimator, and experiments to find performance improvements. You can then create plan guides for those queries that showed improvement.

## Summary

The Query Store continuously measures the performance statistics of your queries, just as a flight data recorder captures activity on a flight. When something goes wrong, you have a history of information to discover the cause of the problem. The Query Store can be enabled on any database on SQL Server 2016 or higher, whatever compatibility level. As well as using the Query Store to continuously monitor query performance, it's useful for A/B testing where you measure the outcome of a single change.

When you upgrade a database to a SQL Server 2014 or higher, you need to consider that changes to the cardinality estimator algorithm may slow down queries that were fast in the previous version of SQL Server. Ideally, you want to find and fix any regression before users or customers are affected. Enabling the Query Store on your databases enables statistics to be continuously gathered on the queries. Used in tandem with the QTA, regressing queries can be identified and fixed before becoming a problem.