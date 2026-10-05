Contoso's catalog account runs in West US 2, and most of the storefront's customers are in Europe. Reads cross an ocean on every page load. In this unit, you add a European region to the account and configure the SDK so that clients running in Europe read from it, which is the change that turns a second region from an insurance policy into a latency improvement.

## Add and remove regions

Adding a region is an account-level operation you can run at any point in the account's life. In the Azure portal, open the account's **Replicate data globally** pane and select **Manage regions**. Choose a region from the dropdown, select the **Availability zone** checkbox if you want the new region to be zone-redundant, and select **Add**.

The Azure CLI does the same through `az cosmosdb update`:

```azurecli
az cosmosdb update `
    --name "contoso-catalog" `
    --resource-group "contoso-data" `
    --locations regionName="West US 2" failoverPriority=0 isZoneRedundant=True `
    --locations regionName="North Europe" failoverPriority=1 isZoneRedundant=True
```

The `--locations` argument describes the account's complete region list rather than adding to it, so list every region you intend to keep. Each entry sets three properties: the region, its **failover priority**, and whether it's zone-redundant. Priority `0` is the write region in a single-write-region account. The priorities you assign here are the order the service uses when it promotes a new write region, which the failover units return to.

Two timing behaviors matter when you update the region list for a real account. A new region isn't marked available until every existing item replicates into it and commits, so the operation takes longer for larger accounts. And if a throughput scaling operation is running, it pauses and resumes automatically once the region change completes.

Removing a region uses the same command with the region left out of the list, or the delete icon in the **Manage regions** pane. One restriction applies: **in single-write-region mode, you can't remove the write region.** You change the write region first, then remove the region that used to hold it. In multi-region write mode, you can remove any region, as long as one remains.

## Route reads with a preferred region list

Adding a region gives the account a replica in Europe. It doesn't move any traffic there. Region selection is a client decision, and the SDK makes it from a list you supply.

If you set no preference at all, the client sends every read and every write to the account's **primary region**, which is the first region in the account's region list. A European client against Contoso's account would keep reading from West US 2, and the new region would sit idle while being billed.

Set a prioritized list instead. The client intersects your list with the regions the account has, keeps your ordering, and connects to the first entry:

::: zone pivot="csharp"

```csharp
using Azure.Identity;
using Microsoft.Azure.Cosmos;

string accountEndpoint = "https://<cosmos-account-name>.documents.azure.com:443/";

CosmosClientOptions options = new()
{
    ApplicationPreferredRegions = new List<string>
    {
        Regions.NorthEurope,
        Regions.WestUS2
    }
};

CosmosClient client = new(accountEndpoint, new DefaultAzureCredential(), options);
```

The `Regions` static class carries a string property for each Azure region, which keeps a typo from silently becoming an ignored region. Setting `ApplicationRegion` instead of `ApplicationPreferredRegions` names a single region and lets the client order the remaining regions by proximity to it.

::: zone-end

::: zone pivot="python"

```python
from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential

ACCOUNT_ENDPOINT = "https://<cosmos-account-name>.documents.azure.com:443/"

client = CosmosClient(
    ACCOUNT_ENDPOINT,
    credential=DefaultAzureCredential(),
    preferred_locations=["North Europe", "West US 2"],
)
```

Region names are matched tolerantly for differences in case, spacing, hyphens, and underscores, so `"North Europe"` and `"northeurope"` both resolve.

::: zone-end

Deploy the same code to several regions and change only the list, so that each deployment prefers the region it runs in. That single difference is what turns a replicated account into a low-latency one.

Three behaviors of this list are worth knowing before you rely on it.

**Entries the account doesn't have are ignored.** Listing a region the account isn't replicated to costs nothing, and if you add that region later, the client starts using it. The client rereads the account configuration every five minutes, so region additions and removals take effect without a restart.

**The write region is always the fallback.** If every region in your list is unavailable, reads fall back to the account's current write region. A list of `["North Europe", "West US 2"]` against an account whose write region is West US 2 behaves the same as a list naming only North Europe.

**Writes ignore the list in a single-write-region account.** Reads follow your preference; writes go to the write region regardless. Only an account with multiple write regions lets the list steer writes, which is the subject of the next unit.

## Keep the routing logic on

Every SDK exposes a switch that disables endpoint discovery and pins the client to the endpoint supplied to its constructor. In .NET, set `LimitToEndpoint = true`. In Python, set `enable_endpoint_discovery=False`. These settings turn off region preference, cross-region retries, and automatic rerouting during an outage.

That switch exists for applications that implement their own availability handling, and it's a poor default. Disabling endpoint discovery means the client can't route around a region that stops responding, which removes most of the value of the regions you're paying for.

Learn more about [adding and removing regions](/azure/cosmos-db/how-to-manage-database-account#add-or-remove-regions-from-your-database-account) and [SDK availability behavior in multiregional environments](/azure/cosmos-db/troubleshoot-sdk-availability).

Reads now come from Europe. Writes still cross the ocean, and the next unit changes the write path.
