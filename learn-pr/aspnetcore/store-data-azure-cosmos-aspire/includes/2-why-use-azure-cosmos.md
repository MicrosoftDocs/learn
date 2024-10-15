When you develop a cloud-native application, your microservices may need to scale rapidly to meet demand. Although you may initially expect modest traffic, it's possible that a successful marketing strategy or media story may unexpectedly result in high loads. It's reassuring to use a database system that can respond to expected changes automatically and without putting demands on administrators.

In your outdoor equipment company, your development teams require a robust and scalable database service to support critical microservices such as the product catalog, shopping basket, and customer records store. The teams have experience with a various database servers, including Apache Cassandra and MongoDB. You want to see if Azure Cosmos DB is a logical solution for your needs.

In this unit, you'll learn about Cosmos DB and the Application Development Interfaces (APIs) it supports.

## What is Cosmos DB?

Cosmos DB is a globally distributed cloud database system that can host both NoSQL and relational data. It can scale from small databases up to the largest deployments in terms of storage volume or traffic capacity. It hosts database in the Azure cloud.

A **distributed database** is one that stores data in many different instances or locations. It might take this approach to implement redundancy so that a database is resilient to local failures. It might also be to move data closer to users so that responses are faster.

A **relational database** is one that organizes data into tables with a strict schema and enforces strict relationships between those tables. Relational database support transactions and guarantee data integrity.

A **NoSQL database** is one that can implement lower consistency levels than a relational database to achieve lower data latency and availability. In a NoSQL database, it's easier to change a schema without updating all existing rows and you can choose not to enforce strict relationships between tables. NoSQL databases can be easier to scale and distribute geographically than relational databases.

Cosmos DB is a **Platform-as-a-Service** (PaaS) database system. That means that you don't have to implement or manage the infrastructure that underlies the database service. Azure automatically applies system updates and patches and you can be sure that the system is always running the latest version. When user demand increases, Azure can automatically scale Cosmos DB out to ensure responsiveness.

Cosmos DB supports many different APIs, so you can migrate code written for other database systems to Cosmos DB rapidly. You might also choose to use an API because your development team already has experience of it. Let's examine the APIs.

## Distributed NoSQL databases

There are several different Cosmos DB APIs for NoSQL databases:

- **API for NoSQL**: The NoSQL API is the native API for Cosmos DB and stores data in document format. It has a query syntax similar to Structured Query Language (SQL) from relational databases so it's familiar for many developers.
- **API for MongoDB**: MongoDB is a popular NoSQL database system. If you have code written to interact with MongoDB, you can move your data to Cosmos DB and only change the connection string. This API stores data in the Binary JSON (BSON) document format.
- **API for Apache Cassandra**: Apache Cassandra is another popular distributed NoSQL database system with an open-source code base. It stores data in a column-oriented schema. Use this API if you have existing code written against a Cassandra system or want to continue with your Cassandra tools and expertise.
- **API for Gremlin**: Use this API when you want to store graph databases in Cosmos DB. In a graph database, objects are represented as vertices connected by edges. These databases are suited to describing relationships between many entities, such as personal relationships, mind maps, and interest graphs.
- **API for Table**: Use this API when you have code that stores data in an Azure Storage Account table. The API stores data in key/value format.

## Distributed Relational databases

If you want to create relational databases but still benefit from Cosmos DB's distributed PaaS architecture, consider using the **API for PostgreSQL**. This API is an implementation of SQL is based on the **Citus** extension to PostgreSQL. Citus add support for data distribution and transactions.

## Vector databases

Cosmos DB supports vector databases, in which data is stored as mathematical representations in high-dimensional space. Each dimension of this space measures a feature of the data, and there may be thousands of dimensions. A single point in the space therefore represents an object with many property values. Phrases, entire documents, images, and other types of object can be vectorized to a point in this space. The distance between points in this space can represent the similarity or diversity of those documents.

The data consistency, scalability, and performance that are possible with vector databases are critical requirements for machine learning and AI applications.

Cosmos DB supports vector databases with the NoSQL, MongoDB, and PostgreSQL APIs.

> [!IMPORTANT]
> Cosmos DB is a rich, advanced, and sophisticated product with many aspects. A full discussion of its capabilities is beyond the scope of this .NET Aspire module. For more information, see the Azure Cosmos DB documentation.

## Learn more

- [Azure Cosmos DB documentation](/azure/cosmos-db/)
