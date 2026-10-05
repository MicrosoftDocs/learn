You set out to close the gap between a search box that returns results and one that answers well. Contoso's shoppers type product names and descriptions of needs into the same box, and Azure Cosmos DB for NoSQL now serves both from one container, with a cost and a relevance figure attached to each query rather than a hope.

## What you learned

- Full-text search ranks on the terms an item contains and vector search ranks on the distance between embeddings, so the query shape and the variation in the indexed text decide which method, or which fusion, a scenario calls for.
- The `RRF` function combines the positions items hold in two or more ranked lists, which is why scores on incompatible scales never need normalizing, and why a weights array biases the fusion positionally rather than by function name.
- A hybrid query includes keyword retrieval, vector retrieval, and fusion work. It needs a query vector, but not a new embedding call when a suitable vector is already available. Measure any embedding-generation call separately from the database request charge and use a fixed evaluation set.
- A global secondary index gives a search workload its own indexing policy, throughput, and partition key, at the price of a 50 to 100 percent surcharge on replace and delete operations against the source container.

## Learn more

- [Use hybrid search in Azure Cosmos DB for NoSQL](/azure/cosmos-db/gen-ai/hybrid-search)
- [RRF system function](/cosmos-db/query/rrf)
- [ORDER BY RANK clause](/cosmos-db/query/order-by-rank)
- [VectorDistance system function](/cosmos-db/query/vectordistance)
- [Global secondary indexes in Azure Cosmos DB](/azure/cosmos-db/global-secondary-indexes)
- [How to configure global secondary indexes](/azure/cosmos-db/how-to-configure-global-secondary-indexes)
- [Integrated vector store in Azure Cosmos DB for NoSQL](/azure/cosmos-db/vector-search)
