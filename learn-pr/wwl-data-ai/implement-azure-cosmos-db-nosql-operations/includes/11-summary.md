In this module, you built the data layer for the Contoso order service with the Azure Cosmos DB SDK, choosing each operation for what it costs and guarantees rather than the first one that works.

## What you learned

- A point read fetches an item by `id` and partition key. A 1-KB item costs about 1 request unit (RU) under the default session consistency. Use a point read whenever your code knows both values.
- Create rejects duplicates with 409, replace requires an existing item, and upsert does either. Suppressing the response payload saves bandwidth at no RU cost.
- Patch sends up to 10 operations rather than a whole document, with an optional filter predicate for conditional updates.
- Time to live expires items automatically: the container value is the gate, an item `ttl` overrides it, and `-1` exempts an item.
- Optimistic concurrency uses `_etag` as a write precondition, returning 412 on mismatch so your code re-reads, retries, or avoids the conflict entirely with a patch increment.
- A transactional batch commits up to 100 operations atomically within one logical partition. When one operation fails, the rest report 424.
- Bulk execution trades atomicity for throughput, grouping independent operations into fewer requests for background ingest. The .NET SDK provides it as a client setting, and Python approximates it with the async client.

## Learn more

- [Partial document update in Azure Cosmos DB](/azure/cosmos-db/partial-document-update)
- [Get started with partial document update](/azure/cosmos-db/partial-document-update-getting-started)
- [Time to live in Azure Cosmos DB](/azure/cosmos-db/time-to-live)
- [Configure time to live in Azure Cosmos DB for NoSQL](/azure/cosmos-db/how-to-time-to-live)
- [Transactions and optimistic concurrency control](/azure/cosmos-db/database-transactions-optimistic-concurrency)
- [Transactional batch operations in Azure Cosmos DB](/azure/cosmos-db/transactional-batch)
- [Bulk import data to Azure Cosmos DB for NoSQL with the .NET SDK](/azure/cosmos-db/tutorial-dotnet-bulk-import)
- [Best practices for the Azure Cosmos DB Python SDK](/azure/cosmos-db/best-practice-python)

## Clean up resources

If you created an Azure Cosmos DB account for the exercise and no longer need it, delete its resource group in the Azure portal to stop incurring charges.
