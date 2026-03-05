AI applications use diverse data retrieval patterns to deliver results to users. A semantic search platform might filter documents by type, sort results by relevance score and date, and perform vector similarity searches. All of these operations might happen within a single user request. Each query pattern requires specific index configurations to execute efficiently. Poorly designed indexes force Azure Cosmos DB to scan entire partitions or containers, dramatically increasing latency and request unit (RU) consumption. Understanding how to design indexes for common AI retrieval patterns helps you build applications that deliver consistent, cost-effective performance.

## Design range indexes for filter operations

Range indexes support the most common filter operations in AI applications. Queries that filter documents by type, status, category, date ranges, or numeric thresholds use range indexes to locate matching items without scanning the entire container.

Consider a document search application that stores metadata about uploaded files. Users filter documents by type (`pdf`, `docx`, `image`) and upload date. The following query uses range indexes on both properties:

```sql
SELECT * FROM c
WHERE c.documentType = 'pdf'
  AND c.uploadDate > '2024-01-01'
```

When both `documentType` and `uploadDate` have range indexes, Azure Cosmos DB uses the indexes to find matching documents efficiently. Without indexes, the query performs a full scan of the partition, consuming RUs proportional to the data size rather than the result size.

Range indexes also support string functions that AI applications use for text matching. Functions like `CONTAINS`, `STARTSWITH`, and `ENDSWITH` can use range indexes when the indexed property appears as the first argument. These functions enable partial text matching without requiring full-text search infrastructure.

## Configure composite indexes for multi-property sorting

Queries that sort results by multiple properties require composite indexes. The composite index must match the exact sequence of properties and sort directions in the `ORDER BY` clause. AI applications often sort results by relevance score and then by date, or by category and then by title.

The following query sorts documents by relevance score (descending) and then by upload date (descending):

```sql
SELECT * FROM c
ORDER BY c.relevanceScore DESC, c.uploadDate DESC
```

Without a composite index matching this exact pattern, the query fails with an error indicating that a composite index is required. The following indexing policy adds the required composite index:

```json
{
  "compositeIndexes": [
    [
      { "path": "/relevanceScore", "order": "descending" },
      { "path": "/uploadDate", "order": "descending" }
    ]
  ]
}
```

Composite indexes also support queries with the opposite sort order on all paths. A composite index defined as `(relevanceScore DESC, uploadDate DESC)` also supports `ORDER BY c.relevanceScore ASC, c.uploadDate ASC`. However, it doesn't support mixed orders like `ORDER BY c.relevanceScore DESC, c.uploadDate ASC`. That pattern requires a separate composite index.

## Optimize queries with filters and ORDER BY

Many AI retrieval patterns filter on one property and sort by another. For example, users might filter documents by category and sort results by date. You can optimize these queries by including the filter property in the `ORDER BY` clause, which allows a single composite index to serve the query.

Consider this query that filters by document type and sorts by upload date:

```sql
SELECT * FROM c
WHERE c.documentType = 'pdf'
ORDER BY c.uploadDate DESC
```

This query uses a range index for the filter and requires the results to be sorted. By rewriting the query to include the filter property in `ORDER BY`, you enable use of a composite index:

```sql
SELECT * FROM c
WHERE c.documentType = 'pdf'
ORDER BY c.documentType, c.uploadDate DESC
```

The rewritten query uses a composite index on `(documentType ASC, uploadDate DESC)`. This optimization significantly reduces RU consumption for queries that filter on one property and sort by another. The following indexing policy supports common filter and sort combinations:

```json
{
  "compositeIndexes": [
    [
      { "path": "/documentType", "order": "ascending" },
      { "path": "/uploadDate", "order": "descending" }
    ],
    [
      { "path": "/category", "order": "ascending" },
      { "path": "/relevanceScore", "order": "descending" }
    ]
  ]
}
```

This policy defines two composite indexes that optimize queries filtering by document type or category while sorting by date or relevance score.

## Use composite indexes for multi-property filters

Queries that filter on multiple properties can benefit from composite indexes. When designing composite indexes for filters, place equality filters first in the index definition. Each composite index supports at most one range filter, which must be the last property in the index.

The following query filters on three properties:

```sql
SELECT * FROM c
WHERE c.category = 'reports'
  AND c.department = 'finance'
  AND c.createdDate > '2024-06-01'
```

The equality filters (`category` and `department`) should appear first in the composite index, followed by the range filter (`createdDate`). The following composite index optimizes this query:

```json
{
  "compositeIndexes": [
    [
      { "path": "/category", "order": "ascending" },
      { "path": "/department", "order": "ascending" },
      { "path": "/createdDate", "order": "ascending" }
    ]
  ]
}
```

If a query has multiple range filters, you need multiple composite indexes because each index supports only one range filter. For a query filtering on `age > 18` and `timestamp > someValue` with an equality filter on `name`, you need two separate composite indexes:

- `(name ASC, age ASC)` for the first range filter
- `(name ASC, timestamp ASC)` for the second range filter

Azure Cosmos DB uses both indexes together to evaluate the complete query.

## Configure tuple indexes for array element filtering

AI applications often store structured data within arrays, such as document chunks with positions and text, tags with categories and weights, or events with timestamps and types. When queries filter on multiple properties within array elements, tuple indexes improve query efficiency.

Consider a document that stores text chunks with position information:

```json
{
  "id": "doc-123",
  "title": "Annual Report 2024",
  "chunks": [
    { "position": 0, "text": "Executive summary...", "tokens": 150 },
    { "position": 1, "text": "Financial highlights...", "tokens": 200 },
    { "position": 2, "text": "Market analysis...", "tokens": 180 }
  ]
}
```

A query that finds chunks at specific positions with minimum token counts filters on both `position` and `tokens` within the same array element:

```sql
SELECT c.id, chunk.text
FROM c
JOIN chunk IN c.chunks
WHERE chunk.position >= 0
  AND chunk.position < 3
  AND chunk.tokens > 100
```

A tuple index on the `chunks` array improves this query's efficiency by indexing the property combinations within each array element. The following path expression defines a tuple index:

```json
{
  "includedPaths": [
    { "path": "/*" },
    { "path": "/chunks/[]/{position, tokens}/?" }
  ]
}
```

The tuple path `/chunks/[]/{position, tokens}/?` indexes the combination of `position` and `tokens` for each element in the `chunks` array. Tuple indexes are particularly valuable for AI applications that store chunked documents where queries frequently filter on chunk position, size, or other metadata.

## Balance read and write performance

Every index increases write latency and RU consumption because Azure Cosmos DB updates the indexes synchronously during write operations. AI applications with high write throughput, such as those ingesting documents, updating embeddings, or processing real-time data, need to balance index coverage against write performance.

Consider these guidelines when designing indexes for AI workloads:

- **Include only queried properties:** If a property is stored but never appears in query filters or `ORDER BY` clauses, exclude it from indexing.

- **Analyze query frequency:** Create composite indexes for queries that execute frequently. Rare queries might not justify the write overhead of additional indexes.

- **Monitor RU consumption:** Compare the RU cost of writes with and without specific indexes. If writes are the dominant workload, fewer indexes might provide better overall performance.

- **Use selective indexing:** Instead of indexing all properties with `/*`, explicitly include only the paths that queries need.

## Understand index transformation behavior

When you modify an indexing policy, Azure Cosmos DB performs an asynchronous transformation to update indexes. Understanding this behavior helps you plan index changes without disrupting application performance.

- **Adding indexes:** New indexes don't improve query performance until the transformation completes. During transformation, queries continue using existing indexes or fall back to scans.

- **Removing indexes:** When you remove an index, queries immediately stop using it and fall back to scans. This happens before the transformation completes.

- **Replacing indexes:** If you're replacing one index pattern with another, add the new index first and wait for the transformation to complete. Then remove the old index. This approach ensures queries always have appropriate index support.

You can track index transformation progress using the Azure portal or SDKs. For large containers with millions of items, transformations can take significant time. Plan index changes during low-traffic periods when possible to minimize impact on provisioned throughput.

## Additional resources

- [Composite indexes in Azure Cosmos DB](/azure/cosmos-db/index-policy#composite-indexes)
- [Tuple indexes in Azure Cosmos DB](/azure/cosmos-db/index-policy#tuple-indexes)
- [How to manage indexing policies](/azure/cosmos-db/how-to-manage-indexing-policy)
