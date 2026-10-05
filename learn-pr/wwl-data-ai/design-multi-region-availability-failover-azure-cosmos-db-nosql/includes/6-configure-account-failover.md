Contoso's catalog now spans two regions, and the operations team still can't answer the original question: if a region goes offline, what happens, and who does what. Azure Cosmos DB offers three account-level failover operations, and they aren't interchangeable. One of them doesn't work during an outage at all, and the other two differ substantially in how quickly they restore writes. In this unit, you learn which operation to use, configure the failover priorities used by forced and service-managed failover, and rehearse the outage procedure.

## Set the failover priorities first

When the write region fails over in a single-write-region account, a read region becomes the new write region. The account's **failover priorities** determine the order of promotion. Taking only a read region offline doesn't change the write region. Priority `0` is the current write region. Read regions carry positive, unique values, and the lowest one is promoted first.

In the portal, open **Replicate data globally** and select **Configure failover policy**, then drag the read regions into the order you want. In the Azure CLI, the priorities are set as a set:

```azurecli
az cosmosdb failover-priority-change `
    --name "contoso-catalog" `
    --resource-group "contoso-data" `
    --failover-policies westus2=0 northeurope=1 japaneast=2
```

Every region on the account has to appear. Every value has to be unique, and exactly one region has to hold `0`. Set these values deliberately: the second-priority region inherits the write traffic during an outage, so it needs the throughput headroom and the network access to carry it.

## Choose the right failover operation

The three operations differ in who starts them, how long they take, and what they cost you in data.

:::image type="content" source="../media/failover-operations.png" alt-text="Diagram routing a healthy account to change write region, and a region outage to forced or service-managed failover." lightbox="../media/failover-operations.png":::

**Change write region** is the planned operation. You choose a new write region while every region is healthy. Replication catches up before the promotion happens, and **no data is lost**. Clients might see a brief interruption that ordinary retry logic absorbs. It's the operation for moving the write region closer to a shifting user base, and for rehearsing the promotion path.

It has one hard restriction, and it's the one people get wrong: **change write region requires the regions to be healthy, so it can't be used during an outage.** The operation runs a consistency check that needs connectivity between the source and destination regions, and that check fails when a region is down.

**Forced failover**, called **Offline region** in the portal, is the outage operation. You take the affected region offline, and the read region with the highest failover priority becomes the new write region. It completes in seconds, and you decide when to run it, which makes it the fastest way to restore write availability. The cost is that **any writes that hadn't replicated out of the offline region can be lost**, unless the account uses strong consistency.

```azurecli
az cosmosdb offline-region `
    --name "contoso-catalog" `
    --resource-group "contoso-data" `
    --region "West US 2"
```

**Service-managed failover** hands the decision to Microsoft. Enable it in advance, and the service detects a write region outage and promotes the next region by priority without you doing anything:

```azurecli
az cosmosdb update `
    --name "contoso-catalog" `
    --resource-group "contoso-data" `
    --enable-automatic-failover true
```

> [!NOTE]
> The Azure CLI flag is still named `--enable-automatic-failover`, and the portal and the documentation now call the capability service-managed failover. They configure the same setting.

The convenience comes with a number worth planning around: **declaring an outage and triggering the failover can take an hour or more.** Service-managed failover is a fallback for an unattended account, not a fast recovery path. When write availability matters and you're watching, a forced failover restores it in seconds instead.

| Attribute | Change write region | Forced failover | Service-managed failover |
| :--- | :--- | :--- | :--- |
| Who starts it | You | You | Microsoft |
| Safe during an outage | No | Yes | Yes |
| Time to complete | Replication catches up first, then a brief interruption | Seconds | An hour or more, including detection |
| Possible data loss | None | Unreplicated writes | Unreplicated writes |

An account with multiple write regions sits outside this table. Every region already accepts writes, so the SDK reroutes around an unhealthy region on its own and no account-level failover is needed.

## Know what an outage does before you act

The behavior during an outage depends on which region failed.

The client usually handles a **read region outage** entirely. The SDK detects it through backend response codes, marks the region unavailable, and moves reads to the next region in the preferred list without any service-side operation. Two consistency levels are exceptions: an account using **strong** consistency with only two regions loses the dynamic quorum it needs, and an account using **bounded staleness** loses write availability once the outage exceeds its staleness threshold. In both cases, you take the affected region offline to restore writes.

For a single-write-region account without per-partition automatic failover, a **write-region outage** stops writes until forced or service-managed failover promotes another region. Reads continue from healthy regions. When per-partition automatic failover is enabled and its prerequisites are met, affected partitions can automatically fail over without an account-level promotion.

Microsoft doesn't notify you when a region goes down. Configure [Azure Resource Health](/azure/service-health/resource-health-overview) alerts for the account and [Azure Service Health](/azure/service-health/overview) alerts for the service, because the outage is yours to detect.

> [!WARNING]
> Don't run control plane operations against an affected region during an outage. Changing the write region, editing failover priorities, switching to multi-region writes, changing consistency, updating network or private endpoint settings, or scaling throughput all leave the account in an inconsistent state and delay recovery.

## Bring the region back

Recovery isn't automatic, and it's the step most often missed.

Returning an offline region isn't immediate. After an actual outage, Microsoft automatically restores a healthy region to online status, but the process can take **several days**. If the region doesn't return within a day or two, open a support case. If you intentionally took a healthy region offline for a disaster-recovery drill, open a support request to bring it back online.

When the region returns, it comes back as a **read region**. **It isn't promoted back to write region automatically.** Once you're satisfied it's healthy, run a change write region operation to move writes back, which is safe and loses no data.

Then drain the conflict feed. Writes that never replicated out of the failed region are surfaced there when it rejoins, and reading, reconciling, and rewriting them is how you recover the data a forced failover put at risk. The code you wrote in the previous unit does a job that has nothing to do with concurrent writes.

To rehearse the failover procedure, temporarily disable service-managed failover, run a forced failover, and watch how the application behaves. Restore the setting afterward.

Learn more about [managing an account in the Azure portal](/azure/cosmos-db/how-to-manage-database-account) and [resilience to region-wide failures](/azure/reliability/reliability-cosmos-db).

Each of these operations moves the whole account. The next unit narrows the unit of failover to a single partition.
