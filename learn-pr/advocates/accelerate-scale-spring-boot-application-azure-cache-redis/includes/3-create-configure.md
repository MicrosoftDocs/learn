While your Azure Cache for Redis instance deploys, learn more about Redis, Azure Cache for Redis, using Redis with Java and Spring Boot applications, and using Spring Data Redis for a distributed cache.

## Redis and Azure Cache for Redis

[Redis](https://redis.io/) is a BSD-licensed, open-source data store. Redis is a distributed, in-memory, key-value database, with optional durability, that acts as a cache and a message broker. Redis is one of the most popular key-value databases. Its ease of use, performance, and scalability make it an excellent choice for application developers.

[Azure Cache for Redis](https://azure.microsoft.com/services/cache) is a managed version of Redis that Azure maintains and operates. Azure Cache for Redis offers all the benefits of Redis, with excellent throughput and performance to handle millions of requests per second. Azure provides all the advantages of a managed cloud service, like automatic patches, updates, scaling, and provisioning.

Azure Cache for Redis offers several service tiers. The most advanced tiers provide clustering, replication, and high availability for critical workloads.

## Azure Cache for Redis use cases

Azure Cache for Redis has the following main uses:

- A *distributed cache* for speeding up applications that rely on SQL databases. Redis can lower the cost of an application, because scaling a Redis cluster is cheaper than scaling a database.
- An *HTTP session data store* that enables scaling of session-based applications. This mechanism is typically useful for applications that use JavaServer Faces (JSF), or applications that store security data in the user session.
- A *message broker* solution for implementing publish/subscribe or queue architectures.

## Use Redis with Java

Redis doesn't provide an official library for Java developers, but developers from various organizations have created several open-source libraries. One of your main decisions as a Java developer is to select the library that best fits your needs. The following libraries are the most popular.

- [Jedis](https://github.com/redis/jedis) is the most used library, and is simple and easy to use.
- [Lettuce](https://github.com/lettuce-io/lettuce-core) is the library this module uses, because it comes bundled with Spring Data for Redis. Lettuce has great asynchronous support, which is important if you want to create a reactive Spring application.
- [Redisson](https://github.com/redisson/redisson) is the most advanced Redis client. You can use Redisson as a Hibernate second-level cache if you need that feature.

## Use Spring Data Redis to create a distributed cache

Creating a distributed cache by using Redis with Spring Boot, typically with [Spring Initializr](https://start.spring.io/), involves three main tasks:

- Add the Spring Data Redis library to your application.
- Configure your *application.yml* file to connect to your Azure Cache for Redis instance.
- Code business logic by using Spring Data Redis to store and retrieve data from the cache.

This setup uses the Lettuce library, but you don't need to use that library directly unless you need some advanced configuration. Spring Data handles all the data access code by using a mechanism that most Spring developers should be familiar with. You also use Spring Data to access SQL databases by using the Java Persistence API (JPA), and to access NoSQL databases like MongoDB.

Spring Data requires you to create two classes:

- A Java bean to hold your data. Annotate the class with the `@RedisHash` Java annotation, to store and retrieve Redis data through a specific key.
- A Spring repository. This repository is a specific Java class that can do database create, retrieve, update, delete (CRUD) operations on the Java bean that stores the data. For example, this class can store one instance of the bean or retrieve a list of beans.

  You can inject this Spring repository into any standard Spring bean. For instance, you can inject the repository into a Spring MVC REST controller, which stores and accesses that data. Proceed to the next unit to implement this configuration.
