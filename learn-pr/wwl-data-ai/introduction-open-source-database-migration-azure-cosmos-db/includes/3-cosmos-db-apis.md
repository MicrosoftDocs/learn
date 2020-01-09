As well as scalability, availability, and low latency along with global distribution mentioned in the previous lesson, Cosmos DB had a design goal of supporting multiple data models.

To support multiple data models, Cosmos DB uses an API for each data model that provides projections of containers and items as familiar objects to that data model. This enables existing NoSQL databases to be migrated to Cosmos DB with minimal disruption while taking advantage of the benefits of the underlying Cosmos DB engine.
For more information, see [A technical overview of Cosmos DB](https://aka.ms/AA58ejj)

## Cosmos DB APIs

Cosmos DB includes multiple APIs that provide mappings for native applications to the Cosmos DB engine. These include the following, but the list will expand as more APIs are developed, including the etcd API for Kubernetes.

### SQL
The SQL API is the core API for Cosmos DB and the SQL API was originally the DocumentDB interface. If you are creating a new database with no need to support pre-existing apps, it makes most sense to use the SQL API.

### Cassandra
The Cassandra API enables apps written for Apache Cassandra to interface with the Cosmos DB engine. The apps can use Cassandra terms for objects, the Cassandra Query Language (CQL), Cassandra drivers, and Cassandra tools.

### MongoDB
The Cosmos DB MongoDB is compatible with the MongoDB wire protocol version 3.2 with version 3.4 in preview. Applications created to support these protocols should be able to connect to the Cosmos DB MongoDB API.

### Gremlin
Gremlin is the Apache Tinkerpop graph traversal language. The Gremlin API enables you to create graph entities in Cosmos DB.

### Table
The Cosmos DB Table API supports applications created for Azure Table storage while providing the scalability and availability advantages of Cosmos DB.
