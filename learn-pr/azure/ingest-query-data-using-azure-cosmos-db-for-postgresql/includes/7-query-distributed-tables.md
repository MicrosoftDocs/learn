Woodgrove Bank has asked you to optimize the performance of the contactless-payment application's user analytics workloads and queries. Applying the information you learned in Unit 6, you're ready to examine how to execute queries against distributed data.

You typically issue queries using standard PostgreSQL `SELECT` queries against the coordinator node in Azure Cosmos DB for PostgreSQL. It handles parallelizing `SELECT` queries involving complex selections, groupings, orderings, and JOINs to optimize and speed up query performance.

## Query distributed tables

At a high level, the coordinator partitions each `SELECT` query into smaller query fragments, assigns query fragments to workers, oversees their execution, merges their results, and returns the final result to the user. Most of the time, knowing how or where data is stored in a cluster isn't necessary. The database uses a distributed query executor to automatically split up regular SQL queries and run them in parallel on worker nodes close to the data.

For simple queries, such as `SELECT COUNT(*) FROM payment_users;`, the coordinator automatically runs the count on all shards in parallel and combines the results.

## Execute aggregate functions

For the more complex aggregations and queries associated with Woodgrove Bank's analytical workloads, Azure Cosmos DB for PostgreSQL supports and parallelizes most aggregate functions supported by PostgreSQL, including custom user-defined aggregates.

:::image type="complex" source="../media/distributed-query.gif" alt-text="Animation of the flow of a query arriving from an application is displayed.":::
    Animation of the flow of a query arriving from an application is displayed. In the animation, the query being processed by the coordinator node using metadata tables. Then, the query fragments are sent to the work nodes for execution. The results of query execution on the worker nodes are passed back to the coordinator, aggregated, and returned to the application.
:::image-end:::

Aggregates execute using one of three methods, in this order of preference:

1. When the aggregate is grouped by a table's distribution column, the coordinator can push down the execution of the entire query to each worker. All aggregates are supported in this situation and execute in parallel on the worker nodes. For example, you can count the number of events, by type, per user in the contactless-payments app by using the following query:

    ```sql
    SELECT user_id, event_type, count(*) FROM payment_events GROUP By user_id, event_type;
    ```

    This query runs quickly because the coordinator can push query execution down to each worker node. Push-down execution is possible because the `GROUP BY` clause contains the table's distribution column. Running the same query using the `EXPLAIN VERBOSE` statement allows you to see the query execution plan and how it's distributed across worker nodes to parallelize query execution.

1. When the aggregate isn't grouped by a table's distribution column, the coordinator can still optimize on a case-by-case basis. Internal rules for specific aggregates like `sum()`, `avg()`, and `count(distinct)` allow queries to be rewritten for partial aggregation on workers. For instance, to calculate an average, the coordinator obtains a sum and a count from each worker, and then the coordinator node computes the final average.

    ```sql
    SELECT merchant_id, event_type, COUNT(*) FROM payment_events GROUP BY merchant_id, event_type;
    ```

    This query results in a partial aggregation occurring on workers, which is slightly less performant than the previous method. The `EXPLAIN VERBOSE` statement provides the details of the `HashAggregate` performed to retrieve each worker's count. The coordinator then computes the final count.

1. For all other aggregation functions, the coordinator pulls all rows from the workers and performs the aggregation itself. If the previous two methods don't cover the aggregate, the coordinator falls back on this approach. However, it's critical to note that this method can cause network overhead and exhaust the coordinator's resources if the dataset to be aggregated is too large.

## Joins

Joins between any number of tables, irrespective of their size and distribution method, are supported. The query planner selects the optimal join method and order based on how tables are distributed. It evaluates several possible join orders and creates a join plan that requires the minimal amount of data to be transferred across the network.

Given the heavy analytical workloads Woodgrove Bank performs against their database, you'll need to support and perform joins across multiple tables. When the database is built out, Woodgrove will have more than just the users, events, and merchants tables, some of which can be colocated and some of which can't.

### Colocated joins

When two tables are colocated, they can be joined efficiently on their common distribution columns. A colocated join is the most efficient way to join two large distributed tables.

The coordinator uses its metadata tables to determine which shards of the colocated tables might match with shards of the other table. This process allows the coordinator to prune away shard pairs that can't produce matching join keys. Joins between the remaining shard pairs are executed in parallel on the worker nodes, and the results are returned to the coordinator.

> [!NOTE]
> Be sure that the tables are distributed into the same number of shards and that the distribution columns of each table have exactly matching types. Attempting to join on columns of slightly different types such as `int` and `bigint` can cause problems.

For the contactless payment app, you colocated the `payment_events` and `payment_users` data by using the same distribution column, `user_id`. Performing a join between these two tables on the `user_id` column allows the coordinator to use the metadata tables to efficiently determine the rows with matching keys and parallelize query execution across worker nodes.

```sql
SELECT u.user_id, login, event_type, merchant_id, event_details FROM payment_events e INNER JOIN payment_users u ON e.user_id = u.user_id LIMIT 5;
```

### Repartition joins

Sometimes, you may need to join two tables on columns other than the distribution column. For such cases, Azure Cosmos DB for PostgreSQL allows joining on non-distribution key columns by dynamically repartitioning the tables for the query. Repartition joins require cross-shard shuffling of data, so they're less efficient than colocated joins. It would be best if you tried to distribute your tables by common join keys whenever possible.

In such cases, the query optimizer determines the table(s) to be partitioned based on the distribution columns, join keys, and sizes. With repartitioned tables, only relevant shard pairs are joined with each other, drastically reducing the amount of data transferred across the network.

There are numerous queries Woodgrove Bank uses in their analytics workloads that will require repartition queries, so you need to configure the database to allow these types of queries. You can enable the execution of repartition queries by running the following command:

```sql
SET citus.enable_repartition_joins TO on;
```

Suppose repartition joins haven't been enabled in the database. Executing a join that requires repartitioning results in the error message: `ERROR: the query contains a join that requires repartitioning`.

Assume for a moment that you didn't convert Woodgrove Bank's `payment_merchants` table to a reference table, instead leaving it distributed on the `merchant_id` column. Joining the `payment_merchants` and `payment_events` tables would require a repartition join. After enabling repartition joins, you could perform the following join on a non-distribution column:

```sql
SELECT m.merchant_id, name, event_type, count(*) as event_count
FROM payment_events e
JOIN payment_merchants m ON e.merchant_id = m.merchant_id
WHERE event_type = 'SendFunds'
GROUP BY m.merchant_id, name, event_type
ORDER BY event_count DESC
LIMIT 5;
```

### Reference table joins

You can use [reference tables](/azure/postgresql/hyperscale/concepts-nodes#type-2-reference-tables) as "dimension" tables to join efficiently with large "fact" tables. Reference tables are replicated across all worker nodes, allowing a reference join to be decomposed into local joins on each worker and performed in parallel. A reference join is like a more flexible version of a colocated join because reference tables aren't distributed on any particular column and are free to join on any of their columns.

To populate a dashboard for Woodgrove Bank's contactless payment application, you've been asked to write a query to count the number of transactions by type for each merchant. This query requires joining the `payment_events` distributed table with the `payment_merchants` reference table on the `merchant_id` column.

```sql
SELECT m.merchant_id, name, event_type, count(*) as event_count
FROM payment_events e
JOIN payment_merchants m ON e.merchant_id = m.merchant_id
WHERE event_type = 'SendFunds'
GROUP BY m.merchant_id, name, event_type
ORDER BY event_count DESC
LIMIT 5;
```

Running the query with `EXPLAIN VERBOSE` shows how the coordinator can generate a plan that pushes query execution down to each of the 32 shards, where the reference table is joined locally on the worker nodes. In this case, changing the `payment_merchants` table to a reference table provides significant performance improvements over the same query executed against a non-colocated distributed table.

Reference tables can also join with [local tables](/azure/postgresql/hyperscale/concepts-nodes#type-3-local-tables) on the coordinator node.

## Modify data in distributed tables

Executing `UPDATE` and `DELETE` commands against distributed tables is accomplished using the standard PostgreSQL `UPDATE` and `DELETE` commands. They can be completed without specifying the distribution column in a `WHERE` clause, but will run more efficiently if it's included.

### Update rows in a distributed table

You use the standard PostgreSQL `UPDATE` command to update records stored in distributed tables. For example, Woodgrove Bank asked you to modify the `event_details` field for every record in the database to include the `user_id` value in the JSONB string.

```sql
UPDATE payment_events
SET event_details = jsonb_set(event_details, '{user_id}', CAST(user_id as text)::jsonb);
```

When the updates affect multiple shards, as in the preceding example, the default behavior is to use a one-phase commit protocol. This behavior means that each worker sends a "done" message to the coordinator and then waits for a commit or abort message from the coordinator. Once all workers have finished executing the query and sent a "done" message, the coordinator decides whether to commit or abort the transaction.

For greater safety, you can enable [two-phase commit](https://www.citusdata.com/blog/2017/11/22/how-citus-executes-distributed-transactions/) by setting the `citus.multi_shard_commit_protocol` value to `2pc`, as follows:

```sql
SET citus.multi_shard_commit_protocol = '2pc';
```

If the `UPDATE` affects only a single shard, it runs within a single worker node, and enabling 2PC is unnecessary. This scenario often occurs when updates or deletes filter by a table's distribution column, as in the following query:

```sql
UPDATE payment_events
SET event_details = jsonb_set(event_details, '{user_id}', CAST(user_id as text)::jsonb)
WHERE user_id = 796958;
```

### Delete records from a distributed table

Deleting rows from distributed tables also uses the standard PostgreSQL `DELETE` command. In the payments app, for example, Woodgrove occasionally needs to run an operation to delete duplicate transaction records caused by a user double-clicking the transaction submit button. They stated this task could be accomplished by deleting the most recent transaction record from the `payment_events` table, as follows:

```sql
DELETE FROM payment_events
WHERE user_id = 796958
AND created_at = (SELECT MAX(created_at) FROM payment_events WHERE user_id = 796958);
```

Like updates, delete operations will use a one-phase commit protocol by default.

### Maximizing Write Performance

You can consult the [Scaling Out Data Ingestion](https://docs.citusdata.com/en/stable/performance/performance_tuning.html#scaling-data-ingestion) section of the Citus documentation to learn more about how to maximize write performance.
