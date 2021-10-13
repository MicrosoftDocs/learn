[Azure Table storage](/azure/storage/tables/table-storage-overview) is a service that stores non-relational structured data (also known as structured NoSQL data). Table storage provides a key/attribute store with a schemaless design. Your tables will scale as demand increases. 

:::image type="content" source="../media/table-storage.png" alt-text="Storage account, table, and entity.":::


Common uses of Table storage include:

- Storing TBs of structured data capable of serving web scale applications. For example, you can store any number of entities in a table, and a storage account may contain any number of tables, up to the capacity limit of the storage account.

- Storing datasets that don't require complex joins, foreign keys, or stored procedures. Example datasets include web applications, address books, device information.

- Quickly querying data using a [clustered index](/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described). Access to Table storage data is fast and cost-effective for many types of applications. Table storage is typically lower in cost than traditional SQL for similar volumes of data.

 

## Differences between Azure Storage tables and Azure Cosmos DB tables

Azure Table storage is a service that stores non-relational structured data (also known as structured NoSQL data) in the cloud, providing a key/attribute store with a schemaless design. Because Table storage is schemaless, it's easy to adapt your data as the needs of your application evolve.. 

Azure Cosmos DB provides the Table API for applications that are written for Azure Table storage and that need premium capabilities like high availability, scalability, and dedicated throughput.

There are some differences in behavior between Azure Storage tables and Azure Cosmos DB tables to remember if you are considering a migration. For example:

- You are charged for the capacity of an Azure Cosmos DB table as soon as it is created, even if that capacity isn't used. This charging structure is because Azure Cosmos DB uses a reserved-capacity model to ensure that clients can read data within 10 ms. In Azure Storage tables, you are only charged for used capacity, but read access is only guaranteed within 10 seconds.

- Query results from Azure Cosmos DB are not sorted in order of partition key and row key as they are from Storage tables.

- Row keys in Azure Cosmos DB are limited to 255 bytes.

- Batch operations are limited to 2 MBs.

- Cross-Origin Resource Sharing (CORS) is supported by Azure Cosmos DB.

- Table names are case-sensitive in Azure Cosmos DB. They are not case-sensitive in Storage tables.

While these differences are small, you should take care to review your apps to ensure that a migration does not cause unexpected problems.

## Other benefits to moving to Cosmos DB

Applications written for Azure Table storage can migrate to the Cosmos DB Table API with few code changes. Azure Cosmos DB Table API and Azure Table storage share the same table data model and expose the same create, delete, update, and query operations through their SDKs.

If you currently use Azure Table Storage, you gain the following benefits by moving to the Azure Cosmos DB Table API:

| Feature| Azure Table Storage| Azure Cosmos DB Table API |
| - | -| - |
| Latency| Fast, but no upper bounds on latency.| Single-digit millisecond latency for reads and writes, backed with <10-ms latency reads and <15-ms latency writes at the 99th percentile, at any scale, anywhere in the world. |
| Throughput| Variable throughput model. Tables have a scalability limit of 20,000 operations.| Highly scalable with dedicated reserved throughput per table that's backed by SLAs. Accounts have no upper limit on throughput and support >10 million operations/s per table (in provisioned throughput mode). |
| Global distribution| Single region with one optional readable secondary read region for high availability.| Turnkey global distribution from one to 30+ regions. |
| Indexing| Only primary index on PartitionKey and RowKey. No secondary indexes.| Automatic and complete indexing on all properties, no index management. |
| Query| Query execution uses index for primary key, and scans otherwise.| Queries can take advantage of automatic indexing on properties for fast query times. |
| Consistency| Strong within primary region| Five well-defined consistency levels to trade off availability, latency, throughput, and consistency. |
| Pricing| Consumption-based| Available in both consumption-based and provisioned capacity modes. |
| SLAs| 99.99% availability| 99.99% availability SLA for all single region accounts and all multi-region accounts with relaxed consistency, and 99.999% read availability on all multi-region database accounts. |