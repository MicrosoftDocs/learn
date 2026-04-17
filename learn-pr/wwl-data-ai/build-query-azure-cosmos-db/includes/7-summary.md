In this module, you learned how Azure Cosmos DB for NoSQL organizes data using a hierarchical resource model with accounts, databases, containers, and items. You explored how partition keys determine data distribution across physical partitions and why selecting an effective partition key is critical for query performance and scalability. You configured throughput using both manual provisioning and autoscale options to match your workload requirements. You implemented SDK operations to connect securely using both account keys and Microsoft Entra ID authentication, following the best practice of reusing a single client instance throughout your application. You performed CRUD operations including creates, upserts, point reads, and deletes, understanding when to use each method. You built SQL queries with filters, projections, parameters, and aggregations to retrieve data efficiently. You also learned the cost difference between single-partition queries that route to specific partitions and cross-partition queries that fan out across all partitions. These skills enable you to build AI applications that store and retrieve document data with low latency, flexible schemas, and predictable costs.

## Additional resources

- [Azure Cosmos DB for NoSQL documentation](/azure/cosmos-db/nosql/)
- [Azure Cosmos DB SDK for Python](/python/api/overview/azure/cosmos-readme)
- [Getting started with SQL queries in Azure Cosmos DB](/azure/cosmos-db/nosql/query/getting-started)
- [Best practices for Azure Cosmos DB Python SDK](/azure/cosmos-db/nosql/best-practice-python)
