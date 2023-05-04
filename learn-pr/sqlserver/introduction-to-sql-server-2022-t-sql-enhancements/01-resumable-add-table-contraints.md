In SQL Server 2019, we added the ability to pause and resume index rebuild and creations. In SQL Server 2022, we introduced the resumable operation feature for adding table constraints. This feature allows the `ALTER TABLE ADD CONSTRAINT` command to be executed online, making it possible to pause, resume, and recover from failures during the addition of `PRIMARY KEY` and `UNIQUE` constraints.

## Resumable Add Table Constraints

The resumable add table constraint feature in SQL Server 2022 provides enhanced flexibility and control over constraint operations on large tables by allowing you to pause and resume an `ALTER TABLE ADD CONSTRAINT` operation to accommodate maintenance windows, recover from failures such as database failovers or insufficient disk space, and perform constraint operations on large tables even with limited log size availability.

## Constraint creation flexibility using the RESUMABLE predicate

Imagine you're a DBA responsible for maintaining the performance and data integrity of a large ERP database. You need to add a primary key constraint to the *AdventureWorks2012.Sales.SalesOrderDetail* table to ensure data consistency, but you also want to minimize how this operation affects other transactions and system resources.

With the resumable add table constraints feature in SQL Server 2022, you can achieve this goal by executing `ALTER TABLE ADD CONSTRAINT` operations with the `RESUMABLE` option. Here are two examples demonstrating how to use the resumable feature for adding table constraints:

```sql
-- Example 1: Add a PRIMARY KEY constraint with resumable operation and a MAX_DURATION of 120 minutes
ALTER TABLE [AdventureWorks2012].[Sales].[SalesOrderDetail]
ADD CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] 
	PRIMARY KEY (SalesOrderID, SalesOrderDetailID)
WITH (ONLINE = ON, RESUMABLE = ON, MAX_DURATION = 120);
```

## Pausing and resuming constraint creation

Assume that it's late in the day and the *PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID* constraint is still running. You don't want the creation of this constraint to affect any other operation at night, so you decide to pause the constraint creation and continue tomorrow morning.  Run the following command to pause it:

```sql
-- You might want to check if the actual constraint is already paused or still running and what percentage of the operation is complete 
SELECT sql_text, state_desc, percent_complete FROM sys.index_resumable_operations;

-- To pause the constraint run the following command
ALTER INDEX ALL ON [AdventureWorks2012].[Sales].[SalesOrderDetail] PAUSE
```

The next morning, to continue the constraint creation, you run the following command:

```sql
ALTER INDEX ALL ON [AdventureWorks2012].[Sales].[SalesOrderDetail] RESUME
```

The resumable add table constraints feature in SQL Server 2022, offers DBAs greater control over the execution of constraint operations on large tables. By using this feature, you can minimize how the constraint operations affect system resources and other transactions, improving overall database performance and maintainability.
