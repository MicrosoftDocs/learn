After looking at Wide World Importers' non-distributed data and evaluating it for distribution, you can distribute the data.

## Review the plan

This is the plan based on what was seen:

1. Set up a simulation of the sensors reporting their readings.
2. Get a baseline understanding of the query in a non-distributed environment through its query plan.
3. Start the benchmark to simulate data access.
4. Drop and update the primary key on `events`.
5. Make `device_types` a reference table.
6. Remove the foreign key relationship between `devices` and `events`.
7. Distribute `devices` on `device_id` using `create_distributed_table_concurrently()`.
8. Distribute `events` on `device_id` using `create_distributed_table_concurrently()`.
9. Recreate the foreign key relationship between `events` and `devices`.
10. Truncate the data from the coordinator.
11. Review query performance in a distributed environment.

Now that the plan is laid out, you can execute the plan.

## Set up the simulation

The sensors report their readings every minute. You can use the `pg_cron` extension and a cron job to write sensor values every minute.

### Verify installation of pg_cron extension

In the following tasks, you'll use the `pg_cron` extension for PostgreSQL to run scheduled jobs in the database. You'll use this to simulate the sensors' updates. Before installing any new supported extensions in your database, view the complete list of installed extensions to avoid potential conflicts. Many popular PostgreSQL extensions are pre-installed on every Azure Cosmos DB for PostgreSQL cluster.

1. Connect to your Azure Cosmos DB for PostgreSQL cluster via psql in [Azure Cloud Shell](https://shell.azure.com).
2. View the list of pre-installed extensions in your Azure Cosmos DB for PostgreSQL database by running the following:

    ```sql
    SELECT * FROM pg_extension;
    ```

    You can use this query to view the version and details associated with the installed extensions. Alternatively, you could run `\dx` from the command line, a shortcut command that provides a list of installed extensions in your database.

3. Inspect the output of the above query, looking for a row where the `extname` value is `pg_cron` to determine if the extension is pre-installed.

    ```text
      oid  |      extname       | extowner | extnamespace | extrelocatable | extversion |         extconfig         | extcondition  
    -------+--------------------+----------+--------------+----------------+------------+---------------------------+---------------
     19371 | pg_cron            |       10 |         2200 | f              | 1.4-1      | {19374,19373,19393,19392} | {"","","",""}
    ```

    The query output reveals that `pg_cron` comes pre-installed, so there's nothing more you need to do to use this extension.

### Create and run a stored procedure to add sensor readings to the database

To correctly measure the impact that transitioning from a single-node cluster to a multi-node cluster has on Wide World Importers' sensors database, you can use a stored procedure and scheduled job to simulate sensor reporting load on the database as you go through this exercise.

1. You can use a stored procedure to create sensor readings for all of the devices listed on the devices table. Since the goal is to run this stored procedure in under 1 minute, you'll generate four sets of sensor data within a minute, sleeping for 10 seconds between runs. This is so that you have data generated in seconds, as this query is a quick query. Run the following SQL:

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

2. Next, you need to execute the stored procedure occasionally to add sensors' readings to the database. To simulate sensor traffic, schedule `generate_sensor_readings` to run every minute using `pg_cron`. Run the following `cron.schedule` command to set up a job named `generate_readings` in the database.

    ```sql
    SELECT cron.schedule('generate_readings','* * * * *', 'CALL generate_sensor_readings();');
    ```

    This command returns the job ID. If you need to unschedule the job, you can run the `cron.unschedule()` function with either of the following formats:

    ```sql
    SELECT cron.unschedule(JOB_ID);
    SELECT cron.unschedule(JOB_NAME);
    ```

If you want to monitor the job runs, you can view their statuses and details with the following query:

```sql
SELECT * FROM cron.job_run_details;
```

> **Note**: If you want to look at the 5 most recent job runs, run the following command: `SELECT * FROM cron.job_run_details ORDER BY start_time DESC LIMIT 5;`

## Get a baseline understanding of the query in a non-distributed configuration

Run the following command to understand how the query is run in a non-distributed configuration:

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

The query plan may look like this:

```text
                             QUERY PLAN                             
--------------------------------------------------------------------
 HashAggregate  (cost=8258.54..8268.54 rows=1000 width=52)
   Group Key: device_id
   ->  Seq Scan on events  (cost=0.00..1628.05 rows=68005 width=66)
(3 rows)
```

For this example, there are 68,005 rows in the sequence scan. When aggregated, it is 1000 rows, as there are 1000 devices showing outliers. Make note of this cost, as you'll compare it later.

Keep this instance of Azure Cloud Shell open, as there are more SQL commands to issue. For the next section, you'll open a second instance of Azure Cloud Shell.

## Simulate data access during data distribution

As part of the goal of this module is to go from non-distributed data to distributed data with minimal interruption, you'll run a benchmark that runs in the background to simulate users accessing the data while you're distributing the data. The 20 minutes allocated for this benchmark job should be enough time to show how your data can be accessed while you're distributing it.

This exercise shows simulated data usage while going from a non-distributed database to a distributed database configuration. The following scenarios are happening:

- The `pg_cron` job writes data
- The `pgbench` job reads data.
- You're distributing data from `psql`.

Since `pgbench` is being used to simulate database read access, run the following command to benchmark over 20 minutes, reporting progress every minute, and then continue reading:

```bash
pgbench $PGURL -c 64 -j 64 -T 1200 -n -P 60 -f outliers.sql
```

Once this benchmark is started, return to your Azure Cloud Shell running psql.

## Update the primary key on events to include the distribution column

Since the `events` table has a relationship with the `devices` table and is frequently queried for a device's readings, it makes sense to distribute the events on the `device_id`. Azure Cosmos DB for PostgreSQL can't enforce unique constraints on distributed tables unless the constraints include the distribution column. Before you can distribute the table, you have to add `device_id` as part of the primary key. The path to minimize disruption involves:

1. Create a new index concurrently that includes the current primary key and the distribution column.
2. Create a transaction to drop the primary key constraint and add the new primary key.

Here's how to accomplish these steps:

1. To create a new index while data is being used, use `CREATE INDEX CONCURRENTLY`. By creating the index concurrently, normal operations can continue while the index is built. To create a new index on the `events` table that includes the current primary key (`event_id`) and the distribution column, run the following query:

    ```sql
    CREATE UNIQUE INDEX CONCURRENTLY events_devices_idx ON events (event_id,device_id);
    ```

2. Transactionally, drop the existing primary key and create a new primary key.

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

    The output for this command should look similar to this:

    ```text
    BEGIN
    ALTER TABLE
    NOTICE:  ALTER TABLE / ADD CONSTRAINT USING INDEX will rename index "events_devices_idx" to "events_pk"
    ALTER TABLE
    COMMIT
    ```

    > **Note**: If you're typing these commands and run into this error: 'DETAIL: Cannot create a primary key or unique constraint using such an index.', you may have left the `UNIQUE` out of the concurrent index creation. If you find yourself in this situation, you can get out of that by running `DROP INDEX CONCURRENTLY events_devices_idx` and then start again at step 1 for this section.

Confirm the new primary key is set by running the following command:

```sql
\d events
```

The output shows:

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

Notice that the primary key under Indexes shows `event_id` and `device_id`. Make note of the foreign key name, as you'll need that in the next section.

## Create a reference table

Once the baseline query metrics and query plan are gathered, then you can distribute the data. First, promote `devices_types` to a reference table with the following query:

```sql
SELECT create_reference_table('device_types');
```

You'll see output similar to this:

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

It might look like the messages are repeated. Citus does add local tables automatically to the metadata and can convert them back to Postgres tables. There's a hint to execute `citus_add_local_table_to_metadata()` for `devices` and `events` since they're local tables with relationships. With those messages, there are a couple of things to note:

- You'll truncate the local copy of data at the end, once a copy has been successfully is distributed.
- If you were keeping a table a local table, then you'd need to run `citus_add_local_table_to_metadata()`.

You aren't going to add the tables as local tables to the metadata, as these tables aren't staying as local tables. These other tables will be distributed.

You can confirm the distribution status with the following query:

```sql
SELECT * FROM citus_tables;
```

The output looks something like this:

```text
  table_name  | citus_table_type | distribution_column | colocation_id | table_size | shard_count | table_owner | access_method 
--------------+------------------+---------------------+---------------+------------+-------------+-------------+---------------
 devices      | local            | <none>              |             0 | 128 kB     |           1 | citus       | heap
 device_types | reference        | <none>              |             1 | 96 kB      |           1 | citus       | heap
 events       | local            | <none>              |             0 | 19 MB      |           1 | citus       | heap
(3 rows)
```

## Remove the foreign key relationships before distribution

You need to remove the foreign key relationship between `devices` and `events` before distributing them. Beware that when the foreign key is removed there's no protection in the database against an application adding or deleting records that violate referential integrity. You'll reestablish the foreign key relationship once the tables are distributed.

To remove the foreign key, use DROP CONSTRAINT in an ALTER statement. Since the foreign key constraint in the example above is named `events_device_id_fkey`, this is the SQL to remove it:

```sql
ALTER TABLE events DROP CONSTRAINT events_device_id_fkey;
```

You may see the following notice as a response:

```text
NOTICE:  removing table public.events from metadata as it is not connected to any reference tables via foreign keys
```

> **Note**: If you run into an error while dropping the constraint, try running the query again.

If you run the query to check `citus_tables`, you'll notice that the events table is missing from the list. This isn't concerning as events will be distributed and in the metadata again soon.

## Distribute the devices table concurrently

Since you have data already loaded, you need to be mindful of moving data in use. You'll use `create_distributed_table_concurrently()` to distribute `devices` on its `device_id` field with the following command:

```sql
SELECT create_distributed_table_concurrently('devices','device_id');
```

To confirm that it's distributed, run the following query:

```sql
SELECT * FROM citus_tables;
```

The output looks like this:

```text
  table_name  | citus_table_type | distribution_column | colocation_id | table_size | shard_count | table_owner | access_method 
--------------+------------------+---------------------+---------------+------------+-------------+-------------+---------------
 devices      | distributed      | device_id           |             3 | 1024 kB    |          32 | citus       | heap
 device_types | reference        | <none>              |             2 | 96 kB      |           1 | citus       | heap
```

Notice that the `citus_table_type` shows `devices` as `distributed`. It also has a `distribution_column` value as well as a shard count greater than 1.

## Distribute the events table concurrently

As there's data in the events table, you want to move the data using `create_distributed_table_concurrently()`.

Use `create_distributed_table_concurrently()` to distribute `events` on its `device_id` field with the following command:

```sql
SELECT create_distributed_table_concurrently('events','device_id');
```

To confirm that it's distributed, run the following query:

```sql
SELECT * FROM citus_tables;
```

The output looks like this:

```text
  table_name  | citus_table_type | distribution_column | colocation_id | table_size | shard_count | table_owner | access_method 
--------------+------------------+---------------------+---------------+------------+-------------+-------------+---------------
 devices      | distributed      | device_id           |             3 | 1024 kB    |          32 | citus       | heap
 device_types | reference        | <none>              |             2 | 96 kB      |           1 | citus       | heap
 events       | distributed      | device_id           |             3 | 19 MB    |          32 | citus       | heap
```

Notice that devices and events are colocated by having the same `colocation_id` value. This means that the `events` data is distributed on `device_id` and colocated with the `devices` shard for that `device_id`.

## Reestablish the foreign key between devices and events

Since `devices` and `events` are two distributed tables that are colocated, they can have a foreign key relationship enforced. Readd the foreign key relationship on `device_id` with the following command:

```sql
ALTER TABLE events ADD CONSTRAINT FK_events_devices FOREIGN KEY (device_id) REFERENCES devices(device_id);
```

## Truncate data from the coordinator

Now that the data is distributed, you can truncate the data from the coordinator. Since you no longer need the local tables on there, it's good practice to clean that up. You can truncate the data by calling `truncate_local_data_after_distributing_table()`. Clean up the local tables with the following commands:

```sql
SELECT truncate_local_data_after_distributing_table('public.device_types');
```

The output looks like this:

```text
NOTICE:  truncate cascades to table "devices"
NOTICE:  truncate cascades to table "events"
 truncate_local_data_after_distributing_table 
----------------------------------------------
 
(1 row)
```

Truncates will cascade to the **local** version of other distributed tables. As the data has been distributed on the worker nodes, this `truncate_local_data_after_distributing_table()` command removes stale data on the local tables left behind in the distribution process.

## Confirm query performance

Now that the data has been distributed and the local data has been truncated, you can stop the benchmarks in the second Azure Cloud Shell window. If they're still running, press `Ctrl+C` to stop `pgbench`. This instance of Azure Cloud Shell can be exited.

Switch to the Azure Cloud Shell running `psql`. You can examine the query plan to see if distributing the query changes the performance.

The non-distributed query plan looked like this:

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

The distributed query plan shows:

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

In the query for outliers, there isn't a specific `device_id`. Since this query involves all records, the coordinator is engaging all nodes, which queries all shards. Why are there 32 tasks? There's a task for each shard, and Azure Cosmos DB for PostgreSQL creates 32 shards by default.

## Looking at specific queries

You know that device 42 is problematic. Does including the device ID improve the query? Try this:

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

The query plan for device 42's outlier report is:

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

In this case, there's one task, as the coordinator can identify which shard needs to be queried for the specific `device_id`. This means that only the shard with `device_id` equal to 42 is queried and not the entire dataset. By including the distribution column in the WHERE clause, Citus can optimize the cluster load to engage only the nodes that have shards with the specified distribution column value.

Suppose you want to query for an `event_id`. Run this query to get the first five records of events for device 42:

```sql
SELECT event_id FROM events WHERE device_id = 42 LIMIT 5;
```

Your results may look like this:

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

With that high of a task count, all of the shards are getting queried, so all of the nodes with shards are engaged. While the `event_id` is part of the index, it isn't the distribution column. Therefore, the coordinator node needs to engage all workers to find the events with the specific `event_id`.

What if you include both the device_id and the event_id?

```sql
EXPLAIN SELECT * FROM events WHERE event_id=7 AND device_id=42;
```

That query plan looks like this:

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

By including the distribution column in your query's WHERE clause, you help the coordinator to figure out which shards to query, which can lessen the impact of the query on the cluster as fewer worker nodes need to be engaged.

## Conclusion

By upgrading from a single-node cluster to a multi-node cluster, Wide World Importers were able to identify problems in their sensor data and quickly observe data for particular devices. They were able to take advantage of distributing their data and use parallel processing of the queries to quickly identify humidity and temperature concerns. They were able to improve their performance for queries for specific devices with minimal downtime. The chilly chocolates were removed from the location with device 42 in time to save them from becoming melted chocolates.
