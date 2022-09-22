Woodgrove Bank only shows 6 months of transactions within their contactless payment app. After 6 months, those transactions are deleted for the context of this application. By using time-partitioning, it is easy to identify which data needs to show as well as which data needs pruned when it is no longer needed.

Users of the Woodgrove Bank app also have shown that they query data within a couple weeks. With this revelation, it makes sense to partition the data in intervals of 7 days.

In this exercise, you will create the partitions for the `payment_events` table. This will break up the data as seen in the diagram below.

![Diagram of the cluster with the coordinator node and two worker nodes. The worker nodes have shards of the payment_events table, distributed on the user_id column. The payment_events table has been partitioned by the created_at field. One worker node has data for user 1894, and the other worker node shows data for user 2000. Both nodes have their data broken down into 7-day partitions.](../media/shards-partitions-illustrated.png)

## Create the partitions for the timeseries in the events table

This was the create statement used for the `payment_events` table:

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

The `PARTITION BY` clause indicates how the data should be partitioned, but it does not create the partitions.

1. To create the partitions for 7-day intervals over 6 months with a past month for later, run the following query:

    ```sql
    SELECT create_time_partitions(
        table_name := 'payment_events',
        partition_interval := '7 days',
        start_from := now() - interval '1 month',
        end_at := now() + interval '6 months'
    );
    ```

2. To confirm that the partitions have been created, run the following command:

    ```sql
    \d+ payment_events
    ```

    The output will look like this:

    ```bash
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
    * There is a partition key called out just above the foreign keys.
    * The partitions under the foreign keys should show the partition names and date ranges.

## Drop partitions

When data is no longer needed, `drop_old_time_partitions()` can be used to remove unnecessary data. For this example, you will see how `drop_old_time_partitions()` can work by deleting the partitions older than now.

1. To remove the data no longer needed from 1 month ago, run the following command:

    ```sql
    CALL drop_old_time_partitions('payment_events',now());
    ```

    The command outputs which partitions are dropped. The output is similar to this:

    ```bash
    NOTICE:  dropping payment_events_p2022w32 with start time 2022-08-08 00:00:00 and end time 2022-08-15 00:00:00
    NOTICE:  dropping payment_events_p2022w33 with start time 2022-08-15 00:00:00 and end time 2022-08-22 00:00:00
    NOTICE:  dropping payment_events_p2022w34 with start time 2022-08-22 00:00:00 and end time 2022-08-29 00:00:00
    NOTICE:  dropping payment_events_p2022w35 with start time 2022-08-29 00:00:00 and end time 2022-09-05 00:00:00
    NOTICE:  dropping payment_events_p2022w36 with start time 2022-09-05 00:00:00 and end time 2022-09-12 00:00:00
    ```


2. To confirm that the partitions have been dropped, run the following command:

    ```sql
    \d+ payment_events
    ```

    The partition for the past month should not appear in the list of partitions.

While `create_time_partitions()` and `drop_old_time_partitions()` can be run manually, an extension called `pg_cron` can be used to schedule this maintenance. Learn more from [scaling timeseries data and scheduling partition maintenance](https://docs.citusdata.com/en/stable/use_cases/timeseries.html#scaling-timeseries-data-on-citus).
