Azure Cosmos DB for NoSQL uses indexes to execute queries efficiently without scanning entire containers. Understanding how indexes work helps you make informed decisions about which properties to index and which index types to use. By default, Azure Cosmos DB automatically indexes all properties in every item, which provides good query performance without upfront configuration. However, customizing the indexing policy unlocks significant performance and cost optimizations for AI workloads that have predictable access patterns.

## Understand automatic indexing behavior

When you create a new container in Azure Cosmos DB, the default indexing policy automatically indexes every property of every item using range indexes. This behavior means that queries on any property can use indexes immediately without additional configuration. The automatic approach simplifies initial development because you don't need to anticipate every query pattern before writing code.

However, automatic indexing has trade-offs that become important as your AI application scales. Each indexed property consumes storage space and adds overhead to write operations. For applications that store large embedding arrays or text content that's never queried, the default policy indexes data unnecessarily. Understanding these trade-offs helps you decide when to customize the indexing policy for your specific workload.

## Explore index types

Azure Cosmos DB supports several index types, each optimized for specific query patterns. The following four types are most relevant for optimizing AI workloads. Azure Cosmos DB also supports full-text indexes and tuple indexes, which are covered later in this learning path. Selecting the appropriate index type for each property ensures that queries execute efficiently while minimizing storage and write overhead.

**Range indexes** support equality queries (`=`), range queries (`>`, `<`, `>=`, `<=`, `!=`), and `ORDER BY` clauses on single properties. Range indexes also enable string functions like `CONTAINS`, `STARTSWITH`, `ENDSWITH`, and `StringEquals`, as well as `IS_DEFINED` checks. AI applications that filter documents by type, status, date ranges, or numeric thresholds rely on range indexes for efficient query execution.

**Composite indexes** optimize queries that sort on multiple properties or filter on multiple properties simultaneously. When a query includes an `ORDER BY` clause with two or more properties, Azure Cosmos DB requires a composite index that matches the exact property sequence and sort direction. Composite indexes also improve performance for queries that combine equality filters with range filters on different properties.

**Spatial indexes** enable geospatial queries using functions like `ST_DISTANCE`, `ST_WITHIN`, and `ST_INTERSECTS`. AI applications that incorporate location-based filtering, such as finding nearby points of interest or filtering results within a geographic boundary, use spatial indexes to execute these queries efficiently.

**Vector indexes** accelerate similarity searches using the `VectorDistance` system function. Vector indexes are essential for AI applications that store embeddings and perform semantic search, recommendation, or similarity-based retrieval. Azure Cosmos DB offers three vector index types: flat, quantizedFlat, and diskANN. Each type is suited for different dataset sizes and accuracy requirements.

## Choose an indexing mode

Azure Cosmos DB provides two indexing modes that control when and how indexes are updated:

- **Consistent:** The index is updated synchronously during each write operation. Queries always reflect the latest committed writes because the index is up to date when the write completes. This mode is the default and suits most workloads.

- **None:** Indexing is disabled on the container. This mode treats the container as a pure key-value store where data is retrieved only by point reads using the item ID and partition key. Disabling indexing can improve write performance for bulk operations, but queries without indexes perform full scans.

For AI applications, consistent indexing mode is typically the right choice because queries need to find recently ingested documents and embeddings. The none mode applies only to specialized scenarios where you never query by secondary properties.

> [!NOTE]
> Azure Cosmos DB previously supported a lazy indexing mode that updated indexes at lower priority. This mode is deprecated and new containers can't use it. Existing containers with lazy indexing should migrate to consistent mode.

## Understand index storage costs

Index size contributes to the total storage consumed by a container. Several factors affect how much storage indexes require:

- **Number of indexed properties:** Each indexed property path increases index storage. Containers that index many properties or deeply nested structures consume more index storage relative to data size.

- **Property value cardinality:** Properties with many distinct values, such as unique identifiers or timestamps, require larger index structures than properties with few distinct values.

- **Array elements:** When arrays are indexed, each element is indexed separately. Large arrays with many elements significantly increase index storage.

For AI applications that store embeddings, the embedding arrays can contain hundreds or thousands of numeric values. Including these arrays in range indexes dramatically increases storage costs without providing query benefits. Vector searches use vector indexes instead. Excluding embedding paths from range indexes reduces storage costs substantially.

> [!IMPORTANT]
> The partition key (unless it is also `/id`) is not indexed automatically and should be explicitly included in your indexing policy. Queries that filter on the partition key benefit from range indexes within each partition. If you exclude the partition key from indexing, queries filtering on it perform full scans, resulting in higher RU consumption.

## Include and exclude property paths

Indexing policies use path expressions to specify which properties to index. Paths follow a specific syntax that supports scalar values, array elements, and wildcards:

- `/*` includes all properties from the root, recursively indexing every scalar value.
- `/propertyName/?` indexes the scalar value at the specified property.
- `/arrayName/[]` indexes all elements within an array.
- `/nested/path/*` indexes all properties under a nested path.

When include and exclude paths conflict, the more specific path takes precedence. This precedence rule allows you to exclude large portions of the document tree while selectively including specific properties that you need to query.

The following example shows the default indexing policy that indexes all properties:

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    { "path": "/*" }
  ],
  "excludedPaths": [
    { "path": "/\"_etag\"/?" }
  ]
}
```

The policy includes all paths with `/*` and excludes only the `_etag` system property. This default configuration indexes every property without requiring you to specify each path explicitly.

The following example shows a selective indexing policy that indexes only the properties used in queries:

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    { "path": "/title/?" },
    { "path": "/category/?" },
    { "path": "/createdDate/?" },
    { "path": "/metadata/*" }
  ],
  "excludedPaths": [
    { "path": "/*" }
  ]
}
```

This policy excludes all paths by default with `/*` in `excludedPaths`, then selectively includes specific properties. The `title`, `category`, and `createdDate` properties are indexed as scalar values using `/?`. All properties under `metadata` are indexed using `/*`. Properties not explicitly included, such as large text content or embedding arrays, aren't indexed.

## Understand system property indexing

Azure Cosmos DB handles several system properties automatically:

- **id and _ts:** These system properties are always indexed when using consistent indexing mode. You can't disable indexing for these properties.

- **_etag:** This property is excluded from indexing by default. You can include it explicitly if your queries filter on ETags, though this is uncommon.

The `id` property serves as the unique identifier within a partition, and `_ts` represents the last modified timestamp. Because these properties are always indexed, you can filter and sort by them without modifying your indexing policy.

## Additional resources

- [Indexing policies in Azure Cosmos DB](/azure/cosmos-db/index-policy)
- [Indexing overview in Azure Cosmos DB](/azure/cosmos-db/index-overview)
- [How to manage indexing policies in Azure Cosmos DB](/azure/cosmos-db/how-to-manage-indexing-policy)
