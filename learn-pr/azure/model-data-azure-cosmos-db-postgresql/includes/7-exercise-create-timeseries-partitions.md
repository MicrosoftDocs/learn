Woodgrove Bank only shows six months of transactions within their contactless payment app. After six months, those transactions are deleted for the context of this application. By using time-partitioning, it's easy to identify which data needs to show and which data needs pruned when it's no longer needed.

The Woodgrove Bank app's users also have shown that they query data within a couple weeks. With this revelation, it makes sense to partition the data in intervals of seven days.

In this exercise, you'll create the partitions for the `payment_events` table. These partitions will break up the data as seen in the diagram below.

:::image type="content" source="../media/shards-partitions-illustrated.svg" alt-text="Diagram of the cluster with the coordinator node and two worker nodes. The worker nodes have shards of the payment_events table, distributed on the user_id column. The payment_events table has been partitioned by the created_at field. One worker node has data for user 1894, and the other worker node shows data for user 2000. Both nodes have their data broken down into seven-day partitions.":::

## Create the partitions for the time series in the events table

Let's look at the statement used for the `payment_events` table:

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

The `PARTITION BY` clause indicates how the data should be partitioned, but it doesn't create the partitions.

1. To create the partitions for seven-day intervals over six months with a past month for later, run the following query:

    ```sql
    SELECT create_time_partitions(
        table_name := 'payment_events',
        partition_interval := '7 days',
        start_from := now() - interval '1 month',
        end_at := now() + interval '6 months'
    );
    ```

1. To confirm that the partitions have been created, run the following command:

    ```sql
    \d+ payment_events
    ```

    The output will look like this:

    ```output
                                                    Partitioned table "public.payment_events"
        Column     |            Type             | Collation | Nullable | Default | Storage  | Compression | Stats target | Description 
    ---------------+-----------------------------+-----------+----------+---------+----------+-------------+--------------+-------------
    event_id      | bigint                      |           |          |         | plain    |             |              | 
    user_id       | bigint                      |           |          |         | plain    |             |              | 
    event_type_id | bigint                      |           |          |         | plain    |             |              | 
    merchant_id   | bigint                      |           |          |         | plain    |             |              | 
    event_details | jsonb                       |           |          |         | extended |             |              | 
    created_at    | timestamp without time zone |           |          |         | plain    |             |              | 
    Partition key: RANGE (created_at)
    Foreign-key constraints:
        "payment_events_event_type_id_fkey" FOREIGN KEY (event_type_id) REFERENCES event_types(event_type_id)
        "payment_events_merchant_id_fkey" FOREIGN KEY (merchant_id) REFERENCES payment_merchants(merchant_id)
    Partitions: payment_events_p2022w32 FOR VALUES FROM ('2022-08-08 00:00:00') TO ('2022-08-15 00:00:00'),
                payment_events_p2022w33 FOR VALUES FROM ('2022-08-15 00:00:00') TO ('2022-08-22 00:00:00'),
                payment_events_p2022w34 FOR VALUES FROM ('2022-08-22 00:00:00') TO ('2022-08-29 00:00:00'),
                payment_events_p2022w35 FOR VALUES FROM ('2022-08-29 00:00:00') TO ('2022-09-05 00:00:00'),
                ...
    ```

    There are two things to note:
    * There's a partition key called out just above the foreign keys.
    * The partitions under the foreign keys should show the partition names and date ranges.

## Drop partitions

When data is no longer needed, you can use `drop_old_time_partitions()` to remove unnecessary data. For this example, you'll see how `drop_old_time_partitions()` works by deleting the partitions older than now.

1. To remove the data no longer needed from one month ago, run the following command:

    ```sql
    CALL drop_old_time_partitions('payment_events',now());
    ```

    The command outputs which partitions are dropped. Here's an example of the output:

    ```output
    NOTICE:  dropping payment_events_p2022w32 with start time 2022-08-08 00:00:00 and end time 2022-08-15 00:00:00
    NOTICE:  dropping payment_events_p2022w33 with start time 2022-08-15 00:00:00 and end time 2022-08-22 00:00:00
    NOTICE:  dropping payment_events_p2022w34 with start time 2022-08-22 00:00:00 and end time 2022-08-29 00:00:00
    NOTICE:  dropping payment_events_p2022w35 with start time 2022-08-29 00:00:00 and end time 2022-09-05 00:00:00
    NOTICE:  dropping payment_events_p2022w36 with start time 2022-09-05 00:00:00 and end time 2022-09-12 00:00:00
    ```

1. To confirm that the partitions have been dropped, run the following command:

    ```sql
    \d+ payment_events
    ```

    The partition for the past month shouldn't appear in the list of partitions.

While you can run `create_time_partitions()` and `drop_old_time_partitions()` manually, you can use an extension called `pg_cron` to schedule this maintenance. Learn more from [scaling time series data and scheduling partition maintenance](https://docs.citusdata.com/en/stable/use_cases/timeseries.html#scaling-timeseries-data-on-citus).
