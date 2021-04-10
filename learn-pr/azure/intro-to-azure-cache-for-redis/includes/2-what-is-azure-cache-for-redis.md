Azure Cache for Redis provides a critical low-latency and high-throughput data storage solution for your modern apps. This can help improve the performance and scalability of apps that rely heavily on backend data stores.

## What is Redis Cache?

Redis Cache is a widely used, open-source caching solution. It's a key-value datastore running in memory. Because it runs in memory, it's very responsive. 

Typically, organizations use Redis Cache to complement their database apps. By combining Redis with backend databases, you can significantly improve the performance of your apps. 

## What should a caching solution do?

Any caching solution should address four key areas. These are:

- **Performance**. The primary requirement of any caching solution is to improve performance, even under high loads. Ideally, the caching solution should both increase throughout and reduce latency.
- **Scalability**. It's important that the system is capable of responding to changes in load. In our earlier example, sudden increases in demand might occur when you run sales promotions, or at specific times of the year. Scaling should be automatic, and take place without downtime. 
- **Availability**. It's vital that any caching solution is highly available to ensure that your apps can deliver at peak performance, even when there are component failures. 
- **Support for geographic distribution**. The ability to provide the same performance and scaling benefits anywhere in the world is an important consideration. This can be challenging if your data is geographically dispersed. 

## Azure Cache for Redis definition

Azure Cache for Redis enables you to implement Redis Cache as a fully managed service. 

> [!NOTE]
> Azure Cache for Redis offers both Redis open-source (OSS Redis) and a commercial product from Redis Labs (Redis Enterprise) as a managed service, depending on the tier you select.

Azure Cache for Redis provides the following application architecture patterns:

- **Data cache**. Because databases are often too large to load directly into cache, it's common to use the *cache-aside* pattern. This pattern loads data into the cache only as and when needed.  
- **Content cache**. Most webpages contain static items including headers, footers, and banners. These items don't change very often. By using an in-memory content cache, you can provide quick access to static content compared with accessing the backend datastores. 
- **Session store**. Often used with shopping carts or other data based on user history data that a web application might want to associate with user cookies. Because storing too much data in a cookie can adversely affect performance, apps often use the cookie as a key to query the backend database for the user data. Using an in-memory cache to store user session information is faster than working with the backend database. 
- **Job and message queuing**. Apps frequently add tasks to a queue. This occurs when the tasks might take a long time to execute. If a task contains operations that are long running, these are often queued to be executed in sequence. Azure Cache for Redis provides a distributed queue to support this application pattern. 

   > [!NOTE]
   > Longer running operations are queued to be processed in sequence, often by another server.

- **Distributed transactions**. Sometimes apps require a series of commands to execute on a backend datastore as a single operation. Azure Cache for Redis supports executing a batch of commands as a single transaction. 

   > [!NOTE]
   > All commands must succeed, or all must be rolled back to the initial state. 


## Azure Cache for Redis tiers

You can select from five available tiers of Azure Cache for Redis. These are: 

- **Basic**. Runs on a single virtual machine (VM). No SLA is provided for this tier. Based on an OSS Redis cache.
- **Standard**. Runs on two replicated VMs. Based on an OSS Redis cache.

   > [!IMPORTANT]
   > Standard and Basic are both single node caches. You should consider these tiers only for non-critical workloads. 

- **Premium**. Deployed on more powerful VMs compared. Offers higher throughput, lower latency, better availability, and more features. Based on an OSS Redis cache.
- **Enterprise**. Offers higher availability than the Premium tier. A high-performance cache powered by Redis Labs' Redis Enterprise software.
- **Enterprise Flash**. Offers a cost effective alternative to Enterprise. Also powered by Redis Labs' Redis Enterprise software. Extends Redis data storage to non-volatile memory, which reduces the overall per-GB memory cost.

All tiers support the following features:

- Data encryption
- Network isolation
- Scaling

Premium and both Enterprise tiers also support additional advanced features. These include:

- **OSS Cluster**. Provides for high-availability and load distribution.
- **Data persistence**. Allows you to persist data in Redis. This enables you to take snapshots and back up the data. You can then load these snapshots in the event of a hardware failure.
- **Zone redundancy**.  Provides higher resilience and availability because the VMs are spread across multiple availability zones. 
- **Geo-replication**. Links together two Azure Cache for Redis instances and creates a data replication relationship. This replication provides a potential disaster recovery solution. 
- **Import/Export**.  Enables you to import data into Azure Cache for Redis or export data from Azure Cache for Redis by importing and exporting an Azure Cache for Redis Database (RDB) snapshot from a premium cache to a blob in an Azure Storage Account.

The following features are only available in the Enterprise tiers:

- **RediSearch**. Provides a powerful indexing and querying engine with a full-text search engine.
- **RedisBloom**. Provides support for probabilistic data structures.
- **RedisTimeSeries**. Enables you to ingest and query very large quantities of data with very high-performance. 
