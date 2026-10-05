The strategy decision points at hybrid retrieval, and one system function implements it: reciprocal rank fusion (RRF). In this unit, you fuse a keyword ranking and a similarity ranking into a single ordered result with `RRF`, bias the fusion with weights, and learn the rules that decide where the function can and can't appear in a query.

## Fuse two rankings with RRF

`RRF` stands for Reciprocal Rank Fusion. It takes two or more scoring functions and returns one fused score.

```sql
RRF(<function1>, <function2>, ..., <weights>)
```

Each argument is a scoring function such as `VectorDistance` or `FullTextScore`. The optional final argument is an array of numbers that weights the functions, in the order the functions appear.

`RRF` is only valid inside an `ORDER BY RANK` clause, which is the clause that sorts a result set by the rank a scoring function produces rather than by a property value.

:::image type="content" source="../media/reciprocal-rank-fusion.png" alt-text="Diagram of two ranked result lists from BM25 and vector distance fusing into one ranking that a top N clause truncates." lightbox="../media/reciprocal-rank-fusion.png":::

### Understand why rank fusion beats score blending

The obvious way to combine two rankings is to add their scores, and it doesn't work, because the two scores aren't measured in the same units.

A cosine distance runs from -1 to +1. A dot product is unbounded. A BM25 score is unbounded as well, and its size depends on how rare the query's terms are in this particular container, so the same query produces different score magnitudes against different corpora. Adding two numbers on incompatible scales lets whichever one happens to be larger decide the order, and the winner changes with the corpus rather than with relevance.

Rank fusion sidesteps the problem. Each component function produces its own ordered list, and `RRF` combines the *positions* in those lists rather than the scores behind them. An item ranked second by BM25 and ninth by vector distance contributes the same evidence regardless of what either raw score was. No normalization step is needed. No component dominates because of its scale, and an item that both methods rank highly rises above an item that only one method likes.

## Write a hybrid query

A hybrid query names both scoring functions inside one `ORDER BY RANK RRF(...)` clause.

```sql
SELECT TOP 10 c.id, c.name, c.categoryName, c.price
FROM c
ORDER BY RANK RRF(
    VectorDistance(c.embedding, @queryVector),
    FullTextScore(c.searchText, @term1, @term2))
```

Four rules govern where the clause can go, and each one produces a query error rather than a wrong answer, so they surface quickly.

- `RRF` can appear only in an `ORDER BY RANK` clause.
- A query using `ORDER BY RANK` can't also order by a property path.
- `RRF` and `FullTextScore` can't appear in the `SELECT` projection. The fused score orders the results and isn't returned with them.
- The full-text half needs a full-text index on the path it reads, and the account needs enrollment in both the full-text search feature and the vector search capability.

To limit the returned results, include `TOP N` in every hybrid query. Larger result sets can increase request charge and latency. The Python SDK requires a `TOP` or `LIMIT` clause for hybrid queries, so omitting a limit can produce an error instead of returning the whole container.

::: zone pivot="python"

```python
response = openai_client.embeddings.create(
    input="something to see the road at night", model=DEPLOYMENT
)
query_vector = response.data[0].embedding

query = """
    SELECT TOP 10 c.id, c.name, c.categoryName, c.price
    FROM c
    ORDER BY RANK RRF(
        VectorDistance(c.embedding, @queryVector),
        FullTextScore(c.searchText, @term1, @term2))
"""

results = container.query_items(
    query=query,
    parameters=[
        {"name": "@queryVector", "value": query_vector},
        {"name": "@term1", "value": "road"},
        {"name": "@term2", "value": "light"},
    ],
    enable_cross_partition_query=True,
)

for item in results:
    print(f"{item['name']}\t{item['categoryName']}")
```

::: zone-end

::: zone pivot="csharp"

```csharp
OpenAIEmbedding embedding = await embeddingClient.GenerateEmbeddingAsync(
    "something to see the road at night");

float[] queryVector = embedding.ToFloats().ToArray();

QueryDefinition query = new QueryDefinition(@"
    SELECT TOP 10 c.id, c.name, c.categoryName, c.price
    FROM c
    ORDER BY RANK RRF(
        VectorDistance(c.embedding, @queryVector),
        FullTextScore(c.searchText, @term1, @term2))")
    .WithParameter("@queryVector", queryVector)
    .WithParameter("@term1", "road")
    .WithParameter("@term2", "light");

using FeedIterator<dynamic> feed = container.GetItemQueryIterator<dynamic>(query);

while (feed.HasMoreResults)
{
    FeedResponse<dynamic> page = await feed.ReadNextAsync();
    foreach (dynamic item in page)
    {
        Console.WriteLine($"{item.name}\t{item.categoryName}");
    }
}
```

::: zone-end

The keyword terms and the vector both reach the query as parameters. Parameterization keeps a large vector out of the query text and treats user-supplied terms as values instead of query syntax. `VectorDistance` also accepts a literal array, so parameterization is a recommendation rather than a syntax requirement.

## Bias the fusion toward one method

An unweighted fusion treats both rankings as equally credible. When you measure your corpus and find that one method is consistently better on your queries, an array of weights shifts the balance without changing anything else about the query.

```sql
SELECT TOP 10 c.id, c.name, c.categoryName
FROM c
ORDER BY RANK RRF(
    VectorDistance(c.embedding, @queryVector),
    FullTextScore(c.searchText, @term1, @term2),
    [2, 1])
```

The weights correspond to the functions positionally. In this query, the vector distance is listed first and carries weight `2`, so semantic evidence counts twice as much as keyword evidence.

> [!IMPORTANT]
> The weights array follows the order of the functions, not their names. Swapping the two functions in the argument list without moving the weights inverts the bias, and the query still runs and still returns plausible results. Change one and check the other.

Treat a weight as a measured setting rather than a preference. A catalog dense with model numbers usually favors the keyword half, and a knowledge base of written prose usually favors the semantic half, but the only way to know your own ratio is to run a fixed set of representative queries and compare the results, which is what the next unit covers.

## Fuse more than one of a kind

`RRF` combines scoring functions, and nothing in it requires one of each kind. Two full-text scores fuse as well as one of each.

```sql
SELECT TOP 10 c.name
FROM c
ORDER BY RANK RRF(
    FullTextScore(c.title, @term),
    FullTextScore(c.body, @term),
    [2, 1])
```

That query ranks a document by the same term in two places at once. The `[2, 1]` array gives the title ranking twice the weight of the body ranking. Without the array, the two rankings have equal weight. Two `VectorDistance` functions fuse the same way, over two vector paths on the same item, which is the shape a multimodal search takes when one embedding describes an item's text and another describes its image.

Both forms need the applicable policies and indexes on the paths they read. You choose which configured paths and scoring functions to combine in each query; the `RRF` argument list isn't fixed when the container is created.

In this unit, you learn how to implement hybrid search using the Reciprocal Rank Fusion (`RRF`) method in Azure Cosmos DB for NoSQL. You see how to parameterize queries, bias the fusion toward one method with weights, and combine multiple scoring functions of the same kind. To optimize retrieval performance, the next unit guides you through measuring and tuning these weights.
