Azure Database for PostgreSQL - Hyperscale (Citus) is now [Azure Cosmos DB for PostgreSQL](../../../paths/azure-cosmos-db-for-postgresql/index.yml)!

[Azure Cosmos DB for PostgreSQL](/azure/postgresql/hyperscale/overview) is a fully managed database-as-a-service hosted on Azure that delivers the full functionality of PostgreSQL combined with the ability to distribute data across multiple servers in a cluster. It's a robust database with a wide range of built-in features. However, sometimes additional capabilities are required to solve complex real-world problems. Azure Cosmos DB for PostgreSQL inherits many of its capabilities from the service formally called Azure Database for PostgreSQL - Hyperscale (Citus).

You can extend the functionality of databases using [PostgreSQL extensions](/azure/postgresql/hyperscale/reference-extensions). PostgreSQL extensions are packages of related SQL objects that function like built-in native features, allowing you to add new capabilities to your database.

In fact, the distributed capabilities of Azure Cosmos DB for PostgreSQL are made possible through the [Citus extension](https://github.com/citusdata/citus). Other examples of extensions are [`pg_cron`](https://github.com/citusdata/pg_cron), a cron-based job scheduler that allows you to schedule PostgreSQL commands directly from the database and [PostGIS](https://postgis.net/) that adds support for geographic objects, allowing location queries to be run in SQL.

![Diagram showing three of the extensions you will use in this learning module, Citus, PostGIS, and pg_cron, being added to Azure Cosmos DB for PostgreSQL and used to extend the functionality of the database.](../media/3a-cosmos-db-for-postgresql-extensions.png)

In the [Extend functionality using extensions](../../extend-the-functionality-of-azure-cosmos-db-for-postgresql-using-extensions/1-introduction.yml) module, you'll explore how extensions can be used to improve the productivity of Azure Cosmos DB for PostgreSQL. You'll examine the Citus extension and how it enables data distribution and investigate other supported extensions and the capabilities they can provide to improve the overall effectiveness of a database.

## What are PostgreSQL extensions?

In PostgreSQL, an _extension_ is a package that bundles multiple related SQL objects to provide new data types, better monitoring, foreign data wrappers, advanced security capabilities, and even new languages for writing stored procedures. [Packaging related objects together](https://www.postgresql.org/docs/current/extend-extensions.html) in this manner can significantly simplify database management.

The main advantage of using an extension, rather than just running a SQL script to load a bunch of "uncoupled" objects into your database, is that PostgreSQL understands that the objects included in the extension go together. The SQL objects contained within the extension package can be loaded or removed from your database with a single command. After being loaded into the database, extensions can function like built-in features allowing you to use the capabilities like native PostgreSQL functionality.

## What is Citus?

Citus provides the primary performance and scalability features of Azure Cosmos DB for PostgreSQL, so in this unit, you examine the extension and its capabilities to understand better how it will help Woodgrove Bank achieve its performance and scalability goals.

[Citus](https://github.com/citusdata/citus) is an open-source extension for PostgreSQL that was created to allow data storage and computing capabilities to scale across a cluster of PostgreSQL servers without sacrificing traditional relational database functionality like transactions, joins, and foreign keys. The Citus extension enables this by transforming PostgreSQL into a highly scalable distributed database with features like a distributed SQL engine, [sharding](/azure/postgresql/hyperscale/concepts-nodes#shards), [reference tables](/azure/postgresql/hyperscale/concepts-nodes#type-2-reference-tables), and [distributed tables](/azure/postgresql/hyperscale/concepts-nodes#type-1-distributed-tables).

![Diagram of an Azure Cosmos DB for PostgreSQL cluster, with multiple worker nodes and a single coordinator node. The diagram also features arrows on the right and left, showing how additional nodes can be added to scale out.](../media/3b-distributed-database.png)

## Scale compute across nodes

Citus extends the functionality of PostgreSQL by enabling multiple PostgreSQL servers, known as [nodes](/azure/postgresql/hyperscale/concepts-nodes#nodes), to be clustered together. Every [cluster](/azure/postgresql/hyperscale/concepts-server-group) consists of a coordinator node and multiple worker nodes, enabling compute and memory to scale across numerous PostgreSQL servers in the cloud. Collectively, clusters can hold more data and use more CPU cores than a single server, providing faster responses on large datasets, even over multiple regions.

Woodgrove Bank's contactless payment application requires the ability to easily add compute resources to meet the demands of their heavy user analytics workloads and efficiently serve their customers. Azure Cosmos DB for PostgreSQL allows them to scale their database across regions to provide more performant queries while distributing their analytics workload over multiple nodes, taking advantage of more memory and CPU cores.

## Data distribution

The Citus extension allows data to be distributed across nodes in the cluster by letting you create [distributed tables](/azure/postgresql/hyperscale/concepts-nodes#type-1-distributed-tables). Distributed tables improve performance by horizontally partitioning table rows across worker nodes. Each row is assigned to a logical group called a [_shard_](/azure/postgresql/hyperscale/concepts-nodes#shards). Every row will be in precisely one shard, and every shard can contain multiple rows. By distributing data across nodes, you can take advantage of more storage capacity than would be available on a single server.

[Metadata tables](/azure/postgresql/hyperscale/reference-metadata#coordinator-metadata) located on the coordinator node store information about which shards are stored on which node. The mapping of shards to worker nodes is referred to as [shard placement](/azure/postgresql/hyperscale/concepts-nodes#shard-placements). Shard placement enables performant query operations against distributed data in the database. These metadata tables track the DNS names and health of worker nodes in addition to data distribution across nodes. During query execution, the coordinator decides what action to take by referencing these metadata tables. The coordinator node checks the metadata tables to determine if data lives on a single node or multiple nodes and then routes queries to worker nodes as needed.

## The power of parallelized query execution

The Citus combination of parallelism, keeping more data in memory, and higher I/O bandwidth can lead to significant performance improvements for multi-tenant SaaS applications, customer-facing real-time analytics dashboards, and time series workloads.

Creating distributed tables in the Woodgrove Bank database allows you to spread workloads across multiple worker nodes, using Citus to utilize more computing power. Woodgrove Bank's database developers won't need to learn new ways of querying data, as distributed tables appear to be regular tables to SQL statements. However, distributed tables are horizontally partitioned across worker nodes, and by storing different rows on different workers, the coordinator node can parallelize query execution.

The coordinator creates query fragments, targeting specific shards, and then sends those fragments to the appropriate worker for execution. These query fragments are executed simultaneously on the worker nodes, allowing the system to parallelize the workload evenly among many servers.

![The flow of a query arriving from an application is displayed, with the query being processed by the coordinator node using metadata tables and then the query fragments being sent to the work nodes for execution. The results of query execution on the worker nodes are passed back to the coordinator, aggregated, and returned to the application.](../media/3c-distributed-table.gif)

For this module, we'll focus on the Azure Database for PostgreSQL capabilities.