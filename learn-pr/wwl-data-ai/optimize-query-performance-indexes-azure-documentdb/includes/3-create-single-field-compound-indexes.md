The two most common index types are single-field and compound indexes. Together they address most query optimization needs.

## Create single-field indexes

A single-field index indexes one field in a collection. You create it with the `createIndex()` method, specifying the field name and sort direction (`1` for ascending, `-1` for descending).

```javascript
// Create an ascending index on the price field
db.products.createIndex({ price: 1 });
```

For single-field indexes, the sort direction doesn't affect query performance. An ascending index on `price` supports both `sort({ price: 1 })` and `sort({ price: -1 })` equally well, because the database can traverse the B-tree in either direction.

### Index nested fields with dot notation

You can index fields within embedded documents using dot notation:

```javascript
// Index a nested field
db.products.createIndex({ "category.name": 1 });

// This query uses the index
db.products.find({ "category.name": "Mountain Bikes" });
```

### Add unique constraints

A unique index ensures that no two documents contain the same value for the indexed field. Use the `unique` option when the field must be distinct across all documents, such as email addresses:

```javascript
// Create a unique index on email
db.customers.createIndex({ email: 1 }, { unique: true });

// The first insert for this customer succeeds
db.customers.insertOne({ email: "haladhar@contoso.com", firstName: "Haladhar", lastName: "Keot" });

// Subsequent inserts with the same email fail with a duplicate key error
db.customers.insertOne({ email: "haladhar@contoso.com", firstName: "Haladhar", lastName: "Keot" });
```

> [!NOTE]
> If the collection already contains duplicate values for the indexed field, the `createIndex()` command fails. Clean up duplicates before creating a unique index.

> [!NOTE]
> Unique index builds run in the foreground and block all write operations on the collection during the build. For large collections, plan the unique index creation during a maintenance window or low-traffic period.

## Create compound indexes

Compound index indexes multiple fields in a single index structure. Compound indexes are essential when queries filter or sort on more than one field.

```javascript
// Create a compound index on category.name (ascending) and price (descending)
db.products.createIndex({ "category.name": 1, price: -1 });
```

Let's dig into how compound indexes work and how to design them effectively in the next section.

### Understand index prefixes

A compound index supports queries on any **prefix** of the indexed fields. A prefix is a starting subset of the fields in the index, in the order they're defined.

For the index `{ "category.name": 1, price: -1, "reviewSummary.averageRating": -1 }`, the usable prefixes are:

- `{ "category.name": 1 }` (first field only)
- `{ "category.name": 1, price: -1 }` (first two fields)
- `{ "category.name": 1, price: -1, "reviewSummary.averageRating": -1 }` (all three fields)

A query that filters only on `price` (without `category.name`) can't use this index efficiently because `price` isn't a prefix. You have to follow the field order defined in the index to get the performance benefits.

Let's create this compound index and see how different queries utilize it:

```javascript
// Create the compound index
db.products.createIndex({ "category.name": 1, price: -1, "reviewSummary.averageRating": -1 });
```

This query uses the index because it matches the first field in the index:

```javascript
db.products.find({ "category.name": "Mountain Bikes" });
```

This query also uses the index because it matches the first two fields in the index:

```javascript
db.products.find({ "category.name": "Mountain Bikes", price: { $lte: 500 } });
```

This query does NOT use the index because it doesn't match the prefix order (price alone isn't a prefix):

```javascript
db.products.find({ price: { $lte: 500 } });
```

This prefix behavior means a well-designed compound index can serve multiple query patterns without creating separate single-field indexes.

### Apply the ESR rule for optimal field ordering

The **Equality, Sort, Range** (ESR) rule is the most important principle for ordering fields in a compound index. Place fields in this order:

1. **Equality** fields first: fields used with exact match operators (`$eq`, `$in`)
2. **Sort** fields next: fields used in `.sort()` operations
3. **Range** fields last: fields used with range operators (`$gt`, `$gte`, `$lt`, `$lte`)

Why this order matters:

- **Equality fields** narrow the index scan to the exact matching entries. Placing them first eliminates the largest portion of the index from consideration.
- **Sort fields** in the middle, positioned before range fields to keep the index scan narrow before ranges are applied.
- **Range fields** at the end define a contiguous range within the already-narrowed subset.

Consider this query that filters by category, sorts by average rating, and applies a price range:

```javascript
// Query: find mountain bikes priced between $50 and $2000, sorted by rating
db.products.find({
  "category.name": "Mountain Bikes",               // Equality
  price: { $gte: 50, $lte: 2000 }                   // Range
}).sort({ "reviewSummary.averageRating": -1 });       // Sort

// Optimal compound index following ESR:
// Equality (category.name) → Sort (reviewSummary.averageRating) → Range (price)
db.products.createIndex({ "category.name": 1, "reviewSummary.averageRating": -1, price: 1 });
```

In this example, the index efficiently filters to the "Mountain Bikes" category first, then sorts those results by average rating, and finally applies the price range to the sorted subset. 

> [!IMPORTANT]
> In Azure DocumentDB, sorting is performed in-memory by default and doesn't push down to indexes. Unlike standard MongoDB, placing sort fields in a compound index doesn't eliminate the in-memory sort step; it still occurs. Index pushdown optimization for `$sort` is available in preview. The sort memory limit varies by cluster tier. To stay within this limit, apply `$match` stages early in your pipeline to reduce the number of documents that reach the sort stage.

If you reverse the order and place the range field before the sort field, the equality and range fields are no longer optimally ordered. This new order increases the number of documents that must be sorted in-memory.

### Consider sort direction in compound indexes

For compound indexes, the sort direction of each field matters when your query sorts on multiple fields. The index sort directions must either match the query's sort specification exactly or be the complete inverse.

Consider an index on: { "category.name": 1, price: -1 }
- ✓ Supported sort: { "category.name": 1, price: -1 } (matches)
- ✓ Supported sort: { "category.name": -1, price: 1 } (complete inverse)
- ✗ NOT supported: { "category.name": 1, price: 1 } (both ascending, not matching the index's mixed directions)

The first two sorts are supported because they maintain a consistent order across all fields and are an inverse of each other (in each sort one was ascending and the other was descending). The last sort isn't supported because it mixes ascending and descending directions in a way that doesn't align with the index structure (both were ascending while the index was mixed). 

### Azure DocumentDB compound index limits

Azure DocumentDB supports a maximum of 32 fields in a compound index. In practice, most compound indexes use two to four fields. An index with more fields increases storage and write overhead without proportional benefit.

When you design a compound index, think about it as a filtering funnel: each field in the index narrows the result set further. The ESR rule ensures that the narrowing happens in the most efficient order, so fewer index entries are examined before reaching the final result.

## Choose between a compound index and multiple single-field indexes

Two single-field indexes on `category.name` and `price` don't perform the same as a compound index on `{ "category.name": 1, price: 1 }`. With separate indexes, the database can only use one index per query, so it still scans more documents than necessary. A compound index handles both fields together in a single lookup, which is faster.

Use a compound index when queries regularly filter or sort on the same combination of fields. Use separate single-field indexes when queries filter on each field independently and rarely combine them.

Single-field and compound indexes cover most indexing needs. By applying the ESR rule and understanding prefix behavior, you can serve multiple query patterns from a single well-designed compound index rather than maintaining many overlapping indexes. In the next unit, you explore specialized index types for arrays, dynamic schemas, and full-text search.
