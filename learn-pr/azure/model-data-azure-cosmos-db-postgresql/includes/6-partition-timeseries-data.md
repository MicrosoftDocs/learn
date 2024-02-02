When dates and times are involved, you might need to keep or prune data for certain periods. You might also query data frequently over a predefined time interval. Time-partitioning can assist with these features. Once time-partitioning is configured and its maintenance is automated, there's nothing special needed for queries to account for these partitions. Woodgrove Bank can take advantage of time-partitioning for showing data within a period of time and archiving or removing no longer needed data.

## What is time-partitioning?

Time-partitioning is a feature of PostgreSQL, allowing a table to be split by time ranges into virtual, indexed tables known as _partitions_. When a table is created, the time partition is indicated by a `PARTITION BY RANGE` clause with the name of the column that serves as the partition key. The partitions need to be created in order for the system to use them. Individual partitions can also be dropped if the data is no longer needed. Time partitions can be managed using the `create_time_partitions()` and `drop_old_time_partitions()` functions.

For Woodgrove Bank, the `payment_events` table is partitioned by the `created_at` field. The following query creates the table:

 ```sql
CREATE TABLE payment_events
(
    event_id bigint,
    user_id bigint,
    event_type_id bigint REFERENCES event_types (event_type_id),
    merchant_id bigint REFERENCES payment_merchants (merchant_id),
    event_details jsonb,
    created_at timestamp
) PARTITION BY RANGE (created_at);
```

This query gets the `payment_events` table ready to be partitioned by the `created_at` column.

## Benefits of time-partitioning

There are a couple benefits to using time partitions.

* The queries will run only over the partitions that are needed rather than over the entire dataset.
* By breaking the data by time range, it's easier to archive or delete the stale data.

Woodgrove Bank only shows six months of transactions within their contactless payment app. After six months, those transactions are deleted for the context of this application. By using time-partitioning, it's easier to query only the data to show and identify which data to prune when it's no longer needed.

The Woodgrove Bank app users also have shown that they query data within a couple weeks. With this revelation, it makes sense to partition the data in intervals of seven days.

## Manage partition creation and expiration

While the partition key is specified by the `PARTITION BY RANGE` clause, this clause only indicates that partitions will be used. The partitions need to be created and dropped outside of the table creation process.

The `create_time_partitions()` function is used to create the time series partitions with the following parameters:

* `table_name`: Which table to partition
* `partition_interval`: an interval of time for the partition
* `start_from` (optional): When to start partitioning, defaults to `now()`
* `end_at`: When to stop partitioning

For Woodgrove Bank, once the `payment_events` table is created and has the `created_at` column flagged as its partition column, then run the following code to partition the data in seven-day increments:

```sql
SELECT create_time_partitions(
    table_name := 'payment_events',
    partition_interval := '7 days',
    end_at := now() + '6 months'
);
```

To expire the partitions, call `drop_old_time_partitions()` with two parameters: the table name and the expiration period. To expire Woodgrove Bank's application data older than six months, use the following code:

```sql
CALL drop_old_time_partitions('payment_events',now() - interval '6 months');
```

As partition creation and dropping old partitions happen only when called, you'll want to schedule this maintenance to run automatically. Learn more about [scaling time series data and scheduling partition maintenance](https://docs.citusdata.com/en/stable/use_cases/timeseries.html).

## Time partitions in a distributed environment

In Azure Cosmos DB for PostgreSQL, you can create partitions on local, reference, and distributed tables. You can create the partitions prior to distributing the table or after distributing the table. To reduce some of the noise from the output of the commands, it might make sense to partition a table after distributing the table.

Partitions are different from shards in that partitions are vertical slicing whereas shards are horizontal scaling. The partition details are managed at the worker-node level, whereas the coordinator node is responsible for the distribution and shard placement. The partition column doesn't need to match the distribution column.

Let's look at how these partitions are implemented in Woodgrove Bank's `payment_events` table.

:::image type="content" source="../media/shards-partitions-illustrated.svg" alt-text="Diagram of the cluster with the coordinator node and two worker nodes. The worker nodes have shards of the payment_events table, distributed on the user_id column. The payment_events table has been partitioned by the created_at field. One worker node has data for user 1894, and the other worker node shows data for user 2000. Both nodes have their data broken down into seven-day partitions.":::

This diagram shows how the `payment_events` table is horizontally scaled by the `user_id`. The transactions for a user are stored together on a single node. User 1894's payment events live on a worker. User 2000's payment events live on another worker. Other events for User 2000 will be stored on the same worker node where the existing events are stored.

This diagram also shows how the shards are partitioned by the `created_at` column. Notice that these partitions happen for each user's set of events.

For Woodgrove Bank, adding time partitions to `payment_events` will enable efficient date and time queries by only querying the data needed rather than entire dataset. These partitions will also help with data management, making it easier to maintain six months of data by adding partitions and removing old partitions as necessary.
