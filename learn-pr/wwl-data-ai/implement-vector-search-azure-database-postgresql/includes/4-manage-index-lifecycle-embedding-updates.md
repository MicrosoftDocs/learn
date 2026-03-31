Vector indexes and embeddings require ongoing maintenance as your data evolves. New documents shift the distribution of vectors, content updates invalidate existing embeddings, and embedding model upgrades require regenerating all vectors. Understanding how to manage these changes keeps your vector search performing well over time.

This unit covers monitoring index health, rebuilding indexes when needed, updating embeddings efficiently, and handling embedding model migrations.

## Monitor index health and performance

Effective maintenance starts with understanding your current index state. PostgreSQL provides system views and functions that reveal whether indexes are being used, how much space they consume, and whether queries perform as expected.

The `pg_stat_user_indexes` view shows usage patterns for your indexes. If a vector index shows zero scans, queries might not be using it—often because the operator class doesn't match the distance operator in your queries, or because the query planner chose a sequential scan for a small table. High scan counts confirm the index is working as expected.

```sql
SELECT
    schemaname,
    relname AS table_name,
    indexrelname AS index_name,
    idx_scan AS times_used,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_stat_user_indexes
WHERE indexrelname LIKE '%embedding%'
ORDER BY idx_scan DESC;
```

Beyond usage statistics, query performance reveals index health over time. Run `EXPLAIN ANALYZE` periodically on representative queries and track the execution times. If queries that took 10 milliseconds now take 50 milliseconds without a corresponding increase in data volume, the index structure might have degraded. This commonly happens after adding significant new data, especially from a different domain or with different characteristics than the original dataset.

Large index builds can take minutes or hours. Monitor progress using `pg_stat_progress_create_index`, which shows the current phase and completion percentage. HNSW builds progress through `initializing` and `loading tuples` phases, while IVFFlat shows additional phases for k-means clustering. The percentage completion is most meaningful during the final `loading tuples` phase.

## Rebuild indexes when data distribution changes

ANN indexes optimize their internal structures based on the data distribution at creation time. When you add significant new data, especially data from a different domain or with different characteristics, the index might no longer partition vectors optimally. This degradation manifests as increased query latency, decreased result quality, or both.

Several signals indicate that an index needs rebuilding. Query latency increases without a corresponding increase in data volume suggest structural degradation. Users reporting less relevant search results points to recall problems. Adding more than 20-30% new data, especially from a new source or domain, often warrants proactive reindexing even before you notice problems.

For production systems that can't tolerate downtime, use `CREATE INDEX CONCURRENTLY` to build a replacement index without blocking queries. This approach takes longer and uses more resources than a regular build, but your application continues serving requests throughout the process. Create the new index with a temporary name, verify it works with `EXPLAIN ANALYZE`, drop the old index, then rename the new one to take its place.

```sql
-- Create new index concurrently (doesn't block queries)
CREATE INDEX CONCURRENTLY documents_embedding_new_idx
ON documents USING hnsw (embedding vector_cosine_ops)
WITH (m = 16, ef_construction = 64);

-- Verify the new index works, then swap
DROP INDEX documents_embedding_idx;
ALTER INDEX documents_embedding_new_idx RENAME TO documents_embedding_idx;
```

For systems that can tolerate brief interruptions, `REINDEX INDEX documents_embedding_idx` is simpler but blocks writes during the rebuild. Schedule this during low-traffic periods.

## Update embeddings efficiently

When source content changes, the associated embedding no longer accurately represents the content's meaning. Keeping embeddings synchronized with content is essential for search quality, but the approach you choose depends on your update frequency and latency requirements.

For occasional updates, updating the embedding in the same transaction as the content keeps everything consistent. Your application calls the embedding API, gets the new vector, and writes both the content and embedding together. This approach is simple and guarantees consistency, but it adds latency to every content update and tightly couples your content workflow to the embedding service's availability.

Applications with frequent content changes benefit from a batch approach that decouples content updates from embedding generation. Mark documents as needing embedding updates using a flag column or timestamp comparison, then process pending updates asynchronously in batches. This pattern reduces API costs through batching, improves content update latency, and makes your system more resilient to embedding service outages.

```sql
-- Add a column to track embedding status
ALTER TABLE documents ADD COLUMN embedding_stale BOOLEAN DEFAULT FALSE;

-- When content changes, mark for embedding update (fast)
UPDATE documents
SET content = 'New content...', embedding_stale = TRUE, updated_at = NOW()
WHERE id = 42;

-- Background job processes stale embeddings in batches
SELECT id, content FROM documents WHERE embedding_stale = TRUE LIMIT 100;

-- After generating embeddings externally, update in bulk
UPDATE documents
SET embedding = data.embedding, embedding_stale = FALSE
FROM (VALUES (1, '[...]'::vector), (2, '[...]'::vector)) AS data(id, embedding)
WHERE documents.id = data.id;
```

Some applications benefit from periodically regenerating all embeddings, not just those with content changes. This catches subtle updates that don't trigger the stale flag, ensures consistency across all embeddings, and helps when testing different embedding parameters. Implement this as a scheduled job that processes documents ordered by their last update time, refreshing older embeddings first.

## Handle embedding model changes

Upgrading to a new embedding model or switching providers requires regenerating all embeddings. Because different models produce vectors with different dimensions and semantic relationships, you can't mix embeddings from different models in the same column.

### Migration strategy

Migrating to a new embedding model requires careful planning because you can't simply overwrite existing embeddings—your application would return inconsistent results while the migration is in progress. The safest approach uses a parallel column strategy that lets you populate new embeddings alongside existing ones, validate search quality, and switch over atomically. This strategy adds temporary storage overhead but avoids downtime and lets you roll back if the new model underperforms.

1. **Add a new vector column** for the new embeddings:

    ```sql
    ALTER TABLE documents ADD COLUMN embedding_v2 vector(3072);
    ```

1. **Create an index on the new column**:

    ```sql
    CREATE INDEX documents_embedding_v2_idx
    ON documents USING hnsw (embedding_v2 vector_cosine_ops);
    ```

1. **Backfill embeddings in batches** to avoid overwhelming the embedding API:

    ```sql
    -- Process in batches, application code generates embeddings
    UPDATE documents
    SET embedding_v2 = '[...]'::vector
    WHERE id BETWEEN 1 AND 10000
      AND embedding_v2 IS NULL;
    ```

1. **Update application queries** to use the new column. You can run both columns in parallel during testing:

    ```sql
    -- Compare results from both models
    SELECT id, title,
           embedding <=> $1 AS v1_distance,
           embedding_v2 <=> $2 AS v2_distance
    FROM documents
    ORDER BY embedding_v2 <=> $2
    LIMIT 10;
    ```

1. **Drop the old column and index** after validating the new embeddings:

    ```sql
    DROP INDEX documents_embedding_idx;
    ALTER TABLE documents DROP COLUMN embedding;
    ALTER TABLE documents RENAME COLUMN embedding_v2 TO embedding;
    ALTER INDEX documents_embedding_v2_idx RENAME TO documents_embedding_idx;
    ```

### Estimate migration time

Plan your migration timeline based on:

- **Row count:** More rows means more embedding API calls
- **API rate limits:** Most embedding APIs have requests-per-minute limits
- **Batch size:** Larger batches are more efficient but might time out

For example, with 500,000 documents, an API rate limit of 3,000 requests per minute, and batches of 100 documents, the backfill would take approximately 28 hours of continuous processing.

## Manage storage and cleanup

Vector columns consume significant storage. A 1536-dimensional vector uses approximately 6 KB per row. A table with one million documents and embeddings requires about 6 GB just for the vector data, plus additional space for indexes.

### Estimate storage requirements

Vector data consumes significantly more storage than typical relational columns, so planning capacity before loading large datasets prevents surprises. Understanding the relationship between dimension count, row count, and index overhead helps you choose appropriate Azure Database for PostgreSQL compute tiers and storage configurations. You can query existing tables to understand current usage and extrapolate for growth.

```sql
SELECT
    pg_size_pretty(pg_relation_size('documents')) AS table_size,
    pg_size_pretty(pg_indexes_size('documents')) AS index_size,
    pg_size_pretty(pg_total_relation_size('documents')) AS total_size;
```

For planning purposes, estimate:

- Vector column storage: `dimensions * 4 bytes * row_count`
- HNSW index overhead: approximately 1.5-2x the vector column size
- IVFFlat index overhead: approximately 1-1.5x the vector column size

### Reclaim space after updates

PostgreSQL uses a multiversion concurrency control (MVCC) system that keeps old row versions until they're no longer needed by any transaction. When you update or delete rows, PostgreSQL doesn't immediately reclaim the disk space. For vector tables with frequent embedding updates, dead tuples accumulate faster than typical relational tables because each embedding change creates a new row version. This bloat can significantly impact query performance and storage costs if not managed proactively. Run `VACUUM` to reclaim space:

```sql
-- Standard vacuum (runs concurrently)
VACUUM documents;

-- Full vacuum (reclaims more space but locks the table)
VACUUM FULL documents;
```

For tables with heavy update activity, configure autovacuum to run more frequently:

```sql
ALTER TABLE documents SET (
    autovacuum_vacuum_scale_factor = 0.05,
    autovacuum_analyze_scale_factor = 0.02
);
```

These settings trigger autovacuum when 5% of rows are modified, rather than the default 20%.
