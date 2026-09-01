Once your collection has documents, you need to retrieve them. The `find()` method is the primary way to query documents in Azure DocumentDB. It supports a rich set of comparison, logical, and element operators that let you filter, project, sort, and paginate results.

## Retrieve all documents

The `find()` method returns documents from a collection. When you call it without a filter, it returns every document in the collection. This form is useful for quickly inspecting data during development, but production queries almost always include a filter to limit the result set:

```javascript
db.products.find()
```

In practice, you almost always add a filter to narrow results.

## Filter with comparison operators

Comparison operators match documents based on field values. They're the building blocks of most queries because nearly every filter expresses a condition like "equal to," "greater than," or "in this list of values."

| Operator | Description | Example |
|----------|-------------|---------|
| `$eq` | Equals | `{ price: { $eq: 3399.99 } }` |
| `$ne` | Not equals | `{ parentCategory: { $ne: "Accessories" } }` |
| `$gt` | Greater than | `{ price: { $gt: 500 } }` |
| `$gte` | Greater than or equal to | `{ inventory: { $gte: 100 } }` |
| `$lt` | Less than | `{ price: { $lt: 50 } }` |
| `$lte` | Less than or equal to | `{ inventory: { $lte: 500 } }` |
| `$in` | Matches any value in array | `{ parentCategory: { $in: ["Bikes", "Accessories"] } }` |
| `$nin` | Matches none of the values | `{ parentCategory: { $nin: ["Clothing"] } }` |

For simple equality checks, you can omit the `$eq` operator. These two queries are equivalent:

```javascript
// Implicit equality
db.products.find({ parentCategory: "Bikes" })

// Explicit $eq
db.products.find({ parentCategory: { $eq: "Bikes" } })
```

To narrow results further, combine multiple fields in the filter:

```javascript
// Bikes priced over $1,000
db.products.find({ parentCategory: "Bikes", price: { $gt: 1000 } })
```

## Combine filters with logical operators

Logical operators combine multiple conditions into a single filter. Use `$or` when any one of several conditions should match, `$and` when every condition must match, and `$not` to invert a condition. These operators let you express business rules that don't fit a single comparison.

```javascript
// Products that are bikes OR priced under $20
db.products.find({
  $or: [
    { parentCategory: "Bikes" },
    { price: { $lt: 20 } }
  ]
})

// Products NOT in the Accessories parent category
db.products.find({
  parentCategory: { $not: { $eq: "Accessories" } }
})
```

The `$and` operator is implicit when you specify multiple conditions in the same filter object. Use explicit `$and` when you need to apply multiple conditions to the same field:

```javascript
// Products priced between $25 and $100 (inclusive)
db.products.find({
  $and: [
    { price: { $gte: 25 } },
    { price: { $lte: 100 } }
  ]
})
```

## Query nested documents and arrays

Documents often contain embedded objects and arrays, so your queries need a way to reach into those nested structures. Azure DocumentDB uses dot notation to address fields inside embedded documents and provides dedicated operators for matching values inside arrays.

```javascript
// Products in the Mountain Bikes category
db.products.find({ "category.name": "Mountain Bikes" })

// Bikes with a 29-inch wheel
db.products.find({ "specs.wheelSize_inches": 29 })
```

For array fields, you can match against individual elements:

```javascript
// Products tagged with "lightweight"
db.products.find({ tags: "lightweight" })

// Products with all specified tags
db.products.find({ tags: { $all: ["lightweight", "aluminum"] } })

// Products with exactly 3 tags
// Note: $size starts with a $ because it's a query operator, not a field name.
// MongoDB query operators (like $size, $all, $in, $gt) are always prefixed with $
// to distinguish them from document fields in your data.
db.products.find({ tags: { $size: 3 } })
```

## Check for field existence

Because documents in the same collection don't have to share the same fields, you sometimes need to find documents based on whether a field is present at all. The `$exists` operator handles this case without checking the field's value.

```javascript
// Products that have a discount field
db.products.find({ discount: { $exists: true } })

// Products without a discount field
db.products.find({ discount: { $exists: false } })
```

## Shape results with projections

By default, `find()` returns all fields in matching documents. Projections let you include or exclude specific fields to reduce the amount of data returned:

```javascript
// Return only name and price (plus _id by default)
db.products.find(
  { parentCategory: "Bikes" },
  { name: 1, price: 1 }
)

// Exclude the _id field
db.products.find(
  { parentCategory: "Bikes" },
  { name: 1, price: 1, _id: 0 }
)
```

> [!NOTE]
> You can't mix inclusion and exclusion in the same projection, except for the `_id` field. Either specify the fields to include (set to `1`) or the fields to exclude (set to `0`), but not both.

## Learn how to sort, limit, and skip

Most applications don't display every matching document at once. Chain `.sort()`, `.limit()`, and `.skip()` onto a `find()` call to control the order of results, return only the top few, and page through large result sets. These three modifiers work together to power features like "top 10" lists and paginated catalog views.

```javascript
// Most expensive products first, top 5
db.products.find().sort({ price: -1 }).limit(5)

// Cheapest products first
db.products.find().sort({ price: 1 })

// Skip the first 10 results and return the next 5 (pagination)
db.products.find().sort({ price: 1 }).skip(10).limit(5)
```

Sort takes `1` for ascending order and `-1` for descending order. You can sort by multiple fields:

```javascript
// Sort by parent category ascending, then by price descending
db.products.find().sort({ parentCategory: 1, price: -1 })
```

## Count documents

When you only need a count rather than the documents themselves, `countDocuments()` returns the number of documents that match a filter. It runs more efficiently than retrieving the full result set and is the right choice for dashboard tiles, paging totals, and threshold checks.

```javascript
// Total products
db.products.countDocuments()

// Bike products
db.products.countDocuments({ parentCategory: "Bikes" })

// Products with inventory below 100
db.products.countDocuments({ inventory: { $lt: 100 } })
```

## Find distinct values

The `distinct()` method returns an array of unique values for a specified field across the documents that match an optional filter. This method is useful for populating filter menus, building category lists, or auditing the variety of values stored in a field.

```javascript
// All unique parent categories
db.products.distinct("parentCategory")

// Unique parent categories where price is over $50
db.products.distinct("parentCategory", { price: { $gt: 50 } })
```

Reading data is only half of day-to-day database work. As orders arrive and inventory changes, you need to modify or remove the documents you just learned to query. The next unit covers update and delete operations so you can keep your catalog in sync with your business.
