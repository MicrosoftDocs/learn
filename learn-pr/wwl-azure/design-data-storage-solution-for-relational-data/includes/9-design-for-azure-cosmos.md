The final option we consider is relational table data storage using Azure Cosmos DB.

[Azure Cosmos DB](https://azure.microsoft.com/services/cosmos-db/) is a fully managed NoSQL database service for modern app development. As a fully managed service, Azure Cosmos DB takes database administration off your hands with automatic management, updates, and patching. It also handles capacity management with cost-effective serverless and automatic scaling options that respond to application needs to match capacity with demand.

### Things to know about Azure Cosmos DB

Review the following characteristics of Azure Cosmos DB and how it can help with relational data storage.

- Azure Cosmos DB has single-digit millisecond response times and guaranteed speed at any scale. 

- Applications that are written for Azure Table Storage can migrate to the Azure Cosmos DB Table API with few code changes.

- Azure Cosmos DB Table API and Table Storage share the same table data model and expose the same create, delete, update, and query operations through their SDKs.

### Things to consider when using the Azure Cosmos DB Table API

If you currently use Azure Table Storage, you gain many benefits by moving to the Azure Cosmos DB Table API. As you review these benefits, consider how Azure Cosmos DB can be included in your relational data storage plan for Tailwind Traders:

| Feature| Azure Table Storage | Azure Cosmos DB Table API |
| --- | ---| --- |
| **Latency** | Fast, but no upper bounds on latency. | Single-digit millisecond latency for reads and writes, backed with < 10-ms latency reads and < 15-ms latency writes at the 99th percentile, at any scale, anywhere in the world. |
| **Throughput** | Variable throughput model. Tables have a scalability limit of 20,000 operations.| Highly scalable with dedicated reserved throughput per table. Accounts have no upper limit on throughput and support > 10 million operations/s per table (in provisioned throughput mode). |
| **Global distribution** | Single region with one optional readable secondary read region for high availability. | Turnkey global distribution from one to 30+ regions. |
| **Indexing** | Only primary index on PartitionKey and RowKey. No secondary indexes. | Automatic and complete indexing on all properties, no index management. |
| **Query** | Query execution uses index for primary key, and scans otherwise. | Queries can take advantage of automatic indexing on properties for fast query times. |
| **Consistency** | Strong within primary region. | Five well-defined consistency levels to trade off availability, latency, throughput, and consistency. |
| **Pricing** | Consumption-based pricing model. | Available in both consumption-based and provisioned capacity pricing models. |
| **SLAs** | 99.99% availability | 99.99% availability SLA for all single region accounts and all multi-region accounts with relaxed consistency, and 99.999% read availability on all multi-region database accounts. |