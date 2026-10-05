Tuning a query controls what one request costs. It doesn't control what a search workload does to the container that also takes orders. Retrieval traffic is read-heavy and bursty. It wants vector and full-text indexes that transactional writes gain nothing from, and it competes for the same provisioned throughput. In this unit, you move retrieval onto a global secondary index so the two workloads stop sharing a budget.

## Separate the search copy from the source

A global secondary index is a read-only container that Azure Cosmos DB keeps synchronized with a source container. It has its own partition key, its own indexing policy, its own throughput limit, and its own data model, and a single source container can have several of them.

The synchronization is a change feed job that the service creates and manages. Your application writes only to the source container. Writes to the index happen asynchronously, so they don't slow the source write path, and the index is eventually consistent with the source whatever consistency level the account uses.

For a search workload, three of those properties matter more than the rest.

- **Its own indexing policy.** Vector and full-text policies and indexes can live on the index container, so the transactional container doesn't carry them.
- **Its own throughput.** Retrieval spikes draw request units from the index container, not from the container serving order writes.
- **Its own partition key.** A search-oriented key can differ from the transactional one, so queries that would fan out on the source can route to a single partition on the index.

Queries against a global secondary index use the full Azure Cosmos DB for NoSQL query syntax, including full-text, vector, and hybrid queries. The `RRF` ranking clause can stay the same when the index contains the same search paths, but the result projection must match the index's data model.

:::image type="content" source="../media/global-secondary-index-search-isolation.png" alt-text="Diagram of application writes reaching a source container while a change feed job hydrates a search index container that serves hybrid queries." lightbox="../media/global-secondary-index-search-isolation.png":::

> [!NOTE]
> Global secondary indexes are documented without a preview label on their concept and how-to pages, and the portal offers the feature as **Global Secondary Index for NoSQL API**. The documented Azure CLI enablement path uses a preview API version, and the Python SDK marks its global secondary index keyword as provisional. Confirm the release status with the product group before you take a production dependency on the feature.

## Define what the index container holds

Creating a global secondary index looks like creating a container, with two additions: the source container it reads from, and a query that defines its data model.

```json
{
  "id": "productSearchIndex",
  "partitionKey": { "paths": [ "/categoryId" ] },
  "materializedViewDefinition": {
    "sourceCollectionId": "product",
    "definition": "SELECT c.id, c.categoryId, c.name, c.categoryName, c.price, c.searchText, c.embedding FROM c"
  }
}
```

The definition query decides which properties each index item carries. Index containers must use autoscale throughput. Autoscale helps absorb synchronization spikes within its configured maximum, but it doesn't guarantee zero throttling or propagation lag.

The account needs continuous backups turned on before the feature can be enabled. An account created with periodic backups can migrate to continuous mode. That migration is one-way, so continuous backup is a commitment the account makes before any index exists. The feature itself is enabled from the **Features** page in the Azure portal or through the Azure CLI, and creating the index container follows in the portal's Data Explorer or through the REST API. Both paths are covered in [How to configure global secondary indexes](/azure/cosmos-db/how-to-configure-global-secondary-indexes).

### Work within the definition query's limits

The definition query is a projection and little else. It can't contain a `WHERE` clause, and it can't use `JOIN`, `DISTINCT`, `GROUP BY`, `ORDER BY`, `TOP`, `OFFSET LIMIT`, or `EXISTS`. It also doesn't support property aliasing with `AS`, system functions, or user-defined functions.

That last restriction has a direct consequence for search. The definition can't build a searchable string by concatenating properties, and it can't call an embedding model. **Both the searchable text and the embedding have to exist on the source item already, so the definition can project them.** A global secondary index isolates the query workload; it doesn't take over the pipeline that produces the text and the vectors, which stays on the write path.

Three more behaviors belong in the design rather than in the troubleshooting.

- Properties from nested levels are flattened to the top level of the index item, so `c.name.first` arrives as `first`.
- Each index item's `id` is generated, and the source item's `id` appears as `_id`. Project `id` explicitly when the application needs it.
- The source container and the definition query can't be changed after the index is created. Test the query against the source container before you create anything.

To return the same product ID and fields as the earlier hybrid query, use `_id` for the source ID and include `price` in the definition projection:

```sql
SELECT TOP 10 c._id AS id, c.name, c.categoryName, c.price
FROM c
ORDER BY RANK RRF(
  VectorDistance(c.embedding, @queryVector),
  FullTextScore(c.searchText, @term1, @term2))
```

Choose the index partition key with the same care you'd give any container, with one addition: a property missing from some source items produces null values, and those items collect in a single logical partition that runs at the 20-GB limit.

## Weigh the cost of isolation

Isolation moves read cost off the source container, and it adds write cost to it. Both halves of that trade are measurable, so neither has to be a surprise.

Once a source container has at least one global secondary index, replace and delete operations on it carry an extra request unit charge of 50 to 100 percent on top of the base write charge for the item's size. The service persists both the previous and current versions of a changed item so the change propagates reliably. Create operations aren't affected.

Synchronization consumes throughput on both sides. Change feed reads draw request units from the source container, and the writes that hydrate the index draw them from the index container. Throughput provisioned on both containers determines how fast the index keeps up. Insufficient throughput can cause throttling and increase propagation lag.

Storage is duplicated for every property the definition projects, which is the argument for projecting narrowly. A search index that carries the embedding and the searchable text but not the full item description costs less to store and less to synchronize.

That arithmetic decides the fit. A catalog read constantly and updated occasionally gets a large read benefit for a small write surcharge. A container under sustained heavy writes pays the surcharge on every one of them, and the isolation has to be worth the surcharge.

One operational detail belongs in the runbook: a source container can't be deleted while any global secondary index built from it still exists. Delete the indexes first.

## Watch propagation lag

Because the index is eventually consistent, the question that matters in production is how far behind it runs. The **Global Secondary Index Propagation Latency in Seconds** metric answers it, and applying splitting by **GlobalSecondaryIndexName** separates one index from another.

The same metric splits by **GlobalSecondaryIndexStatus**, which distinguishes `InitialBuildAfterCreate` from `Active`. That distinction avoids a common false alarm: a newly created index reports high latency while it hydrates the whole source container, and that number says nothing about steady-state lag.

Two alerts are worth setting up when the index goes live. One on propagation latency crossing a threshold your product can tolerate, and one on any HTTP status code of 400 or greater on the index container, which catches items that fail to write, such as an item whose partition key value exceeds the 2-KB limit. Source writes succeed independently of index writes, so a failure on the index side is silent from the application's point of view unless something watches for it.

Lag also sets a product constraint. An item written to the source container isn't searchable until it propagates. If a user has to find something they just created, retrieval from an index container is the wrong design for that path, and the query belongs on the source.

In this unit, you learn how to isolate search functionality using global secondary indexes in Azure Cosmos DB for NoSQL. You see how to evaluate the throughput and storage implications, monitor propagation lag, and set up alerts to maintain operational awareness.
