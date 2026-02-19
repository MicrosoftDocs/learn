In this module, you learned how to implement vector search in Azure Cosmos DB for NoSQL to build AI applications with semantic search capabilities. You configured containers with vector policies that specify embedding paths, data types, dimensions, and distance functions. You stored embeddings alongside document metadata, creating a unified data model that simplifies architecture by eliminating the need for separate vector databases. You executed vector similarity queries using the `VectorDistance` function with proper result limiting and parameterized query vectors. You combined vector search with metadata filters to narrow results by category, date, or other attributes, and used hybrid search with `RRF` to merge semantic and keyword relevance. You also implemented change feed processing to automatically refresh embeddings when source documents change, keeping search results current as content evolves.

## Additional resources

- [Vector search in Azure Cosmos DB for NoSQL](/azure/cosmos-db/nosql/vector-search)
- [VectorDistance system function](/azure/cosmos-db/nosql/query/vectordistance)
- [Hybrid search in Azure Cosmos DB for NoSQL](/azure/cosmos-db/gen-ai/hybrid-search)
- [Change feed processor in Azure Cosmos DB](/azure/cosmos-db/change-feed-processor)
- [Azure OpenAI embeddings](/azure/ai-services/openai/concepts/understand-embeddings)
