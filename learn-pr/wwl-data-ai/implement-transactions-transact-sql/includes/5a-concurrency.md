A core feature of multiuser databases is concurrency. Concurrency uses locking and blocking to enable data to remain consistent with many users updating and reading data at the same time. For example, because of shipping costs, all of our products have a $5 price increase. At the same time, because of currency rates, all products have a 3% price decrease. If these updates happen at exactly the same time, the final price will be variable and there are likely to be many errors. Using locking, you can ensure that one update will complete before the other one begins.

Concurrency occurs at the transaction level. A writing transaction can block other transactions from updating and even reading the same data. Equally, a reading transaction can block other readers or even some writers. For this reason, it's important to avoid needlessly long transactions or transactions spanning excessive amounts of data.

There are many specific transaction isolation levels that can be used to define how a database system handles multiple users. For the purposes of this module, we'll look at broad categories of isolation level, optimistic locking, and pessimistic locking.

> [!NOTE]
> The full detail of transaction locking beyond concurrency is related more to performance and not only dependent on the code - although good code performs better. Please review the in-depth [SQL Server Transaction Locking and Row Versioning Guide](/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide?) for more details. For information about blocking, also review the [SQL Server Performance documentation](/troubleshoot/sql/performance/understand-resolve-blocking).

## Optimistic concurrency

With optimistic locking there's an assumption that few conflicting updates will occur. At the start of the transaction, the initial state of the data is recorded. Before the transaction is committed, the current state is compared with the initial state. If the states are the same, the transaction is completed. If the states are different, the transaction is rolled back.

For example, you have a table containing last years sales orders. This data is infrequently updated, but reports are run often. By using optimistic locking, transactions don't block each other and the system runs more efficiently. Unfortunately, errors have been found in last years data and updates need to take place. While one transaction is updating every row, another transaction makes a minor edit to a single row at the same time. Because the state of the data was changed while the initial transaction was running, the whole transaction is rolled back.

## Pessimistic concurrency

With pessimistic locking there's an assumption that many updates are happening to the data at the same time. By using locks only one update can happen at the same time, and reads of the data are prevented while updates are taking place. This can prevent large rollbacks, as seen in the previous example, but can cause queries to be blocked unnecessarily.

It's important to consider the nature of your data and the queries running on the data when deciding whether to use optimistic or pessimistic concurrency to ensure optimum performance.

## Snapshot isolation

There are five different isolation levels in SQL Server, but for this module we'll concentrate on just READ_COMMITTED_SNAPSHOT_OFF and READ_COMMITTED_SNAPSHOT_ON. READ_COMMITTED_SNAPSHOT_OFF is the default isolation level for SQL Server. READ_COMMITTED_SNAPSHOT_ON is the default isolation level for Azure SQL Database.

READ_COMMITTED_SNAPSHOT_OFF will hold locks on the affected rows until the end of the transaction if query is using the read committed transaction isolation level. While it's possible for some updates to occur, such as the creation of a new row, this will prevent most conflicting changes to the data being read or updated. This is pessimistic concurrency.

READ_COMMITTED_SNAPSHOT_ON takes a snapshot of the data. Updates are then done on that snapshot allowing other connections to query the original data. At the end of the transaction the current state of the data is compared to the snapshot. If the data is the same, the transaction is committed. If the data differs, the transaction is rolled back.

To change the isolation level to READ_COMMITTED_SNAPSHOT_ON issue the following command:

```sql
ALTER DATABASE *db_name* SET READ_COMMITTED_SNAPSHOT ON;
```

To change the isolation level to READ_COMMITTED_SNAPSHOT_OFF issue the following command:

```sql
ALTER DATABASE *db_name* SET READ_COMMITTED_SNAPSHOT OFF;
```

If the database has been altered to turn on read committed snapshot, any transaction that uses the default read committed isolation level will use optimistic locking.

> [!NOTE]
> Snapshot isolation only occurs for read committed transactions. Transactions that use other isolation levels are not affected.
