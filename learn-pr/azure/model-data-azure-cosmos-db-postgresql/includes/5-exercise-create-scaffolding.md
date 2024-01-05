In this exercise, you work with Woodgrove Bank's developers on distributing tables for the distributed version of Woodgrove Bank payment app's database:

:::image type="complex" source="../media/distributed-entity-relationship-diagram.svg" alt-text="Diagram of distributed relationships between users, events, event types, and merchants.":::
   In the diagram, payment_events has a column event_type_id, with a foreign-key relationship to the event_types table. The event_types table contains the name and event_type_id, with the event_type_id as its primary key. The event_types table is a reference table. The payment_merchants table has merchant_id, name, and url. The merchant_id is the distribution column for payment_merchants. The payment_users distributed table uses user_id as its distribution column and has a foreign-key relationship to the payment_events table.
:::image-end:::

## Create tables

The `payment_events`, `event_types`, `payment_users`, and `payment_merchants` tables are created as local tables in the previous exercise. Now, you can convert them to reference or distributed tables. For this exercise, you should already be connected to your database via psql in Azure Cloud Shell.

### Create reference tables

The initial tables are created on the coordinator node as local tables. Once created, they can be converted to reference tables and distributed tables.

The `event_types` table is a smaller table, keeping track of a set of event types. It will be joined in queries with the distributed `payment_events` table, which means that the `event_types` table can't be a local table. When the worker node stores a copy of the `event_types` table on each worker node, the worker node can query the reference data without having to attempt cross-node queries. Because it's a small set of event types, we can promote it to a reference table.

The `payment_merchants` table is also a smaller table. The merchant information is also needed in queries with `payment_events`. The merchants table will also be a reference table.

1. Change the `event_types` table from a local table to a reference table with the following command:

    ```sql
    SELECT create_reference_table('event_types');
    ```

    The output will start with something like this:

    ```output
    NOTICE:  local tables that are added to metadata automatically by citus, but not chained with reference tables via foreign keys might be automatically converted back to postgres tables

    HINT:  Executing citus_add_local_table_to_metadata($$public.payment_events$$) prevents this for the given relation, and all of the connected relations
    ```

    `payment_events` is currently a local table. It's chained to `event_types` via the foreign key relationship. This output isn't concerning. This messaging will be repeated for all of the relationships. Due to the foreign keys already in place, creating the reference tables first shouldn't present a problem.

1. Change the `payment_merchants` table from a local table to a reference table with the following command:

    ```sql
    SELECT create_reference_table('payment_merchants');
    ```

### Create distributed tables

The events and users tables are going to be distributed based on their `user_id` columns.

1. Distribute the `payment_events` table on its `user_id` column with the following command:

    ```sql
    SELECT create_distributed_table('payment_events','user_id');    
    ```

    If the reference table query for creating `event_types` fails and you run this `create_distributed_table` query, you'll get an error that the reference table `event_types` must be a distributed table or a reference table. This output is an example of the error you might see:

    ```output
    citus=>  SELECT create_distributed_table('payment_events','user_id');    
    ERROR:  referenced table "event_types" must be a distributed table or a reference table
    DETAIL:  To enforce foreign keys, the referencing and referenced rows need to be stored on the same node.
    HINT:  You could use SELECT create_reference_table('event_types') to replicate the referenced table to all nodes or consider dropping the foreign key
    ```

1. Distribute the `payment_users` table with implicit colocation using the following command:

    ```sql
    SELECT create_distributed_table('payment_users','user_id');
    ```

## Current design state

Following along with the current exercise, you should have:

* `event_types` as a reference table
* `payment_merchants` as a reference table
* `payment_events` as a distributed table with `user_id` as its distribution column and foreign-key relationships with `event_types` and `payment_merchants`
* `payment_users` as a distributed table with `user_id` as its distribution column, implicity colocated with `payment_events`

Confirm that the tables and distribution are set up as expected with the following query:

```sql
SELECT table_name, citus_table_type, distribution_column, colocation_id FROM citus_tables;
```

The output should confirm the table types (`citus_table_type`) and distribution columns (`distribution_column`). Make note that `event_types` and `payment_merchants` have the value of &lt;none&gt; for their distribution columns, as reference tables don't have distribution columns. The `colocation_id` for `payment_events` and `payment_users` should match. Here's an example of the output:

```output
    table_name     | citus_table_type | distribution_column | colocation_id 
-------------------+------------------+---------------------+---------------
 event_types       | reference        | <none>              |             2
 payment_events    | distributed      | user_id             |             1
 payment_merchants | reference        | <none>              |             2
 payment_users     | distributed      | user_id             |             1
 ```
