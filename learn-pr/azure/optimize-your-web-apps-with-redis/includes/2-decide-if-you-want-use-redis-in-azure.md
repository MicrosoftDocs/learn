Behind your sports website is a database, which returns data by executing queries. However, performance slows down when the load is high, particularly during large sporting events. In hosted environments, increased resource usage translates into higher costs. Caching data ensures your website will perform well and run economically.

## What is caching?

Caching is the act of storing frequently-accessed data in memory that is very close to the application that consumes the data. Caching is used to increase performance and reduce the load on your servers. We use Redis to create an in-memory cache that can provide excellent latency and potentially improve performance.

## What is a Redis cache?

Redis (**RE**mote **DI**ctionary **S**erver) cache is an open-source, in-memory key value pair store. It's popular because it's fast and can store and manipulate common data types such as strings, hashes, and sets. It's also considered developer friendly as it supports multiple languages such as Python, C, C++, C#, Java, and JavaScript among others.

## What is Azure Cache for Redis?

Azure Cache for Redis is based on the popular open-source Redis cache. It gives you access to a secure, dedicated Redis cache, managed by Microsoft. A cache created using Azure Cache for Redis is accessible from any application within Azure. Azure Cache for Redis is typically used to improve the performance of systems that rely heavily on back-end data stores.

Your cached data is located in-memory on an Azure server running the Redis cache as opposed to being loaded from disk by a database. Your cache is also highly scalable. You can alter the size and pricing tier at any time.

## What type of data can be stored in the cache?

Redis supports a variety of data types all oriented around _binary safe_ strings. This means that you can use any binary sequence for a value, from a string like "i-love-rocky-road" to the contents of an image file. An empty string is also a valid value.

- Binary-safe strings (most common)
- Lists of strings
- Unordered sets of strings
- Hashes
- Sorted sets of strings
- Maps of strings

Each data value is associated to a _key_ which can be used to lookup the value from the cache. Redis works best with smaller values (100k or less), so consider chopping up bigger data into multiple keys. Storing larger values is possible (up to 500 MB), but increases network latency and can cause caching and out-of-memory issues if the cache isn't configured to expire old values.

## What is a Redis key?
Redis keys are also binary safe strings. Here are some guidelines for choosing keys:

- Avoid long keys. They take up more memory and require longer lookup times because they have to be compared byte-by-byte. If you want to use a binary blob as the key, generate a unique hash and use that as the key instead. The maximum size of a key is 512 MB, but you should _never_ use a key that size.
- Use keys which can identify the data. For example, "sport:football;date:2008-02-02" would be a better key than "fb:8-2-2". The former is more readable and the extra size is negligible. Find the balance between size and readability.
- Use a convention. A good one is "object:id", as in "sport:football". 

## How is data stored in a Redis cache?

Data in Redis is stored in _**nodes**_ and _**clusters**_.

**Nodes** are a space in Redis where your data is stored.

**Clusters** are sets of three or more nodes your dataset is split across. Clusters are useful because your operations will continue if a node fails or is unable to communicate to the rest of the cluster.

## What are Redis caching architectures?

Redis caching architecture is how we distribute our data in the cache. Redis distributes data in three major ways:

1. **Single node**
1. **Multiple node**
1. **Clustered**

Redis caching architectures are split across Azure by tiers:

### Basic cache

A basic cache provides you with a _**single node**_ Redis cache. The complete dataset will be stored in a single node. This tier is ideal for development, testing, and non-critical workloads.

### Standard cache

The standard cache creates _**multiple node**_ architectures. Redis replicates a cache in a two-node primary/secondary configuration. Azure manages the replication between the two nodes. This is a production-ready cache with master/slave replication.

### Premium tier

The premium tier includes the features of the standard tier but adds the ability to persist data, take snapshots, and back up data. With this tier, you can create a Redis cluster that shards data across multiple Redis nodes to increase available memory. The premium tier also supports an Azure Virtual Network to give you complete control over your connections, subnets, IP addressing, and network isolation. This tier also includes geo-replication, so you can ensure your data is close to the app that's consuming it.

## Summary

A database is great for storing large amounts of data, but there is an inherent latency when looking up data. You send a query. The server interprets the query, looks up the data, and returns it. Servers also have capacity limits for handling requests. If too many requests are made, data retrieval will likely slow down. Caching will store frequently requested data in memory that can be returned faster than querying a database, which should lower latency and increase performance. Azure Cache for Redis gives you access to a secure, dedicated, and scalable Redis cache, hosted in Azure, and managed by Microsoft.
