As your vector dataset grows, similarity queries that scan every row become too slow for production use. A table with one million vectors requires one million distance calculations for each query, resulting in latency measured in seconds rather than milliseconds. Vector indexes solve this problem by organizing embeddings into structures that enable fast approximate search.

This unit covers the indexing strategies available in pgvector: IVFFlat and HNSW. You learn how each algorithm works, when to use each type, and how to configure indexes for your performance requirements.

> [!NOTE]
> Azure Database for PostgreSQL also supports **DiskANN** (Disk Approximate Nearest Neighbor) indexes, which offer a balance of high accuracy and fast build times. For details on DiskANN configuration and usage, see [Optimize performance when using pgvector](/azure/postgresql/flexible-server/how-to-optimize-performance-pgvector).

## Understand exact versus approximate search

Without an index, pgvector performs **exact nearest-neighbor search**. The database calculates the distance between your query vector and every vector in the table, then returns the rows with the smallest distances. This approach guarantees to find the true nearest neighbors, but the computational cost grows linearly with the number of rows.

For small tables (under 10,000 rows), exact search often provides acceptable performance. However, as tables grow larger, query times increase proportionally. A table with 100,000 vectors might take 500 milliseconds per query, while a table with one million vectors could take several seconds.

**Approximate nearest-neighbor (ANN)** search trades perfect accuracy for dramatic speed improvements. ANN algorithms organize vectors into structures that enable the database to examine only a subset of vectors during queries. The results might occasionally miss some true nearest neighbors, but queries complete in milliseconds regardless of table size.

The key metric for ANN quality is **recall**: the percentage of true nearest neighbors that appear in the approximate results. For example, 95% recall means that on average, 95 out of 100 true nearest neighbors appear in the approximate results. Most AI applications achieve excellent results with 95-99% recall, making the speed trade-off worthwhile.

## IVFFlat indexes

The **Inverted File Flat (IVFFlat)** algorithm partitions vectors into clusters during index creation. When you query, the database identifies the clusters closest to your query vector and searches only within those clusters instead of the entire table.

Understanding IVFFlat's internal mechanics helps you choose appropriate parameters and troubleshoot performance issues. During index creation, IVFFlat performs k-means clustering on your vectors, grouping them into a specified number of lists (clusters). Each cluster has a centroid—the average position of all vectors in that cluster. When you run a query, pgvector calculates distances from your query vector to each centroid, identifies the closest clusters (determined by the `probes` setting), and searches only within those clusters. This reduces the number of distance calculations from the total row count to approximately `(rows / lists) * probes`.

Creating an IVFFlat index requires choosing parameters that balance query speed against search accuracy. The `lists` parameter controls the number of clusters: more lists mean each cluster contains fewer vectors, which speeds up queries but can reduce recall if clusters split semantically similar vectors. For tables up to one million rows, use `rows / 1000`; for larger tables, use `sqrt(rows)`.

```sql
CREATE INDEX documents_embedding_idx ON documents
USING ivfflat (embedding vector_cosine_ops)
WITH (lists = 100);
```

The operator class must match the distance operator you use in queries: `vector_l2_ops` for L2 distance (`<->`), `vector_cosine_ops` for cosine distance (`<=>`), or `vector_ip_ops` for inner product (`<#>`).

The `probes` parameter controls how many clusters to search at query time. Higher values improve recall but increase latency. Set this at the session level with `SET ivfflat.probes = 10`. Start with `probes = sqrt(lists)` and adjust based on your recall and latency requirements.

IVFFlat indexes require existing data to train the clustering algorithm. Creating an index on an empty table produces an index that isn't usable for queries—load your initial data before creating the index. When data distribution changes significantly after adding data from a new domain, the clusters might no longer optimally partition your vectors. Monitor recall and rebuild the index if quality degrades.

## HNSW indexes

**Hierarchical Navigable Small World (HNSW)** indexes use a multi-layer graph structure for similarity search. This approach typically provides better query performance than IVFFlat, though with higher memory usage and longer build times.

HNSW uses a fundamentally different approach than IVFFlat, building a navigable graph structure instead of partitioning vectors into clusters. The algorithm builds a graph where each vector is a node connected to its nearest neighbors, organized into multiple layers: the top layer contains the fewest nodes spaced far apart, each lower layer contains more nodes with denser connections, and the bottom layer contains all nodes. When you query, the algorithm starts at the top layer and navigates through the graph, moving to lower layers as it gets closer to the query vector. This coarse-to-fine approach quickly narrows down the search space. The design enables incremental index updates and typically achieves higher recall at the same query latency compared to IVFFlat.

```sql
CREATE INDEX documents_embedding_idx ON documents
USING hnsw (embedding vector_cosine_ops)
WITH (m = 16, ef_construction = 64);
```

Unlike IVFFlat, HNSW indexes can be created on empty tables—the graph structure updates incrementally as you insert new rows.

The `m` parameter sets the maximum number of connections per node in the graph. Higher values improve recall but increase memory usage and build time. The default of 16 works well for most use cases; consider increasing to 32 or 64 for datasets where high recall is critical. The `ef_construction` parameter controls the search width during index building: higher values create higher-quality indexes but slow down construction. For production indexes where query quality matters more than build time, consider values of 100-200.

The `ef_search` parameter controls the search width during queries—set this at the session level with `SET hnsw.ef_search = 100`. Start with the default of 40 and increase if you need higher recall. Values of 100-200 typically achieve 99%+ recall.

## Choose between IVFFlat and HNSW

Both index types enable fast approximate search, but they have different characteristics that make each better suited for specific scenarios.

| Factor | IVFFlat | HNSW |
|--------|---------|------|
| Query performance | Good | Better |
| Build time | Faster | Slower |
| Memory usage | Lower | Higher |
| Empty table support | No | Yes |
| Insert performance | Fast | Moderate |
| Recall at same latency | Lower | Higher |

**Choose HNSW when:**

- Query performance is your primary concern
- You need high recall (99%+) with low latency
- Your dataset doesn't change frequently
- Memory constraints aren't severe

**Choose IVFFlat when:**

- Memory usage is a concern
- You need faster index builds for frequently changing data
- You're willing to trade some query performance for lower resource usage
- You can tolerate slightly lower recall

For most production AI applications, HNSW provides the best user experience due to its superior query performance and recall characteristics. Start with HNSW unless you have specific constraints that favor IVFFlat.

## Match index operators to distance functions

The operator class you specify when creating an index must match the distance operator in your queries. If they don't match, PostgreSQL won't use the index, falling back to a slow sequential scan.

Each operator class corresponds to a specific distance operator:

| Operator class | Distance operator | Use case |
|----------------|-------------------|----------|
| `vector_l2_ops` | `<->` | L2 (Euclidean) distance |
| `vector_cosine_ops` | `<=>` | Cosine distance |
| `vector_ip_ops` | `<#>` | Negative inner product |

To verify that your queries use the index, run `EXPLAIN ANALYZE`:

```sql
EXPLAIN ANALYZE
SELECT id, title
FROM documents
ORDER BY embedding <=> '[0.0123, -0.0456, ...]'::vector
LIMIT 10;
```

The output should show an index scan using your vector index:

```
Limit  (cost=40.02..44.27 rows=10 width=44) (actual time=0.512..0.518 rows=10 loops=1)
  ->  Index Scan using documents_embedding_idx on documents  (cost=40.02..2138.02 rows=4932 width=44) (actual time=0.510..0.515 rows=10 loops=1)
        Order By: (embedding <=> '[...]'::vector)
```

If you see "Seq Scan" instead of "Index Scan," check that:

1. The operator class matches the distance operator
2. The index exists and is valid
3. The table has enough rows (PostgreSQL might choose a sequential scan for small tables)
4. The LIMIT clause is present (indexes are most effective with ORDER BY and LIMIT)
