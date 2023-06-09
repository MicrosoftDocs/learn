In this exercise, you'll learn how you can enable and disable change tracking and obtain tracked changes.

### Enabling change tracking on your database

Enable change tracking on your database by running the following `ALTER DATABASE` query:

```sql
ALTER DATABASE AdventureWorksLT
SET CHANGE_TRACKING = ON
(CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON)
```

You can also enable change tracking in SQL Server Management Studio by using the [Database Properties (ChangeTracking Page)](/sql/relational-databases/databases/database-properties-changetracking-page) dialog box. If a database contains memory optimized tables, you can’t enable change tracking with SQL Server Management Studio.

### Enabling change tracking on your tables

Enable change tracking on the table by running the following `ALTER TABLE` query:

```sql
ALTER TABLE SalesLT.Product
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = ON)
```

You can also enable change tracking for a table in SQL Server Management Studio by using the [Database Properties (ChangeTracking Page)](/sql/relational-databases/databases/database-properties-changetracking-page) dialog box.

### Update the record in table

Update a record into `SalesLT.Product` table to trigger change tracking.

```sql
UPDATE SalesLT.Product  
SET ListPrice = 1000    --pass any random List Price
FROM SalesLT.Product AS P  
WHERE ProductID = 680   --pass any ProductID 
```

### Obtain changes by using change tracking functions

Applications can use the following functions to obtain the changes that are made in a database and information about the changes:

#### `CHANGETABLE(CHANGES ...)` function

Use this rowset function to query for change information. The function queries the data stored in the internal change-tracking tables. The function returns a results set that contains the primary keys of rows that have changed, together with other change information such as the operation, columns updated, and version for the row.

`CHANGETABLE(CHANGES ...)` takes a last synchronization version as an argument. The last synchronization version is obtained using the `@last_synchronization_version` variable.

The following is an example of how to use this function to obtain changes for a `SalesLT.Product` table:

```sql
DECLARE @last_synchronization_version BIGINT;
SELECT
    CT.ProductID, CT.SYS_CHANGE_OPERATION,  
    CT.SYS_CHANGE_COLUMNS, CT.SYS_CHANGE_CONTEXT  
FROM 
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT
```

### Obtain the latest data

Usually, a client will want to obtain the latest data for a row, instead of only the primary keys for the row. Therefore, an application would join the results from `CHANGETABLE(CHANGES ...)` with the data in the user table. For example, the following query joins with the `SalesLT.Product` table to obtain the values for the `Name` and `ListPrice` columns. Note the use of `OUTER JOIN`. This is required to make sure that the change information is returned for those rows that have been deleted from the user table.

```sql
DECLARE @last_synchronization_version BIGINT;
  
SELECT  
    CT.ProductID, P.Name, P.ListPrice,  
    CT.SYS_CHANGE_OPERATION, CT.SYS_CHANGE_COLUMNS,  
    CT.SYS_CHANGE_CONTEXT  
FROM  
    SalesLT.Product AS P  
RIGHT OUTER JOIN  
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT  
ON  
    P.ProductID = CT.ProductID
```

#### `CHANGE_TRACKING_CURRENT_VERSION()` function

You can use this function to obtain the current version that will be used the next time when querying changes. This version represents the version of the last committed transaction.

When an application obtains changes, it must use both `CHANGETABLE(CHANGES...)` and `CHANGE_TRACKING_CURRENT_VERSION()` functions.
The following example shows how to obtain the initial synchronization version and the initial dataset:

```sql
DECLARE @synchronization_version BIGINT;

-- Obtain the current synchronization version. This will be used next time that changes are obtained.  
SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION(); 
```

#### `CHANGE_TRACKING_MIN_VALID_VERSION()` function

You can use this function to obtain the minimum valid version that a client can have and still obtain valid results from `CHANGETABLE()`. The client should check the last synchronization version against the value that this function returns. If the last synchronization version is less than the version returned by this function, the client will be unable to obtain valid results from `CHANGETABLE()` and will have to reinitialize.

The following example shows how to verify the validity of the value of `last_synchronization_version` for each table:

```sql
-- Check individual table.
IF (@last_synchronization_version < CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('SalesLT.Product')))  
BEGIN
  -- Handle invalid version and do not enumerate changes.
  -- Client must be reinitialized.
END
```

### Disabling change tracking on your database & tables

Change tracking must first be disabled for all change-tracked tables before change tracking can be set to OFF for the database. To determine the tables that have change tracking enabled for a database, use the `sys.change_tracking_tables` catalog view.

Disable change tracking for a table by using the following `ALTER TABLE` query:

```sql
ALTER TABLE SalesLT.Product
DISABLE CHANGE_TRACKING;
```

When no tables in a database are tracking changes, you can disable change tracking for the database.

Disable change tracking for a database by using the following `ALTER DATABASE` query:

```sql
ALTER DATABASE AdventureWorksLT
SET CHANGE_TRACKING = OFF;
```
