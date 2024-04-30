Suppose you're a database administrator for a large national/regional grocery chain that has many critical applications running on SQL Server 2005, SQL Server 2008, and SQL Server 2012. These applications include the product ordering system, business intelligence for analyzing customer spending habits, and the e-commerce website that provides deliveries.

Support for these SQL Server versions has expired or will expire soon. You need to upgrade these applications to SQL Server 2022 as soon as possible to avoid problems with old hardware, prevent potential security issues because fixes and patches are no longer available, and use available new features.

You have a new SQL Server 2022 instance installed, and plan to migrate the databases at a scheduled time. However, you're aware of possible *query plan regression* following an upgrade, and the potential for performance loss.

System performance is crucial to the operation of the company's stores. There's limited space for storing fresh and frozen produce, so orders placed with suppliers for perishable goods must be in line with warehouse storage availability. Orders must be precise and correct so products don't end up as waste. Customers need to receive their grocery deliveries promptly. If databases underperform after being upgraded, the business can lose functionality and revenue.

You need to monitor the databases for any drop in performance following the upgrade, and to find the best method for identifying and mitigating regressed queries. To accomplish this objective, you can:

1. Migrate the databases to the new SQL Server 2022 instance and use Query Store to gather baseline query statistics.
1. Upgrade the migrated databases' compatibility levels and continue to gather query statistics.
1. Use the Query Tuning Assistant (QTA) to compare operational performance metrics between the compatibility level versions.
1. Use the comparison to address queries that are beginning to regress.

In this module, you learn how to determine and use the right tools to find regressing queries in databases upgraded to SQL Server 2022 from SQL Server 2012 and earlier versions.

## Learning objectives

In this module, you:

- Evaluate query tuning solutions like the QTA and automatic plan correction.
- Learn how to use the Query Store to assess query performance.
- Understand how the QTA works to address regressing queries.
- Learn how to use the QTA to maintain query performance after database upgrade.

## Prerequisites

- Knowledge of SQL Server database properties and options
- Experience with using SQL Server Management Studio (SSMS) or executing SQL queries
- Understanding of query plans, query tuning, and performance optimization
