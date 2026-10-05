The query metrics tell you how much work a query did. The index metrics tell you which indexed paths absorbed that work and which paths would absorb it if they existed. Together, they answer the question that decides your next move: is this query expensive because the index can't serve its filter, or because the query is doing an appropriate amount of work in too many places?

In this unit, you read that answer out of the metrics.

## Compare retrieved and output document counts

`RetrievedDocumentCount` is the number of documents the query engine loaded. `OutputDocumentCount` is the number the query returned. Comparing them helps you choose a troubleshooting path, but the counts don't establish a cause by themselves. Aggregations and `JOIN` expressions can also change the relationship between loaded documents and results.

:::image type="content" source="../media/retrieved-versus-output.png" alt-text="Diagram comparing a scan that loads many documents to return few with an indexed query that loads only what it returns." lightbox="../media/retrieved-versus-output.png":::

**Retrieved is much higher than output.** At least one part of the query couldn't use the index, so the engine loaded documents off the physical partition and evaluated the filter against each one. Here is a query that behaves this way against a product catalog, along with the metrics it produces:

```sql
SELECT VALUE c.description
FROM c
WHERE UPPER(c.description) = "BABYFOOD, DESSERT, FRUIT DESSERT, WITHOUT ASCORBIC ACID, JUNIOR"
```

```output
Retrieved Document Count                 :          60,951
Retrieved Document Size                  :     399,998,938 bytes
Output Document Count                    :               7
Output Document Size                     :             510 bytes
Index Utilization                        :            0.00 %
Total Query Execution Time               :        4,500.34 milliseconds
  Index Lookup Time                      :            0.01 milliseconds
  Document Load Time                     :        4,177.66 milliseconds
Client Side Metrics
  Request Charge                         :        4,059.95 RUs
```

Every signal points the same way. Index lookup time is effectively zero because the engine never used the index. Document load time accounts for almost the whole execution. Index utilization is 0 percent. The fix lives in the query text or the indexing policy.

**Retrieved is approximately equal to output.** The engine loaded few unnecessary documents, but the counts alone don't prove index use. An unfiltered `TOP` query can scan and retrieve only one more document than it outputs. That one-document difference is expected. When the charge is still high, inspect index metrics and the partition breakdown. A composite index or better routing might help, but the evidence must identify which change applies.

## Turn on index metrics

Index metrics are opt-in, and for good reason: collecting them adds overhead to the request. Enable them while you're troubleshooting a specific query and turn them off afterward. They also stay stable as long as the query shape and the indexing policy stay the same, so there's nothing to gain from leaving them on in production.

::: zone pivot="csharp"

Set `PopulateIndexMetrics` on the request options and read the `IndexMetrics` string from the response. The .NET v3 SDK supports index metrics from version 3.21.0 onward.

```csharp
QueryRequestOptions options = new()
{
    PopulateIndexMetrics = true
};

FeedIterator<Product> iterator = container.GetItemQueryIterator<Product>(query, requestOptions: options);

while (iterator.HasMoreResults)
{
    FeedResponse<Product> page = await iterator.ReadNextAsync();
    Console.WriteLine(page.IndexMetrics);
}
```

::: zone-end

::: zone pivot="python"

Pass `populate_index_metrics` and read the `x-ms-cosmos-index-utilization` response header. The Python SDK supports index metrics from version 4.6.0 onward. The `get_response_headers()` method used in the following example requires version 4.16.0 or later.


The SDK decodes that header for you: it arrives base64-encoded on the wire, and the client replaces it with a parsed dictionary before you see it. Treat the value as a dictionary with four keys rather than as text to print. Single-index entries carry an `IndexSpec` string. Composite entries carry an `IndexSpecs` list, so the code reads whichever one is present.

```python
query_results = container.query_items(
    query="SELECT * FROM c WHERE c.categoryId = @categoryId AND c.price > @floor",
    parameters=[
        {
            "name": "@categoryId",
            "value": "75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C",
        },
        {"name": "@floor", "value": 1000},
    ],
    populate_index_metrics=True,
)

for page in query_results.by_page():
    list(page)

    headers = query_results.get_response_headers()
    utilization = headers["x-ms-cosmos-index-utilization"]

    for section in (
        "UtilizedSingleIndexes",
        "PotentialSingleIndexes",
        "UtilizedCompositeIndexes",
        "PotentialCompositeIndexes",
    ):
        for entry in utilization.get(section, []):
            spec = entry.get("IndexSpec") or ", ".join(
                entry.get("IndexSpecs", [])
            )
            print(
                f"{section:<26}{spec:<30}{entry['IndexImpactScore']}"
            )
```

> [!NOTE]
> The service returns the index utilization header only when the query returns at least one item. A query with no results produces no index metrics, so test against a filter you know matches something.

::: zone-end

## Read utilized and potential indexed paths

The metrics come back in four sections. A query that filters on two properties covered by the default indexing policy produces this output:

```output
Index Utilization Information
  Utilized Single Indexes
    Index Spec: /categoryId/?
    Index Impact Score: High
    ---
    Index Spec: /price/?
    Index Impact Score: High
    ---
  Potential Single Indexes
  Utilized Composite Indexes
  Potential Composite Indexes
    Index Spec: /categoryId ASC, /price ASC
    Index Impact Score: High
    ---
```

**Utilized paths are evidence.** The query used those paths. If a path you expected to see is missing from the utilized list, removing it from the indexing policy costs the query nothing, which is a useful way to find indexed paths you're paying to maintain and never reading.

**Potential paths are recommendations, not proof.** They list indexes the query might use if you added them. The list isn't exhaustive, and some entries don't improve performance at all. Treat a potential index as a hypothesis: add it, rerun the query, and compare the request charge against the baseline you recorded.

**The index impact score reflects the query shape only, not your data.** A score of **High** means that, based on how the filter is written, the path has a high likelihood of reducing the request charge substantially. It says nothing about how many items match. A filter on a property where almost every item shares the same value still scores High, because the score is computed before any data is considered. When several potential paths compete for your attention, start with the ones scoring High, then verify against real charges.

## Recognize filters the index can't serve

Some filters can't use an index regardless of what the indexing policy contains, and they're the usual explanation for a retrieved count far above the output count.

| Filter | Why it scans | What to do instead |
| :--- | :--- | :--- |
| `UPPER(c.name) = 'VALUE'` | Case-conversion functions aren't served from the index | Normalize the casing when you write the item, then compare directly |
| `GetCurrentDateTime()` in a filter | The value changes per evaluation | Compute the timestamp in the client and pass it as a parameter |
| Non-aggregate mathematical expressions | The engine computes the value per document | Store the computed value as a property, or define a computed property |

String functions including `StartsWith`, `Contains`, `RegexMatch`, and `Left` do use the index, so a filter isn't disqualified for calling a function. `Contains`, `RegexMatch`, `EndsWith`, and the case-insensitive forms of `StartsWith` and `StringEquals` do an index scan whose charge increases with the cardinality of the property. When one of those functions produces a high charge, adding an `ORDER BY` clause on the filtered property sorts the results and makes that scan more efficient.

Treat a potential index as a hypothesis and verify its effect against your baseline. If the query uses suitable indexes but remains expensive, examine how many physical partitions it visits before making another indexing change.
