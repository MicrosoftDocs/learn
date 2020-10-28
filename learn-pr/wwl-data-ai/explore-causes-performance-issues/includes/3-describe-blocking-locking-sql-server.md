One feature of relational databases is locking, which is essential to maintain the atomicity, consistency, and isolation properties of the ACID model. All RDBMSs will block actions that would violate the consistency and isolation of writes to a database. When programming in SQL, programmers are responsible for starting and ending transactions at the right point, in order to ensure the logical consistency of their data. In turn, the database engine provides locking mechanisms that also protect the logical consistency of the tables affected by those queries. These actions are a foundational part of the relational model.

On SQL Server, blocking occurs when one process holds a lock on a specific resource (row, page, table, database), and a second process attempts to acquire a lock with an incompatible lock type on the same resource. Typically, locks are held for a very short period, and when the process holding the lock releases it, the blocked process can then acquire the lock and complete its transaction.

SQL Server locks the smallest amount of data needed to successfully complete the transaction. This behavior allows maximum concurrency. For example, if SQL Server is locking a single row, all other rows in the table are available for other processes to use, so a lot of concurrent work can go on. However, each lock requires memory resources, so it’s not cost-effective for one process to have thousands of individual locks on a single table. SQL Server tries to balance concurrency with cost. One technique used is called lock escalation. If SQL Server needs to lock more than 5000 rows on a single object in a single statement, it will escalate the multiple row locks to a single table lock.

Locking is normal behavior and happens many times during a normal day. Locking only become a problem when it causes blocking that is not quickly resolved. There are two types of performance issues that can be caused by blocking:

- A process holds locks on a set of resources for an extended period of time before releasing them. These locks cause other processes to block, which can degrade query performance and concurrency.

- A process gets locks on a set of resources, and never releases them. This problem requires administrator intervention to resolve.

Another blocking scenario is deadlocking, which occurs when one transaction has a lock on a resource, and another transaction has a lock on a second resource. Each transaction then attempts to take a lock on the resource which is currently locked by the other transaction. Theoretically, this scenario would lead to an infinite wait, as neither transaction could complete. However, the SQL Server engine has a mechanism for detecting these scenarios and will kill one of the transactions in order to alleviate the deadlock, based on which transaction has performed the least of amount of work that would need to be rolled back. The transaction that is killed is known as the deadlock victim. Deadlocks are recorded in the *system_health* extended event session which is enabled by default.

It is important to understand the concept of a transaction. By default, SQL Server and Azure SQL Database are in autocommit mode, which means the changes made by the statement below would automatically be written to the database’s transaction log upon completion.

```SQL
INSERT INTO DemoTable (A) VALUES (1);
```

In order to allow developers to have more granular control over their application code, SQL Server also allows you to explicitly control your transactions. The query below would take a lock on a row in the DemoTable table what would not be released until a subsequent command to commit the transaction was added.

```SQL
BEGIN TRANSACTION

INSERT INTO DemoTable (A) VALUES (1);
```

The proper way to write the above query is as follows:

```SQL
BEGIN TRANSACTION

INSERT INTO DemoTable (A) VALUES (1);

COMMIT TRANSACTION
```

The COMMIT TRANSACTION command explicitly commits a record of the changes to the transaction log. The changed data will eventually make its way into the data file asynchronously. These transactions represent a unit of work to the database engine. If the developer forgets to issue the COMMIT TRANSACTION command, the transaction will stay open and the locks will not be released. This is one of the main reasons for long running transactions. They’re not really long-running, but they’ve just not been handled properly.

The other mechanism the database engine uses to help the concurrency of the database is row versioning. When a row versioning isolation level is enabled the database, engine maintains versions of each modified row in TempDB. This is typically used in mixed use workloads, in order to prevent reading queries from blocking queries that are writing to the database.

## Isolation levels

SQL Server offers several isolation levels to allow you to define the level of consistency and correctness you need guaranteed for your data. Isolation levels let you find a balance between concurrency and consistency. The isolation level does not affect the locks taken to prevent data modification, a transaction will always get an exclusive lock on the data that is modifying. However, your isolation level can affect the length of time that your locks are held. Lower isolation levels increase the ability of multiple user process to access data at the same time, but increase the data consistency risks that can occur. The isolation levels in SQL Server are as follows:

**Read uncommitted** - This is the lowest isolation level available. Dirty reads are allowed, which means one transaction may see changes made by another transaction that have not yet been committed.

**Read committed** - This level allows a transaction to read data previously read, but not modified by another transaction with without waiting for the first transaction to finish. This level also releases read locks as soon as the select operation is performed. This is the default SQL Server level.

**Repeatable Read** - This level keeps read and write locks that are acquired on selected data until the end of the transaction.

**Serializable** - This is the highest level of isolation where transactions are completely isolated. Read and write locks are acquired on selected data and not released until the end of the transaction.

SQL Server also includes two isolation levels that include row-versioning.

**Read Committed Snapshot** - In this level read operations take no row or page logs, and the engine presents each operation with a transactionally consistent snapshot of the data as it existed at the start of the query. This level is typically used when users are running frequent reporting queries against an OLTP database, in order to prevent the read operations from blocking the write operations.

**Snapshot** - This level provides transaction level read consistency through row versioning. This level is vulnerable to update conflicts. If a transaction running under this level reads data modified by another transaction, an update by the snapshot transaction will be terminated and roll back. This is not an issue with read committed snapshot isolation.

Isolation levels are set for each session with the T-SQL SET command, as shown:

```SQL
SET TRANSACTION ISOLATION LEVEL

 { READ UNCOMMITTED

 | READ COMMITTED

 | REPEATABLE READ

 | SNAPSHOT

 | SERIALIZABLE

 }
```

There is no way to set a global isolation level all queries running in a database, or for all queries run by a particular user. It is a session level setting.

## Monitoring for blocking problems

Identifying blocking problem can be troublesome as they can be sporadic in nature. There is a DMV called *sys.dm_tran_locks*, which can be joined with *sys.dm_exec_requests* in order to provide further information on locks that each session is holding. A better way to monitor for blocking problems is to do so on an ongoing basis using the Extended Events engine.

Blocking problems typically fall into two categories:

- Poor transactional design. As shown above, a transaction that has no COMMIT TRANSACTION will never end. While that is a very simple example, trying to do too much work in a single transaction or having a distributed transaction which uses a linked server connection, can lead to unpredictable performance.

- Long running transactions caused by schema design. Frequently this can be an update on a column with a missing index, or poorly designed update query.

Monitoring for locking-related performance problems allows you to quickly identity performance degradation related to locking.
