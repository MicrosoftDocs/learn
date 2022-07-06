Azure Cosmos DB offers multiple database APIs, which include the Core (SQL) API, API for MongoDB, Cassandra API, Gremlin API, and Table API. By using these APIs, you can model real world data using documents, key-value, graph, and column-family data models. These APIs allow your applications to treat Azure Cosmos DB as if it were various other databases technologies, without the overhead of management, and scaling approaches.

## Core(SQL) API

This API stores data in document format. It offers the best end-to-end experience as we have full control over the interface, service, and the SDK client libraries. Any new feature that is rolled out to Azure Cosmos DB is first available on SQL API accounts. Azure Cosmos DB SQL API accounts provide support for querying items using the Structured Query Language (SQL) syntax, one of the most familiar and popular query languages.

If you are migrating from other databases such as Oracle, DynamoDB, HBase etc. SQL API is the recommended option. SQL API supports analytics and offers performance isolation between operational and analytical workloads.

## API for MongoDB

This API stores data in a document structure, via BSON format. It is compatible with MongoDB wire protocol; however, it does not use any native MongoDB related code. This API is a great choice if you want to use the broader MongoDB ecosystem and skills, without compromising on using Azure Cosmos DB’s features such as scaling, high availability, geo-replication, multiple write locations, automatic and transparent shard management, transparent replication between operational and analytical stores, and more. You can use your existing MongoDB apps with API for MongoDB by just changing the connection string.

API for MongoDB is compatible with the 4.0, 3.6, and 3.2 MongoDB server versions. Server version 4.0 is recommended as it offers the best performance and full feature support

## Cassandra API

This API stores data in column-oriented schema. Cassandra API is wire protocol compatible with the Apache Cassandra. You should consider Cassandra API if you want to benefit the elasticity and fully managed nature of Azure Cosmos DB and still use most of the native Apache Cassandra features, tools, and ecosystem. This means on Cassandra API you don’t need to manage the OS, Java VM, garbage collector, read/write performance, nodes, clusters, etc.

You can use Apache Cassandra client drivers to connect to the Cassandra API. The Cassandra API enables you to interact with data using the Cassandra Query Language (CQL), and tools like CQL shell, Cassandra client drivers that you're already familiar with. Cassandra API currently only supports OLTP scenarios. Using Cassandra API, you can also use the unique features of Azure Cosmos DB such as change feed.

## Table API

This API stores data in key/value format. If you are currently using Azure Table storage, you may see some limitations in latency, scaling, throughput, global distribution, index management, low query performance. Table API overcomes these limitations and it’s recommended to migrate your app if you want to use the benefits of Azure Cosmos DB. Table API only supports OLTP scenarios.

Applications written for Azure Table storage can migrate to the Table API with little code changes and take advantage of premium capabilities.

## Gremlin API

This API allows users to make graph queries and stores data as edges and vertices. Use this API for scenarios involving dynamic data, data with complex relations, data that is too complex to be modeled with relational databases, and if you want to use the existing Gremlin ecosystem and skills. Gremlin API currently only supports OLTP scenarios.
