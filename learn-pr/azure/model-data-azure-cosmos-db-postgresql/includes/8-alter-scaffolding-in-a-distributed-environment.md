What if the Woodgrove Bank developers created their distributed database by starting with their relational design? Suppose this database was created in Azure Cosmos DB for PostgreSQL.

:::image type="complex" source="../media/normalized-database-entity-relationship-diagram.svg" alt-text="Diagram of the relationships between users, events, merchants, and event types.":::
   In the diagram, payment_events' event_type field is now event_type_id, with a foreign-key relationship to a new table named event_types. The event_types table contains the name and event_type_id, with the event_type_id as its primary key. The payment_events table also has a foreign-key relationship to a new table named payment_merchants. The payment_merchants table has merchant_id, name, and url. The merchant_id is the primary key for payment_merchants.
:::image-end:::

In a non-distributed environment, these relationships work. However, if the developers already loaded this structure in the database, there's some work needed for distributing tables. Data definition language (DDL) queries apply in a distributed environment, and there are functions to help update the distributed tables.

## Handle general DDL changes

In the distributed environment, DDL queries are cascaded across the worker nodes. From ALTER queries to DROP queries, Azure Cosmos DB for PostgreSQL supports most standard DDL used in PostgreSQL. When foreign constraints are supported, they're enforced on the DDL as well. In this example, Azure Cosmos DB for PostgreSQL won't drop the `event_types` table until the relationships with it are severed.

The relationship between `payment_events` and `payment_merchants` needs to be dissolved, because the relationship doesn't work for the distributed environment. `user_id` is the distribution column for `payment_events`, and it doesn't make sense to add the `user_id` column to the `payment_merchants` table. `payment_merchants` might make more sense as a reference table. If that's the case, this foreign-key relationship can be readded even after `payment_events` has been distributed.

Azure Cosmos DB for PostgreSQL will propagate these changes across the worker nodes for distributed tables. However, ALTER TABLE doesn't work with the distribution column. Distribution columns need to be maintained using helper functions. Running ALTER TABLE on a distribution column returns the following error:

```bash
ERROR: cannot execute ALTER TABLE command involving partition column
```

## Update the distribution column for a distributed table

At Woodgrove Bank, the developers were eager to make the primary key the distribution column on the `payment_events` table. However, in discussing the situation with you, they realize that they need to change the distribution column. The `user_id` column makes more sense as the distribution column so that the data can be colocated with the `payment_users` table.

You can use the [`alter_distributed_table()` function](/azure/postgresql/hyperscale/reference-functions#alter_distributed_table) to change the distribution column for a distributed table. For this purpose, this function takes two parameters: the name of the distributed table and the named parameter of `distribution_column`.

## Colocate tables

It makes sense to colocate related data when querying data. For example, because the users are frequently querying their events, it makes sense to colocate the `payment_events` and `payment_users` data by `user_id`. Azure Cosmos DB for PostgreSQL will implicitly colocate tables with distribution columns of the same datatype. This behavior can have performance issues and unintended colocation scenarios, so there are two things to note when setting colocation relationships:

* Colocation can be specified as part of distribution by calling the `create_distributed_table()` function with the `colocate_with` parameter.
* Colocation can be altered with the help of the `update_distributed_table_colocation()` function using the `colocate_with` parameter.

Suppose the developers distributed the `payment_merchants` table on `merchant_id` and forgot to specify the `colocate_with` when they distributed the table. Use `update_distributed_table_colocation()` to remove the colocation.  Here's an example query that removes a colocation:

```sql
SELECT update_distributed_table_colocation('payment_merchants',colocate_with=>'none');
```

## Convert from a distributed table to reference table

What if the `payment_merchants` table was colocated on `merchant_id`, and then the developers realized that it's actually a smaller table and better off as a reference table? Because the table can be converted to a reference table, the foreign key-relationship between `payment_events` and `payment_merchants` can also be recreated.

In order to change a table from a distributed table to a reference table, there are two things that have to happen:

1. Undistribute the table with the `undistribute_table()` function. This operation will move all of the data from the distributed nodes to the coordinator node. This operation will fail if there's no space on the coordinator node.

1. Change the table from a local table to a reference table, following the same pattern you used to create the `event_types` table.

Once you've converted the table, then you can add the foreign-key relationship to the `payment_events` table via ALTER TABLE.
