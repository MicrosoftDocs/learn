Request unit (RU) consumption directly impacts the operational cost of your Azure Cosmos DB workloads. Queries that can use indexes consume RUs proportional to the result size, while queries that perform full scans consume RUs proportional to the data size. Strategic indexing reduces query costs while avoiding unnecessary overhead from indexing properties that aren't queried. This unit teaches practical strategies for designing indexing policies that balance query performance with cost efficiency for AI applications.

## Analyze query patterns before designing indexes

Effective indexing starts with understanding how your application queries data. Review the queries your application executes and identify which properties appear in `WHERE` clauses, `ORDER BY` clauses, and aggregate functions. Build indexes that support actual query patterns rather than theoretical possibilities.

You can start by cataloging your application's query patterns:

- **Filter properties:** Which properties appear in `WHERE` clauses? Are they equality filters (`=`) or range filters (`>`, `<`)?
- **Sort properties:** Which properties appear in `ORDER BY` clauses? What sort directions (ascending or descending) does the application use?
- **Property combinations:** Which properties appear together in the same query? Do queries filter on one property and sort by another?
- **Access frequency:** How often does each query pattern execute? Prioritize indexes for frequent queries.

This analysis reveals which indexes provide the most value. A query that executes thousands of times per minute justifies more index overhead than a query that runs once per day.

## Use query metrics to identify missing indexes

Azure Cosmos DB provides query metrics that reveal how efficiently queries use indexes. When queries perform poorly, metrics can help identify whether missing indexes are the cause.

The SDK returns query metrics through response headers when you enable metric collection. Key metrics to examine include:

- **Index utilization:** Percentage of the query that uses indexes versus scanning.
- **Retrieved document count:** Number of documents fetched from storage. High counts relative to returned results indicate inefficient filtering.
- **Output document count:** Number of documents returned in results.

The following Python example shows how to retrieve and examine query metrics:

```python
from azure.cosmos import CosmosClient

client = CosmosClient(endpoint, credential)
database = client.get_database_client("documents-db")
container = database.get_container_client("documents")

query = "SELECT * FROM c WHERE c.documentType = @type ORDER BY c.uploadDate DESC"
parameters = [{"name": "@type", "value": "pdf"}]

# Use response_hook to capture query metrics from response headers
query_metrics_output = {}

def response_hook(headers, results):
    query_metrics_output["metrics"] = headers.get("x-ms-documentdb-query-metrics", "")
    query_metrics_output["request_charge"] = headers.get("x-ms-request-charge", "")

results = container.query_items(
    query=query,
    parameters=parameters,
    populate_query_metrics=True,
    response_hook=response_hook
)

# Process results (this triggers the query execution and response_hook callback)
items = list(results)

# Access captured query metrics
print(f"Query metrics: {query_metrics_output.get('metrics', '')}")
print(f"Request charge: {query_metrics_output.get('request_charge', '')} RUs")
```

When query metrics show low index utilization or high retrieved-to-output ratios, investigate whether adding or modifying indexes improves performance. Create the missing index, wait for the transformation to complete, and then measure query costs again.

## Exclude properties not used in queries

Properties that your application reads but never filters or sorts don't need indexes. Large text fields stored for display, binary data, and embedding arrays used only for storage should be excluded from indexing.

Consider a document with the following structure:

```json
{
  "id": "doc-123",
  "title": "Quarterly Report Q4 2024",
  "documentType": "report",
  "category": "finance",
  "uploadDate": "2024-12-15T10:30:00Z",
  "content": "Full document text spanning thousands of words...",
  "summary": "AI-generated summary of the document...",
  "embedding": [0.123, 0.456, ...1536 values...],
  "rawMetadata": { "author": "...", "pageCount": 50, "fileSize": 2048000 }
}
```

If your application queries by `documentType`, `category`, and `uploadDate`, but only displays `content` and `summary` in results, the indexing policy should include only the queried properties:

```json
{
  "indexingMode": "consistent",
  "includedPaths": [
    { "path": "/title/?" },
    { "path": "/documentType/?" },
    { "path": "/category/?" },
    { "path": "/uploadDate/?" }
  ],
  "excludedPaths": [
    { "path": "/*" }
  ],
  "vectorIndexes": [
    { "path": "/embedding", "type": "diskANN" }
  ]
}
```

This policy indexes only the four properties used in queries, plus a vector index for embedding search. The large `content` field, `summary`, and `rawMetadata` aren't indexed because they don't appear in query filters.

## Include partition key in the index

While partition keys route queries to specific partitions, queries that filter on partition key properties still benefit from range indexes within each partition. Azure Cosmos DB doesn't index the partition key automatically when you use the exclude-by-default strategy.

If your partition key is `/tenantId` and queries filter by tenant:

```sql
SELECT * FROM c WHERE c.tenantId = 'tenant-123' AND c.status = 'active'
```

You can include the partition key path in your indexing policy:

```json
{
  "includedPaths": [
    { "path": "/tenantId/?" },
    { "path": "/status/?" },
    { "path": "/createdDate/?" }
  ],
  "excludedPaths": [
    { "path": "/*" }
  ]
}
```

Without the partition key in the index, queries that filter on it perform scans within each partition, consuming more RUs than necessary.

## Design composite indexes for common query combinations

Composite indexes provide the most benefit for frequently executed queries. Analyze which property combinations appear together in your application's queries and create composite indexes for the most common patterns.

Prioritize composite index creation based on:

- **Query frequency:** Queries that execute thousands of times benefit more from optimization than rare queries.
- **Data volume:** Queries against large datasets see more significant RU reduction from composite indexes.
- **Filter complexity:** Queries with multiple filters on high-cardinality properties benefit substantially from composite indexes.

Each composite index adds write overhead because Azure Cosmos DB maintains the index during every write operation. Creating dozens of composite indexes for edge cases increases write costs without proportional read benefits. Focus on the five to ten most impactful query patterns.

The following policy includes composite indexes for common AI application patterns:

```json
{
  "indexingMode": "consistent",
  "includedPaths": [
    { "path": "/title/?" },
    { "path": "/documentType/?" },
    { "path": "/category/?" },
    { "path": "/department/?" },
    { "path": "/uploadDate/?" },
    { "path": "/tags/[]" },
    { "path": "/metadata/author/?" }
  ],
  "excludedPaths": [
    { "path": "/*" }
  ],
  "compositeIndexes": [
    [
      { "path": "/documentType", "order": "ascending" },
      { "path": "/uploadDate", "order": "descending" }
    ],
    [
      { "path": "/category", "order": "ascending" },
      { "path": "/department", "order": "ascending" },
      { "path": "/uploadDate", "order": "descending" }
    ]
  ]
}
```

## Consider write-heavy versus read-heavy workloads

Your application's workload profile influences the optimal indexing strategy. Write-heavy applications benefit from minimal indexing, while read-heavy applications benefit from comprehensive indexing.

**Write-heavy characteristics:**
- High-volume document ingestion
- Frequent updates to existing documents
- Real-time data streaming
- Batch processing with periodic queries

For write-heavy workloads, minimize the number of indexed properties and composite indexes. Each index increases write latency and RU consumption. If queries are infrequent, the occasional higher query cost might be acceptable compared to constantly elevated write costs.

**Read-heavy characteristics:**
- Frequent queries from many concurrent users
- Search and retrieval applications
- Analytics and reporting workloads
- Real-time dashboards

For read-heavy workloads, invest in comprehensive indexing. The reduced query costs across many queries outweigh the modest increase in write costs. Create composite indexes for common query patterns and ensure all filtered properties are indexed.

Most AI applications are read-heavy—many users search and retrieve documents, while ingestion happens in batches or at lower frequency. You can design your indexing policy for efficient reads unless your specific workload profile indicates otherwise.

## Monitor index transformation progress

When you modify an indexing policy, Azure Cosmos DB performs an asynchronous transformation. The transformation updates indexes in the background without affecting availability, but queries don't benefit from new indexes until the transformation completes.

Monitor transformation progress to understand when new indexes become effective:

```python
# Check indexing progress through container properties
container_properties = container.read()
indexing_policy = container_properties.get("indexingPolicy", {})

# The Azure portal shows transformation progress as a percentage
# SDK access provides the policy but not real-time progress
# Use Azure portal or CLI for detailed progress monitoring
```

For large containers with millions of items, index transformations can take hours. You can plan index changes during low-traffic periods and allow sufficient time for transformations before expecting improved query performance.

> [!TIP]
> When replacing one index configuration with another, add the new index first and wait for transformation to complete. Then remove the old index. This approach ensures queries always have appropriate index support.

## Test RU consumption with realistic data

Index performance varies with data distribution and cardinality. Test queries against realistic data volumes and distributions to measure actual RU consumption.

Synthetic test data with uniform distributions might not reveal production performance characteristics. If production data has skewed distributions (some categories have many documents, others have few), query performance varies across partitions.

You can create test scenarios that reflect production patterns:

1. Load data with realistic cardinality and distribution
1. Execute representative query patterns
1. Measure RU consumption for each query type
1. Compare costs with and without specific indexes
1. Adjust indexing policy based on measured results

This empirical approach validates that your indexing strategy achieves the expected cost reduction for your specific workload.

## Additional resources

- [Indexing metrics in Azure Cosmos DB](/azure/cosmos-db/nosql/query-metrics)
- [Optimize request cost in Azure Cosmos DB](/azure/cosmos-db/optimize-cost-reads-writes)
- [Best practices for Azure Cosmos DB indexing](/azure/cosmos-db/nosql/best-practice-query#indexing-policy)
