Indexing in Azure Cosmos DB for NoSQL is a cost decision before it's a performance decision. The default policy indexes everything, which serves most queries and charges every write, and this module works through the levers that let you fit that trade to a real workload rather than accepting the default.

## What you learned

- An indexing policy sets the indexing mode and the included and excluded paths, and the query engine's five lookup types explain why two indexed queries can differ sharply in cost.
- An opt-out policy suits changing query patterns and an opt-in policy produces the smallest index, and removing a path takes effect immediately while adding one starts an index transformation.
- Composite indexes are required for sorting on two or more properties and reduce the charge on multi-property filters, and spatial indexes are what make the geospatial functions index-served.
- Computed properties move derived query logic into the container definition, where indexing them turns a full scan into an index lookup.
- A global secondary index stores an automatically synchronized copy of a container under a different partition key, at the cost of a 50 to 100 percent surcharge on replaces and deletes in the source.

## Clean up resources

If you created resources for the exercise and didn't finish its cleanup step, delete the Azure Cosmos DB account you created for it. Keep a lab-provided or shared resource group such as `ResourceGroup1`. Delete the whole resource group only if you created it for this exercise and it contains no resources you need to keep.

## Learn more

- [Overview of indexing in Azure Cosmos DB](/azure/cosmos-db/index-overview)
- [Indexing policies](/azure/cosmos-db/index-policy)
- [Manage indexing policies](/azure/cosmos-db/how-to-manage-indexing-policy)
- [Computed properties](/cosmos-db/query/computed-properties)
- [Global secondary indexes](/azure/cosmos-db/global-secondary-indexes)
