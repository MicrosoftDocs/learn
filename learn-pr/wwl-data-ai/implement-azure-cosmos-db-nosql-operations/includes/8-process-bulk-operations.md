Every night, Contoso reloads a product catalog of several hundred thousand items into Azure Cosmos DB. Those writes have nothing in common with the checkout path: they span every partition in the container, no two of them depend on each other, and nobody is waiting on an individual response. What matters is total elapsed time. Issuing them one at a time, awaiting each response before starting the next, takes hours. In this unit, you use bulk execution to finish the same work in minutes.

## Batch and bulk solve different problems

The two features sound similar and behave in opposite ways.

| Aspect | Transactional batch | Bulk execution |
|:---|:---|:---|
| Purpose | Correctness | Throughput |
| Atomicity | All operations commit or none do | Each operation succeeds or fails independently |
| Partition scope | One logical partition | Any number of partitions |
| Operation count | Up to 100 | Effectively unlimited |
| Failure handling | Whole transaction rolls back | Inspect and retry individual failures |
| Use it for | Related writes that must stay consistent | Large independent workloads |

Bulk offers no transactional guarantee at all. If 3 writes out of 200,000 fail, the other 199,997 are committed and stay committed. That behavior is correct for a catalog load, where you want to retry the 3 failures rather than discard the whole run, and wrong for a checkout.

## How bulk execution works

Internally, bulk doesn't send one request per item. The SDK holds outstanding operations briefly, groups the ones that target the same physical partition, and dispatches each group as a single service request. Fewer, larger requests mean less per-request overhead, fewer client threads, and far better use of the throughput you provision.

The trade-off is latency on the individual operation. The SDK waits a short interval to fill each group, so any single write in bulk mode takes longer than it would on its own. That latency is why bulk belongs on background ingest paths and not on request-response paths where a user is waiting.

::: zone pivot="csharp"

### Bulk in .NET

The .NET SDK exposes bulk as a client-level setting. Set `AllowBulkExecution` when you construct the `CosmosClient`:

```csharp
CosmosClientOptions options = new CosmosClientOptions
{
    AllowBulkExecution = true
};

CosmosClient bulkClient = new CosmosClient(endpoint, new DefaultAzureCredential(), options);
```

The setting is immutable for the lifetime of the client, and it changes the behavior of every operation that client issues. Because of the added per-operation latency, use a **dedicated client instance for bulk work** and keep your regular singleton client for request-response traffic.

With bulk enabled, you don't call a special API. You start many operations without awaiting each one, collect the tasks, and await them together:

```csharp
Container container = bulkClient.GetDatabase("cosmicworks").GetContainer("product");

List<Task> tasks = new List<Task>(products.Count);

foreach (Product product in products)
{
    tasks.Add(container.CreateItemAsync(product, new PartitionKey(product.categoryId)));
}

await Task.WhenAll(tasks);
```

`Task.WhenAll` is what gives the SDK a pool of concurrent operations to group. Awaiting each `CreateItemAsync` inside the loop instead would leave the SDK with exactly one operation at a time and no opportunity to batch anything.

`Task.WhenAll` waits for every task to finish, but awaiting it rethrows only the first exception and hides the rest, which is unhelpful when you need to know which items didn't land. Attach a continuation to each task so every result is inspectable:

```csharp
foreach (Product product in products)
{
    tasks.Add(container
        .CreateItemAsync(product, new PartitionKey(product.categoryId))
        .ContinueWith(t =>
        {
            if (t.IsCompletedSuccessfully)
            {
                return;
            }

            Exception failure = t.Exception?.Flatten().InnerExceptions.FirstOrDefault();

            Console.WriteLine(failure is CosmosException ex
                ? $"{product.id} failed: {(int)ex.StatusCode}"
                : $"{product.id} failed: {failure?.Message ?? "canceled"}");
        }));
}

await Task.WhenAll(tasks);
```

The second branch matters. A cancellation arrives as a `CosmosOperationCanceledException`, which inherits from `OperationCanceledException` rather than `CosmosException`, so a check that looks only for the latter discards those failures without a trace.

::: zone-end

::: zone pivot="python"

### Concurrent writes in Python

The Python SDK has no bulk execution flag. The documented workaround is to drive many operations concurrently with the asynchronous client, so the requests overlap on the wire instead of running one after another. It isn't full parity: the async client doesn't group operations by physical partition the way `AllowBulkExecution` does, and it consumes request units (RUs) quickly, so test your concurrency level against the emulator before pointing it at a provisioned container.

Install the async transport dependency alongside the SDK:

```bash
pip install azure-cosmos aiohttp
```

Import the client from `azure.cosmos.aio` and run the writes with `asyncio.gather`:

```python
import asyncio
from azure.cosmos.aio import CosmosClient
from azure.identity.aio import DefaultAzureCredential

async def load_products(products):
    async with DefaultAzureCredential() as credential:
        async with CosmosClient(endpoint, credential) as client:
            container = client.get_database_client("cosmicworks").get_container_client("product")

            semaphore = asyncio.Semaphore(100)

            async def create(product):
                async with semaphore:
                    return await container.create_item(body=product)

            results = await asyncio.gather(
                *(create(p) for p in products),
                return_exceptions=True,
            )

            for result in results:
                if isinstance(result, asyncio.CancelledError):
                    raise result

            failures = [r for r in results if isinstance(r, Exception)]
            print(f"{len(products) - len(failures)} writes confirmed, {len(failures)} unconfirmed")

asyncio.run(load_products(products))
```

Two details carry most of the value. The semaphore caps how many requests are in flight, which keeps the client from opening more connections than it can service and lets you tune concurrency against your provisioned throughput. `return_exceptions=True` keeps `gather` collecting results after the first failure, so one bad item doesn't abandon the rest of the load.

Cancellation is propagated rather than counted as a successful write. An exception doesn't always mean the item wasn't stored: a write can commit before its response times out. Inspect each unconfirmed outcome before deciding whether to retry it.

> [!IMPORTANT]
> Don't use the synchronous `azure.cosmos.CosmosClient` inside an event loop. Its blocking calls stall the loop and negate the concurrency you're trying to gain. Import the client from `azure.cosmos.aio` for async work.

::: zone-end

## Provisioning and throttling

Bulk can saturate the container's throughput. When requests exceed the available request units (RUs), the service responds with **429 Too Many Requests**, and the SDK retries those operations automatically with back-off. By default, the .NET SDK makes up to 9 retries, issuing the request up to 10 times in total, over a cumulative wait of up to 30 seconds, before the error reaches your code. For a long ingest, consider raising the retry count and wait time on the client options. Provisioned request units per second (RU/s) set an upper bound on service throughput, but client resources, network latency, and partition distribution can also limit the load.

That behavior leads to a few practical habits:

- **Raise throughput for the load, then lower it.** Scale up the container before a large ingest, and scale back down afterward within its allowed minimum. More RU/s can reduce elapsed time when service throughput is the bottleneck.
- **Watch out for the shared ceiling.** A bulk job pointed at a production container consumes throughput that live traffic needs. Either isolate the ingest container or schedule the job for a quiet window.
- **Exclude unused index paths.** Indexing is a large share of write cost. A container that indexes only the paths you query writes measurably faster and cheaper during ingest.
- **Spread work across partition key values.** Bulk can parallelize across physical partitions. A load where most items share one partition key value is limited to the throughput of the physical partition that holds it, even when requests run concurrently.

## Choosing your approach

Ask two questions in order. First: do these writes have to succeed or fail together? If yes, you need a transactional batch, and the items must share a partition key value. If no, ask the second question: are these writes part of a background workload where total throughput matters more than the latency of any single write? If yes, use bulk. If neither applies, individual point operations remain the right choice, and they keep your code simplest.

:::image type="content" source="../media/batch-versus-bulk-decision.png" alt-text="Diagram of a decision flowchart choosing between a transactional batch, bulk execution, and individual point operations." lightbox="../media/batch-versus-bulk-decision.png":::

---

> **Synthesis prompt:** Contoso wants to import 50,000 orders from a legacy system. Each order arrives with its line items, and an order and its line items must never exist in a half-written state. The whole import needs to finish inside a two-hour window. Bulk gives you the throughput but no atomicity. Batch gives you atomicity, but only within a partition. Sketch an approach that satisfies both requirements, and note what your data model has to look like for it to work.
