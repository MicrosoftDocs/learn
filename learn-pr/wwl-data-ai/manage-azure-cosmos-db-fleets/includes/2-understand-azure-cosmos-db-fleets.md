Contoso's platform team already made the isolation decision, and it was the right one. What they need now is a way to operate the result. This unit describes the resource model Azure Cosmos DB fleets add above the account, so you can explain what a fleet, a fleetspace, and a pool each do, and recognize the workload signals that make a fleet worth adopting.

> [!NOTE]
> Fleet analytics is a preview capability. Preview features are provided without a service-level agreement and aren't recommended for production workloads. Review the [supplemental terms of use for Microsoft Azure previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) before you take a dependency on it.

## Why an account for every tenant becomes hard to run

Account-per-tenant is the strongest isolation Azure Cosmos DB offers. Each tenant gets its own endpoint, its own keys or role assignments, its own regional configuration, and its own throughput, so one noisy tenant can't consume another's request units and a mistake in one tenant's access configuration can't expose another's data.

Two problems appear as the tenant count grows, and both come from the same source: throughput and observability are per-account concepts.

The first is over-provisioning. Throughput is provisioned per container or per database, so each tenant needs enough capacity for its own peak even though tenants rarely peak together. A platform with 1,000 tenants on manual throughput pays for the request units per second (RU/s) it provisions even when tenants are idle. Autoscale can reduce that charge by scaling down, but each throughput resource still has a billed minimum.

The second is fragmented visibility. Azure Monitor metrics and diagnostic logs are scoped to a single account. Answering an estate-wide question, such as which tenants grew fastest this quarter or how much a given tenant costs to serve, means collecting the same data from every account and joining it yourself. That work scales linearly with the tenant count, and it gets worse when the accounts span subscriptions.

Partitioning strategies solve a different problem. Hierarchical and synthetic partition keys let many tenants share one container, which removes the per-account overhead entirely. That approach is the correct choice when tenants are small and the isolation requirement is logical rather than physical. It isn't available to Contoso, because a shared container is precisely what their customers contracted out of. Fleets sit on the other side of that line: they leave each tenant in its own account and add a management layer above.

## The fleet resource model

A fleet introduces three resource types above the account, and the rules that bind them are strict enough to be worth memorizing.

:::image type="content" source="../media/fleet-resource-hierarchy.png" alt-text="Diagram of the hierarchy of one fleet holding two fleetspaces, one with a throughput pool, each holding accounts from different subscriptions." lightbox="../media/fleet-resource-hierarchy.png":::

### Fleet

A fleet is the top-level grouping. It organizes multiple Azure Cosmos DB accounts that can live in different subscriptions and different resource groups, and it's the scope at which fleet analytics aggregates. One fleet corresponds to one multitenant application, which is the sizing rule to apply when you're deciding how many fleets to create: a platform team running two unrelated products creates two fleets, not one fleet with two halves.

A fleet is its own Azure resource with its own region, and that region is metadata about where the fleet resource lives. It doesn't constrain, determine, or change the regions of the accounts inside it.

### Fleetspace

A fleetspace is a logical grouping of accounts *within* a fleet. Every account you enroll in a fleet belongs to a fleetspace, and the relationship is exclusive in both directions: an account belongs to exactly one fleetspace and exactly one fleet. An account that's already registered in a fleetspace has to be removed from it before it can join a different fleet.

The fleetspace is also the boundary at which throughput sharing is configured, which is the practical reason to create more than one. Accounts that share a pool have to match on regional configuration and service tier, so a fleet whose accounts differ on either attribute needs one fleetspace per combination.

### Fleetspace account

A fleetspace account is the registration of an existing Azure Cosmos DB account into a fleetspace. It's a reference, not a copy: the account keeps its own endpoint, its own data, its own role assignments, and its own dedicated throughput. Enrolling an account doesn't move data, change a connection string, or interrupt traffic. When the fleetspace has a pool configured, the account's resources become eligible to draw from it.

### Pools and fleet analytics

Two capabilities hang off this structure, and each gets a unit of its own later in this module.

A **pool** is an optional setting on a fleetspace that defines a quantity of request units per second available to any resource in any account in that fleetspace. Each container keeps its own dedicated throughput and spends it first; the pool is what it reaches for instead of being throttled when demand exceeds that allowance.

**Fleet analytics** exports cost, usage, and configuration data for every account in a fleet, aggregated at an hourly grain, into Microsoft Fabric OneLake or an Azure Data Lake Storage Gen2 account. The exported data is where the estate-wide questions get answered, because for the first time the data for every tenant sits in one queryable dataset.

## Default limits

Three limits shape how you plan a fleet. All three can be raised by filing an Azure support ticket, and all three are worth confirming against the current documentation before you design around them.

| Limit | Default |
| :--- | :--- |
| Database accounts per fleetspace | 3,000 |
| Pool request units per second | 1,000,000 RU/s |
| Pool request units per second a single physical partition can consume | 5,000 RU/s |

The first limit is generous enough that most platforms partition their fleetspaces by region or service tier rather than by count. The third is the one that surprises people, because it caps what any single hot partition can absorb from a large pool, and it's covered in detail alongside pool configuration.

## Deciding whether a fleet fits

Fleets pay off under a specific combination of conditions, and the honest answer for workloads outside that combination is that the added structure isn't worth it.

Adopt a fleet when tenants need account-level isolation for contractual, regulatory, or performance reasons; when the number of accounts is large enough that per-account management is a recurring cost; when those accounts span subscriptions or resource groups, which is where estate-wide reporting is hardest; and when tenant activity is uneven, because uneven activity is what makes shared throughput valuable.

Pooling in particular has a shape it suits. It assumes many tenants with different traffic patterns, most of them quiet at any given moment. A workload with a few tenants, or one where every tenant is either continuously idle or continuously busy, might gain little from a pool. Pool throughput is provisioned and billed separately from dedicated throughput. Resources can't consume another tenant's unused dedicated request units.
