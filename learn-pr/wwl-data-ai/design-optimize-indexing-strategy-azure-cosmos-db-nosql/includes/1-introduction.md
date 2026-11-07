::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=34893021-7d5a-4f59-b71b-9576e2ee9dcb]

::: zone-end

::: zone pivot="text"

Every container in Azure Cosmos DB for NoSQL indexes every property of every item by default. That default is a deliberate trade: you get good query performance on day one without designing an index, and you pay for it on every write, because every indexed path the write touches has to be updated along with the item. On a small catalog, nobody notices. On a container taking thousands of writes a second, index maintenance becomes a significant share of the request unit bill, and one of the few parts of it you control.

Contoso runs a product catalog on Azure Cosmos DB for NoSQL, partitioned on `/categoryId`. The storefront reads the catalog constantly, and a pricing job rewrites it nightly, so the container carries both a read-heavy and a write-heavy workload at the same time. Two problems reached you at the same time. The nightly job costs more request units than the team budgeted, and most of the index it maintains serves no query anyone runs. Separately, the storefront looks up products by stock keeping unit, a property that isn't the partition key, so every one of those lookups fans out across every physical partition.

This module works through the levers that fix both. You start with what an indexing policy controls and how the query engine uses the index it produces. You then tune a policy for a read-heavy and a write-heavy mix, add composite and spatial indexes for query shapes that a range index can't serve, and move repeated query logic into computed properties that you can index. You finish with global secondary indexes, which store a second copy of the data under a different partition key so a cross-partition query becomes a single-partition one.

By the end of this module, you can design an indexing strategy for an Azure Cosmos DB for NoSQL container that matches its workload, and measure what each change costs.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
