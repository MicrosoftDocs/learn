Before you can query data, you need to add documents to your collections. Azure DocumentDB uses standard MongoDB Query Language (MQL) insert commands to create new documents. Documents are stored as BSON (Binary JSON) and can contain nested objects, arrays, and various data types.

## Insert a single document

The `insertOne()` method adds one document to a collection. If the collection doesn't exist, Azure DocumentDB creates it automatically when you insert the first document.

```javascript
use cosmicworks

db.products.insertOne({
  sku: "BK-M82S-38",
  name: "Mountain-100 Silver, 38",
  category: { name: "Mountain Bikes" },
  parentCategory: "Bikes",
  price: 3399.99,
  inventory: 45,
  tags: ["mountain", "aluminum", "disc-brake", "suspension"],
  specs: {
    frameMaterial: "aluminum",
    frameSize_cm: 38,
    wheelSize_inches: 29,
    gearCount: 27
  },
  createdAt: new Date()
})
```

When this command runs, Azure DocumentDB returns a response that includes the new document's `_id` field. If you don't include an `_id` field in the document, the service generates a unique `ObjectId` automatically.

```javascript
{
  acknowledged: true,
  insertedId: ObjectId('...')
}
```

## Insert multiple documents

The `insertMany()` method inserts an array of documents in a single operation. This approach is more efficient than calling `insertOne()` multiple times because it reduces the number of network round trips.

```javascript
db.products.insertMany([
  {
    sku: "HL-U509",
    name: "Sport-100 Helmet, Black",
    category: { name: "Helmets" },
    parentCategory: "Accessories",
    price: 34.99,
    inventory: 320,
    tags: ["adjustable", "reflective", "lightweight"],
    createdAt: new Date()
  },
  {
    sku: "TT-M928",
    name: "Mountain Tire Tube",
    category: { name: "Tires and Tubes" },
    parentCategory: "Accessories",
    price: 4.99,
    inventory: 1500,
    tags: ["mountain", "replacement"],
    createdAt: new Date()
  },
  {
    sku: "SJ-0194-M",
    name: "Short-Sleeve Classic Jersey, M",
    category: { name: "Jerseys" },
    parentCategory: "Clothing",
    price: 53.99,
    inventory: 220,
    tags: ["breathable", "lightweight"],
    specs: {
      size: "M",
      fabric: "moisture-wicking polyester"
    },
    createdAt: new Date()
  }
])
```

The response includes an array of `insertedIds` confirming each document's unique identifier.

## Understand the _id field

Every document in Azure DocumentDB must have a unique `_id` field within its collection. This field serves as the document's primary key.

- If you don't provide an `_id`, the service generates a 12-byte `ObjectId` automatically.
- If you provide a custom `_id`, it must be unique within the collection. Inserting a document with a duplicate `_id` produces an error.
- The `_id` field is automatically indexed, so lookups by `_id` are fast.

```javascript
// Custom _id example
db.products.insertOne({
  _id: "BK-R93R-52",
  sku: "BK-R93R-52",
  name: "Road-150 Red, 52",
  category: { name: "Road Bikes" },
  parentCategory: "Bikes",
  price: 3578.27,
  inventory: 28
})
```

## Work with BSON data types

Azure DocumentDB stores data in BSON format, which supports several data types beyond standard JSON:

| Type | Example | Description |
|------|---------|-------------|
| String | `"Mountain-100 Silver, 38"` | UTF-8 text |
| Number (Double) | `3399.99` | 64-bit floating point |
| Number (Int32) | `NumberInt(45)` | 32-bit integer |
| Boolean | `true` | True or false |
| Date | `new Date()` | UTC datetime |
| ObjectId | `ObjectId()` | 12-byte unique identifier |
| Array | `["mountain", "aluminum"]` | Ordered list of values |
| Embedded document | `{ key: "value" }` | Nested object |
| Null | `null` | Null value |

These data types give you flexibility to model your data naturally. For instance, a product document can contain an embedded `specs` object and a `tags` array without requiring separate tables or joins.

## Schema flexibility

Unlike relational databases, Azure DocumentDB doesn't require documents in the same collection to share identical fields. You can add a detailed `specs` object to bikes while accessories like tire tubes in the same collection don't need that field.

This schema flexibility is useful as your application evolves. You can add new fields to documents without running migration scripts or altering table schemas. However, your application code should handle cases where optional fields might not exist in every document.

> [!TIP]
> Although schema flexibility is a strength of document databases, maintaining a consistent structure within a collection makes queries simpler and application code more predictable. Use schema validation if you need to enforce specific rules on your documents.

With documents in your collection, the next step is getting them back out. In the next unit, you use `find()` and a range of query operators to locate the exact products your application needs.
