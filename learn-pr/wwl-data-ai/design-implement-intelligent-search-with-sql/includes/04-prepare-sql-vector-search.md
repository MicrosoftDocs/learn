Before you can run vector searches, you need to store vectors in your database and decide how those searches execute. This unit covers the design decisions you make before writing your first vector query.

Vector search finds rows based on mathematical similarity rather than exact matches. To make this work, you store embeddings as vectors, choose how to measure similarity, and decide whether to search all vectors exactly or use an index for faster approximate results.

## Store vectors with the vector data type

SQL Server and Azure SQL Database provide a native **vector** data type designed for storing embeddings. Each vector is an array of floating-point numbers, stored in an optimized binary format but exposed as JSON arrays for convenience.

When you define a vector column, you specify the number of dimensions:

```sql
CREATE TABLE dbo.Products
(
    ProductID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Description NVARCHAR(MAX),
    DescriptionVector VECTOR(1536) NOT NULL
);
```

The number in parentheses matches the dimensions your embedding model produces. For example, OpenAI's text-embedding-3-small model produces 1,536 dimensions, so your column would be `VECTOR(1536)`. The maximum supported is 1,998 dimensions.

Each element is stored as a single-precision (4-byte) float. A 1,536-dimension vector uses about 6 KB per row. When designing your table, consider how this column affects storage and memory as your data grows.

## Understand distance metrics

Vector search works by calculating the distance between vectors. Vectors that are closer together represent more similar concepts. SQL Server supports three distance metrics:

**Cosine distance** measures the angle between vectors, ignoring their magnitude. Two vectors pointing in the same direction have a cosine distance of 0, regardless of their length. This metric works well when you care about the direction of meaning, not the intensity. Cosine distance ranges from 0 (identical) to 2 (opposite).

**Euclidean distance** measures the straight-line distance between two points in vector space. It considers both direction and magnitude. Euclidean distance ranges from 0 (identical) to infinity.

**Dot product** calculates the sum of element-wise products. SQL Server returns the negative dot product so that smaller values indicate more similar vectors, consistent with the other metrics.

Most embedding models are optimized for cosine similarity, making cosine distance the common choice. However, the best metric depends on how your embeddings were trained.

## Choose between exact and approximate search

When you search for similar vectors, you have two options: exact nearest neighbor (ENN) search and approximate nearest neighbor (ANN) search.

**Exact nearest neighbor search** compares your query vector against every vector in the table. It guarantees the most accurate results but requires calculating the distance to every row. Use the `VECTOR_DISTANCE` function for exact search:

```sql
DECLARE @query VECTOR(1536) = '[0.1, 0.2, ...]';

SELECT TOP 10 ProductID, Name,
    VECTOR_DISTANCE('cosine', @query, DescriptionVector) AS Distance
FROM dbo.Products
ORDER BY Distance;
```

This query calculates the cosine distance between `@query` and every row's `DescriptionVector`, then returns the 10 closest matches. For small tables (under 50,000 vectors as a general guideline), exact search performs well.

**Approximate nearest neighbor search** uses a vector index to find similar vectors without scanning every row. It trades perfect accuracy for speed, returning results that are very close to exact but not guaranteed to be the absolute nearest neighbors.

Create a vector index using `CREATE VECTOR INDEX`:

```sql
CREATE VECTOR INDEX idx_Products_DescriptionVector
ON dbo.Products(DescriptionVector)
WITH (METRIC = 'cosine', TYPE = 'DiskANN');
```

SQL Server uses the DiskANN algorithm, which builds a graph structure that allows fast navigation to nearby vectors. Once the index exists, use the `VECTOR_SEARCH` function for approximate search:

```sql
DECLARE @query VECTOR(1536) = '[0.1, 0.2, ...]';

SELECT t.ProductID, t.Name, s.distance
FROM VECTOR_SEARCH(
    TABLE = dbo.Products AS t,
    COLUMN = DescriptionVector,
    SIMILAR_TO = @query,
    METRIC = 'cosine',
    TOP_N = 10
) AS s
ORDER BY s.distance;
```

## Decide when to use each approach

The choice between exact and approximate search depends on your dataset size and accuracy requirements.

**Use exact search (VECTOR_DISTANCE) when:**
- Your table has fewer than 50,000 vectors
- Your query filters reduce the candidate set to a few rows
- You need guaranteed accurate results and can accept longer query times

**Use approximate search (VECTOR_SEARCH with an index) when:**
- Your table has hundreds of thousands or millions of vectors
- Query speed matters more than perfect accuracy
- A recall close to 1 (meaning most true nearest neighbors are found) is acceptable

Recall measures how many of the true nearest neighbors the approximate search returns compared to an exact search. DiskANN typically achieves high recall, meaning the results are very close to what exact search would return.

## Consider index limitations

Vector indexes in SQL Server have specific requirements to be aware of:

- The table must have a single-column integer primary key with a clustered index
- Tables with vector indexes become read-only while the index exists—you must drop the index to modify data, then recreate it
- Vector indexes can't be partitioned

> [!NOTE]
> Vector indexes are currently in preview. In Azure SQL Database and SQL database in Microsoft Fabric, you can set the `ALLOW_STALE_VECTOR_INDEX` database scoped configuration to `ON` to allow writes, but the index doesn't reflect new data until you rebuild it. This option isn't currently available in SQL Server 2025. Check the current documentation for the latest on these limitations.

These limitations affect how you design your tables and maintenance workflows. For tables that change frequently, you might use exact search until the data stabilizes, then add a vector index.

## Key takeaways

Preparing SQL for vector search means making three decisions: what data type and dimensions to use, which distance metric matches your embedding model, and whether exact or approximate search fits your dataset size. Exact search with `VECTOR_DISTANCE` works well for smaller datasets or filtered queries, while approximate search with `VECTOR_SEARCH` and a DiskANN index handles larger datasets efficiently. In the next unit, you'll learn the specific functions and query patterns for running vector searches.
