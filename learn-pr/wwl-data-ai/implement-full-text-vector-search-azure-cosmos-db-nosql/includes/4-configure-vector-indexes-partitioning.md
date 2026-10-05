A vector policy makes similarity queries possible. A vector index makes them affordable. Without one, each query performs a brute-force comparison against every eligible vector after partition routing and filters are applied. The request charge grows with the size of that candidate set. In this unit, you choose an index type for the size of your data, tune the build when the defaults aren't enough, and decide how the container is partitioned so that queries touch as little of it as possible.

## Choose a vector index type

Three index types are available, and the choice is a trade between recall, latency, and cost.

| Type | Search | Maximum dimensions | Suits |
| :--- | :--- | :--- | :--- |
| `flat` | Brute force, 100 percent recall | 505 | Small corpora, or any case that has to return the exact nearest neighbors |
| `quantizedFlat` | Brute force over compressed vectors | 4,096 | Up to roughly 50,000 vectors in the search scope, especially with selective filters |
| `diskANN` | Approximate nearest neighbor | 4,096 | More than roughly 50,000 vectors in the search scope |

:::image type="content" source="../media/vector-index-selection.png" alt-text="Diagram selecting a vector index type from dimension count, corpus size, and whether exact recall is required." lightbox="../media/vector-index-selection.png":::

The dimension limit decides the question before anything else does. A `flat` index holds at most 505 dimensions, so a 1,536-dimension embedding rules it out regardless of how small the corpus is.

Above that limit, size decides. `quantizedFlat` compresses each vector before storing it, then still compares the query against all of them, so its accuracy is near but not exactly 100 percent and its cost stays proportional to the number of vectors it scans. `diskANN` builds a separate graph index and traverses it, so its cost grows far more slowly, at the price of returning most of the relevant results rather than provably all of them.

> [!IMPORTANT]
> Both `quantizedFlat` and `diskANN` need at least 1,000 vectors before the index is useful. Below that, the engine runs a full scan instead, which returns correct results at a higher request charge. A lab-sized container of a few hundred items always takes that path, so don't read its request charges as representative of production.

You add the index to the same indexing policy that holds your included and excluded paths, and you exclude the vector path itself.

```json
{
    "indexingMode": "consistent",
    "automatic": true,
    "includedPaths": [
        { "path": "/*" }
    ],
    "excludedPaths": [
        { "path": "/\"_etag\"/?" },
        { "path": "/embedding/*" }
    ],
    "vectorIndexes": [
        { "path": "/embedding", "type": "diskANN" }
    ]
}
```

Excluding `/embedding/*` matters more than it looks. Without the exclusion, the standard index treats the vector as 1,536 indexable numbers and writes an entry for each one, which raises the request charge and the latency of every insert while contributing nothing to any query. The vector index is the only index a vector needs.

## Tune the index build

The defaults are reasonable, and two optional settings exist for when they aren't.

- `quantizationByteSize` sets how many bytes each vector is compressed to. The minimum is 1, the maximum is 512, and the system chooses the default. Raising it improves accuracy and raises request charge and latency. It applies to `quantizedFlat` and `diskANN`.
- `indexingSearchListSize` sets how many vectors are examined while the index is built. The minimum is 10, the maximum is 500, and the default is 100. Raising it improves search accuracy at the cost of longer build times and slower ingestion. It applies to `diskANN` only.

A `quantizerType` setting controls the compression method. The default, `product`, provides balanced performance and accuracy for most workloads. The alternative, `spherical`, can reduce quantization time and may provide higher, more stable recall for very high-dimensional embeddings.

```json
{
    "vectorIndexes": [
        {
            "path": "/embedding",
            "type": "diskANN",
            "quantizerType": "spherical",
            "indexingSearchListSize": 200
        }
    ]
}
```

Use these settings only after you measure. Retrieval quality is usually lost in how the text was chunked and which model embedded it, and no index parameter recovers meaning the embedding never captured.

### Expect approximate results to vary

`diskANN` performs approximate search, so a query against an unchanged container can return a slightly different ordering from one run to the next. Each replica builds its own copy of the vector index, and any replica can answer a query. That variation is expected behavior rather than a symptom.

The practical consequence is for testing. An assertion that the same query returns the same ordered list of identifiers is a flaky test against an approximate index. Instead, evaluate whether expected items appear in the top results and measure recall against a known result set. If you need exact nearest-neighbor calculations, use flat when the vector dimensions permit, or force a brute-force comparison at query time. Exact calculations still don't guarantee a consistent order between items with equal scores.

Vector indexes also assume realistic embeddings. They rely on the geometric structure that a trained model produces, so a corpus of randomly generated vectors measures nothing useful about recall.

## Partition a vector container

Partitioning a vector container is the same discipline as partitioning any other container, with one added consequence: the partition key decides how many vectors a filtered query has to consider.

A query that supplies the complete partition key value targets one logical partition, which is hosted on one physical partition. The vector comparison is therefore limited to the eligible vectors in that logical partition rather than the entire container. Index selection should therefore consider the size of each query's search scope, not only the size of the container. For example, a container might hold 1,000,000 vectors while each tenant-scoped query searches only 20,000. That workload is a candidate for `quantizedFlat` rather than `diskANN`, subject to performance and recall testing.

For multitenant retrieval, partition-key-per-tenant and account-per-tenant models provide different levels of isolation. A shared container with a tenant partition key provides logical isolation, high tenant density, and lower management overhead. A separate account provides stronger performance and security isolation and supports account-level configuration for each tenant, but requires more resources to manage. Consider isolating a tenant in its own account when its workload creates sustained contention or it requires independent performance, security, or account-level settings.

### Add levels with hierarchical partition keys

When a single tenant exceeds the 20-gigabyte logical partition limit, a hierarchical partition key extends the model rather than replacing it. Contoso could partition on tenant, then department, then item identifier. A tenant-only filter routes the query to the subset of physical partitions holding that tenant's data, which can include several partitions. Supplying the full hierarchical key targets a single logical partition.

Two rules govern the shape. The lowest level needs high cardinality, which is why an item identifier or globally unique identifier belongs there, and a first level with few distinct values concentrates writes on the same physical partitions and creates the bottleneck the hierarchy was meant to prevent.

> [!NOTE]
> Running vector search against a container with hierarchical partition keys requires the Azure Cosmos DB team to configure the account so the search uses the partitioning scheme. Request that configuration at `cosmossearch@microsoft.com` before you commit a design to it.

One more operational consideration is initial ingestion. Inserting more than approximately 5,000,000 vectors in a short period can extend index-build time. Pace and monitor large initial loads, and allow the vector index to become ready before relying on production query performance.
