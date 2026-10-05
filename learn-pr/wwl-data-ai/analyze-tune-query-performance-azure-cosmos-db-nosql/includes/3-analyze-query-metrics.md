A request charge tells you that a query is expensive. It doesn't tell you why. The server-side query metrics do: they report how much work the query engine did, how that work split across physical partitions, and how much of it the index absorbed. Reading those metrics turns "this query costs 400 request units (RU)" into "this query loaded 60,000 documents to return seven."

In this unit, you read the metrics a query returns and use them to distinguish three different problems.

:::image type="content" source="../media/query-diagnosis-path.png" alt-text="Diagram mapping three query metric patterns to fixing the filter or index, tuning routing and latency, or rebalancing load." lightbox="../media/query-diagnosis-path.png":::

## Read the server-side query metrics

The metrics arrive with the query response, so collecting them costs no extra round trip.

::: zone pivot="csharp"

The .NET SDK exposes them as a strongly typed object from version 3.36.0 onward. Call `GetQueryMetrics` on the diagnostics of each `FeedResponse<T>`.

```csharp
FeedIterator<Product> iterator = container.GetItemQueryIterator<Product>(query);

while (iterator.HasMoreResults)
{
    FeedResponse<Product> page = await iterator.ReadNextAsync();
    ServerSideCumulativeMetrics metrics = page.Diagnostics.GetQueryMetrics();
    ServerSideMetrics cumulative = metrics.CumulativeMetrics;

    Console.WriteLine($"Retrieved documents : {cumulative.RetrievedDocumentCount}");
    Console.WriteLine($"Output documents    : {cumulative.OutputDocumentCount}");
    Console.WriteLine($"Index hit ratio     : {cumulative.IndexHitRatio:P2}");
    Console.WriteLine($"Index lookup time   : {cumulative.IndexLookupTime.TotalMilliseconds:0.00} ms");
    Console.WriteLine($"Document load time  : {cumulative.DocumentLoadTime.TotalMilliseconds:0.00} ms");
    Console.WriteLine($"Total time          : {cumulative.TotalTime.TotalMilliseconds:0.00} ms");
}
```

`CumulativeMetrics` aggregates across every physical partition the round trip touched. `ServerSideCumulativeMetrics` also carries a `TotalRequestCharge` property, so one object holds both the cost and the explanation.

::: zone-end

::: zone pivot="python"

The Python SDK returns the metrics in a response header when you pass `populate_query_metrics`. The header is a semicolon-delimited list of `key=value` pairs, so parse it into a dictionary before reading it.

```python
query_results = container.query_items(
    query="SELECT * FROM c WHERE c.name = @name",
    parameters=[{"name": "@name", "value": "Touring-3000 Blue, 62"}],
    enable_cross_partition_query=True,
    populate_query_metrics=True,
)

for page in query_results.by_page():
    list(page)

    headers = query_results.get_response_headers()
    raw = headers["x-ms-documentdb-query-metrics"]
    metrics = dict(pair.split("=", 1) for pair in raw.split(";") if pair)

    for key in sorted(metrics):
        print(f"{key:<32}{metrics[key]}")
```

The dictionary holds the same measurements the .NET object exposes, including the retrieved and output document counts, the index utilization ratio, and a breakdown of where the execution time went.

::: zone-end

Six values carry most of the diagnostic weight.

| Metric | What it tells you |
| :--- | :--- |
| `RetrievedDocumentCount` | How many documents the engine loaded to answer the query |
| `OutputDocumentCount` | How many documents the query returned |
| `IndexHitRatio` | The share of loaded documents that the filter matched, from 0 to 1 |
| `IndexLookupTime` | Time spent in the index layer |
| `DocumentLoadTime` | Time spent reading documents off the physical partition |
| `TotalTime` | Total server-side execution time for the round trip |

`TotalTime` measures server-side work only. If a query's request charge is modest and its `TotalTime` is small, but the call still feels slow, inspect network transit and client-side processing. Check the SDK diagnostics for retries as well, because throttling delays can increase end-to-end latency without increasing server-side execution time.

## Compare the partitions inside one query

A single request charge hides an important distinction: whether the cost came from one busy partition or spread evenly across several.

::: zone pivot="csharp"

`ServerSideCumulativeMetrics` carries a `PartitionedMetrics` list holding one entry per physical partition the round trip reached. Each entry is a `ServerSidePartitionedMetrics` object with the partition key range identifier and the request charge for that partition alone.

```csharp
ServerSideCumulativeMetrics metrics = page.Diagnostics.GetQueryMetrics();

foreach (ServerSidePartitionedMetrics partition in metrics.PartitionedMetrics)
{
    Console.WriteLine(
        $"Partition {partition.PartitionKeyRangeId}: {partition.RequestCharge:0.00} RU");
}
```

::: zone-end

::: zone pivot="python"

The Python SDK reports the metrics for the round trip rather than a per-partition breakdown. To see how work distributes across physical partitions, use the account-level **Normalized RU Consumption (%) By PartitionKeyRangeID** chart described later in this unit, or run the same query against a single partition key value and compare the charge with the unscoped version.

::: zone-end

In an SDK that exposes per-partition query metrics, such as the .NET SDK, each entry describes one continuation rather than the whole query. Collect distinct partition key range identifiers across every page before deciding how many physical partitions the query touched. The Python SDK doesn't expose this per-partition breakdown in its query-metrics response header, so use the `Normalized RU Consumption (%) By PartitionKeyRangeID` chart to examine how work is distributed across physical partitions.

## Diagnose throttling

When operations consume more request units in a second than the container's provisioned throughput allows, Azure Cosmos DB responds with HTTP status code **429**, a rate-limiting response. Current documentation describes four distinct causes, and they call for different responses.

- **Request rate is large.** The common case: consumption exceeded the provisioned request units per second (RU/s), either overall or on a single physical partition.
- **A high rate of metadata requests.** Creating, reading, or listing databases and containers, or querying provisioned throughput, draws on a system-reserved limit. Raising the container's RU/s has no effect on this case.
- **A transient service error.** Retry the request.
- **`TXN_WAIT_FOR_TRANSACTION_END`.** Several clients attempted concurrent transactions against the same logical partition key. Azure Cosmos DB processes one transactional operation at a time per logical partition key, so the second request waits.

A low rate of 429 responses is normal rather than alarming. With evenly distributed partition traffic and acceptable end-to-end latency, a 1 to 5 percent 429 rate can indicate full use of provisioned throughput. A low account-wide rate can still hide a hot partition, so check the individual partition ranges. Each SDK retries rate-limited requests automatically, typically up to nine times, which is why the Azure Monitor metrics often show 429 responses that your application never observed.

Above that range, the next question is whether the load is even. The **Normalized RU Consumption** metric reports the highest utilization across all partition key ranges in a one-minute interval, expressed as a percentage. In the portal, open **Insights**, select **Throughput**, and read the **Normalized RU Consumption (%) By PartitionKeyRangeID** chart. Each partition key range maps to one physical partition. When one range sits at 100 percent while the others stay near 30 percent, you have a hot partition, and adding throughput spreads the extra capacity evenly across all partitions rather than delivering it where the pressure is.

Query metrics help you distinguish index problems from unnecessary fan-out or uneven partition load. When a query loads many documents but returns few, examine its index metrics before choosing a query rewrite or an indexing change.
