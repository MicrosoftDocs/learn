One of the value-added features in Azure Database for MySQL and PostgreSQL is an implementation of the Query Store in each database. While a slightly different implementation of the feature than in Azure SQL, the Query Store offers insightful actionable performance information to the DBA.

## Query Store in Azure Database for MySQL

The Query Store in MySQL allows you to track query performance over time and quickly identify the longest running and most expensive queries in your databases. The data for all users, databases, and queries is stored in the **mysql** schema database in your instance. Like Azure SQL Database, the Azure portal includes a Query Performance Insight dashboard, which highlights expensive queries and wait statistics for your instance.

[![Query Performance Insight waits statistics](../media/module-44-optimize-resources-final-24.png)](../media/module-44-optimize-resources-final-24.png#lightbox)

The Azure portal also includes a performance recommendations section based on the data in the Query Store.

## Query Store in Azure Database for PostgreSQL

In a similar implementation to Azure Database for MySQL, PostgreSQL stores its Query Store information in a database named **azure_sys** in your instance. You can also capture wait statistics. The feature is not enabled by default and should be enabled by the DBA in the server parameter settings for your instance. Similar to the Query Store in Azure SQL, you can change the capture mode from all queries, to top queries, or no queries. You can also adjust the data retention period and frequency of wait stats sampling. Just like Azure SQL and Azure Database for MySQL, when you enable the Query Store you can access Query Performance Insights and performance recommendations in the Azure portal.
