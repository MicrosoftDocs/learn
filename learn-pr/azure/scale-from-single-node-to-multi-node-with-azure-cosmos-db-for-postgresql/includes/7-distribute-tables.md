Wide World Importers knows that they're racing against the clock in saving their chilly chocolates from becoming melted chocolates. By improving their query performance with a distributed environment, they can more quickly identify fail points in the system and rectify the situation. To go to a distributed layout, some things need to happen.

- The `device_types` table needs to become a reference table.
- The `devices` table needs to be distributed on the `device_id` column.
- The `events` table needs to be distributed on the `device_id` column.

Since the plan is to move from a non-distributed environment to a distributed environment with data already in place, this move needs to happen with minimal disruption to the existing data. The order in tackling these is crucial.

## Current non-distributed configuration

This is a reminder of the current non-distributed configuration.

- `device_types` has a `device_type_id` field and a `name` field. `device_type_id` is its primary key.
- `devices` has three fields - `device_id`, `device_type_id`, and `name`. The `device_id` field is the primary key. There's a foreign key relationship on the `device_type_id` field that references the `device_type_id` field on the `device_types` table.
- `events` has three fields - `event_id`, `device_id`, and `payload`. The `event_id` is its primary key. There's a foreign key relation on the `device_id` that references the `device_id` field on the `devices` table.

![Diagram of the relationships between device types, devices, and events. The device_types table has two fields - device_type_id and name. device_type_id is its primary key. The devices table has three fields - device_id, device_type_id, and name. device_id is its primary key. The devices table has a foreign key relationship on device_type_id that references the device_type_id field on the device_types table. The events table has three fields - event_id, device_id, and payload. event_id is its primary key. The events table has a foreign key relationship on its device_id that references the device_id field on the devices table.](../media/normalized-database-erd.png)

## Decide the order for distribution

Keep in mind that relationships change in a distributed environment. These are the cases where foreign keys work in Azure Cosmos DB for PostgreSQL:

- Between two local tables
- Between two reference tables
- Between reference tables and local tables
- Between two colocated distributed tables with a shared key
- From a distributed table to a reference table

The cases where foreign keys aren't supported are:

- From reference tables to distributed tables
- From local tables to distributed tables

By default, all tables are local tables on the coordinator node. Unless they're supposed to be local tables, they need to be distributed. These are the steps to take in converting from the non-distributed configuration:

1. Look at the tables with the least amount of impact. Reference tables are the first candidates to look at, as relationships between reference and local tables aren't issues.
    - `device_types` has a primary key of `device_type_id`. This needn't change.
    - When `device_types` is promoted to a reference table, the foreign key relationship between it and `devices` shouldn't cause problems due to the situation between reference and local tables.
2. Identify relationships between distributed tables and other tables.
    - The `devices` table has a primary key of `device_id` This needn't change.
    - `devices` and `device_types` are joined by `device_id` in a foreign key relationship.
    - Since the `devices` table has a relationship with the `events` table, you need to look at that as well.
    - The `events` table has a primary key of `event_id`. This needs to change. As you identified that `events` will be distributed by `device_id`, the `device_id` field needs to be added to the primary key.
      1. The primary key constraint needs to be dropped so that it can be replaced with a composite primary key.
      2. The primary key constraint needs to be added as a composite primary key of `device_id` and `event_id`. You'd need to keep the `event_id` to ensure uniqueness on the primary key side of things.
      3. The foreign key constraint from the `events` table to the `devices` table needs to be dropped temporarily to prepare `devices` for distribution.

## Move existing data in-use

At this point, `events` and `devices` are ready to be distributed. If you were starting with a new database and didn't have the data already loaded, you could use `create_distributed_table()`. However, since you have data already in use, you need to move the data using `create_distributed_table_concurrently()`.

`create_distributed_table_concurrently()` is a non-blocking function, which allows distributing the data while also allowing writes to the table.

Some things to note with this function:

- You can't use `create_distributed_table_concurrently()` in a transaction. This function can only be used for one table at a time.
- You can't use `create_distributed_table_concurrently()` when the table is referenced by a foreign key or references a local table. However, you can remove foreign key references and then reestablish them after distribution.
- Updates and deletes can fail during distribution if there isn't a primary key due to how the replication works.

You'll use `create_distributed_table_concurrently()` to distribute the `devices` and `events` tables.

## Truncate data on the coordinator

Before distribution, the data lives solely on the coordinator node. As part of data distribution, the data is copied to the worker nodes. This leaves the initial data on the coordinator node. Rather than leaving unused data behind, it's good practice to remove the unnecessary data by truncating it from the coordinator node. This can be done with the `truncate_local_data_after_distributing_table()` function.

Now that you have a plan for transitioning from a non-distributed environment to a distributed environment, you can apply this to the Wide World Importers sensors data.
