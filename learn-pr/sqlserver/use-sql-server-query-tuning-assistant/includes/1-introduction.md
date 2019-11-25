Suppose you work for a national grocery chain that has many critical applications running on SQL Server. These applications include the product ordering system, business intelligence for analyzing customer spending habits, and the e-commerce website so customers can have their items delivered straight to their door. These applications use SQL Server 2005 or SQL Server 2008. You want to upgrade them straight away to avoid problems with the old hardware on which they run. You also don't want to face potential security issues, as fixes and patches are no longer available. Furthermore, there are many new features in SQL Server 2017 you're keen to make use of.

You have a new SQL Server 2017 instance installed and ready and have a plan to migrate the databases at a scheduled time. However, if the databases under-perform after being upgraded, the business stands to lose revenue, as perishable products must be ordered correctly so as not to end up as waste and customers can receive their regular grocery deliveries. You want to monitor the databases for any drop in performance following the upgrade.

You can solve the problem by migrating the databases to a new SQL Server 2017 instance and gathering query statistics. You can then upgrade the compatibility level and compare metrics to operational performance in the previous version. This comparison enables you to find queries that are beginning to regress.

Here, you'll learn how to use the right tools to find regressing queries in databases upgraded to SQL Server 2017, from versions before SQL Server 2014.

## Learning objectives

In this module, you will:  

- Decide if Query Tuning Assistant (QTA) is the right solution for you
- Learn how to use the Query Store to assess query performance
- Understand how QTA works to find regressing queries
- Tune queries after migration to maintain performance

## Prerequisites

- Experience of query tuning and performance
- Knowledge of database properties and options
- Understanding of query plans