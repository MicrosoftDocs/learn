MVCC provides the appropriate concurrency settings for most scenarios, but if an application requires specific locks that control exactly which rows are affected and with a specific lock level, then explicit lock modes enable this fine-grained control.

In Azure Database for PostgreSQL, there are three types of explicit lock, table-level locks, row-level-locks, and page-level locks. The initial transaction will ask for a lock and, if accepted, this will become the existing lock. If another transaction tries to take out a lock on the same data, it will only be accepted if it does not conflict with the original transaction.

For example, two transactions can query the same data at the same time with a SELECT statement. This would use an ACCESS SHARE lock and they would both be allowed. In another scenario, one transaction is querying data with a SELECT statement and an ACCESS SHARE lock, but at the same time another transaction tries to drop the same table. Dropping a table requires an ACCESS EXCLUSIVE lock which would not be granted, in this scenario.

## Table-level locks

Table level locks acquire locks on an entire table, even if they have ROW in their name. Locking an entire table might be required if the table itself is being modified, or might be more efficient than taking out many row-level locks.

There are eight types of table-level lock in Azure Database for PostgreSQL and these are the SQL commands that acquire these locks:


|Lock Mode  |Acquired by  |
|---------|---------|
|ACCESS SHARE     |SELECT command         |
|ROW SHARE     |SELECT FOR UPDATE and SELECT FOR SHARE commands         |
|ROW EXCLUSIVE     |UPDATE, DELETE, and INSERT commands         |
|SHARE UPDATE EXCLUSIVE     |ANALYZE, CREATE INDEX CONCURRENTLY, CREATE STATISTICS, COMMENT ON, REINDEX CONCURRENTLY commands, some ALTER INDEX and ALTER TABLE commands, and VACUUM (not FULL)         |
|SHARE     |CREATE INDEX (not CONCURRENTLY) command        |
|SHARE ROW EXCLUSIVE     |CREATE TRIGGER command and some ALTER TABLE commands         |
|EXCLUSIVE     |REFRESH MATERIALIZED VIEW CONCURRENTLY command         |
|ACCESS EXCLUSIVE     |DROP TABLE, REINDEX, TRUNCATE, CLUSTER, REFRESH MATERIALIZED VIEW (not CONCURRENTLY) commands, most ALTER INDEX and ALTER TABLE commands, and VACUUM FULL         |

Each type of existing lock will block other requested locks being acquired. The following table lists which lock types will be blocked:


|   | Existing ACCESS SHARE  | Existing ROW SHARE | Existing ROW EXCLUSIVE | Existing SHARE UPDATE EXCLUSIVE | Existing SHARE | Existing SHARE ROW EXCL | Existing EXCLUSIVE | Existing ACCESS EXCLUSIVE |
| -------------------- | - | -------------- | ----------- | ----------- | -------------------- | ------- | ----------------- | ------- |
| Requested ACCESS SHARE       |   |                |             |             |                      |         |                   |Blocked      |
| Requested ROW SHARE          |   |                |             |             |                      |         |Blocked                |Blocked      |
| Requested ROW EXCLUSIVE          |   |                |             |             |Blocked                   |Blocked      |Blocked                |Blocked      |
| Requested SHARE UPDATE EXCLUSIVE |   |                |             |Blocked          |Blocked                   |Blocked      |Blocked                |Blocked      |
| Requested SHARE              |   |                |Blocked          |Blocked          |                      |Blocked      |Blocked                |Blocked      |
| Requested SHARE ROW EXCLUSIVE    |   |                |Blocked          |Blocked          |Blocked                   |Blocked      |Blocked                |Blocked      |
| Requested EXCLUSIVE              |   |Blocked             |Blocked          |Blocked          |Blocked                   |Blocked      |Blocked                |Blocked      |
| Requested ACCESS EXCLUSIVE       |Blocked|Blocked             |Blocked          |Blocked          |Blocked                   |Blocked      |Blocked                |Blocked      |

## Row-level locks

Row level locks are more granular and will only affect another transaction that is accessing the same row. This improves concurrency, but acquiring and dropping many locks will negatively affect performance. Row-level locks are automatically acquired by PostgreSQL and are not applied manually.

There are four types of row-level lock in Azure Database for PostgreSQL and they are acquired depending on which other lock types need to be blocked:


| | Existing FOR KEY SHARE | Existing FOR SHARE | Existing FOR NO KEY UPDATE | Existing FOR UPDATE |
| ------------------- | ----------------- | ------------- | --------- | ----------------- |
| Requested FOR KEY SHARE       |                   |               |           |Blocked                |
| Requested FOR SHARE           |                   |               |Blocked        |Blocked                |
| Requested FOR NO KEY UPDATE   |                   |Blocked            |Blocked        |Blocked                |
| Requested FOR UPDATE          |Blocked                |Blocked            |Blocked        |Blocked                |

## Page-level locks

Page-level locks affect a page of data, which typically consists of multiple rows. Although PostgreSQL processes use page-level locks they are not typically required by application developers.

## Manually applying locks and viewing current locks

To manually apply a table-level lock, you can use the LOCK command with the required lock mode. The LOCK command must be within a transaction and the locks are released when the transaction completes. For example:

```sql
BEGIN TRANSACTION;
LOCK TABLE humanresources.department IN ROW EXCLUSIVE MODE;
COMMIT;
```

To view locks that are currently held on the database, use **pg_locks**. For example, to view all current locks, use the following command:

```sql
SELECT * FROM pg_locks;
```
