In general, NoSQL databases like Azure Cosmos DB are characterized as being both horizontally scalable and nonrelational.

## Horizontal scale versus vertical scale

Relational databases typically grow by increasing the size of the VM or compute that they're hosted on. NoSQL databases scale by adding more servers, also known as *partitions*, to store increasing amounts of data. Data stored on other partitions needs to be organized so that it can be efficiently accessed later. 

Data is routed to different partitions by using the value of a required property on each document. This property then becomes that container's *partition key* and is specified when you create the container. Passing the partition key when data is written or read from a container helps ensure that operations are efficient, routing only to the partitions storing that data.

Although this process might appear to be constraining when the database is accessing data, it has some enormous benefits. Typically, unsharded relational databases can grow to only 4 TB. A NoSQL database can grow to unlimited size. It does so without any change in response times when it's accessing data from a single partition. 

A NoSQL database can provide the same latency whether the database is 1 MB or 1 PB. Also, as partitions are added, so too is more compute in the form of additional throughput capacity. So the amount of processing that can occur simultaneously also grows.

## Nonrelational versus relational databases

The second defining characteristic of a NoSQL database is that there are no foreign keys, constraints, joins, or enforced relationships of any kind between pieces of data. Because data in a NoSQL database is stored on different physical servers, enforcing constraints or relationships by placing locks on data might result in negative or unpredictable performance. 

Azure Cosmos DB is designed to provide high and predictable performance. So it doesn't put any locks on data. However, you can manage relational data and relationships in Azure Cosmos DB. It just uses different mechanisms to do it.

:::image type="content" source="../media/2-horizontal-scale-non-relational.png" alt-text="Diagram that shows the horizontal scale for Azure Cosmos DB." border="false":::

## Why are these database types so different?

Understanding how the economics of computing has changed since relational databases were first introduced can help explain why these two types of databases are so different.

When relational databases were invented in 1970, the cost of storage relative to compute was high. The goal of normalizing a database model was to reduce duplicate data and thus cost within a database. Then the database engine would apply locks and latches to enforce strict ACID (atomicity, consistency, isolation, durability) semantics. The locks on data ensured consistent data, but with trade-offs in concurrency, latency, and availability.

Today, the cost of storage relative to compute is cheap. Compute is expensive, and it's compute that processes requests on data. With workloads requiring increasing levels of concurrency and availability and lower latencies, there's a need for a new type of database that's optimized for these requirements. 

For this reason, the goal in modeling data for a NoSQL database is to read or write data in a compute-efficient manner. Because relational operators like joins don't exist in a NoSQL database, data must be stored as the application uses it. Often data needs to be denormalized, duplicated, or otherwise stored in a way that breaks most design goals for normalized data storage.

## Can you use NoSQL for relational workloads?

At this point, you might be wondering whether NoSQL databases are appropriate to use for relational workloads. And the answer is yes! NoSQL databases can absolutely be used for workloads where relationships between different entities exist. NoSQL databases are often used when a relational database can't meet the desired performance or availability needs.

The techniques for designing a NoSQL database are different from the techniques for modeling data for a relational database. They're also not intuitive. Best practices that you learn for building relational databases don't translate well and are often antipatterns when you're designing for a NoSQL database.

For the remainder of this module and in the advanced modeling module, we'll go step by step in demonstrating the techniques to model data that will result in a high-performance NoSQL database.
