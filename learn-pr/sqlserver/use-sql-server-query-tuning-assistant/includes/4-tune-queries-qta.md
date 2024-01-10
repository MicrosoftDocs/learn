You decide to use the Query Store to monitor database performance before migration, compare this data to the performance after upgrade, and use the Query Tuning Assistant (QTA) to find regressed queries and suggest improvements. This unit describes the steps to follow to use the Query Store and QTA to maintain query performance.

Because your database applications are critical systems that underpin the operations of the business, you need to have an action plan and contingency plan for the upgrade. Upgrade core production databases one at a time. Determine a test plan for the upgraded databases to make sure each database is back in production without any problems before you upgrade any others. 

You can use the Query Store to continuously monitor the performance of queries or to measure the effects of a change such as a database upgrade. The QTA provides automatic support after an upgrade to find and fix regressed queries based on the data captured in the Query Store.

For QTA to work correctly, you need to apply the following steps in order.

> [!IMPORTANT]
> Make sure to use your production application database, or one with an application workload that closely matches your production database workload, so Query Store can gather realistic metrics on the queries.

1. Migrate the database to SQL Server 2022.
1. Leave the compatibility level unchanged at the previous SQL Server version.
1. Enable the Query Store on the database.
1. Let the Query Store can gather enough realistic baseline metrics on the queries.
1. Upgrade the compatibility level to SQL Server 2022 (160).
1. Let the Query Store continue to gather enough realistic metrics on the queries.
1. Use the QTA to compare the performance of queries before and after the database compatibility level change, find regressing queries, and suggest fixes.

## Migrate the database

When you're ready to move to SQL Server 2022, start by migrating your database to the new instance. There are a number of ways to do this migration. For example, you could use a straightforward backup and restore, use database mirroring, or use a bulkload. The most appropriate choice depends on the configuration of your current environment and the version of SQL Server you're migrating from. The Microsoft Database Migration Assistant (DMA) is a good solution, because it supports databases from SQL Server 2005 onwards.

## Leave compatibility level unchanged

After you migrate the database, leave the compatibility level unchanged. Until you move the compatibility level to SQL Server 2014 (120) or higher, SQL Server uses a legacy cardinality estimator. SQL Server 2014 introduced an upgraded cardinality estimator that benefits most queries, but can rarely have a negative performance impact. This step is critical, because you want the baseline to be taken using the current database configuration.

## Enable Query Store

Although the database compatibility level remains at the previous version, you can enable the Query Store on the database, because Query Store is a server-level feature. To enable the Query Store, in SQL Server Management Studio (SSMS), right-click the database and select **Properties**. In the **Database Properties** window, select **Query Store** in the left pane. Set **Operation Mode (Requested)** to **Read only** or **Read write**, and then select **OK**. Alternatively, you can run the following statement:

```sql
ALTER DATABASE <database-name> SET QUERY_STORE = ON
```

## Let Query Store gather data

Put your migrated database back into production and switch over any database connections from applications or reports. The database starts receiving queries from production applications. Allow the Query Store to run for enough time to gather a realistic workload on the database.

The Query Store should capture a typical cycle of business activity, including regular business hours, nightly processing, maintenance windows, and other scheduled or periodic activity. For many businesses, a week's activity is sufficient, but this period may be shorter or longer. For a grocery store, the weekly inventory arrival and restocking cycles cover the majority of database activity.

You can see what's been collected by browsing through the Query Store tabs. In SSMS **Object Explorer**, expand the database tree to display **Query Store** and see the tabs. Once you're satisfied that enough data has been gathered, you can schedule the upgrade.

## Upgrade the compatibility level

Before making any change to a database, it's good practice to back up the database, outside of working hours if possible. After taking your backup, to upgrade the compatibility level, right-click the database in SSMS **Object Explorer** and choose **Properties**. In the **Database Properties** window, select the **Options** tab, change the compatibility level to **SQL Server 2022 (160)**, and select **OK**. Alternatively, you can run the following statement:

```sql
ALTER DATABASE <database-name> SET COMPATIBILITY_LEVEL = 160
```

## Let Query Store continue to gather data

After your database is upgraded and applications resume, the Query Store continues to run in the background to gather metrics for the queries. The queries are now exposed to potential problems because of the new cardinality estimator the query optimizer uses.

Continue to run the Query Store and allow it to gather data for the same duration as before the upgrade. However, query regression might show up right away and allow you to take action to remediate any performance issues immediately.

## Run the QTA

Run the QTA to find any regressing queries. To configure the QTA, right-click the database in SSMS **Object Explorer** and select **Tasks** > **Database Upgrade** > **New Database Upgrade Session**. In the **New Query Tuning Session**. On the **Setup** screen of the **Query Tuning Assistant Wizard**, enter the **Workload duration (days) to capture** and the **Target Database Compatibility Level**. The QTA gives you a summary report for the top regressed queries, comparing the observed data to the baseline data. You can then view the changes that QTA recommends for tuning the query where performance has degraded.

## Summary

Use the QTA after your database upgrade to find and fix queries that regress as a result of the upgrade. For the QTA to find regressed queries, you must first create a baseline by using the Query Store to measure queries at the old compatibility level.

The Query Store then gathers metrics after the upgrade, which you can use with QTA to compare the new performance to the baseline. It's crucial that the Query Store gathers data before and after the upgrade so that the QTA can operate.

When the QTA identifies regressed queries, it experiments to find the best actions for increasing performance. You can then apply these actions.
