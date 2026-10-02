The Contoso catalog now serves retail brands who run their own storefronts, and the obvious key for the shared containers is the tenant identifier: every storefront query is scoped to one brand, so every query routes to one partition. The obvious key is also the one that breaks first. Tenant is a low-cardinality property, tenant sizes are wildly uneven, and the largest brand passes 20 gigabytes (GB) of products long before the others reach 1 GB. When it does, writes for that tenant stop.

Hierarchical partition keys solve exactly the case where a tenant outgrows a logical partition. In this unit, you subpartition a container so that one first-level value can grow past the logical partition ceiling while queries that name it still route efficiently.

## How subpartitioning changes the ceiling

A hierarchical partition key declares up to three property paths in order. The full path, all levels combined, defines the logical partition and carries the same ceilings as any other logical partition: 20 GB and 10,000 request units per second. What changes is that a *prefix* of the hierarchy is no longer a logical partition.

Items sharing a first-level value are colocated on the same physical partition for as long as they fit. When that physical partition passes 50 GB, the service splits it and the data for that first-level value spreads across two physical partitions. Repeat as the tenant grows. A single `tenantId` value can occupy many physical partitions and many terabytes, while the 20-GB limit applies only to a full three-part key that's unlikely to ever fill.

For Contoso, the hierarchy follows the storefront's own access path:

| Level | Path | Why |
|:------|:-----|:----|
| 1 | `/tenantId` | Scopes every storefront operation |
| 2 | `/categoryId` | The filter on the highest-frequency read |
| 3 | `/id` | Guarantees the full key never fills a logical partition |

## Create a subpartitioned container

Hierarchical keys are set at creation and can't be added to an existing container. The supported software development kits (SDKs) are .NET v3 3.33.0 or later, Java v4 4.42.0 or later, Python 4.6.0 or later, and JavaScript v4 4.0.0.

> [!NOTE]
> Hierarchical partition key support in the JavaScript SDK is currently in preview. The .NET, Java, and Python SDKs are generally available.

::: zone pivot="csharp"

```csharp
List<string> keyPaths = new()
{
    "/tenantId",
    "/categoryId",
    "/id"
};

ContainerProperties properties = new(id: "product", partitionKeyPaths: keyPaths);

Container container = await database.CreateContainerIfNotExistsAsync(properties);
```

The `partitionKeyPaths` parameter, plural, is what distinguishes this container from one with a single key. The SDK sets the partition key kind and version for you.

::: zone-end

::: zone pivot="python"

```python
from azure.cosmos import PartitionKey

container = database.create_container_if_not_exists(
    id="product",
    partition_key=PartitionKey(
        path=["/tenantId", "/categoryId", "/id"],
        kind="MultiHash",
    ),
)
```

A list of paths and a `kind` of `MultiHash` together declare the hierarchy. The order of the list is the order of the hierarchy and can't be changed later.

::: zone-end

### Write and read items

Writes need no special handling as long as each item carries a value at every declared path. Omitting a value isn't safe: the Python SDK rejects the write with a partition key mismatch, and the .NET SDK treats the missing level as undefined and stores the item under a key your queries don't match.

Point reads need the full key, all three values, in hierarchy order.

::: zone pivot="csharp"

```csharp
PartitionKey partitionKey = new PartitionKeyBuilder()
    .Add(product.tenantId)
    .Add(product.categoryId)
    .Add(product.id)
    .Build();

ItemResponse<Product> response = await container.ReadItemAsync<Product>(product.id, partitionKey);
```

`PartitionKeyBuilder` assembles the composite value. The SDK can also extract it from the object you pass to `CreateItemAsync`, but supplying it explicitly performs better at scale.

::: zone-end

::: zone pivot="python"

```python
item = container.read_item(
    item=product_id,
    partition_key=[tenant_id, category_id, product_id],
)
```

The partition key is a list in hierarchy order. Supplying fewer values than the container declares raises an error rather than performing a partial lookup.

::: zone-end

### Query by prefix

The reason to order the hierarchy around your access patterns is routing. A query that names a leading run of the hierarchy in its `WHERE` clause reaches only the physical partitions holding that data, no matter how many partitions the container has.

| Filter | Routing |
|:-------|:--------|
| Tenant, category, and item identifier | One logical partition |
| Tenant and category | The subset of partitions holding that category's data for that tenant |
| Tenant only | The subset of partitions holding that tenant's data |
| Category only, or item identifier only | Every physical partition |

:::image type="content" source="../media/hierarchical-partition-key-routing.png" alt-text="Diagram showing how filters on one, two, or three leading hierarchical-key levels reach fewer partitions; skipping the first level fans out to all." lightbox="../media/hierarchical-partition-key-routing.png":::

The last row is the trap. Omitting the first level removes the routable prefix, so a filter on only the middle of the hierarchy fans out. If the query includes the tenant but skips the category, it can still route by the tenant prefix.

::: zone pivot="csharp"

```csharp
QueryDefinition query = new QueryDefinition(
        "SELECT p.id, p.name, p.price FROM product p WHERE p.tenantId = @tenant AND p.categoryId = @category")
    .WithParameter("@tenant", tenantId)
    .WithParameter("@category", categoryId);

using FeedIterator<Product> iterator = container.GetItemQueryIterator<Product>(query);

while (iterator.HasMoreResults)
{
    FeedResponse<Product> page = await iterator.ReadNextAsync();
    // Process the page
}
```

::: zone-end

::: zone pivot="python"

```python
results = container.query_items(
    query="SELECT p.id, p.name, p.price FROM product p WHERE p.tenantId = @tenant AND p.categoryId = @category",
    parameters=[
        {"name": "@tenant", "value": tenant_id},
        {"name": "@category", "value": category_id},
    ],
    enable_cross_partition_query=True,
)

for product in results:
    print(product["name"])
```

::: zone-end

Put the prefix values in the `WHERE` clause. Routing is derived from the filter, so supplying the values only through a partition key object doesn't guarantee that the query avoids a fan-out.

## Choose the levels deliberately

Three properties of the hierarchy decide whether it helps.

**The first level needs high cardinality, measured against your physical partition count.** Because items sharing a first-level value colocate, each of five tenants initially sends its writes to one physical partition. Those tenants might occupy only a few of the container's partitions. Splits can take four to six hours to complete. Hierarchical keys suit workloads with hundreds or thousands of first-level values and broadly similar usage per value. With a handful of tenants, or one tenant that consistently consumes far more throughput than the rest, they can concentrate traffic rather than distribute it evenly.

**Each level should appear in your queries.** A level nobody filters on adds key length and complexity without buying routing.

**The item identifier is the safest final level, with one caveat.** It guarantees the full key never approaches 20 GB. But transactional batch operations and stored procedures require the complete key, so a hierarchy ending in `/id` can't run an atomic multi-item operation scoped to a tenant or a category. If a workload needs those guarantees at a prefix level, end the hierarchy somewhere else.

To move an existing container onto a hierarchical key, create a new container with the hierarchy defined and copy the data across, the same migration path as any other partition key change.

For a container already in production and already at the ceiling, a support request can raise its logical partition size limit above 20 GB. Use the support request only as a temporary measure while you migrate. It isn't a permanent solution because the service-level agreement doesn't apply while the higher limit is in effect.
