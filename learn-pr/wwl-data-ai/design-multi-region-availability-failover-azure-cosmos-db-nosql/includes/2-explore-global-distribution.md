Before you add a region to Contoso's catalog account, it helps to know what a region buys you. Azure Cosmos DB offers redundancy at two different scopes, and they protect against different failures at different prices. In this unit, you learn how the service replicates data, how zone redundancy and regional redundancy differ, and how to read a replication choice as a statement about recovery objectives and cost.

## Understand how replication works

Every container has a partition key path. The value at that path decides which *physical partition* holds an item inside a region. A physical partition isn't a machine: it's a **replica set**, a group of replicas that the service grows and shrinks on its own, and that maintains quorum so that losing an individual node causes no data loss and needs no change in your application.

When an account spans regions, the replica sets that hold the same partition key values in different regions form a **partition set**. Replication within a region is local distribution; replication between the replica sets of a partition set is global distribution.

:::image type="content" source="../media/replica-partition-sets.png" alt-text="Diagram showing replica sets distributed locally within three regions and grouped vertically into one partition set for global distribution." lightbox="../media/replica-partition-sets.png":::

The direction data flows between those replica sets depends on one account setting. With a single write region, replication is one-way: the write region sends out changes to every read region. With multiple write regions, any region accepts a write and replication runs in every direction, which is why that configuration introduces conflicts and the single-write-region configuration doesn't.

Two consequences follow, and both shape the rest of this module. Adding a region is a configuration change rather than a data migration, so your application doesn't pause or redeploy for it. And because replication between regions is asynchronous for every consistency level except strong, a region can hold data before it reaches the others.

## Compare zone redundancy and regional redundancy

An Azure region is a group of datacenters. **Availability zones** are physically separate groups within one region, with their own power, networking, and cooling. Azure Cosmos DB protects against failure at both scopes, and the two settings are independent.

**Zone redundancy** spreads the replicas of a replica set across availability zones inside a single region. Replication across zones is synchronous, so a zone outage causes no data loss, and the service detects and handles the failure with no action from you. Connections might drop for a few seconds while traffic redistributes, which the SDK's retry behavior absorbs.

Zone redundancy is configured **per region**, not per account, and it's normally set when you add a region. To enable it on a region that already exists, you add a temporary region, move to it, and re-add the original region with zone redundancy switched on. Serverless accounts don't even get that workaround: zone redundancy can only be chosen when the account is created, and an existing serverless account can't be converted.

Zone-redundant regions carry a price premium, but the premium is waived for accounts configured with multi-region writes and for containers using autoscale throughput. For a single-region account, or a single write region with read regions, zone redundancy is usually the cheapest availability improvement available.

**Regional redundancy** is what the rest of this module configures. It protects against the loss of an entire region, which zone redundancy can't do. A single-region account, zone-redundant or not, loses read and write access during a region-wide outage.

The two settings compose. A production account often uses both: several regions, each of them zone-redundant.

## Weigh recovery objectives against cost

Adding regions multiplies the amount of provisioned throughput and storage that is billed. If the throughput configured across the account is `T` and the account spans `N` regions, the total provisioned-throughput quantity is `T × N` request units per second (RU/s). Data and index storage are also billed in each region, and inter-region replication can incur network-transfer charges.

The monetary cost isn’t determined by `T × N` alone. Single-write-region and multi-region-write accounts use different throughput billing rates. Multi-region-write accounts are billed at the multi-region-write rate in every region, so enabling multi-region writes can change both the amount of provisioned throughput billed and the price applied to each throughput unit.

Autoscale follows the same regional replication model. Each region scales within the configured autoscale range, with billing based on the highest RU/s reached during the hour and the autoscale minimum. The applicable single-write or multi-region-write rate is then applied in every region.

Cost buys down two numbers. Recovery time objective (RTO) is how long the application is unavailable. Recovery point objective (RPO) is how much recent data an outage can cost you. Regions and failover configuration determine RTO, which the next units cover. RPO is set by the account's consistency level:

| Consistency level | RPO for a region outage |
| :--- | :--- |
| Session, consistent prefix, eventual | Less than 15 minutes |
| Bounded staleness | *K* versions or *T* time, whichever comes first |
| Strong | 0 |

For accounts spanning multiple regions, the minimum bounded staleness values are 100,000 write operations or 300 seconds. Strong consistency reaches an RPO of zero because a write isn't acknowledged until it commits across regions, which is also why it costs the most write latency and why it isn't available with multi-region writes.

One constraint rules out this whole discussion for some accounts: **serverless accounts run in a single Azure region.** An account that needs regional redundancy needs provisioned throughput, whether manual or autoscale.

Learn more about [distributing data globally](/azure/cosmos-db/distribute-data-globally), [reliability in Azure Cosmos DB](/azure/reliability/reliability-cosmos-db), and [optimizing cost for multi-region deployments](/azure/cosmos-db/optimize-cost-regions).

You know what a region costs and what it protects. The next unit adds one to Contoso's account and points the storefront's reads at it.
