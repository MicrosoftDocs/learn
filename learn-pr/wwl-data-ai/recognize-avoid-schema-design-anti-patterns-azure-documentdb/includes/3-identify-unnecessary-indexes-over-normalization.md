Beyond structural issues, two common anti-patterns involve performance trade-offs that developers misjudge: creating too many indexes and over-normalizing data. Both stem from habits that work well in relational databases but cause problems in a document database.

## Recognize the unnecessary indexes anti-pattern

The unnecessary indexes anti-pattern occurs when you create indexes on every field or maintain indexes that are rarely or never used. While indexes speed up reads, every index slows down writes because each insert, update, or delete must also update all associated indexes.

Consider a products collection with indexes on nearly every field:

```javascript
// Anti-pattern: indexing every field
db.products.createIndex({ name: 1 });
db.products.createIndex({ sku: 1 });
db.products.createIndex({ price: 1 });
db.products.createIndex({ productType: 1 });
db.products.createIndex({ "category.name": 1 });
db.products.createIndex({ "tags": 1 });
db.products.createIndex({ createdAt: 1 });
db.products.createIndex({ "reviewSummary.averageRating": 1 });
db.products.createIndex({ "reviewSummary.totalCount": 1 });
// 9+ indexes on a single collection
```

This approach causes several problems:

- **Slow writes**: Every insert or update must update all indexes. A collection with 20 indexes might take 10-50 times longer to write than one with two indexes.
- **Storage overhead**: Indexes consume disk space, sometimes as much as or more than the data itself.
- **Memory pressure**: Indexes compete with your working set for available RAM.
- **Diminishing returns**: Most queries use only a few indexes. Unused indexes consume resources without benefit.

Are you really searching on every field? Do you need to sort by every field? If not, those indexes are unnecessary. 

### Identify unnecessary indexes

Three common patterns indicate indexes you can remove or consolidate.

**Overlapping indexes** occur when a compound index already covers simpler queries:

```javascript
// These three indexes overlap
db.orders.createIndex({ customerId: 1 });
db.orders.createIndex({ customerId: 1, orderDate: 1 });
db.orders.createIndex({ customerId: 1, orderDate: 1, status: 1 });

// The compound index serves all three query patterns
// Remove the first two and keep only:
db.orders.createIndex({ customerId: 1, orderDate: -1, status: 1 });
```

**Low-cardinality indexes** are indexes on fields with few unique values, like a `status` field with only three possible values. On their own, these indexes provide minimal query benefit. Instead, combine them into a compound index:

```javascript
// Low-cardinality field alone is inefficient
db.products.createIndex({ productType: 1 });

// Better: compound index with a selective field
db.products.createIndex({ productType: 1, price: -1 });
```

**Rarely-used indexes** support queries that run infrequently, for example a `createdAt` index used only for an annual report. Use `$indexStats` to identify these indexes:

```javascript
// Check index usage statistics
db.products.aggregate([{ $indexStats: {} }]);

// Example output for an unused index:
// { name: "createdAt_1", accesses: { ops: 0, since: ISODate("2026-01-01") } }
```

### Fix unnecessary indexes

Follow these guidelines to maintain an efficient index set:

- **Apply the ESR rule**: When building compound indexes, order fields by Equality, Sort, then Range (ESR). This sequence maximizes index efficiency for common query patterns.

   ```javascript
   // Query: find shipped orders for a customer, sorted by date
   db.orders.find({ status: "shipped", customerId: "cust123" })
     .sort({ orderDate: -1 });

   // ESR index: equality fields first, then sort field.
   db.orders.createIndex({ status: 1, customerId: 1, orderDate: -1 });
   ```

    You check `status` and `customerId` before `orderDate`.

- **Use partial indexes** for queries that filter on a subset of documents:

   ```javascript
   // Index only unprocessed orders instead of all orders
   db.orders.createIndex(
     { createdAt: -1 },
     { partialFilterExpression: { processedAt: { $exists: false } } }
   );
   ```
    You only index documents where `processedAt` doesn't exist, which is a smaller subset of the collection, making the index smaller and faster to update.

- **Audit indexes regularly**: Run `$indexStats` monthly and drop indexes with zero or near-zero operations.

    The `$indexStats` aggregation stage returns one document per index in the collection. Each document includes the index `name`, the `key` specification, and an `accesses` object with two fields: `ops` (the number of operations that used the index) and `since` (the timestamp when the server started tracking usage). An index with `ops: 0` wasn't used since tracking began and is a candidate for removal.

> [!TIP]
> Use `explain("executionStats")` to verify that your queries use the intended index. Look for `"stage": "IXSCAN"` (index scan) instead of `"stage": "COLLSCAN"` (full collection scan).

Because Azure DocumentDB only indexes the `_id` field by default, developers who are new to the service sometimes overcompensate by indexing every field they might query. A better starting point is to index only the fields that appear in your most frequent queries, then add indexes incrementally as new query patterns emerge. Don't forget to remove indexes that aren't used, especially if they support features you no longer use, like a `status` field for a feature that was deprecated.

## Recognize the over-normalization anti-pattern

The over-normalization anti-pattern occurs when you split data across many collections as if designing a relational database: separate collections for customers, addresses, cities, and states, all linked by foreign key references. In a document database, this design forces multiple queries to assemble data that the application displays on a single page.

Consider a customer profile that requires four queries to display:

```javascript
// Anti-pattern: over-normalized like a relational database
const customer = await db.customers.findOne({ _id: customerId });
const address = await db.addresses.findOne({ customerId: customer._id });
const city = await db.cities.findOne({ _id: address.cityId });
const state = await db.states.findOne({ _id: city.stateId });
// Four round trips to display one customer profile
```

This approach causes several problems:

- **Multiple round trips**: Each query adds network latency. Four queries might take 40 ms instead of a single 10-ms query.
- **Complex application code**: Your application must manually join data from multiple collections.
- **Consistency risk**: If the four queries aren't wrapped in a transaction, the data might change between reads, producing inconsistent results.

### Fix over-normalization

Embed data that the application reads together into a single document. This approach, called denormalization, trades some data redundancy for faster reads:

```javascript
// Embed related data accessed together
db.customers.insertOne({
  _id: ObjectId("ddd100010000000000000000"),
  firstName: "Haladhar",
  lastName: "Keot",
  email: "haladhar@contoso.com",
  addresses: [
    {
      addressType: "shipping",
      street: "7890 Pine Avenue",
      city: "Bellevue",
      state: "WA",
      zip: "98004",
      country: "US"
    }
  ]
});

// Single query returns everything the profile page needs
const customer = await db.customers.findOne({ _id: customerId });
```

For data that has different lifecycle or update frequencies, use the extended reference pattern. Embed the fields you display frequently and keep a reference to the full document:

```javascript
// Order embeds display-only customer fields
db.orders.insertOne({
  customerId: ObjectId("ddd100010000000000000000"),
  customerName: "Haladhar Keot",
  customerEmail: "haladhar@contoso.com",
  items: [
    {
      productId: ObjectId("ccc100030000000000000000"),
      name: "Mountain-100 Silver, 44",
      price: 3399.99,
      quantity: 1
    }
  ],
  shippingAddress: {
    street: "7890 Pine Avenue",
    city: "Bellevue",
    state: "WA",
    zip: "98004"
  }
});
```

> [!IMPORTANT]
> Denormalization doesn't mean embedding everything. If the data is read together, embed the data, bounded in size, and owned by the parent document. Reference data that changes independently, grows without bounds, or needs to be queried on its own.

Over-normalization is the most common anti-pattern among developers moving from relational databases to Azure DocumentDB. The `$lookup` aggregation stage can perform cross-collection joins, but it's significantly more expensive than reading embedded data, especially in sharded clusters where cross-shard data retrieval has limits.

Unnecessary indexes and over-normalization both reflect habits from relational databases applied to a document model. Index everything and normalize everything are safe defaults in a relational system, but they carry real costs in a document database. In the next unit, you explore a different kind of anti-pattern: case sensitivity issues that affect data quality rather than performance.
