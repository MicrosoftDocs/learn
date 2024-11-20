You plan to migrate two production databases from SQL Server 2012 to a new SQL Server 2022 instance. Because the databases are in use, you want to initially leave the compatibility levels at the original settings and repoint the applications. The cardinality estimator has changed since SQL Server 2014, and you want to measure query performance before you change the compatibility level of the databases to SQL Server 2022 (160).

You need to find and fix any queries that regress when you move the compatibility level and apply the new cardinality estimator algorithm. Using this approach measures a baseline for performance to compare against after you upgrade the compatibility level.

Enabling the Query Store gathers the metrics you need to find regressing queries, and using the Query Tuning Assistant (QTA) guides you through fixing the regressing queries. This unit provides an overview of the Query Store and the QTA.

## Query Store overview

The Query Store feature was introduced in SQL Server 2016 to continuously collect information about the execution and performance of queries within a database. The Query Store operates like a flight-data recorder to gather runtime information on queries and plans. If you save this runtime data, you can track performance over time. If something goes wrong, there's a history of information to discover the cause of the problem.

Starting with SQL Server 2022, and in Azure SQL Database and SQL Managed Instance, the Query Store is enabled for new databases by default. In SQL Server 2016, SQL Server 2017, and SQL Server 2019, the Query Store isn't enabled by default, but any database on an instance of SQL Server 2016 or higher can enable, disable, and configure the Query Store. See the next unit for instructions on how to enable Query Store or confirm its configuration on a database.

Query Store can work on databases with earlier compatibility levels than the SQL Server instance. For example, if you migrate a database from SQL Server 2012 to SQL Server 2022 and leave the compatibility level at 110, Query Store can still operate on the database.

However, many features of Intelligent Query Processing and other automatic performance improvements are enabled only for newer database compatibility levels. Therefore, you should try to test your application performance on the latest SQL Server database compatibility level. The Query Store and QTA can assist with this performance testing.

When enabled on a database, Query Store gathers and reports the following statistics for your queries:

- Regressed Queries
- Overall Resource Consumption
- Top Resource Consuming Queries
- Queries With Forced Plans
- Queries With High Variation
- Query Wait Statistics
- Tracked Queries

A regressed query occurs when the query optimizer uses a new query plan that causes performance to degrade. Regression can happen after important changes like adding, dropping, or altering an index, updating statistics, or changing data cardinality.

Before Query Store, SQL Server provided no insight into the cause of regressions, and identifying issues was a problem for database developers and administrators. You can now use the Query Store to find regressed queries and force the optimizer to use a particular plan from history.

It's common for a few out of possibly thousands of queries to consume the most system resource. The Query Store identifies which queries have the highest consumption, either because of regression or because of poor tuning. Depending on the configuration, you can filter results by duration, CPU, memory, I/O, or number of executions.

You can use the Query Store to monitor ongoing performance and for A/B testing to compare performance before and after applying a single change. For example, you can performance tune a query by adding an index to a table that the query references, so the join lookup is faster. Comparing the statistics in the Query Store before and after you add the index tells you whether the index affects performance. You might also compare statistics after adding new hardware or updating an application.

## Query Tuning Assistant overview

The Query Tuning Assistant (QTA) uses data from the Query Store to find queries that are beginning to regress. The QTA automatically experiments to find a solution that speeds up the query, before the query underperforms to the point of affecting users.

You can use the Query Store and the QTA to monitor and optimize database performance after upgrading. After migrating a database to SQL Server 2016 or higher, you leave the compatibility level of the database unchanged, and enable the Query Store to collect baseline query performance statistics.

You then change the compatibility level, and continue to use Query Store data to measure the performance statistics of your queries. You can compare the statistics to find out if each query is doing better, the same, or worse than before the upgrade.

When you change the compatibility level to upgrade the database, SQL Server changes the version of the cardinality estimator it uses. The QTA finds possible patterns of query regression because of the change in the cardinality estimator, and experiments to find performance improvements. You can then create plan guides for queries that show improvement.

## Summary

The Query Store continuously measures the performance statistics of your queries, just as an aircraft's flight-data recorder captures activity. You can enable the Query Store on any database on SQL Server 2016 or higher, regardless of compatibility level. Use the Query Store to continuously monitor query performance, and for A/B testing to measure the effects of a single change.

When you upgrade a database to SQL Server 2014 or higher, changes to the cardinality estimator might slow queries that were fast in the previous SQL Server version. Ideally, you want to find and fix any regressions before they affect users. Enabling the Query Store on your databases means that statistics are continuously gathered on the queries. You can then use the QTA to identify and fix regressing queries before they become a problem.
