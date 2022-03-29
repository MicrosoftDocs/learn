Caching is a common technique that aims to improve the performance and scalability of a system. It does this by temporarily copying frequently accessed data to fast storage that's located close to the application. If this fast data storage is located closer to the application than the original source, then caching can significantly improve response times for client applications by serving data more quickly.

Caching is most effective when a client instance repeatedly reads the same data, especially if all the following conditions apply to the original data store:

- It remains relatively static.

- It's slow compared to the speed of the cache.

- It's subject to a high level of contention.

- It's far away when network latency can cause access to be slow.

In this unit, you’ll learn how to use Azure Cache for Redis to manage caching requirements.

## Recommend a caching solution for applications

Suppose you work at a Tailwind Traders that has launched a new game ,which will have real time leaderboards for gamers to check their scores. The leaderboard would show the user's rank in the game in real time while getting updated as soon as the events in the game changes. This requires in-memory fast read and writes for which you have been asked to design a caching solution.

### What is Azure Cache for Redis?

[Azure Cache for Redis](/azure/azure-cache-for-redis/cache-overview) provides an in-memory data store based on the Redis software. Redis improves the performance and scalability of an application that uses backend data stores heavily. It's able to process large volumes of application requests by keeping frequently accessed data in the server memory, which can be written to and read from quickly. Redis brings a critical low-latency and high-throughput data storage solution to modern applications.

Azure Cache for Redis offers both:

- The Redis open source (OSS Redis) 

- A commercial product from Redis Labs (Redis Enterprise) as a managed service. 

Azure Cache for Redis provides secure and dedicated Redis server instances and full Redis API compatibility. The service is operated by Microsoft, hosted on Azure, and usable by any application within or outside of Azure.

You can use Azure Cache for Redis for several purposes, including as a:

- Distributed data or content cache

- A session store

- A message broker

> [!TIP]
> You can deploy Azure Cache for Redis as a standalone. Alternatively, you can deploy it with other Azure database services, such as Azure SQL or Cosmos DB.

The following diagram shows how cache works in applications.

:::image type="content" source="../media/azure-cache-for-redis.png" alt-text="A graphic displays the typical use for Azure Cache for Redis.":::


### When to use Azure Cache for Redis?

Azure Cache for Redis improves application performance by supporting common application architecture patterns. Some of the most common include the following patterns.

| **Audience**| **Azure Cache for Redis** |
| - |- |
| Data cache| Databases are often too large to load directly into a cache. It's common to use the cache-aside pattern to load data into the cache only as needed. When the system makes changes to the data, the system can also update the cache, which is then distributed to other clients. Additionally, the system can set an expiration on data, or use an eviction policy to trigger data updates into the cache. |
| Content cache| Many web pages are generated from templates that use static content such as headers, footers, banners. These static items shouldn't change often. Using an in-memory cache provides quick access to static content compared to backend datastores. This pattern reduces processing time and server load, allowing web servers to be more responsive. It can allow you to reduce the number of servers needed to handle loads. Azure Cache for Redis provides the Redis Output Cache Provider to support this pattern with ASP.NET. |
| Session store| This pattern is commonly used with shopping carts and other user history data that a web application might associate with user cookies. Storing too much in a cookie can have a negative effect on performance as the cookie size grows and is passed and validated with every request. A typical solution uses the cookie as a key to query the data in a database. Using an in-memory cache, like Azure Cache for Redis, to associate information with a user, is much faster than interacting with a full relational database. |
| Job and message queuing| Applications often add tasks to a queue when the operations associated with the request take time to execute. Longer running operations are queued to be processed in sequence, often by another server. This method of deferring work is called task queuing. Azure Cache for Redis provides a distributed queue to enable this pattern in your application. |
| Distributed transactions| Applications sometimes require a series of commands against a backend data-store to execute as a single atomic operation. All commands must succeed, or all must be rolled back to the initial state. Azure Cache for Redis supports executing a batch of commands as a single transaction. |
