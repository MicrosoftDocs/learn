As your e-commerce application processes orders, you need to update product inventory, change prices, and remove items no longer available. Azure DocumentDB supports the full set of MongoDB Query Language (MQL) update and delete operations, including field operators for modifying values and array operators for managing list data.

## Update a single document

The `updateOne()` method modifies the first document that matches a filter, leaving the rest of the document untouched. Update operations rely on update operators (like `$set`, `$inc`, and `$push`) to describe exactly what should change, so you only send the delta to the server instead of the whole document.

```javascript
// Reduce inventory by 1 for a specific product
db.products.updateOne(
  { sku: "BK-M82S-38" },
  { $inc: { inventory: -1 } }
)
```

The response tells you how many documents matched and how many were modified:

```javascript
{
  acknowledged: true,
  matchedCount: 1,
  modifiedCount: 1
}
```

## Field update operators

Field update operators change the value of individual fields in a document. Each operator solves a different problem: `$set` overwrites a value, `$inc` shifts a number by a delta, `$rename` changes a field's name, and `$currentDate` stamps a field with the current time. Knowing which operator to reach for is the key to writing precise, low-overhead updates.

| Operator | Description | Example |
|----------|-------------|---------|
| `$set` | Sets a field to a specified value | `{ $set: { price: 3199.99 } }` |
| `$unset` | Removes a field from the document | `{ $unset: { discount: "" } }` |
| `$inc` | Increments a field by a specified value | `{ $inc: { inventory: -5 } }` |
| `$mul` | Multiplies a field by a specified value | `{ $mul: { price: 0.9 } }` |
| `$min` | Updates if specified value is less than current | `{ $min: { price: 99.99 } }` |
| `$max` | Updates if specified value is greater than current | `{ $max: { inventory: 500 } }` |
| `$rename` | Renames a field | `{ $rename: { "specs": "specifications" } }` |
| `$currentDate` | Sets field to current date | `{ $currentDate: { updatedAt: true } }` |

You can combine multiple operators in a single update:

```javascript
// Update price and set a last-modified timestamp
db.products.updateOne(
  { sku: "HL-U509" },
  {
    $set: { price: 29.99 },
    $currentDate: { updatedAt: true }
  }
)
```

## Update multiple documents

Many business operations apply the same change across an entire group of documents. For example, you might mark down every item in a category or tag products that meet a threshold. The `updateMany()` method runs a single update against every document that matches the filter, which is far more efficient than looping through results in application code.

```javascript
// Apply a 10% discount to all clothing
db.products.updateMany(
  { parentCategory: "Clothing" },
  { $mul: { price: 0.9 } }
)

// Add a "sale" tag to all products priced under $20
db.products.updateMany(
  { price: { $lt: 20 } },
  { $addToSet: { tags: "sale" } }
)
```

> [!IMPORTANT]
> Be careful with `updateMany()` because it modifies every matching document. Always test your filter with `find()` first to verify which documents match before running the update.

## Array update operators

Arrays are a first-class data type in document databases, so you need a way to add, remove, or modify individual elements without rewriting the entire array. Array update operators handle these changes in place: `$push` appends, `$addToSet` adds only if missing, `$pull` removes by value, and `$each` lets you process several elements at once.

```javascript
// Add a new tag to a product
db.products.updateOne(
  { sku: "SJ-0194-M" },
  { $push: { tags: "reflective" } }
)

// Add a tag only if it doesn't already exist
db.products.updateOne(
  { sku: "SJ-0194-M" },
  { $addToSet: { tags: "reflective" } }
)

// Remove a specific tag
db.products.updateOne(
  { sku: "SJ-0194-M" },
  { $pull: { tags: "lightweight" } }
)

// Add multiple tags at once
db.products.updateOne(
  { sku: "SJ-0194-M" },
  { $push: { tags: { $each: ["high-visibility", "all-season"] } } }
)
```

## Replace a document

Sometimes a document needs more than a few field-level tweaks. It needs to be replaced entirely, for example, when an upstream system pushes a fresh canonical version. The `replaceOne()` method replaces the matched document (everything except the `_id`) with a new document you supply, which is simpler than chaining many `$set` operators.

```javascript
db.products.replaceOne(
  { _id: "BK-R93R-52" },
  {
    _id: "BK-R93R-52",
    sku: "BK-R93R-52",
    name: "Road-150 Red, 52 (2026 Edition)",
    category: { name: "Road Bikes" },
    parentCategory: "Bikes",
    price: 3699.00,
    inventory: 30,
    tags: ["road", "carbon-fiber", "racing", "high-performance"],
    specs: {
      frameMaterial: "carbon fiber",
      frameSize_cm: 52,
      gearCount: 22
    }
  }
)
```

> [!NOTE]
> Use `replaceOne()` when you want to overwrite a document completely. Use `updateOne()` with `$set` when you want to change specific fields while keeping the rest of the document intact.

## Find and modify atomically

Workflows like decrementing inventory or claiming a job from a queue have to read and modify a document as a single, indivisible step. The `findOneAndUpdate()` method does both in one server round trip and returns the document either before or after the change, so you avoid race conditions that can occur when separate `findOne()` and `updateOne()` calls run between concurrent clients.

```javascript
// Decrement inventory and return the updated document
db.products.findOneAndUpdate(
  { sku: "TT-M928", inventory: { $gt: 0 } },
  { $inc: { inventory: -1 } },
  { returnDocument: "after" }
)
```

Setting `returnDocument: "after"` returns the document with the update applied. The default behavior returns the document as it was before the update.

## Delete documents

Not every document is meant to live forever. Products no longer available, expired sessions, and finished jobs all eventually need to be cleaned up. The `deleteOne()` and `deleteMany()` methods remove documents that match a filter and report how many were deleted, so your application can confirm the cleanup ran as expected.

```javascript
// Delete a specific product
db.products.deleteOne({ _id: "BK-R93R-52" })
```

The `deleteMany()` method removes all documents that match the filter:

```javascript
// Delete all products with zero inventory
db.products.deleteMany({ inventory: 0 })

// Delete all products marked inactive
db.products.deleteMany({ isActive: false })
```

The response includes a `deletedCount` indicating how many documents were removed:

```javascript
{
  acknowledged: true,
  deletedCount: 3
}
```

> [!IMPORTANT]
> Delete operations are permanent. There's no undo command. For critical data, consider using Azure DocumentDB's point-in-time restore capability as a safety net. Backups are retained for 35 days for standard clusters and 7 days for burstable tier clusters (M10, M20, M25).

## Use upsert for insert-or-update logic

Applications often need an "insert if missing, update if present" workflow. For example, you might synchronize a record from an external source. Applying this change as two operations is slower and creates a race window between the read and the write. Setting `upsert: true` on `updateOne()` collapses both cases into a single atomic operation: the server either updates the matching document or inserts a new one.

```javascript
// Update the product if it exists, or insert it if it doesn't
db.products.updateOne(
  { sku: "WB-T44U" },
  {
    $set: {
      name: "Water Bottle - 30 oz.",
      category: { name: "Bottles and Cages" },
      parentCategory: "Accessories",
      price: 4.99,
      inventory: 600
    },
    $setOnInsert: {
      tags: ["hydration", "lightweight"],
      createdAt: new Date()
    }
  },
  { upsert: true }
)
```

The `$setOnInsert` operator sets the specified fields only when the operation results in an insert, not an update. This feature is useful for setting initial values like creation timestamps.

Inserts, finds, updates, and deletes cover the operations most applications run thousands of times a day. Many business questions, however, can't be answered by working with one document at a time. The next unit introduces aggregation pipelines, which let you summarize and reshape data across many documents in a single query.
