---
ms.custom:
  - build-2023
---
New enhancements have been added to SQL Server 2022 to help control the creation of indexes, and unique and primary key constraints for large tables. These improvements include extending the `WAIT_AT_LOW_PRIORITY` clause to the `CREATE INDEX` command, and introducing the resumable operation feature for adding table constraints, using the `ALTER TABLE ADD CONSTRAINT` command. By incorporating these features, we can better manage lock contention, minimize how the operations affect other queries and transactions, and ultimately enhance overall database performance and maintainability.

## Resumable add table constraints

The resumable add table constraint feature in SQL Server 2022 provides enhanced flexibility and control over constraint operations on large tables, by allowing you to pause and resume an `ALTER TABLE ADD CONSTRAINT` operation to accommodate maintenance windows, recover from failures such as database failovers or insufficient disk space, and perform constraint operations on large tables, even with limited log size availability.

## Constraint creation flexibility using the RESUMABLE predicate

Imagine you're a DBA responsible for maintaining the performance and data integrity of a large ERP database. You need to add a primary key constraint to the *AdventureWorks2012.Sales.SalesOrderDetail* table to ensure data consistency, but you also want to minimize how this operation affects other transactions and system resources.

With the resumable add table constraints feature in SQL Server 2022, you can achieve this goal by executing `ALTER TABLE ADD CONSTRAINT` operations with the `RESUMABLE` option. Here are two examples demonstrating how to use the resumable feature for adding table constraints:

```sql
-- Example 1: Add a PRIMARY KEY constraint with resumable operation and a MAX_DURATION of 120 minutes
ALTER TABLE [AdventureWorks2022].[Sales].[SalesOrderDetail]
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
ALTER INDEX ALL ON [AdventureWorks2012].[Sales].[SalesOrderDetail] PAUSE;
```

The next morning, to continue the constraint creation, you run the following command:

```sql
ALTER INDEX ALL ON [AdventureWorks2012].[Sales].[SalesOrderDetail] RESUME;
```

## WAIT_AT_LOW_PRIORITY

SQL Server 2022 provides three actions to `CREATE INDEX` online index operations using the `WAIT_AT_LOW_PRIORITY` option when waiting for schema stability (`Sch-S`) and schema modification (`Sch-M`) locks. The `NONE` action continues waiting for the lock with normal priority, the `SELF` action terminates the online index operation without taking any action, and the `BLOCKERS` action terminates all user transactions blocking the online index operation.

## Improve query performance with WAIT_AT_LOW_PRIORITY

Imagine you're a DBA responsible for maintaining the performance of a busy e-commerce database. You need to create a new index on the Orders table to improve query performance, but you want to minimize how this command affect other transactions.

With the `WAIT_AT_LOW_PRIORITY` option in SQL Server 2022, you can achieve this goal by specifying lock wait behavior during online index creation. Here are two examples choosing to terminate either the create index command or the blocker commands using the `WAIT_AT_LOW_PRIORITY` settings:

```sql
-- Example 1: Terminate the index creation after waiting 10 minutes for low priority locks
CREATE NONCLUSTERED INDEX idx_CustomerID_OrderDate ON [AdventureWorks2012].[Sales].[SalesOrderHeader] (CustomerID, OrderDate)
WITH (ONLINE = ON (WAIT_AT_LOW_PRIORITY (MAX_DURATION = 10 MINUTES, ABORT_AFTER_WAIT = SELF)));
```

```sql
-- Example 2: Terminate blocking transactions after waiting 10 minutes for low priority locks
CREATE NONCLUSTERED INDEX idx_CustomerID_OrderDate ON [AdventureWorks2022].[Sales].[SalesOrderHeader] (CustomerID, OrderDate)
WITH (ONLINE = ON (WAIT_AT_LOW_PRIORITY (MAX_DURATION = 10 MINUTES, ABORT_AFTER_WAIT = BLOCKERS)));
```

SQL Server 2022 introduces the `WAIT_AT_LOW_PRIORITY` option to the `CREATE INDEX` statement and resumable add table constraints feature, enhancing control over database operations. DBAs can manage lock contention, reduce the load on resources, and boost performance and maintainability. These improvements highlight a commitment to optimizing SQL Server for modern database administrators.
