Azure Cosmos DB allows developers to choose among the five consistency models: strong, bounded staleness, session, consistent prefix and eventual. Each of these consistency models can be used for specific real-world scenarios. Each provides precise availability and performance tradeoffs and are backed by comprehensive SLAs. The following simple considerations will help you make the right choice in many common scenarios.

## SQL API and Table API

Consider the following points if your application is built using SQL API or Table API:

* For many real-world scenarios, session consistency is optimal and it's the recommended option. 

* If your application requires strong consistency, it is recommended that you use bounded staleness consistency level.

* If you need stricter consistency guarantees than the ones provided by session consistency and single-digit-millisecond latency for writes, it is recommended that you use bounded staleness consistency level.

* If your application requires eventual consistency, it is recommended that you use consistent prefix consistency level.

* If you need less strict consistency guarantees than the ones provided by session consistency, it is recommended that you use consistent prefix consistency level.

* If you need the highest throughput and the lowest latency, then use eventual consistency level.

* If you need even higher data durability without sacrificing performance, you can create a custom consistency level at the application layer. 

## Cassandra, MongoDB, and Gremlin APIs

Azure Cosmos DB provides native support for wire protocol-compatible APIs for popular databases. These include MongoDB, Apache Cassandra, and Gremlin. When using Gremlin API the default consistency level configured on the Azure Cosmos account is used. For details on consistency level mapping between Cassandra API or the API for MongoDB and Azure Cosmos DB's consistency levels see, [Cassandra API consistency mapping](/azure/cosmos-db/cassandra/apache-cassandra-consistency-mapping) and [API for MongoDB consistency mapping](/azure/cosmos-db/mongodb/consistency-mapping).

## Consistency guarantees in practice

In practice, you may often get stronger consistency guarantees. Consistency guarantees for a read operation correspond to the freshness and ordering of the database state that you request. Read-consistency is tied to the ordering and propagation of the write/update operations.

* When the consistency level is set to **bounded staleness**, Cosmos DB guarantees that the clients always read the value of a previous write, with a lag bounded by the staleness window.

* When the consistency level is set to **strong**, the staleness window is equivalent to zero, and the clients are guaranteed to read the latest committed value of the write operation.

* For the remaining three consistency levels, the staleness window is largely dependent on your workload. For example, if there are no write operations on the database, a read operation with **eventual**, **session**, or **consistent prefix** consistency levels is likely to yield the same results as a read operation with strong consistency level.

If your Azure Cosmos account is configured with a consistency level other than the strong consistency, you can find out the probability that your clients may get strong and consistent reads for your workloads by looking at the *Probabilistically Bounded Staleness* (PBS) metric. 

Probabilistic bounded staleness shows how eventual your eventual consistency is. This metric provides an insight into how often you can get a stronger consistency than the consistency level that you have currently configured on your Azure Cosmos account. In other words, you can see the probability (measured in milliseconds) of getting strongly consistent reads for a combination of write and read regions.