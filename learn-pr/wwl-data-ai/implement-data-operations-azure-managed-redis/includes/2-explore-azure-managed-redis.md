Azure Managed Redis provides an in-memory data store based on the Redis Enterprise software. Redis Enterprise improves the performance and reliability of the community edition of Redis, while maintaining compatibility. Microsoft operates the service, hosted on Azure, and usable by any application within or outside of Azure.

Azure Managed Redis can improve the performance and scalability of an application that heavily uses backend data stores. It's able to process large volumes of application requests by keeping frequently accessed data in the server memory, which can be written to and read from quickly.

## Common caching strategies

Azure Managed Redis supports many caching use cases. Following is information on three of the most common:

- Data cache
- Content cache
- Session store

### Data cache

Databases are often too large to load directly into a cache, making it impractical to preload entire datasets. Azure Managed Redis excels at implementing the cache-aside pattern, where data is loaded into the cache only when requested. When an application needs data, it first checks the Redis cache. If the data isn't found (a cache miss), the application retrieves it from the database and stores it in Redis for subsequent requests.

When the application makes changes to the underlying data, it can also invalidate or update the corresponding cache entries to maintain consistency. The service supports time-to-live (TTL) settings to automatically remove stale data, and configurable eviction policies that manage memory efficiently when the cache reaches capacity. For globally distributed applications, built-in Active-Active geo-replication synchronizes cache data across multiple regions.

### Content cache

Many web pages are generated from templates that use static content such as headers, footers, banners, navigation menus, and common UI components. These elements rarely change, making them ideal candidates for caching. Storing this content in Azure Managed Redis provides sub-millisecond access compared to retrieving it from backend datastores or regenerating it on every request.

This pattern dramatically reduces processing time and server load, allowing web servers to handle more concurrent users. By offloading static content delivery, you can reduce the number of web servers needed to handle the same traffic load, lowering infrastructure costs. The service provides native integration through the Redis Output Cache Provider for ASP.NET applications and supports similar patterns for other frameworks. Clustering capabilities distribute large amounts of static content across multiple nodes for optimal performance.

### Session store

Session stores are valuable for shopping carts, user preferences, authentication tokens, and other user-specific data that web applications maintain across requests. Storing too much information directly in cookies negatively impacts performance—each cookie is transmitted with every HTTP request and response, increasing bandwidth usage and latency.

The typical solution stores only a session identifier in the cookie, then uses that key to retrieve full session data. Traditional implementations query this data from a database, but Azure Managed Redis delivers orders of magnitude faster performance by storing session data in memory. The service can retrieve and update user session data with sub-millisecond latency while scaling to handle millions of concurrent sessions. Automatic session expiration, high availability through replication, and seamless integration with web frameworks (ASP.NET, ASP.NET Core, Node.js, Python, Java) make it well-suited for this pattern. Active-Active geo-replication ensures users maintain their session state even during regional failovers.

## Choosing the right tier

Selecting the right Redis tier determines your application's availability guarantees, performance ceiling, and monthly costs. There are four tiers of Azure Managed Redis available, each with different performance characteristics and price levels.

Three tiers store in-memory data:

- **Memory Optimized** Ideal for memory-intensive use cases that require a high memory-to-vCPU ratio (8:1) but don't need the highest throughput performance. It provides a lower price point for scenarios where less processing power or throughput is necessary, making it an excellent choice for development and testing environments.
- **Balanced (Memory + Compute)** Offers a balanced memory-to-vCPU (4:1) ratio, making it ideal for standard workloads. This tier provides a healthy balance of memory and compute resources.
- **Compute Optimized** Designed for performance-intensive workloads requiring maximum throughput, with a low memory-to-vCPU (2:1) ratio. It's ideal for applications that demand the highest performance.

One tier stores data both in-memory and on-disk:

- **Flash Optimized (preview)** Enables Redis clusters to automatically move less frequently accessed data from memory (RAM) to NVMe storage. This reduces performance, but allows for cost-effective scaling of caches with large datasets.

For a detailed feature comparison of the tiers, visit [About Azure Managed Redis](/azure/redis/overview#choosing-the-right-tier)

## Additional resources

- For pricing information, visit [Azure Managed Redis Pricing](https://aka.ms/amrpricing)
- For an architecture overview, visit [Azure Managed Redis architecture](/azure/redis/architecture)
