AI applications require data stores that deliver consistent low-latency performance while scaling to meet unpredictable demand. Azure Cosmos DB for NoSQL provides a globally distributed, schemaless document database that supports flexible JSON data models and automatic indexing. This module guides you through connecting to Azure Cosmos DB for NoSQL and building efficient queries to power AI solutions that retrieve and manipulate document data.

Imagine you're a developer building an AI-powered recommendation engine for an e-commerce platform. Your application stores product catalogs, user preferences, and interaction history as JSON documents. Each recommendation request requires retrieving relevant products based on category, price range, and user attributes. All of this must happen within milliseconds to maintain a responsive user experience. The existing relational database struggles to keep up with peak traffic, and schema changes require lengthy migrations that slow down feature development. Your team evaluates Azure Cosmos DB for NoSQL because it provides schema flexibility for evolving data models without downtime. The default indexing policy automatically indexes properties in your items, which reduces the amount of index setup you do upfront. As your query patterns evolve, you might still need to customize indexing policies, such as adding composite indexes for some `ORDER BY` patterns. You can scale throughput independently of storage to handle traffic spikes during promotional events. You need to understand how to structure your data across databases and containers, connect securely using the SDK, and write efficient queries that minimize request unit consumption while delivering the results your AI models need.

After completing this module, you'll be able to:

- Explain the Azure Cosmos DB for NoSQL resource model and how databases, containers, and items relate to each other
- Implement SDK operations to connect to Azure Cosmos DB and perform CRUD operations on items
- Select between point reads and queries based on performance requirements and access patterns
- Build queries using SQL syntax to filter, project, and retrieve data from containers

> [!NOTE]
> All code examples in this module are based on the most recent version of the `azure-cosmos` library for Python at the time of writing. The library is updated often and the recommendation is to visit the [Azure Cosmos DB SDK for Python documentation](/python/api/overview/azure/cosmos-readme) for the most up-to-date information.
