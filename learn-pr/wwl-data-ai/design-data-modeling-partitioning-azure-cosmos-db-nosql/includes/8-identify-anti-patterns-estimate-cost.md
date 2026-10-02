A partitioning problem is cheap to fix on a whiteboard and expensive to fix in production, where fixing it means to copy a container. That asymmetry makes design review a skill worth practicing deliberately. In this unit, you review a model for the anti-patterns that show up most often, and estimate what a design costs before it exists.

## Anti-patterns to look for

Each of these anti-patterns passes a casual read of the model and fails under load.

**A low-cardinality key.** Properties like `status`, `region`, `type`, or `countryOrRegion` produce a small fixed number of logical partitions, and every one of them is capped at 20 gigabytes (GB) and 10,000 request units per second (RU/s). The design works in test, where the container is small, and hits a ceiling it can't grow past in production. The exception is a container that stays genuinely small, such as a reference list, where the low-cardinality key buys single-partition reads and the ceilings never come into play.

**High cardinality with no query alignment.** A random identifier that no query filters on can distribute writes well, but those queries fan out. The key satisfies the cardinality criterion and fails the routing one, which is why the criteria have to be evaluated together.

**The item identifier in a query-heavy workload.** A specific and common form of the previous mistake. Using `/id` gives one logical partition per item and efficient point reads, which is why it suits write-dominated containers. It doesn't guarantee equal traffic or item sizes. In a container the application queries without an identifier filter, those queries cross every partition.

**A key that concentrates current writes.** A date or rounded timestamp can send nearly every new write to the same current-day or current-hour value. Historical cardinality looks healthy, but one logical partition absorbs the current traffic. A synthetic key with a suffix can spread those writes. Increasing values alone don't cause this problem: Azure Cosmos DB hashes partition key values, so distinct sequential identifiers don't inherently concentrate writes on one partition.

**A key that reflects one screen instead of the workload.** A key chosen for the query someone happened to be working on when the container was created. Test candidate keys against the whole access-pattern inventory, weighted by frequency.

**A skewed key in a shared workload.** The key is fine for most values and wrong for a few. Tenant identifiers are the common case: correct in shape, catastrophic when one tenant is a hundred times larger than the rest.

**A mutable partition key value.** A property the business changes, such as an order status or an assigned owner. Because partition key values can't be updated, every change becomes a delete and an insert that can't run atomically together.

**Treating “read together” as “owned together.”** Two values appearing on the same screen doesn’t mean they belong to the same aggregate or item. Embedding independently owned data couples unrelated lifecycles and can create multiple competing sources of truth. When a read frequently needs values owned by another aggregate, consider storing a denormalized projection instead.

**Confusing a projection with its source of truth.** A copied category name on Product is optimized for reading, but Category remains authoritative. Every copied or pre-aggregated value needs a defined owner, synchronization mechanism, acceptable consistency window, and recovery strategy.

**Equating aggregates with items, logical partitions, or containers.** An aggregate defines business ownership and lifecycle. An item is a JSON document. A logical partition defines routing, scale, and the scope of multi-item transactions. A container defines partitioning and operational configuration. Forcing these boundaries into a one-to-one mapping can create oversized items, unnecessary containers, or poorly distributed partitions.

**Unbounded growth inside an item.** An array that grows with activity, such as an order history or event log embedded in a parent, makes the item progressively larger and more expensive to read and update. It can eventually reach the item-size limit. This problem often indicates that independently growing records should be separate items. When those items require atomic multi-item operations, co-locate them in the same logical partition rather than embedding an unbounded collection.

:::image type="content" source="../media/storage-distribution-skew.png" alt-text="Diagram showing one oversized tenant partition marked hot and consuming most provisioned throughput, while five sibling partitions hold little data." lightbox="../media/storage-distribution-skew.png":::

## Signals to investigate

Design review catches most of these anti-patterns on paper. For a container already running, investigate these three signals:

- **Normalized RU consumption** reports the maximum per-second utilization across partition key ranges within the measurement interval. Sustained consumption near 100 percent on one range while others remain near 30 percent suggests a hot partition. A brief peak alone doesn't confirm a problem. Split the chart by partition key range and check rate limiting and application latency. Increasing throughput can temporarily help if the busy physical partition receives less than its 10,000-RU/s maximum, but it doesn't remove an underlying key-distribution problem.
- **The `PartitionKeyStatistics` diagnostic log category** reports storage for the largest logical partition key values, which exposes storage skew directly. It reports a sample instead of every value. A key with less than about 1 GB of data might not appear. Therefore, an empty result doesn't prove that the container is evenly distributed. It's also opt-in, so turn on diagnostic settings before you need the data.
- **An alert over that same log** warns when a key value approaches 20 GB, while migration is still a planned project rather than an incident.

## Estimate what a design costs

Start with two main cost components: the throughput you provision or consume, and the storage you occupy. Backup, data transfer, and optional features such as a dedicated gateway can add charges, depending on the configuration. Estimating throughput is a matter of arithmetic once you know the request unit (RU) charge of each operation in your inventory.

A useful anchor: reading a single item of about 1 kilobyte (KB) by its identifier and partition key costs 1 RU with session, consistent prefix, or eventual consistency. Strong and bounded staleness consistency double the read charge. Everything else moves relative to that anchor. Writes cost more than reads of the same item, and the charge rises with item size, the number of indexed properties, and the number of properties in the item. Queries cost more than point reads, and their charge depends on how many items the engine loads, not only how many it returns.

Because those factors compound, measure rather than predict. Every response carries its own charge.

::: zone pivot="csharp"

```csharp
ItemResponse<Product> response = await container.ReadItemAsync<Product>(id, new PartitionKey(categoryId));

Console.WriteLine($"Charge: {response.RequestCharge} RU");
```

::: zone-end

::: zone pivot="python"

```python
item = container.read_item(item=product_id, partition_key=category_id)

charge = container.client_connection.last_response_headers["x-ms-request-charge"]
print(f"Charge: {charge} RU")
```

::: zone-end

With a measured charge per operation, the estimate follows:

1. **Multiply charge by rate.** For each operation in the inventory, multiply its RU charge by the operations per second you expect at peak, not average. Sum across operations to get the RU/s the container needs.
1. **Add storage.** Total item size plus index overhead, billed per GB per month.
1. **Account for regions.** Throughput provisioned on a container is provisioned in every region the account uses, so an account in three regions provisions three times the RU/s. Data and index storage are also billed in each region. Include applicable inter-region data transfer charges.

Run the same arithmetic against a representative sample rather than a single item. A charge measured on the smallest product in the catalog underestimates a workload dominated by the largest.

For a first pass before any code exists, the [Azure Cosmos DB Cost Estimator](https://cosmos.azure.com/costestimator/) models throughput and storage cost from item size, item count, and operation rates. Treat its output as a planning number and replace it with measured charges as soon as you have a working container.

> [!NOTE]
> The Azure Cosmos DB Cost Estimator is currently in preview.

> **Try it yourself:** Review a container you already run against the anti-patterns in this unit, then measure rather than assume. Record the RU charge of your three highest-frequency operations, multiply each by its peak rate, and compare the total against the throughput currently provisioned. Then check the normalized RU consumption for the same container. A large gap between the two totals can indicate over-provisioning. Sustained high normalized consumption at low average utilization calls for a partition-level review before choosing a throughput increase or a partition-key change.
