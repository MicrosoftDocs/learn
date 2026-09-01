A core feature of multiuser databases is concurrency. Concurrency uses locking and blocking to enable data to remain consistent with many users updating and reading data at the same time. For example, because of shipping costs, all of our products have a $5 price increase. At the same time, because of currency rates, all products have a 3% price decrease. If these updates happen at exactly the same time, the final price will be variable and there are likely to be many errors. Using locking, you can ensure that one update will complete before the other one begins.

Concurrency occurs at the transaction level. A writing transaction can block other transactions from updating and even reading the same data. Equally, a reading transaction can block other readers or even some writers. For this reason, it's important to avoid needlessly long transactions or transactions spanning excessive amounts of data.

There are many specific transaction isolation levels that can be used to define how a database system handles multiple users. For the purposes of this module, we'll look at broad categories of isolation level, optimistic locking, and pessimistic locking.

> [!NOTE]
> The full detail of transaction locking beyond concurrency is related more to performance and not only dependent on the code—although good code performs better. For deeper detail, review the [SQL Server transaction locking and row versioning guide](/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide). For information about blocking, also review the [SQL Server Performance documentation](/troubleshoot/sql/performance/understand-resolve-blocking).

## Optimistic concurrency

With optimistic locking there's an assumption that few conflicting updates will occur. At the start of the transaction, the initial state of the data is recorded. Before the transaction is committed, the current state is compared with the initial state. If the states are the same, the transaction is completed. If the states are different, the transaction is rolled back.

For example, you have a table containing last years sales orders. This data is infrequently updated, but reports are run often. By using optimistic locking, transactions don't block each other and the system runs more efficiently. Unfortunately, errors have been found in last years data and updates need to take place. While one transaction is updating every row, another transaction makes a minor edit to a single row at the same time. Because the state of the data was changed while the initial transaction was running, the whole transaction is rolled back.

## Pessimistic concurrency

With pessimistic locking there's an assumption that many updates are happening to the data at the same time. By using locks only one update can happen at the same time, and reads of the data are prevented while updates are taking place. This can prevent large rollbacks, as seen in the previous example, but can cause queries to be blocked unnecessarily.

It's important to consider the nature of your data and the queries running on the data when deciding whether to use optimistic or pessimistic concurrency to ensure optimum performance.

## Snapshot isolation

SQL Server supports five transaction isolation levels—`READ UNCOMMITTED`, `READ COMMITTED`, `REPEATABLE READ`, `SNAPSHOT`, and `SERIALIZABLE`—set per session with `SET TRANSACTION ISOLATION LEVEL`. Separately, `READ_COMMITTED_SNAPSHOT` is a *database-level option* (set with `ALTER DATABASE`) that changes how the `READ COMMITTED` isolation level behaves. For this module we focus on those two database-option settings, because they determine whether the default `READ COMMITTED` transactions use pessimistic locking or row versioning.

- With `READ_COMMITTED_SNAPSHOT OFF` (the default for SQL Server), `READ COMMITTED` transactions acquire shared locks on rows they read and hold them until the read completes. This prevents most conflicting changes to the data being read and is a form of **pessimistic concurrency**.
- With `READ_COMMITTED_SNAPSHOT ON` (the default for Azure SQL Database and Azure SQL Managed Instance), `READ COMMITTED` transactions use **row versioning** stored in `tempdb`. Each statement sees the last committed version of each row as of when that statement started, so readers never block writers and writers never block readers. Writers still acquire standard exclusive locks, so concurrent writes to the same row still block each other. This is a form of **optimistic concurrency for reads**—but note there's no automatic commit-time conflict detection for writes; that behavior belongs to the separate `SNAPSHOT` isolation level.

To turn `READ_COMMITTED_SNAPSHOT` on, run:

```sql
ALTER DATABASE <db_name> SET READ_COMMITTED_SNAPSHOT ON;
```

To turn it off:

```sql
ALTER DATABASE <db_name> SET READ_COMMITTED_SNAPSHOT OFF;
```

If the database has been altered to turn on read committed snapshot, any transaction that uses the default `READ COMMITTED` isolation level uses row versioning instead of shared read locks.

> [!NOTE]
> The `READ_COMMITTED_SNAPSHOT` database option only affects transactions running at the `READ COMMITTED` isolation level. Transactions explicitly using other isolation levels (`REPEATABLE READ`, `SERIALIZABLE`, or `SNAPSHOT`) aren't affected by this option.
