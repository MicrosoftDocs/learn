Because Azure Cosmos DB for PostgreSQL provides distributed functionality by extending PostgreSQL, it's compatible with PostgreSQL constructs. Users can use most of the tools and features in the rich and extensible PostgreSQL ecosystem for distributed tables. However, some SQL features aren't supported for queries that combine information from multiple nodes, and while there are some suggested workarounds, most of these queries are considered *anti-patterns*. Anti-patterns are queries that might return the requested data but have unintended consequences, such as poor performance, unnecessary data movement, and other unwanted behaviors. You should consider whether a distributed database is appropriate for your situation if you find yourself attempting numerous workarounds or needing to write queries following anti-patterns. You can reevaluate your distribution column selection on each of your tables.

## Joins without specifying a distribution column

### Using CTEs to join tables on non-distribution columns

When a SQL query is unsupported, one way to work around it is using common table expressions (CTEs), which use what is referred to as pull-push execution.

Suppose the `payment_merchants` table was still a distributed table. Running the following query to join it with the `payment_events` table would fail:

```sql
SELECT name, event_id
FROM payment_events AS e
LEFT JOIN payment_merchants m ON e.merchant_id = m.merchant_id;
```

The query results in an error:

```output
ERROR: complex joins are only supported when all distributed tables are co-located and joined on their distribution columns
```

To complete the query, you can use a CTE to work around the join limitations:

```sql
WITH merchants AS (SELECT * FROM payment_merchants)
SELECT name, event_id FROM payment_events LEFT JOIN merchants USING (merchant_id);
```

The CTE allows you to successfully execute the join between non-colocated tables, but at what cost? Running an `EXPLAIN` on the query reveals the cost of executing a query like this sample.

```sql
EXPLAIN
    WITH merchants AS (SELECT * FROM payment_merchants)
    SELECT name, event_id FROM payment_events LEFT JOIN merchants USING (merchant_id);
```

```output
Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=100000 width=40)
   ->  Distributed Subplan 15_1
         ->  Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=100000 width=72)
               Task Count: 32
               Tasks Shown: One of 32
               ->  Task
                     Node: host=private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com port=5432 dbname=citus
                     ->  Seq Scan on payment_merchants_102491 payment_merchants  (cost=0.00..34.39 rows=1539 width=72)
   Task Count: 32
   Tasks Shown: One of 32
   ->  Task
         Node: host=private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com port=5432 dbname=citus
         ->  Merge Right Join  (cost=470.48..522.83 rows=4482 width=40)
               Merge Cond: (intermediate_result.merchant_id = payment_events.merchant_id)
               ->  Sort  (cost=59.83..62.33 rows=1000 width=40)
                     Sort Key: intermediate_result.merchant_id
                     ->  Function Scan on read_intermediate_result intermediate_result  (cost=0.00..10.00 rows=1000 width=40)
               ->  Sort  (cost=410.65..421.86 rows=4482 width=16)
                     Sort Key: payment_events.merchant_id
                     ->  Seq Scan on payment_events_102232 payment_events  (cost=0.00..138.82 rows=4482 width=16)
```

The first part of the output reveals that it was necessary to create a distributed subplan. This subplan means the coordinator has to push the query within the CTE down to workers for execution and pull the results back. The coordinator will send the intermediate results from the CTE down to workers to be used in the join query run on each worker. While this technique does work, it's considered a distributed query anti-pattern because of the data shuffling required between nodes to complete the query.

Thus, it’s best to either add the most specific filters and limits to the inner query as possible or aggregate the table. That reduces the network overhead that such a query can cause. For more information about this optimization, see [Subquery/CTE Network Overhead](https://docs.citusdata.com/en/stable/performance/performance_tuning.html#subquery-perf) in the Citus documentation.

## Using temp tables

There are still a few queries that are [unsupported](https://docs.citusdata.com/en/stable/faq/faq.html#unsupported) even with the use of push-pull execution via subqueries. One of them is using [grouping sets](https://www.postgresql.org/docs/current/queries-table-expressions.html#QUERIES-GROUPING-SETS) on a distributed table.

In the payment application, you created a table called `payment_events`, distributed by the `user_id` column. The example below queries it to find the earliest events for a preselected set of users, grouped by combinations of event type and merchant ID. A convenient way to construct this type of query is with grouping sets. However, as mentioned, this feature isn't yet supported in distributed queries:

```sql
-- This will not work

SELECT user_id, merchant_id, event_type,
    GROUPING(merchant_id, event_type),
    MIN(created_at)
FROM payment_events
GROUP BY user_id, ROLLUP(merchant_id, event_type);
```

```output
ERROR:  could not run distributed query with GROUPING
HINT:  Consider using an equality filter on the distributed table's partition column.
```

There's a trick, though. You can pull the relevant information to the coordinator as a temporary table and execute the query against a local table.

```sql
CREATE TEMP TABLE results AS (
    SELECT user_id, merchant_id, event_type, created_at
    FROM payment_events
);

SELECT user_id, merchant_id, event_type,
    GROUPING(merchant_id, event_type),
    MIN(created_at)
FROM results
GROUP BY user_id, ROLLUP(merchant_id, event_type);
```

Creating a temporary table on the coordinator is a last resort. It's limited by the node's disk size and CPU.
