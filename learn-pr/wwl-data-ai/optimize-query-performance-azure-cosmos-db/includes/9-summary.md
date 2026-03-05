In this module, you learned how to optimize query performance for Azure Cosmos DB for NoSQL workloads that power AI applications. You explored several index types, including range, composite, spatial, vector, and tuple indexes, and learned to analyze query patterns to identify which indexes improve performance for your specific workload. Range indexes support the equality and range filters that AI applications use to query documents by type, category, or date. Composite indexes optimize queries that sort on multiple properties or combine filters with sorting, enabling efficient retrieval for complex search patterns.

You tuned vector indexes by selecting between flat, quantizedFlat, and diskANN types based on your dataset size and accuracy requirements. The flat index provides 100 percent accuracy for small datasets, quantizedFlat balances performance and accuracy for medium datasets, and diskANN delivers the lowest latency and RU cost for large-scale vector workloads. You learned to exclude embedding arrays from range indexes to reduce storage costs while maintaining vector search capability through dedicated vector indexes.

You designed indexing policies that balance read performance against write overhead by selectively including only queried properties. This targeted approach reduces storage consumption and write costs for AI applications that store large documents with embedded text and vectors. You used query metrics to identify missing indexes and validate that optimizations achieved the expected cost reductions.

You also selected consistency levels that meet application requirements while minimizing costs. Session consistency provides the read-your-writes guarantee that users expect when uploading and immediately searching for content. Eventual consistency offers lower costs for background analytics queries where immediate freshness isn't required. Understanding the RU cost differences between consistency levels helps you optimize operational costs across different operation types.

## Additional resources

- [Indexing policies in Azure Cosmos DB](/azure/cosmos-db/index-policy)
- [Vector search in Azure Cosmos DB for NoSQL](/azure/cosmos-db/vector-search)
- [How to manage indexing policies](/azure/cosmos-db/how-to-manage-indexing-policy)
- [Consistency levels in Azure Cosmos DB](/azure/cosmos-db/consistency-levels)
