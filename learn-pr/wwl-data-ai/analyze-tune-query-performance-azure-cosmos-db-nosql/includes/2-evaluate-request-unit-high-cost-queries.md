Tuning starts with a number. Before you change an indexing policy or rewrite a filter, you need to know what the current operation costs and how often it runs, because those two values together decide whether the operation is worth your attention at all. A 200 request unit (RU) query that runs twice a day costs less over a month than a 4 RU query that runs 50 times a second.

In this unit, you measure the cost of individual operations and identify the ones that dominate a workload.

## Read the request charge of an operation

Azure Cosmos DB returns the request charge of every operation in a response header, so measuring cost needs no configuration and no extra permission. Each SDK surfaces that header as a property on the response.

For a point operation, read the charge from the item response.

::: zone pivot="csharp"

```csharp
ItemResponse<Product> response = await container.ReadItemAsync<Product>(
    id: "BD340F0A-F661-4ED8-B36F-FBA7623605D9",
    partitionKey: new PartitionKey("75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C"));

Console.WriteLine($"Point read: {response.RequestCharge:0.00} RU");
```

For a query, the charge arrives one page at a time. A `FeedResponse<T>` carries the charge for the page it holds, not for the whole query, so a query that returns three pages reports three separate charges. Add them up as you drain the iterator.

```csharp
QueryDefinition query = new QueryDefinition(
        "SELECT * FROM c WHERE c.categoryId = @categoryId")
    .WithParameter("@categoryId", "75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C");

double totalCharge = 0;
int itemCount = 0;

FeedIterator<Product> iterator = container.GetItemQueryIterator<Product>(query);
while (iterator.HasMoreResults)
{
    FeedResponse<Product> page = await iterator.ReadNextAsync();
    totalCharge += page.RequestCharge;
    itemCount += page.Count;
}

Console.WriteLine($"Query: {totalCharge:0.00} RU for {itemCount} items");
```

::: zone-end

::: zone pivot="python"

```python
response = container.read_item(
    item="BD340F0A-F661-4ED8-B36F-FBA7623605D9",
    partition_key="75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C",
)

charge = response.get_response_headers()["x-ms-request-charge"]
print(f"Point read: {float(charge):.2f} RU")
```

Current Python SDK responses expose headers through get_response_headers(). A query iterator updates its response headers after each page is materialized, so read the charge from that iterator once per page and accumulate the values.

```python
total_charge = 0.0
item_count = 0

query_results = container.query_items(
    query="SELECT * FROM c WHERE c.categoryId = @categoryId",
    parameters=[
        {
            "name": "@categoryId",
            "value": "75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C",
        }
    ],
    partition_key="75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C",
)

for page in query_results.by_page():
    items = list(page)
    item_count += len(items)

    headers = query_results.get_response_headers()
    total_charge += float(headers["x-ms-request-charge"])

print(f"Query: {total_charge:.2f} RU for {item_count} items")

```

::: zone-end

The Data Explorer in the Azure portal reports the same value. Run a query, select the **Query Stats** tab, and read the **Request Charge** row in the metric list. That path costs nothing to set up, so it's the quickest way to compare two versions of a query while you're still deciding which one to write into an application.

## Baseline before you change anything

A request charge is reproducible for a fixed query and data set under the same account and query settings. Keep the indexing policy, consistency level, page size, and physical partition count stable. Service optimizations can change RU consumption over time without an application change, so use a recent baseline. Latency varies with network conditions and server load, so it makes a poor cost signal on its own.

Record a baseline as a small set of representative operations rather than a single query: one point read, one filtered query, and one write. A point read of a 1 KB item costs 1 RU with session, consistent prefix, or eventual consistency. Strong and bounded staleness reads cost twice as much. Use the same item and consistency level for the reference read. Write down the numbers before you touch the indexing policy, because an indexing change usually moves read cost and write cost in opposite directions, and a baseline that covers only reads hides half of the result.

Keep the page size stable between runs as well. The `MaxItemCount` request option controls how many items the service returns per page, and changing it changes the number of round trips, which changes the total charge for the same logical work.

> [!TIP]
> Parameterize the queries you measure. A parameterized query keeps its shape across executions, which lets you compare charges across different values without the query text changing underneath you.

## Find the operations that dominate the workload

A single measurement tells you what one operation costs. Finding the operations worth tuning means combining cost with frequency, and that question is account-level rather than client-side.

The **Total Request Units** metric in Azure Monitor reports consumption for the account and supports splitting by dimension. Split by **Operation Type** to see whether queries, reads, or writes dominate, and filter by **CollectionName** to narrow to one container. A container where `Create` and `Upsert` operations dominate consumption points at the indexing policy rather than at any query, because every indexed path adds work to every write.

For per-request detail, including the request charge of individual operations and the query text, you need diagnostic logs routed to a Log Analytics workspace. To see unobfuscated query text, collect the `QueryRuntimeStatistics` category and enable the account's **Diagnostics full-text query** feature. Query text can contain sensitive values, so enable this feature only when the investigation requires it. Those logs answer questions the metrics can't, such as which logical partition key values consume the most request units per second (RU/s). Diagnostic settings, log routing, and alerting are account-level monitoring concerns that this learning path covers separately.

> [!IMPORTANT]
> Diagnostic logs are billed by volume of data ingested into Log Analytics, separately from Azure Cosmos DB. Turn them on for a bounded investigation and turn them off when you finish.

Use request charge and execution frequency together when you choose a tuning target, and keep the baseline for comparison after each change. For an expensive query, query metrics help you understand where the cost comes from.
