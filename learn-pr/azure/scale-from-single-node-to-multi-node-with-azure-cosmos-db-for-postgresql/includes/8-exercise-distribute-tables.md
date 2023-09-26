After you review the Wide World Importers nondistributed data and evaluate it for distribution, you can distribute the data.

## Review the plan

You create the following plan based on the data you reviewed:

1. Set up a simulation of the sensors to report their readings.
1. Get a baseline understanding of the query in a nondistributed environment through its query plan.
1. Start the benchmark to simulate data access.
1. Drop and update the primary key on the `events` table.
1. Make `device_types` a reference table.
1. Remove the foreign key relationship between `devices` and `events`.
1. Distribute `devices` on `device_id` by using `create_distributed_table_concurrently()`.
1. Distribute `events` on `device_id` by using `create_distributed_table_concurrently()`.
1. Re-create the foreign key relationship between `events` and `devices`.
1. Truncate the data from the coordinator.
1. Review the query performance in a distributed environment.

Now that the plan is laid out, you can execute the plan.

## Set up the simulation

The sensors report their readings every minute. You can use the pg_cron extension and a cron job to write sensor values every minute.

### Verify that the pg_cron extension is installed

In the following tasks, you use the pg_cron extension for PostgreSQL to run scheduled jobs in the database. You use the extension to simulate sensor updates. Before you install any new supported extensions in your database, view the complete list of installed extensions to avoid potential conflicts. Many popular PostgreSQL extensions are preinstalled on every Azure Cosmos DB for PostgreSQL cluster.

1. Connect to your Azure Cosmos DB for PostgreSQL cluster via psql in [Azure Cloud Shell](https://shell.azure.com).
1. View the list of preinstalled extensions in your Azure Cosmos DB for PostgreSQL database by running the following query:

    ```sql
    SELECT * FROM pg_extension;
    ```

    You can use this query to view the version and details that are associated with the installed extensions. Alternatively, you can run `\dx` at the command prompt, a shortcut command that provides a list of extensions that are installed in your database.

1. Inspect the output of the query. Look for a row in which the **extname** value is **pg_cron** to determine whether the extension is preinstalled.

    ```text
      oid  |      extname       | extowner | extnamespace | extrelocatable | extversion |         extconfig         | extcondition  
    -------+--------------------+----------+--------------+----------------+------------+---------------------------+---------------
     19371 | pg_cron            |       10 |         2200 | f              | 1.4-1      | {19374,19373,19393,19392} | {"","","",""}
    ```

    The query output reveals that pg_cron comes preinstalled, so there's nothing more you need to do to use this extension.

### Create and run a stored procedure to add sensor readings to the database

To correctly measure the impact that transitioning from a single-node cluster to a multi-node cluster has on Wide World Importers sensor database, you can use a stored procedure and a scheduled job to simulate the load of sensor reporting on the database as you go through this exercise.

1. You can use a stored procedure to create sensor readings for all the devices that are listed in the `devices` table. Because the goal is to run this stored procedure in under one minute, you generate four sets of sensor data within a minute, and then sleep for 10 seconds between runs. This query is a quick query, so you have data generated in seconds. Run the following SQL commands:

    ```sql
    CREATE OR REPLACE PROCEDURE generate_sensor_readings()    
    LANGUAGE plpgsql
    AS
    $$
    DECLARE
        max_id bigint;
        min_id int;
    BEGIN
        -- Generates readings for all devices   
        min_id := (SELECT MIN(device_id) FROM devices);
        max_id := (SELECT MAX(device_id) FROM devices);
        FOR j IN 1..4 LOOP
            FOR device_counter IN min_id..max_id LOOP
                CALL generate_reading(device_counter);
            END LOOP;
            PERFORM pg_sleep_for('10 seconds');
        END LOOP;
    END;
    $$;
    ```

1. Next, you need to execute the stored procedure occasionally to add sensor readings to the database. To simulate sensor traffic, schedule `generate_sensor_readings` to run every minute by using pg_cron. Run the following `cron.schedule` command to set up a job named `generate_readings` in the database.

    ```sql
    SELECT cron.schedule('generate_readings','* * * * *', 'CALL generate_sensor_readings();');
    ```

    This command returns the job ID. If you need to unschedule the job, you can run the `cron.unschedule()` function by using either of the following formats:

    ```sql
    SELECT cron.unschedule(JOB_ID);
    SELECT cron.unschedule(JOB_NAME);
    ```

If you want to monitor job runs, you can view job status and details by using the following query:

```sql
SELECT * FROM cron.job_run_details;
```

> [!NOTE]
> If you want to look at the five most recent job runs, run the following command: `SELECT * FROM cron.job_run_details ORDER BY start_time DESC LIMIT 5;`

## Get a baseline understanding of the query in a nondistributed configuration

Run the following command to understand how the query is run in a nondistributed configuration:

```sql
EXPLAIN SELECT device_id, COUNT((CASE WHEN (payload ->> 'humidity')::decimal < 60 THEN 1 ELSE NULL END)) AS LowHumidity,  
COUNT((CASE WHEN (payload ->> 'humidity')::decimal > 70 THEN 1 ELSE NULL END)) AS HighHumidity,
COUNT((CASE WHEN (payload ->> 'temperature')::decimal < 55 THEN 1 ELSE NULL END)) AS LowTemperature,
COUNT((CASE WHEN (payload ->> 'temperature')::decimal > 60 THEN 1 ELSE NULL END)) AS HighTemperature,
COUNT((CASE WHEN (payload ->> 'humidity')::decimal BETWEEN 60 AND 70 THEN 1 ELSE NULL END)) AS RegularHumidity,  
COUNT((CASE WHEN (payload ->> 'temperature')::decimal BETWEEN 55 AND 60 THEN 1 ELSE NULL END)) AS RegularTemperature
FROM events
GROUP BY device_id;
```

The query plan might look like this example:

```text
                             QUERY PLAN                             
--------------------------------------------------------------------
 HashAggregate  (cost=8258.54..8268.54 rows=1000 width=52)
   Group Key: device_id
   ->  Seq Scan on events  (cost=0.00..1628.05 rows=68005 width=66)
(3 rows)
```

For this example, there are 68,005 rows in the sequence scan. When aggregated, it's 1,000 rows, because 1,000 devices show outliers. Make note of this cost because you'll compare it later.

Keep this instance of Cloud Shell open. You'll run more SQL commands later in this unit. For the next section, you'll open a second instance of Azure Cloud Shell.

## Simulate data access during data distribution

Because part of the goal of this training module is to go from nondistributed data to distributed data with minimal interruption, you run a benchmark that runs in the background to simulate users accessing the data while you're distributing the data. The 20 minutes that you allocated for this benchmark job should be enough time to show how your data can be accessed while you're distributing it.

This exercise shows simulated data usage for the scenario of changing from a nondistributed database to a distributed database. The scenario includes the following processes:

- The pg_cron job writes data.
- The pgbench job reads data.
- You distribute data from psql.

Because you're using pgbench to simulate database read access, run the following command to set a benchmark of 20 minutes, to report progress every minute, and to then continue reading:

```bash
pgbench $PGURL -c 64 -j 64 -T 1200 -n -P 60 -f outliers.sql
```

After this benchmark is started, return to the Cloud Shell window that's running psql.

## Update the primary key on events to include the distribution column

Because the `events` table has a relationship with the `devices` table and is frequently queried for a device's readings, it makes sense to distribute the events on the `device_id`. Azure Cosmos DB for PostgreSQL can't enforce unique constraints on distributed tables unless the constraints include the distribution column. Before you can distribute the table, you have to add `device_id` as part of the primary key. The path to minimize disruption involves these tasks:

1. Concurrently create a new index that includes the current primary key and the distribution column.
1. Create a transaction to drop the primary key constraint and add the new primary key.

Here's how to accomplish these tasks:

1. To create a new index while data is being used, use `CREATE INDEX CONCURRENTLY`. By creating the index concurrently, normal operations can continue while the index is built. To create a new index on the `events` table that includes the current primary key (`event_id`) and the distribution column, run the following query:

    ```sql
    CREATE UNIQUE INDEX CONCURRENTLY events_devices_idx ON events (event_id,device_id);
    ```

1. Transactionally, drop the existing primary key and create a new primary key:

    ```sql
    BEGIN;

    -- Swap out the primary key for the index
    ALTER TABLE events
        DROP CONSTRAINT events_pkey CASCADE,
        ADD CONSTRAINT events_pk PRIMARY KEY USING INDEX events_devices_idx;   

    -- Create any foreign keys impacted by the CASCADE.
    -- For this example, we don't have any.

    COMMIT;
    ```

    The output for this command should look similar to this example:

    ```text
    BEGIN
    ALTER TABLE
    NOTICE:  ALTER TABLE / ADD CONSTRAINT USING INDEX will rename index "events_devices_idx" to "events_pk"
    ALTER TABLE
    COMMIT
    ```

    > [!NOTE]
    > If you're typing these commands and see the error message 'DETAIL: Cannot create a primary key or unique constraint using such an index.', you might have left the `UNIQUE` out of the concurrent index creation. If you find yourself in this situation, you can get out of that by running `DROP INDEX CONCURRENTLY events_devices_idx`, and then start again at step 1 for this section.

Confirm that the new primary key is set by running the following command:

```sql
\d events
```

The output looks like this example:

```text
                                           Table "public.events"
   Column   |            Type             | Collation | Nullable |                 Default                  
------------+-----------------------------+-----------+----------+------------------------------------------
 event_id   | bigint                      |           | not null | nextval('events_event_id_seq'::regclass)
 device_id  | integer                     |           | not null | 
 payload    | jsonb                       |           |          | 
 created_at | timestamp without time zone |           |          | 
Indexes:
    "events_pk" PRIMARY KEY, btree (event_id, device_id)
    "events_payload_idx" gin (payload)
Foreign-key constraints:
    "events_device_id_fkey" FOREIGN KEY (device_id) REFERENCES devices(device_id)
```

The primary key under **Indexes** shows **event_id** and **device_id**. Make note of the foreign key name because you use it in the next section.

## Create a reference table

After the baseline query metrics and query plan are gathered, you can distribute the data. First, promote `devices_types` to a reference table by using the following query:

```sql
SELECT create_reference_table('device_types');
```

You see output similar to this example:

```text
NOTICE:  Copying data from local table...
NOTICE:  copying the data has completed
DETAIL:  The local data in the table is no longer visible, but is still on disk.
HINT:  To remove the local data, run: SELECT truncate_local_data_after_distributing_table($$public.device_types$$)
NOTICE:  local tables that are added to metadata automatically by citus, but not chained with reference tables via foreign keys might be automatically converted back to postgres tables
HINT:  Executing citus_add_local_table_to_metadata($$public.devices$$) prevents this for the given relation, and all of the connected relations
NOTICE:  local tables that are added to metadata automatically by citus, but not chained with reference tables via foreign keys might be automatically converted back to postgres tables
HINT:  Executing citus_add_local_table_to_metadata($$public.devices$$) prevents this for the given relation, and all of the connected relations
NOTICE:  local tables that are added to metadata automatically by citus, but not chained with reference tables via foreign keys might be automatically converted back to postgres tables
HINT:  Executing citus_add_local_table_to_metadata($$public.events$$) prevents this for the given relation, and all of the connected relations
```

It might look like the messages are repeated. Citus does automatically add local tables to the metadata, and it can convert them back to PostgreSQL tables. There's a hint to execute `citus_add_local_table_to_metadata()` for `devices` and `events` because they're local tables that have relationships. There are a couple of things to note in those messages:

- After a copy is successfully distributed, you truncate the local copy of data at the end.
- If you were keeping a table as a local table, you'd need to run `citus_add_local_table_to_metadata()`.

You aren't going to add the tables as local tables in the metadata because these tables won't remain local tables. These other tables are distributed.

You can confirm the distribution status by using the following query:

```sql
SELECT * FROM citus_tables;
```

The output looks something like this example:

```text
  table_name  | citus_table_type | distribution_column | colocation_id | table_size | shard_count | table_owner | access_method 
--------------+------------------+---------------------+---------------+------------+-------------+-------------+---------------
 devices      | local            | <none>              |             0 | 128 kB     |           1 | citus       | heap
 device_types | reference        | <none>              |             1 | 96 kB      |           1 | citus       | heap
 events       | local            | <none>              |             0 | 19 MB      |           1 | citus       | heap
(3 rows)
```

## Remove the foreign key relationships before distribution

You need to remove the foreign key relationship between `devices` and `events` before you distribute them. Be aware that when the foreign key is removed, there's no protection in the database against an application adding or deleting records that violate referential integrity. You'll reestablish the foreign key relationship after the tables are distributed.

To remove the foreign key, use `DROP CONSTRAINT` in an `ALTER` statement. Because the foreign key constraint in the example is named `events_device_id_fkey`, use this SQL statement to remove it:

```sql
ALTER TABLE events DROP CONSTRAINT events_device_id_fkey;
```

You might see the following notice as a response:

```text
NOTICE:  removing table public.events from metadata as it is not connected to any reference tables via foreign keys
```

> [!NOTE]
> If you run into an error when you drop the constraint, try running the query again.

If you run the query to check `citus_tables`, you notice that the `events` table is missing from the list. This fact isn't concerning because events will be distributed and they'll be in the metadata again soon.

## Distribute the devices table concurrently

Because you have data that's already loaded, you need to be mindful of moving data that's in use. You use `create_distributed_table_concurrently()` to distribute `devices` on its `device_id` field by using the following command:

```sql
SELECT create_distributed_table_concurrently('devices','device_id');
```

To confirm that it's distributed, run the following query:

```sql
SELECT * FROM citus_tables;
```

The output looks like this example:

```text
  table_name  | citus_table_type | distribution_column | colocation_id | table_size | shard_count | table_owner | access_method 
--------------+------------------+---------------------+---------------+------------+-------------+-------------+---------------
 devices      | distributed      | device_id           |             3 | 1024 kB    |          32 | citus       | heap
 device_types | reference        | <none>              |             2 | 96 kB      |           1 | citus       | heap
```

Notice that the **citus_table_type** column shows that `devices` is distributed. It also has a **distribution_column** value and a shard count greater than 1.

## Distribute the events table concurrently

Because there's data in the `events` table, you want to move the data by using `create_distributed_table_concurrently()`.

Use `create_distributed_table_concurrently()` to distribute `events` on its `device_id` field by using the following command:

```sql
SELECT create_distributed_table_concurrently('events','device_id');
```

To confirm that it's distributed, run the following query:

```sql
SELECT * FROM citus_tables;
```

The output looks like this example:

```text
  table_name  | citus_table_type | distribution_column | colocation_id | table_size | shard_count | table_owner | access_method 
--------------+------------------+---------------------+---------------+------------+-------------+-------------+---------------
 devices      | distributed      | device_id           |             3 | 1024 kB    |          32 | citus       | heap
 device_types | reference        | <none>              |             2 | 96 kB      |           1 | citus       | heap
 events       | distributed      | device_id           |             3 | 19 MB    |          32 | citus       | heap
```

Notice that `devices` and `events` are colocated by having the same `colocation_id` value. The `events` data is distributed on `device_id` and colocated with the `devices` shard for that `device_id` value.

## Reestablish the foreign key between devices and events

Because `devices` and `events` are two distributed tables that are colocated, they can have a foreign key relationship enforced. Readd the foreign key relationship on `device_id` by using the following command:

```sql
ALTER TABLE events ADD CONSTRAINT FK_events_devices FOREIGN KEY (device_id) REFERENCES devices(device_id);
```

## Truncate data from the coordinator node

Now that the data is distributed, you can truncate the data from the coordinator node. Because you no longer need the local tables on that node, it's good practice to clean up the node. You can truncate the data by calling `truncate_local_data_after_distributing_table()`. Clean up the local tables by using the following commands:

```sql
SELECT truncate_local_data_after_distributing_table('public.device_types');
```

The output looks like this example:

```text
NOTICE:  truncate cascades to table "devices"
NOTICE:  truncate cascades to table "events"
 truncate_local_data_after_distributing_table 
----------------------------------------------
 
(1 row)
```

Truncates cascade to the **local** version of other distributed tables. Because the data has been distributed on the worker nodes, this `truncate_local_data_after_distributing_table()` command removes stale data on the local tables that was left behind in the distribution process.

## Confirm query performance

Now that the data has been distributed and the local data has been truncated, you can stop the benchmarks in the second Cloud Shell window. If they're still running, select **Ctrl+C** to stop pgbench. You can close this instance of Cloud Shell.

Switch to the Cloud Shell window that's running psql. You can examine the query plan to see whether distributing the query changes the performance.

The nondistributed query plan looked like this example:

```text
                             QUERY PLAN                             
--------------------------------------------------------------------
 HashAggregate  (cost=8258.54..8268.54 rows=1000 width=52)
   Group Key: device_id
   ->  Seq Scan on events  (cost=0.00..1628.05 rows=68005 width=66)
(3 rows)
```

Run the following command to see the query plan in a distributed environment:

```sql
EXPLAIN SELECT device_id, COUNT((CASE WHEN (payload ->> 'humidity')::decimal < 60 THEN 1 ELSE NULL END)) AS LowHumidity,  
COUNT((CASE WHEN (payload ->> 'humidity')::decimal > 70 THEN 1 ELSE NULL END)) AS HighHumidity,
COUNT((CASE WHEN (payload ->> 'temperature')::decimal < 55 THEN 1 ELSE NULL END)) AS LowTemperature,
COUNT((CASE WHEN (payload ->> 'temperature')::decimal > 60 THEN 1 ELSE NULL END)) AS HighTemperature,
COUNT((CASE WHEN (payload ->> 'humidity')::decimal BETWEEN 60 AND 70 THEN 1 ELSE NULL END)) AS RegularHumidity,  
COUNT((CASE WHEN (payload ->> 'temperature')::decimal BETWEEN 55 AND 60 THEN 1 ELSE NULL END)) AS RegularTemperature
FROM events
GROUP BY device_id;
```

The distributed query plan shows output that looks like this example:

```text
                                              QUERY PLAN                                              
------------------------------------------------------------------------------------------------------
 Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=100000 width=52)
   Task Count: 32
   Tasks Shown: One of 32
   ->  Task
         Node: host=private-w1.cosmos-sensors-data.postgres.database.azure.com port=5432 dbname=citus
         ->  HashAggregate  (cost=377.12..377.37 rows=25 width=52)
               Group Key: device_id
               ->  Seq Scan on events_102044 events  (cost=0.00..71.36 rows=3136 width=56)
(8 rows)
```

In the query for outliers, there isn't a specific value for `device_id`. Because this query involves all records, the coordinator node is engaging all nodes, and all shards are queried. Why are there 32 tasks? There's a task for each shard, and Azure Cosmos DB for PostgreSQL creates 32 shards by default.

## Look at specific queries

You know that device 42 is problematic. Does including the device ID improve the query? Try running the following query:

```sql
EXPLAIN SELECT device_id, COUNT((CASE WHEN (payload ->> 'humidity')::decimal < 60 THEN 1 ELSE NULL END)) AS LowHumidity,  
COUNT((CASE WHEN (payload ->> 'humidity')::decimal > 70 THEN 1 ELSE NULL END)) AS HighHumidity,
COUNT((CASE WHEN (payload ->> 'temperature')::decimal < 55 THEN 1 ELSE NULL END)) AS LowTemperature,
COUNT((CASE WHEN (payload ->> 'temperature')::decimal > 60 THEN 1 ELSE NULL END)) AS HighTemperature,
COUNT((CASE WHEN (payload ->> 'humidity')::decimal BETWEEN 60 AND 70 THEN 1 ELSE NULL END)) AS RegularHumidity,  
COUNT((CASE WHEN (payload ->> 'temperature')::decimal BETWEEN 55 AND 60 THEN 1 ELSE NULL END)) AS RegularTemperature
FROM events
WHERE device_id = 42
GROUP BY device_id;
```

The query plan for device 42's outlier report looks like this example:

```text
                                              QUERY PLAN                                              
------------------------------------------------------------------------------------------------------
 Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=0 width=0)
   Task Count: 1
   Tasks Shown: All
   ->  Task
         Node: host=private-w1.cosmos-sensors-data.postgres.database.azure.com port=5432 dbname=citus
         ->  GroupAggregate  (cost=0.00..2687.02 rows=39 width=52)
               Group Key: device_id
               ->  Seq Scan on events_102071 events  (cost=0.00..688.08 rows=20498 width=74)
                     Filter: (device_id = 42)
(9 rows)
```

In this case, there's one task because the coordinator node can identify which shard needs to be queried for the specific `device_id` value. Only the shard that has a `device_id` value that's equal to 42 is queried, and not the entire dataset. By including the distribution column in the `WHERE` clause, Citus can optimize the cluster load to engage only the nodes that have shards that have the specified distribution column value.

Suppose you want to query for an `event_id` value. Run this query to get the first five records of events for device 42:

```sql
SELECT event_id FROM events WHERE device_id = 42 LIMIT 5;
```

Your results might look like this example:

```text
 event_id 
----------
        7
       10
       13
       16
       19
(5 rows)
```

What does the query plan look like if you omit `device_id` and query solely by `event_id`? Try this SQL:

```sql
EXPLAIN SELECT * FROM events WHERE event_id=7;
```

The query plan comes back as:

```text
                                                QUERY PLAN                                                
----------------------------------------------------------------------------------------------------------
 Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=100000 width=52)
   Task Count: 32
   Tasks Shown: One of 32
   ->  Task
         Node: host=private-w1.cosmos-sensors-data.postgres.database.azure.com port=5432 dbname=citus
         ->  Index Scan using events_pk_102044 on events_102044 events  (cost=0.28..4.30 rows=1 width=72)
               Index Cond: (event_id = 7)
(7 rows)
```

With a task count that's so high, you know that all the shards are being queried. All of the nodes that have shards are engaged. Although `event_id` is part of the index, it isn't the distribution column. Therefore, the coordinator node needs to engage all workers to find the events that have the specific `event_id` value.

What if you include both `device_id` and `event_id`?

```sql
EXPLAIN SELECT * FROM events WHERE event_id=7 AND device_id=42;
```

That query plan looks like this example:

```text
                                                QUERY PLAN                                                
----------------------------------------------------------------------------------------------------------
 Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=0 width=0)
   Task Count: 1
   Tasks Shown: All
   ->  Task
         Node: host=private-w1.cosmos-sensors-data.postgres.database.azure.com port=5432 dbname=citus
         ->  Index Scan using events_pk_102071 on events_102071 events  (cost=0.29..4.31 rows=1 width=90)
               Index Cond: ((event_id = 7) AND (device_id = 42))
(7 rows)
```

By including the distribution column in your query's `WHERE` clause, you help the coordinator node figure out which shards to query. The result is less impact on the cluster because fewer worker nodes need to be engaged in the query.

## Conclusion

By upgrading from a single-node cluster to a multi-node cluster, Wide World Importers was able to identify problems in its sensor data and quickly observe data for specific devices. The company was able to distribute its data and use parallel processing for queries to quickly identify humidity and temperature concerns. It was able to improve performance for queries for specific devices with minimal downtime. The popular chilly chocolates product were removed from device 42 in time to save them from becoming melted chocolates.
