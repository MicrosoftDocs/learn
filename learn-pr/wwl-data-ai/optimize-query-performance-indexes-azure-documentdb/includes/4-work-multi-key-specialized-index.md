Beyond single-field and compound indexes, Azure DocumentDB supports several specialized index types designed for specific data patterns and query requirements.

## Index array fields with multi-key indexes

When you create an index on a field that contains an array, Azure DocumentDB automatically creates a **multi-key index**. The database creates a separate index entry for each element in the array, which allows efficient queries on any individual array value. Let's add a multi-key index on the `tags` field of our products collection:

```javascript
// Products with a tags array
db.products.insertOne({
  name: "Mountain-100 Silver, 44",
  tags: ["mountain", "aluminum", "disc-brake", "suspension"]
});

// Create a multi-key index on the tags field
db.products.createIndex({ tags: 1 });

// Query for any single tag value. Uses the multi-key index.
db.products.find({ tags: "disc-brake" });
```

Multi-key indexes also work with arrays of embedded documents. You can index a specific field within each embedded object. For example, if you have an `orders` collection where each order contains an array of `items`, you can create a multi-key index on the `sku` field within the `items` array:

```javascript
// Orders with an array of item objects
db.orders.insertOne({
  customerName: "Haladhar Keot",
  items: [
    { sku: "BK-M100S-44", name: "Mountain-100 Silver, 44", price: 3399.99 },
    { sku: "HL-6618", name: "Sport-100 Helmet, Black, M", price: 42.94 }
  ]
});

// Index the sku field within the items array
db.orders.createIndex({ "items.sku": 1 });

// Find orders containing a specific product
db.orders.find({ "items.sku": "BK-M100S-44" });
```

> [!IMPORTANT]
> A compound index can include at most **one** array field. If you attempt to create a compound index on two array fields, the operation fails. This limitation exists because indexing every combination of elements from two arrays would create an exponential number of index entries.

If your documents contain multiple array fields that need querying, create separate indexes for each array field rather than trying to combine them in a single compound index. For example, if you have both `tags` and `categories` arrays, create one index on `tags` and another on `categories`:

```javascript
// Separate multi-key indexes for multiple array fields
db.products.createIndex({ tags: 1 });
db.products.createIndex({ categories: 1 });
```

## Use wildcard indexes for dynamic schemas

Some collections contain documents with unpredictable field names or deeply nested structures. **Wildcard indexes** (`$**`) index all fields under a specified path, making them useful when you can't predict which fields queries filter on. Consider a products collection where each product has a `specs` field that contains different attributes based on the product type:

```javascript
// Products with varying specification fields
db.products.insertMany([
  { name: "Mountain-100 Silver, 44", productType: "bike",
    specs: { frameSize: 44, frameMaterial: "Aluminum", gears: 27, brakeType: "Hydraulic Disc" } },
  { name: "Sport-100 Helmet, Black, M", productType: "accessory",
    specs: { color: "Black", weight_grams: 170, sizeRange: "M" } }
]);

// Wildcard index on all fields under specs
db.products.createIndex({ "specs.$**": 1 });

// Both queries use the wildcard index
db.products.find({ "specs.frameMaterial": "Aluminum" });
db.products.find({ "specs.weight_grams": { $lt: 200 } });
```

You can also create a wildcard index on all fields in the entire document:

```javascript
// Index all fields in all documents
db.products.createIndex({ "$**": 1 });
```

Wildcard indexes have specific limitations in Azure DocumentDB:

- They can't be unique indexes.
- They don't support `ORDER BY` unless the filter includes only paths present in the wildcard.
- A compound wildcard index can have only **one** wildcard term and one or more regular index terms.

> [!TIP]
> Use wildcard indexes when your query patterns are genuinely unpredictable. For known, stable query patterns, compound indexes are more efficient because they support multi-field queries and sorting in a single index structure.

## Create partial indexes for conditional indexing

**Partial index** indexes only documents that match a filter expression. This filter reduces the index size and write overhead because documents that don't match the filter are excluded from the index.

For example, if you have a products collection where only in-stock items are frequently queried, you can create a partial index that includes only documents where `inventory.quantityAvailable` is greater than zero:

```javascript
// Index only products that are in stock
db.products.createIndex(
  { "category.name": 1, price: 1 },
  { partialFilterExpression: { "inventory.quantityAvailable": { $gt: 0 } } }
);

// This query uses the partial index (filter matches the partial expression)
db.products.find({ "category.name": "Mountain Bikes", price: { $lte: 2000 }, "inventory.quantityAvailable": { $gt: 0 } });

// This query does NOT use the partial index (missing the inventory filter)
db.products.find({ "category.name": "Mountain Bikes", price: { $lte: 2000 } });
```

The partial filter expression supports equality (`$eq`), existence (`$exists`), range (`$gt`, `$gte`, `$lt`, `$lte`), type (`$type`), and logical operators (`$and`, `$or`).

Partial indexes are especially useful for:

- Active records: Index only documents where `status` equals `"active"` when inactive records are rarely queried.
- Soft deletes: Exclude documents where `deleted` equals `true`.
- Time-based queries: Index only recent documents using a date filter.

> [!NOTE]
> In Azure DocumentDB, a partial index only supports sorting and unique constraints when the query includes the same filter conditions defined in the `partialFilterExpression`. If your query omits those conditions, the database can't use the partial index for sorting or uniqueness enforcement.

## Use sparse indexes for optional fields

A **sparse index** includes entries only for documents that contain the indexed field. Documents missing the field are excluded from the index. Sparse indexes are useful for fields that exist in only a subset of documents.

```javascript
// Not all customers have a phone number
db.customers.createIndex({ phone: 1 }, { sparse: true });

// Finds customers who have a phone field. Uses the sparse index
db.customers.find({ phone: { $exists: true } });
```

Partial indexes are recommended over sparse indexes because they offer more flexible filter conditions. A sparse index is equivalent to a partial index with `{ field: { $exists: true } }`.

## Create text indexes for full-text search

Text indexes support keyword-based search across string fields. You can create a text index on one or multiple fields:

```javascript
// Text index on product name and description
db.products.createIndex({ name: "text", description: "text" });

// Search for products matching "mountain bike"
db.products.find({ $text: { $search: "mountain bike" } });

// Include a relevance score
db.products.find(
  { $text: { $search: "mountain bike" } },
  { score: { $meta: "textScore" } }
).sort({ score: { $meta: "textScore" } });
```

> [!NOTE]
> Only one text index is allowed per collection. If you need to search across multiple fields, include all of them in a single text index definition.

## Use vector indexes for similarity search

Azure DocumentDB includes an integrated vector database at no extra cost. Vector indexes support similarity search on high-dimensional embeddings, making them essential for AI workloads like semantic search, recommendation systems, and retrieval-augmented generation (RAG) patterns. You store vector embeddings alongside your document data in the same collection, so there's no need for a separate vector database to power your AI workloads.

Azure DocumentDB supports three vector index algorithms:

| Algorithm | Best for | Cluster tier |
|-----------|----------|--------------|
| **IVF** | Small datasets (under 10,000 vectors). Faster build times, lower memory use. | M10 or M20 |
| **HNSW** | Medium datasets (up to 50,000 vectors). Better query performance in terms of speed-recall tradeoff. | M30 and higher |
| **DiskANN** (recommended) | Large datasets (500,000+ vectors). Efficient at any scale with high recall and throughput. | M30 and higher |

To create a vector index, use the `cosmosSearch` index type and specify the algorithm, dimensions, and similarity metric:

```javascript
// Create a vector index using the HNSW algorithm
db.products.createIndex(
  { embedding: "cosmosSearch" },
  {
    cosmosSearchOptions: {
      kind: "vector-hnsw",
      dimensions: 1536,
      similarity: "COS"
    }
  }
);
```

Once the index is created, use the `$search` aggregation stage with the `cosmosSearch` operator to find documents with similar vectors:

```javascript
// Find the 5 most similar products to a query vector
db.products.aggregate([
  {
    $search: {
      cosmosSearch: {
        vector: [0.012, -0.043, 0.087, /* ... remaining dimensions */],
        path: "embedding",
        k: 5
      }
    }
  },
  {
    $project: {
      name: 1,
      score: { $meta: "searchScore" }
    }
  }
]);
```

Supported similarity metrics include `COS` (cosine distance), `L2` (Euclidean distance), and `IP` (inner product). The default maximum vector dimension for indexing is 2,000, but DiskANN with product quantization supports up to 16,000 dimensions, which accommodates the large embedding models commonly used in AI workloads.

> [!NOTE]
> Vectors must be stored as a `number[]` to be indexed. Documents with vectors using other types, such as `double[]`, aren't indexed and don't appear in vector search results.

## Combine vector and full-text search

Azure DocumentDB supports hybrid search that combines vector similarity search with full-text keyword search. Hybrid search uses both a vector index and a text index, merging the ranked results using Reciprocal Rank Fusion (RRF). This approach improves recall for queries that benefit from both semantic meaning and exact keyword matching, such as finding products by described intent and by exact brand name simultaneously.

For implementation details, see [Hybrid search in Azure DocumentDB](/azure/documentdb/hybrid-search).

## Use geospatial indexes for location-based queries

Geospatial indexes support queries on data stored as GeoJSON objects or legacy coordinate pairs. They enable efficient proximity searches, region lookups, and intersection queries.

Azure DocumentDB provides two geospatial index types:

- **2dsphere**: interprets geometry on a sphere. Use for real-world geographic data with GeoJSON objects (points, polygons, lines). This data type is the recommended type for most location-based applications.
- **2d**: interprets geometry on a flat surface. Use only with legacy coordinate pair data.

```javascript
// Store locations as GeoJSON Point objects
db.stores.insertOne({
  name: "Contoso Bikes Redmond",
  location: {
    type: "Point",
    coordinates: [-122.1215, 47.6740]   // [longitude, latitude]
  }
});

// Create a 2dsphere index on the location field
db.stores.createIndex({ location: "2dsphere" });

// Find stores within 5 km of a point
db.stores.find({
  location: {
    $nearSphere: {
      $geometry: { type: "Point", coordinates: [-122.1300, 47.6800] },
      $maxDistance: 5000   // distance in meters
    }
  }
});
```

Geospatial indexes in Azure DocumentDB have specific limitations:

- Compound indexes that combine a regular field with a `2dsphere` or `2d` field aren't supported.
- A `2d` index allows only one location field and one nongeospatial field.
- Polygons with holes aren't supported in `$geoWithin` queries.

## Use hashed indexes for shard key distribution

Hashed indexes compute a hash of a field's value and index the hashed result. Their primary use is enabling hash-based sharding, which distributes documents evenly across shards. Unlike B-tree indexes, hashed indexes don't support range queries or sorting.

```javascript
// Create a hashed index on customerId for even shard distribution
db.orders.createIndex({ customerId: "hashed" });
```

Use a hashed index when you need even data distribution across shards and your queries filter by exact match on the shard key. If your queries require range filtering or sorting on the shard key, a standard B-tree index is a better choice.

Azure DocumentDB offers a wide range of index types. From general-purpose single-field and compound indexes to specialized options for arrays, dynamic schemas, text search, and vector similarity. The key is matching the index type to your data pattern and query requirements. In the next unit, you learn how to use the `explain()` command to verify that your indexes are actually being used and diagnose queries that aren't performing as expected.
