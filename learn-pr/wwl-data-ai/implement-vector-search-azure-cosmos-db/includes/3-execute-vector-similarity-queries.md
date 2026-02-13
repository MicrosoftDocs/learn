Once your container stores documents with embeddings, you can execute vector similarity queries to find semantically related content. The `VectorDistance` function calculates similarity between vectors and enables queries that understand meaning rather than matching exact keywords. You can build more responsive AI applications if you understand query syntax, result ordering, and performance considerations.

## Use the VectorDistance function

The `VectorDistance` function is the core mechanism for vector search in Azure Cosmos DB. It calculates the similarity between a document's embedding and a query vector based on the distance function configured in the container's vector policy. For cosine similarity, the function returns values where higher numbers indicate greater similarity. A document with a score of 0.9 is more similar to the query than one with a score of 0.5.

The function accepts the following parameters:

- **vector_expr_1:** The document's embedding path (such as `c.embedding`)
- **vector_expr_2:** The query vector (an array of numbers)
- **bool_expr:** Optional boolean that forces brute-force search when set to `true` (default: `false`)
- **obj_expr:** Optional JSON object with other options like `distanceFunction` and `dataType`

A basic call to `VectorDistance` in a query looks like this:

```sql
VectorDistance(c.embedding, [0.1, -0.2, 0.3, ...])
```

The function returns a numeric similarity score. You use this score both for ordering results and optionally for filtering by similarity threshold.

## Structure basic vector search queries

A vector search query retrieves documents ordered by their similarity to a query vector. The query structure combines `VectorDistance` in both the `SELECT` clause (to return similarity scores) and the `ORDER BY` clause (to rank results). Always include a `TOP N` clause to limit results—without it, the query attempts to return all documents, consuming excessive RUs and causing high latency.

The following query finds the 10 most similar documents to a query vector and returns their titles and similarity scores:

```sql
SELECT TOP 10
    c.id,
    c.title,
    c.category,
    VectorDistance(c.embedding, @queryVector) AS SimilarityScore
FROM c
ORDER BY VectorDistance(c.embedding, @queryVector)
```

The `ORDER BY` clause sorts results by relevance, with the most similar documents returned first. The `TOP 10` clause ensures the query returns only the most relevant results rather than scanning the entire container.

## Generate query vectors for search

Before executing a vector search, you must convert the user's search text into an embedding using the same model that generated the document embeddings. Using the same model is essential. Different embedding models create incompatible vector spaces, so a query embedding from one model doesn't match document embeddings from another.

The following Python code shows the complete workflow from user query to vector search results:

```python
from openai import AzureOpenAI

# User's search query
query_text = "How do I fix WiFi connection problems?"

# Generate query embedding using the same model as documents
openai_client = AzureOpenAI(
    api_key=api_key,
    api_version="2024-02-01",
    azure_endpoint=endpoint
)

response = openai_client.embeddings.create(
    input=query_text,
    model="text-embedding-ada-002"
)
query_embedding = response.data[0].embedding

# Execute vector search
query = """
    SELECT TOP 10
        c.id,
        c.title,
        c.category,
        VectorDistance(c.embedding, @queryVector) AS SimilarityScore
    FROM c
    ORDER BY VectorDistance(c.embedding, @queryVector)
"""

results = container.query_items(
    query=query,
    parameters=[{"name": "@queryVector", "value": query_embedding}],
    enable_cross_partition_query=True
)

for item in results:
    print(f"{item['title']} - Score: {item['SimilarityScore']:.4f}")
```

The search returns documents semantically similar to the query, including articles about "wireless network troubleshooting" even though the user searched for "WiFi connection problems."

## Use parameterized queries for efficiency

Passing the query vector as a parameter (using `@queryVector`) rather than embedding it directly in the query string provides several benefits. Parameterized queries enable query plan caching, which improves performance for repeated similar queries. Parameters also avoid issues with long query strings—embedding 1,536 floating-point numbers directly in the query text creates unwieldy queries that are difficult to debug.

The parameters array in the Python SDK accepts name-value pairs that map to the `@` parameters in the query:

```python
parameters = [
    {"name": "@queryVector", "value": query_embedding}
]

results = container.query_items(
    query=query,
    parameters=parameters,
    enable_cross_partition_query=True
)
```

This approach keeps queries readable and maintainable while providing performance benefits from plan caching.

## Interpret similarity scores

The meaning of similarity scores depends on the distance function configured in your vector policy. For cosine similarity, the `VectorDistance` function returns values where higher numbers indicate greater similarity:

- **+1.0:** Identical vectors (highest possible similarity)
- **0.7-0.9:** Highly similar content
- **0.5-0.7:** Moderately similar content
- **0.1-0.5:** Low similarity
- **0.0 or negative:** Dissimilar content (vectors pointing in different directions)

For AI applications, setting a similarity threshold helps filter out low-quality matches. A threshold of 0.7 typically returns highly relevant results, while 0.5 includes moderately related content. The optimal threshold depends on your specific use case. You can experiment with different values using representative queries to find the best balance between precision and recall.

The following query returns only documents with similarity scores above 0.7 (highly similar):

```sql
SELECT TOP 10
    c.id,
    c.title,
    VectorDistance(c.embedding, @queryVector) AS SimilarityScore
FROM c
WHERE VectorDistance(c.embedding, @queryVector) > 0.7
ORDER BY VectorDistance(c.embedding, @queryVector)
```

## Control result count for different scenarios

The `TOP N` clause determines how many results the query returns. The optimal value depends on your application's needs:

- **RAG applications:** Return five to 10 results to provide context for the language model without overwhelming it with too much information. More context doesn't always improve LLM responses and increases token costs.
- **User-facing search:** Return 10 to 20 results with pagination support. Users can browse through results and the application can fetch additional pages as needed.
- **Recommendation systems:** Return three to five highly similar items to show related content without cluttering the interface.

Requesting fewer results improves query performance by reducing the amount of data processed and returned. Start with a smaller number and increase if users need more options.

## Compare indexed and brute-force search

By default, vector queries use the configured vector index (such as DiskANN) for fast approximate results. Indexed search trades a small amount of accuracy for significantly better performance. DiskANN maintains high recall while processing queries orders of magnitude faster than brute-force search.

When you need 100 percent accurate results, you can force brute-force search by passing `true` as the third parameter to `VectorDistance`:

```sql
SELECT TOP 5
    c.title,
    VectorDistance(c.embedding, @queryVector, true) AS SimilarityScore
FROM c
ORDER BY VectorDistance(c.embedding, @queryVector, true)
```

Use brute-force search sparingly because it:

- Compares the query vector against every document in the container
- Consumes significantly more RUs than indexed search
- Has higher latency, especially for large datasets
- Scales poorly as your data grows

For most AI applications, the approximate results from indexed search are indistinguishable from exact results in practice. Reserve brute-force search for scenarios where exact accuracy is required, such as evaluation and testing, or when working with small datasets where the performance difference is negligible.

## Optimize query performance

Vector search performance depends on several factors that you can optimize through configuration and query design. Monitor your queries' RU consumption and latency to identify optimization opportunities.

**Choose the right index type:** DiskANN provides the best performance for large datasets (more than 50,000 vectors per partition). For smaller datasets, `quantizedFlat` offers a good balance of performance and accuracy.

**Limit result count:** Always use `TOP N` with the smallest reasonable value. Requesting 100 results when the user sees 10 wastes resources.

**Use partition keys:** When queries include the partition key, they route to a single partition and avoid cross-partition overhead. Design partition keys that align with common query patterns.

**Project only needed fields:** Select only the fields you need rather than using `SELECT *`. This reduces the data transferred and improves response time.

```python
# Project only essential fields
query = """
    SELECT TOP 10
        c.id,
        c.title,
        VectorDistance(c.embedding, @queryVector) AS SimilarityScore
    FROM c
    ORDER BY VectorDistance(c.embedding, @queryVector)
"""
```

**Monitor RU consumption:** Use the Azure portal or SDK to track RU charges for vector queries. High RU consumption might indicate missing indexes, excessive result counts, or suboptimal partition key design.

## Additional resources

- [VectorDistance function reference](/azure/cosmos-db/nosql/query/vectordistance)
- [Vector search in Azure Cosmos DB for NoSQL](/azure/cosmos-db/nosql/vector-search)
- [Query items in Azure Cosmos DB for NoSQL using Python](/azure/cosmos-db/nosql/how-to-python-query-items)
