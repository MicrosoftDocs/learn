While your Azure Cache for Redis is being created, let's have a look at what Redis is, and which are its recommended use cases.

## What is Redis

[Redis](https://redis.io/) is an Open Source (BSD licensed) data store. It's a distributed, in-memory key-value database, that you can use as cache and as a message broker, and it has optional durability.

Redis is often ranked as the most popular key-value database. Its ease of use, performance, and scalability make it an excellent choice for many application developers.

## What is Azure Cache for Redis

[Azure Cache for Redis](https://azure.microsoft.com/services/cache/?WT.mc_id=java-11981-judubois) is a managed version of Redis, maintained, and operated by Azure.

Azure Cache for Redis provides all the benefits or Redis: excellent throughput and performance to handle millions of requests per second. As it's managed by Azure, you benefit from all the advantages of a cloud service like automatic patches, updates, scaling and provisioning.

Several tiers are available, and the most advanced ones can provide clustering, replication, and high availability. You can rely on those advanced tiers for critical workloads.

## Recommended use cases

Azure Cache for Redis has the following main use cases:

- As a **distributed cache** it speeds up applications relying on an SQL database. It can also lower the cost of an application, as scaling a Redis cluster is cheaper than scaling a database.
- As an **HTTP session data store**, it makes it possible to scale session-based applications. This mechanism is typically useful for applications using JSF (JavaServer Faces), or applications storing security data in the user's session.
- As a **message broker**, Azure Cache for Redis is a solution for implementing pub/sub or queue architectures.

## Using Redis in Java and with Spring Boot

For Java developers, Redis doesn't provide an official library: there are in fact several different Open Source libraries made by third-party developers. Choice is good, and one of your main decisions is to select the one that fits your needs best.

Here are the three most popular ones:

- [Jedis](https://github.com/redis/jedis) is the most used library, and it's simple and easy to use.
- [Lettuce](https://github.com/lettuce-io/lettuce-core) is the library we'll use in this module, as it's the one that comes bundled with Spring Data for Redis. It has great asynchronous support, which is important if you want to create a reactive Spring application.
- [Redisson](https://github.com/redisson/redisson) is the most advanced Redis client, as you can also use it as an Hibernate second-level cache (which is an awesome feature if you need it).

## Creating and configuring a distributed cache using Spring Data Redis

Let's focus on the first recommended use case that we listed earlier: creating a distributed cache using Redis.

Using Spring Boot, typically with [https://start.spring.io/](https://start.spring.io/), you will have three main tasks to achieve:

- Add the Spring Data Redis library to your application.
- Configure your `application.yml` file to connect to your Azure Cache for Redis instance.
- Code some business logic, using Spring Data Redis to store, and retrieve data from the cache.

This setup will use the [Lettuce](https://github.com/lettuce-io/lettuce-core) library underneath, but you won't need to use that library directly, unless you require some advanced configuration. All the data access code is handled by Spring Data, using a mechanism that most Spring developers should be familiar with. Spring Data is also used for accessing SQL databases (using JPA) and NoSQL databases (like MongoDB).

Spring Data requires you to create two classes:

- A Java bean that will hold your data, and which should be annotated with the `@RedisHash` Java annotation. This annotation is used to store, and retrieve data in Redis, using a specific key.
- A Spring repository, which is a specific Java class which will be able to do database operations (create, retrieve, update, delete) on the Java bean that stores the data. For example, it will be able to store one instance of the bean, or retrieve a list of beans.

Then, you can inject this Spring repository into any standard Spring bean: for instance, you can inject it inside a Spring MVC Rest controller, which will be used to store and access that data. It is what we're going to achieve in the next section's exercise.
