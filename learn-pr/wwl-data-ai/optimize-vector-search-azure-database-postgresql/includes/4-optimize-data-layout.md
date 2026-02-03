Data modeling decisions significantly affect vector search performance. How you structure tables, choose data types for metadata, and create supporting indexes determines whether queries execute efficiently as your dataset grows.

> [!NOTE]
> Code examples in this unit demonstrate schema design patterns for vector data with metadata. Adapt these patterns to your specific data model and query requirements.

## Vector storage considerations

Vector columns consume substantial storage and processing resources. Understanding the storage characteristics helps you make informed decisions about schema design.

Each vector dimension adds 4 bytes of storage (for single-precision float) plus fixed overhead. The relationship between dimensions and storage is linear:

| Dimensions | Bytes per vector | 1 million vectors |
|--|--|--|
| 384 | ~1.5 KB | ~1.5 GB |
| 768 | ~3 KB | ~3 GB |
| 1536 | ~6 KB | ~6 GB |
| 3072 | ~12 KB | ~12 GB |

For a product catalog with two million items using 1536-dimensional embeddings, the vector column alone requires approximately 12 GB of storage. Adding HNSW indexes increases this by roughly 50%.

Many embedding models offer multiple dimension options. Lower dimensions reduce storage and computation costs while maintaining reasonable quality for many use cases. Specifying dimensions in the column definition provides validation. Attempts to insert vectors with different dimensions fail with an error, preventing subtle bugs from mismatched embedding models. Define your table with an explicit dimension constraint using `embedding vector(768)` in the column definition.

Some applications need vectors from different models. For example, you might store product title embeddings, image embeddings, and user behavior embeddings separately. Each vector column needs its own index because you can't create a single index that covers multiple vector columns.

```sql
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    title_embedding vector(768),      -- Text embedding model
    image_embedding vector(512),       -- Image embedding model
    category_id INTEGER,
    price NUMERIC(10,2)
);

-- Create separate indexes for each embedding type
CREATE INDEX ON products USING hnsw (title_embedding vector_cosine_ops);
CREATE INDEX ON products USING hnsw (image_embedding vector_cosine_ops);
```

## Metadata data types: structured columns versus JSONB

Product recommendations rarely use vector similarity alone. Queries typically filter by category, price range, availability, or other attributes before or alongside vector search. How you store this metadata affects query performance.

Structured columns use PostgreSQL's native data types (INTEGER, TIMESTAMP, NUMERIC, TEXT) with explicit schema. These columns offer query performance benefits because native types enable efficient B-tree indexes for equality and range queries, storage efficiency through optimized storage formats, type safety through insert-time validation, and query optimization through accurate planner statistics. Use structured columns when attributes are known at design time, you frequently filter or sort by specific attributes, or query performance is critical.

```sql
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    embedding vector(1536),
    category_id INTEGER NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    in_stock BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    brand TEXT,
    rating NUMERIC(2,1)
);
```

JSONB stores semi-structured data as binary JSON, offering flexibility for dynamic attributes. JSONB provides schema flexibility (different products can have different attributes), easy evolution (add new attributes without schema migrations), and nested structures (store complex hierarchical data). However, JSONB has query overhead (extracting values requires parsing), index limitations (GIN indexes work for containment queries but not range queries), and planner uncertainty (statistics are less precise for JSONB contents).

For filtered vector searches, the metadata filter performance directly affects total query time. Structured columns with B-tree indexes enable PostgreSQL to quickly narrow candidates before vector distance calculations, while JSONB requires different query patterns and index types. A structured column filter like `WHERE category_id = 5 AND price BETWEEN 100 AND 500` can use a B-tree index on `(category_id, price)` to quickly identify candidate rows. A JSONB filter like `WHERE attributes @> '{"category": "electronics"}' AND (attributes->>'price')::numeric BETWEEN 100 AND 500` requires either a GIN index (which doesn't help with range queries on price) or a sequential scan of the JSONB column.

Many applications benefit from combining structured columns and JSONB: use structured columns for frequently filtered attributes where query performance matters, and JSONB for dynamic or rarely filtered attributes where schema flexibility is more valuable. This pattern lets you optimize the common case without sacrificing flexibility for edge cases.

```sql
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    embedding vector(1536),
    -- Structured columns for common filters
    category_id INTEGER NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    in_stock BOOLEAN DEFAULT true,
    -- JSONB for dynamic attributes
    attributes JSONB DEFAULT '{}'
);
```

## Metadata indexes for filtered searches

Metadata indexes complement vector indexes by accelerating the filtering phase of queries. Without proper metadata indexes, PostgreSQL might need to scan all rows to apply filters before vector search.

Create B-tree indexes on columns used in WHERE clauses. Single-column indexes handle exact matches, while composite indexes handle filter combinations. Composite indexes are most effective when queries filter on the leftmost columns. An index on `(category_id, price)` efficiently handles `WHERE category_id = 5` and `WHERE category_id = 5 AND price < 100`, but it doesn't help with `WHERE price < 100` alone because price isn't the leftmost column.

```sql
-- Single-column index for exact matches
CREATE INDEX idx_products_category ON products (category_id);

-- Composite index for common filter combinations
CREATE INDEX idx_products_category_price ON products (category_id, price);
```

If most queries filter on the same condition (such as in-stock products), a partial index reduces index size and improves performance. This index is smaller than a full index and is used only for queries that include `WHERE in_stock = true`. For an e-commerce recommendation engine where nearly all queries target available products, this can significantly reduce index maintenance overhead. Create a partial index with `CREATE INDEX idx_products_instock_category ON products (category_id) WHERE in_stock = true;`.

If you use JSONB for attributes, GIN indexes support containment queries using the `@>` (contains), `<@` (contained by), `?` (key exists), and `?|`/`?&` (any/all keys exist) operators. They don't accelerate range queries or arbitrary JSON path expressions. Create a GIN index with `CREATE INDEX idx_products_attributes ON products USING gin (attributes);`. For frequently queried JSONB fields that need range queries, consider expression indexes. Create an expression index on a JSONB field extracted as numeric with `CREATE INDEX idx_products_json_price ON products (((attributes->>'price')::numeric));` to enable range queries on that field.

## Combine vector search with metadata filters

PostgreSQL executes queries by combining index scans with filtering. Understanding execution patterns helps you write efficient queries.

The most efficient pattern applies metadata filters first, reducing the set of vectors that need similarity calculations. PostgreSQL uses metadata indexes to identify products matching the filters, then applies vector similarity only to those candidates. If 5% of products match the filters, you're searching 100,000 vectors instead of 2 million.

```sql
-- Efficient: filter narrows candidates before vector search
SELECT id, name, embedding <=> $1 AS distance
FROM products
WHERE category_id = 5
  AND in_stock = true
  AND price BETWEEN 100 AND 500
ORDER BY embedding <=> $1
LIMIT 10;
```

Use `EXPLAIN ANALYZE` to verify that queries use expected indexes and to identify performance bottlenecks. The query plan shows whether PostgreSQL uses your metadata indexes to filter candidates before vector search, or whether it resorts to sequential scans that examine every row. Look for **Index Scan** or **Bitmap Index Scan** on metadata columns (efficient), **Index Scan** using the vector index (efficient), and **Seq Scan** on large tables (potentially inefficient). If you see unexpected sequential scans, check that appropriate indexes exist and that statistics are current using `ANALYZE products;`.

Some queries don't lend themselves to efficient filtering. When filters don't eliminate many rows (such as `WHERE price > 0` which nearly all products match), PostgreSQL might skip metadata indexes entirely and rely on the vector index alone. This is expected behavior because the optimizer makes cost-based decisions.

Sometimes you need results from the vector index that also satisfy constraints not efficiently filterable beforehand. The post-filtering pattern fetches more vector-similar candidates than needed, then applies filters. Adjust the inner LIMIT based on expected filter selectivity.

```sql
-- Get more candidates than needed, then filter
WITH candidates AS (
    SELECT id, name, price, in_stock, embedding <=> $1 AS distance
    FROM products
    ORDER BY embedding <=> $1
    LIMIT 100
)
SELECT id, name, distance
FROM candidates
WHERE in_stock = true AND price BETWEEN 100 AND 500
ORDER BY distance
LIMIT 10;
```

## Table partitioning for large datasets

Partitioning divides a large table into smaller, more manageable pieces. For vector workloads, partitioning can improve query performance and simplify maintenance.

Consider partitioning when tables exceed tens of millions of rows, queries naturally filter by partition key (date, category, tenant), you need to efficiently drop old data (partition pruning), or index build times become prohibitive on the full table.

For applications that process time-series embeddings (such as user activity vectors or content published over time), range partitioning by date is effective. Queries that filter by date scan only relevant partitions. Each partition has its own indexes, making maintenance more manageable.

```sql
-- Create partitioned table
CREATE TABLE user_interactions (
    id BIGSERIAL,
    user_id BIGINT NOT NULL,
    embedding vector(768),
    created_at TIMESTAMP NOT NULL,
    interaction_type TEXT
) PARTITION BY RANGE (created_at);

-- Create partitions for each month
CREATE TABLE user_interactions_2025_01
    PARTITION OF user_interactions
    FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');
```

For multitenant applications or product catalogs with natural categories, list or hash partitioning can help. Queries filtered by category scan only the relevant partition, reducing both data scanned and index size.

Create indexes on the parent table to automatically create matching indexes on all partitions using `CREATE INDEX ON products USING hnsw (embedding vector_cosine_ops);`. Each partition has its own index, which can be built or rebuilt independently. This is valuable for large datasets where rebuilding a single global index would take hours.

Partitioning adds complexity. Queries that span many partitions might be slower than on a single table. Cross-partition unique constraints require the partition key in the constraint. Application logic might need awareness of partition boundaries. Evaluate whether your query patterns align with potential partition keys before implementing partitioning.

## Additional resources

- [Table partitioning in PostgreSQL](/azure/postgresql/flexible-server/concepts-table-partitioning)
- [JSONB indexing strategies](https://www.postgresql.org/docs/current/datatype-json.html#JSON-INDEXING)
- [Index types in PostgreSQL](/azure/postgresql/flexible-server/how-to-optimize-performance-indexes)
