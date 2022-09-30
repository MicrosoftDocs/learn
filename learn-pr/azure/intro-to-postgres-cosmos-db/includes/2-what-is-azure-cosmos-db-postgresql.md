Azure Database for PostgreSQL - Hyperscale (Citus) is now [Azure Cosmos DB for PostgreSQL](../../../paths/azure-cosmos-db-for-postgresql/index.yml)!

## The PostgreSQL layer

Azure Cosmos DB for PostgreSQL transforms PostgreSQL into a highly scalable distributed database by clustering PostgreSQL servers. Distributed databases work by spreading table data across nodes in the cluster, horizontally partitioning rows across worker nodes. By dispersing data across shards on different worker nodes, they can take advantage of cross-machine parallelism, providing the key performance benefits of Azure Cosmos DB for PostgreSQL.

The service provides a relational database solution with horizontal scalability across as many machines - and locations - as needed. You don’t have to give up transactions, joins, and foreign keys for the ability to scale.

>[!Note]
>Azure Cosmos DB for PostgreSQL inherits it's horizontal scaling capabilities from the service formally called Azure Database for PostgreSQL - Hyperscale (Citus).

## The Azure layer

**Azure Cosmos DB for PostgreSQL (formerly Azure Database for PostgreSQL - Hyperscale)** delivers scale across multiple machines. It serves applications that require greater scale and performance, generally workloads that are approaching--or already exceed--100 GB of data. Azure Cosmos DB for PostgreSQL can also be deployed and managed on-premises, on the edge, or on multicloud environments using Azure Arc.

The Azure layer gives each deployment option four noticeable benefits:

* High availability, with an SLA of up to 99.99% uptime
* AI-powered performance optimization
* Automated hardware and software maintenance
* Advanced data and server security

They're constantly working behind the scenes, automated actions that can help your business reduce administration costs, and complexity.

>[!Note]
>Cosmos DB for PostgreSQL shouldn't be confused with Azure Database for PostgreSQL, which is used for smaller workloads.
>Visit [Introduction to Azure Database for PostgreSQL](../../../paths/introduction-to-azure-postgres/index.yml),To follow the training modules for Azure Database for PostgreSQL.

## Distributed capabilities

[Azure Cosmos DB for PostgreSQL](/azure/postgresql/hyperscale/overview) is a fully managed database-as-a-service hosted on Azure that delivers the full functionality of PostgreSQL combined with the ability to distribute data across multiple PostgreSQL servers as nodes within a cluster. It's a robust database with a wide range of built-in features. Azure Cosmos DB for PostgreSQL inherits many of its capabilities from the service formally called Azure Database for PostgreSQL - Hyperscale (Citus).

Azure Cosmos DB for PostgreSQL transforms PostgreSQL into a highly scalable distributed database by clustering PostgreSQL servers. Distributed databases work by spreading table data across nodes in the cluster, horizontally partitioning rows across worker nodes. By dispersing data across [shards](/azure/postgresql/hyperscale/concepts-nodes#shards) on different worker nodes, the distributed databases can take advantage of cross-machine parallelism, providing the key performance benefits of Azure Cosmos DB for PostgreSQL.

In fact, the distributed capabilities of Azure Cosmos DB for PostgreSQL are made possible through the [Citus extension](https://github.com/citusdata/citus). Other examples of extensions are [`pg_cron`](https://github.com/citusdata/pg_cron), a cron-based job scheduler that allows you to schedule PostgreSQL commands directly from the database and [PostGIS](https://postgis.net/) that adds support for geographic objects, allowing location queries to be run in SQL.

![Diagram showing three of the extensions you will use in this learning module, Citus, PostGIS, and pg_cron, being added to Azure Cosmos DB for PostgreSQL and used to extend the functionality of the database.](../media/2a-cosmos-db-for-postgresql-extensions.png)

In the Extend functionality using extensions module, you'll explore in more detail how extensions can be used to improve the productivity of Azure Cosmos DB for PostgreSQL. You'll examine the Citus extension and how it enables data distribution and investigate other supported extensions and the capabilities they can provide to improve the overall effectiveness of a database.

## What is Citus?

[Citus](https://github.com/citusdata/citus) is an open-source extension for PostgreSQL that was created to allow data storage and computing capabilities to scale across a cluster of PostgreSQL servers without sacrificing traditional relational database functionality like transactions, joins, and foreign keys. The Citus extension enables this by transforming PostgreSQL into a highly scalable distributed database with features like a distributed SQL engine, [sharding](/azure/postgresql/hyperscale/concepts-nodes#shards), [reference tables](/azure/postgresql/hyperscale/concepts-nodes#type-2-reference-tables), and [distributed tables](/azure/postgresql/hyperscale/concepts-nodes#type-1-distributed-tables).

![Diagram explaining how the Azure Cosmos DB for PostgreSQL cluster, with multiple worker nodes and a single coordinator node. The diagram also features arrows on the right and left, showing how additional nodes can be added to scale out.](../media/2b-distributed-database.png)

## Scale compute across nodes

Citus extends the functionality of PostgreSQL by enabling multiple PostgreSQL servers, known as [nodes](/azure/postgresql/hyperscale/concepts-nodes#nodes), to be clustered together. Every [cluster](/azure/postgresql/hyperscale/concepts-server-group) consists of a coordinator node and multiple worker nodes, enabling compute and memory to scale across numerous PostgreSQL servers in the cloud. Collectively, clusters can hold more data and use more CPU cores than a single server, providing faster responses on large datasets, even over multiple regions.

## Data distribution

The Citus extension allows data to be distributed across nodes in the cluster by letting you create [distributed tables](/azure/postgresql/hyperscale/concepts-nodes#type-1-distributed-tables). Distributed tables improve performance by horizontally partitioning table rows across worker nodes. Each row is assigned to a logical group called a [_shard_](/azure/postgresql/hyperscale/concepts-nodes#shards). Every row will be in precisely one shard, and every shard can contain multiple rows. By distributing data across nodes, you can take advantage of more storage capacity than would be available on a single server.

[Metadata tables](/azure/postgresql/hyperscale/reference-metadata#coordinator-metadata) located on the coordinator node stores information about which shards are stored on which node. The mapping of shards to worker nodes is referred to as [shard placement](/azure/postgresql/hyperscale/concepts-nodes#shard-placements). Shard placement enables performant query operations against distributed data in the database. These metadata tables track the DNS names and health of worker nodes in addition to data distribution across nodes. During query execution, the coordinator decides what action to take by referencing these metadata tables. The coordinator node checks the metadata tables to determine if data lives on a single node or multiple nodes and then routes queries to worker nodes as needed.

## Workloads

If you want a database to perform well, it’s important to design it methodically. When designing a database, especially a large database, you need to assess your workloads and application. There are, generally, two types of workloads for databases.

### What are OLTP workloads?

Workloads that generate standard CRUD—create, read, update, delete—operations can involve **small amounts of data**, but generally have a **large number of transactions**. The data being analyzed is usually text, numeric, time, or JSON data. These workloads are usually called online transactional processing, or more simply **OLTP**, and are the most common type of workload. An example of this kind of workload might be sending a text, or purchasing clothes online.

Our contactless payment app will mostly have OLTP workloads - account-to-account transactions. The transactions will have small amounts of data, but occur in large numbers.

### What are OLAP workloads?

Workloads that generate reports can involve **large amounts of data**, but have a **low number of transactions**. The data being analyzed is generally event data or time series data. These workloads are usually called online analytical processing, or **OLAP**. Examples include applications that power customer-facing analytics dashboards, such as web and mobile analytics or anomaly and fraud detection.

In our scenario, when customer and merchant queries are run on the contactless payment app, these will be OLAP workloads. An example might be a status dashboard, showing if services are running or undergoing maintenance.
