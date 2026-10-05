Indexing policies, composite indexes, and computed properties all improve a query that runs inside one partition, or reduce what a cross-partition query costs. None of them changes the fact that a query filtering on something other than the partition key has to visit every physical partition. The Contoso storefront's stock keeping unit lookup is that query: `product` is partitioned on `/categoryId`, and `sku` appears nowhere in the partition key.

A global secondary index solves that problem by storing a second copy of the data with a different partition key. The index is a read-only container that Azure Cosmos DB keeps synchronized with a source container, and it has its own partition key, indexing policy, throughput, and data model.

## What a global secondary index gives you

The value is that a would-be cross-partition query on the source becomes a single-partition query on the index. Three consequences follow from the design:

- **Writes stay in one place.** Your application writes only to the source container. The service handles the copy, so you avoid the correctness problems of writing the same data to two containers yourself.
- **Performance is isolated.** The index has its own storage and request unit limits, so a heavy read workload on the index doesn't compete with transactional traffic on the source.
- **The index can be shaped for reads.** You choose the partition key, the projection, and the indexing policy independently of the source. You can also create several indexes over one source container.

## Enable the feature and define the index

Global secondary indexes are enabled per account, on the **Features** page under **Settings** in the Azure portal, where the item is named **Global Secondary Index for NoSQL API**.

> [!IMPORTANT]
> The account has to have [continuous backups](/azure/cosmos-db/continuous-backup-restore-introduction) turned on before you can enable global secondary indexes. An account created with the periodic backup policy can be [migrated to continuous mode](/azure/cosmos-db/migrate-continuous-backup). That migration is one way, so treat it as a permanent change to the account rather than a setting you toggle.

Creating an index container looks like creating any other container, with two extra pieces: the source container it derives from, and a query that defines its data model.

```json
{
  "location": "West US 2",
  "properties": {
    "resource": {
      "id": "productBySku",
      "partitionKey": { "paths": [ "/sku" ] },
      "materializedViewDefinition": {
        "sourceCollectionId": "product",
        "definition": "SELECT c.id, c.sku, c.name, c.price, c.categoryId FROM c"
      }
    },
    "options": {
      "autoscaleSettings": { "maxThroughput": 1000 }
    }
  }
}
```

Two naming details explain the property names. `materializedViewDefinition` and the account property `enableMaterializedViews` both carry the feature's former name, so you meet the old term in the management API even though the feature is called a global secondary index everywhere else.

The definition query is constrained, and because the source container and the definition can't be changed after creation, it's worth getting right the first time:

- `SELECT` can project properties from any level of the source item, or use `SELECT *`. Projected properties are flattened to the top level of the index item.
- Aliasing with `AS` isn't supported.
- No `WHERE`, `JOIN`, `DISTINCT`, `GROUP BY`, `ORDER BY`, `TOP`, `OFFSET LIMIT`, or `EXISTS`.
- No system functions and no user-defined functions.

Index containers have to use autoscale throughput, which helps them absorb bursts of change within the configured maximum. Insufficient throughput on the source or the index can still cause throttling and synchronization lag.

One mapping detail catches people the first time they query an index. Each index item maps one to one with a source item, and to maintain that mapping, the index's own `id` is generated for you, while the source item's `id` arrives as `_id`. With `SELECT *`, that mapping happens automatically. With an explicit projection, include `id` if you need it.

> [!NOTE]
> The Azure CLI path shown in the product documentation reaches the management API through `az rest` with a preview API version, and the native `--enable-materialized-views` flag lives in the `cosmosdb-preview` extension. Confirm the current support status of these management surfaces before you build a deployment pipeline on them.

## Understand what synchronization costs

Synchronization runs on the [change feed](/azure/cosmos-db/change-feed). When you define an index, the service creates and manages a change feed job for you, so changes propagate asynchronously and writes to the source aren't held up waiting for the index. The consequence is that an index is **eventually consistent** with its source, whatever consistency level the account is configured for. Design around that behavior: an index is the wrong place to read a value you wrote a moment ago.

:::image type="content" source="../media/global-secondary-index-sync.png" alt-text="Diagram of flow from the application write path through the source container and change feed job into the read-only index container." lightbox="../media/global-secondary-index-sync.png":::

Three costs are worth budgeting for:

- **Change feed reads** consume request units from the source container.
- **Index writes** consume request units from the index container. The throughput you provision on both containers decides how fast data hydrates and how far behind the index runs.
- **A write surcharge on the source.** When a source container has one or more global secondary indexes, replace and delete operations cost extra, because the service persists both the previous and the current version of the item so the change propagates reliably. The surcharge scales with item size and runs from 50 to 100 percent on top of the base write charge. Create operations aren't affected.

That surcharge is the trade at the center of this feature. To turn a fan-out query into a single-partition query, you're paying more on a subset of writes, so the arithmetic depends on your read-to-write ratio and on how often items are replaced rather than created. That single-partition query isn't a point read, which requires an item ID and partition key through the point-read API.

In a multiple-region account with a single write region, the change feed reads and index writes happen in the write region. In an account with multiple write regions, they happen in one of them, and they move with the write region after a failover.

## Monitor and operate the index

Query an index exactly as you query any other container, using the full NoSQL query syntax:

::: zone pivot="csharp"

```csharp
Container index = client.GetDatabase("cosmicworks").GetContainer("productBySku");

FeedIterator<Product> results = index.GetItemQueryIterator<Product>(
    new QueryDefinition("SELECT * FROM c WHERE c.sku = @sku")
        .WithParameter("@sku", "BK-R93R-44"));
```

::: zone-end

::: zone pivot="python"

```python
index = client.get_database_client("cosmicworks").get_container_client("productBySku")

results = index.query_items(
    query="SELECT * FROM c WHERE c.sku = @sku",
    parameters=[{"name": "@sku", "value": "BK-R93R-44"}],
)
```

::: zone-end

Track how far behind the index is running with the **Global Secondary Index Propagation Latency in Seconds** metric in the portal. Splitting that metric by `GlobalSecondaryIndexName` gives you one series per index, and splitting by `GlobalSecondaryIndexStatus` separates the initial build after creation from steady-state operation, which is how you tell whether an index is ready to query.

Four operational habits are worth adopting:

- Choose the index's partition key with the same care as any other container's, and prefer a property that exists in nearly every source item. Items missing the property land under a null value and can push a single logical partition toward its 20-gigabyte limit.
- Project only the properties your queries need. Every extra property costs storage and synchronization request units.
- Tune the index's indexing policy for its own queries. Everything in the earlier units of this module applies to it.
- Delete every index over a source container before you delete the source container.

Learn more about [global secondary indexes](/azure/cosmos-db/global-secondary-indexes) and [how to configure them](/azure/cosmos-db/how-to-configure-global-secondary-indexes).
