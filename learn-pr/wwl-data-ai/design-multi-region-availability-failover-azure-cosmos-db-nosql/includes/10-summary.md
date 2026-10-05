Contoso's catalog started this module in one region, with high read latency for most of its customers and no answer to what a regional outage would cost. It ends with a region topology, a client configuration, and a rehearsed failover procedure.

## What you learned

- Azure Cosmos DB offers redundancy at the zone scope and the region scope, and the two settings compose rather than compete.
- Adding regions multiplies provisioned throughput and storage charges by the total region count and buys down recovery time, while recovery point objective follows the consistency level. Multi-region-write accounts also use a different throughput billing rate than single-write-region accounts.
- A preferred region list in the SDK turns a replicated account into a low-latency one, because a client with no preference reads from the primary region.
- Multi-region writes make every region writable, rule out strong consistency, and route conflict arbitration through the account's hub region.
- Conflict resolution is a container policy fixed at creation: last writer wins on a timestamp or numeric path, or custom logic with the conflict feed as the fallback.
- Change write region is the planned operation. Forced failover is the customer-initiated outage operation. Service-managed failover requires no customer action, but the service can take one hour or more to declare the outage and trigger failover.
- Per-partition automatic failover moves only the affected partitions, and requires a supported SDK version on every client instance.

## Learn more

- [Distribute your data globally with Azure Cosmos DB](/azure/cosmos-db/distribute-data-globally)
- [Reliability in Azure Cosmos DB](/azure/reliability/reliability-cosmos-db)
- [Manage an Azure Cosmos DB account in the Azure portal](/azure/cosmos-db/how-to-manage-database-account)
- [Multi-region writes in Azure Cosmos DB](/azure/cosmos-db/multi-region-writes)
- [Conflict types and resolution policies](/azure/cosmos-db/conflict-resolution-policies)
- [Configure per-partition automatic failover](/azure/cosmos-db/how-to-configure-per-partition-automatic-failover)
