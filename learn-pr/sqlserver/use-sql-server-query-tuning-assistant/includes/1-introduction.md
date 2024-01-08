Suppose you work for a national/regional grocery chain that has many critical applications running on SQL Server. These applications include the product ordering system, business intelligence for analyzing customer spending habits, and the e-commerce website that provides deliveries. 

These applications use SQL Server 2005 or SQL Server 2008. You want to upgrade them immediately to avoid problems with the old hardware on which they run. You also don't want to face potential security issues, as fixes and patches are no longer available. Also, you're keen to use the many new features in SQL Server 2019.

You have a new SQL Server 2019 instance installed, and plan to migrate the databases at a scheduled time. However, if the databases underperform after being upgraded, the business stands to lose revenue. Perishable products must be ordered correctly so they don't end up as waste. Customers also need to receive their regular grocery deliveries. You want to monitor the databases for any drop in performance following the upgrade.

You'll solve the problem by migrating the databases to a new SQL Server 2019 instance and gathering query statistics. You can then upgrade the compatibility level and compare metrics to operational performance in the previous version. Use this comparison to find queries that are beginning to regress.

Here, you'll learn how to use the right tools to find regressing queries in databases upgraded to SQL Server 2019, from SQL Server 2012.

## Learning objectives

In this module, you'll:  

- Decide if Query Tuning Assistant (QTA) is the right solution for you.
- Learn how to use the Query Store to assess query performance.
- Understand how QTA works to find regressing queries.
- Tune queries after migration to maintain performance.

## Prerequisites

- Experience of query tuning and performance
- Knowledge of database properties and options
- Understanding of query plans
