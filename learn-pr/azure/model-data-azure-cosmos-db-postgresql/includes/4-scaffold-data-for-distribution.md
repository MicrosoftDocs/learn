Understanding the high level of distributed query processing and recognizing the different table types aren't enough for moving from a single environment to a distributed environment. It's also important to understand how data is distributed by a column and how tables can be located together based on their distribution columns. For Woodgrove Bank, this characteristic means distributing their events, event types, merchants, and user data in a way that enables efficient querying at scale.

## Choose a distribution column

In moving from a single relational server to a distributed environment, you'll need to reevaluate relationships and identify how the tables and columns are used in queries. The primary key of a table in a standalone server may no longer make sense as the primary key in a distributed environment. For a primary key to be enforced in the Azure Cosmos DB for PostgreSQL environment, that key must be part of the distribution column. These considerations should be reviewed when choosing a distribution column.

1. The column should be a central piece to the application. Examples include `device_id` in IoT workloads, `store_id` in eCommerce analytics, and `tenant_id` in multi-tenant applications.
1. The column's values should be varied with a high cardinality and a balanced statistical distribution.
1. The column should appear in the most common queries to allow parallelization of those queries.
1. If there are tables that are commonly queried together, they can benefit from [_colocation_](/azure/postgresql/hyperscale/concepts-colocation). Colocation means that all data with the same distribution column value is stored on the same node.

For the Woodgrove Bank application, `user_id` makes sense as the distribution column for the `payment_users` table, because it's central to the application and appears in most queries.

Distributed tables are created with the `create_distributed_table()` function, which takes at least two parameters: the name of the table to distribute and its distribution column. For the Woodgrove Bank `payment_users` table, this query will distribute the users table on its `user_id` column.

```sql
SELECT create_distributed_table('payment_users','user_id');
```

However, for the Woodgrove application, the choice of distribution column on the `payment_events` table is unclear. While the event identity column made sense as a primary key in the non-distributed environment, the `event_id` column doesn't account for its relationship with `payment_users`. The `user_id` column could be a good candidate as a distribution column as the user's details and events could be colocated by the shared `user_id` column. If the `payment_merchants` table was distributed, the `merchant_id` column might be another good candidate for the distribution column on `payment_events` as the merchant's details, and events could be colocated by the shared `merchant_id` column. In this case, the deciding factor on the distribution column will be understanding how the data is queried and identifying which scenarios could benefit more from colocation.

## Decide on colocation

Consider this event data for `user_id` 1894. When the events are distributed by `user_id`, these details are stored on the same node:

:::image type="content" source="../media/events-distributed-user-id.svg" alt-text="Diagram of event data sharded on user_id. All the data for a user_id value is stored in a shard on a worker node.":::

If this data were sharded by `merchant_id`, the data would be split like this:

:::image type="complex" source="../media/events-distributed-merchant-id.svg" alt-text="Diagram of event data sharded on merchant_id.":::
   All the data for a merchant_id value is stored in a shard on a worker node. Because user_id 1894 worked with multiple merchants, their event data is split on separate worker nodes when the event data is sharded by merchant_id.
:::image-end:::

Querying for events for `user_id` 1894 with `payment_events` distributed on `merchant_id` means that all shards would need to be queried for data where `user_id` is set to 1894. While this example is only two shards, know that the performance pain scales as more shards are involved.

Because this data will be heavily queried with a focus on the users, `payment_events` will be sharded by the `user_id`.

### Woodgrove Bank's colocation considerations

Regarding the `payment_events` table, colocation is a consideration. What does colocation mean from a meaningful data perspective?

Suppose you need to see all events for a user in a dashboard and include the number of events for the user. By distributing `payment_events` by `user_id`, the data is already broken up in a way that the worker nodes can process the users in parallel and pass the results directly to the coordinator node.

However, if you need to see all events for a merchant and the `payment_events` is distributed by `user_id`, those queries are slower, because there isn't a guarantee that the data will be grouped on a single node. Each shard on each node needs to be queried in order to find the records for a specific `merchant_id`.

The key thing to understand with colocation is that rows with the same values for their distribution columns will be stored together on the same worker node. Azure Cosmos DB for PostgreSQL hashes the distribution values and uses those hashes for [shard placement](/azure/postgresql/hyperscale/concepts-nodes#shards) and [colocation](/azure/postgresql/hyperscale/concepts-colocation).

Because the Woodgrove Bank application is querying on the user basis, the `payment_events` table can also distribute by `user_id`.

```sql
SELECT create_distributed_table('payment_events','user_id');
```

With the events and users tables having distribution columns of the same data type, Azure Cosmos DB for PostgreSQL will implicitly colocate their data. That means the events and user details for a single user ID will be stored on the same node.

Consider this event data for `user_id` 1894 and 85147. When the `events` and the `users` tables are colocated and distributed on `user_id`, these details are stored on the same node:

:::image type="content" source="../media/colocated-distribution.svg" alt-text="Diagram of two worker nodes. Each worker node shows an event shard and a user shard where the user_id matches on both the event and user records.":::

### Trouble with implicit colocation

Azure Cosmos DB for PostgreSQL does implicit colocation. Implicit colocation means that unless you specify colocation details when distributing the table, the system will automatically colocate with distribution columns of the same datatype. This characteristic is a problem, because not all columns of the same datatype represent the same entity. With Woodgrove Bank's situation, events and users are distributed on the same column. However, suppose the merchants were stored on a distributed table and were distributed on merchant ID.

The following screenshot shows what happens when the `colocate_with` parameter is omitted while distributing `payment_events` and `payment_users` on `user_id` and distributing `payment_merchants` on `merchant_id`. All three tables are colocated in the same colocation group, as seen in the `colocation_id` on `citus_tables`.

:::image type="content" source="../media/colocation-concerns.png" alt-text="Screenshot of the query of the citus_tables, highlighting colocation ID. payment_events and payment_users are distributed on user_id. payment_merchants is distributed by merchant_id. All of these tables are colocated due to not specifying colocate_with on distribution.":::

By colocating merchants on `merchant_id` with the users and events tables distributed on `user_id`, the data would be stored like this:

:::image type="content" source="../media/problem-implicit-colocation.svg" alt-text="Diagram of two worker nodes. Each worker node shows an event shard, a user shard, and a merchant shard where their distribution columns match on value.":::

This distribution is concerning, because the `merchant_id` and `user_id` fields don't represent the same entities. Be specific about colocation when distributing tables.

If you distribute the `payment_merchants` table, colocation would have to be explicitly called out with `colocate_with => 'none'`, because the merchants table's distribution column `merchant_id` doesn't represent the same entity as the distribution columns for users and events: `user_id`.

`colocate_with` is a named parameter for `create_distributed_table()`. To distribute the `payment_merchants` table, use the following SQL:

```sql
SELECT create_distributed_table('payment_merchants','merchant_id',colocate_with=>'none');
```

Using `colocate_with=>'none'` explicitly tells Azure Cosmos DB for PostgreSQL to not colocate merchants with users and events.

## Foreign-key implications in a distributed environment

Foreign-key constraints in a standalone application make sense. However, in this distributed environment, foreign-key enforcement is tricky. Here are some example cases where foreign keys will work in Azure Cosmos DB for PostgreSQL:

* Between two local tables
* Between two reference tables
* Between reference tables and local tables
* Between two colocated distributed tables with a shared key
* From a distributed table to a reference table

However, foreign keys _aren't_ supported from reference tables to distributed tables.

In order for foreign keys to be enforced, the referencing and referenced rows need to be stored on the same node.

Foreign keys that involve sharded data must include the distribution column. The distribution column must also be included in primary keys and UNIQUE constraints. This requirement means that going from a standalone relational system to a distributed relational system may require updating constraints from simple keys to composite keys.

For Woodgrove Bank, here are some changes you'll need to make:

* In order to keep the foreign key on the events table to the users table, the `user_id` needs to be the distribution column for both tables.
* The foreign-key relationship between events and event types works because it's going from a distributed table to a reference table. Keep in mind that reference tables don't have distribution columns.
* If the merchants table is distributed because the `user_id` isn't part of the merchants table, the foreign-key relationship between events and merchants disappears.
* However, the developers may realize that their merchants table is a smaller table and decided to make it a reference table. Then, the foreign-key relationship can stay, as that would be a relationship between a distributed table and a reference table.

## Compare from a single ERD to a distributed ERD

The Woodgrove Bank application's database in a non-distributed environment looked like this:

:::image type="complex" source="../media/normalized-database-entity-relationship-diagram.svg" alt-text="Diagram of the relationships between users, events, merchants, and event types.":::
   In the diagram, payment_events' event_type field is now event_type_id, with a foreign key relationship to a new table named event_types. The event_types table contains the name and event_type_id, with the event_type_id as its primary key. The payment_events table also has a foreign-key relationship to a new table named payment_merchants. The payment_merchants table has merchant_id, name, and url. The merchant_id is the primary key for payment_merchants.
:::image-end:::

In terms of the relational diagram with distribution considerations, this diagram represents the final application for Woodgrove Bank:

:::image type="complex" source="../media/distributed-entity-relationship-diagram.svg" alt-text="Diagram of distributed relationships between users, events, event types, and merchants.":::
   In the diagram, payment_events has a column event_type_id, with a foreign key relationship to the event_types table. The event_types table contains the name and event_type_id, with the event_type_id as its primary key. The event_types table is a reference table. The payment_merchants table has merchant_id, name, and url. The merchant_id is the distribution column for payment_merchants. The payment_users distributed table uses user_id as its distribution column and has a foreign key relationship to the payment_events table.
:::image-end:::
