While your Azure Cache for Redis instance deploys, read the following sections to learn more about the following technologies:

- Redis and Azure Cache for Redis.
- Redis with Java and Spring Boot applications.
- Spring Data Redis distributed cache.

## Redis and Azure Cache for Redis

[Redis](https://redis.io/) is a BSD-licensed, open-source distributed in-memory data store with optional durability that acts as a cache and message broker. Redis is one of the most popular key-value databases, with ease of use, performance, and scalability that make it an excellent choice for application developers.

[Azure Cache for Redis](https://azure.microsoft.com/services/cache) is a managed version of Redis that Azure maintains and operates in the cloud. Azure Cache for Redis offers all the benefits of Redis, including high throughput and performance to handle millions of requests per second. Azure also provides the advantages of a managed cloud service, like automatic patches, updates, scaling, and provisioning.

Azure Cache for Redis offers several service tiers. The advanced tiers provide clustering, geo-replication, and high availability for the most critical workloads.

## Azure Cache for Redis use cases

Redis and Azure Cache for Redis provide the following main use cases:

- A *distributed cache* speeds up applications that rely on SQL databases. Redis can lower the cost of an application, because scaling a Redis cluster is cheaper than scaling a database.
- An *HTTP session data store* stores session data, which allows scaling of session-based applications. Applications that use JavaServer Faces (JSF) or that store security data in the user session typically use this mechanism.
- A *message broker* solution implements publish/subscribe or queue architectures.

## Use Redis with Java

Redis doesn't provide an official library for Java developers, but there are several open-source libraries. One of your main decisions as a Java developer is to select the library that best fits your needs. The most popular are the following libraries.

- [Jedis](https://github.com/redis/jedis) is the most used library, and is simple and easy to use.
- [Lettuce](https://github.com/lettuce-io/lettuce-core) is the library this module uses, because it comes bundled with Spring Data for Redis. Lettuce has great asynchronous support, which is important if you want to create a reactive Spring application.
- [Redisson](https://github.com/redisson/redisson) is the most advanced Redis client. You can use Redisson as a Hibernate second-level cache if you need that feature.

## Use Spring Data Redis to create a distributed cache

To create a distributed cache by using Redis with Spring Boot, typically with [Spring Initializr](https://start.spring.io/), you do three main tasks:

1. Add the Spring Data Redis library to your application.
1. Configure your *application.yml* file to connect to your Azure Cache for Redis instance.
1. Code business logic by using Spring Data Redis to store and retrieve data from the cache.

The current module uses the Lettuce library, but you don't need to use the library directly unless you need advanced configuration. Spring Data handles the data access code by using a mechanism that most Spring developers should be familiar with. You can also use Spring Data to access SQL databases by using the Java Persistence API (JPA), and to access NoSQL databases like MongoDB.

Spring Data requires you to create the following classes:

- A Java bean to hold your data. You annotate the class with the `@RedisHash` Java annotation to store and retrieve Redis data through a specific key.
- A Spring repository. This repository is a specific Java class that can do database create, retrieve, update, delete (CRUD) operations on the Java bean that stores the data. For example, this class can store one instance of the bean or retrieve a list of beans.

  You can inject this Spring repository into any standard Spring bean. For instance, you can inject the repository into a Spring MVC REST controller, which stores and accesses the repository data.

Proceed to the next unit to create a Spring Boot application with a distributed cache that uses Spring Data Redis. You can create the application while you wait for your Azure Cache for Redis cache to finish deploying.
