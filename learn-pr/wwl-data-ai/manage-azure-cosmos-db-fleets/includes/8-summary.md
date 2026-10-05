Fleets change what a multitenant Azure Cosmos DB estate costs to operate without changing what it guarantees. Every tenant keeps its own account, its own endpoint, and its own isolation, while throughput and reporting move up to a level where one decision covers hundreds of accounts.

## What you learned

- A fleet groups accounts across subscriptions and resource groups. A fleetspace groups accounts within a fleet, and each account belongs to exactly one fleetspace and one fleet.
- Fleet resources have their own `az cosmosdb fleet`, `az cosmosdb fleetspace`, and `az cosmosdb fleetspace account` command groups. Automation can also run through `az resource` or Bicep, and JSON is passed with the `@<file>` convention.
- A pool adds shared request units on top of each resource's dedicated allowance, starts at a minimum of 100,000 request units per second (RU/s), and caps a single physical partition at the lesser of its dedicated throughput plus 5,000 RU/s, or 10,000 RU/s.
- Accounts share a pool only when their regions and their service tier match, and both are fixed when the fleetspace is created.
- Fleet analytics exports hourly cost, usage, and configuration data as Delta Lake tables to Fabric OneLake or Data Lake Storage Gen2, and the usage fact tables need a join to `DimResource` before their numbers name a customer.

## Learn more

- [Fleets overview](/azure/cosmos-db/fleet)
- [Fleet pools](/azure/cosmos-db/fleet-pools)
- [Create a fleet](/azure/cosmos-db/how-to-create-fleet)
- [Fleet analytics](/azure/cosmos-db/fleet-analytics)
- [Enable fleet analytics](/azure/cosmos-db/how-to-enable-fleet-analytics)
- [Fleet analytics schema reference](/azure/cosmos-db/fleet-analytics-schema-reference)
- [Fleets frequently asked questions](/azure/cosmos-db/fleet-faq)
