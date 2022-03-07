[Azure Cosmos DB](https://azure.microsoft.com/services/cosmos-db/) is a fully managed NoSQL database service for modern app development. It has single-digit millisecond response times and guaranteed speed at any scale.

As a fully managed service, Azure Cosmos DB takes database administration off your hands with automatic management, updates, and patching. It also handles capacity management with cost-effective serverless and automatic scaling options that respond to application needs to match capacity with demand.

Some of the features of Azure Cosmos DB are:

- Automatic and instant scalability.

- Enterprise-grade security.

- Business continuity is assured with 99.999% SLA-backed availability.

- Turnkey multiple region data distribution anywhere in the world.

- Open-source APIs and SDKs for most popular languages.

- Takes care of database administration with automatic management, updates, and patching.

- Build fast with no-ETL analytics over operational data.

 

> [!NOTE] 
> Azure Cosmos DB is flexible and stores data in atom-record-sequence (ARS) format. The data is then abstracted and projected as an API.

 
## Differences between Azure Storage tables and Azure Cosmos DB tables

[Azure Table storage](/azure/storage/tables/table-storage-overview) is a service that stores non-relational structured data (also known as structured NoSQL data) in the cloud, providing a key/attribute store with a schemaless design. Because Table storage is schemaless, it's easy to adapt your data as the needs of your application evolve.. 

:::image type="content" source="../media/table-storage.png" alt-text="Storage account, table, and entity.":::

Common uses of Table storage include:

- Storing TBs of structured data capable of serving web scale applications. For example, you can store any number of entities in a table, and a storage account may contain any number of tables, up to the capacity limit of the storage account.

- Storing datasets that don't require complex joins, foreign keys, or stored procedures. Example datasets include web applications, address books, device information.

- Quickly querying data using a [clustered index](/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described). Access to Table storage data is fast and cost-effective for many types of applications. Table storage is typically lower in cost than traditional SQL for similar volumes of data.

 
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



## What database APIs does Cosmos DB provide?

Azure Cosmos DB offers multiple database APIs, to provide native interface for a range of NoSQL databases. Using these APIs, Azure Cosmos DB helps you to use the ecosystems, tools, and skills you already have for data modeling and querying. 

In this unit, we will examine some real-life scenarios where Core (SQL) API, API for MongoDB, Cassandra API and Gremlin API are applicable. The following diagram summarizes the workflow for selecting an appropriate data storage solution.

:::image type="content" source="../media/cosmos-decision-tree.png" alt-text="Flowchart to select compatible database formats or relational data products.":::



## When to use Core (SQL) API

Let's imagine you work for a company that's an e-commerce retailer that sells automotive parts. The company stores a lot of product catalogs as JSON files. For semi-structured data storage, they've decided to migrate to Azure Cosmos DB. You need to choose an API for Cosmos DB that will:

- Enable fast scaling for new products.

- Supports current querying method of using SQL for JSON data.

Your requirements are:

- Use the team's existing skill set of SQL querying for JSON objects.

- Globally accessible data with guaranteed throughput.

- Support for adding new product categories quickly.

Based on the above criteria, you decide on Core (SQL) API to store the catalog for your customer facing e-commerce site. This API stores data in document format. Why choose Core (SQL) API?

- Single-digit millisecond latency for read and writes.

- Globally distributed database with automatic failover.

- Read and write availability with 99.999% SLA's.

- Leverage provisioned throughput or autoscale.

- Recommended for use cases such as storing cache data, session management repository, user & profile management, and product recommendation.

## When to use MongoDB API

Let's imagine Tailwind Traders uses Mongo DB to store purchase orders for different home improvement products. The products are not limited to any structure and can have many attributes. Tailwind Traders would like to migrate to Azure Cosmos DB. You need to help database staff to choose the right API.

Your requirements are:

- Existing database uses MongoDB to process purchase orders.

- The operations team wants to migrate with few code changes and as little downtime as possible.

- The development team has spent lot of effort on building custom SDK.

- The volume of orders is increasing so scalability needs to be considered.

- There is a need to run analytics against real-time data for business intelligence (BI) use cases.

 

An effective choice here is to pick [MongoDB API for Azure Cosmos DB](/azure/cosmos-db/mongodb/mongodb-introduction). Azure Cosmos DB API for MongoDB implements the wire protocol for MongoDB. You can leverage your MongoDB experience and continue to use your favorite MongoDB drivers, SDKs, and tools by pointing your application to the API for MongoDB account's connection string.

The advantages of MongoDB are described in the next table.

| Advantage| Description |
| - | -|
| Instantaneous scalability| The Autoscale feature allows you to scale your database up/down with zero warmup period. |
| Automatic and transparent sharding| The API for MongoDB manages all of the infrastructure for you. This includes sharding and the number of shards. |
| High Availability| 99.999% availability is configurable. |
| Serverless deployments| This API for Azure Cosmos DB offers a serverless capacity mode. With Serverless, you are only charged per operation, and don't pay for the database when you don't use it. |
| Fast upgrades| All API versions are contained within one codebase, so version changes takes seconds with zero downtime. |
| Real time analytics at scale| This API offers the ability to run complex analytical queries for BI applications against your database data in real time. This is fast because of columnar data store and no ETL pipelines. |


 

## When to use the Cassandra API

Let's imagine you are modeling a solution for a use case involving storing of health tracker data. This also involves telemetry and sensor data. Currently this is being done in Apache Cassandra. You need to help them choose the right API for scaling their database needs.

Your requirements are:

- Your developers are currently using Cassandra Query Language (CQL), Cassandra-based tools (like cqlsh), and Cassandra client drivers

- The solution should support horizontal scaling.

- Online load balancing and cluster growth is desired. 

- There should be a flexible schema.

 

An effective choice here is to pick [Cassandra API for Azure Cosmos DB](/azure/cosmos-db/cassandra/cassandra-introduction). Cassandra API is wire protocol compatible with the Apache Cassandra. This API stores data in column-oriented schema. Cassandra API currently only supports OLTP scenarios. The API supports CQL version 3.x.

 

> [!Note] 
> The serverless capacity mode is now available on Azure Cosmos DB's Cassandra API.

What are the advantages of Cassandra API?

The advantages of using Cassandra API are as follows:

| Feature| Description |
| - | -|
| Built-in tools| Uses native Apache Cassandra features, tools, and ecosystem with the API. |
| Fully managed| The Cassandra API manages the OS, Java VM, garbage collection, read/write performance, nodes, and clusters. You don't need the node tool commands, such as repair and decommission, that are used in Apache Cassandra. |
| Regional writes| The Cassandra API allows you to choose single region or multiple region write configurations. |
| Integration| You can minimize latency by provisioning throughput (RUs) in the Cassandra API. You can configure Azure Cosmos containers in autoscale provisioned throughput. |


 

>[!TIP] 
> The advantage of multiple region write configurations is to maintaining strong consistency across multiple regions and avoid cross-region conflict scenarios.

## When to use the Gremlin API

Let's imagine you are required to analyze and provision a new non-relational database application on Azure ecosystem for Tailwind Traders. You are looking to store social media entity relationships and be able to traverse them quickly in the database.

Your requirements are:

- Store, retrieve, and manipulate graph data and visualize it using Data Explorer.

- Process high volumes of transactions without affecting performance.

- Overcome traditional graph database limitations of flexibility and relational approaches.

- Users should have capability of working with Graph query language to ingest and query data.

An effective choice here is to pick [Azure Cosmos DB's Gremlin API](/azure/cosmos-db/graph/graph-introduction) which is based on the Apache TinkerPop. Apache TinkerPop is a graph computing framework that uses the Gremlin query language. A graph is a structure that's composed of vertices and edges. Vertices represent objects and edges denote the relationships between vertices.

Use cases for this type of database are storing organizational hierarchies, online fraud detection systems, social media graphs, and IoT. Gremlin API currently only supports online transactional processing (OLTP) scenarios.


## What are the advantages of Gremlin API?

- Gremlin API has a wire protocol support with the open-source Gremlin, so you can use the open-source Gremlin SDKs to build your application.

- You can store massive graphs with billions of vertices and edges. The data will be automatically distributed using graph partitioning allowing to elastically scale throughput and storage.

- You can query the graphs with millisecond latency and evolve the graph structure easily.

- Gremlin API also works with Apache Spark and GraphFrames for complex analytical graph scenarios.

- Multi-region replication provides automatic regional failover mechanism to ensure the continuity of your application.