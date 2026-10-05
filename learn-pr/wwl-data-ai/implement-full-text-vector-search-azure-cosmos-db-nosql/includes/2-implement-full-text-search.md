The Contoso catalog already holds everything a keyword search needs. Each product carries a name such as `Sport-100 Helmet, Red` and a category such as `Accessories, Helmets`. What it lacks is a way to rank those strings by relevance instead of scanning them character by character. In this unit, you configure the two pieces of container configuration that full-text search depends on, then query the text with the four full-text system functions.

Full-text search in Azure Cosmos DB for NoSQL applies the processing you expect from a search engine: tokenization splits text into terms, stemming reduces those terms to a common root so *helmets* matches *helmet*, and stop words drop out. Relevance ranking uses `BM25`, which weighs how often a term appears in an item, how rare the term is across the container, and how long the text is.

> [!IMPORTANT]
> Full-text indexes depend on the **Full Text & Hybrid Search for NoSQL API** feature, which you enable on the account from the **Features** pane in the Azure portal. The full-text query functions also require this enrollment. Enable it before you create the container, because the index is part of the container definition.

## Configure a full-text policy

A full-text policy tells the engine which properties hold searchable text and what language to process them in. It belongs to the container, and you set it when you create the container.

The policy has two parts. `defaultLanguage` applies to any path that doesn't name its own, and `fullTextPaths` lists each searchable property with its `path` and `language`.

```json
{
    "defaultLanguage": "en-US",
    "fullTextPaths": [
        {
            "path": "/searchText",
            "language": "en-US"
        }
    ]
}
```

Add an element to `fullTextPaths` for every property you want searchable. Array paths use wildcard notation, so `/tags/[]` covers an array of strings and `/tags/[]/name` covers a property inside an array of objects.

The path you choose is a design decision worth making deliberately. Contoso stores a `searchText` property that concatenates the product name and its category, because the two together describe the product the way a shopper describes it. A generated sentence that repeats the product name remains searchable, and its distinct product-name terms still contribute to BM25 ranking. It doesn't add category terms that are absent from the name, so it limits what shoppers can find.

> [!NOTE]
> Full-text search generally supports `en-US`. Language-aware indexing for German, Spanish, French, Italian, and Portuguese is in early preview, requires separate enrollment in **New features for full-text search**, and might not be available in every region. Stop-word removal is currently available only for English. Don’t present non-English language support as generally available while the feature remains in preview.

## Add a full-text index

The policy declares intent. The index makes the queries efficient. Add a `fullTextIndexes` section to the container's indexing policy, listing the same paths the policy names.

```json
{
    "indexingMode": "consistent",
    "automatic": true,
    "includedPaths": [
        { "path": "/*" }
    ],
    "excludedPaths": [
        { "path": "/\"_etag\"/?" }
    ],
    "fullTextIndexes": [
        { "path": "/searchText" }
    ]
}
```

A full-text index path has to appear in the container's full-text policy. The reverse isn't strictly required. The `FullTextContains` family still runs against a policy path that has no index. Those queries cost more request units and take longer, because the engine evaluates the text instead of reading a prepared index. `FullTextScore` is the exception: it requires a full-text index and fails without one, so index every path you intend to rank on.

You set both policies together when you create the container.

::: zone pivot="python"

```python
from azure.cosmos import CosmosClient, PartitionKey

full_text_policy = {
    "defaultLanguage": "en-US",
    "fullTextPaths": [
        {"path": "/searchText", "language": "en-US"}
    ]
}

indexing_policy = {
    "indexingMode": "consistent",
    "automatic": True,
    "includedPaths": [{"path": "/*"}],
    "excludedPaths": [{"path": "/\"_etag\"/?"}],
    "fullTextIndexes": [{"path": "/searchText"}]
}

container = database.create_container(
    id="productSearch",
    partition_key=PartitionKey(path="/categoryId"),
    indexing_policy=indexing_policy,
    full_text_policy=full_text_policy
)
```

::: zone-end

::: zone pivot="csharp"

```csharp
ContainerProperties properties = new ContainerProperties(
    id: "productSearch",
    partitionKeyPath: "/categoryId")
{
    FullTextPolicy = new FullTextPolicy()
    {
        DefaultLanguage = "en-US",
        FullTextPaths = new Collection<FullTextPath>()
        {
            new FullTextPath() { Path = "/searchText", Language = "en-US" }
        }
    },
    IndexingPolicy = new IndexingPolicy()
    {
        FullTextIndexes = new()
        {
            new FullTextIndexPath() { Path = "/searchText" }
        }
    }
};

properties.IndexingPolicy.IncludedPaths.Add(new IncludedPath { Path = "/*" });

Container container = await database.CreateContainerAsync(properties);
```

::: zone-end

## Query text with the full-text functions

Four system functions read a full-text index. Three of them return a boolean and belong in a `WHERE` clause. The fourth returns a score and belongs in `ORDER BY RANK`.

### Filter with the contains functions

`FullTextContains` tests one string. `FullTextContainsAll` requires every term you list. `FullTextContainsAny` requires at least one.

```sql
SELECT TOP 10 c.name, c.categoryName
FROM c
WHERE FullTextContains(c.searchText, "helmet")
```

Against the CosmicWorks catalog, that query returns the three `Sport-100 Helmet` products. Swapping in `FullTextContainsAny(c.searchText, "mountain", "helmet")` makes mountain products and helmets eligible, but `TOP 10` still returns at most 10 items. `FullTextContainsAll(c.searchText, "mountain", "helmet")` returns nothing, because no product matches both terms.

You can also allow for typos. Pass an object instead of a string and set `distance` to the number of edits you tolerate, up to a maximum of two.

```sql
SELECT TOP 10 c.name
FROM c
WHERE FullTextContains(c.searchText, {"term": "helmit", "distance": 1})
```

### Rank with `FullTextScore`

`FullTextScore` produces the BM25 relevance value, and its placement is fixed: it goes in an `ORDER BY RANK` clause and nowhere else. Projecting it in a `SELECT` list or using it in a `WHERE` clause is invalid.

```sql
SELECT TOP 10 c.name, c.categoryName
FROM c
ORDER BY RANK FullTextScore(c.searchText, "mountain", "frame")
```

Items containing both terms, and containing them more often relative to their length, sort to the top. Because the score can't be projected, treat the order of the result as the answer rather than looking for a number to threshold on.

The two styles combine. Use a contains function to define which items qualify, and `FullTextScore` to order the ones that do.

```sql
SELECT TOP 10 c.name
FROM c
WHERE FullTextContains(c.searchText, "mountain")
ORDER BY RANK FullTextScore(c.searchText, "mountain", "frame")
```

## Prefer full-text search over substring matching

`CONTAINS` looks similar and behaves nothing alike. It tests for a literal substring and doesn't use the full-text index. With a range index on the text path, it can scan distinct indexed values and load matching items instead of evaluating every item. The documented comparison of the two functions over the same container and term is stark: `FullTextContains` returns 234 items for 3.11 request units (RUs) in 0.02 milliseconds, while `CONTAINS` returns 32 items for 12,614 RUs in 258.32 milliseconds.

The result counts differ because the functions answer different questions. `FullTextContains` matches tokens after stemming, so it finds *helmets* when you search *helmet*. `CONTAINS` matches raw characters, so it finds *helmet* inside *helmeted* but misses *Helmet* unless you ask for a case-insensitive comparison.

When you genuinely need literal substring semantics, use both: let `FullTextContains` narrow the candidate set with the index, then apply `CONTAINS` to what survives.

```sql
SELECT *
FROM c
WHERE c.categoryId = @categoryId
    AND FullTextContains(c.searchText, "helmet")
    AND CONTAINS(c.searchText, "Helmet")
```

Full-text search answers questions phrased in the words the data uses. The next unit starts on the other half of the problem: finding items whose meaning matches a request that shares no words with them at all.

In this unit, you explore full-text search capabilities in Azure Cosmos DB for NoSQL, learning how to configure indexes, write queries that use tokenization and stemming, and rank results using `BM25` relevance scoring. In the next unit, you shift focus to vector search, which enables semantic retrieval based on meaning rather than exact words.
