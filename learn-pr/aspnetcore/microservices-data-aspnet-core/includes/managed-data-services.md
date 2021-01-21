The *:::no-loc text="eShopOnContainers":::* app uses five different databases:

- Three SQL Server in the same container/pod
- One MongoDB
- One Redis

This example demonstrates it's possible to mix and match databases in a microservices architecture, and it's okay for a sample app or for dev/test environment, it isn't so for a production environment.

Kubernetes was designed primarily for stateless workloads, which is precisely not the case for a database service. Kubernetes can also be used to handle stateful workloads, but it requires some extra work. You can also deploy a [SQL Server High Availability (HA) solution in a container on AKS](https://docs.microsoft.com/sql/linux/tutorial-sql-server-containers-kubernetes?view=sql-server-ver15).

In production environments, you typically handle the databases as services outside the cluster. You can configure a separate Virtual Machine (VM) or, more probably, a dedicated database High Availability cluster for each microservice.

However, considering that each microservice should have an independent database server, it's easy to see that handling the required infrastructure can get complicated.

In this scenario, the Azure Managed Database Services can be an effective solution that ensures your databases are in top-notch condition, with the latest security patches, can scale to adapt to any workload automatically, and can be configured quite easily.

In this module, you'll explore how to modify the *:::no-loc text="eShopOnContainers":::* app to use managed data services. You'll replace Redis and MongoDB with Azure Cache for Redis and Azure Cosmos DB, respectively.

## Azure Cache for Redis

[Azure Cache for Redis](https://docs.microsoft.com/azure/azure-cache-for-redis/cache-overview) provides an in-memory data store based on the open-source software [Redis](https://redis.io/). When used as a cache, Redis improves the performance and scalability of systems that rely heavily on backend data stores. Frequently accessed data is copied to fast storage located close to the app. With Azure Cache for Redis, this fast storage is located in-memory instead of being loaded from disk by a database.

Azure Cache for Redis can be used as a distributed data cache, a session store, and a message broker. App performance is improved by taking advantage of the low-latency, high-throughput performance of the Redis engine.

Azure Cache for Redis offers access to a secure, dedicated Redis cache. It's managed by Microsoft, hosted on Azure, and accessible to any app within or outside of Azure.

Some key features for Azure Cache for Redis are:

- Data persistence, geo-replication, and Redis cluster for Premium tier.
- Security via Firewall rules.
- Encryption in transit.

Redis is used in *:::no-loc text="eShopOnContainers":::* for:

- Shopping cart storage.
- [Data protection storage](https://docs.microsoft.com/aspnet/core/security/data-protection/introduction) (Key rings) for ASP.NET Core apps (Identity and WebSPA).
- SignalR storage.

## Azure Cosmos DB

[Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/introduction) is Microsoft's globally distributed database service for mission-critical apps. Azure Cosmos DB provides the following features:

- [Turn-key global distribution](https://docs.microsoft.com/azure/cosmos-db/distribute-data-globally)
- [Elastic scaling of throughput and storage](https://docs.microsoft.com/azure/cosmos-db/partition-data) worldwide
- Single-digit millisecond latencies at the 99th percentile
- [Five well-defined consistency levels](https://docs.microsoft.com/azure/cosmos-db/consistency-levels)
- Guaranteed high availability
- [Industry-leading service-level agreements](https://azure.microsoft.com/support/legal/sla/cosmos-db/)

Azure Cosmos DB is a [multi-model database](https://docs.microsoft.com/azure/cosmos-db/relational-nosql) that supports document, key-value, graph, and columnar data models. It [automatically indexes data](https://www.vldb.org/pvldb/vol8/p1668-shukla.pdf) without requiring you to deal with schema and index management.

You can quickly create and query document, key-value, and graph databases. All of these database types benefit from the global distribution and horizontal scale capabilities at the core of Azure Cosmos DB.

Multi-model means Azure Cosmos DB can have several "impersonations" that can implement both NoSQL and relational databases. From an API perspective, Cosmos DB can look like:

- A [SQL Database](https://docs.microsoft.com/azure/cosmos-db/sql-query-getting-started)
- A [MongoDB database](https://docs.microsoft.com/azure/cosmos-db/mongodb-introduction)
- A [Cassandra database](https://docs.microsoft.com/azure/cosmos-db/cassandra-introduction)
- A [Gremlin API graph database](https://docs.microsoft.com/azure/cosmos-db/graph-introduction)
- An [Azure Table](https://docs.microsoft.com/azure/cosmos-db/table-introduction)

You define the way a Cosmos DB looks like on creation time. The impersonations mentioned above support the corresponding wire protocols, so you can easily migrate your app with a simple connection string update.
