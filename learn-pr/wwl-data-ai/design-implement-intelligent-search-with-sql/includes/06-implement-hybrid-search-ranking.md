Full-text search and vector search each have strengths, but neither alone handles every query. Full-text search excels at finding exact keywords but misses documents that express the same idea differently. Vector search captures semantic meaning but might return conceptually related items that don't contain important terms the user specified. Hybrid search combines both approaches to maximize relevance.

In this unit, you learn how to implement hybrid search in SQL by running full-text and vector searches in parallel, then merging the results using Reciprocal Rank Fusion (RRF).

## Understand the hybrid search pattern

A hybrid search query runs two searches against the same data:

1. **Full-text search** uses `FREETEXTTABLE` or `CONTAINSTABLE` to find documents matching keywords, returning results ranked by BM25 relevance.
2. **Vector search** uses `VECTOR_DISTANCE` or `VECTOR_SEARCH` to find documents with similar embeddings, returning results ranked by distance.

Each search produces a ranked list. The challenge is combining these two lists into a single result set that benefits from both ranking signals.

Consider a user searching for "Azure SQL backup strategies." Full-text search finds documents containing those exact words. Vector search finds documents about "database recovery planning" or "disaster recovery for SQL databases" that are semantically related but use different terms. A hybrid approach returns both, giving users the best of both worlds.

## Merge results with Reciprocal Rank Fusion

Reciprocal Rank Fusion (RRF) is a technique for combining ranked lists from different sources. Instead of comparing raw scores, which might use different scales, RRF focuses on rank positions.

The formula for RRF is:

```
RRF_score = 1/(k + rank_from_source_1) + 1/(k + rank_from_source_2)
```

The constant `k` (typically 60) prevents high-ranked items from dominating. A document ranked #1 in both lists receives a higher combined score than one ranked #1 in only one list.

This approach has two key advantages:

- **Score normalization isn't needed.** Full-text BM25 scores and cosine distances use completely different scales. RRF sidesteps these differences by using ranks instead.
- **Neither source dominates.** If vector search consistently returns higher scores than full-text search, raw score fusion would favor vector results. RRF treats both sources equally.

## Implement hybrid search in SQL

Here's a complete hybrid search implementation using Common Table Expressions (CTEs) to structure the query:

```sql
DECLARE @searchText NVARCHAR(1000) = 'lightweight hiking boots';
DECLARE @searchVector VECTOR(1536);
DECLARE @topN INT = 50;
DECLARE @rrfK INT = 60;

-- Generate embedding for the search phrase
SELECT @searchVector = AI_GENERATE_EMBEDDINGS(@searchText USE MODEL MyEmbeddingModel);

-- Run hybrid search with RRF
WITH keyword_search AS (
    SELECT TOP(@topN)
        p.ProductID,
        RANK() OVER (ORDER BY ftt.[RANK] DESC) AS keyword_rank
    FROM dbo.Products p
    INNER JOIN FREETEXTTABLE(dbo.Products, Description, @searchText) AS ftt 
        ON p.ProductID = ftt.[KEY]
),
vector_search AS (
    SELECT TOP(@topN)
        ProductID,
        RANK() OVER (ORDER BY distance) AS vector_rank
    FROM (
        SELECT 
            ProductID,
            VECTOR_DISTANCE('cosine', @searchVector, DescriptionVector) AS distance
        FROM dbo.Products
    ) AS similar_products
),
combined AS (
    SELECT TOP(@topN)
        COALESCE(ks.ProductID, vs.ProductID) AS ProductID,
        ks.keyword_rank,
        vs.vector_rank,
        COALESCE(1.0 / (@rrfK + ks.keyword_rank), 0.0) +
        COALESCE(1.0 / (@rrfK + vs.vector_rank), 0.0) AS rrf_score
    FROM keyword_search ks
    FULL OUTER JOIN vector_search vs ON ks.ProductID = vs.ProductID
)
SELECT 
    p.ProductID,
    p.Name,
    p.Description,
    c.keyword_rank,
    c.vector_rank,
    c.rrf_score
FROM combined c
INNER JOIN dbo.Products p ON c.ProductID = p.ProductID
ORDER BY c.rrf_score DESC;
```

Let's break down what each CTE does:

1. **keyword_search**: Runs a full-text search using `FREETEXTTABLE`, which returns BM25-ranked results. The `RANK()` function assigns position numbers.

2. **vector_search**: Calculates cosine distance for all products and assigns rank positions based on distance (smallest first).

3. **combined**: Joins the two result sets using `FULL OUTER JOIN` so products appearing in either list are included. The RRF formula calculates the combined score. `COALESCE` handles products that appear in only one list by treating the missing rank as contributing zero.

4. **Final SELECT**: Joins back to the Products table to retrieve the full product details, ordered by the combined RRF score.

## Use VECTOR_SEARCH for large datasets

When your table has hundreds of thousands of rows, replace the exact `VECTOR_DISTANCE` calculation with `VECTOR_SEARCH` for better performance:

```sql
vector_search AS (
    SELECT TOP(@topN)
        t.ProductID,
        RANK() OVER (ORDER BY s.distance) AS vector_rank
    FROM VECTOR_SEARCH(
        TABLE = dbo.Products AS t,
        COLUMN = DescriptionVector,
        SIMILAR_TO = @searchVector,
        METRIC = 'cosine',
        TOP_N = @topN
    ) AS s
)
```

This version uses the DiskANN index for approximate nearest neighbor search, which is faster for large datasets while still providing high-quality results.

## Tune hybrid search parameters

Several factors affect hybrid search quality:

**Result set size (@topN)**: The number of candidates from each search. Larger values give RRF more candidates to work with but increase query time. Start with 50 and adjust based on your relevance testing.

**The RRF constant (@rrfK)**: The formula uses `1/(k + rank)`. A larger k (like 60) smooths out differences between ranks. A smaller k amplifies the advantage of top-ranked items. The value 60 is standard and comes from the original RRF research.

**Weighting**: You can weight one source more than the other by multiplying its contribution:

```sql
-- Weight vector search 2x more than keyword search
COALESCE(1.0 / (@rrfK + ks.keyword_rank), 0.0) +
COALESCE(2.0 / (@rrfK + vs.vector_rank), 0.0) AS rrf_score
```

**Filtering**: Apply filters before the hybrid search when possible. Filtering after RRF might eliminate highly ranked results.

## Evaluate search quality

Measuring search quality helps you tune parameters and choose between approaches. Common metrics include:

**Precision**: Of the results returned, what percentage are relevant? High precision means few irrelevant results.

**Recall**: Of all relevant documents in your database, what percentage did the search find? High recall means you're not missing good results.

**Mean Reciprocal Rank (MRR)**: How high does the first relevant result appear? MRR rewards searches that put the best result at the top.

To evaluate, you need a test set of queries with known relevant documents. Run each approach (full-text only, vector only, hybrid) and compare metrics. Hybrid search typically improves recall compared to either approach alone, often with minimal precision loss.

## Key takeaways

Hybrid search combines full-text and vector search to handle both keyword-focused and concept-focused queries. Reciprocal Rank Fusion merges the ranked results without requiring score normalization, treating both sources fairly. You can tune the result set size, RRF constant, and source weights to optimize for your data. Evaluating precision, recall, and MRR helps you measure whether hybrid search improves relevance for your specific use case.
