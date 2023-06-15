## Scenario

As the CTO of your healthcare company, you might decide to only track whether a change event (for example, insert/update/delete) has happened on any of your regional inventory databases, not necessarily track all historical data changes. This might be a more optimal approach that has less of an impact on your source database. In order to implement this, we need to first better understand change tracking.

## How it works

Different types of applications have different requirements for how much information they need about the changes. Applications can use change tracking to answer the following questions about the changes that have been made to a user table:

- **What rows have changed for a user table?** Only the fact that a row has changed is required, not how many times the row has changed or the values of any intermediate changes. The latest data can be obtained directly from the table that is being tracked.

- **Has a row changed?** The fact that a row has changed and information about the change must be available and recorded at the time that the change was made in the same transaction.

You can use change tracking as a foundation for both one-way and two-way synchronization applications.

- One-way synchronization applications, such as a client or mid-tier caching application, can be built to use change tracking. As shown in the following illustration, a caching application requires data to be stored in the Database Engine and to be cached in other data stores. The application must be able to keep the cache up-to-date with any changes that have been made to the database tables. There are no changes to pass back to the Database Engine.
   :::image type="content" source="../media/one-way-sync.gif" alt-text="Diagram showing one-way synchronization applications.":::

- Two-way synchronization applications can also be built to use change tracking. In this scenario, the data in an instance of the Database Engine is synchronized with one or more data stores. The data in those stores can be updated and the changes must be synchronized back to the Database Engine.
   :::image type="content" source="../media/two-way-sync.gif" alt-text="Diagram showing two-way synchronization applications.":::

After change tracking is configured for a table, any DML statement that affects rows in the table will cause change-tracking information for each modified row to be recorded. To query for the rows that have changed and to obtain information about the changes, you can use change-tracking functions.

The value of the primary key column is the only information from the tracked table that is recorded with the change information. These values identify the rows that have changed. To obtain the latest data for those rows, an application can use the primary key column values to join the source table with the tracked table.

You can also obtain information about the change that was made to each row by using change tracking. For example, you can obtain the type of DML operation that caused the change (insert, update, or delete) or the columns that were changed as part of an update operation.

## Enabling and disabling change tracking

### Enabling change tracking on your database

Before you can use change tracking, you must enable change tracking at the database level. The following example shows how to enable change tracking by using `ALTER DATABASE`:

```sql
ALTER DATABASE AdventureWorksLT
SET CHANGE_TRACKING = ON
(CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON)
```

You can also enable change tracking in SQL Server Management Studio by using the [Database Properties (ChangeTracking Page)](/sql/relational-databases/databases/database-properties-changetracking-page) dialog box. If a database contains memory optimized tables, you can’t enable change tracking with SQL Server Management Studio. To enable, use T-SQL.

You can specify the `CHANGE_RETENTION` and `AUTO_CLEANUP` options when you enable change tracking, and you can change the values at any time after change tracking is enabled.

The change-retention value specifies the time period for which change tracking information is kept. Change-tracking information that's older than this time period is removed periodically. When you're setting this value, you should consider how often applications will synchronize with the tables in the database. The specified retention period must be at least as long as the maximum time period between synchronizations. If an application obtains changes at longer intervals, the results returned might be incorrect because some of the change information has probably been removed. To avoid obtaining incorrect results, an application can use the `CHANGE_TRACKING_MIN_VALID_VERSION` system function to determine whether the interval between synchronizations has been too long.

You can use the `AUTO_CLEANUP` option to enable or disable the cleanup task that removes old change-tracking information. This can be useful when there's a temporary problem that prevents applications from synchronizing, and the process for removing change tracking information older than the retention period must be paused until the problem is resolved.

### Enabling change tracking on your tables

Similarly to change data capture, change tracking must be enabled for each table that you want tracked. When change tracking is enabled, change tracking information is maintained for all rows in the table that are affected by a DML operation.

The following example shows how to enable change tracking for a table by using `ALTER TABLE`:

```sql
ALTER TABLE SalesLT.Product
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = ON)
```

You can also enable change tracking for a table in SQL Server Management Studio by using the [Database Properties (ChangeTracking Page)](/sql/relational-databases/databases/database-properties-changetracking-page) dialog box.

When the `TRACK_COLUMNS_UPDATED` option is set to `ON`, the SQL Server Database Engine stores extra information about which columns were updated to the internal change tracking table. Column tracking can enable an application to synchronize only those columns that were updated. This can improve efficiency and performance; however, maintaining column-tracking information adds some extra storage overhead, so this option is set to `OFF` by default.

### Disabling change tracking on your database or tables

Change tracking must first be disabled for all change-tracked tables before change tracking can be set to `OFF` for the database. To determine the tables that have change tracking enabled for a database, use the `sys.change_tracking_tables` catalog view.

When no tables in a database track changes, you can disable change tracking for the database. The following example shows how to disable change tracking for a database by using `ALTER DATABASE`:

```sql
ALTER DATABASE AdventureWorksLT
SET CHANGE_TRACKING = OFF;
```

The following example shows how to disable change tracking for a table by using `ALTER TABLE`:

```sql
ALTER TABLE SalesLT.Product
DISABLE CHANGE_TRACKING;
```
