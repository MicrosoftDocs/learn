In general, NoSQL databases like Azure Cosmos DB are characterized as being both horizontally scalable and nonrelational.

## Horizontal scale versus vertical scale

Relational databases typically grow by increasing the size of the VM or compute that they're hosted on. NoSQL databases scale up by adding more servers or nodes. These nodes are also known as physical partitions in Cosmos DB. Data stored on these physical partitions needs to be organized so that it can be efficiently accessed later. 

Data is predictably routed to different physical partitions by using the value of a required property on each document. This property is called a container's *partition key*, this partition key needs to be specified when creating the container. Passing the partition key when data is written or read from a container ensures that operations are efficient.

Although the need for a partition key might appear to be constraint, it has some enormous benefits. Typically, relational database possibly will grow to less than 100 TB at most. A NoSQL database can grow to unlimited size, and can do so without any impact on response times when it's accessing data from any single partition. 

Additionally, as partitions are added, so too is more compute added and the amount of processing that is supported by the database simultaneously grows.

## Nonrelational versus relational databases

The second defining characteristic of a NoSQL database is that there are no foreign keys, constraints, or enforced relationships of any kind between pieces of data. Because data in a NoSQL database is stored on different physical servers, enforcing constraints or relationships, or placing locks on data would result in negative or unpredictable performance. 

However, not having enforced relationships doesn't mean that you can't manage entities that have relationships in a NoSQL database, it just means that you need to do it differently.

## Why are these database types so different?

Understanding how the economics of computing has changed since relational databases were first introduced can help explain why these two types of databases are so different.

When relational databases were invented in 1970, the cost of storage and memory were relative to compute was high. The goal of normalizing a database model was to reduce duplicate data and thus cost within a database. The database engine would apply locks and latches to enforce strict ACID (atomicity, consistency, isolation, durability) semantics as it performed operations on all the needed pieces of data together. The locks on data ensured consistent data, but with trade-offs in concurrency, latency, and availability.

Today, the cost of storage and memory is relatively cheap compared to compute, thus, to be cost effective we no longer need optimize for storage efficiency. With workloads requiring increasing levels of concurrency and availability and lower latencies, there was a need for a new type of database that's optimized for these requirements, and so NoSQL databases were born. 

It is also for these reasons, that one of the goals in modeling data for a NoSQL database is to do so in a manner that ensures reading or writing data is compute-efficient. In-part because relational operators like cross-document joins don't exist in NoSQL databases, data must be stored as the application uses it for it to be the most efficient. Often data needs to be denormalized, duplicated, or otherwise stored in a way that breaks many of the relational normalization rules that are used for relational data modeling.

## Can you use NoSQL for relational workloads?

At this point, you might be wondering whether NoSQL databases are appropriate to use for relational workloads. And the answer is yes! NoSQL databases can absolutely be used for workloads where relationships between different entities exist. 

NoSQL databases are often used when a relational database can't meet the desired performance, scale, or availability needs of the application.

The techniques for designing a NoSQL database are different from the techniques for modeling data for a relational database. These techniques are also not intuitive for someone with a background in relational database design. Some of the best practices that you learn for building relational databases don't translate well to non-relational database design. Those relational database best practices are often antipatterns when you're designing for a NoSQL database.

For the rest of this module and in the advanced modeling module, we'll step you through the techniques that are used to model data in a manner that will result in a high-performance NoSQL database.
