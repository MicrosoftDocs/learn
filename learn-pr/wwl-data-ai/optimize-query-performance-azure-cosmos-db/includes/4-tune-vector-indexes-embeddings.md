AI applications that store embeddings need vector indexes to perform efficient similarity searches. Vector indexes are a specialized index type that accelerates queries using the `VectorDistance` system function. Selecting the right vector index type for your workload affects query latency, accuracy, and RU consumption. This unit teaches you how to choose and configure vector indexes as part of your overall indexing strategy, focusing on selection criteria and integration with other index types.

> [!NOTE]
> The previous module in this learning path covers container creation with vector policies, distance function selection, and vector search query syntax in detail. This unit focuses on selecting the right vector index type for your workload and integrating vector indexes into a comprehensive indexing policy.

## Understand vector indexes in the indexing policy

Vector indexes work alongside range, composite, and spatial indexes within the same indexing policy. While other index types support property filtering and sorting, vector indexes specifically accelerate similarity queries that find items with embeddings closest to a query vector.

Before you can add a vector index, you must define a vector policy for the container that specifies the embedding properties. The vector policy includes the path, data type, dimensions, and distance function for each embedding property. The vector index then references these paths to create optimized data structures for similarity search.

The following example shows how vector indexes fit within a complete indexing policy:

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    { "path": "/category/?" },
    { "path": "/createdDate/?" },
    { "path": "/documentType/?" }
  ],
  "excludedPaths": [
    { "path": "/*" },
    { "path": "/embedding/*" }
  ],
  "compositeIndexes": [
    [
      { "path": "/category", "order": "ascending" },
      { "path": "/createdDate", "order": "descending" }
    ]
  ],
  "vectorIndexes": [
    { "path": "/embedding", "type": "diskANN" }
  ]
}
```

This policy demonstrates several important principles. The embedding path is explicitly excluded from `includedPaths` to prevent range indexing of the embedding array. The `vectorIndexes` section defines a diskANN index for the embedding property. Range and composite indexes support metadata filters that can narrow down results before or alongside vector search.

## Select the appropriate vector index type

Azure Cosmos DB offers three vector index types, each optimized for different dataset sizes and accuracy requirements. Understanding the trade-offs helps you select the right type for your AI application.

### Flat index for small datasets

The flat index performs brute-force k-nearest neighbor search, comparing the query vector against every indexed vector. This approach guarantees 100% accuracy because it evaluates all vectors without approximation.

**When to use flat indexes:**

- Small datasets where the vector count per physical partition is modest
- Scenarios where query filters significantly reduce the search space before vector comparison
- Applications requiring guaranteed accuracy where approximate results aren't acceptable

**Limitations:**

- Maximum of 505 dimensions per vector
- Higher latency and RU consumption for large datasets because every vector is compared

Flat indexes work well for applications where metadata filters narrow the candidate set to a manageable size before vector comparison. For example, if users always filter by category and each category has only a few hundred documents, flat indexes provide accurate results efficiently.

### QuantizedFlat index for medium datasets

The quantizedFlat index compresses vectors using quantization before storing them in the index. Quantization reduces storage requirements and improves query throughput at the cost of slight accuracy reduction.

**When to use quantizedFlat indexes:**

- Medium datasets with roughly 1,000 to 50,000 vectors per physical partition
- Applications where slight accuracy reduction is acceptable for better performance
- Scenarios combining metadata filters with vector search to reduce candidate sets

**Characteristics:**

- Supports up to 4,096 dimensions
- Performs brute-force search on quantized vectors
- Lower latency and RU cost than flat indexes for comparable accuracy levels
- Requires at least 1,000 vectors before the index becomes effective

The quantizedFlat index balances accuracy against performance. Vector searches return results that are usually the same as flat indexes, but occasionally the quantization causes minor differences in the ranked results.

### DiskANN index for large datasets

The diskANN index uses approximate nearest neighbor algorithms developed by Microsoft Research. DiskANN creates specialized data structures that enable fast vector search without comparing against every vector.

**When to use diskANN indexes:**

- Large datasets with more than 50,000 vectors per physical partition
- Applications requiring the lowest possible query latency at scale
- Workloads where RU efficiency is critical

**Characteristics:**

- Supports up to 4,096 dimensions
- Lowest latency and RU cost for large-scale vector search
- Maintains high accuracy while using approximate nearest neighbor algorithms
- Requires at least 1,000 vectors before the index becomes effective

DiskANN is the recommended choice for production AI applications with large embedding collections. The algorithm provides high recall while dramatically reducing query costs compared to brute-force approaches.

## Understand minimum vector requirements

Both quantizedFlat and diskANN indexes require at least 1,000 vectors before the index becomes effective. This minimum ensures accurate quantization and graph construction during index building. When fewer than 1,000 vectors exist, Azure Cosmos DB falls back to brute-force scans, which might result in higher RU charges than expected.

Plan for this behavior during initial data loading. If you're starting with a small dataset that grows over time, queries perform brute-force scans until you reach the 1,000-vector threshold. For applications that start small, consider using a flat index initially and migrating to quantizedFlat or diskANN as the dataset grows.

## Tune vector index parameters

Both quantizedFlat and diskANN indexes accept optional parameters that let you tune the trade-off between accuracy and performance.

**quantizationByteSize:** Controls how much compression is applied to vectors. Larger values preserve more information, improving accuracy but increasing storage and potentially reducing throughput. The default value is determined dynamically by the system. Valid values range from 1 to 512 bytes.

**indexingSearchListSize (diskANN only):** Controls how many vectors are evaluated during index construction. Higher values improve the quality of the index (and thus query accuracy) but increase the time required to build the index and add new vectors. The default is 100, with valid values ranging from 10 to 500.

Most applications perform well with default parameters. Consider tuning only if you observe accuracy issues in production or need to optimize for specific latency targets. The following example shows a vector index with custom parameters:

```json
{
  "vectorIndexes": [
    {
      "path": "/embedding",
      "type": "diskANN",
      "quantizationByteSize": 64,
      "indexingSearchListSize": 150
    }
  ]
}
```

## Exclude embeddings from range indexes

Embedding arrays consume significant storage when included in range indexes without providing query benefits. Vector searches use vector indexes, not range indexes, to find similar embeddings. Always exclude embedding paths from range indexing to reduce storage costs and write overhead.

When using the selective indexing strategy (excluding `/*` by default), simply don't include the embedding path in `includedPaths`. When using the default indexing strategy (including `/*`), explicitly add the embedding path to `excludedPaths`:

```json
{
  "excludedPaths": [
    { "path": "/\"_etag\"/?" },
    { "path": "/embedding/*" }
  ]
}
```

For documents with multiple embedding properties (perhaps different models or different text representations), exclude each embedding path individually.

## Coordinate vector and metadata indexes

Effective AI retrieval often combines vector similarity search with metadata filters. A user might search for documents similar to a query within a specific category or date range. You can design your indexing policy so that range and composite indexes support the metadata filters used alongside vector search.

This coordination enables pre-filtering that reduces the vector search space. When Azure Cosmos DB evaluates a query like "find the 10 most similar documents in category X," it first identifies documents in category X using the range index, then performs vector comparison only on those documents. This approach can dramatically reduce RU consumption compared to searching all embeddings and filtering afterward.

The following indexing policy supports combined metadata and vector search:

```json
{
  "indexingMode": "consistent",
  "includedPaths": [
    { "path": "/category/?" },
    { "path": "/department/?" },
    { "path": "/createdDate/?" },
    { "path": "/documentType/?" }
  ],
  "excludedPaths": [
    { "path": "/*" }
  ],
  "compositeIndexes": [
    [
      { "path": "/category", "order": "ascending" },
      { "path": "/createdDate", "order": "descending" }
    ]
  ],
  "vectorIndexes": [
    { "path": "/embedding", "type": "diskANN" }
  ]
}
```

This policy indexes metadata properties used in filters while excluding unnecessary properties. The composite index supports queries that filter by category and sort by date. The diskANN vector index enables efficient similarity search. Together, these indexes support queries that filter by metadata and then rank results by semantic similarity.

## Plan for vector policy immutability

Vector policies, which define the embedding properties available for vector indexing, can't be modified after container creation. This immutability means you must plan carefully during design:

- **Dimensions:** Choose dimensions that match your embedding model. If you plan to change models, ensure the new model produces the same dimensional output or create a new container.

- **Data types:** Select the appropriate data type (`float32`, `float16`, `int8`, or `uint8`) based on your accuracy and storage requirements. Using `float16` reduces storage by 50% compared to `float32` with minimal accuracy impact for most models.

- **Distance function:** Choose the distance function that matches how your embedding model was trained. Most text embedding models use cosine similarity.

If your requirements change, such as upgrading to a model with more dimensions, you must create a new container with the updated vector policy and migrate your data.

## Additional resources

- [Vector search in Azure Cosmos DB for NoSQL](/azure/cosmos-db/vector-search)
- [Vector indexes in Azure Cosmos DB](/azure/cosmos-db/index-policy#vector-indexes)
- [VectorDistance system function](/azure/cosmos-db/nosql/query/vectordistance)
