
## NoSQL versus relational databases
Azure Cosmos DB is a NoSQL database. In general, NoSQL databases are characterized as being both horizontally scalable and non-relational.

Relational databases typically grow by increasing the size of the VM or compute they are hosted on. NoSQL databases, scale by adding additional servers to store increasing amounts of data. Data stored on additional servers needs to be organized so that it can be accessed later. Simply put data is partitioned by identifying a property of the document that will be used to route the it to the correct server. This property is known as a partition key and the servers are referred to as partitions. To ensure the most efficient operations, the partition key is passed with the data to route to the correct partition to be read or written.

While this may appear to be constraining when accessing data, it has some enormous benefits. Typically an un-sharded relational databases can only grow to 4 TB in size. However, a NoSQL database can grow to unlimited size. It also does so without any change in response times when accessing data from a single partition. This means a NoSQL database can provide the same latency whether the database is 1 MB in size or 1 PB in size. Additionally, as partitions are added, so too is additional throughput capacity, meaning the amount of processing that can occur simultaneously grows as well.

The second defining characteristic of a NoSQL database is there are no foreign keys, constraints, joins or enforced relationships of any kind between data that spans partitions. Since data in a NoSQL database is stored on different physical servers, enforcing constraints or relationships by placing locks on data could result in negative or unpredictable performance. Azure Cosmos DB is designed to provide high and predictable performance so does not put any locks on data. However, you can manage relational data and relationships in Azure Cosmos DB. It just uses different mechanisms to do it.

:::image type="content" source="../media/horizontal-scale-non-relational.png" alt-text="horizontal scale and non-relational":::

Understanding how the economics of computing has changed since relational databases were first introduced to today can help explain why these two types of databases are so different.

When relational database was invented in 1970 the cost of storage relative to compute was relatively high. This is one reason why normalization seeks to reduce duplicate data within a database. Today the cost of storage relative to compute is cheap. Compute is expensive and it is compute which processes requests on data. For this reason, the objective when modeling data for a NoSQL database is read or write data in a compute efficient manner. Since relational operators like joins don't exist in a NoSQL database, data must be stored such as the application uses it. This often means data needs to be denormalized, duplicated or otherwise stored in a way that breaks most design goals for normalized data storage.

At this point you may be wondering whether NoSQL databases are appropriate to use for relational workloads. And the answer is yes! NoSQL databases can absolutely be used for workloads where relationships between different entities exist. NoSQL databases are often used when a relational database cannot meet the desired performance or availability needs.

The techniques used to design for a NoSQL database are very different than modeling data for a relational database. They are also not very intuitive. Best practices learned building for relational databases do not translate well and are often anti-patterns when designing for a NoSQL database.

For the remainder of this module and in the advanced modeling module following this, we will go step by step demonstrating the techniques to model data that will result in a high-performance NoSQL database.