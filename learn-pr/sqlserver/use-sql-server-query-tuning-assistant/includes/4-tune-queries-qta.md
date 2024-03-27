You decide to use the Query Store to monitor database performance before migration and compare this data to the performance after upgrade. You plan to use the Query Tuning Assistant (QTA) to find regressed queries and suggest improvements. This unit describes the steps to use the Query Store and QTA to maintain query performance.

Because your database applications are critical systems that underpin the operations of the business, you need to have an action plan and contingency plan for the upgrade. Upgrade core production databases one at a time. Determine a test plan for the upgraded databases to make sure each database is back in production without any problems before you upgrade any others. 

You can use the Query Store to continuously monitor the performance of queries, and for A/B testing to measure the effects of a change such as a database upgrade. The QTA provides automatic support after an upgrade to find and fix regressed queries based on the data captured in the Query Store.

For QTA to work correctly, you need to apply the following steps in order.

> [!IMPORTANT]
> Make sure to use your production application database, or one with an application workload that closely matches your production database workload, so Query Store can gather realistic metrics on the queries.

1. Migrate the database to SQL Server 2022.
1. Leave the compatibility level unchanged at the previous SQL Server version.
1. Enable the Query Store on the database.
1. Let the Query Store gather baseline metrics on the queries based on sufficient realistic user activity.
1. Upgrade the compatibility level to SQL Server 2022 (160).
1. Again let the Query Store gather data on the queries based on sufficient realistic user activity.
1. Use the QTA to compare the performance of queries before and after the database compatibility level change. If regressed queries are found, identify fixes.

## Migrate the database

When you're ready to move to SQL Server 2022, start by migrating your database to the new instance. There are several ways to do this migration. For example, you could use a straightforward backup and restore, use database mirroring, or use a bulkload. The most appropriate choice depends on the configuration of your current environment and the version of SQL Server you're migrating from. Azure Data Migration Service (DMS) is a good solution, because it supports databases from SQL Server 2005 onwards.

> [!NOTE]
> Azure DMS also support database migrations to Azure SQL Managed Instance. Use the [Azure SQL migration extension for Azure Data Studio](/sql/azure-data-studio/extensions/azure-sql-migration-extension) to get started.

## Leave compatibility level unchanged

After you migrate the database, leave the compatibility level unchanged. This step is critical, because you want the baseline to be measured using the current database configuration. Until you move the compatibility level to SQL Server 2014 (120) or higher, SQL Server uses the legacy cardinality estimator. SQL Server 2014 introduced an upgraded cardinality estimator that benefits most queries, but can rarely have a negative performance impact.

## Enable the Query Store

Although the database compatibility level remains at the previous version, you can enable the Query Store on the database, because Query Store is a server-level feature. To enable the Query Store:

1. In SQL Server Management Studio (SSMS), right-click the database and select **Properties**.
1. In the **Database Properties** window, select **Query Store** in the left pane.
1. Set **Operation Mode (Requested)** to **Read only** or **Read write**.
1. Select **OK**.

Alternatively, you can run the following statement to enable the Query Store in the default `READ WRITE` mode:

```sql
ALTER DATABASE <database-name> SET QUERY_STORE = ON
```

## Let the Query Store gather data

Put your migrated database back into production and switch over any database connections from applications or reports. The database starts receiving queries from production applications. Allow the Query Store to run long enough to gather a realistic workload on the database.

The Query Store should capture a typical cycle of business activity, including business hours, nightly processing, maintenance windows, and other activity. For many businesses, a week's activity is sufficient, but for some businesses this period may be shorter or longer.

Many businesses have major business cycles, and therefore unique activity, for biweekly payroll or month-end processing. You should be aware of the timing of business cycles your databases experience. For a grocery store, the weekly inventory arrival and restocking cycles cover most database activity.

You can see the collected data by browsing the Query Store tabs. To see the tabs, in SSMS **Object Explorer**, expand the database tree to display **Query Store**. Once you're satisfied that enough data is gathered, you can schedule the upgrade.

## Upgrade the compatibility level

Before making any change to a database, it's good practice to back up the database, outside of working hours if possible. After taking your backup, upgrade the compatibility level as follows:

1. Right-click the database in SSMS **Object Explorer** and choose **Properties**.
1. In the **Database Properties** window, select the **Options** tab.
1. Change the compatibility level to **SQL Server 2022 (160)**, and select **OK**.

Alternatively, you can run the following statement:

```sql
ALTER DATABASE <database-name> SET COMPATIBILITY_LEVEL = 160
```

## Let the Query Store continue to gather data

After your database is upgraded and applications resume, the Query Store continues to run in the background to gather metrics for the queries. The queries are now exposed to potential problems because of the new cardinality estimator the query optimizer uses.

Continue to run the Query Store and allow it to gather data for the same duration as before the upgrade. However, query regression might show up right away so you can take action to remediate any performance issues immediately.

## Run the Query Tuning Assistant

Run the QTA to address any regressing queries. To configure the QTA:

1. Right-click the database in SSMS **Object Explorer** and select **Tasks** > **Database Upgrade** > **New Database Upgrade Session**.
1. On the **Setup** screen of the **Query Tuning Assistant Wizard**, enter the **Workload duration (days) to capture** and the **Target Database Compatibility Level**.
1. Select **Next** to configure the **Settings** and **Tuning** screens.
1. Select **Finish**.

To monitor the QTA, right-click the database name, select **Tasks** > **Database Upgrade** > **Monitor Sessions**. The QTA gives you a summary report for the top regressed queries, comparing the observed data to the baseline data. You can then view the changes that QTA recommends for tuning the queries where performance has degraded.

## Summary

Use the QTA after your database upgrade to find and fix queries that regress as a result of the upgrade. For the QTA to find regressed queries, you must first create a baseline by using the Query Store to measure queries at the old compatibility level.

The Query Store then gathers metrics after the upgrade, which you can use with the QTA to compare the new performance to the baseline. It's crucial to QTA operation that the Query Store gathers data before and after the upgrade.

When the QTA identifies regressed queries, it experiments to find the best actions for improving performance. You can then apply these actions.
