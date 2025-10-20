SQL Server 2025 brings AI capabilities directly into the database engine. Throughout this module, you explored how SQL Server 2025 enables developers to build AI-powered applications using T-SQL syntax with technologies like vector embeddings, semantic search, and large language models.

:::image type="content" source="../media/sql-2025-ai.png" alt-text="Diagram illustrating AI-powered features in SQL Server 2025, including vector support, embeddings, semantic search, and integration with AI services." lightbox="../media/sql-2025-ai.png" border="false":::

In this module, you explored the AI concepts and capabilities in SQL Server 2025. You learned to work with vector data types and embeddings, performing both exact nearest neighbor (k-NN) search using `VECTOR_DISTANCE` and approximate nearest neighbor (ANN) search using `VECTOR_SEARCH` with DiskANN indexes. You learned how to integrate SQL Server securely with external AI services through `CREATE EXTERNAL MODEL` and `sp_invoke_external_rest_endpoint`, implementing authentication patterns using managed identities, Microsoft Entra authentication, and database-scoped credentials to connect with Azure OpenAI, Azure AI Foundry, and custom ONNX models.

You implemented complete Retrieval Augmented Generation (RAG) workflows that combine vector search with large language models to create context-aware AI responses. You learned to integrate SQL Server with AI frameworks including LangChain and Semantic Kernel, and explored hybrid search scenarios that combine semantic similarity with traditional SQL filtering and full-text search. You also configured Change Event Streaming for real-time, event-driven AI applications and implemented conversational AI interfaces using natural language to SQL (NL2SQL) capabilities with safety guardrails.

Finally, you used Microsoft Copilot in SQL Server Management Studio 21 for AI-powered assistance in writing queries, optimizing performance, debugging errors, and exploring schemas. You also learned to configure Microsoft Fabric mirroring for near real-time analytics, use the MSSQL extension for Visual Studio Code with GitHub Copilot integration, and apply Entity Framework Core with AI capabilities to build production-ready applications.

## Additional resources

To deepen your understanding of AI-powered solutions with SQL Server 2025, explore these resources:

- [Download SQL Server 2025 from the Microsoft Evaluation Center](https://www.microsoft.com/evalcenter/evaluate-sql-server-2025)
- [What's new in SQL Server 2025](/sql/sql-server/what-s-new-in-sql-server-2025?azure-portal=true)
- [Vector data type in SQL Server](/sql/t-sql/data-types/vector-data-type?azure-portal=true)
- [`CREATE EXTERNAL MODEL (Transact-SQL`)](/sql/t-sql/statements/create-external-model-transact-sql?azure-portal=true)
- [`VECTOR_DISTANCE (Transact-SQL)`](/sql/t-sql/functions/vector-distance-transact-sql?azure-portal=true)
- [`VECTOR_SEARCH (Transact-SQL)`](/sql/t-sql/functions/vector-search-transact-sql?azure-portal=true)
- [Microsoft Fabric mirroring for SQL Server](/fabric/database/mirrored-database/overview?azure-portal=true)
- [Azure OpenAI Service documentation](/azure/ai-services/openai/?azure-portal=true)
