While your Azure Cache for Redis is being created, let's have a look at what Redis is, and which are its recommended use cases.

## What is Redis

[Redis](https://redis.io/) is an Open Source (BSD licensed) data store. It's a distributed, in-memory key-value database, that can be used as a cache and a message broker, and it has optional durability.

Redis is often ranked as the most popular key-value database. Its ease of use, performance and scalability make it an excellent choice for many application developers.

## What is Azure Cache for Redis

[Azure Cache for Redis](https://azure.microsoft.com/services/cache/?WT.mc_id=java-11981-judubois) is a managed version of Redis, maintained and operated by Azure.

Azure Cache for Redis provides all the benefits or Redis: excellent throughput and performance to handle millions of requests per second. As it's managed by Azure, you benefit from all the advantages of a cloud service like automatic patches, updates, scaling and provisioning.

Several tiers are available, and the most advanced ones can provide clustering, replication and high availability, so you can rely on Redis for critical workloads.

## Using Redis in Java and with Spring Boot

For Java developers, Redis doesn't provide an official library: there are in fact several different Open Source libraries made by third-party developers. Choice is good, and one of your main decisions will be to select the one that fits your needs best.

Here are the 3 most popular ones:

- [Jedis](https://github.com/redis/jedis) is the most used library, and it's simple and easy to use.
- [Lettuce](https://github.com/lettuce-io/lettuce-core) is the library we will use in this module, as it's the one that comes bundled with Spring Data for Redis. It has great asynchronous support, which is important if you want to create a reactive Spring application.
- [Redisson](https://github.com/redisson/redisson) is the most advanced Redis client, as it can also be used as an Hibernate second-level cache (which is an awesome feature if you need it).

## Recommended use cases

Azure Cache for Redis has the following main use cases:

- As a **distributed cache** it allows to speed up applications relying on an SQL database. It can also lower the cost of an application, as scaling a Redis cluster is cheaper than scaling a database.
- As a **HTTP session data store** it makes it possible to scale session-based applications. This is typically useful for applications using JSF (JavaServer Faces), or applications storing security data in the user's session.
- As a **message broker**, Azure Cache for Redis is a solution for implementing pub/sub or queue architectures.
