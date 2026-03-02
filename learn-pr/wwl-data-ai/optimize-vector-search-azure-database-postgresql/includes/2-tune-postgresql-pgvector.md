Vector search workloads place different demands on PostgreSQL compared to traditional transactional or analytical queries. Understanding these differences helps you tune configuration parameters to optimize query latency, memory usage, and compute efficiency for AI applications.

> [!NOTE]
> Code examples in this unit demonstrate configuration patterns for PostgreSQL and pgvector. Parameter values shown are starting points for tuning. Optimal settings depend on your specific workload, dataset size, and hardware. Always benchmark changes in a test environment before applying them to production.

## Pgvector compute and memory requirements

Vector similarity search involves computing distances between a query vector and potentially millions of stored vectors. This computational pattern differs fundamentally from traditional database operations that filter rows based on indexed columns or join tables on key values.

When you execute a vector similarity query, pgvector must calculate the distance between your query vector and candidate vectors. For a 1536-dimensional embedding (common with OpenAI models), each distance calculation involves 1,536 floating-point operations. Searching one million vectors without an index requires over 1.5 billion floating-point operations per query. The three distance functions have different computational costs that affect your choice based on your data characteristics and performance requirements.

- **L2 (Euclidean) distance:** Uses the `<->` operator and calculates the square root of the sum of squared differences. This is the most computationally expensive option.
- **Cosine distance:** Uses the `<=>` operator and measures the angle between vectors. It normalizes vectors internally, adding computation but providing scale-invariant similarity.
- **Inner product:** Uses the `<#>` operator and calculates the dot product. This is the fastest operation but requires pre-normalized vectors for meaningful similarity comparisons.

For recommendation engines and semantic search, cosine distance is often preferred because it handles vectors of varying magnitudes consistently. If your embeddings are already normalized (many embedding APIs return normalized vectors), inner product provides equivalent results with less computation.

Vector columns consume substantial storage compared to traditional data types. A single 1536-dimensional vector stored as `float4` (single precision) requires 6,144 bytes, plus overhead. A table with one million product embeddings needs approximately 6 GB just for the vector column. When PostgreSQL processes vector queries, it loads vector data into memory. The relationship between available memory and vector data size directly affects whether queries can execute efficiently in memory or must repeatedly read from disk.

Higher-dimensional embeddings provide more semantic resolution but increase both storage and computation costs quadratically. A 3072-dimensional vector (used by some newer embedding models) requires four times the distance calculation work and twice the storage of a 1536-dimensional vector. Consider your accuracy requirements when choosing embedding dimensions. For many recommendation and search applications, 768 or 1,024 dimensions provide sufficient quality with meaningfully lower resource consumption.

## Memory configuration for vector workloads

PostgreSQL's memory parameters significantly affect vector query performance. Proper tuning ensures vector indexes and frequently accessed data remain in memory, reducing expensive disk operations.

The `shared_buffers` parameter controls PostgreSQL's shared memory cache, where frequently accessed data pages reside. For vector workloads, this cache should be large enough to hold your vector indexes and hot data. A cache hit ratio below 99% for vector-heavy workloads indicates that `shared_buffers` might be too small. On Azure Database for PostgreSQL, this parameter is tuned automatically based on your compute tier, but you can adjust it within the allowed range for your tier. For dedicated vector search workloads, aim for `shared_buffers` large enough to hold your vector indexes plus a margin for other cached data. A starting point is 25% of available memory, with increases based on monitoring. The following queries help you check your current settings and cache performance.

```sql
-- Check current setting
SHOW shared_buffers;

-- View buffer cache hit ratio
SELECT
    sum(heap_blks_hit) / (sum(heap_blks_hit) + sum(heap_blks_read)) AS cache_hit_ratio
FROM pg_statio_user_tables;
```

The `work_mem` parameter controls memory available for individual query operations like sorts and hash joins. Vector similarity queries, especially those combining vector search with filtering and ordering, benefit from adequate `work_mem`. The default `work_mem` (typically 4 MB) is often too small for vector operations that must sort results by similarity. You can increase this value for sessions or queries that perform vector searches with large result sets using `SET work_mem = '256MB';`. Be cautious with global increases to `work_mem` because the setting applies per-operation per-connection, so a server handling 100 concurrent connections with complex queries could consume 100 × `work_mem` × operations-per-query in memory. For vector workloads, consider setting `work_mem` at the session level for specific queries rather than globally.

The `effective_cache_size` parameter tells the query planner how much memory is available for caching, including both PostgreSQL's `shared_buffers` and the operating system's file cache. This setting doesn't allocate memory but influences whether the planner chooses index scans over sequential scans. Set `effective_cache_size` to approximately 75% of total system memory on dedicated database servers. Higher values encourage the planner to use indexes, which is typically beneficial for vector search. On Azure Database for PostgreSQL, this is configured automatically based on your tier.

## Query planner settings for vector search

PostgreSQL's query planner makes decisions about how to execute queries based on cost estimates. Several parameters affect these estimates, and tuning them for modern SSD storage improves vector query planning.

The `random_page_cost` parameter estimates the cost of reading a random disk page relative to a sequential page. The default value of 4.0 reflects spinning disk characteristics where random access is significantly slower than sequential access. Azure Database for PostgreSQL uses SSD storage where random and sequential access have similar performance. Lowering `random_page_cost` to 1.1-1.5 encourages the planner to use index scans more readily, which benefits vector searches that access scattered data pages. You can adjust this setting with `SET random_page_cost = 1.1;`.

The `effective_io_concurrency` parameter tells PostgreSQL how many concurrent disk I/O operations the storage system can handle. Higher values enable bitmap heap scans to prefetch more pages in parallel. SSD storage handles concurrent I/O well, so set `effective_io_concurrency` to 200 for SSD-based Azure Database for PostgreSQL instances. This improves performance for queries that combine vector similarity with metadata filtering.

The `parallel_tuple_cost` and `parallel_setup_cost` parameters control when PostgreSQL uses parallel query execution. Vector operations can benefit from parallelism, especially for sequential scans on large tables. Lower values for `parallel_tuple_cost` (default 0.1) and `parallel_setup_cost` (default 1000) encourage parallel execution. For vector workloads with large tables, enabling parallelism can significantly reduce query time when indexes aren't being used. You can check your current parallel settings using `SHOW parallel_tuple_cost;`, `SHOW parallel_setup_cost;`, and `SHOW max_parallel_workers_per_gather;`.

## Configure pgvector-specific parameters

The pgvector extension provides configuration parameters that control the accuracy-speed trade-off for index-based searches. These parameters are critical for tuning vector query performance.

When using IVFFlat indexes, the `ivfflat.probes` parameter controls how many index partitions (lists) are searched for each query. Higher values increase recall (finding more of the true nearest neighbors) but slow queries. This trade-off is central to IVFFlat performance tuning. You're balancing the risk of missing good matches against the cost of searching more partitions. The default value of **1** searches only the single most promising partition, which is fast but might miss relevant results stored in adjacent partitions. For recommendation engines where missing a good match degrades user experience, start with `ivfflat.probes` set to 5-10% of your `lists` parameter and adjust based on measured recall.

```sql
-- Configure IVFFlat search depth
SET ivfflat.probes = 10;

-- Execute vector search
SELECT id, name, embedding <=> $1 AS distance
FROM products
ORDER BY embedding <=> $1
LIMIT 10;
```

For HNSW indexes, the `hnsw.ef_search` parameter controls the size of the dynamic candidate list during search. Larger values explore more of the graph, improving recall at the cost of speed. Unlike IVFFlat's discrete partitions, HNSW's graph structure means this parameter affects how thoroughly the algorithm explores neighbor connections before returning results. The default value of 40 provides a reasonable balance for many workloads. For high-accuracy requirements (such as finding the true top-10 matches), increase to 100-200. For latency-critical applications where approximate results are acceptable, values as low as 20 can work. Configure `hnsw.ef_search` with `SET hnsw.ef_search = 100;` before executing your vector search. The optimal value depends on your accuracy requirements and latency budget. Benchmark with representative queries to find the right balance for your application.

## Monitor and measure performance

Tuning without measurement is guesswork. Use PostgreSQL's built-in tools and Azure Monitor to understand query behavior and validate configuration changes.

The `EXPLAIN ANALYZE` command shows how PostgreSQL executes a query and provides actual timing information. For vector queries, this reveals whether indexes are being used and where time is spent. Understanding the execution plan helps you identify whether poor performance stems from missing indexes, suboptimal parameter settings, or data distribution issues. Run `EXPLAIN ANALYZE` before your vector query to see the execution plan. Look for **Index Scan using [index_name]** (indicates the vector index is being used), **Seq Scan** (indicates a sequential scan, which is slow for large tables), **actual time** values (show where execution time is spent), and **rows** counts (help identify if filtering is working efficiently). If you see sequential scans when you expect index usage, check that the query's distance operator matches the index's operator class (for example, using `<=>` with an index created using `vector_cosine_ops`).

Sometimes PostgreSQL chooses not to use an available index. Common reasons for vector queries include queries that return a large portion of the table (index overhead exceeds sequential scan), outdated statistics after significant data changes, or a distance operator that doesn't match the index's operator class. Run `ANALYZE products;` to update statistics for accurate planning. You can check index information with `SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'products';`.

Azure Database for PostgreSQL exposes metrics through Azure Monitor that help identify performance bottlenecks. Monitor **CPU percent** (high sustained CPU indicates compute-bound vector operations), **Memory percent** (approaching limits suggests increasing compute tier or optimizing queries), **Storage IO percent** (high values indicate data isn't fitting in cache), and **Active connections** (approaching limits indicates connection pooling might help). Set up alerts for these metrics to catch performance degradation before it affects users.

## Best practices for pgvector tuning

Effective tuning follows a systematic approach rather than random parameter changes.

- **Establish baselines first:** Measure query latency and resource usage before making changes. Without baselines, you can't determine if changes help or hurt.
- **Change one parameter at a time:** Multiple simultaneous changes make it impossible to attribute improvements or regressions to specific settings.
- **Test with production-like data:** Query performance varies dramatically with data size and distribution. Tuning on small test datasets often produces settings that fail at scale.
- **Monitor for regressions:** Parameters that improve vector search might negatively affect other workloads. Monitor overall system health after changes.
- **Document your settings:** Record what you changed, why, and what effect it had. This documentation is invaluable when troubleshooting future issues.

## Additional resources

- [Server parameters in Azure Database for PostgreSQL](/azure/postgresql/flexible-server/concepts-server-parameters)
- [pgvector on Azure Database for PostgreSQL](/azure/postgresql/flexible-server/how-to-use-pgvector)
- [Performance recommendations for Azure Database for PostgreSQL](/azure/postgresql/flexible-server/concepts-performance-recommendations)
