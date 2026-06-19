With your application connected to Azure DocumentDB, you're ready to work with data. The MongoDB drivers for Python, .NET, and JavaScript expose methods that map directly to the MongoDB Query Language (MQL) operations you already know from MongoDB Shell. The same filter documents, update operators, and query patterns work in your application code.

In this unit, you learn how to insert, read, update, and delete documents programmatically. Each operation uses the same query syntax covered in the previous module, but executed through driver methods instead of an interactive shell.

## Insert documents

Use `insertOne` to add a single document or `insertMany` to add multiple documents in a single batch. Both operations return the generated `_id` values for the new documents.

::: zone pivot="python"

```python
# Insert a single document
result = products.insert_one({
    "sku": "HL-U509",
    "name": "Sport-100 Helmet, Black",
    "price": 34.99,
    "category": {"_id": "aaa10004", "name": "Helmets"},
    "tags": ["adjustable", "reflective", "lightweight"],
    "inventory": 320
})
print(f"Inserted document with _id: {result.inserted_id}")

# Insert multiple documents
docs = [
    {
        "sku": "TI-R982",
        "name": "HL Road Tire",
        "price": 32.60,
        "category": {"_id": "aaa10005", "name": "Tires and Tubes"},
        "tags": ["road", "durable"],
        "inventory": 230
    },
    {
        "sku": "TT-R982",
        "name": "Road Tire Tube",
        "price": 3.99,
        "category": {"_id": "aaa10005", "name": "Tires and Tubes"},
        "tags": ["road", "lightweight"],
        "inventory": 500
    }
]
result = products.insert_many(docs)
print(f"Inserted {len(result.inserted_ids)} documents")
```

::: zone-end

::: zone pivot="csharp"

```csharp
// Insert a single document
var helmet = new BsonDocument
{
    { "sku", "HL-U509" },
    { "name", "Sport-100 Helmet, Black" },
    { "price", 34.99 },
    { "category", new BsonDocument { { "_id", "aaa10004" }, { "name", "Helmets" } } },
    { "tags", new BsonArray { "adjustable", "reflective", "lightweight" } },
    { "inventory", 320 }
};
await products.InsertOneAsync(helmet);
Console.WriteLine($"Inserted document with _id: {helmet["_id"]}");

// Insert multiple documents
var docs = new List<BsonDocument>
{
    new BsonDocument
    {
        { "sku", "TI-R982" }, { "name", "HL Road Tire" }, { "price", 32.60 },
        { "category", new BsonDocument { { "_id", "aaa10005" }, { "name", "Tires and Tubes" } } },
        { "tags", new BsonArray { "road", "durable" } }, { "inventory", 230 }
    },
    new BsonDocument
    {
        { "sku", "TT-R982" }, { "name", "Road Tire Tube" }, { "price", 3.99 },
        { "category", new BsonDocument { { "_id", "aaa10005" }, { "name", "Tires and Tubes" } } },
        { "tags", new BsonArray { "road", "lightweight" } }, { "inventory", 500 }
    }
};
await products.InsertManyAsync(docs);
Console.WriteLine($"Inserted {docs.Count} documents");
```

::: zone-end

::: zone pivot="node"

```javascript
// Insert a single document
const result = await products.insertOne({
    sku: 'HL-U509',
    name: 'Sport-100 Helmet, Black',
    price: 34.99,
    category: { _id: 'aaa10004', name: 'Helmets' },
    tags: ['adjustable', 'reflective', 'lightweight'],
    inventory: 320
});
console.log(`Inserted document with _id: ${result.insertedId}`);

// Insert multiple documents
const docs = [
    {
        sku: 'TI-R982', name: 'HL Road Tire', price: 32.60,
        category: { _id: 'aaa10005', name: 'Tires and Tubes' },
        tags: ['road', 'durable'], inventory: 230
    },
    {
        sku: 'TT-R982', name: 'Road Tire Tube', price: 3.99,
        category: { _id: 'aaa10005', name: 'Tires and Tubes' },
        tags: ['road', 'lightweight'], inventory: 500
    }
];
const multiResult = await products.insertMany(docs);
console.log(`Inserted ${multiResult.insertedCount} documents`);
```

::: zone-end

## Read documents

Reading data is the most frequent database operation in most applications. Whether your e-commerce site displays a product detail page or lists search results, you use read operations to retrieve documents from collections.

Use `findOne` to retrieve a single document by filter, or `find` to retrieve multiple documents matching a query. Both methods accept the same filter syntax you use in MongoDB Shell.

::: zone pivot="python"

```python
# Find a single document by SKU
helmet = products.find_one({"sku": "HL-U509"})
print(f"Found: {helmet['name']}, ${helmet['price']}")

# Find all products in a category with price under $40
affordable = products.find({
    "category.name": "Tires and Tubes",
    "price": {"$lt": 40}
})
for product in affordable:
    print(f"  {product['name']}: ${product['price']}")
```

::: zone-end

::: zone pivot="csharp"

```csharp
// Find a single document by SKU
var filter = Builders<BsonDocument>.Filter.Eq("sku", "HL-U509");
var helmet = await products.Find(filter).FirstOrDefaultAsync();
Console.WriteLine($"Found: {helmet["name"]}, ${helmet["price"]}");

// Find all products in a category with price under $40
var categoryFilter = Builders<BsonDocument>.Filter.And(
    Builders<BsonDocument>.Filter.Eq("category.name", "Tires and Tubes"),
    Builders<BsonDocument>.Filter.Lt("price", 40)
);
var affordable = await products.Find(categoryFilter).ToListAsync();
foreach (var product in affordable)
{
    Console.WriteLine($"  {product["name"]}: ${product["price"]}");
}
```

::: zone-end

::: zone pivot="node"

```javascript
// Find a single document by SKU
const helmet = await products.findOne({ sku: 'HL-U509' });
console.log(`Found: ${helmet.name}, $${helmet.price}`);

// Find all products in a category with price under $40
const affordable = await products.find({
    'category.name': 'Tires and Tubes',
    price: { $lt: 40 }
}).toArray();
for (const product of affordable) {
    console.log(`  ${product.name}: $${product.price}`);
}
```

::: zone-end

## Update documents

As your application processes orders and manages inventory, you need to modify existing documents without replacing them entirely. MongoDB drivers provide `updateOne` and `updateMany` methods that accept the same update operators you use in MongoDB Shell, like `$set`, `$inc`, and `$push`.

::: zone pivot="python"

```python
# Update a single document: reduce inventory by 1
products.update_one(
    {"sku": "HL-U509"},
    {"$inc": {"inventory": -1}}
)

# Update multiple documents: add a "sale" tag to all tires
products.update_many(
    {"category.name": "Tires and Tubes"},
    {"$addToSet": {"tags": "sale"}}
)
```

::: zone-end

::: zone pivot="csharp"

```csharp
// Update a single document: reduce inventory by 1
var skuFilter = Builders<BsonDocument>.Filter.Eq("sku", "HL-U509");
var decrementUpdate = Builders<BsonDocument>.Update.Inc("inventory", -1);
await products.UpdateOneAsync(skuFilter, decrementUpdate);

// Update multiple documents: add a "sale" tag to all tires
var tiresFilter = Builders<BsonDocument>.Filter.Eq("category.name", "Tires and Tubes");
var addTagUpdate = Builders<BsonDocument>.Update.AddToSet("tags", "sale");
await products.UpdateManyAsync(tiresFilter, addTagUpdate);
```

::: zone-end

::: zone pivot="node"

```javascript
// Update a single document: reduce inventory by 1
await products.updateOne(
    { sku: 'HL-U509' },
    { $inc: { inventory: -1 } }
);

// Update multiple documents: add a "sale" tag to all tires
await products.updateMany(
    { 'category.name': 'Tires and Tubes' },
    { $addToSet: { tags: 'sale' } }
);
```

::: zone-end

## Delete documents

When products are no longer needed or test data needs cleanup, use `deleteOne` to remove a single document or `deleteMany` to remove all documents matching a filter. Both methods return the count of deleted documents so your application can confirm the operation succeeded.

> [!CAUTION]
> Delete operations are permanent. There's no undo command. For critical data, consider using Azure DocumentDB's point-in-time restore capability as a safety net. Backups are retained for 35 days for standard clusters and 7 days for burstable tier clusters (M10, M20, M25).

::: zone pivot="python"

```python
# Delete a single document
products.delete_one({"sku": "TT-R982"})

# Delete all documents with zero inventory
result = products.delete_many({"inventory": 0})
print(f"Deleted {result.deleted_count} out-of-stock products")
```

::: zone-end

::: zone pivot="csharp"

```csharp
// Delete a single document
var deleteFilter = Builders<BsonDocument>.Filter.Eq("sku", "TT-R982");
await products.DeleteOneAsync(deleteFilter);

// Delete all documents with zero inventory
var outOfStockFilter = Builders<BsonDocument>.Filter.Eq("inventory", 0);
var deleteResult = await products.DeleteManyAsync(outOfStockFilter);
Console.WriteLine($"Deleted {deleteResult.DeletedCount} out-of-stock products");
```

::: zone-end

::: zone pivot="node"

```javascript
// Delete a single document
await products.deleteOne({ sku: 'TT-R982' });

// Delete all documents with zero inventory
const deleteResult = await products.deleteMany({ inventory: 0 });
console.log(`Deleted ${deleteResult.deletedCount} out-of-stock products`);
```

::: zone-end


> [!TIP]
> The MongoDB query operators you use in application code are identical to the ones you use in MongoDB Shell. If you can write a query in `mongosh`, you can use the same filter document in your driver code.

You now know how to insert, read, update, and delete documents using the MongoDB driver for your language. In the next unit, you learn how to manage connections, handle errors, and secure your credentials in production code.
