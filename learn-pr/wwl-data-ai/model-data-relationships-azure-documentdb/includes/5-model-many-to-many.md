Many-to-many relationships occur when multiple instances of one entity relate to multiple instances of another: products belong to many categories and each category contains many products. Customers purchase from many sellers and each seller has many customers. These relationships need a different approach than one-to-one or one-to-many patterns.

## Understand the core approach

In relational databases, many-to-many relationships use a junction table (also called a bridge or join table). In document databases, you store arrays of references on one or both sides of the relationship instead.

The key question is: **which side stores the references, and what data gets denormalized for display?**

## Use one-way references

When one direction is queried far more frequently than the other, store the references only on the side that initiates most queries. For example, let's consider products and their tags, you would include the tags with the products, but wouldn't include the products with the tags:

```javascript
// Products store tag references (one-way)
db.products.insertOne({
  _id: ObjectId("ccc100010000000000000000"),
  name: "Mountain-100 Silver, 38",
  sku: "BK-M100S-38",
  price: 3381.99,
  tags: ["mountain", "aluminum", "disc-brake", "suspension", "high-performance"]
});

// Tags don't store product references
db.tags.insertOne({
  _id: ObjectId("bbb100010000000000000000"),
  name: "mountain",
  slug: "mountain",
  description: "Off-road and trail riding equipment"
});

// Find all tags for a product (fast: use the embedded array)
const product = db.products.findOne({ sku: "BK-M100S-38" });
// product.tags is already available

// Find all products with a tag (requires query on products collection)
const products = db.products.find({
  tags: "mountain"
}).toArray();
```

One-way references work when:

- One direction is queried much more frequently
- The reference array on the chosen side stays reasonably sized (under 1,000 items)
- You can accept the performance cost of querying the "reverse" direction

One-way references are common in scenarios like product-to-tags relationships, where you often query products by tag but rarely need to query tags by product.

## Use two-way references

On a e-commerce web app, tags work as one-way references because they're simple labels with no page of their own. Categories are different: they have dedicated browse pages, parent hierarchies, and metadata, so you need to query from both directions. When both directions are queried frequently, store references on both sides.

```javascript
// Product with category reference (extended reference pattern)
db.products.insertOne({
  _id: ObjectId("ccc100010000000000000000"),
  name: "Mountain-100 Silver, 38",
  sku: "BK-M100S-38",
  price: 3381.99,
  category: {
    _id: ObjectId("aaa100010000000000000000"),
    name: "Mountain Bikes"
  },
  tags: ["mountain", "aluminum", "disc-brake", "suspension", "high-performance"]
});

// Category with its own metadata and product count
db.categories.insertOne({
  _id: ObjectId("aaa100010000000000000000"),
  name: "Mountain Bikes",
  parentCategory: "Bikes",
  slug: "mountain-bikes",
  description: "Off-road bikes for trail and mountain riding",
  isActive: true,
  productCount: 32
});
```

With two-way references, both directions resolve quickly:

```javascript
// Find category for a product (no second query needed)
const product = db.products.findOne({ sku: "BK-M100S-38" });
// product.category.name is "Mountain Bikes", already embedded

// Find all products in a category
db.products.find({ "category.name": "Mountain Bikes" })
  .limit(20)
  .toArray();
```

In our example, the trade-off is that when a category name changes, you need to update every product that embeds the category because the denormalized data is no longer accurate.

## Denormalize for display

In many-to-many relationships, you often embed denormalized data (frequently displayed fields) rather than just IDs. This eliminates extra queries for the most common page loads.

Consider two pages in the e-commerce app. The customer dashboard displays each customer's favorite categories by name, so the customer document embeds category names directly. The category admin page lists top customers for targeted outreach, so the category document embeds customer names. Both sides store just enough to render without a second query:

```javascript
// Customer with denormalized favorite categories
db.customers.insertOne({
  _id: ObjectId("ddd100010000000000000000"),
  firstName: "Haladhar",
  lastName: "Keot",
  email: "haladhar@contoso.com",
  favoriteCategories: [
    {
      categoryId: ObjectId("aaa100010000000000000000"),
      name: "Mountain Bikes",
      addedAt: ISODate("2025-05-10T00:00:00Z")
    },
    {
      categoryId: ObjectId("aaa100180000000000000000"),
      name: "Helmets",
      addedAt: ISODate("2025-02-15T00:00:00Z")
    }
  ]
});

// Category with denormalized top customers
db.categories.insertOne({
  _id: ObjectId("aaa100010000000000000000"),
  name: "Mountain Bikes",
  parentCategory: "Bikes",
  followerCount: 1247,
  topCustomers: [
    {
      customerId: ObjectId("ddd100010000000000000000"),
      name: "Haladhar Keot",
      addedAt: ISODate("2025-05-10T00:00:00Z")
    },
    {
      customerId: ObjectId("ddd100020000000000000000"),
      name: "Eduarda Almeida",
      addedAt: ISODate("2025-01-01T00:00:00Z")
    }
  ]
});
```

Denormalize fields that appear in list views or cards (names, thumbnails). Skip fields that change frequently or are only needed on detail pages.

## Manage relationship changes

Denormalized fields can go stale. If the "Mountain Bikes" category is renamed to "Mountain & Trail Bikes," every customer document that embeds the old name needs an update. First, update the category itself:

```javascript
// Rename the category
db.categories.updateOne(
  { _id: ObjectId("aaa100010000000000000000") },
  { $set: { name: "Mountain & Trail Bikes", slug: "mountain-trail-bikes" } }
);
```

Then propagate the new name to all customer documents that still embed the old value. Use `arrayFilters` to target only the matching entry in the `favoriteCategories` array:

```javascript
// Update category name in all customers that reference it
db.customers.updateMany(
  { "favoriteCategories.categoryId": ObjectId("aaa100010000000000000000") },
  {
    $set: {
      "favoriteCategories.$[elem].name": "Mountain & Trail Bikes"
    }
  },
  { arrayFilters: [{ "elem.categoryId": ObjectId("aaa100010000000000000000") }] }
);
```

These type of updates shouldn't be a real problem, because you would usually only embed related data from other collections that rarely changes.

## Use aggregation for cross-collection joins

When you need related data that isn't denormalized, use `$lookup` to join collections in an aggregation pipeline. For example, if you would like to return additional category details for a product that were not embedded to the product's document, `$lookup` can be used to perform a left outer join.

```javascript
// Get product with full category details
db.products.aggregate([
  { $match: { sku: "BK-M100S-38" } },
  {
    $lookup: {
      from: "categories",
      localField: "category._id",
      foreignField: "_id",
      as: "categoryDetails"
    }
  },
  {
    $project: {
      name: 1,
      price: 1,
      category: { $arrayElemAt: ["$categoryDetails", 0] }
    }
  }
]);
```

> [!TIP]
> Index the array fields used in many-to-many queries. Create indexes on `categories._id` in the products collection and `productIds` in the categories collection to keep lookups fast. Indexing is covered in a future module.

Keep in mind that `$lookup` adds latency compared to reading denormalized data, so reserve it for less frequent queries where you need the full related document.

## Choose a consistency strategy

Many-to-many relationships require you to choose how strictly you maintain consistency between the two sides:

- **Transactions:** Use for critical relationships where inconsistency is unacceptable (for example, financial data). Both sides update atomically, but writes are slightly slower.
- **Eventual consistency:** Update one side immediately and the other asynchronously. Faster writes, but the data can be temporarily inconsistent. Good for display-only denormalized data like category names.
- **Single source of truth:** Designate one side as authoritative and rebuild the other side on demand. Simplest to maintain, but requires periodic synchronization.

For e-commerce product-category relationships, eventual consistency usually works because a brief delay in category name updates doesn't affect functionality.
