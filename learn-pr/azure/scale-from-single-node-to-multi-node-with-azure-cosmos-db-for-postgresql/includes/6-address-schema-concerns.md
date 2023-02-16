The Wide World Importers sensors data now has multiple worker nodes to handle the parallel processing of a query. The next step is to distribute the tables. However, before you can distribute the tables, you need to understand the available table types and how distribution impacts the key relationships.

## Table classification

There are three types of tables that can be created in Azure Cosmos DB for PostgreSQL:

- local tables
- reference tables
- distributed tables

Each of these tables starts on the coordinator node and is created using the regular PostgreSQL CREATE TABLE syntax.

### Local tables

[**Local tables**](https://learn.microsoft.com/azure/cosmos-db/postgresql/concepts-nodes#type-3-local-tables) are tables of data that may be related to the application that consumes the data in the database. Local tables live solely on the coordinator node. An example of a local table could be a user authentication table. All tables start as local tables until they are distributed.

### Reference tables

[**Reference tables**](https://learn.microsoft.com/azure/cosmos-db/postgresql/concepts-nodes#type-2-reference-tables) are smaller tables of data replicated across each of the worker nodes that are frequently linked to the distributed tables. As the reference table lives in duplicate on each worker node, a worker node can access the data of a reference table without needing to access additional records from another worker node. The `device_types` table contains a few records of the types of devices supported in the system, so it is a smaller table and a good candidate to be a reference table.

A reference table is created by the `create_reference_table()` function. This query will convert the `device_types` table from a local table to a reference table:

```sql
SELECT create_reference_table('device_types');
```

Reference tables can be joined with local tables. They can also be joined with distributed tables.

### Distributed tables

[**Distributed tables**](https://learn.microsoft.com/azure/cosmos-db/postgresql/concepts-nodes#type-1-distributed-tables) are large tables of data that are broken up into [shards](https://learn.microsoft.com/azure/cosmos-db/postgresql/concepts-nodes#shards). The tables are sharded - or distributed - by a field known as the **distribution column**. Examples of distributed tables for the Wide World Importers app are the `devices` and `events` tables.

When two tables are distributed on the same field, it'd make sense to store shards with the same field value together and take advantage of [colocation](https://learn.microsoft.com/azure/cosmos-db/postgresql/concepts-colocation). Colocation means that all data with the same distribution column value is stored on the same node.

Suppose the `devices` and `events` tables are distributed on `device_id`. Since the tables are distributed by the same column, colocating them makes sense. This means that the device entry for `device97` would be stored on the same node as the sensors readings for `device97`. When a query is run specifically for `device97`, only the node that has that information will be engaged. The query won't have to be processed by separate nodes for the `devices` and `events` table due to colocation.

Distributed tables can be joined with reference tables. However, distributed tables can't be joined with local tables.

### Storage of the tables

The three different types of tables are stored differently across the nodes.

- A local table is stored on the coordinator node.
- A reference table is stored in a shard on each node that hosts shards, with all of its data duplicated and kept in sync across each of the nodes.
- A distributed table is distributed across the nodes that host shards.

When storing tables, the coordinator node can host the reference and distributed shards if you are starting out with a single-node configuration and upgrading to a multi-node configuration. Otherwise, the worker nodes are the only nodes that host the reference and distributed shards.

The diagram below shows this breakdown.

![Diagram of the Coordinator node as a PostgreSQL database with metadata tables and a local table. The diagram also contains 3 worker nodes, each with distributed shards and a reference table. Arrows are coming from the coordinator and point at each of the worker nodes.](../media/coordinator-workers-with-arrows-with-tables.png)

### Reference table versus distributed table

It might be unclear whether a table should be a reference table or a distributed table. These are some things to think about.

- How much data is on this table? How much growth is anticipated?
- How often is the data used in queries with distributed tables?
- What are the performance implications if this data were duplicated across worker nodes?
- Does the data need to be duplicated or distributed?

If the data is joined with distributed tables and is a smaller amount of data that can be duplicated across worker nodes, then the data could be a good candidate for a reference table. If the data is a larger amount of data where duplication of that data hurts performance, then the table may be a better candidate as a distributed table.

For Wide World Importers, should the `devices` table be a reference table or a distributed table? The developers initially thought that the number of devices would be manageable as a reference table. However, talking through the growth of the data:

- The number of devices could grow significantly if other locations see the potential. This growth needs to be considered.
- If it is a slow, small growth, it may make sense to keep devices as a reference table.
- However, if the growth is exponential or at a rate where query performance is impacted, then it may make more sense to classify `devices` as a distributed table.

So for the Wide World Importer tables, they have settled on the following:

- `device_types` is a reference table.
- `devices` is a distributed table.
- `events` is a distributed table.

Now that the table types are identified, you can create those tables in Azure Cosmos DB for PostgreSQL. Before you can create distributed tables, you need to understand the impact on the foreign key relationships as well as determine the columns to distribute the data on.

## Foreign key and other constraint implications in a distributed environment

There are relationships and constraints in a non-distributed environment that don't translate over to a distributed environment. These are some things to keep in mind.

### Foreign key implications

In this distributed environment, foreign key enforcement is tricky. These are the cases where foreign keys will work in Azure Cosmos DB for PostgreSQL:

- Between two local tables
- Between two reference tables
- Between reference tables and local tables
- Between two colocated distributed tables with a shared key
- From a distributed table to a reference table

The cases where foreign keys aren't supported are:

- From reference tables to distributed tables
- From local tables to distributed tables

For foreign keys to be enforced, the referencing and referenced rows need to be stored on the same node.

Foreign keys that involve distributed data must include the distribution column. The distribution column must also be included in primary keys and UNIQUE constraints. This means that going from a standalone relational system to a distributed relational system may require updating constraints from simple keys to composite keys.

For Wide World Importers, this means that:

- The foreign key relationship between the `devices` table and the `device_types` table works because it is going from a distributed table to a reference table. Keep in mind that reference tables don't have distribution columns.
- If the `events` table is distributed by `event_id`, the foreign key relationship between the `events` table and the `devices` table will no longer be possible. The distribution column needs to be included as part of the foreign key. Since the `devices` table doesn't contain the `event_id` column, then the foreign key can't be created.
- However, if the developers realize that their devices table is a smaller table and make it a reference table, then the foreign key relationship can stay, as that'd be a relationship between a distributed table and a reference table.
- To keep the foreign key on the events table to the devices table with both tables, the `device_id` needs to be the distribution column for both tables. This would colocate the tables and allow for the enforcement of the foreign key relationship.

### Identity implications

If you're coming from a relational database with identity fields, those fields won't work in a distributed environment. Drop the identity constraints before distribution.

An alternative to identity fields that is supported by Citus is [the serial data type](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).

## Choose a distribution column

In moving from a non-distributed to a distributed environment, you need to reevaluate relationships and identify how the tables and columns are used in queries. The primary key of a table in a standalone server may no longer make sense as the primary key in a distributed environment. For a primary key to be enforced in the Azure Cosmos DB for PostgreSQL environment, that key must be part of the distribution column. These are some considerations for choosing a distribution column.

1. The column should be a central piece of the application. Examples include `device_id` in IoT workloads, `store_id` in eCommerce analytics, and `tenant_id` in multi-tenant applications.
2. The column's values should be varied with high cardinality and a balanced statistical distribution. This means the column should have many possible values and the amount of data with that value should be evenly distributed through the data set.
3. The column should appear in the most common queries to allow parallelization of those queries.
4. If there are tables that are commonly queried together, they can benefit from colocation.

For the Wide World Importers sensors data, `device_id` makes sense as the distribution column for the `devices` table because it is central to the application and appears in most queries.

Distributed tables are created with the `create_distributed_table()` function, which takes at least two parameters - the name of the table to distribute and its distribution column. For the Wide World Importers `devices` table, this query will distribute the devices table on its `device_id` column.

```sql
SELECT create_distributed_table('devices','device_id');
```

When data already exists and is in use, you can distribute the data while allowing for normal database usage by using `create_distributed_table_concurrently()`. This takes the same parameters as `create_distributed_table()`.

For the Wide World Importers sensors data, the choice of distribution column on the `events` table was initially unclear. While the event identity column made sense as a primary key in the non-distributed environment, the `event_id` column doesn't account for its relationship with `devices`. The `device_id` column could be a good candidate as a distribution column as the device's details and events could be colocated by the shared `device_id` column. In this case, the deciding factors on the distribution column are query patterns, data relationships, and identifying which scenarios could benefit more from colocation.

## Change schema from non-distributed to distributed

This is the non-distributed layout.

- `device_types` has a `device_type_id` field and a `name` field. `device_type_id` is its primary key.
- `devices` has three fields - `device_id`, `device_type_id`, and `name`. The `device_id` field is the primary key. There is a foreign key relationship on the `device_type_id` field that references the `device_type_id` field on the `device_types` table.
- `events` has three fields - `event_id`, `device_id`, and `payload`. The `event_id` is its primary key. There is a foreign key relation on the `device_id` that references the `device_id` field on the `devices` table.

![Diagram of the relationships between device types, devices, and events. The device_types table has two fields - device_type_id and name. device_type_id is its primary key. The devices table has three fields - device_id, device_type_id, and name. device_id is its primary key. The devices table has a foreign key relationship on device_type_id that references the device_type_id field on the device_types table. The events table has three fields - event_id, device_id, and payload. event_id is its primary key. The events table has a foreign key relationship on its device_id that references the device_id field on the devices table.](../media/normalized-database-erd.png)

To go to a distributed layout, some things need to happen.

- The `device_types` table needs to become a reference table.
- The primary key on the `events` table needs to be dropped and recreated as a composite key of `device_id` and `event_id`.
- The foreign key between `events` and `devices` needs to be dropped for distribution.
- The `devices` table needs to be distributed on its `device_id` column.
- The `events` table needs to be distributed on its `device_id` column.
- The foreign key needs reestablished on the `events` table.
- The local data needs truncated from the coordinator node.

While this is the plan, the order of distributing the data matters. Since the plan is to move from a non-distributed environment to a distributed environment with data already in place, this move needs to happen with minimal disruption to the existing data. Next, you'll look at the concerns on the order of distribution.
