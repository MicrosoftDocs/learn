Azure Cosmos DB is a NoSQL database. In general, NoSQL databases are characterized as being both horizontally scalable and non-relational.

## Horizontal scale versus vertical scale

Relational databases typically grow by increasing the size of the VM or compute they are hosted on. NoSQL databases, scale by adding more servers, also known as *partitions*, to store increasing amounts of data. Data stored on additional partitions needs to be organized so that it can be efficiently accessed later. Data is routed to different partitions by using the value of a required property on each document known as the *partition key*. Passing the partition key when data is written or read from a container, ensures operations are efficient, routing only to the partitions storing that data.

While this process may appear to be constraining when accessing data, it has some enormous benefits. Typically unsharded relational databases can only grow to 4 TB in size. However, a NoSQL database can grow to unlimited size. It also does so without any change in response times when accessing data from a single partition. A NoSQL database can provide the same latency whether the database is 1 MB in size or 1 PB in size. Also, as partitions are added, so too is more compute in the form of additional throughput capacity. So the amount of processing that can occur simultaneously also grows.

## Non-relational versus relational databases

The second defining characteristic of a NoSQL database is there are no foreign keys, constraints, joins, or enforced relationships of any kind between data. Because data in a NoSQL database is stored on different physical servers, enforcing constraints or relationships by placing locks on data could result in negative or unpredictable performance. Azure Cosmos DB is designed to provide high and predictable performance. So it doesn't put any locks on data. However, you can manage relational data and relationships in Azure Cosmos DB. It just uses different mechanisms to do it.

:::image type="content" source="../media/2-horizontal-scale-non-relational.png" alt-text="Diagram that shows the horizontal scale for Azure Cosmos DB." border="false":::

## Why are these database types so different?

Understanding how the economics of computing has changed since relational databases were first introduced to today can help explain why these two types of databases are so different.

When relational database was invented in 1970 the cost of storage relative to compute was relatively high. The objective of normalizing a database model was to reduce duplicate data and thus cost within a database. Then the database engine would apply locks and latches to enforce strict ACID semantics. This ensures consistent data but with trade-offs with respect to concurrency, latency and availability.

Today the cost of storage relative to compute is cheap. Compute is expensive and it is compute which processes requests on data. Additionally, with workloads requiring increasing levels of concurrency and availability and lower latencies, a new type of database optimized for these requirements is needed. For this reason, the objective when modeling data for a NoSQL database is read or write data in a compute efficient manner. Since relational operators like joins don't exist in a NoSQL database, data must be stored such as the application uses it. Often data needs to be denormalized, duplicated, or otherwise stored in a way that breaks most design goals for normalized data storage.

## Can you use NoSQL for relational workloads?

At this point, you may be wondering whether NoSQL databases are appropriate to use for relational workloads. And the answer is yes! NoSQL databases can absolutely be used for workloads where relationships between different entities exist. NoSQL databases are often used when a relational database can't meet the desired performance or availability needs.

The techniques used to design for a NoSQL database are very different than modeling data for a relational database. They are also not intuitive. Best practices you learn for building  relational databases don't translate well and are often anti-patterns when designing for a NoSQL database.

For the remainder of this module and in the advanced modeling module, we will go step by step demonstrating the techniques to model data that will result in a high-performance NoSQL database.
