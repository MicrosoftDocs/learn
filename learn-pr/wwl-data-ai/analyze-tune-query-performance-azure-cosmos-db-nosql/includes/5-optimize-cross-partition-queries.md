When a query retrieves roughly what it outputs and the charge is still higher than you want, inspect the index metrics and partition breakdown. Similar document counts don't prove fan-out or rule out expensive index work. If the query uses suitable indexes but visits more physical partitions than necessary, reducing those visits can lower its cost.

In this unit, you scope queries to fewer partitions and tune the ones that genuinely can't be scoped.

## Understand why a query fans out

Azure Cosmos DB distributes a container's data across physical partitions, and **each physical partition holds its own independent index**. There's no single index spanning the container. So when the service receives a query, its first decision is which partitions could possibly hold a match.

:::image type="content" source="../media/cross-partition-fan-out.png" alt-text="Diagram of a routed query reaching one physical partition compared with a fan-out query reaching every partition in the container." lightbox="../media/cross-partition-fan-out.png":::

For a container with a single-path partition key, an equality filter on that key identifies the partition that owns its hash range. An IN filter listing several partition key values narrows the query to the partitions that own those values. For a container with hierarchical partition keys, equality filters on a leading partition-key prefix can efficiently route the query to only the subset of physical partitions containing that prefix; specifying the full hierarchy identifies one logical partition. Predicates that don't provide an equality value or usable hierarchical prefix, including range comparisons on partition-key properties, generally require fan-out.

Consider a `product` container partitioned on `/categoryId`. The first query checks one partition. The second and third check every partition in the container.

```sql
SELECT * FROM c WHERE c.categoryId = "75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C" AND c.price > 1000
```

```sql
SELECT * FROM c WHERE c.price > 1000
```

```sql
SELECT * FROM c WHERE c.categoryId > "75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C"
```

The third query is the one that surprises people. It filters on the partition key, but with a range comparison rather than equality, and hash-based partitioning gives ranges of partition key values no relationship to ranges of hash values. A range filter on the partition key fans out exactly like no filter at all.

Fan-out costs in two ways. Each partition the engine visits carries a small fixed charge on top of the work it does, so the overhead grows with the partition count. And the client merges and sorts results across every partition that responded, which adds latency that no amount of provisioned throughput removes.

> [!NOTE]
> The saving from eliminating fan-out depends on the physical partition count. A newly created container with low throughput and a small dataset usually has one physical partition, but item count alone doesn't prove that. Check the **Physical Partition Count** metric. With one physical partition, scoping doesn't remove any fan-out overhead. Documentation cites roughly 30,000 provisioned request units per second (RU/s) or about 100 GB of stored data as a useful indication of significant fan-out costs, not a minimum threshold for savings. Measure the effect in your container.

## Scope a query to a partition key value

The most direct fix is to include the partition key value in the filter, which usually means carrying it in the request that triggers the query rather than looking it up.

You can also supply the value through the request options instead of the query text. Doing both is common and harmless.

::: zone pivot="csharp"

```csharp
QueryDefinition query = new QueryDefinition(
        "SELECT * FROM c WHERE c.price > @floor")
    .WithParameter("@floor", 1000);

QueryRequestOptions options = new()
{
    PartitionKey = new PartitionKey("75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C")
};

FeedIterator<Product> iterator = container.GetItemQueryIterator<Product>(query, requestOptions: options);
```

> [!IMPORTANT]
> On clients running Linux or macOS, always set the partition key in the request options object. The .NET SDK's local query plan generation relies on a native library that ships for Windows x64 only, so on other platforms the value in the options object is what lets the SDK skip the gateway round trip.

::: zone-end

::: zone pivot="python"

```python
items = container.query_items(
    query="SELECT * FROM c WHERE c.price > @floor",
    parameters=[{"name": "@floor", "value": 1000}],
    partition_key="75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C",
)
```

::: zone-end

Scoping does more than reduce the partitions visited. A single-partition query whose results don't need pagination can skip the client-side query plan call to the gateway entirely, which removes a network round trip from the query's latency. The .NET SDK applies this optimization, called Optimistic Direct Execution, from version 3.38.0 onward, and the `EnableOptimisticDirectExecution` property in `QueryRequestOptions` controls it. Single-partition queries using `GROUP BY`, `ORDER BY`, `DISTINCT`, or aggregate functions benefit most. Queries that still span partitions or still need pagination can see higher latency and cost with it enabled, which is the case for turning it on deliberately rather than assuming it always helps.

## Tune queries that can't be scoped

Some queries legitimately span the container. An administrative report over every category has no partition key value to supply. For those queries, you reduce latency rather than partition count.

::: zone pivot="csharp"

- **Raise the degree of parallelism.** `MaxConcurrency` sets how many partitions the SDK queries at once. Setting it to `-1` lets the SDK choose, and setting it to the number of physical partitions gives the query the best chance of finishing in one round of parallel work. Parallelism helps most when results distribute evenly; when nearly all matches sit in one partition, it does little.
- **Prefetch more aggressively.** `MaxBufferedItemCount` limits how many results the SDK buffers while the client processes the current page. Setting it at or above the expected result count gets the full benefit of prefetching, at the cost of client memory.
- **Right-size the page.** `MaxItemCount` controls items per round trip. A small page multiplies round trips for the same work. Setting it to `-1` lets the SDK choose based on document size.

::: zone-end

::: zone pivot="python"

The Python SDK doesn't expose equivalents to the .NET SDK's `MaxConcurrency` or `MaxBufferedItemCount` query options. The SDK and service manage cross-partition execution. The Python SDK does expose `max_item_count`, which controls the maximum number of items returned per page. Smaller pages can require more round trips, while larger pages can increase response size and client memory use. Measure both latency and total request charge when changing it.

::: zone-end

Concurrency and buffering primarily target latency. Page size and page count can also affect total request charge, so measure both latency and request unit consumption when changing `MaxItemCount`. If the charge remains high, also check for a filter the index can serve or a query the service can route to fewer partitions.

When a high-value query has no partition key value to give it, two structural options remain. A **global secondary index** maintains a copy of the container keyed on a different property. A query can target one partition in that copy when it has an equality filter on the new partition key. A range filter still fans out even if the filtered property becomes the partition key. Alternatively, revisiting the partition key changes the routing for every query at once, at the cost of migrating the data, because a container's partition key can't be changed in place.

Reduce partition scope where the query's requirements allow, and tune client settings for queries that must still span partitions. Compare both request charge and end-to-end latency with your baseline, because a faster query doesn't necessarily consume fewer request units.
