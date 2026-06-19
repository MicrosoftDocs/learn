Two of the most common structural anti-patterns in document databases involve how you organize data within documents and across collections. Unbounded arrays let documents grow until they hit size limits and degrade performance. Collection sprawl creates management overhead that scales with your tenant or entity count. Both problems share a root cause: designing without considering how data grows over time.

## Recognize the unbounded arrays anti-pattern

The unbounded arrays anti-pattern occurs when you embed arrays in documents without any limit on their growth. As arrays grow, documents approach the 16-MB document size limit, consume more memory when loaded, and slow down every read and write operation that touches them.

Consider a product document that stores every customer review in an embedded array:

```javascript
// Anti-pattern: array that grows without bounds
db.products.insertOne({
  _id: ObjectId("ccc100030000000000000000"),
  name: "Mountain-100 Silver, 44",
  price: 3399.99,
  reviews: [
    { customerName: "Nikhil Barot", rating: 5, title: "Handles rough terrain", createdAt: ISODate("2025-06-15T10:00:00Z") },
    { customerName: "Dusan Sykora", rating: 4, title: "Good value for money", createdAt: ISODate("2025-07-02T11:30:00Z") }
    // Grows with every review -- potentially thousands of entries
  ]
});
```

Each time a customer writes a review, the application pushes another object onto the `reviews` array. A popular product could accumulate thousands of reviews over time. This causes several problems:

- **Document size limit**: Azure DocumentDB enforces a 16-MB document size limit. Once the array pushes the document past this threshold, writes fail.
- **Performance degradation**: Loading large documents consumes excessive memory and increases network transfer time.
- **Index bloat**: Indexes on array fields grow with each array element, consuming more storage and slowing updates.
- **Update overhead**: Appending to a large array is slower than appending to a small one because the database must rewrite the document.

Performance degrades gradually as the array grows, so you might not notice the problem until it becomes severe. By then, fixing it requires a costly migration to a new schema.

### Fix unbounded arrays

Three solutions address this anti-pattern, depending on your access pattern.

**Use the subset pattern** when the application typically displays only recent or top items. Keep a bounded summary in the document using `$slice` or a topReviews array, and store the full set in a separate collection:

```javascript
// Keep only the top 3 reviews in the product document
db.products.updateOne(
  { _id: productId },
  {
    $set: {
      "reviewSummary.topReviews": topThreeReviews
    },
    $inc: { "reviewSummary.totalCount": 1 }
  }
);

// Store the complete review in a separate collection
db.reviews.insertOne({
  productId: productId,
  customerName: "Moina Potongia",
  rating: 5,
  title: "Mountain-100 Silver 44 rack mounts on 72 kilometer ride",
  createdAt: new Date()
});
```

**Use a separate collection** when the application doesn't need any embedded items. Remove the array entirely and query the related collection when needed:

```javascript
// Product document with no embedded reviews -- only summary stats
db.products.insertOne({
  _id: ObjectId("ccc100030000000000000000"),
  name: "Mountain-100 Silver, 44",
  price: 3399.99,
  reviewSummary: { totalCount: 110, averageRating: 3.9 }
});

// Query reviews separately
db.reviews.find({ productId: productId }).sort({ createdAt: -1 }).limit(10);
```

**Use the bucket pattern** for time-series data. Group entries into time-based documents with preaggregated statistics:

```javascript
// Monthly bucket for product review activity
db.reviewBuckets.insertOne({
  productId: ObjectId("ccc100030000000000000000"),
  month: "2026-03",
  reviews: [
    { customerName: "Gitte Olsen", rating: 5, createdAt: ISODate("2026-03-01T10:00:00Z") },
    { customerName: "Eduarda Almeida", rating: 4, createdAt: ISODate("2026-03-05T14:20:00Z") }
  ],
  stats: { count: 18, averageRating: 4.2 }
});
```

> [!TIP]
> A quick way to detect unbounded arrays is to check your largest documents. Run `db.collection.find().sort({ $natural: -1 }).limit(5)` and look for arrays with hundreds or thousands of elements.

Because Azure DocumentDB enforces a hard 16-MB document size limit, unbounded arrays can silently grow until writes start failing. Cap arrays at insert time rather than fixing them later. Doing so prevents both write failures and the gradual performance degradation that precedes them.

## Recognize the collection sprawl anti-pattern

The collection sprawl anti-pattern occurs when you create too many collections, often one per user, per tenant, or per device. Each collection carries its own index overhead, metadata storage, and maintenance burden.

Consider a multitenant application that creates a separate collection for each customer:

```javascript
// Anti-pattern: one collection per customer
db.createCollection("customer_contoso_orders");
db.createCollection("customer_fabrikam_orders");
db.createCollection("customer_treyresearch_orders");
// Hundreds or thousands of collections
```

This approach causes several problems:

- **Index overhead**: Each collection needs its own indexes. With 1,000 customers and three indexes each, you maintain 3,000 indexes.
- **Memory consumption**: Collection and index metadata consumes RAM regardless of whether the collection is actively queried.
- **Cross-entity queries impossible**: You can't run a single aggregation pipeline across all customers without iterating collections.
- **Operational burden**: Backup, restore, and monitoring complexity scales linearly with collection count.

The problem starts small and is easy to miss. As you onboard more tenants, the overhead grows. By the time it becomes unmanageable, consolidating collections requires a costly migration.

### Fix collection sprawl

Use a single collection with a discriminator field. Add a field like `tenantId` or `customerId` to each document and create a compound index for efficient filtering:

```javascript
// Single collection for all customers
db.orders.insertMany([
  {
    customerId: ObjectId("ddd100010000000000000000"),
    customerName: "Haladhar Keot",
    total: 3722.98,
    orderDate: ISODate("2026-03-15")
  },
  {
    customerId: ObjectId("ddd100020000000000000000"),
    customerName: "Eduarda Almeida",
    total: 1299.50,
    orderDate: ISODate("2026-03-15")
  }
]);

// Compound index for customer-scoped queries
db.orders.createIndex({ customerId: 1, orderDate: -1 });

// Cross-customer analytics become straightforward
db.orders.aggregate([
  { $group: { _id: null, totalRevenue: { $sum: "$total" } } }
]);
```

> [!NOTE]
> Multiple collections are appropriate when entities have fundamentally different schemas and access patterns, for example, separate `customers`, `products`, and `orders` collections. The anti-pattern applies when you create many collections for the same entity type differentiated only by an identifier.

Azure DocumentDB supports up to 1,000 collections per cluster. Each collection carries its own metadata and index overhead regardless of how much data it holds, so consolidating similar entities into fewer collections frees resources for the queries that matter.

Both unbounded arrays and collection sprawl stem from designing without considering how data grows. Unbounded arrays let individual documents balloon, while collection sprawl lets the number of collections balloon. The fix in both cases is the same principle: constrain growth by choosing the right granularity for your data. In the next unit, you look at two anti-patterns that involve performance trade-offs rather than structural choices.
