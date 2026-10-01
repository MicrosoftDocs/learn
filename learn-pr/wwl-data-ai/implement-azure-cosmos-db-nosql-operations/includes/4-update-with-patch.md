A Contoso order document holds the customer reference, the shipping address, a payment summary, and every line item on the order. Some of those documents run to several hundred kilobytes. When a warehouse scanner reports that one order shipped, the only thing that changes is a status field and a timestamp. Your app reads the whole document, changes two properties, and writes back the whole document, which moves all of those kilobytes across the network twice to change a few dozen bytes. In this unit, you use partial document patch to send only the change.

## What patch does

**Partial document update** also called the patch API, sends a list of operations that describe the change rather than the resulting document. The service applies those operations to the stored item server side. Your application never has to read the item first.

Three things improve at once:

- **Bandwidth.** The request carries the operations, not the document, and you can suppress the response too. Large documents benefit the most. The request unit (RU) charge is a separate question, covered at the end of this unit.
- **Round-trips.** A patch is a single request. The read-modify-write pattern is at least two, so patch also saves the RU charge of the read you no longer need.
- **Concurrency safety.** Because there's no gap between reading and writing on the client, the read-modify-write race disappears: no other writer can slip in between your read and your write and have their change silently overwritten. `Increment` goes further and composes fully, as you see shortly. Concurrent `Set` or `Replace` on the same path are still last-write-wins, which is what the next two units address.

:::image type="content" source="../media/patch-versus-replace-corrected.png" alt-text="Diagram comparing read-modify-write replace with a single patch request. Patch sends only operations and returns the updated document by default." lightbox="../media/patch-versus-replace-corrected.png":::

Patch is based on the JSON Patch specification, so each operation names a path into the document, such as `/status` or `/lineItems/0/quantity`. Azure Cosmos DB doesn't support the `copy` and `test` operations from that specification.

### Supported operations

| Operation | Effect |
|:---|:---|
| `Add` | Adds the property if it's missing, replaces it if present. On an array, inserts at the given index and shifts the rest. Use the `-` index to append. |
| `Set` | Same as add, except on an array, where it updates the element already at that index instead of inserting. |
| `Replace` | Strict update. Fails if the path doesn't already exist. |
| `Remove` | Deletes the property or array element. Fails if the path doesn't exist. |
| `Increment` | Adds a numeric value to a number field, creating the field if it's missing. Accepts negative values to decrement. Fails if the path exists but doesn't hold a number. |
| `Move` | Removes the value at a `from` path and writes it to the target path. |

Pick the operation that states your intent most narrowly. `Replace` fails loudly when a property you assumed exists is missing, which surfaces a data problem early. `Set` succeeds either way, which is what you want when adding a property to documents written before that property existed.

## Patching an item

The Contoso shipping handler updates the status, stamps the time, and appends a tracking number.

These examples require a `trackingNumbers` array on the stored order. Create that array when you create the order. Appending to `/trackingNumbers/-` doesn't create the parent array.

::: zone pivot="csharp"

```csharp
List<PatchOperation> operations = new()
{
    PatchOperation.Set("/status", "shipped"),
    PatchOperation.Set("/shippedAt", DateTime.UtcNow),
    PatchOperation.Add("/trackingNumbers/-", "1Z999AA10123456784")
};

ItemResponse<Order> response = await container.PatchItemAsync<Order>(
    id: "order-88431",
    partitionKey: new PartitionKey("cust-2043"),
    patchOperations: operations);

Order updated = response.Resource;
```

::: zone-end

::: zone pivot="python"

```python
from datetime import datetime, timezone

operations = [
    {"op": "set", "path": "/status", "value": "shipped"},
    {"op": "set", "path": "/shippedAt", "value": datetime.now(timezone.utc).isoformat()},
    {"op": "add", "path": "/trackingNumbers/-", "value": "1Z999AA10123456784"},
]

updated = container.patch_item(
    item="order-88431",
    partition_key="cust-2043",
    patch_operations=operations,
)
```

::: zone-end

All operations in one patch request apply atomically. Either every operation succeeds and the item is updated, or none of them apply and the item is untouched. There's no partially patched state to reason about.

Decrementing available stock shows the increment operation, and it's the clearest case where patch beats read-modify-write:

::: zone pivot="csharp"

```csharp
await container.PatchItemAsync<Product>(
    id: "prod-4410",
    partitionKey: new PartitionKey("bikes"),
    patchOperations: new[] { PatchOperation.Increment("/inventory/quantity", -1) });
```

::: zone-end

::: zone pivot="python"

```python
container.patch_item(
    item="prod-4410",
    partition_key="bikes",
    patch_operations=[{"op": "incr", "path": "/inventory/quantity", "value": -1}],
)
```

::: zone-end

The service performs the arithmetic, so two concurrent decrements both apply. A client that reads the quantity, subtracts one, and writes it back would let the second write overwrite the first and lose a unit of stock.

### Conditional patch with a filter predicate

Sometimes the update should apply only when the document is in a particular state. A filter predicate attaches a SQL condition to the patch. If the condition is false, the service rejects the request instead of applying the operations.

::: zone pivot="csharp"

```csharp
PatchItemRequestOptions options = new()
{
    FilterPredicate = "FROM orders o WHERE o.status = 'pending'"
};

await container.PatchItemAsync<Order>(
    id: "order-88431",
    partitionKey: new PartitionKey("cust-2043"),
    patchOperations: new[] { PatchOperation.Set("/status", "canceled") },
    requestOptions: options);
```

::: zone-end

::: zone pivot="python"

```python
container.patch_item(
    item="order-88431",
    partition_key="cust-2043",
    patch_operations=[{"op": "set", "path": "/status", "value": "canceled"}],
    filter_predicate="FROM orders o WHERE o.status = 'pending'",
)
```

::: zone-end

A rejected conditional patch returns 412 Precondition Failed. In this example, that response tells you the order already moved past the pending state, so cancellation is no longer valid. Handle it as a business rule, not as an error.

## Constraints to design around

- **Ten operations per request.** A patch specification accepts at most 10 operations. Group larger changes into several patches, or replace the whole document.
- **System properties are read-only.** You can't patch paths such as `id`, `_etag`, `_ts`, and `_rid`, and you can't patch the partition key property, because changing it would move the item to a different logical partition. The `ttl` property is an ordinary property in this respect, and the next unit patches it.
- **Paths must resolve.** `Replace` and `Remove` fail when the target path doesn't exist, and `Add` can create only one level at a time. To add `/inventory/color`, the `/inventory` object must already exist.
- **Conditional patch depends on the SDK.** The .NET SDK and the Python SDK each support a filter predicate that tests the item's current content. The standalone .NET `PatchItemAsync` method doesn't support `IfMatchEtag`; use `FilterPredicate` for that method. Python `patch_item` also supports an ETag precondition through `etag` and `match_condition`. A failed condition returns 412 Precondition Failed. Patch operations within a transactional batch have separate request options.
- **Multi-region conflict resolution is path aware.** In an account with multiple write regions, concurrent patches to different paths in the same document are resolved automatically instead of one overwriting the other. Concurrent patches to the same path use the account's conflict resolution policy. Arrays are the exception: the service treats an array as a single unit, so concurrent patches to different elements of the same array don't merge.

## Choosing between patch and replace

Patch when you're changing a small, known part of a large document, incrementing a counter, or updating a document your code didn't already read. Replace when your code already loaded and modified the full object, when the change touches most of the document, or when the change exceeds 10 operations.

Patch doesn't cut the RU charge the way the size of its request suggests. The service still reads and writes the whole item internally, so patching costs about what replacing the same document costs. What patch saves is the round trip and RU charge of the read you no longer need, plus the bandwidth of moving a large document in both directions. On a 500-KB order, the benefit is substantial. On a 1-KB document, it's marginal. Let document size and whether your code already holds the item decide.

---

> **Try it yourself:** Take an item of a few hundred kilobytes and update one field two ways: once by reading the item, changing the field, and calling replace, and once with a single patch operation. Print the request charge for each path, remembering to include the RU cost of the read in the first one. Then repeat with a 1-KB item and compare how the advantage shifts.
