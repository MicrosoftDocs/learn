To prevent users getting incorrect data returned from a SELECT statement, MySQL locks database objects. Innodb uses **metadata locking** to manage concurrent access and data consistency. Metadata locking affects the following commands:

- CREATE or DELETE INDEX
- MODIFY TABLE
- DROP TABLE
- Table maintenance operations, such as OPTIMIZE TABLE, TABLE REPAIR, etc.
- LOCK TABLE *mytable* WRITE

**Metadata locking** prevent DDL (data definition language) statements acting on affected objects while a transaction is in progress.

> [!NOTE]
> Data Definition Language (DDL) statements define the database objects. They are commands such as CREATE, ALTER, DROP, etc.

For **metadata locking** to work smoothly and without impacting performance, MySQL should have **autocommit** = ON. This prevents pending commits and locked objects preventing other users from accessing them. **Autocommit** is ON by default. If practical, perform DLL operations at times when few or no users are connected.

InnoDB also uses shared and exclusive row locks. A shared lock allows reads, and exclusive locks are exclusive to one transaction, thereby stopping other transactions modifying the row. Innodb will also lock tables if needed.

Gap locks are used to lock indexes and ensure consistent results from SELECT statements.

Deadlocks happen when two transactions are waiting on each other to release a lock. Innodb solves this by using the **innodb_lock_wait_timeout** parameter. The query will wait for the specified time, and then give up.

The following table describes the server parameters relating to locks. These parameters can also be set at the session level.

|Server Parameter           |Description                                                    |Default    |
|---------                  |---------                                                      |---------  |
|Innodb_lock_wait_timeout   |The time in seconds that a transaction waits for a row lock.   |50 seconds |
|Lock_wait_timeout          |The time in seconds to acquire metadata locks.                 |           |
