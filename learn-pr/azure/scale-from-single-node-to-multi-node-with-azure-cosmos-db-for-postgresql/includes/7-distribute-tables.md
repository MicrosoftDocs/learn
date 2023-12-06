Wide World Importers knows that they're racing against the clock in saving their chilly chocolates from becoming melted chocolates. By improving their query performance with a distributed environment, they can more quickly identify fail points in the system and rectify the situation. To go to a distributed layout, some things need to happen.

- The `device_types` table needs to become a reference table.
- The `devices` table needs to be distributed on the `device_id` column.
- The `events` table needs to be distributed on the `device_id` column.

Because the plan is to move from a nondistributed environment to a distributed environment with data already in place, this move needs to happen with minimal disruption to the existing data. The order in which you make changes is crucial.

## Current nondistributed configuration

It's helpful to review the current nondistributed configuration:

- The `device_types` table has two fields: `device_type_id` and `name`.

   The `device_types` table primary key is `device_type_id`.

- The `devices` table has three fields: `device_id`, `device_type_id`, and `name`.

   The `devices` table primary key is `device_id`.

   A foreign key relationship on the `device_type_id` field references the `device_type_id` field on the `device_types` table.
- The `events` has four fields: `event_id`, `device_id`, `payload`, and `created_at`.

   The `events` table primary key is `event_id`.
  
   A foreign key relationship on the `device_id` field references the `device_id` field on the `devices` table.

:::image type="content" source="../media/normalized-database-erd.png" border="false" alt-text="Diagram that shows the relationships between three tables, and the columns and primary keys in each table.":::

## Decide the order for distribution

Keep in mind that relationships change in a distributed environment. Foreign keys work in Azure Cosmos DB for PostgreSQL in these scenarios:

- Between two local tables
- Between two reference tables
- Between reference tables and local tables
- Between two colocated distributed tables with a shared key
- From a distributed table to a reference table

The cases where foreign keys aren't supported are:

- From reference tables to distributed tables
- From local tables to distributed tables

By default, all tables are local tables on the coordinator node. Unless they're supposed to be local tables, they need to be distributed. Take these steps when you convert from the nondistributed configuration:

1. Look at the tables that have the least amount of impact. Reference tables are the first candidates to look at because relationships between reference tables and local tables aren't issues.
    - `device_types` has a primary key of `device_type_id`. You don't need to change this primary key value.
    - When `device_types` is promoted to a reference table, the foreign key relationship between it and `devices` shouldn't cause problems due to the situation between reference and local tables.
1. Identify relationships between distributed tables and other tables.
    - The `devices` table has a primary key of `device_id`. You don't need to change this primary key value.
    - `devices` and `device_types` are joined by `device_id` in a foreign key relationship.
    - Because the `devices` table has a relationship with the `events` table, you also need to consider that factor.
    - The `events` table has a primary key of `event_id`. This value needs to change. As you identified that `events` will be distributed by `device_id`, the `device_id` field needs to be added to the primary key.
      1. The primary key constraint needs to be dropped so that it can be replaced with a composite primary key.
      1. The primary key constraint needs to be added as a composite primary key of `device_id` and `event_id`. You'd need to keep the `event_id` to ensure uniqueness on the primary key side of things.
      1. The foreign key constraint from the `events` table to the `devices` table needs to be dropped temporarily to prepare `devices` for distribution.

## Move existing data in-use

At this point, `events` and `devices` are ready to be distributed. If you were starting with a new database and didn't have the data already loaded, you could use `create_distributed_table()`. However, because you have data already in use, you need to move the data using `create_distributed_table_concurrently()`.

`create_distributed_table_concurrently()` is a nonblocking function, which allows distributing the data while also allowing writes to the table.

Some things to note with this function:

- You can't use `create_distributed_table_concurrently()` in a transaction. This function can only be used for one table at a time.
- You can't use `create_distributed_table_concurrently()` when the table is referenced by a foreign key or references a local table. However, you can remove foreign key references, and then reestablish them after distribution.
- Updates and deletes might fail during distribution if there isn't a primary key because of how replication works.

You'll use `create_distributed_table_concurrently()` to distribute the `devices` and `events` tables.

## Truncate data on the coordinator

Before distribution, the data lives solely on the coordinator node. As part of data distribution, the data is copied to the worker nodes. The initial data remains on the coordinator node. Rather than leaving unused data behind, it's good practice to remove the unnecessary data by truncating it from the coordinator node. You can remove unnecessary data by using the `truncate_local_data_after_distributing_table()` function.

Now that you have a plan for transitioning from a nondistributed environment to a distributed environment, you can apply the plan to the Wide World Importers sensors data.
