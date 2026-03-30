Choosing the right hardware and configuration is only part of database performance. What happens when two customers try to buy the last item in stock at the exact same moment? Or when a report reads a price that another transaction is in the middle of changing? Transaction isolation levels control how the database handles these situations.

## How isolation levels work

Isolation levels define how much one transaction can see of another transaction's uncommitted work. The SQL standard frames them around three **concurrency side effects**, each of which maps to a real problem in your applications. Let's use an e-commerce application to illustrate them:

- **Dirty reads**: A customer's order reads a discounted price that another transaction set but isn't committed yet. If the transaction that set the price rolls back, the order used a price that never existed. Dirty reads are defined as reading uncommitted data from another transaction, which can lead to incorrect behavior if that other transaction doesn't commit.
- **Nonrepeatable reads**: On the same transaction, your inventory service reads the stock count for an item. After the initial read, the transaction does some calculations, then reads the same row again. In between those steps, another transaction committed a change, so the count is now different. Nonrepeatable reads occur when a transaction reads the same row twice and gets different values each time.
- **Phantom reads**: A report queries all orders placed in the last hour, calculates a total, then runs the same query moments later within the same transaction. Another transaction inserted new orders in between, so the totals don't match. Phantom reads happen when a transaction re-executes a query and sees new rows that weren't there before.

Consider our e-commerce application during a flash sale with hundreds of concurrent customers. All three side effects can show up at once. The isolation level you choose determines which ones your application tolerates and how much blocking it accepts in return.

Notice that each of these problems involves a transaction that performs multiple operations: read a row, do some work, then read again or make a decision. A single-statement transaction usually completes so quickly that these conflicts rarely surface. Isolation levels matter most when your transactions span multiple statements, which is common in business logic that reads data, applies rules, and then writes results.

Here's a typical pattern where isolation levels come into play. Imagine two customers both trying to buy the last unit of the same product:

```sql
-- Transaction A (Customer 1)          -- Transaction B (Customer 2)
BEGIN TRANSACTION;
                                        BEGIN TRANSACTION;
SELECT @Stock = StockCount
  FROM Products
  WHERE ProductID = 42;
-- @Stock = 1, proceed with order
                                        SELECT @Stock = StockCount
                                          FROM Products
                                          WHERE ProductID = 42;
                                        -- @Stock = 1, proceed with order

UPDATE Products
  SET StockCount = StockCount - 1
  WHERE ProductID = 42;
INSERT INTO Orders (ProductID, Quantity)
  VALUES (42, 1);
COMMIT TRANSACTION;
                                        UPDATE Products
                                          SET StockCount = StockCount - 1
                                          WHERE ProductID = 42;
                                        INSERT INTO Orders (ProductID, Quantity)
                                          VALUES (42, 1);
                                        COMMIT TRANSACTION;
-- StockCount is now -1. Two orders placed for one item.
```

Both transactions read a stock count of 1 and both decided to proceed. The isolation level determines whether Transaction B sees the original value or waits for Transaction A to finish first. If the isolation level allows dirty reads, Transaction B reads the uncommitted value of 1 and proceeds, which leads to overselling. If the isolation level is more restrictive, Transaction B waits until Transaction A commits. If Transaction A commits successfully, Transaction B sees the updated stock count of 0 and can prevent the second order from going through. If Transaction A rolls back for some reason, Transaction B sees the original value of 1 and can still proceed without ever reading uncommitted data.

SQL Server and Azure SQL Database support six isolation levels. The first four use **pessimistic concurrency** (locking). The last two use **optimistic concurrency** (row versioning).

### Lock-based isolation levels

With lock-based isolation, the database engine uses shared and exclusive locks to keep transactions from interfering with each other. The more restrictive the level, the longer those locks are held. Fewer side effects get through, but more transactions end up waiting.

**READ UNCOMMITTED** is the fastest and the riskiest isolation level. It skips shared locks on reads entirely, so there's no read-write blocking. But that also means a transaction can read another transaction's uncommitted changes. If that other transaction rolls back, your application just acted on data that never existed. This level makes sense only when approximate results are acceptable, like a dashboard showing rough order counts.

**READ COMMITTED** is the default isolation level in SQL Server and strikes a basic balance. Each read acquires a shared lock, grabs the data, and releases the lock right away. Releasing the lock quickly is enough to prevent dirty reads. However, nothing stops another transaction from changing the row between your two reads, so nonrepeatable reads and phantom reads can still happen.

**REPEATABLE READ** goes a step further than READ COMMITTED. It holds shared locks on every row you read until your transaction completes. Now those rows can't change while the transaction is active, which prevents both dirty reads and nonrepeatable reads. But other transactions can still insert new rows that match your query filter, so phantom reads remain a possibility.

**SERIALIZABLE** takes care of everything previous levels do and more. It takes range locks that cover not just the rows you read but also the gaps between key values, blocking inserts into those ranges. Dirty reads, nonrepeatable reads, and phantom reads are all prevented. The cost is real, though: range locks cause significantly more blocking and increase the chance of deadlocks. Reserve this level for scenarios like financial reconciliation or inventory reservation where phantom reads would cause calculation errors.

### Row-versioning isolation levels

What if readers didn't have to wait for writers at all? That question is what row-versioning isolation addresses. Instead of blocking behind locks, the database engine keeps previous versions of rows in a **version store**. When a transaction needs to read data that another transaction is modifying, it reads from the version store instead of waiting. In Azure SQL Database, accelerated database recovery (ADR) is always enabled, so the version store resides in the database itself using the persistent version store (PVS).

**Read Committed Snapshot Isolation** changes the behavior of READ COMMITTED at the database level. With Read Committed Snapshot Isolation (RCSI) enabled, each read operation sees a snapshot of the data as it existed at the start of that *statement*. Writers still take locks on the rows they modify, but readers never block behind them. The important detail: RCSI is enabled by default in Azure SQL Database, so you get this behavior out of the box without any code changes.

**SNAPSHOT isolation** takes this solution a step further. Instead of a per-statement snapshot, each read sees the data as it existed at the start of the entire *transaction*. If your application needs to run multiple queries within a single transaction and get consistent results across all of them, SNAPSHOT isolation provides that guarantee. To use it, you must enable `ALLOW_SNAPSHOT_ISOLATION` on the database and set the isolation level explicitly in the session. One thing to watch for: if two transactions try to modify the same row, SNAPSHOT isolation raises an update conflict rather than letting one silently overwrite the other.

The following table summarizes the behavior of each isolation level:

| Isolation level | Dirty reads | Nonrepeatable reads | Phantom reads | Blocking between readers and writers |
|---|---|---|---|---|
| READ UNCOMMITTED | Yes | Yes | Yes | No |
| READ COMMITTED | No | Yes | Yes | Yes |
| REPEATABLE READ | No | No | Yes | Yes |
| SERIALIZABLE | No | No | No | Yes (range locks) |
| READ COMMITTED SNAPSHOT | No | Yes | Yes | No |
| SNAPSHOT | No | No | No | No (update conflicts possible) |

## Reduce blocking with optimized locking

RCSI eliminates read-write blocking. But what about write-write blocking? Traditional locking holds row and page locks for every modified row until the transaction commits. Under heavy write concurrency, those held locks add up fast.

Azure SQL Database addresses this issue with **optimized locking**, which is always enabled and works alongside RCSI. It uses two mechanisms:

- **Transaction ID (TID) locking**: Instead of holding individual key or row locks for every modified row, the engine takes a single exclusive lock on the transaction ID (TID). Other transactions that need to access the same row acquire a shared lock on the TID and wait for the modifying transaction to complete. The result is far fewer locks held in memory, which also makes lock escalation much less likely.
- **Lock after qualification**: Before a row is modified, the engine reads the latest committed version without acquiring a lock and checks whether the row matches the query predicate. Only rows that actually qualify get locked, and that exclusive lock is released as soon as the row update is complete, not at the end of the transaction. Lock after qualification (LAQ) requires RCSI to be enabled.

The practical effect is significant. Page and row locks for modifications are released as soon as each row is updated rather than held until the transaction commits. Concurrent writes that touch different rows rarely block each other, even under peak load.

## Choose the right isolation level

With six isolation levels available, how do you decide? Start with the defaults. For most Azure SQL Database workloads, the combination of RCSI and optimized locking already provides the best balance of consistency and performance. Readers don't block writers. Writers don't block readers. Lock memory stays low. You don't need to change anything.

Step up to SNAPSHOT isolation when your application runs multiple queries within a single transaction and needs consistent results across all of them. Think of a financial report that queries account balances and then totals them: you need both queries to see the same point-in-time data.

Reserve SERIALIZABLE for scenarios where phantom reads would cause real business errors, like double-booking inventory or miscalculating a reconciliation. Accept that throughput drops and deadlocks become more likely.

> [!IMPORTANT]
> Regardless of which level you choose, keep transactions as short as possible. Long-running transactions hold locks for extended periods, increase blocking, and consume version store space. A transaction that stays open while waiting for user input or an external API call can bring concurrency to a halt.

## Key takeaways

Transaction isolation levels control the trade-off between data consistency and concurrency. Higher isolation prevents more side effects but increases blocking. Azure SQL Database enables RCSI by default, which eliminates read-write blocking by using row versioning instead of shared locks. Optimized locking further reduces blocking by releasing row and page locks as soon as each row is updated. For most workloads, the default combination of RCSI and optimized locking provides the best balance. Reserve SERIALIZABLE for scenarios where phantom reads would cause business logic errors.
