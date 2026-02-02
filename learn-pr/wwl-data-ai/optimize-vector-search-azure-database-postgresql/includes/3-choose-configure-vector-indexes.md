Vector indexes enable fast similarity search by organizing vectors into data structures that eliminate the need to compare every stored vector against each query. Choosing the right index type and configuring its parameters correctly determines whether your AI application meets its performance targets.

> [!NOTE]
> Code examples in this unit show index creation patterns for pgvector. Index parameter recommendations are starting points based on general guidance. Optimal values depend on your dataset characteristics, accuracy requirements, and performance constraints. Always benchmark with representative data before deploying to production.

## Vector index fundamentals

Without an index, vector similarity search requires a sequential scan that compares the query vector against every vector in the table. For a table with one million product embeddings, this means one million distance calculations per query, which takes seconds rather than milliseconds.

Sequential scans perform exact nearest neighbor (NN) search, guaranteeing that the returned results are the true closest vectors. This guarantee comes at the cost of query time that grows linearly with table size. Approximate nearest neighbor (ANN) indexes trade perfect accuracy for dramatically faster queries. Instead of examining every vector, ANN algorithms use clever data structures to find vectors that are likely (but not guaranteed) to be among the closest. Query time grows logarithmically or sublinearly with table size.

The accuracy of ANN search is measured as recall, the fraction of true nearest neighbors that appear in the returned results. For example, if you request 10 results and the index returns 8 of the actual 10 closest vectors (plus 2 that are close but not in the true top 10), recall is 80%. For most AI applications, 95-99% recall is acceptable because the difference between the eighth and tenth closest vectors is rarely meaningful to end users. The 100x-1000x speed improvement from ANN indexes makes this trade-off worthwhile.

The benefit of vector indexes depends on table size and query patterns:

| Table size | Index benefit |
|------------|---------------|
| Under 10,000 rows | Limited; sequential scans might be fast enough |
| 10,000 - 100,000 rows | Moderate; indexes reduce latency meaningfully |
| 100,000 - 1 million rows | Significant; indexes are typically required for interactive use |
| Over 1 million rows | Essential; queries are unusably slow without indexes |

For the product recommendation scenario with two million products, indexes are essential for meeting the 100-millisecond latency target.

## IVFFlat indexes

IVFFlat (Inverted File Flat) indexes partition vectors into clusters, then search only relevant clusters at query time. This approach reduces the search space while maintaining reasonable accuracy.

IVFFlat uses k-means clustering to organize vectors into lists (also called partitions or cells). During index creation, pgvector clusters your vectors into a specified number of lists, with each list containing vectors that are similar to each other. When you query, pgvector identifies the lists whose centroids are closest to the query vector, then performs exact distance calculations only on vectors within those lists. If your query probes 10 lists out of 1000 total, you reduce the search space by 99%.

Create an IVFFlat index by specifying the number of lists and the operator class that matches your distance function. The operator class must match the distance operator you use in queries. Use `vector_cosine_ops` for cosine distance (`<=>`), `vector_l2_ops` for Euclidean distance (`<->`), and `vector_ip_ops` for negative inner product (`<#>`). Using a mismatched operator prevents index usage. For example, creating an index with `vector_cosine_ops` but querying with `<->` (L2 distance) forces a sequential scan.

```sql
-- Create IVFFlat index for cosine distance
CREATE INDEX ON products
USING ivfflat (embedding vector_cosine_ops)
WITH (lists = 1000);
```

The `lists` parameter determines how finely the vector space is partitioned. More lists create smaller partitions, which means fewer vectors to search per query but also more risk of missing relevant vectors in adjacent partitions. For datasets up to 100,000 rows, 100 lists is sufficient. For 100,000 to one million rows, use 1,000 lists. For one to ten million rows, use 4,000-10,000 lists. For over ten million rows, use sqrt(rows). For two million products, start with lists between 1,500 and 2,000.

The `ivfflat.probes` parameter controls how many lists are searched per query. Higher values improve recall but increase query time. Start with probes equal to sqrt(lists) and adjust based on measured recall. For 1,000 lists, begin with 30-50 probes. If recall is too low (missing relevant results), increase probes. If queries are too slow, decrease probes. Configure probes with `SET ivfflat.probes = 20;` before executing your vector search.

IVFFlat indexes offer fast build times (k-means clustering is efficient), lower memory usage (the index stores centroids and pointers, not duplicated vector data), and runtime tunability (adjust `probes` without rebuilding the index). However, they require training data (indexes built on small samples perform poorly), have a lower recall ceiling (even with high probes, recall might not reach 99%+ for some data distributions), and need rebuilding when data distribution changes significantly.

## HNSW indexes

HNSW (Hierarchical Navigable Small World) indexes organize vectors into a multi-layer graph structure that enables efficient navigation from any starting point to the nearest neighbors. HNSW builds a graph where each vector is a node connected to its nearest neighbors. The graph has multiple layers, with higher layers containing fewer nodes that serve as "express lanes" for navigation. When you query, HNSW starts at a fixed entry point in the top layer, greedily moves toward the query vector using the sparse upper layers, then refines the search in the dense bottom layer. This hierarchical navigation typically finds excellent results while visiting a small fraction of nodes.

Create an HNSW index by specifying the connections per node (`m`) and construction search width (`ef_construction`). The same operator class rules apply: use `vector_cosine_ops` for cosine distance (`<=>`), `vector_l2_ops` for L2 distance (`<->`), and `vector_ip_ops` for inner product (`<#>`).

```sql
-- Create HNSW index for cosine distance
CREATE INDEX ON products
USING hnsw (embedding vector_cosine_ops)
WITH (m = 16, ef_construction = 64);
```

The `m` parameter controls how many connections each node maintains to other nodes. Higher values create a denser graph with better recall but higher memory usage and longer build times. Start with `m = 16` for most workloads. Increase to 32 if you need higher recall and can accept the memory and build time costs. The `ef_construction` parameter controls the search width during index building. Higher values create a better-quality graph but increase build time. Set `ef_construction` to at least `2 * m`. For high-quality indexes, use `4 * m` or higher. This parameter doesn't affect index size or query time, only build time and resulting graph quality.

The `hnsw.ef_search` parameter controls the search width at query time, similar to how `probes` works for IVFFlat. The default value of 40 works well for many applications. For high-accuracy requirements, increase to 100-200. The value should be at least as large as the number of results you request (the `LIMIT` clause). Configure ef_search with `SET hnsw.ef_search = 100;` before executing your vector search.

HNSW indexes offer higher recall (typically achieves 99%+ with appropriate parameters), no training dependency (index quality doesn't depend on data distribution), and consistent performance (query time is predictable regardless of where results fall in the vector space). However, they require higher memory usage (the graph structure requires significant storage, approximately 1.5x the vector data size for m=16), longer build times (building the graph is computationally expensive), and fixed parameters (changing `m` or `ef_construction` requires rebuilding the index)

## Choose an index type

The choice between IVFFlat and HNSW depends on your requirements and constraints.

> [!NOTE]
> Azure Database for PostgreSQL also supports [DiskANN indexes](/azure/postgresql/flexible-server/how-to-use-pgdiskann), which offer high recall, fast build times, and excellent performance for large datasets (100 million+ vectors). DiskANN is an Azure-specific feature worth considering for enterprise-scale workloads.

Choosing between IVFFlat and HNSW indexes includes several factors based on your specific constraints and requirements. Memory availability, acceptable build times, recall requirements, and how frequently your data changes all affect which index type works best. Choose IVFFlat when memory budget is limited, build time tolerance is low, 90-95% recall is acceptable, or data update frequency involves frequent bulk updates. Choose HNSW when memory is ample, you can tolerate longer build times, 99%+ recall is needed, or the workload is mostly reads with small updates.

For a high-traffic recommendation engine (the module scenario), HNSW is typically the better choice because the higher recall ensures users see the most relevant products, and the consistent sub-10ms query latency supports high concurrency. For large catalogs with frequent updates, IVFFlat might be more practical if you frequently add or update large batches of products. For memory-constrained environments, IVFFlat's lower memory footprint makes it viable when HNSW would exceed available memory. For development and testing, IVFFlat's faster build times make iteration quicker.

Sequential scans without indexes might be acceptable when tables have fewer than 10,000 rows, queries already filter to small subsets before vector search, you need guaranteed exact results (100% recall), or data changes so frequently that index maintenance overhead exceeds query savings.

## Create and maintain indexes

Proper index creation and maintenance ensures consistent performance as your data evolves.

Index creation locks the table for writes by default. For production systems, use `CONCURRENTLY` to allow writes during index building. Concurrent index creation takes longer and requires more resources, but prevents application downtime. Monitor the build progress with `SELECT phase, blocks_total, blocks_done, tuples_total, tuples_done FROM pg_stat_progress_create_index;`.

```sql
-- Build index without blocking writes
CREATE INDEX CONCURRENTLY idx_products_embedding
ON products USING hnsw (embedding vector_cosine_ops)
WITH (m = 16, ef_construction = 64);
```

Build times vary with hardware, but these rough estimates help with planning: IVFFlat (lists=1000) takes 5-15 minutes for one million vectors and 30-60 minutes for ten million vectors. HNSW (m=16, ef=64) takes 15-45 minutes for one million vectors and 2-6 hours for ten million vectors. HNSW build times increase more than linearly with data size. Plan accordingly for large datasets.

Index quality degrades when data distribution changes significantly. Signs that reindexing might help include query latency that has increased without data growth explaining it, recall measurements showing degradation, or large portions of data that have been replaced or updated. Reindex using `REINDEX INDEX CONCURRENTLY idx_products_embedding;`. For IVFFlat indexes, reindexing updates the cluster centroids to match current data distribution. For HNSW indexes, it rebuilds the graph structure.

Check index size and usage statistics to monitor index health. Query `pg_stat_user_indexes` to see index sizes with `SELECT indexrelname, pg_size_pretty(pg_relation_size(indexrelid)) AS size FROM pg_stat_user_indexes WHERE relname = 'products';`. Check if indexes are being used with `SELECT indexrelname, idx_scan, idx_tup_read FROM pg_stat_user_indexes WHERE relname = 'products';`. Low `idx_scan` counts suggest the index isn't being used. Verify that query operators match the index operator class.

## Additional resources

- [pgvector indexing documentation](https://github.com/pgvector/pgvector#indexing)
- [Indexing best practices for Azure Database for PostgreSQL](/azure/postgresql/flexible-server/how-to-optimize-performance-indexes)
- [HNSW algorithm paper](https://arxiv.org/abs/1603.09320)
