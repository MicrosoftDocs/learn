One feature of relational databases is locking, which is essential to maintain the atomicity, consistency, and isolation properties of the ACID model. All RDBMSs will block actions that would violate the consistency and isolation of writes to a database. SQL programmers are responsible for starting and ending transactions at the right point, in order to ensure the logical consistency of their data. In turn, the database engine provides locking mechanisms that also protect the logical consistency of the tables affected by those queries. These actions are a foundational part of the relational model.

On SQL Server, blocking occurs when one process holds a lock on a specific resource (row, page, table, database), and a second process attempts to acquire a lock with an incompatible lock type on the same resource. Typically, locks are held for a short period, and when the process holding the lock releases it, the blocked process can then acquire the lock and complete its transaction.

SQL Server locks the smallest amount of data needed to successfully complete the transaction. This behavior allows maximum concurrency. For example, if SQL Server is locking a single row, all other rows in the table are available for other processes to use, so concurrent work can go on. However, each lock requires memory resources, so it’s not cost-effective for one process to have thousands of individual locks on a single table. SQL Server tries to balance concurrency with cost. One technique used is called lock escalation. If SQL Server needs to lock more than 5000 rows on a single object in a single statement, it will escalate the multiple row locks to a single table lock.

Locking is normal behavior and happens many times during a normal day. Locking only become a problem when it causes blocking that isn't quickly resolved. There are two types of performance issues that can be caused by blocking:

- A process holds locks on a set of resources for an extended period of time before releasing them. These locks cause other processes to block, which can degrade query performance and concurrency.

- A process gets locks on a set of resources, and never releases them. This problem requires administrator intervention to resolve.

Another blocking scenario is deadlocking, which occurs when one transaction has a lock on a resource, and another transaction has a lock on a second resource. Each transaction then attempts to take a lock on the resource, which is currently locked by the other transaction. Theoretically, this scenario would lead to an infinite wait, as neither transaction could complete. However, the SQL Server engine has a mechanism for detecting these scenarios and will kill one of the transactions in order to alleviate the deadlock, based on which transaction has performed the least of amount of work that would need to be rolled back. The transaction that is killed is known as the deadlock victim. Deadlocks are recorded in the *system_health* extended event session, which is enabled by default.

It's important to understand the concept of a transaction. Auto-commit is the default mode of SQL Server and Azure SQL Database, which means the changes made by the statement below would automatically be recorded in the database's transaction log.

```SQL
INSERT INTO DemoTable (A) VALUES (1);
```

In order to allow developers to have more granular control over their application code, SQL Server also allows you to explicitly control your transactions. The query below would take a lock on a row in the *DemoTable* table what wouldn't be released until a subsequent command to commit the transaction was added.

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

The `COMMIT TRANSACTION` command explicitly commits a record of the changes to the transaction log. The changed data will eventually make its way into the data file asynchronously. These transactions represent a unit of work to the database engine. If the developer forgets to issue the `COMMIT TRANSACTION` command, the transaction will stay open and the locks won't be released. This is one of the main reasons for long running transactions.

The other mechanism the database engine uses to help the concurrency of the database is row versioning. When a row versioning isolation level is enabled to the database, the engine maintains versions of each modified row in TempDB. This is typically used in mixed use workloads, in order to prevent reading queries from blocking queries that are writing to the database.

To monitor open transactions awaiting commit or rollback run the following query:

```sql
SELECT tst.session_id, [database_name] = db_name(s.database_id)
    , tat.transaction_begin_time
    , transaction_duration_s = datediff(s, tat.transaction_begin_time, sysdatetime()) 
    , transaction_type = CASE tat.transaction_type  WHEN 1 THEN 'Read/write transaction'
        WHEN 2 THEN 'Read-only transaction'
        WHEN 3 THEN 'System transaction'
        WHEN 4 THEN 'Distributed transaction' END
    , input_buffer = ib.event_info, tat.transaction_uow     
    , transaction_state  = CASE tat.transaction_state    
        WHEN 0 THEN 'The transaction has not been completely initialized yet.'
        WHEN 1 THEN 'The transaction has been initialized but has not started.'
        WHEN 2 THEN 'The transaction is active - has not been committed or rolled back.'
        WHEN 3 THEN 'The transaction has ended. This is used for read-only transactions.'
        WHEN 4 THEN 'The commit process has been initiated on the distributed transaction.'
        WHEN 5 THEN 'The transaction is in a prepared state and waiting resolution.'
        WHEN 6 THEN 'The transaction has been committed.'
        WHEN 7 THEN 'The transaction is being rolled back.'
        WHEN 8 THEN 'The transaction has been rolled back.' END 
    , transaction_name = tat.name, request_status = r.status
    , tst.is_user_transaction, tst.is_local
    , session_open_transaction_count = tst.open_transaction_count  
    , s.host_name, s.program_name, s.client_interface_name, s.login_name, s.is_user_process
FROM sys.dm_tran_active_transactions tat 
INNER JOIN sys.dm_tran_session_transactions tst  on tat.transaction_id = tst.transaction_id
INNER JOIN Sys.dm_exec_sessions s on s.session_id = tst.session_id 
LEFT OUTER JOIN sys.dm_exec_requests r on r.session_id = s.session_id
CROSS APPLY sys.dm_exec_input_buffer(s.session_id, null) AS ib
ORDER BY tat.transaction_begin_time DESC;
```

## Isolation levels

SQL Server offers several isolation levels to allow you to define the level of consistency and correctness you need guaranteed for your data. Isolation levels let you find a balance between concurrency and consistency. The isolation level doesn't affect the locks taken to prevent data modification, a transaction will always get an exclusive lock on the data that is modifying. However, your isolation level can affect the length of time that your locks are held. Lower isolation levels increase the ability of multiple user process to access data at the same time, but increase the data consistency risks that can occur. The isolation levels in SQL Server are as follows:

- **Read uncommitted** – Lowest isolation level available. Dirty reads are allowed, which means one transaction may see changes made by another transaction that haven't yet been committed.

- **Read committed** – allows a transaction to read data previously read, but not modified by another transaction with without waiting for the first transaction to finish. This level also releases read locks as soon as the select operation is performed. This is the default SQL Server level.

- **Repeatable Read** – This level keeps read and write locks that are acquired on selected data until the end of the transaction.

- **Serializable** – This is the highest level of isolation where transactions are isolated. Read and write locks are acquired on selected data and not released until the end of the transaction.

SQL Server also includes two isolation levels that include row-versioning.

- **Read Committed Snapshot** – In this level read operations take no row or page locks, and the engine presents each operation with a consistent snapshot of the data as it existed at the start of the query. This level is typically used when users are running frequent reporting queries against an OLTP database, in order to prevent the read operations from blocking the write operations.

- **Snapshot** – This level provides transaction level read consistency through row versioning. This level is vulnerable to update conflicts. If a transaction running under this level reads data modified by another transaction, an update by the snapshot transaction will be terminated and roll back. This isn't an issue with read committed snapshot isolation.

Isolation levels are set for each session with the T-SQL `SET` command, as shown:

```SQL
SET TRANSACTION ISOLATION LEVEL

 { READ UNCOMMITTED

 | READ COMMITTED

 | REPEATABLE READ

 | SNAPSHOT

 | SERIALIZABLE

 }
```

There's no way to set a global isolation level all queries running in a database, or for all queries run by a particular user. It's a session level setting.

## Monitoring for blocking problems

Identifying blocking problem can be troublesome as they can be sporadic in nature. There's a DMV called `sys.dm_tran_locks`, which can be joined with `sys.dm_exec_requests` in order to provide further information on locks that each session is holding. A better way to monitor for blocking problems is to do so on an ongoing basis using the Extended Events engine.

Blocking problems typically fall into two categories:

- Poor transactional design. As shown above, a transaction that has no `COMMIT TRANSACTION` will never end. While that is a simple example, trying to do too much work in a single transaction or having a distributed transaction, which uses a linked server connection, can lead to unpredictable performance.

- Long running transactions caused by schema design. Frequently this can be an update on a column with a missing index, or poorly designed update query.

Monitoring for locking-related performance problems allows you to quickly identity performance degradation related to locking.

For more information about how to monitor blocking, see [Understand and resolve SQL Server blocking problems](/troubleshoot/sql/performance/understand-resolve-blocking).
