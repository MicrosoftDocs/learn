In SQL Server 2014, we added the `WAIT_AT_LOW_PRIORITY` clause to the `ALTER INDEX` command. In SQL Server 2022, we further enhanced our control over online index operations by also including this clause to the `CREATE INDEX` command.

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
CREATE NONCLUSTERED INDEX idx_CustomerID_OrderDate ON [AdventureWorks2012].[Sales].[SalesOrderHeader] (CustomerID, OrderDate)
WITH (ONLINE = ON (WAIT_AT_LOW_PRIORITY (MAX_DURATION = 10 MINUTES, ABORT_AFTER_WAIT = BLOCKERS)));
```

Adding the `WAIT_AT_LOW_PRIORITY` option to the `CREATE INDEX` command in SQL Server 2022 is a powerful tool in the DBA's arsenal. It helps you to manage lock contention during online index operations. By specifying the desired lock wait behavior, you can minimize how the index operations affect other queries and transactions, improving overall database performance and maintainability.
