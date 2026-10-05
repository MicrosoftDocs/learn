You set out to give the Contoso product knowledge base a search box that answers both the shopper who types *helmet* and the shopper who types *something to protect my head*, without adding a second data store to the architecture. Azure Cosmos DB for NoSQL does both natively, against the container that already holds the catalog.

## What you learned

- Full-text search needs a container full-text policy naming the searchable paths and a matching full-text index, and it ranks results with `BM25` through `FullTextScore` in an `ORDER BY RANK` clause.
- A container vector policy fixes the vector path, data type, dimension count, and distance function at creation time, so those four decisions belong in the design rather than in a later migration.
- Vector index type follows the size of the search scope and the dimension count, with `flat` capped at 505 dimensions, `quantizedFlat` suiting scopes up to roughly 50,000 vectors, and `diskANN` scaling beyond that scope.
- `VectorDistance` ranks items by similarity, and a `TOP N` clause, a projection of only the properties you need, and a partition key filter are what keep the request charge proportionate.
- The change feed refreshes embeddings when source text changes, and a stored content hash both prevents needless model calls and stops the consumer from repeatedly processing its own writes.

## Learn more

- [Use full-text search in Azure Cosmos DB for NoSQL](/azure/cosmos-db/gen-ai/full-text-search)
- [Integrated vector store in Azure Cosmos DB for NoSQL](/azure/cosmos-db/vector-search)
- [Indexing policies](/azure/cosmos-db/index-policy)
- [VectorDistance system function](/cosmos-db/query/vectordistance)
- [FullTextScore system function](/cosmos-db/query/fulltextscore)
- [Multitenancy in Azure Cosmos DB](/azure/cosmos-db/multi-tenancy-vector-search)
- [Change feed in Azure Cosmos DB](/azure/cosmos-db/change-feed)

## Clean up resources

If you completed the exercise and no longer need the resources, delete the resource group it created to stop all charges.
