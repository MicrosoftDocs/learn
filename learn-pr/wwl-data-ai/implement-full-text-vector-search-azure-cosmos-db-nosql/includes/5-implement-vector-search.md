The container is configured and loaded. Turning it into a search feature takes one system function and a few habits that keep the request charge proportionate. In this unit, you run a similarity query with `VectorDistance`, narrow it with metadata filters, and use the function's options to trade recall against cost deliberately rather than by accident.

## Query with `VectorDistance`

`VectorDistance` compares two vectors and returns a similarity score. In practice, the first argument is the property holding the stored embedding, and the second is the query vector you generated from the user's text.

```sql
VectorDistance(<vector_expr_1>, <vector_expr_2>, <bool_expr>, <obj_expr>)
```

The third argument forces brute-force comparison when it's `true`, and defaults to `false`, which uses the vector index. The fourth is an options object covered later in this unit.

A search query names the function twice: once in the projection so the caller sees the score, and once in `ORDER BY` so the most similar items come first.

```sql
SELECT TOP 10
    c.id,
    c.name,
    c.categoryName,
    VectorDistance(c.embedding, @queryVector) AS similarityScore
FROM c
ORDER BY VectorDistance(c.embedding, @queryVector)
```

> [!IMPORTANT]
> Always include `TOP N`. Without it, the query ranks and returns the entire container, and the request charge and latency follow. The number you choose is a product decision: a retrieval-augmented chat call needs a handful of grounding passages, while a search results page needs a page worth.

The query vector reaches the query as a parameter rather than as literal text. Embedding 1,536 numbers into a query string produces something no one can read in a log, and parameters let the engine reuse the query plan across calls.

### Generate the query vector with the same model

The single most common cause of results that look random is a query embedded by a different model from the documents. Two models produce two coordinate systems, and distances measured across them are meaningless. Use the same deployment for the query text that produced the stored embeddings, and treat that pairing as part of the container's configuration.

::: zone pivot="python"

```python
from azure.identity import DefaultAzureCredential, get_bearer_token_provider
from openai import AzureOpenAI

credential = DefaultAzureCredential()
token_provider = get_bearer_token_provider(
    credential, "https://cognitiveservices.azure.com/.default"
)

openai_client = AzureOpenAI(
    azure_endpoint=openai_endpoint,
    azure_ad_token_provider=token_provider,
    api_version="2024-10-21"
)

response = openai_client.embeddings.create(
    input="something to protect my head",
    model="text-embedding-3-small"
)
query_vector = response.data[0].embedding

query = """
    SELECT TOP 10 c.id, c.name, c.categoryName,
        VectorDistance(c.embedding, @queryVector) AS similarityScore
    FROM c
    ORDER BY VectorDistance(c.embedding, @queryVector)
"""

for item in container.query_items(
    query=query,
    parameters=[{"name": "@queryVector", "value": query_vector}],
    enable_cross_partition_query=True
):
    print(f"{item['name']}\t{item['similarityScore']:.4f}")
```

::: zone-end

::: zone pivot="csharp"

```csharp
AzureOpenAIClient openAiClient = new AzureOpenAIClient(
    new Uri(openAiEndpoint), new DefaultAzureCredential());

EmbeddingClient embeddingClient = openAiClient.GetEmbeddingClient("text-embedding-3-small");

OpenAIEmbedding embedding = await embeddingClient.GenerateEmbeddingAsync(
    "something to protect my head");

float[] queryVector = embedding.ToFloats().ToArray();

QueryDefinition query = new QueryDefinition(@"
    SELECT TOP 10 c.id, c.name, c.categoryName,
        VectorDistance(c.embedding, @queryVector) AS similarityScore
    FROM c
    ORDER BY VectorDistance(c.embedding, @queryVector)")
    .WithParameter("@queryVector", queryVector);

using FeedIterator<dynamic> feed = container.GetItemQueryIterator<dynamic>(query);

while (feed.HasMoreResults)
{
    FeedResponse<dynamic> page = await feed.ReadNextAsync();
    foreach (dynamic item in page)
    {
        Console.WriteLine($"{item.name}\t{item.similarityScore}");
    }
}
```

::: zone-end

### Read the score in the right direction

What counts as a good score depends entirely on the distance function in the container's vector policy. With `cosine`, values run from -1 to +1 and higher is more similar. With `dotproduct`, higher is more similar and the range is unbounded. With `euclidean`, 0 is identical and larger values mean less similar.

Resist the urge to hard-code a universal cutoff. A threshold that separates relevant from irrelevant is a property of your corpus and your model, not of the function, and the only way to find it is to run representative queries and look at where the results stop being useful. Score direction is consistent, but approximate indexes can return slightly different results or ordering between executions. Absolute score values require calibration against representative queries.

## Narrow the search with filters

Vector search combines with the rest of the query language, so a `WHERE` clause restricts which items are ranked at all.

```sql
SELECT TOP 10
    c.name,
    c.price,
    VectorDistance(c.embedding, @queryVector) AS similarityScore
FROM c
WHERE c.categoryId = @categoryId AND c.price < @maxPrice
ORDER BY VectorDistance(c.embedding, @queryVector)
```

Filters do two jobs. They enforce rules the ranking can't express, such as which items a user is allowed to see or which are still in stock, and they shrink the search scope so the comparison runs over fewer vectors.

The most valuable filter is the partition key, because it routes the query to a single physical partition instead of fanning out. When the application already knows the category, the tenant, or the customer, putting that value in the `WHERE` clause converts a container-wide search into a partition-scoped one.

Filter selectivity determines whether a filter is worth using. A predicate that eliminates most of the container offsets its evaluation cost; a predicate that matches nearly everything adds evaluation cost and removes nothing. Index the properties you filter on, or the filter itself becomes a scan.

## Control cost and recall

The fourth argument to `VectorDistance` is an options object, and it exists so you can adjust the accuracy trade at the level of a single query rather than by rebuilding the index.

| Option | Effect |
| :--- | :--- |
| `searchListSizeMultiplier` | Widens the DiskANN search list. Higher values raise recall, latency, and request charge |
| `quantizedVectorListMultiplier` | Widens the quantized candidate list, with the same trade |
| `filterPriority` | Weights the `WHERE` clause against the vector search inside DiskANN |
| `distanceFunction` | Overrides the policy's function for this query |
| `dataType` | Overrides the policy's data type for this query |

```sql
SELECT TOP 10 c.id, c.name
FROM c
WHERE c.categoryId = @categoryId
ORDER BY VectorDistance(c.embedding, @queryVector, false,
    {'dataType': 'Float32', 'searchListSizeMultiplier': 10, 'filterPriority': 0.5})
```

The third argument controls brute-force comparison. Setting it to `true` forces an exact comparison against the vectors in the query's routed and filtered search scope. Request charge and latency grow with the size of that candidate set. It earns its cost in evaluation runs, where you want a ground-truth ranking to measure the approximate index against, and it's the wrong default for anything a user waits on.

Three habits keep vector queries cheap without touching any of these settings: request the smallest `TOP N` the feature needs, project only the properties the caller uses instead of `SELECT *`, and include the partition key in the filter whenever the application knows it. Measure the effect the same way you measure any query, by reading the request charge from the response rather than estimating it.

Both retrieval methods now work against the container. The engine maintains the full-text index as items change, but application-managed embeddings need a refresh when their source text changes. The next unit covers that refresh.

In this unit, you learn how to implement vector search in Azure Cosmos DB, control its cost and recall, and understand the impact of partitioning on query performance. Next, you learn how to refresh application-managed embeddings when their source text changes.
