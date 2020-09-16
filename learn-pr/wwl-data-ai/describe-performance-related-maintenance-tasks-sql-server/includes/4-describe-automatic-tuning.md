The Query Store provides database administrators with in-depth insights on query plans and performance metrics. By default, execution plans evolve over time due to schema changes, index modifications, or changes to the data that cause updates to the statistics. This evolution can cause queries to perform poorly as the execution plan no longer meets the demands of the given query. The Query Store in Azure SQL features a plan forcing option to always force a given execution plan.

### Automatic tuning features

SQL Server 2017 introduced a feature called automatic tuning. Automatic tuning allows for the gathering and applying machine learning against performance metrics to provide suggested improvements or even allow for self-correction. Automatic tuning, whether on-premises or in the cloud, allows you to identify issues caused by query execution plan regression. Additionally, in Azure SQL Database you have the option to further improve query performance by index tuning. Azure SQL Database automatic tuning can identify indexes that should be added or even removed from the database to enhance query performance.

### Automatic plan correction

Using Query Store, the database engine can identify when query execution plans have regressed in their performance. While you can manually identify a regressed plan through the user interface, the Query Store also provides the option to notify you automatically.

:::image type="content" source="../media/module-44-optimize-resources-final-25.png" alt-text="Query Store view of Automatic Plan Correction":::

In the example above, you can see a check mark on Plan ID 1, which means that the plan has been forced. Once the feature has been enabled, the database engine will automatically force any recommended query execution plan where the number of errors in the previous plan is higher than the recommended plan, the estimated CPU gain is greater than 10 seconds, or a plan was forced and continues to be better than the previous one. The plan will revert back to the last known good plan after 15 executions of the query.

When plan forcing occurs automatically, the database engine will apply the last known good plan and will also continue to monitor query execution plan performance. If the forced plan does not perform better than the previous plan, it will be subsequently unforced and force a new plan to be compiled. If the forced plan continues to outperform the previously bad plan, it will remain forced until such time as a recompile occurs.

You can enable automatic plan correction via a T-SQL query, as shown below. The Query Store must be enabled and must be in Read-Write mode for the command to succeed. If either of those two criteria are not met, the ALTER statement will fail.

```SQL
ALTER DATABASE [WideWorldImporters] SET AUTOMATIC_TUNING (FORCE_LAST_GOOD_PLAN = ON);
```

You can examine the automatic tuning recommendations through a dynamic management view (DMV), *sys.dm_db_tuning_recommendations*, which is available in SQL Server 2017 or higher and is also available in Azure SQL Database solutions. This DMV provides information such as reasons as to why the recommendation was provided, the type of recommendation, the state of the recommendation, as well as others. To confirm that automatic tuning is enabled for a database, there is a DMV sys.*database_automatic_tuning_options* that can be queried.

### Automatic index management

Azure SQL Database can perform automatic index tuning. Over time, the database will learn about existing workloads and provide recommendations on adding or removing indexes in order to provide better performance. Like forcing improved query plans, the database can be configured to allow for automatic index creation or removal depending on existing index performance, as shown below:

:::image type="content" source="../media/module-44-optimize-resources-final-26.png" alt-text="Automatic tuning Options":::

When enabled, the Performance Recommendations blade will identify indexes that can be created or dropped depending on query performance. Remember this feature is not available for on-premises databases and only available for Azure SQL Database.

Creating new indexes can consume resources, and the timing of the index creations is critical to ensure no negative impact is felt on your workloads. Azure SQL Database will monitor windows of time to implement new indexes to avoid causing performance issues. If resources are needed for existing workloads and potentially not available to create an index, the tuning action is postponed until such time as resources are available. If a newly created index does not result in an increase in query performance, it will be dropped quickly. This monitoring process will validate that any actions taken only helps performance and does not degrade it. If an index is dropped and query performance noticeably degrades, the recently dropped index will be recreated automatically.
