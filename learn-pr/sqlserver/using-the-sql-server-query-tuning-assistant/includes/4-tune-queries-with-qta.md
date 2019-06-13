Suppose you support database applications for a large national grocery store, and your company has signed-off an upgrade for the core production databases. These database applications are critical systems that underpin the operations of the business and without which it can't function. Your manager has agreed you can begin the upgrades by moving one database each weekend, to ensure each one is back in production without any problems before you upgrade any others.

It's mid-week and your manager has asked you to write an action plan for the weekend, to make a contingency plan. They also want you to demonstrate how you'll be testing the databases after upgrading them, as performance is vital to the product ordering system. You've decided to use the Query Store to monitor database performance before the migration. You then want to compare this data to the performance after upgrade by using the Query Tuning Assistant (QTA).

## Tuning queries with the QTA

The Query Store can be used to continuously monitor the performance of your queries. It's also ideal for measuring a change made in an A/B test. Such a change could be the upgrade of a database. The QTA provides automatic support after an upgrade, to find and fix regressed queries, based on the data captured in the Query Store. However, in order for QTA to work correctly, you need to apply the following steps in order:  

1. Migrate the database to SQL Server 2017.
1. Leave the compatibility level unchanged (at the previous SQL Server version).
1. Enable Query Store on the database.
1. Make the database live so Query Store can gather baseline metrics on the queries.
1. Upgrade the compatibility level.
1. Continue to use the Query Store to gather post-upgrade query performance.
1. Use QTA to find regressing queries.

When you're ready to transition to SQL Server 2017, start by migrating your database to the new instance. There are a number of ways to do this migration. For example, you could use a straightforward backup and restore, use database mirroring, or a bulk load. The most appropriate choice depends on the configuration of your current environment and the version of SQL Server from which you're migrating; the Microsoft Database Migration Assistant (DMA) is a good solution, as it supports databases from SQL Server 2005 onwards.

After migrating the database, the compatibility level must be left unchanged. Until you move the compatibility level to SQL Server 2014 or higher, SQL Server uses the cardinality estimator. This step is critical, as you want the baseline to be created using the current database configuration.

Although the compatibility level remains in the previous version, you can enable the Query Store on the database, as Query Store is a server level feature. The Query Store can be enabled through the database properties window in SQL Server Management Studio (SSMS), or by running the following statement:

```sql
ALTER DATABASE FreshFoods2008 SET QUERY_STORE = ON
```

You can now put your database back into production and switch over any database connections from applications or reports. This will start generating traffic. Allow the Query Store to run for enough time to gather a decent workload on the database. A day is adequate on a typical system. You can see what has been collected by browsing through the Query Store tabs: In SSMS, in **Object Explorer**, expand the database tree to display **Query Store**. The tabs are located here. If you are satisfied that enough data has been gathered, you can then schedule the upgrade.

Before making any change to a database, it's good practice to  backup the database. Make this change out of hours if possible. After taking your backup, right-click on the database in **Object Explorer** and choose **Properties**. You can then select the **Options** tab, and change the compatibility level to **SQL Server 2017 (140)**. You can achieve the same results by running the following code:

```sql
ALTER DATABASE FreshFoods2008 SET COMPATIBILITY_LEVEL = 140
```

After your database is upgraded and applications resume, the Query Store continues to run in the background gathering metrics for the queries, which are now exposed to potential problems because of the new cardinality estimator being used by the query optimizer.

Continue to run the Query Store, and as before, allow it to gather a reasonable quantity of data. You can then run the QTA and find any regressing queries. Right-click on the database in **Object Explorer** and select **Tasks**, **Query Tuning**, then **New Query Tuning Session**. In the **Setup** window, you can choose the number of days worth of workload you want QTA to capture. You can also set the target compatibility level. The QTA provides you with a summary report for the top regressed queries, comparing the observed data to the baseline data. You can then view the changes that QTA recommends to tune the query where performance has degraded.

## Summary

Use the QTA after your database upgrade to find and fix queries regressing as a result. In order for the QTA to find regressed queries, you must first create a baseline by using the Query Store to measure queries at the old compatibility level. The Query Store then gathers metrics after the upgrade, which you can use with QTA to compare the new performance to the baseline. It's crucial that the Query Store gathers data before and after the upgrade so that the QTA can operate. When the QTA finds regressed queries, it experiments to find the best actions for increasing performance. These actions can then be applied.