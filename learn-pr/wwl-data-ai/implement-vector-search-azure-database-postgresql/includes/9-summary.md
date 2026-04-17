In this module, you learned how to implement vector search capabilities using the pgvector extension in Azure Database for PostgreSQL. You started by enabling the extension and designing schemas with vector columns to store embeddings from different models, understanding how dimension size affects storage and performance. You explored the three distance operators—Euclidean distance, cosine distance, and inner product—and learned when to apply each based on your embedding model and use case.

You also learned how to create vector indexes using IVFFlat and HNSW algorithms to transform expensive sequential scans into fast approximate nearest neighbor searches. You discovered that IVFFlat requires existing data before index creation and uses lists and probes parameters to balance speed and recall, while HNSW can index data incrementally and offers better recall with the m, ef_construction, and ef_search parameters. You learned to verify index usage with EXPLAIN ANALYZE and match operator classes to your distance operators.

Additionally, you explored index lifecycle management strategies including monitoring index health with pg_stat_user_indexes, determining when to rebuild indexes after significant data changes, and handling embedding model migrations that require updating all vectors. You implemented semantic retrieval patterns that combine vector similarity with metadata filtering, distance thresholds, and multi-vector queries. Finally, you designed RAG pipeline schemas that separate source documents from chunks, enabling context retrieval with full citation metadata for LLM applications.

## Additional resources

- [Use pgvector on Azure Database for PostgreSQL](/azure/postgresql/flexible-server/how-to-use-pgvector)
- [Optimize performance when using pgvector](/azure/postgresql/flexible-server/how-to-optimize-performance-pgvector)
- [Integrate Azure Database for PostgreSQL with Azure AI Services](/azure/postgresql/flexible-server/generative-ai-azure-overview)
- [Generative AI with Azure Database for PostgreSQL](/azure/postgresql/flexible-server/generative-ai-overview)
