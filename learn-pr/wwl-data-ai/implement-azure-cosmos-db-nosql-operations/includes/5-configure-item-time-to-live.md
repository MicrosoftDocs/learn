Not everything the Contoso order service writes deserves to live forever. A checkout session holds a cart for a few hours. A shipping quote from a carrier goes stale in 15 minutes. An idempotency token guarding against duplicate submissions matters for a day and never again. Storing that data indefinitely inflates storage cost and forces someone to write a cleanup job. In this unit, you configure time to live so Azure Cosmos DB expires those items for you.

## How time to live works

Time to live (TTL) is a countdown, measured in seconds, that starts from the moment an item was last modified. When the countdown reaches zero, the item is eligible for deletion. Two settings interact:

- **Container TTL** (`DefaultTimeToLive`) controls whether expiration is enabled for the container at all, and sets the default for items that don't specify their own value.
- **Item TTL** (the `ttl` property on a document) overrides the container default for that one item.

The container setting is the gate. If it's off, item TTL values are ignored entirely.

| Container `DefaultTimeToLive` | Item without `ttl` | Item with `ttl` |
|:---|:---|:---|
| Not set (expiration off) | Never expires | Never expires, and the value is ignored |
| `-1` (enabled, no default) | Never expires | Expires after the item's `ttl` seconds |
| A positive number, for example `86400` | Expires after the container default | Expires after the item's `ttl` seconds |

The `-1` value means "enabled, but nothing expires unless the item says so," and it's the setting to use when only some documents in the container are transient. An item can also set its own `ttl` to `-1`, which exempts that single item from a container default. Apart from `-1`, both settings take a positive number of seconds up to 2,147,483,647, roughly 68 years. Zero isn't valid in either place.

Expired items stop appearing in query and read results as soon as they expire, even though physical deletion happens in the background. On a provisioned throughput account, the background delete consumes leftover request units (RUs), so it never competes with your application's requests. On a serverless account, those deletions are charged at the same rate as delete operations. The service doesn't guarantee that the physical delete completes at an exact moment in either case. Design for "gone from results on time," not "physically deleted on time."

## Enabling expiration on the container

Item TTL does nothing until the container allows it. You configure the container property once, either in the Azure portal or in code, and normally at provisioning time rather than at runtime. The container also has to be indexed: a container whose indexing mode is `none` rejects the change.

> [!IMPORTANT]
> The container-replacement SDK examples below apply to a client authenticated with an account key. With Microsoft Entra authentication, configure container TTL through the Azure portal, Azure CLI, Azure PowerShell, or a management SDK with appropriate control-plane permissions. Microsoft Entra authentication doesn't authorize container replacement through the data-plane SDK. The exercise uses Azure CLI for this step.

::: zone pivot="csharp"

```csharp
ContainerProperties properties = await container.ReadContainerAsync();
properties.DefaultTimeToLive = -1;

await container.ReplaceContainerAsync(properties);
```

::: zone-end

::: zone pivot="python"

```python
from azure.cosmos import PartitionKey

database.replace_container(
    container=container,
    partition_key=PartitionKey(path="/customerId"),
    default_ttl=-1,
)
```

`replace_container` rewrites the container definition, so it needs the partition key restated as a `PartitionKey` object even though only the TTL setting changes.

::: zone-end

Setting `-1` turns on the feature without imposing a default, which preserves existing items that don't have a `ttl` property. An item that already carries a positive `ttl` value is different. After you enable TTL, the service evaluates that value against the item's existing last-modified timestamp (`_ts`). An item whose lifetime already elapsed can expire immediately. Enabling container TTL doesn't reset `_ts`.

### Setting time to live on an item

With the container gate open, an item expires by carrying a `ttl` property. The cleanest way to set it, and the one that reads identically in both languages, is a patch operation.

::: zone pivot="csharp"

```csharp
await container.PatchItemAsync<CheckoutSession>(
    id: "session-9f21",
    partitionKey: new PartitionKey("cust-2043"),
    patchOperations: new[] { PatchOperation.Set("/ttl", 3600) });
```

::: zone-end

::: zone pivot="python"

```python
container.patch_item(
    item="session-9f21",
    partition_key="cust-2043",
    patch_operations=[{"op": "set", "path": "/ttl", "value": 3600}],
)
```

::: zone-end

More often, you set the value when you first write the item, which means the property belongs on your model.

::: zone pivot="csharp"

The .NET SDK serializes with Newtonsoft.Json by default. Declare the property as a nullable integer and tell the serializer to omit it when it's null, so items that shouldn't expire don't carry a `ttl` at all:

```csharp
public class CheckoutSession
{
    public string id { get; set; }
    public string customerId { get; set; }

    [JsonProperty(PropertyName = "ttl", NullValueHandling = NullValueHandling.Ignore)]
    public int? ttl { get; set; }
}

CheckoutSession session = new()
{
    id = "session-9f21",
    customerId = "cust-2043",
    ttl = 3600
};

await container.CreateItemAsync(session, new PartitionKey(session.customerId));
```

::: zone-end

::: zone pivot="python"

Because the Python SDK works with dictionaries, add the property only when the item should expire:

```python
session = {
    "id": "session-9f21",
    "customerId": "cust-2043",
    "ttl": 3600,
}

container.create_item(body=session)
```

::: zone-end

The countdown restarts on every write to the item. A checkout session with a one-hour TTL that a customer touches every 20 minutes stays alive, and expires an hour after the customer stops. That behavior gives you sliding expiration for free, which is usually what session data wants.

### Exempting an item from a container default

Suppose the Contoso team sets the sessions container to expire everything after 24 hours, but a few sessions belong to long-running business accounts that shouldn't expire at all. Setting `ttl` to `-1` on those items opts them out.

::: zone pivot="csharp"

```csharp
await container.PatchItemAsync<CheckoutSession>(
    id: "session-9f21",
    partitionKey: new PartitionKey("cust-2043"),
    patchOperations: new[] { PatchOperation.Set("/ttl", -1) });
```

::: zone-end

::: zone pivot="python"

```python
container.patch_item(
    item="session-9f21",
    partition_key="cust-2043",
    patch_operations=[{"op": "set", "path": "/ttl", "value": -1}],
)
```

::: zone-end

Removing the `ttl` property entirely has a different effect: the item falls back to the container default rather than becoming permanent.

## Where TTL fits

TTL suits data whose value depends on its age: sessions, caches, tokens, and short-lived event or telemetry records. It doesn't suit data you need to archive, audit, or restore, because expiration is a real delete and the item doesn't move anywhere first. When you need old data to survive in cheaper form, copy it out while it's still inside its TTL window, for example by reading the container's change feed as items are written. Don't treat the change feed as a signal that an item expired: the default latest-version mode doesn't surface expirations at all, and the all-versions-and-deletes mode reports them only after the physical purge.

TTL also isn't a substitute for a partition-wide cleanup. To remove every item for one customer, a dedicated delete-by-partition-key operation does the job in one request instead of stamping thousands of documents individually. That operation runs as a background task capped at roughly 10 percent of the container's throughput in request units per second (RU/s), and it requires the `DeleteAllItemsByPartitionKey` capability on the account, which you enable with the Azure CLI. The operation is still in preview, so confirm its current status before you build on it.

---

> **Guiding question:** Contoso stores idempotency tokens that guard against duplicate checkout submissions, and each token has to remain readable for exactly 24 hours after it's created. TTL restarts its countdown on every write. What would go wrong if the code updated a token's record during that 24-hour window, and how would you keep the expiry anchored to creation time?
