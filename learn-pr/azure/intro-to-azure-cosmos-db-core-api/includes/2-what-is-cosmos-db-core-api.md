Let's start with a few definitions and a quick tour through Azure Cosmos DB. This overview should help you see whether Azure Cosmos DB might be a good fit for your work.

## What is a relational database?

Relational databases have been the prevalent type of database used in many workloads and applications for decades. Relational databases organize the data as a set of two-dimension tables organized using rows and columns. Relational database engines typically use a series of locks and latches to enforce strict adherence to [ACID (atomicity, consistency, isolation, durability)](https://en.wikipedia.org/wiki/ACID) guarantees.

:::image type="content" source="../media/2-relational-db.svg" alt-text="Illustration of a tabular data store with rows and columns, and a single row selected" border="false":::

Relational databases are popular because they are mature, widely proven, and ensure strong consistency. Relational databases also require a significant time investment up-front to design a fixed schema for a data workload. The pre-designed fixed schema is then later used in SQL (Structured Query Language) queries.

## What is a NoSQL database?

Many modern applications require high performance for operations and high-availability for mission critical workloads. NoSQL databases are designed to meet these needs. NoSQL databases generally do not enforce relational constraints or put locks on data, making writes very fast. They are also often horizontally scalable via sharding or partitioning, which allows them to maintain high-performance regardless of size.

:::image type="content" source="../media/2-nosql-db.svg" alt-text="Illustration of various NoSQL models including; a key-value store with a one-to-one relationship between identifiers and values, a document store with a hierarchy of entities, a graph store with traversal paths, and a column family store with multiple columns" border="false":::

## Why use a distributed NoSQL database?

High transaction workloads can necessitate that a data workload is manually sharded across multiple data stores in various regions or datacenters. Manual sharding is a time consuming and difficult process to implement. *Distributed databases* are NoSQL database solutions that are designed, from the onset, to be distributed across multiple compute and storage nodes in a manner that can be scaled.

NoSQL databases are often distributed, both by storing data in multiple local replicas as well as storing data across large distances over a network, providing resiliency to both local failures as well as regional outages.

> [!TIP]
> Maintenance of a distributed database can still be a costly and time-consuming factor. When considering a distributed database system, consider how much maintenance is involved in managing all aspects of the system.

## What is Azure Cosmos DB?

Azure Cosmos DB is a globally distributed NoSQL database service that offers rich querying over diverse data, helps deliver configurable and reliable performance, and enables rapid development.

<!-- Source for the following diagram is at https://commons.wikimedia.org/wiki/File:Simplified_blank_world_map_without_Antartica_(no_borders).svg -->
<!-- We will need to replace this with approved art -->
:::image type="content" source="../media/2-azure-cosmos-db.svg" alt-text="An illustration of a world map with four globally distributed nodes that are connected via lines" border="false":::

Azure Cosmos DB is a fully managed NoSQL database service for modern app development that provides guaranteed single-digit millisecond response times and 99.999-percent availability, backed by SLAs with automatic and instant scalability.

- **No NoSQL administration experience required**: No one on your team will need to manage deployments, maintain database servers, manually scale instances, or patch servers.
- **Global distribution**: Distributing your data to multiple regions around the globe is merely a low friction option in the Azure portal.
- **Elastic scale**: As your data needs grow, you can elastically store more data and increase throughput without the need to deploy new servers.
- **Protocol-level support for existing database drivers, libraries, and tools**: If you already use existing NoSQL tools such as DocumentDB SDKs, Azure Storage Table libraries, MongoDB drivers, or Cassandra tools; you can use those same tools to access or manage data in Azure Cosmos DB.
- **Comprehensive SLAs**: Azure Cosmos DB offers comprehensive 99.99% SLAs that covers guarantees in four different areas; Throughput, consistency, availability, and latency.

Azure Cosmos DB achieves these advantages through a managed platform that’s backed by the power and reach of Microsoft Azure. Azure Cosmos DB is uniquely positioned to handle these challenges because of it's global reach, automatic and instant scale, open-source APIs for existing NoSQL engines, and SLA-backed speed and availability.

Azure Cosmos DB simplifies development by integrating with key Azure services, existing database APIs or SDKs, and automatically distributing and indexing data. Azure Cosmos DB is also fully managed minimizing the amount of effort required to maintain your globally distributed data. Additionally, Azure Cosmos DB offers multiple service models and throughput options to accommodate a wide variety of workloads, data types, and performance requirements.

## What is Azure Cosmos DB SQL API?

The Azure Cosmos DB SQL API is the native API for the database platform. Applications can arbitrarily store native JSON documents with flexible schema. Data is indexed automatically and is available for query using a flavor of the SQL query language designed for JSON data. the SQL API also supports cross-document transactions written in JavaScript and executed server-side. The SQL API can be accessed using SDKs for popular frameworks such as [.NET](/azure/cosmos-db/sql-api-sdk-dotnet-standard), [Python](/azure/cosmos-db/sql-api-sdk-python), [Java](/azure/cosmos-db/sql-api-sdk-java-v4), and [Node.js](/azure/cosmos-db/sql-api-sdk-node). The SQL API can also be accessed using a [RESTful HTTP API](/rest/api/cosmos-db/) endpoint.
