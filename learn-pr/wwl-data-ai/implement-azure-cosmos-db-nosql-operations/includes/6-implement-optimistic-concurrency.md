Two Contoso support agents open the same order at 10:03. One applies a discount. The other corrects the shipping address. Both read the document, both change their own field, and both write back the whole document. The second write wins completely, and the first agent's discount vanishes without any error surfacing anywhere. In this unit, you use ETags to close that window so a write that's based on stale data fails instead of silently overwriting a newer one.

## The lost update problem

Any read-modify-write sequence opens a gap between the read and the write. During that gap, the item can change underneath you.

:::image type="content" source="../media/6-read-update-latency.png" alt-text="Diagram showing a read operation and an update operation separated by a latency interval labeled n, during which another client can modify the item." lightbox="../media/6-read-update-latency.png":::

The diagram labels the gap *n*. In tight server-side code, *n* is a few milliseconds. In an application where a person reads a form, thinks, and selects **Save**, *n* is minutes. The longer the gap, the more likely a competing write lands inside it, and nothing about the standard write operations detects the collision:

::: zone pivot="csharp"

```csharp
Order order = await container.ReadItemAsync<Order>("order-88431", partitionKey);

order.discount = 15.00;

await container.ReplaceItemAsync<Order>(order, order.id, partitionKey);
```

::: zone-end

::: zone pivot="python"

```python
order = container.read_item(item="order-88431", partition_key="cust-2043")

order["discount"] = 15.00

container.replace_item(item=order["id"], body=order)
```

::: zone-end

The replace succeeds regardless of what happened in between, because nothing in the request describes what the caller expected to find.

## ETags and conditional writes

Every item in Azure Cosmos DB carries a system property named `_etag`: an opaque string that the service regenerates on every write. Two reads of an unchanged item return the same ETag. Any write changes it.

**Optimistic concurrency control** uses that value as a precondition. You read an item and keep its ETag, then attach the ETag to your write. The service compares the value you sent against the item's current ETag and applies the write only if they match. The approach is optimistic because it assumes conflicts are rare: instead of locking the item, it lets both writers proceed and detects the collision at commit time.

:::image type="content" source="../media/optimistic-concurrency-entity-tag-flow.png" alt-text="Diagram showing two agents reading the same item, one writing first, and the second write failing with 412." lightbox="../media/optimistic-concurrency-entity-tag-flow.png":::

::: zone pivot="csharp"

The ETag arrives on the response object from the read:

```csharp
ItemResponse<Order> response = await container.ReadItemAsync<Order>("order-88431", partitionKey);

Order order = response.Resource;
string etag = response.ETag;
```

Attach it to the write with `ItemRequestOptions`:

```csharp
order.discount = 15.00;

ItemRequestOptions options = new ItemRequestOptions { IfMatchEtag = etag };

await container.ReplaceItemAsync<Order>(order, order.id, partitionKey, options);
```

::: zone-end

::: zone pivot="python"

The ETag is available on the returned item as the `_etag` property:

```python
order = container.read_item(item="order-88431", partition_key="cust-2043")

etag = order["_etag"]
```

Attach it to the write with the `etag` and `match_condition` keyword arguments:

```python
from azure.core import MatchConditions

order["discount"] = 15.00

container.replace_item(
    item=order["id"],
    body=order,
    etag=etag,
    match_condition=MatchConditions.IfNotModified,
)
```

`MatchConditions.IfNotModified` tells the SDK to send the value as an `If-Match` header, so the write proceeds only when the stored item still carries that ETag.

::: zone-end

::: zone pivot="csharp"

The same options work on `ReplaceItemAsync` and `DeleteItemAsync`, so you guard a conditional delete the same way you guard a conditional update. `UpsertItemAsync` applies the ETag only when the item already exists. When the call inserts instead, it skips the constraint and nothing surfaces. `CreateItemAsync` ignores the ETag outright. The standalone `PatchItemAsync` method doesn't support `IfMatchEtag`. For a conditional patch, use `FilterPredicate` through `PatchItemRequestOptions` to test the item's current content. An ETag on a supported operation inside a transactional batch makes the whole transaction conditional, which the next unit covers.

::: zone-end

::: zone pivot="python"

The same options work on `replace_item`, `delete_item`, and `patch_item`, so you guard a conditional delete or a conditional patch the same way you guard a conditional update. `upsert_item` applies the ETag only when the item already exists. When the call inserts instead, it skips the constraint and nothing surfaces. `create_item` ignores the ETag outright. A patch also accepts a `filter_predicate`, which tests the item's current content rather than its version, so pick whichever condition matches the rule you're enforcing. An ETag on a single operation inside a transactional batch makes the whole transaction conditional, which the next unit covers.

::: zone-end

## Handling the conflict

When the ETags don't match, the service rejects the write with **412 Precondition Failed**. That status is the whole point of the pattern: it tells you the item changed since you read it, and it hands your caller a decision to make.

::: zone pivot="csharp"

```csharp
try
{
    await container.ReplaceItemAsync<Order>(order, order.id, partitionKey, options);
}
catch (CosmosException ex) when (ex.StatusCode == HttpStatusCode.PreconditionFailed)
{
    // Another writer changed the order after this copy was read.
}
```

::: zone-end

::: zone pivot="python"

```python
from azure.cosmos import exceptions

try:
    container.replace_item(
        item=order["id"],
        body=order,
        etag=etag,
        match_condition=MatchConditions.IfNotModified,
    )
except exceptions.CosmosAccessConditionFailedError:
    # Another writer changed the order after this copy was read.
    pass
```

::: zone-end

Three responses to a 412 are reasonable, and the right one depends on the change:

- **Re-read and retry.** Read the item again to pick up the current state and ETag, reapply your change, and write again. Bound the loop, typically to three or four attempts, so a hot item can't spin forever.
- **Surface the conflict.** Tell the user that the record changed and show them the current values. For a human editing a form, an automatic retry would quietly discard whatever the other person did.
- **Reconsider the operation.** A 412 on a read-modify-write of a numeric field often means a patch increment is the better operation. The service does the arithmetic without a client read-modify-write gap. Contention can still produce retryable errors, and multi-region conflict resolution still applies.

A bounded retry loop looks like this example:

::: zone pivot="csharp"

```csharp
for (int attempt = 0; attempt < 3; attempt++)
{
    ItemResponse<Order> current = await container.ReadItemAsync<Order>(id, partitionKey);
    Order order = current.Resource;
    order.discount = 15.00;

    try
    {
        await container.ReplaceItemAsync<Order>(
            order, order.id, partitionKey,
            new ItemRequestOptions { IfMatchEtag = current.ETag });
        break;
    }
    catch (CosmosException ex) when (ex.StatusCode == HttpStatusCode.PreconditionFailed)
    {
        // Someone else won this round. Read the newer version and try again.
    }
}
```

::: zone-end

::: zone pivot="python"

```python
for attempt in range(3):
    order = container.read_item(item=item_id, partition_key=customer_id)
    order["discount"] = 15.00

    try:
        container.replace_item(
            item=order["id"],
            body=order,
            etag=order["_etag"],
            match_condition=MatchConditions.IfNotModified,
        )
        break
    except exceptions.CosmosAccessConditionFailedError:
        # Someone else won this round. Read the newer version and try again.
        continue
```

::: zone-end

Each retry starts with a fresh read, which is what makes the loop correct. Retrying with the original ETag fails every time. The loop falls through silently once the attempts run out: in production code, report that outcome to the caller instead of letting an abandoned write look like a successful one.

## Deciding when to use it

Optimistic concurrency is opt-in. Without an ETag, last write wins, which is fine for data that a single writer owns or that your application regenerates from a source of truth.

Add the ETag when losing an update has a real consequence: order state, account balances, inventory, and anything a person edits through a form. The cost is one extra header and a catch block, and the protection covers the exact case that's hardest to reproduce in testing.

Before adding the ETag, check whether patch removes the need for it. A conditional patch with a filter predicate expresses "change this only if the order is still pending" directly, and an increment operation handles counters without any read at all. Reach for the ETag when the update genuinely depends on the full document you read.

---

> **Guiding question:** Two Contoso code paths both hit 412 under load. The first decrements a stock counter after reading the product. The second saves an order-notes field that a support agent edited in a form over several minutes. An automatic retry loop is right for exactly one of them, and the other calls for a different fix entirely. Which is which, and what does the correct fix look like in each case?
