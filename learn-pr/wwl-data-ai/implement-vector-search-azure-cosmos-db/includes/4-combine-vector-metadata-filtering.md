Real-world AI applications rarely rely on pure semantic search. Users typically want results filtered by category, date range, access permissions, or other attributes. Azure Cosmos DB's integrated architecture enables you to combine vector similarity search with traditional query filters in a single query, and to merge semantic results with keyword-based full-text search using hybrid search techniques.

## Add WHERE clauses to vector queries

You can combine vector similarity search with standard filter predicates in the same query. Filters execute before or during vector distance calculation depending on the query optimizer's assessment of filter selectivity. When filters significantly reduce the search space, they improve query performance by limiting the number of vectors that need comparison.

The following query combines vector search with filters on category and date:

```python
query = """
    SELECT TOP 10
        c.id,
        c.title,
        c.category,
        c.createdDate,
        VectorDistance(c.embedding, @queryVector) AS SimilarityScore
    FROM c
    WHERE c.category = @category
        AND c.createdDate > @startDate
    ORDER BY VectorDistance(c.embedding, @queryVector)
"""

results = container.query_items(
    query=query,
    parameters=[
        {"name": "@queryVector", "value": query_embedding},
        {"name": "@category", "value": "networking"},
        {"name": "@startDate", "value": "2024-01-01T00:00:00Z"}
    ],
    enable_cross_partition_query=True
)
```

This query finds documents semantically similar to the query vector but only within the "networking" category and created after January 2024. Support agents can focus their search on relevant product areas without wading through unrelated documentation.

## Understand pre-filtering and post-filtering

When you combine filters with vector search, the query optimizer determines whether to apply filters before vector comparison (pre-filtering) or after ranking (post-filtering). This decision affects both performance and result quality.

**Pre-filtering** reduces the search space before vector comparison. If you filter to a category with 1,000 documents out of 100,000 total, the vector search only compares against those 1,000 documents. Pre-filtering improves efficiency when filters are selective (eliminate most documents).

**Post-filtering** applies filters after the vector search ranks all documents. This preserves ranking quality but might return fewer results than requested if many top-ranked documents fail the filter criteria. The query might return only three results when you requested ten if seven of the top semantic matches were filtered out.

The query optimizer automatically chooses the approach based on filter selectivity estimates. For best performance, ensure your filter properties have appropriate indexes defined in your indexing policy.

## Apply common filter patterns for AI applications

Different AI applications benefit from different filtering strategies. Consider these common patterns when designing queries for your support knowledge base:

**Filter by document type:** Restrict searches to specific content types like FAQs, troubleshooting guides, or release notes.

```sql
WHERE c.documentType = 'troubleshooting-guide'
```

**Filter by date range:** Find recent content or content within a specific time window.

```sql
WHERE c.createdDate >= '2024-01-01' AND c.createdDate < '2025-01-01'
```

**Filter by product or version:** Narrow results to specific products the customer uses.

```sql
WHERE c.productId IN ('router-x100', 'router-x200')
```

**Filter by access permissions:** Ensure users only see content they're authorized to access.

```sql
WHERE ARRAY_CONTAINS(c.accessGroups, @userGroup)
```

**Filter by status:** Exclude draft, archived, or deprecated content.

```sql
WHERE c.status = 'published'
```

Combining multiple filters creates precise search scopes. A query for "WiFi problems" filtered to published networking guides for router-x100 created in 2024 returns highly targeted results.

## Optimize queries with partition keys

When your query's `WHERE` clause includes the partition key, Azure Cosmos DB routes the query to a single partition instead of scanning all partitions. This optimization significantly reduces RU consumption and latency. Design your partition key strategy to align with common filter patterns.

For the support knowledge base using `/category` as the partition key, queries filtered by category automatically benefit from partition targeting:

```python
query = """
    SELECT TOP 10
        c.id,
        c.title,
        VectorDistance(c.embedding, @queryVector) AS SimilarityScore
    FROM c
    WHERE c.category = @category
    ORDER BY VectorDistance(c.embedding, @queryVector)
"""

# Query routes to single partition
results = container.query_items(
    query=query,
    parameters=[
        {"name": "@queryVector", "value": query_embedding},
        {"name": "@category", "value": "networking"}
    ],
    partition_key="networking"
)
```

Note the `partition_key` parameter in `query_items`. While the `WHERE` clause tells the database what data to return, the `partition_key` parameter explicitly routes the query to a single partition for maximum efficiency.

## Combine vector and full-text search with hybrid queries

Sometimes semantic search alone isn't enough. Users might search for specific error codes, product names, or technical terms that need exact matching rather than semantic similarity. Hybrid search combines vector similarity with full-text search scoring using the Reciprocal Rank Fusion (RRF) function.

RRF merges rankings from multiple scoring functions into a unified result set. Documents that rank highly in both vector and keyword searches appear at the top, while documents that excel in only one dimension still appear in results.

Before using hybrid search, configure your container with both a vector policy and a full-text policy. The full-text policy specifies which text properties support keyword search:

```json
{
    "defaultLanguage": "en-US",
    "fullTextPaths": [
        {
            "path": "/content",
            "language": "en-US"
        }
    ]
}
```

The indexing policy must include both vector and full-text indexes:

```json
{
    "vectorIndexes": [
        {"path": "/embedding", "type": "diskANN"}
    ],
    "fullTextIndexes": [
        {"path": "/content"}
    ]
}
```

With these policies configured, hybrid queries use the `ORDER BY RANK RRF` clause:

```sql
SELECT TOP 10 *
FROM c
ORDER BY RANK RRF(
    VectorDistance(c.embedding, @queryVector),
    FullTextScore(c.content, @searchTerm1, @searchTerm2)
)
```

A support agent searching for "error code 0x80070005 access denied" benefits from hybrid search. The error code needs exact matching (full-text), while "access denied" works better semantically (vector). RRF combines both approaches to return the most relevant results.

## Control hybrid search weighting

You can adjust how much influence each scoring component has on final rankings by providing weights to the `RRF` function. Weights are specified as an array of numbers in the order the scoring functions appear.

The following query weights vector search twice as heavily as full-text search:

```sql
SELECT TOP 10 *
FROM c
ORDER BY RANK RRF(
    VectorDistance(c.embedding, @queryVector),
    FullTextScore(c.content, @searchTerm1, @searchTerm2),
    [2, 1]
)
```

With weights of `[2, 1]`, a document's vector similarity score contributes twice as much to its final rank as its keyword match score. Adjust weights based on your application's needs:

- **Higher vector weight:** Prioritizes semantic understanding. Use when users describe problems in natural language.
- **Higher full-text weight:** Prioritizes exact keyword matches. Use when users search for specific terms, codes, or names.
- **Equal weights:** Balances both approaches. A good starting point for general-purpose search.

You can experiment with different weight combinations using representative queries to find the optimal balance for your use case.

## Execute multi-vector search

Some applications store multiple embeddings per document—for example, separate embeddings for title and content, or embeddings from different models. You can combine similarity scores from multiple `VectorDistance` calls using `RRF` to find documents that match across different embedding spaces.

```sql
SELECT TOP 10 *
FROM c
ORDER BY RANK RRF(
    VectorDistance(c.titleEmbedding, @queryVector),
    VectorDistance(c.contentEmbedding, @queryVector)
)
```

This query finds documents where either the title or content closely matches the query, with documents matching in both spaces ranked highest. Multi-vector search is useful when different document sections have different semantic characteristics—a document's title often captures its main topic while its content provides detailed information.

## Evaluate performance trade-offs

Complex queries with filters and hybrid search consume more RUs than simple vector searches. Test your queries with realistic data volumes and filter combinations to understand their resource requirements.

**Filter selectivity matters:** Filters that eliminate most documents improve performance. Filters that match most documents provide little benefit and might add overhead.

**Hybrid search costs more:** Combining `VectorDistance` with `FullTextScore` requires evaluating both scoring functions. Use hybrid search when it provides clear value, not by default.

**Index all filter properties:** Ensure properties used in `WHERE` clauses have appropriate indexes. Unindexed filters cause full scans that multiply RU costs.

**Test with production data volumes:** Query performance characteristics change significantly between development datasets (thousands of documents) and production datasets (millions of documents). Test early with representative data sizes.

You can monitor query metrics through the Azure portal or by examining the response headers from the SDK. The `x-ms-request-charge` header shows the RU cost of each query, helping you identify expensive operations that might need optimization.

## Additional resources

- [Hybrid search in Azure Cosmos DB for NoSQL](/azure/cosmos-db/gen-ai/hybrid-search)
- [RRF system function](/azure/cosmos-db/nosql/query/rrf)
- [FullTextScore system function](/azure/cosmos-db/nosql/query/fulltextscore)
