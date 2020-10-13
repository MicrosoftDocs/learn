SQL Server and Azure SQL include automation to help deliver consistent performance for your application. These automation capabilities are called, collectively, intelligent performance.

Intelligent performance for Azure SQL includes intelligent query processing, automatic plan correction, and automatic tuning.

## Intelligent query processing

Intelligent query processing (IQP) is a suite of new capabilities built into the query processor. You enable it by using the latest database compatibility level. Applications can gain performance by simply using the latest database compatibility level. There are no code changes required. An example of IQP is *table variable deferred compilation* to help make queries that use table variables run faster.

Azure SQL Database and Azure SQL Managed Instance support the same database compatibility level required to use IQP (150) as SQL Server 2019.

## Automatic plan correction

Query plan regressions represent one of the most difficult performance problems to solve with SQL Server. A query plan regression occurs when the same query is recompiled and a new plan results in worse performance.

SQL Server 2017 and Azure SQL Database introduced the concept of automatic plan correction by analyzing data in the Query Store. When you enable the Query Store with a database in SQL Server 2017 (or later) and in Azure SQL Database, the SQL Server engine looks for query plan regressions and provides recommendations. You can see these recommendations in the dynamic management view (DMV) **sys.dm_db_tuning_recommendations**. These recommendations include T-SQL statements to manually force a query plan when performance was in a good state.

If you gain confidence in these recommendations, you can enable SQL Server to force plans automatically when regressions are encountered. Enable automatic plan correction by using ALTER DATABASE and the AUTOMATIC_TUNING argument.

For Azure SQL Database, you can also enable automatic plan correction through automatic tuning options in the Azure portal or REST APIs. Automatic plan correction recommendations are always enabled for any database where Query Store is enabled (which is the default for Azure SQL Database and Azure SQL Managed Instance). For new databases, automatic plan correction (FORCE_PLAN) is enabled by default for Azure SQL Database.

## Automatic tuning for Azure SQL Database

Automatic plan correction is an example of automatic tuning in Azure SQL and SQL Server. But a unique aspect to automatic tuning for Azure SQL Database is automatic indexing.

> [!NOTE]
> Automatic indexing isn't currently available in SQL Managed Instance.

The cloud provides a method for Microsoft to provide additional services in form of performance recommendations and automation outside of plan recommendations. This capability is known as automatic tuning for Azure SQL Database. These services run as background programs that analyze performance data from an instance of Azure SQL Database. These services are included in the price of any database subscription.

The main scenario automatic tuning is designed to address pertains to indexes. Automatic tuning analyzes data from the telemetry of a database, including the Query Store and DMVs, to recommend indexes to be created that can improve application performance. Additionally, you can enable automatic tuning to automatically create indexes that can improve query performance. Automatic tuning also monitors index changes, and recommends dropping or automatically drops indexes that don't improve query performance.

Automatic tuning for Azure SQL Database takes a conservative approach to recommending indexes. This means that recommendations that might appear in a DMV like sys.dm_db_missing_index_details, or a query show plan, might not show up immediately as recommendations for automatic tuning. Automatic tuning services monitor queries over time, and use machine learning algorithms to make recommendations to truly affect query performance.

Be aware that automatic tuning for index recommendations doesn't account for any overhead performance an index can cause on your operations, such as inserts, updates, or deletes.

Parameterized queries represent an additional scenario for automatic tuning. Queries with non-parameterized values can lead to performance overhead because the execution plan is recompiled each time the non-parameterized values are different. In many cases, the same queries with different parameter values generate the same execution plans. These plans, however, are still separately added to the plan cache. The process of recompiling execution plans uses database resources, increases the query duration time, and overflows the plan cache. These events, in turn, cause plans to be evicted from the cache.

You can alter this SQL Server behavior by setting the forced parameterization option on the database (run the ALTER DATABASE T-SQL statement and use the PARAMETERIZATION FORCED option). Automatic tuning can analyze a query performance workload against a database over time, and recommend forced parameterization for the database. If you observe performance degradation over time, the option is disabled.

## Example of indexes with automatic tuning in Azure SQL Database

The following is an example from the Azure portal, in which indexes are recommended for a database based on workload analysis over time.

:::image type="content" source="../media/9-index-recommendation-notification.png" alt-text="Screenshot of index recommendation notification.":::

In the Azure portal, in **Performance Overview**, you can see performance information for the top 5 resource-consuming queries, as found in the Query Store. There's also a recommendation.

:::image type="content" source="../media/9-query-performance-overview.png" alt-text="Screenshot of Query Performance Overview.":::

The Azure portal also offers Query Performance Insights, which is a visual reporting tool based on the Query Store. In this example, Query Performance Insights shows the specific query consuming the most resources, and advises how to improve query performance.

:::image type="content" source="../media/9-query-performance-insights.png" alt-text="Screenshot of Query Performance Insights.":::

The Azure portal also provides a direct way to see any performance recommendations.

:::image type="content" source="../media/9-performance-recommendations.png" alt-text="Screenshot of Performance Recommendations.":::

In this view, you see specific recommendations, and the history of any automatic tuning actions. In the case of an index, details of the index and table are shown. The **Automate** option enables automatic tuning.

:::image type="content" source="../media/9-automatic-tuning-options.png" alt-text="Screenshot of automatic tuning options.":::

You can set automatic tuning options at the database server or database level. If you had enabled automatic tuning in this scenario, the index would have been automatically created.

You can also view automatic tuning options through the DMV **sys.database_automatic_tuning_options**.

> [!NOTE]
> Recommendations and automation for indexes and parameter sensitive plans aren't available for Azure SQL Managed Instance or SQL Server. Automatic plan correction is available.

If you select the recommended index, you get more details about the specific index.

:::image type="content" source="../media/9-create-index-recommendation.png" alt-text="Screenshot of create index recommendation.":::

You will see details about the index, table, and space required. You have the option to apply the recommended index, or to view a T-SQL script that applies the index.

:::image type="content" source="../media/9-create-index-recommendation-script.png" alt-text="Screenshot of the index recommendation script.":::

Notice that the index is a non-clustered index that is applied as an online index. When an index has been applied based on a recommendation, either manually or through automatic tuning, the recommendation engine also monitors query performance over a period of time with the applied index. If query performance degrades compared to before the index was applied, you can drop the index.
