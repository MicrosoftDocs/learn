A shopper filtering the Contoso catalog by price band can match 40,000 products. The API returns 20 of them. Fetching all 40,000 to serve 20 wastes request units (RUs), memory, and time on every request, and the mobile client that made the call has no use for the rest. In this unit, you page through results and use continuation tokens to resume a query across separate requests.

## Results arrive in pages already

Every query in Azure Cosmos DB for NoSQL returns results in pages. `MaxItemCount` sets a ceiling on how many items a single page holds:

```sql
SELECT p.id, p.name, p.price
FROM product p
WHERE p.categoryId = @category AND p.price <= @max
```

That ceiling is a maximum, not a target. The service might return a smaller page if the response is too large or the operation takes too long. It might also return fewer results if the container is throttled or if a smaller page improves efficiency. A page can even come back empty while more results remain.

The consequence shapes all the code that follows: never treat a short page or an empty page as the end of the results. The iterator, not the item count, tells you when a query is done.

::: zone pivot="csharp"

```csharp
QueryDefinition query = new QueryDefinition(
        "SELECT p.id, p.name, p.price FROM product p WHERE p.categoryId = @category AND p.price <= @max")
    .WithParameter("@category", categoryId)
    .WithParameter("@max", maxPrice);

QueryRequestOptions options = new()
{
    PartitionKey = new PartitionKey(categoryId),
    MaxItemCount = 20
};

using FeedIterator<Product> iterator = container.GetItemQueryIterator<Product>(query, requestOptions: options);

while (iterator.HasMoreResults)
{
    FeedResponse<Product> page = await iterator.ReadNextAsync();

    foreach (Product product in page)
    {
        Console.WriteLine(product.name);
    }
}
```

`HasMoreResults` stays true until the service confirms there's nothing left, which is why the loop condition tests it rather than the count of items returned.

::: zone-end

::: zone pivot="python"

```python
query = "SELECT p.id, p.name, p.price FROM product p WHERE p.categoryId = @category AND p.price <= @max"

results = container.query_items(
    query=query,
    parameters=[
        {"name": "@category", "value": category_id},
        {"name": "@max", "value": max_price},
    ],
    partition_key=category_id,
    max_item_count=20,
)

for page in results.by_page():
    for product in page:
        print(product["name"])
```

`by_page` turns the paged iterable into an iterator of pages. Iterating it to exhaustion drains the query; stopping early leaves results unread on the service.

::: zone-end

Setting `MaxItemCount` caps the size of each response and lets your code stop after the first page when that page is all the caller needs. Page size and page count are factors in query RU consumption, so measure the total charge across all pages instead of assuming that reading the whole result set costs the same for every page size.

## Continuation tokens resume a query later

Draining an iterator works when one process reads the whole result set in one go. A web API can't work that way. Request one returns page one and the process moves on; request two arrives later, possibly on a different instance, and has to continue from where the first stopped.

A continuation token is the bookmark that makes it possible. The service returns one with each page, and it encodes everything needed to resume: the query's position across every physical partition it touches. Query execution is stateless on the service side, so nothing is held open between requests. Pass the token back and the query resumes.

:::image type="content" source="../media/continuation-token-paging.png" alt-text="Diagram showing a client, a catalog API, and Azure Cosmos DB exchanging pages and continuation tokens across three separate requests." lightbox="../media/continuation-token-paging.png":::

::: zone pivot="csharp"

```csharp
async Task<(List<Product> Items, string Token)> GetPageAsync(
    string categoryId, decimal maxPrice, string continuationToken)
{
    QueryDefinition query = new QueryDefinition(
            "SELECT p.id, p.name, p.price FROM product p WHERE p.categoryId = @category AND p.price <= @max")
        .WithParameter("@category", categoryId)
        .WithParameter("@max", maxPrice);

    QueryRequestOptions options = new()
    {
        PartitionKey = new PartitionKey(categoryId),
        MaxItemCount = 20
    };

    using FeedIterator<Product> iterator =
        container.GetItemQueryIterator<Product>(query, continuationToken, options);

    FeedResponse<Product> page = await iterator.ReadNextAsync();

    return (page.ToList(), page.ContinuationToken);
}
```

The first request passes `null` and starts at the beginning. Each response carries `ContinuationToken`, which the API hands back to the client. A `null` token means the results are exhausted.

::: zone-end

::: zone pivot="python"

```python
def get_page(category_id, max_price, continuation_token=None):
    results = container.query_items(
        query="SELECT p.id, p.name, p.price FROM product p WHERE p.categoryId = @category AND p.price <= @max",
        parameters=[
            {"name": "@category", "value": category_id},
            {"name": "@max", "value": max_price},
        ],
        partition_key=category_id,
        max_item_count=20,
    )

    pager = results.by_page(continuation_token)
    page = list(next(pager))

    return page, pager.continuation_token
```

The first call passes `None` and starts at the beginning. `pager.continuation_token` after reading a page carries the bookmark for the next one, and it's `None` once the results are exhausted.

::: zone-end

The token is an opaque string. Treat it as a value to round-trip, not to parse or construct. Because it encodes query state, it's only valid for the query that produced it: changing the filter values invalidates the position it describes.

## Know where tokens don't work

Continuation-token support depends on the query shape and SDK. In .NET, filters and projections support tokens, but `GROUP BY` and `DISTINCT` without `ORDER BY` don't. Cross-partition scalar aggregates combine partial results into one result rather than exposing a token for resuming the aggregation.

| Query feature | .NET continuation token support |
|:---|:---|
| Filters and projections | Supported |
| `ORDER BY` | Supported |
| `DISTINCT` | Supported only with `ORDER BY` |
| `GROUP BY` | Not supported |
| Cross-partition scalar aggregates such as `COUNT` and `SUM` | No resumable token for the client-side aggregation |

::: zone pivot="python"

The Python SDK adds a constraint worth planning around. Continuation tokens apply to streamable cross-partition queries, meaning filters and projections. Cross-partition queries that sort, count, or apply `DISTINCT` don't support them.

::: zone-end

Two more practical notes. A token stays valid indefinitely as long as your application uses the same SDK version, so a client can hold one across a session. And a token can grow large enough to break a request that round-trips it through a URL, a cookie, or a header; both software development kits (SDKs) let you cap its size, through `ResponseContinuationTokenLimitInKb` in .NET and `continuation_token_limit` in Python.

## Why not OFFSET and LIMIT

`OFFSET 200 LIMIT 20` looks like the simpler way to serve page 11, and for shallow paging it's fine. The problem is what it charges: the engine still evaluates and skips the 200 items ahead of the offset, so the RU cost of page 11 includes the cost of pages 1 through 10. Deep paging with offsets gets progressively more expensive.

A continuation token avoids repeating that skipped-item work. Each request resumes the query, but its RU charge still includes the index and document-processing work needed to produce the page. Use `OFFSET` and `LIMIT` for jumping to an arbitrary page in a short result set, and continuation tokens for sequential paging through a long one.

---

> **Try it yourself:** Build a loop that pages through a large category with `MaxItemCount` set to 20, printing the item count and RU charge for each page. Note any page that returns fewer than 20 items before the last one. Then serve the same result set with `OFFSET` and `LIMIT`, requesting page 1, page 10, and page 50, and compare the RU charge of each against the continuation-token equivalent.
