Azure Managed Redis provides vector database capabilities through RediSearch, enabling you to store and query high-dimensional embeddings for AI applications like semantic search, recommendation systems, and retrieval-augmented generation (RAG). Understanding how to create indexes, ingest vectors, and execute similarity searches is fundamental to building performant AI backends that need fast vector retrieval.

Imagine you're building a customer support chatbot that needs to find relevant documentation based on user questions. Your documentation exists as text, but you need semantic similarity—finding docs that mean the same thing even if they use different words. You generate 1536-dimensional embeddings from an AI model for each doc and for each user question, but now you need somewhere to store millions of these vectors and search them in milliseconds. A traditional database can't efficiently handle high-dimensional similarity search at this scale. Azure Managed Redis with vector indexing solves this by providing specialized data structures (HNSW graphs or flat indexes) that make KNN queries fast, letting your chatbot respond to users in real-time even with large knowledge bases.

## Creating a vector index

A vector index is a specialized data structure that Redis builds to organize your embeddings for fast similarity searches. Before you can store vectors, you need to define an index schema that specifies exactly how Redis should handle your embeddings—including the vector field name, data type, dimensionality, distance metric, and indexing algorithm. Think of the schema as a blueprint that tells Redis what kind of data to expect and how to structure it for optimal query performance.

### Index schema components

The schema combines multiple field definitions that describe your data structure. The most critical component is `VectorField`, which tells Redis how to handle your embeddings: the field name identifies where vectors are stored in your Redis hashes, dimensions must match your embedding model's output exactly (typically 384-3072 depending on your model), the data type determines memory usage (FLOAT32 is standard), and the distance metric controls how similarity is calculated (COSINE works best for text embeddings). When you create the index, Redis begins monitoring keys with the specified prefix and automatically indexes any vectors you add:

```python
# Code fragment - focus on VectorField configuration
from redis.commands.search.field import TextField, VectorField
from redis.commands.search.indexDefinition import IndexDefinition, IndexType

schema = (
    TextField("title"),
    TextField("content"),
    VectorField(
        "embedding",           # Field name in your Redis hashes
        "HNSW",               # Algorithm: FLAT or HNSW
        {
            "TYPE": "FLOAT32",          # Standard for AI embeddings
            "DIM": 1536,                # Must match your model's output
            "DISTANCE_METRIC": "COSINE" # Use COSINE for text, L2 for images
        }
    )
)

redis_client.ft("idx:documents").create_index(
    fields=schema,
    definition=IndexDefinition(
        prefix=["doc:"],          # Index keys starting with "doc:"
        index_type=IndexType.HASH # HASH or JSON
    )
)
```

### Choosing an indexing algorithm

Redis offers two algorithms for organizing vectors: FLAT (brute force) and HNSW (graph-based approximation). FLAT compares your query against every single vector in the index to find exact matches—this guarantees perfect accuracy but becomes slow as your dataset grows. HNSW builds a graph structure that lets Redis navigate through vectors intelligently, finding approximate nearest neighbors in milliseconds even across millions of vectors by skipping irrelevant regions of the search space. Choose FLAT for small datasets (under 10,000 vectors) when you need perfect accuracy, or HNSW for large datasets when you need fast queries (<10 ms) and can accept 95-99% accuracy. Most production AI systems use HNSW because the slight accuracy tradeoff is negligible compared to the massive performance gains.

## Ingesting vector data

Ingestion is the process of loading your embeddings into Redis so they become searchable. Unlike regular data, vectors need special handling: Redis stores them as binary blobs (byte arrays) for maximum efficiency, which means you convert your NumPy arrays to bytes using `tobytes()` before storage. When you add vectors to keys matching your index prefix (like `doc:*`), Redis automatically indexes them in the background—no separate indexing step needed. This automatic indexing keeps your search index synchronized with your data as you add, update, or delete vectors.

### Storing vectors with metadata

Storing vectors alone isn't useful—you need metadata (like titles, content, categories) to make sense of search results. Redis Hash lets you store the vector and its metadata together in a single key using `hset` with a `mapping` dictionary. The embedding field contains your vector converted to bytes with `tobytes()`, while other fields hold human-readable information. This colocation means when Redis finds similar vectors, it can immediately return the context your application needs without additional lookups:

```python
# Code fragment - focus on vector storage with tobytes()
import numpy as np

embedding = np.array([0.1, 0.2, 0.3, ...], dtype=np.float32)

redis_client.hset(
    "doc:001",
    mapping={
        "title": "Getting Started with Azure AI",
        "content": "Azure AI Services provide pre-built models...",
        "embedding": embedding.tobytes(),  # Convert NumPy array to bytes
        "category": "documentation"
    }
)
```

### Bulk ingestion for performance

When loading thousands or millions of vectors, sending individual `hset` commands creates network overhead that limits throughput to a few hundred operations per second. Pipelines solve this by batching multiple commands together and sending them to Redis in one network round-trip, which can increase throughput 10-100x depending on network latency. All commands in the pipeline execute atomically on the server, and you receive all responses at once when you call `execute()`:

```python
# Code fragment - focus on bulk ingestion pattern
# Assumes `documents` is a list of dicts with 'id', 'title', 'content', 'embedding'

pipeline = redis_client.pipeline()

for doc in documents:
    vector_bytes = np.array(doc['embedding'], dtype=np.float32).tobytes()

    pipeline.hset(
        f"doc:{doc['id']}",
        mapping={
            "title": doc['title'],
            "content": doc['content'],
            "embedding": vector_bytes,
            "category": doc.get('category', 'general')
        }
    )

# Execute all HSETs in one network round-trip
pipeline.execute()
```

## Querying by similarity

Vector similarity search uses K-Nearest Neighbors (KNN) to find the vectors most similar to your query embedding. When you submit a query vector, Redis calculates the distance (using your chosen metric like COSINE) between your query and indexed vectors, then returns the K closest matches ranked by similarity score. Lower scores mean higher similarity in most metrics—for COSINE distance, 0.0 means identical vectors while 2.0 means opposite. Understanding these scores helps you set relevance thresholds and tune your application's result quality.

### Basic KNN queries

A KNN query requires several components working together: the query vector (converted to bytes), the number of neighbors K to return, the vector field to search (`@embedding`), and dialect 2 (required for vector queries). The query string `*=>[KNN 5 @embedding $query_vec AS score]` breaks down as: `*` searches all documents, `=>` indicates vector search syntax, `KNN 5` requests five nearest neighbors, `@embedding` specifies which field contains vectors, and `$query_vec` is a parameter placeholder you fill with your query bytes. The `AS score` clause returns the distance as a field you can sort by:

```python
# Code fragment - focus on KNN query syntax
from redis.commands.search.query import Query

query_bytes = np.array(query_embedding, dtype=np.float32).tobytes()

query = (
    Query("*=>[KNN 5 @embedding $query_vec AS score]")
    .return_fields("title", "content", "score")
    .sort_by("score")
    .dialect(2)
)

results = redis_client.ft("idx:documents").search(
    query,
    query_params={"query_vec": query_bytes}
)
```

The query syntax `*=>[KNN 5 @embedding $query_vec AS score]` searches all documents, finds five nearest neighbors in the `embedding` field, and returns similarity scores. Use `.dialect(2)` for vector queries.

### Hybrid search: Filtering with metadata

Hybrid search combines vector similarity with traditional metadata filters, letting you find semantically similar items within a specific category or subset. Hybrid search is powerful for real-world applications—imagine searching for "comfortable shoes" but only within "running shoes" category, or finding similar documents but only from the last month. The syntax places the filter expression (like `@category:{documentation}`) before the vector search operator `=>`, which tells Redis to first filter down to matching items, then find the K nearest neighbors only within that filtered set:

```python
# Code fragment - focus on hybrid query syntax
hybrid_query = Query(
    "@category:{documentation}=>[KNN 3 @embedding $query_vec AS score]"
).return_fields("title", "category", "score").sort_by("score").dialect(2)

results = redis_client.ft("idx:documents").search(
    hybrid_query,
    query_params={"query_vec": query_bytes}
)
```

### Range queries: Threshold-based retrieval

While KNN returns a fixed number of results (like top 5), range queries return all vectors within a distance threshold—useful when you want everything above a certain similarity level rather than an arbitrary count. For example, you might want all documents with COSINE distance under 0.2 from your query, which could return 3 results or 300 depending on your data. Use `VECTOR_RANGE` with a distance threshold to find all vectors within that boundary:

```python
# Code fragment - focus on VECTOR_RANGE syntax
range_query = Query(
    "@embedding:[VECTOR_RANGE 0.2 $query_vec]=>{$YIELD_DISTANCE_AS: score}"
).return_fields("title", "score").sort_by("score").dialect(2)

results = redis_client.ft("idx:documents").search(
    range_query,
    query_params={"query_vec": query_bytes}
)
```

## Key considerations

Successful vector search depends on getting several technical details exactly right—small misconfigurations can cause queries to fail or return poor results. Understanding dimension matching, distance metrics, and HNSW tuning helps you avoid common pitfalls and optimize for your specific use case. These concerns aren't theoretical: mismatched dimensions cause runtime errors, wrong distance metrics return irrelevant results, and poorly tuned HNSW parameters can make queries slower than necessary.

### Dimension matching requirement

Vector dimensions must match exactly between your index definition and query vectors because the distance calculations rely on comparing each dimension position-by-position. If your index expects 1536-dimensional vectors but you query with a 768-dimensional vector, Redis can't compute meaningful distances and rejects the query with an error. This is one of the most common mistakes when working with multiple embedding models or switching between model versions. Always verify your query vector dimension matches the DIM parameter you specified when creating the index.

### Understanding distance metrics

Distance metrics define how Redis calculates "similarity" between vectors—essentially, they're the mathematical formulas used to compare embeddings. Choosing the wrong metric returns irrelevant results because different metrics measure different properties of vectors. COSINE measures the angle between vectors (ignoring magnitude), which aligns with how language models encode semantic meaning. L2 measures straight-line distance considering both direction and magnitude, which works better for spatial data like images. Using L2 with text embeddings trained for COSINE comparison gives you mathematically correct but semantically meaningless results. Choose the metric matching your embedding model's training objective:

- **COSINE:** Use for text embeddings (OpenAI, Cohere, Sentence Transformers)
- **L2:** Use for image embeddings and spatial data
- **IP:** Use only for pre-normalized embeddings

### Tuning HNSW performance

HNSW's speed comes from selectively exploring the graph structure rather than checking every vector, but it creates a tradeoff: exploring more of the graph improves accuracy while exploring less improves speed. The `EF_RUNTIME` parameter controls how many graph nodes Redis examines during search—higher values mean more thorough exploration and better accuracy, but slower queries. The default is typically 10, which prioritizes speed. You can adjust this per-query to balance speed and accuracy for different use cases:

```python
# Code fragment - focus on EF_RUNTIME parameter
query = Query("*=>[KNN 10 @embedding $query_vec EF_RUNTIME 200 AS score]")
```

Higher values improve accuracy but slow queries. Start with 50, increase to 100-200 if needed.

## Additional resources

- [RediSearch Vector Similarity Documentation](https://redis.io/docs/latest/develop/interact/search-and-query/query/vector-search/) - Official guide to vector indexing and queries
- [redis-py Vector Search Examples](https://github.com/redis/redis-py/blob/master/docs/examples/search_vector_similarity_examples.ipynb) - Comprehensive notebook with working code examples
