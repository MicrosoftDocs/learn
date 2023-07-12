You can use the open-source [Citus extension](https://github.com/citusdata/citus) for PostgreSQL to provide the distributed functionality in Azure Cosmos DB for PostgreSQL. It uses the standard PostgreSQL SQL constructs, so most queries are supported, even when they combine data across the network from multiple database nodes. This support includes transactional semantics across nodes. Currently, all SQL is supported except:

- Correlated subqueries
- Recursive CTEs
- Table sample
- SELECT … FOR UPDATE
- Grouping sets

Additionally, queries that access a single node in the cluster have 100% SQL support. For example, querying Woodgrove Bank's `payment_events` table to retrieve all transactions where `user_id` = 87 accesses data in a single shard residing on a single node. You can use the `EXPLAIN` statement to view the query plan:

```sql
EXPLAIN SELECT * FROM payment_events WHERE user_id = 87;
```

The output shows a task count of 1 against `shardid` 102235, the shard on which the data for `user_id` 87 resides.

```output
Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=0 width=0)
   Task Count: 1
   Tasks Shown: All
   ->  Task
         Node: host=private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com port=5432 dbname=citus
         ->  Index Scan using payment_events_pkey_102235 on payment_events_102235 payment_events  (cost=0.28..65.23 rows=2 width=126)
               Index Cond: (user_id = 87)
```

These queries are common, for instance, in multi-tenant applications where different nodes store different tenants. However, it's crucial to remember that even with extensive SQL coverage, data modeling can significantly influence query performance.

## Constraint limitations in distributed tables

Using Azure Cosmos DB for PostgreSQL allows you to continue to enjoy the safety of a relational database, including database constraints. However, there's a limitation. Because of the nature of distributed systems, you can't cross-reference uniqueness constraints or referential integrity between worker nodes.

For example, Woodgrove Bank would like to add a `UNIQUE` constraint between events and merchants for each transaction. If you attempt to make the combination of the `event_id` and `merchant_id` fields a key on the `payment_events` table, you'll receive an error.

```sql
-- Will not work
ALTER TABLE payment_events ADD CONSTRAINT event_merchant UNIQUE (event_id, merchant_id);
```

```output
ERROR:  cannot create constraint on "payment_events"
DETAIL:  Distributed relations cannot have UNIQUE, EXCLUDE, or PRIMARY KEY constraints that do not include the partition column (with an equality operator if EXCLUDE).
```

Recall, the `payment_events` table is distributed on the `user_id` column. In a distributed table, the best you can do is make the column's unique modulo the distribution column:

```sql
ALTER TABLE payment_events ADD CONSTRAINT event_merchant UNIQUE (user_id, event_id, merchant_id);
```

The above constraint merely makes `merchant_id` unique per user and event.
