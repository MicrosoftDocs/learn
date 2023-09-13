Working with the Woodgrove Bank developers on getting their application's database scaffolded, this diagram illustrates what they loaded in the database:

:::image type="complex" source="../media/normalized-database-entity-relationship-diagram.svg" alt-text="Diagram of the relationships between users, events, merchants, and event types.":::
   In the diagram, payment_events' event_type field is now event_type_id, with a foreign-key relationship to a new table named event_types. The event_types table contains the name and event_type_id, with the event_type_id as its primary key. The payment_events table also has a foreign-key relationship to a new table named payment_merchants. The payment_merchants table has merchant_id, name, and url. The merchant_id is the primary key for payment_merchants.
:::image-end:::

In this exercise, you'll restructure their database to get to the following output:

:::image type="complex" source="../media/distributed-entity-relationship-diagram.svg" alt-text="Diagram of distributed relationships between users, events, event types, and merchants.":::
   In the diagram, payment_events has a column event_type_id, with a foreign-key relationship to the event_types table. The event_types table contains the name and event_type_id, with the event_type_id as its primary key. The event_types table is a reference table. The payment_merchants table has merchant_id, name, and url. The merchant_id is the distribution column for payment_merchants. The payment_users distributed table uses user_id as its distribution column and has a foreign-key relationship to the payment_events table.
:::image-end:::

## Reset the exercise database

1. Clear the tables from the previous exercise, removing dependencies first:

    ```sql
        DROP TABLE payment_events;
        DROP TABLE payment_merchants;    
        DROP TABLE payment_users;
        DROP TABLE event_types;
    ```

1. Create the tables as the Woodgrove Bank developers created.

    ```sql
    CREATE TABLE event_types 
    (
        event_type_id bigint CONSTRAINT event_types_pk PRIMARY KEY,
        event_type text
    );

    CREATE TABLE payment_users
    (
        user_id bigint CONSTRAINT payment_users_pk PRIMARY KEY,
        url text,
        login text,
        avatar_url text
    );

    CREATE TABLE payment_merchants
    (
        merchant_id bigint CONSTRAINT payment_merchants_pk PRIMARY KEY,
        name text,
        url text
    );

    CREATE TABLE payment_events
    (
        event_id bigint,
        user_id bigint CONSTRAINT payment_events_payment_users_fk REFERENCES payment_users (user_id),
        event_type_id bigint CONSTRAINT payment_events_event_types_fk REFERENCES event_types (event_type_id),
        merchant_id bigint CONSTRAINT payment_events_payment_merchants_fk REFERENCES payment_merchants (merchant_id),
        event_details jsonb,
        created_at timestamp
    ) PARTITION BY RANGE (created_at);    
    ```

## Adjust the dependencies

In order to get the relational database ready for distribution, you need to remove some constraints.

```sql
ALTER TABLE payment_events         
    DROP CONSTRAINT payment_events_payment_merchants_fk;
ALTER TABLE payment_events         
    DROP CONSTRAINT payment_events_payment_users_fk;
```

## Distribute the non-events tables

You can distribute the non-events tables or turn them into reference tables. As the Woodgrove Bank developers wonder what happens if `payment_merchants` is distributed, these steps will take you down that path.

1. Change `event_types` to a reference table with this query:

    ```sql
    SELECT create_reference_table('event_types');
    ```

1. Distribute `payment_users` on `user_id` with this query:

    ```sql
    SELECT create_distributed_table('payment_users','user_id');
    ```

1. Distribute `payment_merchants` on `merchant_id` with this query:

    ```sql
    SELECT create_distributed_table('payment_merchants','merchant_id');
    ```

1. Ensure the tables are distributed as expected with the following query:

    ```sql
    SELECT table_name, citus_table_type, distribution_column, colocation_id FROM citus_tables;
    ```

    Notice that the distributed tables are implicitly colocated together. Here's an example of the output:

    ```output
        table_name     | citus_table_type | distribution_column | colocation_id 
    -------------------+------------------+---------------------+---------------
    event_types       | reference        | <none>              |             2
    payment_merchants | distributed      | merchant_id         |             1
    payment_users     | distributed      | user_id             |             1
    ```

## Update colocation settings

The developers asked about updating colocation after a table is distributed, because `payment_merchants` shouldn't be colocated.

1. Run the following query:

    ```sql
    SELECT update_distributed_table_colocation('payment_merchants',colocate_with=>'none');
    ```

1. Ensure that the users and merchants tables are no longer colocated with the following query:

    ```sql
    SELECT table_name, citus_table_type, distribution_column, colocation_id FROM citus_tables;  
    ```

    The users and merchants tables should have different `colocation_id` values. The output should look something like this:

    ```output
        table_name     | citus_table_type | distribution_column | colocation_id 
    -------------------+------------------+---------------------+---------------
    event_types       | reference        | <none>              |             2
    payment_merchants | distributed      | merchant_id         |             4
    payment_users     | distributed      | user_id             |             1
    ```

## Distribute the events table

While you work through the design with the Woodgrove Bank developers, they ask why they shouldn't distribute the events on the `event_id` field.

1. Distribute the `payment_events` table on `event_id`.

    ```sql
    SELECT create_distributed_table('payment_events','event_id');
    ```

1. Query `citus_tables` to show co-location.

    ```sql
    SELECT table_name, citus_table_type, distribution_column, colocation_id FROM citus_tables;  
    ```

    The output will look like this:

    ```output
        table_name     | citus_table_type | distribution_column | colocation_id 
    -------------------+------------------+---------------------+---------------
    event_types       | reference        | <none>              |             2
    payment_events    | distributed      | event_id            |             1
    payment_merchants | distributed      | merchant_id         |             4
    payment_users     | distributed      | user_id             |             1
    ```

    Observe that Azure Cosmos DB for PostgreSQL colocated `payment_events` with `payment_users` implicitly, based on datatypes of their distribution columns. The developers are starting to see that the fields don't match and that it doesn't seem like a good distribution column, because they want to join the `payment_events` and `payment_users` tables on `user_id`.

## Update the events table to distribute based on user_id

Update the `payment_events` table to be distributed on `user_id`.

1. Run the following query to change the distribution column for `payment_events`:

    ```sql
    SELECT alter_distributed_table('payment_events',distribution_column:='user_id');
    ```

    When this query is run successfully, you'll see output like this:

    ```output
    NOTICE:  creating a new table for public.payment_events
    NOTICE:  moving the data of public.payment_events
    NOTICE:  dropping the old public.payment_events
    NOTICE:  renaming the new table to public.payment_events
    ```

    This query will apply to all the partitions for this table.

1. Confirm the change took effect by running:

    ```sql
    SELECT table_name, citus_table_type, distribution_column, colocation_id FROM citus_tables;  
    ```

    The output is:

    ```output
        table_name     | citus_table_type | distribution_column | colocation_id 
    -------------------+------------------+---------------------+---------------
    event_types       | reference        | <none>              |             2
    payment_events    | distributed      | user_id             |             1
    payment_merchants | distributed      | merchant_id         |             4
    payment_users     | distributed      | user_id             |             1
    ```

    The `distribution_column` for `payment_events` and its partitions should show the `user_id`.

## Adding a foreign key to a distributed table after creation

In a case where there are two colocated distributed tables with a foreign key relationship, you'll need to add the foreign key after both tables are distributed. A foreign key in this case must include the distribution column.

1. `payment_events` should have a foreign key relationship to `payment_users`. Add this relationship with the following command:

    ```sql
    ALTER TABLE payment_events ADD CONSTRAINT events_users_fk
     FOREIGN KEY (user_id) REFERENCES payment_users(user_id);
    ```

1. Confirm that the foreign key has been added by running the following command:

    ```sql
    \d payment_events
    ```

    The output will look like this:

    ```output
                      Partitioned table "public.payment_events"
    Column     |            Type             | Collation | Nullable | Default 
    ---------------+-----------------------------+-----------+----------+---------
    event_id      | bigint                      |           |          | 
    user_id       | bigint                      |           |          | 
    event_type_id | bigint                      |           |          | 
    merchant_id   | bigint                      |           |          | 
    event_details | jsonb                       |           |          | 
    created_at    | timestamp without time zone |           |          | 
    Partition key: RANGE (created_at)
    Foreign-key constraints:
        "events_users_fk" FOREIGN KEY (user_id) REFERENCES payment_users(user_id)
        "payment_events_event_types_fk" FOREIGN KEY (event_type_id) REFERENCES event_types(event_type_id)
    ```

    There should be two foreign keys on the `payment_events` table; one for the events and the other for the users.

## Adding a foreign key without the distribution column

`payment_events` also initially had a foreign key relationship with `payment_merchants`. Try adding this relationship with the following command:

```sql
ALTER TABLE payment_events ADD CONSTRAINT events_merchants_fk
 FOREIGN KEY (merchant_id) REFERENCES payment_merchants(merchant_id);
```

By running this command, you'll see output along these lines:

```output
ERROR:  cannot create foreign key constraint
DETAIL:  Foreign keys are supported in two cases, either in between two colocated tables including partition column in the same ordinal in the both tables or from distributed to reference tables
```

This foreign key is something that we'll have to sacrifice from the design when going from a single server to a distributed database.

## Convert from a distributed table to a reference table

The merchants table might not be as large as the developers suggested. Rather than having the foreign-key relationship discarded, convert the merchant table to a reference table. Then, bring back the foreign key relationship from the distributed table to the reference table.

1. Convert the merchant table to a reference table with the following commands:

    ```sql
    SELECT undistribute_table('payment_merchants');
    SELECT create_reference_table('payment_merchants');
    ```

1. Add the foreign key relationship from payment_events to payment_merchants with the following command:

    ```sql
    ALTER TABLE payment_events ADD CONSTRAINT events_merchants_fk
     FOREIGN KEY (merchant_id) REFERENCES payment_merchants(merchant_id);
    ```

## View distributed tables

Confirm whether tables are distributed by querying the `citus_tables` system view. The following query includes the table name, table type, and distribution column. Run the following command:

```sql
SELECT table_name, citus_table_type, distribution_column FROM citus_tables;
```

In the results from the query, the `citus_table_type` column will indicate whether a table is a distributed table or a reference table. The results will look like this:

```bash
   table_name     | citus_table_type | distribution_column 
-------------------+------------------+---------------------
 event_types       | reference        | <none>
 payment_events    | distributed      | user_id
 payment_merchants | reference        | <none>
 payment_users     | distributed      | user_id
```

Notice that reference tables don't have distribution columns.

## Clean up

Once you're done in this module, clean up the resources created in order to minimize costs.

1. Sign in to the Azure portal.
1. Navigate to the resource group created for this module.
1. Delete the resource group.
