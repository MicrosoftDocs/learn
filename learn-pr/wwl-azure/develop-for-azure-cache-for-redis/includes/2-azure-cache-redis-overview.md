Azure Cache for Redis provides an in-memory data store based on the [Redis](https://redis.io/) software. Redis improves the performance and scalability of an application that uses backend data stores heavily. It's able to process large volumes of application requests by keeping frequently accessed data in the server memory, which can be written to and read from quickly. Redis brings a critical low-latency and high-throughput data storage solution to modern applications.

Azure Cache for Redis offers both the Redis open-source (OSS Redis) and a commercial product from Redis Labs (Redis Enterprise) as a managed service. It provides secure and dedicated Redis server instances and full Redis API compatibility. Microsoft operates the service, hosted on Azure, and usable by any application within or outside of Azure.

## Key scenarios

Azure Cache for Redis improves application performance by supporting common application architecture patterns. Some of the most common include the following patterns:

| Pattern | Description |
|--|--|
| Data cache | Databases are often too large to load directly into a cache. It's common to use the [cache-aside](/azure/architecture/patterns/cache-aside) pattern to load data into the cache only as needed. When the system makes changes to the data, the system can also update the cache, which is then distributed to other clients. |
| Content cache | Many web pages are generated from templates that use static content such as headers, footers, banners. These static items shouldn't change often. Using an in-memory cache provides quick access to static content compared to backend datastores. |
| Session store | This pattern is commonly used with shopping carts and other user history data that a web application might associate with user cookies. Storing too much in a cookie can have a negative effect on performance as the cookie size grows and is passed and validated with every request. A typical solution uses the cookie as a key to query the data in a database. Using an in-memory cache, like Azure Cache for Redis, to associate information with a user is faster than interacting with a full relational database. |
| Job and message queuing | Applications often add tasks to a queue when the operations associated with the request take time to execute. Longer running operations are queued to be processed in sequence, often by another server. This method of deferring work is called task queuing. |
| Distributed transactions | Applications sometimes require a series of commands against a backend data-store to execute as a single atomic operation. All commands must succeed, or all must be rolled back to the initial state. Azure Cache for Redis supports executing a batch of commands as a single [transaction](https://redis.io/topics/transactions). |

## Service tiers

Azure Cache for Redis is available in these tiers:

| Tier | Description |
|--|--|
| Basic | An OSS Redis cache running on a single virtual machine (VM). This tier has no service-level agreement (SLA) and is ideal for development/test and noncritical workloads. |
| Standard | An OSS Redis cache running on two VMs in a replicated configuration. |
| Premium | High-performance OSS Redis caches. This tier offers higher throughput, lower latency, better availability, and more features. Premium caches are deployed on more powerful VMs compared to the VMs for Basic or Standard caches. |
| Enterprise | High-performance caches powered by Redis Labs' Redis Enterprise software. This tier supports Redis modules including RediSearch, RedisBloom, and RedisTimeSeries. Also, it offers even higher availability than the Premium tier. |
| Enterprise Flash | Cost-effective large caches powered by Redis Labs' Redis Enterprise software. This tier extends Redis data storage to nonvolatile memory, which is cheaper than DRAM, on a VM. It reduces the overall per-GB memory cost. |

The [Azure Cache for Redis Pricing](https://azure.microsoft.com/pricing/details/cache/) provides a detailed comparison of each tier.