Two patterns address common modeling challenges: the extended reference pattern reduces cross-collection lookups, and the schema versioning pattern manages schema evolution without downtime.

## Apply the extended reference pattern to reduce lookups

When you use references between collections, displaying related data requires multiple queries. An order page needs to show the customer's name and the product names, but with pure references, every page view triggers separate lookups to the `customers` and `products` collections.

Full embedding avoids extra lookups, but duplicating entire documents wastes storage and creates large documents. The **extended reference pattern** takes a middle path: embed only the frequently displayed fields from the referenced document alongside the reference ID. The full document stays in its source collection for when you need the complete data.

For example, when displaying the content of the `orders` collection, you usually only need the customer's name and email address. Likewise, for the `items` array, you typically only need the product's sku, name, and price.

```javascript
// Order with extended references, no extra queries for display
db.orders.insertOne({
  customerId: ObjectId("ddd100010000000000000000"),
  customerName: "Haladhar Keot",
  customerEmail: "haladhar@contoso.com",
  // Full profile (addresses, membershipTier, recentOrders) stays in customers collection
  orderDate: ISODate("2026-03-15"),
  status: "delivered",

  items: [
    {
      // Extended product reference
      sku: "BK-M100S-44",
      name: "Mountain-100 Silver, 44",
      productId: ObjectId("ccc100030000000000000000"),
      // Full description, reviews, specs stay in products collection
      price: 3399.99,
      quantity: 1
    }
  ],

  subtotal: 3399.99,
  shipping: 0.00,
  tax: 322.99,
  total: 3722.98
});

// Single query returns everything the order confirmation page needs
db.orders.findOne({ customerId: ObjectId("ddd100010000000000000000") });
```

By including the minimum required data from the `customer` and `item` collections, your `orders` reports can be generated without extra lookups, improving performance and reducing latency.

### Decide what to include in the extended reference

Not every field belongs in the extended reference. Use this guideline:

| Include | Exclude |
|---|---|
| Display names and usernames | Passwords and sensitive data |
| Image URLs and avatars | Full biographies or descriptions |
| Status indicators and types | Large nested structures |
| Category or type identifiers | Frequently changing data |

**Price at time of purchase** is a special case. Embed `priceAtPurchase` in the order because it's a historical fact; the current product price may change, but the order price shouldn't.

When deciding what to include, focus on reducing lookups without bloating the parent document. Embed only what you display, and leave everything else in the source collection.

### Update extended references when source data changes

When a customer changes their name, the extended reference in existing orders becomes stale. This staleness is often acceptable for historical records. But when accuracy matters, update extended references alongside the source:

```javascript
// Update the source document
db.customers.updateOne(
  { _id: ObjectId("ddd100010000000000000000") },
  { $set: { firstName: "Haladhar K.", lastName: "Keot" } }
);

// Update extended references in all related orders
db.orders.updateMany(
  { customerId: ObjectId("ddd100010000000000000000") },
  { $set: { customerName: "Haladhar K. Keot" } }
);
```

**When to use it:** You reference related data that displays frequently but the full document is large. Orders with customer info, product listings with category names, and review displays with customer names are typical examples.

**Trade-offs:** Duplicated fields may become stale. Updates to the source require updating extended references in multiple documents. Keep the duplicated field set small to minimize the update surface.

Although Azure DocumentDB supports `$lookup` for cross-collection joins, these lookups are expensive in sharded clusters where cross-shard data retrieval is limited to 1 GB per query. The extended reference pattern avoids this cost for common read paths. When you do need to update stale references across many documents, use bulk operations (limited to 25,000 writes per batch) or the `$merge` aggregation stage.

## Apply the schema versioning pattern for schema evolution

Application requirements change over time. You add new fields, restructure data, or rename properties. In a document database, existing documents don't automatically update when your schema changes. Without a strategy, your application ends up with documents in different formats and no way to tell which is which.

The **schema versioning pattern** adds a `schemaVersion` field to every document. When your schema changes, increment the version number. Application code reads the version and handles each format.

For example, your product document starts simple and evolves through time through three versions:

```javascript
// Version 1: Original schema, category is a simple string
{ schemaVersion: 1, name: "Mountain-100 Silver, 44", category: "Mountain Bikes", price: 3399.99 }

// Version 2: Category becomes an extended reference object
{ schemaVersion: 2, name: "Mountain-100 Silver, 44",
  category: { _id: ObjectId("aaa100010000000000000000"), name: "Mountain Bikes" }, price: 3399.99 }

// Version 3: Add productType discriminator and specs
{ schemaVersion: 3, name: "Mountain-100 Silver, 44", productType: "bike",
  category: { _id: ObjectId("aaa100010000000000000000"), name: "Mountain Bikes" },
  price: 3399.99, specs: { frameSize: 44, frameMaterial: "Aluminum", gears: 27 } }
```

Each version remains valid and queryable, so you can deploy schema changes without downtime. Older documents keep working until you explicitly migrate them. The drawback, your application must handle multiple schema versions.

### Choose a migration strategy

Having multiple versions of a document, increases the complexity of your application. The application needs to handle each version appropriately. The best solution is to migrate documents to the latest version. Two strategies exist for migrating documents to the latest version:

- **Lazy migration** converts documents when they're read. This approach is zero-downtime and spreads migration cost over time. When the application reads a document, it checks the `schemaVersion`, normalizes to the latest format, and saves the updated version back:

  ```javascript
  function getProduct(productId) {
    const product = db.products.findOne({ _id: productId });
    const currentVersion = 3;

    if (product.schemaVersion < currentVersion) {
      const migrated = migrateToLatestVersion(product);
      db.products.replaceOne({ _id: productId }, migrated);
      return migrated;
    }
    return product;
  }
  ```

- **Batch migration** converts documents in bulk using a background process. Use this migration type when you want to complete the migration on a schedule, or when you need all documents in the new format before deploying new application code:

  ```javascript
  // Batch migrate all v1 and v2 products to v3
  const cursor = db.products.find({ schemaVersion: { $lt: 3 } });
  const bulkOps = [];

  while (cursor.hasNext()) {
    const product = cursor.next();
    const migrated = migrateToLatestVersion(product);
    bulkOps.push({
      replaceOne: { filter: { _id: product._id }, replacement: migrated }
    });

    if (bulkOps.length >= 1000) {
      db.products.bulkWrite(bulkOps);
      bulkOps.length = 0;
    }
  }

  if (bulkOps.length > 0) {
    db.products.bulkWrite(bulkOps);
  }
  ```

> [!TIP]
> Use lazy migration for large collections where migration can happen gradually. Use batch migration when new features require all documents to be in the latest format before deployment.

**When to use it:** Your schema evolves over an active collection with existing data. Frequent scenarios include splitting fields, restructuring nested objects, adding new required fields, and changing field types.

**Trade-offs:** Application code must handle multiple schema versions, which adds complexity. Old migration code accumulates as technical debt. Test your application against all supported versions.

When a new schema version introduces fields you plan to query, remember that Azure DocumentDB doesn't index new fields automatically. Create indexes for those fields after the migration so that queries against the new structure don't fall back to full collection scans.

These two patterns address complementary challenges. The extended reference pattern reduces the number of queries your application needs for common read paths, while the schema versioning pattern gives you a controlled way to evolve your document structure without downtime or data loss. Together, they help you build applications that stay performant as both your data model and your data volume grow. In the next unit, you explore patterns for handling more complex data scenarios, including time-series data, statistical outliers, and data lifecycle management.
