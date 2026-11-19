::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=4bb47b7d-4c3b-46f7-a602-68990263cd7a]

> [!TIP]
> For more information, see the **Text and images** tab.

::: zone-end

::: zone pivot="text"

Contoso pays for capacity that its tenants rarely use outside brief daily peaks. A throughput pool provides shared capacity to handle these peaks.

## How pooled throughput works

Contoso provisions each tenant's catalog container to handle a few thousand request units per second (RU/s). Peak demand lasts only a few minutes each day. During the rest of the day, each container uses a fraction of its provisioned capacity. Across 200 tenants, Contoso pays continuously for capacity that it rarely uses.

In this unit, you learn how to:

- Explain how a pool allocates request units.
- Size and price a pool.
- Identify which accounts can share a pool.
- Confirm that resources use pooled throughput.

Pooling doesn't replace the throughput a container already has. It adds a second, shared allowance on top of it.

### Dedicated request units

Dedicated RU/s are the request units provisioned at the database or container level, exactly as they are on any Azure Cosmos DB account. They're guaranteed, so every resource keeps a floor of performance that no other tenant can take. For autoscale, the dedicated allowance is the autoscale maximum, which is always available.

The entry point for dedicated throughput on a pooled resource is 100 to 1,000 autoscale RU/s. That entry point is the number to have in mind when you size individual tenants: with a pool behind them, containers are provisioned for their *typical* load rather than their peak.

### Pool request units

Pool RU/s are the total request units available within a fleetspace to any resource in any of its accounts. A resource spends its dedicated allowance first. When demand exceeds that allowance, the resource draws from the pool instead of being rate limited, which is the behavior that makes the smaller dedicated sizing safe.

Without a pool, a container that exceeds its provisioned throughput is throttled, and the application sees HTTP 429 responses. With a pool, that same burst is absorbed, up to the limits described later in this unit.

:::image type="content" source="../media/pooled-versus-dedicated-throughput.png" alt-text="Diagram comparing provisioning every tenant for peak throughput against a small dedicated allowance per tenant plus a shared fleetspace pool." lightbox="../media/pooled-versus-dedicated-throughput.png":::

### What a physical partition can draw

The pool is large, but a single physical partition can't consume all of it. Two limits apply, and they compose:

- A physical partition draws up to 5,000 extra RU/s from the pool, on top of its dedicated throughput.
- Combined dedicated and pooled consumption on a physical partition can't exceed 10,000 RU/s. This limit applies even when the pool has available capacity.

So the most a physical partition can consume is the lesser of two numbers: its dedicated throughput plus 5,000, or 10,000. A physical partition holding 1,000 dedicated RU/s reaches 6,000; one holding 8,000 reaches 10,000 rather than 13,000. The first of those limits can be raised with a support ticket.

The consequence for design is that a pool doesn't rescue a hot partition. If one logical partition key takes most of a tenant's traffic, that traffic lands on one physical partition and meets a ceiling far below the pool's size. Pooling smooths uneven demand *across* tenants; it doesn't compensate for uneven demand *within* one. To see how much dedicated throughput each physical partition holds, use the `PhysicalPartitionThroughput` metric in Azure Monitor.

## Size and price a pool

A pool is configured for autoscale by default. You set a minimum and a maximum, and the pool scales between them.

Three rules govern the numbers:

- The minimum is at least 100,000 RU/s and a multiple of 1,000.
- The maximum is at most 10 times the minimum. A minimum of 100,000 RU/s allows a maximum anywhere up to 1,000,000 RU/s.
- The maximum can't be lower than the minimum.

Billing follows the highest RU/s the pool scaled to during each hour, charged for every region the pool is available in. An idle pool is billed at its minimum for each region. Pay particular attention to the pool minimum because you pay for this capacity even when the pool is idle. Unlike a container's autoscale minimum, the pool minimum starts at 100,000 RU/s.

The published example makes the trade-off concrete. Consider a provider with 1,000 tenants. Each tenant has one account and one container. A container's typical load is small, but an active tenant can reach 5,000 RU/s. Without pooling, the provider provisions every container at 5,000 RU/s to handle peak demand. The provider pays for 5,000,000 RU/s in total. With pooling, the containers are provisioned at 100 to 1,000 RU/s and a fleetspace pool of 100,000 to 500,000 RU/s absorbs the spikes. The saving comes from the fact that the tenants don't peak simultaneously.

That last clause is the assumption the whole model rests on. Pooling suits many tenants with different traffic patterns, most of them quiet at any moment. Pooling offers little benefit for workloads with only a few tenants. It also offers little benefit when every tenant is either always idle or always busy. In these cases, the 100,000 RU/s minimum can cost more than provisioning each tenant for peak demand.

## Rules that decide which accounts can share a pool

Throughput pooling requires every account in a fleetspace to have the same regional configuration and the same service tier. Two attributes have to match.

The first is the set of regions. Accounts distributed to different sets of regions can't share a pool, and neither can an account in two regions and an account in one. Pool RU/s aren't shared across regions either, so a multi-region pool is priced per region.

The second is the write configuration, which the fleetspace expresses as a service tier: **General purpose** for single-region write accounts, **Business critical** for multi-region write accounts. An account with multi-region writes and an account with single-region writes can't participate in the same pool.

Some combinations are worth reading twice:

| Configuration | Allowed in one pool |
| :--- | :--- |
| Two accounts with single-region writes, each in a different Azure region | Yes |
| Two accounts with multi-region writes, each in a different Azure region | Yes |
| One account with single-region writes distributed to two regions, plus an account with single-region writes in one region | No |
| Two accounts with global distribution across different sets of regions | No |
| One account with multi-region writes and one account with single-region writes | No |

Because the service tier and the data regions are fixed when the fleetspace is created, these rules are effectively a design exercise you complete before you create anything. Group your accounts by regional configuration and write type first, and create one fleetspace per group.

## Confirm that pooling is doing something

You pay for a pool even when no resources draw from it. Verify that resources use the pool rather than assume they do.

At the fleet level, the `FleetspaceAutoscaledThroughput` metric reports the RU/s the pool scaled to, which is also the quantity you're billed for.

At the account level, Azure Monitor separates the two allowances:

1. Open the Azure Cosmos DB account's **Metrics** page in the Azure portal.
1. Filter to the database and container you're interested in.
1. Select the **Total Requests** metric and split it by **Capacity Type** to see whether requests were served from the pool or from the resource's dedicated throughput.
1. To see how many request units came from each source, select **Total Request Units** and split it the same way.

If the pooled split stays at zero over a representative period, the dedicated allowances are already large enough and the pool isn't earning its minimum. If resources consistently reach their pooled throughput limits, investigate two possible causes. The tenants might need more dedicated throughput. Alternatively, traffic might target too few physical partitions to use the pool's available capacity.

::: zone-end
