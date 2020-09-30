SQL Server has always had configuration options that were set at the database level. For example, the recovery model has always been a database setting, but as more complex features have been introduced to the database, more options have been added. Many of these options are tied to the compatibility level of the database, which is itself a database level configuration option. Database configuration options break down into two groups, with a minor difference:

- Options configured by the ALTER DATABASE SCOPED CONFIGURATION syntax in T-SQL

- Options configured by the ALTER DATABASE syntax in T-SQL

There is no significance to the different ways to set these options. Options that are set using ALTER DATABASE include:

- Database Recovery Model - Whether the database is in full or simple recovery model

- Automatic Tuning Option - Whether to enable the force last good plan

- Auto Create and Update Statistics - Allows the database to create and update statistics and allows for the option of asynchronous statistics updates

- Query Store Options - The Query Store options are configured here

- Snapshot Isolation - You can configure snapshot isolation and read committed snapshot isolation

The above settings are a subset of the configurable options.

Database scoped options were introduced in SQL Server 2016, and allow configuration of several options that were formerly configured at the server level. Some of the options include:

- Maximum Degree of Parallelism - This setting allows for a database to configure its own MaxDOP setting and override the server’s setting.

- Legacy Cardinality Estimation - This setting allows for the database to use the older cardinality estimator. Some queries may have degraded performance under the newer cardinality estimator, introduced in SQL Server 2014, and may benefit from this setting. You should note that if you use this option in conjunction with a newer compatibility level, you can still get the benefits of Intelligent Query Processing in compatibility level 140 or 150.

- Last Query Plan Stats - This allows you to capture the values of the last actual execution plan for a query. This feature is only active in compatibility level 150.

- Optimize for Ad Hoc Workloads - This option uses the optimizer to store a stub query plan in the plan cache. This can help reduce the size of the plan cache for workloads that have a lot of single use queries.

## Database compatibility level

Each database has its own compatibility level, which controls the behavior of the query optimizer for that database. You can manage this setting when upgrading SQL Server to ensure that your queries have similar execution plans to the older version. Microsoft will support running on an older compatibility level for an extended period. You should attempt to move towards newer compatibility levels, as many of the new performance features in Intelligent Query Processing are only available under compatibility level 140 or 150.
