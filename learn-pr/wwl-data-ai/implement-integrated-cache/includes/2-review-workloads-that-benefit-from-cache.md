Point operations and queries consume request units (RU/s) when they are performed. In a scenario with a read-heavy workload, you can find your application performing the same point-reads and issuing queries with identical filters many times. Typically, you would multiply the normalized RU cost of each operation and query by the number of times performed. With a sizeable read-heavy workload, this can aggregate to a high cost quickly.

As a developer, it can be tempting to write a custom cache client in code, but you have to consider multiple things:

- First, you must route all requests through your custom cache. You would be responsible for scaling out your cache compute to levels that can keep up with Azure Cosmos DB’s scale
- You will need to handle cache invalidation when items updated or deleted
- You will also need to increase the complexity of operations that create one or more new items

For all of these reasons, an integrated in-memory cache in Azure Cosmos DB is a viable solution. As a developer, you will get the benefits of caching without the complexities of implementing the cache yourself.

For some workloads in Azure Cosmos DB, an integrated cache comes at a great benefit. These workloads include, but are not limited to:

- Workloads with far more read operations and queries than write operations
- Workloads that read large individual items multiple times
- Workloads that execute queries multiple times with a large amount of RU/s
- Workloads that have hot partition key\[s\] for read operations and queries

Workloads that consistently perform the same point read and query operations are ideal to use with the integrated cache. When using the integrated cache, you will only consume request units in the first operation or query. Subsequent requests, as long as the item is not stale, will not consume any request units if the data is retrieved from the cache.
