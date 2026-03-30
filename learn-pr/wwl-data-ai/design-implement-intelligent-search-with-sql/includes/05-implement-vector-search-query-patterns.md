With vectors stored and a search strategy chosen, you're ready to write queries. This unit covers the T-SQL functions that power vector search and shows you how to combine them effectively.

Vector search queries follow a common pattern: generate or retrieve a query vector, calculate distances to stored vectors, and return the closest matches. SQL Server provides four functions that work together to support this pattern: `VECTOR_DISTANCE`, `VECTOR_SEARCH`, `VECTOR_NORMALIZE`, and `VECTORPROPERTY`.

## Calculate distances with VECTOR_DISTANCE

The `VECTOR_DISTANCE` function calculates the distance between two vectors using the metric you specify. This function performs exact nearest neighbor search, computing the distance to every qualifying row. In practical terms, it compares your search embedding against every stored embedding to find which ones are most similar, like checking every product in a catalog to find the best matches.

```sql
VECTOR_DISTANCE(metric, vector1, vector2)
```

The metric must be `'cosine'`, `'euclidean'`, or `'dot'`. Both vectors must have the same number of dimensions.

Here's a typical pattern for finding similar products based on a description embedding:

```sql
-- Generate an embedding for the user's search phrase
DECLARE @searchVector VECTOR(1536);
SELECT @searchVector = AI_GENERATE_EMBEDDINGS('lightweight hiking boots' USE MODEL MyEmbeddingModel);

SELECT TOP 10 
    ProductID,
    Name,
    VECTOR_DISTANCE('cosine', @searchVector, DescriptionVector) AS Distance
FROM dbo.Products
ORDER BY Distance;
```

This query works in two steps. First, it converts the search phrase "lightweight hiking boots" into an embedding using the same model that created the stored `DescriptionVector` values. Second, it calculates the cosine distance between `@searchVector` and every row's `DescriptionVector`. The `ORDER BY Distance` clause sorts the results from smallest distance (most similar) to largest, and `TOP 10` returns only the first 10 rows. Since smaller distances mean more similar vectors, this combination gives you the 10 products most semantically related to "lightweight hiking boots."

You can also use `VECTOR_DISTANCE` in a WHERE clause to find all vectors within a specific distance threshold:

```sql
SELECT ProductID, Name
FROM dbo.Products
WHERE VECTOR_DISTANCE('cosine', @searchVector, DescriptionVector) < 0.3
ORDER BY VECTOR_DISTANCE('cosine', @searchVector, DescriptionVector);
```

This approach finds all products within a similarity threshold rather than returning a fixed count. The 0.3 value here's just an example. Cosine distance ranges from 0 (identical vectors) to 2 (completely opposite), but what counts as "similar enough" depends entirely on your data and embedding model. To find the right threshold, run test queries, examine the distance values in your results, and identify where relevant results stop and the noise begins. Use this pattern when you want everything meeting a quality bar rather than a fixed number of results.

## Use VECTOR_SEARCH for approximate retrieval

When your table grows beyond tens of thousands of rows, calculating distances to every row becomes slow. The `VECTOR_SEARCH` function uses a vector index to find approximate nearest neighbors quickly.

```sql
VECTOR_SEARCH(
    TABLE = object AS alias,
    COLUMN = vector_column,
    SIMILAR_TO = query_vector,
    METRIC = 'cosine' | 'euclidean' | 'dot',
    TOP_N = k
)
```

This function returns a result set containing all columns from the source table plus a `distance` column. Here's how you'd use it:

```sql
DECLARE @searchVector VECTOR(1536);
SELECT @searchVector = AI_GENERATE_EMBEDDINGS('lightweight hiking boots' USE MODEL MyEmbeddingModel);

SELECT t.ProductID, t.Name, s.distance
FROM VECTOR_SEARCH(
    TABLE = dbo.Products AS t,
    COLUMN = DescriptionVector,
    SIMILAR_TO = @searchVector,
    METRIC = 'cosine',
    TOP_N = 10
) AS s
ORDER BY s.distance;
```

The function returns the approximate 10 nearest neighbors. If a matching vector index exists on `DescriptionVector` with the same metric, `VECTOR_SEARCH` uses it for fast retrieval. Without an index, it falls back to exact search and raises a warning.

### Handle post-filtering carefully

`VECTOR_SEARCH` applies any WHERE clause conditions *after* finding the nearest neighbors, not before. Consider this query:

```sql
SELECT t.ProductID, t.Name, s.distance
FROM VECTOR_SEARCH(
    TABLE = dbo.Products AS t,
    COLUMN = DescriptionVector,
    SIMILAR_TO = @searchVector,
    METRIC = 'cosine',
    TOP_N = 10
) AS s
WHERE t.CategoryID = 5
ORDER BY s.distance;
```

This query first finds the 10 nearest vectors across all categories, then filters to only category 5. If none of the 10 nearest products are in category 5, you get no results. To work around this issue, request more candidates than you need:

```sql
SELECT TOP 10 t.ProductID, t.Name, s.distance
FROM VECTOR_SEARCH(
    TABLE = dbo.Products AS t,
    COLUMN = DescriptionVector,
    SIMILAR_TO = @searchVector,
    METRIC = 'cosine',
    TOP_N = 50
) AS s
WHERE t.CategoryID = 5
ORDER BY s.distance;
```

By requesting 50 candidates from `VECTOR_SEARCH` and then taking the top 10 after filtering, you're more likely to have enough results in the target category.

## Normalize vectors for consistent comparisons

Different embedding models produce vectors with different lengths (magnitudes). When comparing vectors from multiple sources or when your model doesn't normalize outputs, you can use `VECTOR_NORMALIZE` to scale vectors to unit length.

```sql
VECTOR_NORMALIZE(vector, norm_type)
```

The `norm_type` can be:
- `'norm2'`: Euclidean norm (most common)
- `'norm1'`: Sum of absolute values
- `'norminf'`: Maximum absolute value

```sql
DECLARE @v VECTOR(3) = '[3, 4, 0]';
SELECT VECTOR_NORMALIZE(@v, 'norm2') AS NormalizedVector;
-- Returns: [0.6, 0.8, 0.0]
```

Normalizing ensures that cosine distance and dot product behave consistently. Most modern embedding models (like those from OpenAI) produce normalized vectors, so you often don't need this step. But if you're working with embeddings from models that don't normalize, applying `VECTOR_NORMALIZE` before storing or comparing ensures consistent similarity scores.

You can calculate a vector's magnitude using the related `VECTOR_NORM` function:

```sql
DECLARE @v VECTOR(3) = '[3, 4, 0]';
SELECT VECTOR_NORM(@v, 'norm2') AS Magnitude;
-- Returns: 5.0
```

## Inspect vectors with VECTORPROPERTY

The `VECTORPROPERTY` function returns metadata about a vector. This metadata is useful for validating data or debugging dimension mismatches.

```sql
VECTORPROPERTY(vector, property)
```

Two properties are supported:
- `'Dimensions'`: Returns the number of dimensions as an integer
- `'BaseType'`: Returns the data type name (currently always `float`)

```sql
DECLARE @v VECTOR(1536) = '[0.1, 0.2, ...]';
SELECT VECTORPROPERTY(@v, 'Dimensions') AS Dims;
-- Returns: 1536
```

This function helps when troubleshooting queries where vectors might have mismatched dimensions—a common issue when different embedding models are used.

## Choose the right function for your scenario

Each function serves a distinct purpose in vector search:

| Scenario | Function | When to use |
|----------|----------|-------------|
| Small dataset or filtered queries | `VECTOR_DISTANCE` | Under 50,000 vectors, or when a WHERE clause significantly reduces candidates |
| Large dataset with vector index | `VECTOR_SEARCH` | Hundreds of thousands of vectors or more, when speed matters |
| Comparing vectors from different models | `VECTOR_NORMALIZE` | When embedding sources vary or model doesn't produce normalized vectors |
| Validating vector data | `VECTORPROPERTY` | Checking dimensions during troubleshooting or data validation |

## Key takeaways

Vector search queries in SQL follow a predictable pattern: prepare a query vector, find neighbors using either `VECTOR_DISTANCE` (exact) or `VECTOR_SEARCH` (approximate), and order by distance. `VECTOR_NORMALIZE` and `VECTORPROPERTY` support data quality and consistency. Remember that `VECTOR_SEARCH` applies filters after finding nearest neighbors, so request more candidates than you need when combining with WHERE clauses. In the next unit, you'll learn how to combine vector search with full-text search in hybrid queries.
