The Woodgrove Bank application trial went well, and now it's time to prepare the app for growth. Woodgrove Bank is expanding, adding a corporate office and branches throughout Europe. Their contactless payment app is about to see growth in the number of users and the locations. With a substantial growth in users, the number of transactions will grow exponentially. This growth is a case where it makes sense to distribute the data across multiple servers rather than put the burden of growth on a single server. Azure Cosmos DB for PostgreSQL can help cases when coming from a standalone PostgreSQL environment and needing to grow at scale.

## Initial standalone relational data schema

As the Woodgrove Bank development team needed a quick proof of concept, they trialed their payment application with a single, non-distributed PostgreSQL database. Prior to their trial, they initially had two tables:

* `payment_users`: Users using the application
* `payment_events`: User events such as GiftFunds, SendFunds, and RequestFunds

This diagram illustrates the initial database architecture:

:::image type="complex" source="../media/initial-database-entity-relationship-diagram.svg" alt-text="Diagram of the relationship between payment_users and payment_events.":::
   In the diagram, payment_users has four fields: user_id, url, sign-in, and avatar_url. user_id is the primary key on payment_users. payment_events has six fields: event_id, event_type, user_id, merchant_id, event_details, and created_at. event_id is the primary key on payment_events. payment_events has a foreign-key relationship to payment_users on the user_id field.
:::image-end:::

The Woodgrove Bank team realized they needed to normalize their data to store it in a relational database. They migrated their event types and merchants to their own tables. This diagram illustrates the normalized architecture:

:::image type="complex" source="../media/normalized-database-entity-relationship-diagram.svg" alt-text="Diagram of the relationships between users, events, merchants, and event types.":::
   In the diagram, payment_events' event_type field is now event_type_id, with a foreign key relationship to a new table named event_types. The event_types table contains the name and event_type_id, with the event_type_id as its primary key. The payment_events table also has a foreign key relationship to a new table named payment_merchants. The payment_merchants table has merchant_id, name, and url. The merchant_id is the primary key for payment_merchants.
:::image-end:::

This normalized data diagram is what they used for their trial. However, as Woodgrove Bank is growing and needs a distributed environment, the developers suspect that this data diagram will evolve. Before they can change their model, they need to understand what it means to distribute the data.

## Distributing data across multiple servers

Azure Cosmos DB for PostgreSQL operates as a group of individual PostgreSQL servers known as a _cluster_. The primary server—the _coordinator node_—manages the cluster and coordinates with the _worker nodes_ to distribute data and process queries as needed. Data is broken into [_shards_](/azure/postgresql/hyperscale/concepts-nodes#shards): partial tables of data, delineated by values in a [_distribution column_](/azure/postgresql/hyperscale/concepts-nodes#distribution-column).

With a small trial base, Woodgrove Bank's analysts initially queried their events by merchant to see if merchants were a driving factor for app usage. Suppose Woodgrove Bank decided to shard its events data by the merchant ID. The following diagram shows what the `payment_events` table would look like if sharded across multiple nodes based on `merchant_id`:

:::image type="content" source="../media/shards-illustrated.svg" alt-text="Diagram of an Azure Cosmos DB for PostgreSQL cluster with a coordinator node and two worker nodes. The worker nodes show separate pieces of data for the same table, grouped by their 'merchant_id' field.":::

The coordinator contains [metadata tables and views](/azure/postgresql/hyperscale/reference-metadata) to track shard placement. When a query comes into the cluster, the coordinator node reviews the query, and uses the metadata tables and views to identify which worker nodes to engage. The worker nodes query their respective shards and return the results to the coordinator. The coordinator returns the collected results.

:::image type="content" source="../media/distributed-query-processing.svg" alt-text="Diagram of SQL query processing in the Azure Cosmos DB for PostgreSQL environment. The SQL query enters a cluster via the coordinator node. The coordinator node directs the query to the required worker nodes.":::

By splitting the data across nodes and distributing on a frequently used column, you gain performance by only engaging the worker nodes needed rather than engaging the entire dataset. For Woodgrove Bank, the query `SELECT * FROM payment_events WHERE merchant_id = '49605596';` would only engage one worker node: the node with that particular `merchant_id` value. The coordinator node knows which worker nodes to engage based on the shard placement, and only the engaged worker nodes process the query. The query is only querying the data that is needed, rather than the entire set of `payment_events` data.

Woodgrove Bank's analysis showed that the merchant wasn't the driving force for their application. If the data is already sharded by merchant ID and the query looks at user ID that has performance implications. For example, if the query is `SELECT * FROM payment_events WHERE user_id = '1894';`, the coordinator node would need to engage all the worker nodes and wait for all of them to return. Choosing a distribution column—also known as a _shard key_—is crucial as it can make or break performance.

Before choosing a distribution column, it's important to be aware of how the tables and relationships from a standalone PostgreSQL translate to a distributed environment. There are many things to consider when migrating from a standalone environment to a distributed environment:

* **Data usage**: Related data stored together leads to better performance.
* **Data distribution**: Queries perform best with balanced data in a distributed environment.
* **Data relationships**: Tables related in a non-distributed environment may lose their relationships in a distributed environment due to enforcement constraints.

## Classify relational tables for distribution

There are three types of tables that you can create in Azure Cosmos DB for PostgreSQL:

* Local tables
* Reference tables
* Distributed tables

Each of these tables starts on the coordinator node and are created using the regular PostgreSQL CREATE TABLE syntax.

### Local tables

[_Local tables_](/azure/postgresql/hyperscale/concepts-nodes#type-3-local-tables) are tables of data that might be related to the application that consumes the data in the database. Local tables live solely on the coordinator node. An example of a local table could be a user-authentication table. All tables start as local tables until they're distributed.

### Reference tables

[_Reference tables_](/azure/postgresql/hyperscale/concepts-nodes#type-2-reference-tables) are smaller tables of data replicated across each of the worker nodes that are frequently linked to the distributed tables. As the reference table lives in duplicate on each worker node, a worker node can access the data of a reference table without needing to access extra records from another worker node. The `event_types` table contains 11 records of the types of the events supported in the system, so it's a smaller table and good candidate to be a reference table.

A reference table is created by the `create_reference_table()` function. This query will convert the `event_types` table from a local table to a reference table:

```sql
SELECT create_reference_table('event_types');
```

You can join reference tables with local tables. You can also join them with distributed tables.

### Distributed tables

[_Distributed tables_](/azure/postgresql/hyperscale/concepts-nodes#type-1-distributed-tables) are large tables of data that are broken up into smaller chunks known as [_shards_](/azure/postgresql/hyperscale/concepts-nodes#shards). The tables are sharded—or distributed—by a field known as the **distribution column**. Examples of distributed tables for the Woodgrove Bank app are the `payment_users` and `payment_events` tables.

You can join distributed tables with reference tables. However, you can't join distributed tables with local tables.

### Table storage

The three different types of tables are stored differently across the nodes.

* A local table is stored on the coordinator node.
* A reference table is stored in a shard on each worker node, with all of its data duplicated and kept in-sync across each of the nodes.
* A distributed table is sharded over the worker nodes.

The following diagram shows this breakdown:

:::image type="content" source="../media/coordinator-workers-arrows-tables.svg" alt-text="Diagram of the Coordinator node as a PostgreSQL database with metadata tables and a local table. The diagram also contains two worker nodes, each with distributed shards and a reference table. There are arrows coming from the coordinator and pointed at each of the worker nodes.":::

### Reference table versus distributed table

It might be unclear whether a table should be a reference table or a distributed table. Here are some questions to help you make that determination:

* How much data is on this table? How much growth is anticipated?
* How often is the data used in queries with distributed tables?
* What are the performance implications if this data were duplicated across worker nodes?
* Does the data need to be duplicated or sharded?

If the data is joined with distributed tables and is a smaller amount of data that can be duplicated across worker nodes, then the data could be a good candidate for a reference table. If the data is a larger amount of data where duplication of that data hurts performance, then the table might be a better candidate as a distributed table.

For Woodgrove Bank, should the `payment_merchants` table be a reference table or a distributed table? The developers initially thought that the number of merchants would grow significantly and wondered if it would be a good case as a distributed table. However, talking through the growth of the tables:

* There will be more users than merchants. A merchant can have numerous payment events for a single user. A merchant can have many users as customers.
* Merchants will grow, but not at the rate of users or transactions.
* The merchants list will be relatively small compared to users and events.
* The merchants list isn't anticipated to grow at a rate where duplication would hurt performance.

The `payment_merchants` table makes sense to be a reference table. So for the Woodgrove Bank tables, they've settled on the following design:

* `payment_merchants` is a reference table.
* `event_types` is a reference table.
* `payment_events` is a distributed table.
* `payment_users` is a distributed table.

Now that the table types are identified, let's create those tables in Azure Cosmos DB for PostgreSQL.
