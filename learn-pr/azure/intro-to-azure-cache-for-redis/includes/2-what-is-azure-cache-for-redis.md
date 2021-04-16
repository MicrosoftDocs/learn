Let's start with a quick overview of Azure Cache for Redis to help you decide if it's a suitable solution for your organization. <!--Andy, a couple of template fixes. I also removed the second sentence because we had it in the first unit. Moved third sentence to end of first unit.-->

## What is Redis Cache?

Redis Cache is a widely used, open-source caching solution. It's a key-value datastore running in memory. Because it runs in memory, it's very responsive.

Typically, organizations use Redis Cache to complement their database apps. By combining Redis with back-end databases, you can significantly improve the performance of your apps.

## What should a caching solution do?

Any caching solution should address the following four key requirements:

- **Performance**. The primary requirement of any caching solution is to improve performance, even under high loads. Ideally, the caching solution should increase throughout and also reduce latency.
- **Scalability**. It's important that the system is capable of responding to changes in load. In your fictional shoe company, sudden increases in demand might occur when you run sales promotions, or at specific times of the year. Scaling should be automatic, and take place without downtime.
- **Availability**. It's vital that any caching solution is highly available. this will help ensure that your apps can deliver at peak performance, even when there are component failures.
- **Support for geographic distribution**. The ability to provide the same performance and scaling benefits anywhere in the world is an important consideration. This can be challenging if your data is geographically dispersed.

## Azure Cache for Redis definition

Azure Cache for Redis enables you to implement Redis Cache as a fully managed service.

> [!NOTE]
> Azure Cache for Redis offers both Redis open-source (OSS Redis) and a commercial product from Redis Labs (Redis Enterprise) as a managed service, depending on the tier you select.

Azure Cache for Redis provides the following application architecture patterns:

- **Data cache**. Because databases are often too large to load directly into cache, it's common to use the *cache-aside* pattern. This pattern loads data into the cache only as and when needed.  
- **Content cache**. Most webpages contain static items including headers, footers, and banners. These items don't change very often. By using an in-memory content cache, you can provide quick access to static content as compared to accessing the back-end datastores.
- **Session store**. This pattern is often used with shopping carts or other data based on user history data, which a web application might want to associate with user cookies. Because storing too much data in a cookie can adversely affect performance, apps often use the cookie as a key to query the back-end database for the user data. Using an in-memory cache to store user session information is faster than working with the backend database.
- **Job and message queuing**. Apps frequently add tasks to a queue. This occurs when the tasks might take a long time to run. If a task contains long-running operations, these are often queued to be run in sequence. Azure Cache for Redis provides a distributed queue to support this application pattern.

   > [!NOTE]
   > Longer running operations are queued to be processed in sequence, often by another server.

- **Distributed transactions**. Sometimes apps require a series of commands to run on a back-end datastore as a single operation. Azure Cache for Redis supports running a batch of commands as a single transaction.

   > [!NOTE]
   > All commands must either succeed or be rolled back to the initial state.

## Azure Cache for Redis tiers

You can select from the following five tiers that are available for Azure Cache for Redis:

- The Basic tier runs on a single virtual machine (VM) and doesn't include an SLA. It is based on an OSS Redis cache.
- The Standard tier runs on two replicated VMs and is based on an OSS Redis cache.

   > [!IMPORTANT]
   > Standard and Basic are both single-node caches. You should consider these tiers only for non-critical workloads.

- The Premium tier is deployed on more powerful VMs and offers features such as higher throughput, lower latency, and better availability. It is based on an OSS Redis cache.
- The Enterprise tier offers higher availability than the Premium tier and a high-performance cache powered by Redis Labs' Redis Enterprise software.
- The Enterprise Flash tier offers a cost-effective alternative to the Enterprise tier and is also powered by Redis Labs' Redis Enterprise software. This tier extends Redis data storage to non-volatile memory, which reduces the overall per-GB memory cost.

All tiers support the following features:

- Data encryption
- Network isolation
- Scaling

The Premium, Enterprise, and Enterprise Flash tiers also support additional advanced features such as:

- **OSS Cluster**. Provides for high-availability and load distribution.
- **Data persistence**. Allows you to persist data in Redis. This enables you to take snapshots and back up the data. You can then load these snapshots in the event of a hardware failure.
- **Zone redundancy**.  Provides higher resilience and availability because the VMs are spread across multiple availability zones.
- **Geo-replication**. Links together two Azure Cache for Redis instances and creates a data replication relationship. This replication provides a potential disaster recovery solution.
- **Import/Export**.  Enables you to import data into or export data from Azure Cache for Redis by importing and exporting an Azure Cache for Redis Database (RDB) snapshot from a premium cache to a blob in an Azure Storage Account.

The following features are only available in the Enterprise tiers:

- **RediSearch**. Provides a powerful indexing and querying engine with a full-text search engine.
- **RedisBloom**. Provides support for probabilistic data structures.
- **RedisTimeSeries**. Enables you to ingest and query very large quantities of data with very high performance.
