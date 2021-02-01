Not every data storage solution is fast enough to meet the requirements of event-driven applications. Especially not, if you expect response times in real time.

## Requirements for storage solutions

_Loose coupling_ is achieved for the price of eventual consistency and potentially replicated data. The storage solutions might need to handle high throughput especially for write access. It might be even necessary to distinguish between the datasets for reading and writing access. In conclusion, the storage solution needs fulfill the following requirements:

1. fast non-blocking write access
2. fast non-blocking read access
3. high throughput
4. scalability
5. for productive systems, as always: SLA

## Cosmos DB

Azure Cosmos DB is a fully managed NoSQL database for modern app development. Single-digit millisecond response times, and automatic and instant scalability, guarantee speed at any scale. Business continuity is assured with SLA-backed availability and enterprise-grade security. App development is faster and more productive thanks to turnkey multi region data distribution anywhere in the world, open-source APIs and SDKs for popular languages. As a fully managed service, Azure Cosmos DB takes database administration off your hands with automatic management, updates, and patching. It also handles capacity management with cost-effective serverless and automatic scaling options that respond to application needs to match capacity with demand.

## Other databases to consider

MongoDB, or Cassandra and others could also be an option you should consider. In this Learn Module, we'll focus on Cosmos DB.
