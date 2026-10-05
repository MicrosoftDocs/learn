Contoso's storefront now reads locally in Europe, but every European checkout still writes to West US 2. Enabling writes in more than one region removes that round trip and turns a regional outage from a write outage into a routing change. It also introduces the possibility that two regions change the same item at the same time. In this unit, you enable multi-region writes and learn how the service arbitrates those changes, so that the next unit can cover what to do about them.

## Enable writes in every region

Multi-region writes is an account setting, and turning it on doesn't interrupt the application. In the portal, open **Replicate data globally**, select the **Multi-region writes** checkbox in the **Configuration** section, and confirm. Every read region on the account becomes a read and write region.

The Azure CLI sets the same property:

```azurecli
az cosmosdb update `
    --name "contoso-catalog" `
    --resource-group "contoso-data" `
    --enable-multiple-write-locations true
```

An account created with a single write region can move to multiple write regions later with no downtime, so you don't have to make this decision at creation time.

One capability is lost in exchange. **Strong consistency isn't available with multi-region writes.** A write is acknowledged as soon as it commits locally, and replication to the other regions happens afterward, which is what makes the write fast and what makes conflicts possible. If an account requires a recovery point objective of zero, it requires strong consistency, and therefore a single write region.

:::image type="content" source="../media/write-region-topologies.png" alt-text="Diagram comparing a single write region, which replicates one way, with multi-region writes, where both regions accept writes." lightbox="../media/write-region-topologies.png":::

## Understand the hub region

Multi-region writes doesn't make the regions symmetric. In an account with two or more write regions, the region the account was created in is the **hub region**, and every other region is a **satellite region**. If you remove the hub region, the next region in the order you added them becomes the hub.

That asymmetry is the conflict resolution mechanism. A write arriving in a satellite region is quorum-committed locally and then sent to the hub asynchronously, where the service either resolves a conflict or confirms there wasn't one. Until the hub processes the write, the write is **tentative**, or unconfirmed. Once the hub processes it, the write is **confirmed**. A write that arrives at the hub in the first place is confirmed immediately.

You can see the distinction in the timestamps the service sets on each item:

| Timestamp | Meaning | Where it appears |
| :--- | :--- | :--- |
| `_ts` | The server time at which the item was written in that region | Every read and query response, in every account configuration |
| `crts` | The time a conflict was resolved, or the absence of a conflict confirmed, in the hub region | Change feed responses using the new wire model, which is the default for all versions and deletes mode |

`crts` is what orders changes for the change feed in a multi-region write account: it sets the start time for change feed requests and the sort order of the responses. An item read straight from the container reports `_ts` and nothing more, so a tentative write and a confirmed write look identical to a point read.

## Design the application for local writes

Enabling the setting is a few seconds of work. Getting the benefit takes a client configuration and a traffic pattern that match it.

Point each deployment at its own region:

::: zone pivot="csharp"

```csharp
using Azure.Identity;
using Microsoft.Azure.Cosmos;

string accountEndpoint = "https://<cosmos-account-name>.documents.azure.com:443/";

CosmosClientOptions options = new()
{
    ApplicationRegion = Regions.NorthEurope
};

CosmosClient client = new(accountEndpoint, new DefaultAzureCredential(), options);
```

In the .NET SDK v3, `ApplicationRegion` is the only change the client needs. The SDK reads the account configuration, sees that the account accepts writes in several regions, and routes writes to the named region. It also orders the remaining regions by proximity, so a region added later is picked up without a redeployment.

::: zone-end

::: zone pivot="python"

```python
from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential

ACCOUNT_ENDPOINT = "https://<cosmos-account-name>.documents.azure.com:443/"

client = CosmosClient(
    ACCOUNT_ENDPOINT,
    credential=DefaultAzureCredential(),
    multiple_write_locations=True,
    preferred_locations=["North Europe", "West US 2"],
)
```

The Python SDK needs both arguments: `multiple_write_locations` tells the client that writes may go somewhere other than the primary region, and `preferred_locations` decides where.

::: zone-end

Then keep traffic in its region of origin. The documented guidance reduces to one rule: **traffic that originates in a region stays in that region.** Three patterns break it, and all three raise the conflict rate rather than lowering latency:

- Sending the same write to every region to see which responds first.
- Choosing the target region per request at random.
- Rotating through regions with a round-robin policy.

Two more design points matter once writes are distributed.

**Don't build on replication lag.** An architecture that writes to one region and reads from another depends on how fast replication happens between them, and replication slows during a brief network disruption or a burst of conflict resolution. Reading and writing in the same region keeps performance steady even when the lag grows.

**Pass session tokens for reads only.** Under session consistency, a write carrying a session token from another region forces the receiving region to catch up to that token before it can persist the write. In a single-write-region account, the condition is always satisfied; in a multi-region write account, it adds latency. When you share session tokens between client instances, use them on reads.

Finally, avoid repeatedly rewriting the same item. Short bursts of repeated updates are normal. But when your application updates one document frequently over time, server-side conflict resolution overlaps with those writes and adds latency. When an item changes constantly, writing new documents usually beats updating one in place.

Learn more about [multi-region writes](/azure/cosmos-db/multi-region-writes) and [configuring multi-region writes in your application](/azure/cosmos-db/how-to-multi-master).

Every region now accepts writes, and two of them can change the same item within the replication window. The next unit decides who wins.
