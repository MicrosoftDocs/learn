The *:::no-loc text="eShopOnContainers":::* app uses five different databases:

- Three instances of SQL Server hosted within the following services:
  - Identity
  - Catalog
  - Ordering
- One instance of MongoDB in the coupon service.
- One instance of Redis in the basket service.

A microservices architecture enables the developer to easily swap out containerized databases (like SQL Server, MongoDB, and Redis) with managed services. Providers such as Microsoft Azure offer managed versions of several popular database platforms.

In this unit, you'll explore how to modify the *:::no-loc text="eShopOnContainers":::* app to use managed data services. You'll replace Redis and MongoDB with Azure Cache for Redis and Azure Cosmos DB, respectively.

## Azure Cache for Redis

[Azure Cache for Redis](/azure/azure-cache-for-redis/cache-overview) is a managed service offering of the open-source software [Redis](https://redis.io/). When used as a cache, Redis improves the performance and scalability of systems that rely heavily on backend data stores. Frequently accessed data is copied to fast storage located close to the app. With Azure Cache for Redis, this fast storage is located in-memory instead of being loaded from disk by a database.

You can use Azure Cache for Redis as a distributed data cache, session store, and message broker. App performance is improved by taking advantage of the Redis engine's low-latency, high-throughput performance.

Here are some key features for Azure Cache for Redis:

- Data persistence, geo-replication, and Redis cluster for Premium tier
- Security via Firewall rules
- Encryption in transit

*:::no-loc text="eShopOnContainers":::* uses Redis for:

- Shopping cart storage.
- Data protection storage (key rings) for ASP.NET Core apps (Identity and WebSPA).
- SignalR storage.

## Azure Cosmos DB

Azure Cosmos DB is a globally distributed, multimodel database service. You can elastically and independently scale throughput and storage across any number of Azure regions worldwide. You can take advantage of fast, single-digit-millisecond data access by using any one of several popular APIs. Azure Cosmos DB provides comprehensive service-level agreements for throughput, latency, availability, and consistency guarantees.

Azure Cosmos DB includes several different models for accessing and managing data, each suited to specific use cases.

:::image type="content" source="../media/types-of-nosql-datastores.png" alt-text="Diagram illustrating the data models used by NoSQL databases. They are listed in the following table." lightbox="../media/types-of-nosql-datastores.png":::

### Data models for NoSQL databases

| Model | Characteristics |
| :-------- | :-------- |
| Document Store | Data and metadata are stored hierarchically in JSON-based documents inside the database. |
| Key Value Store | The simplest of the NoSQL databases, data is represented as a collection of key-value pairs. |
| Wide-Column Store | Related data is stored as a set of nested-key/value pairs within a single column. |
| Graph Store | Data is stored in a graph structure as node, edge, and data properties. |

You define the API used by Cosmos DB at creation time. Cosmos DB implements several APIs to serve data to clients, including:

- Core (SQL) API
- Cassandra API
- Azure Cosmos DB API for Mongo DB.

In the next unit, you'll verify *:::no-loc text="eShopOnContainers":::* deployed correctly.
