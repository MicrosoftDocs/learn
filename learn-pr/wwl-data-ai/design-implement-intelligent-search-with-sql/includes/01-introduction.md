Finding relevant information in a database often requires more than matching keywords. Users search for concepts, not just words. A customer looking for "lightweight hiking backpack" might find nothing if the product is listed as "ultralight trail bag." SQL Server and Azure SQL Database provide multiple search approaches to handle these challenges: full-text search for keyword matching, vector search for semantic similarity, and hybrid search that combines both.

Full-text search excels when users know the specific terms they want. Vector search uses embeddings to find content based on meaning even when the exact words differ. Hybrid search runs both approaches and merges the results, giving users the best of both worlds. Choosing the right approach depends on how your users search and what trade-offs you can accept between precision, recall, and performance.

Imagine a retail team building a product search feature. They have embeddings stored for their product descriptions and support articles. Now they need search capabilities that help customers find products and answers quickly. Some customers type exact product names. Others describe what they need in natural language. The team decides to implement hybrid search so their application handles both patterns effectively, using full-text indexes for keyword matching and vector search for semantic similarity.

After completing this module, you'll be able to:

- To select the right approach for different query types, evaluate full-text search, vector search, and hybrid search.
- Implement full-text search using full-text indexes and query predicates.
- Prepare SQL databases for vector search by storing embeddings and choosing distance metrics.
- Write vector search queries using VECTOR_DISTANCE and VECTOR_SEARCH functions.
- Combine full-text and vector search results using Reciprocal Rank Fusion (RRF).
