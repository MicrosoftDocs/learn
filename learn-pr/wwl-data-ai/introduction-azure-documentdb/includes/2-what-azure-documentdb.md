Azure DocumentDB is a fully managed document database service on Azure that provides high compatibility with MongoDB clients and tools. It supports the MongoDB wire protocol, which means your existing applications, drivers, and queries work with minimal or no changes. The service was previously known as Azure Cosmos DB for MongoDB (vCore) and became its own distinct offering aligned with the open-source DocumentDB project.

## Open-source foundation

Azure DocumentDB is built on the [DocumentDB open-source project](https://github.com/documentdb/documentdb). The Linux Foundation governs this MongoDB-compatible document database, and it uses the MIT license. This open-source engine doesn't run the MongoDB database server or use its codebase. MongoDB's Server Side Public License (SSPL) doesn't apply to DocumentDB or Azure DocumentDB.

The open-source foundation means the database implementation is transparent, community-driven, and auditable. Organizations that need to review the code powering their database for compliance or security reasons can do so directly on GitHub.

## MongoDB compatibility

Azure DocumentDB delivers over 99% compatibility with the MongoDB Query Language (MQL) through wire protocol and BSON support. This compatibility level means that most MongoDB operations, aggregation pipelines, and index types work as expected.

In practice, this compatibility means you can:

- Connect using standard MongoDB drivers for Python (PyMongo), .NET (MongoDB.Driver), JavaScript (mongodb npm package), and other languages.
- Use familiar tools like Studio 3T, MongoDB Compass, and `mongosh` for visual data exploration and command-line management.
- Browse, query, and manage your databases directly in Visual Studio (VS) Code using the [DocumentDB for VS Code extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-documentdb).
- Run existing aggregation pipelines, CRUD operations, and most administrative commands without modification.
- Use change streams to react to real-time data changes, such as triggering notifications or updating caches when documents are inserted, updated, or deleted.

> [!NOTE]
> Some server-side MongoDB extensions and certain administrative commands aren't supported because Azure DocumentDB is a managed service that handles replication, sharding, and server administration for you. Review the [feature compatibility documentation](/azure/documentdb/compatibility-features) for specific details.

## How Azure DocumentDB relates to Azure Cosmos DB

Understanding the product lineage helps avoid confusion between similarly named services. Azure DocumentDB was previously known as **Azure Cosmos DB for MongoDB (vCore)**. It's a separate service from **Azure Cosmos DB for MongoDB (RU-based)**, which uses a different architecture based on Request Units and horizontal scale-out with global distribution.

The key differences are:

- **Azure DocumentDB** uses a vCore-based architecture where you select a compute tier (vCores and RAM) and storage size independently. Pricing is predictable and based on the resources you provision.
- **Azure Cosmos DB for MongoDB (RU-based)** uses Request Unit pricing where throughput is measured in RU/s. It offers automatic global distribution and multi-region writes.

These Azure services are distinct services with different pricing models, scaling behaviors, and feature sets. When evaluating your options, verify which service aligns with your workload's requirements for scaling, pricing, and feature support.

## The document data model

Azure DocumentDB stores data as JSON-like documents in collections within databases. This document model offers several advantages for application development:

- **Flexible schema**: Documents in the same collection can have different fields and structures. You can add new fields as your application evolves without modifying a rigid table schema.
- **Natural data representation**: Documents map directly to objects in most programming languages. A product document, for example, can contain nested arrays for reviews and embedded objects for pricing tiers, all in a single document.
- **BSON format**: Data uses BSON (Binary JSON) for storage and transmission. BSON supports dates, binary data, and decimal values that standard JSON doesn't.

This schema flexibility makes Azure DocumentDB a good fit for product catalogs, user profiles, content management systems, and other applications with evolving data structures.
