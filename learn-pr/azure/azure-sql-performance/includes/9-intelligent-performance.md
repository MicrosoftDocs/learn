SQL Server and Azure SQL are constantly enhancing performance capabilities including automation to assist and help deliver consistent performance for your application. Because these automation capabilities are built into the SQL Server engine or Azure SQL service, we call them collectively **Intelligent Performance**.

Intelligent Performance for Azure SQL includes Intelligent Query Processing, Automatic Plan Correction, and Automatic Tuning.

## Intelligent Query Processing

Intelligent Query Processing (IQP) is a suite of new capabilities built into the Query Processor and enabled using the latest database compatibility level. Applications can gain performance with no code changes by simply using the latest database compatibility level. An example of IQP is *table variable deferred compilation* to help make queries using table variables run faster with no code changes.

Azure SQL Database and Managed Instance support the same database compatibility level required to use IQP (150) as SQL Server 2019.

## Automatic Plan Correction

One of the most difficult performance problems to solve with SQL Server are **query plan regressions**. A query plan regression occurs when the same query is recompiled and a new plan results in worse performance. A common scenario for query plan regression are *parameter-sensitive plans* (PSP). You can read more about troubleshooting problems related to PSP in the documentation.

SQL Server 2017 and Azure SQL Database introduced the concept of Automatic Plan Correction (APC) by analyzing data in the Query Store. When the Query Store is enabled with a database in SQL Server 2017 (or later) and in Azure SQL Database, the SQL Server engine will look for query plan regressions and provide recommendations. You can see these recommendations in the DMV **sys.dm_db_tuning_recommendations**. These recommendations will include T-SQL statements to manually force a query plan when performance was "in a good state".

If you gain confidence in these recommendations, you can enable SQL Server to force plans automatically when regressions are encountered. Automatic Plan Correction can be enabled using ALTER DATABASE using the AUTOMATIC_TUNING argument.

For Azure SQL Database, you can also enable Automatic Plan Correction through automatic tuning options in the Azure portal or REST APIs. You can read more about these techniques in the documentation. Automatic Plan Correction recommendations are always enabled for any database where Query Store is enabled (which is the default for Azure SQL Database and Managed Instance). Automatic Plan Correction (FORCE_PLAN) is enabled by default for Azure SQL Database as of March, 2020 for new databases.

## Automatic Tuning for Azure SQL Database

Automatic Plan Correction is an example of Automatic Tuning in Azure SQL and SQL Server. But a unique aspect to Automatic Tuning for Azure SQL Database is **automatic indexing**.

> [!NOTE]
> Automatic indexing is not currently available in Azure SQL Managed Instance

The cloud provides a method for Microsoft to provide additional services in form of performance recommendations and automation outside of plan recommendations. This capability is known as Automatic Tuning for Azure SQL Database (also known in some parts of the documentation as SQL Database Advisor). These services run as background programs analyzing performance data from an Azure SQL Database and are included in the price of any database subscription.

The main scenario **Automatic Tuning for Azure SQL Database** is designed to address are *indexes*. Automatic Tuning will analyze data from telemetry of a database including the Query Store and Dynamic Management Views to recommend indexes to be created that can improve application performance. Additionally, you can **enable Automatic Tuning** services to automatically create indexes that it believes will improve query performance. Automatic Tuning will also monitor index changes and recommend or automatically drop indexes that do not improve query performance. Automatic Tuning for Azure SQL Database takes a conservative approach to recommend indexes. This means that recommendations that may show up in a DMV like sys.dm_db_missing_index_details or a query show plan may not show up immediately as recommendations for Automatic Tuning. Automatic Tuning services monitor queries over time and use machine learning algorithms to make recommendations to truly affect query performance.

One downside to Automatic Tuning for index recommendations is that it does not account for any overhead performance an index could cause insert, update, or delete operations.

One additional scenario in preview for Automatic Tuning for Azure SQL Database is parameterized queries. Queries with non-parameterized values can lead to performance overhead because the execution plan is recompiled each time the non-parameterized values are different. In many cases, the same queries with different parameter values generate the same execution plans. These plans, however, are still separately added to the plan cache. The process of recompiling execution plans uses database resources, increases the query duration time, and overflows the plan cache. These events, in turn, cause plans to be evicted from the cache. This SQL Server behavior can be altered by setting the forced parameterization option on the database (this is done by executing the ALTER DATABASE T-SQL statement using the PARAMETERIZATION FORCED option). Automatic tuning can analyze a query performance workload against a database over time and recommend forced parameterization for the database. If over time, performance degradation has been observed, the option will be disabled.

## See an example of indexes with Automatic Tuning in Azure SQL Database

The following is an example from the Azure portal where indexes are recommended for a database based on workload analysis over time.

> [!NOTE]
> You can at a later date use the AdventureWorksLT sample with your own Azure SQL Database deployment and use the scripts in the *04-Performance\tuning_recommendations* folder to see this example. It is important to note that when you run these scripts it can take 8 hours or more to see results in DMVs and Azure portal.

:::image type="content" source="../media/9-index-recommendation-notification.png" alt-text="Screenshot of Index Recommendation Notification.":::

If you look at **Performance Overview** in the Azure portal, you will see performance information for the top 5 resource consuming queries as found in the Query Story and an indication of a recommendation:

:::image type="content" source="../media/9-query-performance-overview.png" alt-text="Screenshot of Query Performance Overview.":::

The Azure portal also offers **Query Performance Insights**, which is a visual reporting tool based on the Query Store. In this example, Query Performance Insights will show the specific query consuming the most resources and advice of any recommendations to improve query performance

:::image type="content" source="../media/9-query-performance-insights.png" alt-text="Screenshot of Query Performance Insights.":::

The Azure portal also provides a way to directly see any performance recommendations.

:::image type="content" source="../media/9-performance-recommendations.png" alt-text="Screenshot of Performance Recommendations.":::

In this view you will see specific recommendations and history of any automatic tuning actions. In the case of an index, details of the index and table are displayed. The option to **Automate** is to enable Automatic Tuning.

:::image type="content" source="../media/9-automatic-tuning-options.png" alt-text="Screenshot of Automatic Tuning options.":::

Automatic Tuning options can be set at the Database Server or database level.  If you would have enabled Automatic Tuning in this scenario, the index would have been automatically created.

You can also view automatic tuning options through the DMV **sys.database_automatic_tuning_options**.

Recommendations and automation for indexes and parameter sensitive plans are not available for Azure SQL Managed Instance or SQL Server (Automatic Plan Correction is available).

If you click on the recommended index you will get more details about the specific index.

:::image type="content" source="../media/9-create-index-recommendation.png" alt-text="Screenshot of create index recommendation.":::

You will see details of the index, table, and space required. You have the option to apply the recommended index or view a T-SQL script that will be used to apply the index.

:::image type="content" source="../media/9-create-index-recommendation-script.png" alt-text="Screenshot of the index recommendation script.":::

Notice the index is a non-clustered index that is applied as an online index. When an index has been applied based on a recommendation, either manually or through automatic tuning, the recommendation engine will also monitor query performance over a period of item with the applied index. If query performance degrades compared to before the index was applied, a recommendation can be made to drop the index.
