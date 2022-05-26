SQL Server has always had configuration options that were set at the database level. For example, the recovery model has always been a database setting, but as more complex features have been introduced to the database, more options have been added. Many of these options are tied to the compatibility level of the database, which is itself a database level configuration option. Database configuration options break down into two groups, with a minor difference:

- Options configured by the `ALTER DATABASE SCOPED CONFIGURATION` syntax in T-SQL

- Options configured by the `ALTER DATABASE` syntax in T-SQL

There's no significance to the different ways to set these options. Options that are set using `ALTER DATABASE` include:

- **Database recovery model –** Whether the database is in full or simple recovery model

- **Automatic tuning option –** Whether to enable the force last good plan

- **Auto create and update statistics –** Allows the database to create and update statistics and allows for the option of asynchronous statistics updates

- **Query store options –** The Query Store options are configured here

- **Snapshot isolation –** You can configure snapshot isolation and read committed snapshot isolation

The above settings are a subset of the configurable options.

Many options previously configured on the server can now be configured at the database level. Some of the options include:

- **Maximum Degree of Parallelism –** Allows for a database to configure its own MaxDOP setting and override the server’s setting.

- **Legacy Cardinality Estimation –** Allows for the database to use the older cardinality estimator. Some queries may have degraded performance under the newer cardinality estimator, and may benefit from it. You should note that if you use this option with a newer compatibility level, you can still get the benefits of Intelligent Query Processing in compatibility level 140 or 150.

- **Last Query Plan Stats –** Allows you to capture the values of the last actual execution plan for a query. This feature is only active in compatibility level 150.

- **Optimize for Ad Hoc Workloads –** Uses the optimizer to store a stub query plan in the plan cache. This can help reduce the size of the plan cache for workloads that have numerous single use queries.

## Database compatibility level

Each database has its own compatibility level, which controls the behavior of the query optimizer for that database.

You can manage this setting when upgrading SQL Server to ensure that your queries have similar execution plans to the older version.

Microsoft will support running on an older compatibility level for an extended period. You should upgrade to a newer compatibility level if possible, as many of the new features in Intelligent Query Processing are only available in compatibility level 140 or 150.
