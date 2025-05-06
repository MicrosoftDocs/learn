Cosmos DB NoSQL in Fabric is a fully managed NoSQL database, based on Azure Cosmos DB for NoSSQL, that allows you to easily build operational database directly in Fabric.

## API and SDK

As the name implies, Cosmos DB NoSQL in Fabric supports the NoSQL API. The NoSQL API is a schema-agnostic, document-oriented database that allows you to store and query JSON documents. It supports various data types, including strings, numbers, arrays, and objects. The NoSQL API is designed for high availability and low latency, making it ideal for applications that require fast access to data.

## Authentication and Security

Microsoft Fabric supports the following authentication methods for Cosmos DB NoSQL in Fabric:

- Microsoft Entra authentication.
- Managed identity.
- Service principal.

Network security is supported automatically. If the customer enables Fabric tenant level network protection, Cosmos DB NoSQL in Fabric honors tenant level private endpoints (PEs).

Cosmos DB automatically enforces user permissions based on access level granted on the workspaces.

## Software as a Service Database

Cosmos DB NoSQL in Fabric is a Software as a Service (SaaS) database, which means that it's a fully managed service that Microsoft maintains and hosts. This means that you don't have to worry about managing the underlying infrastructure, such as servers, storage, and networking. Instead, you can focus on building your applications and using the database to store and retrieve data.

Throughput is handled automatically and no other configuration is needed. Fabric database is available in the region where Fabric capacity is set up.

> [!NOTE]
> Multi-region writes and reads aren't supported in public preview.

> [!NOTE]
> In public preview, we don’t yet support vector search for AI scenarios, reverse-ETL with Spark connector or real-time intelligence (RTI).

Cosmos DB NoSQL in Fabric delivers the no-knob, best-performance available, 5 seconds to start, 5 minutes to WOW Fabric experience.
