Contoso's category rename now has a source of events. What it needs next is a consumer that reads those events reliably, survives a process restart without reprocessing everything, and scales out when the catalog grows. In this unit, you build that consumer and see what the runtime handles for you in each language.

## The four components

A change feed processor assembles four pieces. A pull-model consumer manages its own continuation tokens instead of using processor leases:

| Component | Role |
|:----------|:-----|
| Monitored container | The container whose inserts and updates generate the feed. Here, `productMeta`, which holds Contoso's categories. |
| Lease container | Stores the current read position. Each lease document tracks progress for 1 range of partition key values. |
| Compute instance | The host running the consumer: a virtual machine, a container in Azure Kubernetes Service, an App Service instance, or a function. Each instance carries a name that's unique within the deployment. |
| Delegate | Your code, invoked with each batch of changes. |

Create the lease container before starting the processor. It's an ordinary container with a partition key of `/id`. Lease renewals and progress writes consume request units, which can come from dedicated container throughput or shared database throughput.

## Build the consumer

::: zone pivot="csharp"

The change feed processor is part of the .NET V3 SDK. You get a builder from the monitored container, hand it a delegate and a lease container, and start it.

The delegate receives a context object, the batch of changes, and a cancellation token. Because `productMeta` holds both category and tag documents discriminated by a `type` property, the delegate filters on it:

```csharp
static async Task HandleChangesAsync(
    ChangeFeedProcessorContext context,
    IReadOnlyCollection<ProductMetaItem> changes,
    CancellationToken cancellationToken)
{
    Console.WriteLine($"Lease {context.LeaseToken} consumed {context.Headers.RequestCharge} RU.");

    foreach (ProductMetaItem item in changes)
    {
        if (item.type != "category")
        {
            continue;
        }

        await SyncCategoryNameAsync(item, cancellationToken);
    }
}
```

`ChangeFeedProcessorContext` carries the lease token, the request charge for the read, and diagnostics, which makes it the place to emit the telemetry you need when a consumer starts lagging.

Building and starting the processor takes both containers and a processor name:

```csharp
Container monitoredContainer = client.GetContainer("cosmicworks", "productMeta");
Container leaseContainer = client.GetContainer("cosmicworks", "leases");

ChangeFeedProcessor processor = monitoredContainer
    .GetChangeFeedProcessorBuilder<ProductMetaItem>(
        processorName: "categoryNameSync",
        onChangesDelegate: HandleChangesAsync)
    .WithInstanceName("catalog-worker-1")
    .WithLeaseContainer(leaseContainer)
    .WithErrorNotification(HandleErrorAsync)
    .Build();

await processor.StartAsync();

// The processor runs until stopped

await processor.StopAsync();
```

The processor name identifies the workload. Two consumers with different names share a lease container but keep independent positions, which is how one container feeds a search indexer and an archiver at the same time.

Register `WithErrorNotification` even when you skip the other life cycle handlers. Without it, an exception the processor hits while reading the monitored container surfaces nowhere.

::: zone-end

::: zone pivot="python"

The Python SDK doesn't include the change feed processor, so a Python consumer reads the feed directly and keeps its own position. The loop is short, but every piece of bookkeeping is yours.

```python
import time

monitored = database.get_container_client("productMeta")

continuation = load_checkpoint()

while True:
    if continuation:
        changes = monitored.query_items_change_feed(continuation=continuation)
    else:
        changes = monitored.query_items_change_feed(start_time="Beginning")

    for item in changes:
        if item["type"] == "category":
            sync_category_name(item)

    continuation = monitored.client_connection.last_response_headers["etag"]
    save_checkpoint(continuation)

    time.sleep(5)
```

`productMeta` holds both category and tag documents discriminated by a `type` property, so the loop filters on it.

A continuation token records the reader’s position, but it isn’t equivalent to a processor lease. It doesn’t coordinate ownership or distribute work across consumers. The application must persist a separate token for each feed range and coordinate those ranges itself. Persist it after the batch is processed, never before, so that a crash mid-batch replays those changes instead of skipping them. A token stays valid for as long as the container exists when you read in latest version mode.

To spread the work across several workers, read the container's feed ranges and give each worker its own. One feed range corresponds to one physical partition:

```python
ranges = list(monitored.read_feed_ranges())

changes = monitored.query_items_change_feed(
    start_time="Beginning",
    feed_range=ranges[0],
)
```

Each range needs its own continuation token. Ranges also change as the container grows and physical partitions split, so a long-lived deployment has to reread `read_feed_ranges` periodically rather than caching the list at startup.

The pull model also does something the processor can't: read the feed for a single partition key value. Because `productMeta` is partitioned on `/type`, scoping the read to the `category` value removes the need to filter out tag changes in code.

```python
changes = monitored.query_items_change_feed(
    start_time="Beginning",
    partition_key="category",
)
```

::: zone-end

### Where processing starts

By default, a change feed processor starting for the first time picks up changes from that moment forward. To include existing items instead, the Python example explicitly uses `start_time="Beginning"`.

To read a container's full history, which is what a migration or a first-time index build needs, set the start position explicitly. In .NET, `WithStartTime(DateTime.MinValue.ToUniversalTime())` on the builder starts from the beginning of the container's lifetime, and passing any other `DateTime` starts from that moment. In the pull model, `start_time="Beginning"` does the same.

These settings apply only on the first initialization. Once a lease document or a supplied continuation token exists, the stored position wins and changing the start setting has no effect. To reset a processor, stop it and remove that workload's leases before restarting with the desired start configuration. To reset a pull-model reader, omit its saved continuation token and select a new starting position.

### Failures, retries, and poison batches

The change feed processor provides at-least-once delivery. The position advances only after your code returns successfully, so an unhandled exception in the middle of a batch means that entire batch arrives again. The exception is a failure on the first-ever delegate execution: no position is stored yet, so the retry falls back to the start configuration, which might not include that batch. A pull-model reader must implement its own retries and checkpoint handling.

At-least-once delivery also means a successfully processed change can be delivered again. For example, some side effects might complete before a later item causes the batch to fail. Make every handler idempotent, or record a stable operation identifier so that retrying a change doesn’t duplicate notifications, increments, or downstream writes.

That guarantee has an edge. A change that always throws, a malformed document, a downstream service returning a permanent error, blocks its range indefinitely: the same batch retries, fails, and retries again while newer changes queue behind it. Catch exceptions inside your handler and write the failing change to a separate store, so that processing continues and nothing is silently lost. An error container works well.

Prevent two smaller failure modes during design. Set the client network timeout above the 5-second server-side timeout, because a mismatch stalls processing rather than failing loudly. And avoid starting asynchronous work you don't await inside the handler, because the position can advance before that work finishes.

> **Try it yourself:** Take a consumer you recently wrote or read and ask what happens if one input is permanently unprocessable. Does the pipeline route it aside, or does it stop? The answer usually reveals whether the retry behavior was designed or inherited.

## Scaling out

Scaling is a matter of running more instances against the same lease container.

With the processor, instances that share a processor name and lease container but carry distinct instance names automatically divide the leases among themselves, one owner per lease at a time. When you add an instance, the processor redistributes the leases. If an instance stops, another host acquires its leases after the 60-second lease expiration interval and the 13-second lease acquisition interval. Because a lease has exactly one owner, running more instances than leases leaves the extras idle. The processor also creates new leases as the container's partitions grow, so scale follows storage without intervention.

With the pull model, you do the same distribution by hand: an orchestrator reads the feed ranges, assigns them to workers, and reassigns them when a worker joins or fails.

One configuration detail affects processor leases in multi-region accounts. Build the client against the account's global endpoint and select the region with the preferred-regions setting. Lease documents apply only to the endpoint where they were created. If a client uses a regional endpoint, it creates a separate set of leases. As a result, the client processes the feed again.

## Permissions

A processor authenticating with Microsoft Entra ID needs data-plane permissions on both containers: read metadata and read change feed on the monitored container, and read, create, replace, delete, and query on items in the lease container. The `Cosmos DB Built-in Data Contributor` role covers all of them. A pull-model reader needs access to the monitored container and whichever store it uses for checkpoints.

Data-plane role assignments can't be made in the Azure portal. Assign them with `az cosmosdb sql role assignment create`.
