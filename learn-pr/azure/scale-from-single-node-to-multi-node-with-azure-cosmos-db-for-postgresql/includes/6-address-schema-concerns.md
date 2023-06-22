The Wide World Importers sensor data now has multiple worker nodes to handle parallel processing for queries. The next step is to distribute the tables. However, before you can distribute the tables, you need to understand the available table types and how distribution affects the table key relationships.

## Table classification

You can create three types of tables in Azure Cosmos DB for PostgreSQL:

- Local tables
- Reference tables
- Distributed tables

Each of these tables starts on the coordinator node. You create the tables by using the regular PostgreSQL `CREATE TABLE` syntax.

### Local tables

*Local tables* are tables of data that might be related to the application that consumes the data in the database. Local tables live solely on the coordinator node. An example of a local table could be a user authentication table. All tables start as local tables until they're distributed.

For more information, see [Local tables](/azure/cosmos-db/postgresql/concepts-nodes#type-3-local-tables).

### Reference tables

*Reference tables* are smaller tables of data that are replicated across each of the worker nodes that are frequently linked to the distributed tables. Because the reference table is located in duplicate on each worker node, a worker node can access the data of a reference table without needing to access records from another worker node. The `device_types` table contains a few records of the types of devices that are supported in the system, so it's a smaller table and a good candidate to be a reference table.

A reference table is created by the `create_reference_table()` function. This query converts the `device_types` table from a local table to a reference table:

```sql
SELECT create_reference_table('device_types');
```

Reference tables can be joined with local tables. They can also be joined with distributed tables.

For more information, see [Reference tables](/azure/cosmos-db/postgresql/concepts-nodes#type-2-reference-tables).

### Distributed tables

*Distributed tables* are large tables of data that are broken up into [shards](/azure/cosmos-db/postgresql/concepts-nodes#shards). The tables are sharded (that is, distributed) based on a field that's called the *distribution column*. Examples of distributed tables for the Wide World Importers app are the `devices` and `events` tables.

When two tables are distributed on the same field, it would make sense to store shards that have the same field value together and take advantage of [colocation](/azure/cosmos-db/postgresql/concepts-colocation). Colocation means that all data that has the same distribution column value is stored on the same node.

Suppose the `devices` and `events` tables are distributed based on `device_id`. Because the tables are distributed by the same column, colocating them makes sense. The device entry for `device97` would be stored on the same node as the sensors readings for `device97`. When a query is run specifically for `device97`, only the node that has that information is engaged. The query doesn't need to be processed by separate nodes for the `devices` and `events` table due to colocation.

Distributed tables can be joined with reference tables. However, distributed tables can't be joined with local tables.

For more information, see [Distributed tables](/azure/cosmos-db/postgresql/concepts-nodes#type-1-distributed-tables).

### Storing the tables

The three different types of tables are stored differently across the nodes.

- A *local table* is stored on the coordinator node.
- A *reference table* is stored in a shard on each node that hosts shards, with all of its data duplicated and kept in sync across each of the nodes.
- A *distributed table* is distributed across the nodes that host shards.

When you store tables, the coordinator node can host the reference and distributed shards if you start with a single-node configuration and upgrade to a multi-node configuration. Otherwise, the worker nodes are the only nodes that host the reference and distributed shards.

The following figure shows this breakdown:

:::image type="content" source="../media/coordinator-workers-with-arrows-with-tables.png" border="false" alt-text="Diagram that shows the coordinator node as a PostgreSQL database with metadata tables and a local table. Arrows indicate the flow of data.":::

### Reference table vs. distributed table

It might be unclear whether a table should be a reference table or a distributed table. Consider these factors:

- How much data is on this table? How much growth is anticipated?
- How often is the data used in queries with distributed tables?
- What are the performance implications if this data were duplicated across worker nodes?
- Does the data need to be duplicated or distributed?

If the data is joined with distributed tables and is a smaller amount of data that can be duplicated across worker nodes, then the data could be a good candidate for a reference table. If the data is a larger amount of data where duplication of that data hurts performance, then the table might be a better candidate for a distributed table.

For Wide World Importers, should the `devices` table be a reference table or a distributed table? The developers initially thought that the number of devices would be manageable as a reference table. However, talking through the growth of the data, the team considers these factors:

- The number of devices might grow significantly if other locations see the potential. This growth needs to be considered.
- If it's a slow, small growth, it might make sense to keep `devices` as a reference table.
- However, if the growth is exponential or at a rate that affects query performance, then it might make more sense to classify `devices` as a distributed table.

So for the Wide World Importer tables, the developer team settles on these tables:

- `device_types` is a reference table
- `devices` is a distributed table
- `events` is a distributed table

Now that the table types are identified, you can create those tables in Azure Cosmos DB for PostgreSQL. But before you do create distributed tables, you need to understand the impact on the foreign key relationships and determine the columns to use to distribute the data.

## Foreign key and other constraint implications in a distributed environment

There are relationships and constraints in a nondistributed environment that don't translate over to a distributed environment. Consider the factors that are described in the following sections.

### Foreign key implications

In this distributed environment, foreign key enforcement is tricky. Foreign keys work in Azure Cosmos DB for PostgreSQL in the following scenarios:

- Between two local tables
- Between two reference tables
- Between reference tables and local tables
- Between two colocated distributed tables with a shared key
- From a distributed table to a reference table

Foreign keys *aren't* supported in these scenarios:

- From reference tables to distributed tables
- From local tables to distributed tables

For foreign keys to be enforced, the referencing and referenced rows need to be stored on the same node.

Foreign keys that involve distributed data must include the distribution column. The distribution column must also be included in primary keys and UNIQUE constraints. Going from a standalone relational system to a distributed relational system might require updating constraints from simple keys to composite keys.

Wide World Importers needs to consider these factors:

- The foreign key relationship between the `devices` table and the `device_types` table works because it's going from a distributed table to a reference table. Keep in mind that reference tables don't have distribution columns.
- If the `events` table is distributed by `event_id`, the foreign key relationship between the `events` table and the `devices` table will no longer be possible. The distribution column needs to be included as part of the foreign key. Because the `devices` table doesn't contain the `event_id` column, then the foreign key can't be created.
- However, if the developers realize that their `devices` table is a smaller table, and they make it a reference table, then the foreign key relationship can stay because that would be a relationship between a distributed table and a reference table.
- To keep the foreign key on the `events` table to the `devices` table with both tables, the `device_id` needs to be the distribution column for both tables. This would colocate the tables and allow for the enforcement of the foreign key relationship.

### Identity implications

If you're coming from a relational database with identity fields, those fields won't work in a distributed environment. Drop the identity constraints before distribution.

An alternative to using identity fields that is supported by Citus is [the serial data type](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).

## Choose a distribution column

In moving from a nondistributed to a distributed environment, you need to reevaluate relationships and identify how the tables and columns are used in queries. The primary key of a table in a standalone server may no longer make sense as the primary key in a distributed environment. For a primary key to be enforced in the Azure Cosmos DB for PostgreSQL environment, that key must be part of the distribution column.

Here are some considerations for choosing a distribution column:

1. The column should be a central piece of the application. Examples include `device_id` in IoT workloads, `store_id` in eCommerce analytics, and `tenant_id` in Because applications.
1. The column's values should be varied with high cardinality and a balanced statistical distribution. The column should have many possible values and the amount of data with that value should be evenly distributed through the data set.
1. The column should appear in the most common queries to allow parallelization of those queries.
1. If there are tables that are commonly queried together, they can benefit from colocation.

For the Wide World Importers sensors data, `device_id` makes sense as the distribution column for the `devices` table because it's central to the application and appears in most queries.

Distributed tables are created with the `create_distributed_table()` function, which takes at least two parameters - the name of the table to distribute and its distribution column. For the Wide World Importers `devices` table, this query distributes the devices table on its `device_id` column.

```sql
SELECT create_distributed_table('devices','device_id');
```

When data already exists and is in use, you can distribute the data while allowing for normal database usage by using `create_distributed_table_concurrently()`. It takes the same parameters as `create_distributed_table()`.

For the Wide World Importers sensors data, the choice of distribution column on the `events` table was initially unclear. Although the event identity column made sense as a primary key in the nondistributed environment, the `event_id` column doesn't account for its relationship with `devices`. The `device_id` column could be a good candidate as a distribution column as the device's details and events could be colocated by the shared `device_id` column. In this case, the deciding factors on the distribution column are query patterns, data relationships, and identifying which scenarios could benefit more from colocation.

## Change schema from nondistributed to distributed

The nondistributed layout has the following characteristics:

- The `device_types` table has two fields: `device_type_id` and `name`.

   The `device_types` table primary key is `device_type_id`.

- The `devices` table has three fields: `device_id`, `device_type_id`, and `name`.

   The `devices` table primary key is `device_id`.

   A foreign key relationship on the `device_type_id` field references the `device_type_id` field on the `device_types` table.
- The `events` has four fields: `event_id`, `device_id`, `payload`, and `created_at`.

   The `events` table primary key is `event_id`.
  
   A foreign key relationship on the `device_id` field references the `device_id` field on the `devices` table.

:::image type="content" source="../media/normalized-database-erd.png" border="false" alt-text="Diagram that shows the relationships between three tables, and the columns and primary keys in each table.":::

To switch to a distributed layout, the following events must occur:

- The `device_types` table needs to become a reference table.
- The primary key on the `events` table needs to be dropped and re-created as a composite key of `device_id` and `event_id`.
- The foreign key between `events` and `devices` needs to be dropped for distribution.
- The `devices` table needs to be distributed on its `device_id` column.
- The `events` table needs to be distributed on its `device_id` column.
- The foreign key needs to be reestablished on the `events` table.
- The local data needs to be truncated from the coordinator node.

Although the steps that must occur are set, the order of distributing the data matters. Because the plan is to move from a nondistributed environment to a distributed environment with data already in place, this move needs to happen with minimal disruption to the existing data. Next, you look at the concerns on the order of distribution.
