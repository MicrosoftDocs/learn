AI applications increasingly rely on semantic search to find relevant information based on meaning rather than keyword matches. This module guides you through implementing vector search in Azure Cosmos DB for NoSQL, enabling your AI applications to store embeddings alongside document data and perform efficient similarity queries within your existing database infrastructure.

Imagine you're a developer building an AI-powered knowledge base for a customer support team. Support agents need to find relevant documentation, past tickets, and troubleshooting guides based on natural language questions. Traditional keyword search fails when users describe problems in different words than the documentation uses. Searching for "can't connect to WiFi" misses articles titled "wireless network troubleshooting." Your team decides to implement semantic search using vector embeddings. Each document and support ticket is processed through Azure OpenAI's embedding model, converting text into high-dimensional vectors that capture semantic meaning. When an agent types a question, the system converts it to a vector and finds documents with similar vectors, regardless of specific word choices. The results include relevant articles even when terminology differs. You need to design a solution that stores embeddings efficiently alongside document metadata, executes fast similarity queries at scale, combines semantic search with metadata filters (like product category or date range), and keeps embeddings updated as documents change. Azure Cosmos DB for NoSQL provides integrated vector search that meets these requirements without requiring a separate vector database.

After completing this module, you'll be able to:

- Store and retrieve vector embeddings in Azure Cosmos DB containers with properly configured vector policies
- Execute vector similarity queries using the VectorDistance function to find semantically similar documents
- Combine vector search with metadata filters and full-text search using hybrid queries
- Implement change feed processing to automatically refresh embeddings when source documents change

> [!NOTE]
> All code examples in this module are based on the most recent version of the `azure-cosmos` Python SDK at the time of writing. The SDK is updated often and the recommendation is to visit the [Azure Cosmos DB Python SDK documentation](/azure/cosmos-db/sdk-python) for the most up-to-date information.
