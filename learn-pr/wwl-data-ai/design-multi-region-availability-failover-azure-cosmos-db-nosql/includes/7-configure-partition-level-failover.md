Every failover in the previous unit moves the entire account. An account-level failover is a blunt response to a failure that's often narrower: Azure Cosmos DB spreads a container across many physical partitions, and infrastructure problems frequently affect some of them and leave the rest serving traffic normally. Per-partition automatic failover (PPAF) fails over only the affected partitions, which is how Contoso's catalog stays writable through a partial region failure. In this unit, you check whether an account qualifies, enable PPAF, configure the client for it, and rehearse it with an injected fault.

## Understand what PPAF changes

PPAF applies to single-write-region accounts. When the service detects a problem with the infrastructure behind a partition, it promotes that partition's write role to a secondary region and leaves the healthy partitions writing in the primary region. Recovery is typically around **three minutes**, with no manual intervention and no application code change.

Compare PPAF against the account-level options for the same partial failure. Service-managed failover waits for an outage declaration that can take an hour, and then moves everything. A forced failover is fast, but you have to notice the problem first, and it also moves everything. PPAF moves only what's broken, and it does it without you.

:::image type="content" source="../media/partition-level-failover.png" alt-text="Diagram contrasting an account-level failover moving all four partitions with per-partition failover moving only one." lightbox="../media/partition-level-failover.png":::

PPAF and account-level failover cover different failures rather than competing. Keep the failover priorities configured, because PPAF uses them to choose which region hosts a failed-over partition next. One account-level failover operation is blocked while PPAF is enabled: you can't take a region offline. Disable PPAF, run the forced failover, then enable it again.

Data durability follows the account's consistency level, exactly as it does for an account-level failover. With strong consistency, no data is lost. Without it, writes that hadn't replicated out of the affected partition could be lost if that region suffers permanent data loss.

PPAF also has a narrow role in read region outages. It normally doesn't apply, with one exception: an account using strong consistency with only two regions can't maintain dynamic quorum when it loses one, and PPAF activates to shift the affected partitions to the healthy region.

## Check the prerequisites

PPAF has more requirements than any other setting in this module, and enabling it against an account that doesn't meet them causes the failures it exists to prevent.

| Requirement | Value |
| :--- | :--- |
| Account topology | A single write region with at least 1 read region |
| API | API for NoSQL |
| Consistency | Strong, session, consistent prefix, or eventual. |
| Throughput | Provisioned, either manual or autoscale. Serverless accounts aren't supported |
| Region | The account must be in a global Azure region |
| Connection mode | Direct |
| SDK | .NET SDK v3 3.62.0 or later, Java SDK 4.79.0 or later, Python SDK 4.16.0 or later, or Node.js SDK 4.7.0 or later |

> [!NOTE]
> Per-partition automatic failover doesn't currently support bounded staleness consistency.

The SDK floor is the requirement that surprises teams, because it applies to **every** application instance connecting to the account, not to a majority of them. An instance on an older SDK doesn't understand a partition-level failover and can keep sending writes to a region that no longer owns the partition, which produces failed writes during exactly the event PPAF was meant to survive. Inventory the clients before you enable it.

PPAF is part of the Business Critical service tier and is charged accordingly. Check [Azure Cosmos DB pricing](https://azure.microsoft.com/pricing/details/cosmos-db/) before enabling it on an account you care about the bill for.

## Enable PPAF and configure the client

Enable it in the portal from the account's **Features** pane under **Settings**. Select **Per-partition automatic failover**, review the prerequisites the pane lists, and switch it to **Enable**. The Azure CLI and Azure PowerShell also configure it.

On the client side, two settings matter. Upgrade every instance to a supported SDK version, and make sure the account has at least one secondary region, which is already true if the account met the prerequisites.

Enabling PPAF automatically switches on the per-partition circuit breaker. Cross-region hedging is a separate, optional client strategy that must be configured explicitly.

**Per-partition circuit breaker** tracks failures per partition on the client. After a run of `408` and `5xx` responses on one partition, the client routes that partition's reads to another region without waiting for a service-side signal. Writes stay with the region PPAF elects. In the Python SDK, the thresholds are environment variables, defaulting to 10 consecutive read errors, 5 consecutive write errors, or a 90 percent failure rate.

**Cross-region hedging** is an opt-in strategy that sends a duplicate read request to another region when the first region doesn't answer within a configured threshold and uses whichever response arrives first. It trades extra request volume and request-unit charges for lower tail latency. PPAF doesn't enable hedging automatically. In the Python SDK, setting availability_strategy=True uses the default 500-ms threshold and 100-ms steps; alternatively, provide explicit thresholds as shown:

::: zone pivot="python"

```python
from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential

client = CosmosClient(
    ACCOUNT_ENDPOINT,
    credential=DefaultAzureCredential(),
    preferred_locations=["West US 2", "North Europe"],
    availability_strategy={"threshold_ms": 300, "threshold_steps_ms": 100},
)
```

You can also set `availability_strategy` per request, including `False` to turn off hedging for an operation where the extra request isn't worth the cost.

::: zone-end

::: zone pivot="csharp"

The .NET SDK offers the same capability as its threshold-based availability strategy. Configure it on `CosmosClientOptions` alongside the region preferences you already set, and treat the threshold as a tuning value: a lower threshold hedges more aggressively and issues more requests, and a higher one is more conservative and does less for tail latency.

::: zone-end

## Rehearse it with an injected fault

PPAF is one of the few availability features you can test without waiting for a real outage. Azure Cosmos DB exposes a partition failure simulation through its representational state transfer API, and the product group publishes a PowerShell wrapper, `EnableDisableChaosFault.ps1`, in the [ppaf-samples repository](https://github.com/AzureCosmosDB/ppaf-samples).

Running it with `-Enable` injects a fault into a sample of the container's partitions: 10 percent, with a floor of one partition and a ceiling of 10. The simulation takes up to 15 minutes to take effect, and the same script with `-Disable` stops it, taking up to another 15 minutes.

While the fault is active, exercise the application's critical transactions and watch two values in the portal's **Metrics** pane. **Total Requests**, split by region, should show writes appearing in the secondary region. A metric named **PartitionWriteGlobalStatus** reports how many write partitions each region holds, which tells you exactly how many partitions failed over.

That combination, a real failover on a subset of partitions with the application running against it, is the closest match to a regional outage you can arrange on purpose.

Learn more about [configuring per-partition automatic failover](/azure/cosmos-db/how-to-configure-per-partition-automatic-failover) and [designing resilient applications with Azure Cosmos DB SDKs](/azure/cosmos-db/conceptual-resilient-sdk-applications).
