The Contoso order service retrieves a single order far more often than it does anything else. An agent opens an order. A status page refreshes, a downstream service confirms a shipment. Each of those requests knows exactly which order it wants, which makes it a candidate for the cheapest read Azure Cosmos DB offers. In this unit, the developer retrieves an item by its identifier and partition key with a point read. The developer also learns why this operation is the default choice whenever both values are known.

## What makes a point read different

A **point read** fetches exactly one item using the combination of its `id` and its partition key value. Because both values are supplied, the SDK routes the request directly to the physical partition that holds the item, and the service returns the document without involving the query engine at all.

A query takes a different path. Even a query that filters on a single `id` compiles a query plan, runs it against an index, and returns a result set. The extra machinery costs more, and the cost shows in the request unit (RU) charge:

| Read style | Typical charge for a 1-KB item | Why |
|:---|:---|:---|
| Point read | '1' RU | Direct lookup by `id` and partition key, with no query engine |
| Query returning 1 item | About '3' RU | Query plan, index lookup, and result-set assembly |

Both figures assume the default *session* consistency. Under *strong* or *bounded staleness*, the RU cost of any read doubles, whether it's a point read or a query.

The gap looks small on a single request. Multiply it across the thousands of order lookups the Contoso service handles each minute, and the point read becomes the difference between comfortable headroom and constant throttling. Point reads also have more predictable latency. Their cost varies only with the size of the item retrieved, not with the complexity of a predicate or the number of results to assemble.

## Reading an item

A point read needs two values: the item's `id` and its partition key value. In the Contoso order container, the partition key path is `/customerId`.

::: zone pivot="csharp"

```csharp
string id = "order-88431";
PartitionKey partitionKey = new PartitionKey("cust-2043");

Order order = await container.ReadItemAsync<Order>(id, partitionKey);

Console.WriteLine($"{order.id} status: {order.status}");
```

`ReadItemAsync<T>` deserializes the response into the type you specify, so you work with a typed `Order` object rather than raw JSON. Assigning the result directly to `Order` relies on the implicit conversion from `ItemResponse<Order>`. Capture the response object instead when you need the metadata that comes with it:

```csharp
ItemResponse<Order> response = await container.ReadItemAsync<Order>(id, partitionKey);

Order order = response.Resource;
double charge = response.RequestCharge;
string etag = response.ETag;
```

`RequestCharge` reports the actual RU cost of the operation, so you can compare it with an equivalent query. The API call, not the charge alone, identifies the operation as a point read. `ETag` carries the item's current version, which you use for optimistic concurrency later in this module.

::: zone-end

::: zone pivot="python"

```python
order = container.read_item(item="order-88431", partition_key="cust-2043")

print(f"{order['id']} status: {order['status']}")
```

The Python SDK returns the item as a dictionary. Response metadata, including the RU charge, comes from the response headers:

```python
headers = order.get_response_headers()
charge = headers["x-ms-request-charge"]
etag = order["_etag"]
```

`x-ms-request-charge` reports the actual RU cost of the operation, so you can compare it with an equivalent query. The API call, not the charge alone, identifies the operation as a point read. The `_etag` property carries the item's current version, which you use for optimistic concurrency later in this module.

::: zone-end

Both calls require the partition key value. If you don't know it, use a query to find the item. These point-read APIs don't automatically switch to a query when the partition key argument is missing.

### Handling a missing item

A point read against an `id` that doesn't exist is a normal outcome in an order service, not an exceptional one. A customer follows a stale link, or a downstream retry arrives after a cancellation. The SDK signals this case with an error rather than a null result, so handle it explicitly.

::: zone pivot="csharp"

```csharp
try
{
    ItemResponse<Order> response = await container.ReadItemAsync<Order>(id, partitionKey);
    return response.Resource;
}
catch (CosmosException ex) when (ex.StatusCode == HttpStatusCode.NotFound)
{
    return null;
}
```

Filtering the `catch` clause on `HttpStatusCode.NotFound` keeps genuine failures, such as throttling or authorization errors, propagating to the caller.

::: zone-end

::: zone pivot="python"

```python
from azure.cosmos import exceptions

try:
    return container.read_item(item=item_id, partition_key=customer_id)
except exceptions.CosmosResourceNotFoundError:
    return None
```

Catching `CosmosResourceNotFoundError` specifically, rather than the broader `CosmosHttpResponseError`, keeps genuine failures, such as throttling or authorization errors, propagating to the caller.

::: zone-end

A missing item still costs RUs (request units), so a code path that reads speculatively on every request pays for reads that return nothing. When a read is likely to miss, consider whether the calling code can avoid the attempt.

### Reading several known items at once

The Contoso order page shows a customer's five most recent orders, and it knows all five identifiers. Issuing five separate point reads works, but the SDK offers a batched read that groups the lookups into fewer network round-trips while keeping the per-item RU efficiency of a point read.

::: zone pivot="csharp"

```csharp
List<(string, PartitionKey)> itemsToRead = new()
{
    ("order-88431", new PartitionKey("cust-2043")),
    ("order-88602", new PartitionKey("cust-2043")),
    ("order-89117", new PartitionKey("cust-7781"))
};

FeedResponse<Order> orders = await container.ReadManyItemsAsync<Order>(itemsToRead);
```

`ReadManyItemsAsync` accepts items across different partition keys and returns them in a single feed response.

::: zone-end

::: zone pivot="python"

```python
items_to_read = [
    ("order-88431", "cust-2043"),
    ("order-88602", "cust-2043"),
    ("order-89117", "cust-7781"),
]

orders = container.read_items(items=items_to_read, max_concurrency=4)
```

`read_items` accepts items across different partition keys and returns them as a list. `max_concurrency` caps how many lookups run in parallel. Items that aren't found are omitted from the result rather than raising an error, so compare the result count against the request count when a missing item matters.

::: zone-end

## Choosing between a point read and a query

The decision is mechanical. If your code knows both the `id` and the partition key value, use a point read. If it knows only a filter, such as every order placed by a customer in the last week, use a query.

The interesting case sits between the two: your code knows a business key, such as an order number, but not the `id`. That situation is a data-modeling signal. Storing the order number as the `id` turns a repeated query into a repeated point read and cuts the cost of your most frequent operation, provided the value contains none of the characters that `id` prohibits: `/`, `\`, `?`, and `#`. Design your identifiers around the lookups your application performs most.

---

> **Try it yourself:** Read the same item twice, once with `ReadItemAsync`/`read_item` and once with a query that filters on `id` and the partition key. Print the request charge for each. Then repeat both reads against an item roughly 10 times larger. Watch how the two charges diverge as the document grows, and consider what that difference means for a service running thousands of lookups a minute.
