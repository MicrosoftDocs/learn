Semantic retrieval finds documents based on meaning rather than exact keyword matches. This capability powers applications like knowledge base search, document discovery, and recommendation systems. Effective semantic retrieval combines vector similarity with metadata filtering, distance thresholds, and query patterns that return contextually relevant results.

This unit covers practical query patterns for semantic retrieval scenarios. You learn to filter results by metadata, set quality thresholds, handle complex queries, and combine vector search with full-text search for hybrid retrieval.

## Combine vector search with metadata filters

Real-world queries rarely search the entire document corpus. Users typically want results filtered by category, date range, author, or other attributes. The challenge is combining vector similarity with these filters while maintaining acceptable query performance.

Adding `WHERE` clauses to filter documents before similarity calculation works intuitively: PostgreSQL first identifies rows matching your filters, then calculates distances only for those rows. For highly selective filters (matching a small percentage of rows), this dramatically reduces the search space. A query filtering to "contracts" in the "corporate" practice area might eliminate 95% of documents before any vector math happens.

```sql
SELECT id, title, embedding <=> $1 AS distance
FROM documents
WHERE category = 'contracts'
  AND practice_area = 'corporate'
  AND created_at > '2024-01-01'
ORDER BY embedding <=> $1
LIMIT 10;
```

To maintain performance with filtered queries, create B-tree indexes on columns you frequently filter. For queries that always combine specific columns, composite indexes can be more efficient than multiple single-column indexes. PostgreSQL's query planner decides whether to use the vector index, metadata indexes, or both based on filter selectivity and table statistics. Run `ANALYZE` after loading data to ensure accurate statistics that help the planner make good decisions.

Filter selectivity affects which execution strategy PostgreSQL chooses. When filters match a large portion of the table (low selectivity), the vector index dominates query performance. When filters are highly selective, PostgreSQL might scan matching rows without using the vector index at all. Neither approach is wrong—the planner optimizes for total query cost. Monitor query plans with `EXPLAIN ANALYZE` to understand how PostgreSQL handles your specific filter combinations.

## Implement distance thresholds

Using only `LIMIT` returns the top N most similar documents regardless of their actual similarity. For some applications, returning irrelevant results is worse than returning no results. A legal research assistant that surfaces unrelated contracts when no relevant ones exist erodes user trust. Distance thresholds ensure a minimum quality level by filtering out results that fall below a similarity standard.

Adding a `WHERE` clause that filters by distance creates this quality floor. The query returns at most N documents, but only if they meet the threshold. If no documents are similar enough, the query returns empty results—which might be the right answer.

```sql
SELECT id, title, embedding <=> $1 AS distance
FROM documents
WHERE embedding <=> $1 < 0.4
ORDER BY embedding <=> $1
LIMIT 10;
```

Choosing the right threshold requires understanding your data. Start by analyzing distance distributions: calculate distances between queries and documents you know are relevant (these should cluster at low distances) and between queries and clearly unrelated documents (these should have higher distances). The threshold should fall in the gap between these distributions. For cosine distance with OpenAI embeddings, thresholds typically fall between 0.3 (strict, high precision) and 0.6 (lenient, high recall).

Most production queries combine both mechanisms: a distance threshold for quality and a limit for resource control. This returns up to five legal documents that are sufficiently similar, ordered by similarity, while avoiding the embarrassment of surfacing unrelated results when the knowledge base lacks relevant content.

## Retrieve documents with content for context

Semantic retrieval often serves as input to downstream processing, such as displaying results to users or providing context to an LLM. Your queries should return all the information needed for these purposes in a single round trip.

Retrieve the columns your application needs—title, content, metadata, distance score—in one query rather than fetching IDs first and making follow-up queries for details. For large content fields, consider whether you need the full text or just a summary; limiting data transfer improves response time. When document metadata spans multiple tables, use joins to retrieve complete information, ensuring joined tables have appropriate indexes on the join columns.

```sql
SELECT
    d.id,
    d.title,
    d.content,
    d.embedding <=> $1 AS distance,
    a.name AS author_name
FROM documents d
JOIN authors a ON d.author_id = a.id
WHERE d.embedding <=> $1 < 0.5
ORDER BY d.embedding <=> $1
LIMIT 5;
```

## Handle multi-vector queries

Some scenarios require finding documents similar to multiple examples rather than a single query vector. A user might provide several relevant documents as examples, or a complex query might have multiple distinct aspects that each need representation.

When example documents are semantically related—all describing the same concept from different angles—averaging their vectors produces a combined embedding that represents the "center" of those examples in embedding space. This works well for queries like "find more documents like these three merger agreements."

When examples represent different aspects of a query that shouldn't be averaged together, query each aspect separately and combine the results. A search for "documents about mergers AND environmental compliance" benefits from separate queries because averaging the merger embedding with the environmental embedding produces a point that might not be near either concept. Instead, retrieve candidates for each aspect and rank by combined relevance.

```sql
WITH
merger_results AS (
    SELECT id, embedding <=> $1 AS distance FROM documents ORDER BY embedding <=> $1 LIMIT 20
),
environmental_results AS (
    SELECT id, embedding <=> $2 AS distance FROM documents ORDER BY embedding <=> $2 LIMIT 20
)
SELECT d.id, d.title,
       (COALESCE(mr.distance, 1) + COALESCE(er.distance, 1)) / 2 AS combined_score
FROM documents d
LEFT JOIN merger_results mr ON d.id = mr.id
LEFT JOIN environmental_results er ON d.id = er.id
WHERE mr.id IS NOT NULL OR er.id IS NOT NULL
ORDER BY combined_score
LIMIT 10;
```

This finds documents similar to either aspect and ranks them by combined proximity to both queries.

## Implement hybrid search

Vector similarity excels at finding semantically related content but can miss documents with exact term matches that users expect. When an attorney searches for "Smith v. Jones," they expect that exact case name to appear in results even if the semantic meaning of their query points elsewhere. Hybrid search combines vector similarity with keyword-based full-text search to capture both semantic and lexical relevance.

PostgreSQL's built-in full-text search provides `ts_rank` for scoring keyword matches. Combine this with vector distance (converted to a similarity score) for a hybrid ranking. The weights determine how much each signal contributes: higher semantic weight works better for queries where meaning matters more than exact terms, while higher keyword weight serves queries with specific technical terms, names, or codes that must match exactly.

```sql
SELECT
    id,
    title,
    (1 - (embedding <=> $1)) * 0.7 +
        ts_rank(to_tsvector('english', content), plainto_tsquery('english', $2)) * 0.3 AS hybrid_score
FROM documents
WHERE to_tsvector('english', content) @@ plainto_tsquery('english', $2)
   OR embedding <=> $1 < 0.5
ORDER BY hybrid_score DESC
LIMIT 10;
```

To speed up keyword matching, create a GIN index on the full-text search vector. For frequently searched columns, storing the tsvector in a generated column avoids recomputing it for every query.

Hybrid search adds complexity and computation. Use it when users search for specific terms that must match exactly, when your corpus includes technical jargon where synonyms don't capture the right meaning, or when you want to boost results that match both semantically and lexically. For pure semantic search where meaning matters more than specific words, vector-only search is simpler and often sufficient.
