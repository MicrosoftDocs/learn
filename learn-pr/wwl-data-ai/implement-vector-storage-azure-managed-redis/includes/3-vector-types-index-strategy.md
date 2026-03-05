Choosing the right vector data type, distance metric, and indexing algorithm directly impacts your application's accuracy, performance, and resource usage. Understanding these configuration options helps you optimize vector search for your specific AI workload.

Imagine you're building a recommendation engine that suggests similar products based on user browsing history. You generate embeddings for thousands of products, but your search needs to return results in under 10 milliseconds to keep users engaged. If you choose exact search (FLAT indexing), you might achieve perfect accuracy but with latency that scales poorly as your product catalog grows. Alternatively, approximate search (HNSW) can deliver 99% accuracy with sub-10ms queries even on millions of products. Making informed choices about vector types, distance metrics, and indexing algorithms ensures your system meets both accuracy and performance requirements.

## Vector data types and dimensions

The data type you choose (FLOAT32 or FLOAT64) determines both the memory footprint of your vectors and the precision of similarity calculations. Each float in a FLOAT32 vector uses 4 bytes, while FLOAT64 uses 8 bytes—for a 1536-dimensional vector, that's 6KB versus 12KB per vector. Multiply across millions of vectors and the choice significantly impacts your Redis memory costs and query performance (larger data means more memory transfers). Dimensionality must match your embedding model's output exactly because distance calculations depend on comparing corresponding positions in the vector arrays. Understanding these constraints helps you configure indexes that work correctly and efficiently with your specific AI models.

### Choosing vector data type

Vector data types represent a classic precision-versus-efficiency tradeoff. FLOAT32 (single-precision) provides about seven decimal digits of precision, which is more than sufficient for AI embeddings since the models themselves have inherent noise and approximation. FLOAT64 (double-precision) provides 15 decimal digits but doubles memory usage and slows down distance calculations due to larger data transfers. For nearly all AI applications, the extra precision of FLOAT64 provides no meaningful accuracy improvement because the embedding models don't produce values that precise. Use FLOAT32 for standard work—it balances precision with memory efficiency and works with all major embedding models:

```python
# Code fragment - focus on vector data type configuration
VectorField(
    "embedding",
    "HNSW",
    {
        "TYPE": "FLOAT32",  # Standard choice for AI embeddings
        "DIM": 1536,
        "DISTANCE_METRIC": "COSINE"
    }
)
```

FLOAT32 uses 4 bytes per dimension (6KB for a 1536-dimensional vector), while FLOAT64 uses 8 bytes (12KB). For millions of vectors, FLOAT32's smaller footprint means better performance and lower costs. Use FLOAT64 only when you need maximum precision for specialized research.

### Matching embedding dimensions

Embedding models are neural networks trained to produce fixed-length vectors. Different models output different dimensions—common ranges are 384, 768, 1024, 1536, and 3072. Your Redis index DIM parameter must match your model's output exactly because the distance calculations depend on position-by-position comparisons across all dimensions. If there's a mismatch, Redis either rejects the data during ingestion, or queries fail with dimension errors. Always check your model's documentation to confirm the output dimension before creating your index:

```python
# Code fragment - focus on dimension matching
embedding_models = {
    "small-model": 384,
    "medium-model": 768,
    "large-model": 1536,
    "xlarge-model": 3072,
}

# Create index matching your model
VectorField(
    "embedding",
    "HNSW",
    {
        "TYPE": "FLOAT32",
        "DIM": 1536,  # Must match model output
        "DISTANCE_METRIC": "COSINE"
    }
)
```

Mismatched dimensions cause index creation or ingestion failures. Always verify your model's output dimension before defining the schema.

## Distance metrics

Distance metrics are mathematical functions that define how "close" two vectors are to each other in high-dimensional space. While vectors exist in abstract spaces with hundreds or thousands of dimensions, distance metrics give us a single number that quantifies similarity—lower numbers typically mean more similar vectors. The metric you choose must align with how your embedding model was trained because different metrics measure different properties: some measure angles (direction), others measure straight-line distance (magnitude and direction), and others compute overlap (dot product). Choosing the metric that matches your model's training objective ensures your similarity scores reflect semantic meaning rather than only mathematical coincidence.

### Understanding distance metric options

Redis supports three distance metrics, each measuring a different aspect of vector similarity. Understanding what each metric actually calculates helps you choose the right one for your data:

1. **COSINE** measures the angle between vectors, ignoring magnitude. Use this for text embeddings and semantic similarity—it's what OpenAI, Cohere, and most language models expect.

1. **L2 (Euclidean)** measures straight-line distance in vector space. Use this for image embeddings and spatial data where both direction and magnitude matter.

1. **IP (Inner Product)** computes the dot product between vectors. Use this only when working with pre-normalized embeddings or specialized models that require it.

For most AI applications involving text understanding, choose COSINE.

### Selecting the appropriate metric

Embedding models are trained with a specific distance metric in mind—the model learns to position similar concepts close together according to that metric's geometry. Using a different metric at query time means you're measuring similarity in a way the model wasn't optimized for, leading to poor results. For example, text embedding models are typically trained with COSINE similarity, so using L2 distance would give mathematically valid but semantically meaningless results. Always match your metric to your embedding type:

```python
# Code fragment - focus on distance metric selection

# For text embeddings (most common)
VectorField("embedding", "HNSW", {
    "TYPE": "FLOAT32",
    "DIM": 1536,
    "DISTANCE_METRIC": "COSINE"  # Use for OpenAI, Cohere, Sentence Transformers
})

# For image embeddings
VectorField("image_embedding", "HNSW", {
    "TYPE": "FLOAT32",
    "DIM": 768,
    "DISTANCE_METRIC": "L2"  # Use for vision models
})
```

## Indexing algorithms

The indexing algorithm determines how Redis organizes and searches through your vectors, presenting a fundamental tradeoff between perfect accuracy and practical performance. Exact search (FLAT) guarantees you find the true nearest neighbors by comparing against every vector, but this brute-force approach becomes prohibitively slow as datasets grow—searching 1 million vectors might take seconds. Approximate search (HNSW) uses a graph-based index to intelligently skip large portions of the search space, finding near-neighbors in milliseconds even across millions of vectors, but with a small chance of missing the absolute best matches. For most production AI systems, 95-99% accuracy at 100x the speed is a worthwhile tradeoff. Choose between FLAT and HNSW based on your dataset size and latency requirements.

### FLAT indexing (exact search)

FLAT indexing uses brute-force search—when you query, Redis literally compares your query vector against every single stored vector using the distance metric, sorts all results, and returns the K nearest. This guarantees perfect accuracy because nothing is skipped, but query time grows linearly with dataset size: 10,000 vectors might take 10 ms, but 1 million vectors could take 1000ms. FLAT works well for development, prototyping, and production systems with small datasets. Use FLAT for small datasets (under 10,000 vectors), development and prototyping, or when you need perfect accuracy and can accept query latency under 100ms:

```python
# Code fragment - focus on FLAT index configuration
VectorField(
    "embedding",
    "FLAT",  # Exact nearest neighbor search
    {
        "TYPE": "FLOAT32",
        "DIM": 1536,
        "DISTANCE_METRIC": "COSINE"
    }
)
```

### HNSW indexing (approximate search)

HNSW (Hierarchical Navigable Small World) builds a multi-layer graph where each vector connects to nearby neighbors at different scales—like a highway system with interstate highways (top layer, long jumps), state highways (middle layers, medium jumps), and local streets (bottom layer, fine-grained navigation). When searching, Redis starts at the top layer and uses the graph connections to quickly navigate toward your query vector, progressively moving to lower layers for finer precision. This structure lets Redis examine only a small fraction of total vectors (maybe 1,000 out of 1 million) while still finding excellent matches. Use HNSW for large datasets (over 10,000 vectors), production systems needing fast queries (<10ms), or when 95-99% accuracy is acceptable. Most production AI systems use HNSW because the slight accuracy tradeoff is negligible compared to the massive performance gains:

```python
# Code fragment - focus on HNSW index configuration
VectorField(
    "embedding",
    "HNSW",  # Approximate nearest neighbor search
    {
        "TYPE": "FLOAT32",
        "DIM": 1536,
        "DISTANCE_METRIC": "COSINE"
    }
)
```

HNSW delivers near-instant results on millions of vectors by trading a small amount of accuracy for massive speed improvements.

### Tuning HNSW performance

The HNSW graph structure enables fast search by limiting how many vectors Redis examines, but this creates a tunable tradeoff between speed and accuracy. The `EF_RUNTIME` parameter controls how many graph nodes Redis explores during each query—think of it as "effort level." Low values (like 10-50) mean Redis takes shorter paths through the graph, finding good matches quickly but potentially missing better ones. High values (like 100-200) mean Redis explores more paths, finding better matches but taking longer. The defaults work well for most applications, but you can tune HNSW if you need different speed-accuracy characteristics:

**EF_RUNTIME** (query-time tuning):

```python
# Code fragment - focus on runtime tuning
query = Query(
    "*=>[KNN 10 @embedding $query_vec EF_RUNTIME 100 AS score]"
).dialect(2)
```

Higher `EF_RUNTIME` improves accuracy but slows queries. Start with 50, increase to 100-200 if you need better results.

## Choosing the right configuration

With multiple options for data type, distance metric, and indexing algorithm, the key is matching your configuration to your specific requirements. Dataset size often determines the algorithm choice (FLAT vs HNSW), your embedding model determines the metric (usually COSINE for text), and memory constraints might influence data type (usually FLOAT32). Rather than trying every combination, use these guidelines to narrow down the right configuration for your use case, then validate with testing on your actual data.

### Quick configuration guide

| Use Case | Data Type | Metric | Algorithm |
|----------|-----------|-----------|-----|
| Text search (small) | FLOAT32 | COSINE | FLAT |
| Text search (large) | FLOAT32 | COSINE | HNSW |
| Image similarity | FLOAT32 | L2 | HNSW |
| Recommendations | FLOAT32 | COSINE | HNSW |

### Testing your configuration

While guidelines provide starting points, your actual performance depends on your specific data characteristics—vector distribution, query patterns, and hardware all affect results. Testing different configurations with your real data helps you find the optimal balance between speed and accuracy for your application. For HNSW tuning specifically, measuring latency at different `EF_RUNTIME` values shows you exactly how much speed you trade for accuracy improvements:

```python
# Code fragment - focus on performance testing
import time

for ef_runtime in [50, 100, 200]:
    query = Query(
        f"*=>[KNN 10 @embedding $query_vec EF_RUNTIME {ef_runtime} AS score]"
    ).return_fields("id", "score").dialect(2)

    start = time.time()
    results = redis_client.ft("idx:docs").search(
        query,
        query_params={"query_vec": query_vector.tobytes()}
    )
    latency = (time.time() - start) * 1000

    print(f"EF_RUNTIME={ef_runtime}: {latency:.2f}ms")
```

## Additional resources

- [RediSearch Vector Field Documentation](https://redis.io/docs/latest/develop/interact/search-and-query/advanced-concepts/vectors/) - Comprehensive guide to vector field configuration
- [Choosing Distance Metrics for Embeddings](https://redis.io/docs/latest/develop/interact/search-and-query/advanced-concepts/vectors/#distance-metrics) - Official Redis guidance on similarity metrics
