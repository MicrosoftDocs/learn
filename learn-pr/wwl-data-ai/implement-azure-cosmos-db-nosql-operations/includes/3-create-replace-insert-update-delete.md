Reading orders is only half of the Contoso data layer. The service also has to record a new order when a customer checks out and revise an order when a warehouse confirms stock. It must refresh a cached shipping quote whether or not one already exists, and remove a canceled order. Four write operations cover all of it, and each carries different semantics for what happens when the item already exists. In this unit, you perform each write with the SDK and learn which one to reach for in a given situation.

## The four write operations

| Operation | Item exists | Item doesn't exist | Use it when |
|:---|:---|:---|:---|
| Create | Fails with 409 Conflict | Inserts the item | The item is genuinely new and a duplicate is an error |
| Replace | Overwrites the whole item | Fails with 404 Not Found | You loaded the item, changed it, and expect it to still be there |
| Upsert | Overwrites the whole item | Inserts the item | You don't know or don't care whether the item exists |
| Delete | Removes the item | Fails with 404 Not Found | The item is no longer needed |

Every one of these operations is a point operation, addressed by `id` and partition key, so each one costs a predictable amount. For a 1-KB item with few indexed properties, a create or delete costs roughly '5' RUs (request units). That's five times the '1' RU cost of a point read, because the service writes to the replica set and updates the index. A replace costs about twice as much as a create operation, because the service deletes the old document and inserts the new one as two full document operations. An upsert costs whichever case applies: around '5' RUs when it inserts, around 10 when it replaces. Indexing more properties raises the cost of every write.

### Creating an item

Create is the strict option. It succeeds only if no item with that `id` exists in that logical partition, which makes it the right choice for a checkout that must never produce two orders from one submission.

::: zone pivot="csharp"

```csharp
Order order = new Order
{
    id = "order-88431",
    customerId = "cust-2043",
    status = "pending",
    total = 249.95
};

ItemResponse<Order> response = await container.CreateItemAsync<Order>(
    item: order,
    partitionKey: new PartitionKey(order.customerId));
```

Passing the partition key explicitly lets the SDK route the request without inspecting the serialized document, which is slightly faster. If you omit it, the SDK extracts the value from the item itself.

Catch the conflict and treat it as a business outcome rather than a failure:

```csharp
try
{
    await container.CreateItemAsync<Order>(order, new PartitionKey(order.customerId));
}
catch (CosmosException ex) when (ex.StatusCode == HttpStatusCode.Conflict)
{
    // An order with this id already exists in this partition.
}
```

::: zone-end

::: zone pivot="python"

```python
order = {
    "id": "order-88431",
    "customerId": "cust-2043",
    "status": "pending",
    "total": 249.95,
}

created = container.create_item(body=order)
```

The Python SDK extracts the partition key value from the document itself, so the item must include the property that the container's partition key path points at.

Catch the conflict and treat it as a business outcome rather than a failure:

```python
from azure.cosmos import exceptions

try:
    container.create_item(body=order)
except exceptions.CosmosResourceExistsError:
    # An order with this id already exists in this partition.
    pass
```

::: zone-end

Remember that `id` is unique only within a logical partition. Two different customers can each have an order with the `id` `order-88431` without conflicting, because they sit in different logical partitions. Uniqueness across the whole container requires a globally unique identifier such as a GUID.

### Replacing an item

Replace overwrites an existing item completely. Anything absent from the object you pass in disappears from the stored document, which is exactly what you want after a read-modify-write cycle and exactly what you don't want if you constructed a partial object by hand.

::: zone pivot="csharp"

```csharp
Order order = await container.ReadItemAsync<Order>("order-88431", partitionKey);
order.status = "shipped";

await container.ReplaceItemAsync<Order>(
    item: order,
    id: order.id,
    partitionKey: new PartitionKey(order.customerId));
```

::: zone-end

::: zone pivot="python"

```python
order = container.read_item(item="order-88431", partition_key="cust-2043")
order["status"] = "shipped"

container.replace_item(item=order["id"], body=order)
```

::: zone-end

Because replace requires the item to already exist, it fails with 404 when another process deleted the order between your read and your write. That failure is useful information: it tells you the state you based your change on is gone.

### Upserting an item

Upsert collapses the create-or-replace decision into a single request. The Contoso service uses it for a cached shipping quote per customer, where the code doesn't know or care whether a quote already exists.

::: zone pivot="csharp"

```csharp
await container.UpsertItemAsync<ShippingQuote>(
    item: quote,
    partitionKey: new PartitionKey(quote.customerId));
```

::: zone-end

::: zone pivot="python"

```python
container.upsert_item(body=quote)
```

::: zone-end

Upsert is convenient, and that convenience is also its risk. It replaces an existing item with the same `id` and partition key instead of rejecting it as a duplicate create, so it can overwrite an item that another process created a moment earlier. Other constraints, such as a unique key policy, can still cause a 409 Conflict. Reach for create when a duplicate is a real error, and reserve upsert for data your application owns outright and can safely regenerate.

### Deleting an item

Delete removes a single item, addressed the same way as a point read.

::: zone pivot="csharp"

```csharp
await container.DeleteItemAsync<Order>(
    id: "order-88431",
    partitionKey: new PartitionKey("cust-2043"));
```

::: zone-end

::: zone pivot="python"

```python
container.delete_item(item="order-88431", partition_key="cust-2043")
```

::: zone-end

Delete fails with 404 when the item is already gone. For an idempotent cleanup path, catching and ignoring that status is correct, because a missing item and a just-deleted item leave the caller in the same state.

## Trimming the response payload

Create, replace, and upsert each return the stored item by default. Ingest and fire-and-forget paths usually discard that result. When yours does, you pay for bandwidth and deserialization you never use. Both SDKs (Software Development Kits) let you suppress the payload.

::: zone pivot="csharp"

```csharp
ItemRequestOptions options = new ItemRequestOptions
{
    EnableContentResponseOnWrite = false
};

await container.CreateItemAsync<Order>(order, new PartitionKey(order.customerId), options);
```

::: zone-end

::: zone pivot="python"

```python
container.create_item(body=order, no_response=True)
```

The `no_response` argument applies to `create_item`, `replace_item`, and `upsert_item`. It arrived in a recent release of the `azure-cosmos` package, so upgrade the package if your client rejects the argument.

::: zone-end

The RU charge stays the same, because the service does the same work. What you save is network transfer and client-side processing, which matters most on the high-volume write paths you meet later in this module.

---

> **Guiding question:** The Contoso checkout endpoint retries automatically when a request times out, so the same order submission can arrive twice. Which write operation makes that retry safe, and what does your handler need to do after catching the conflict to tell a genuine duplicate apart from a retry of its own request?
