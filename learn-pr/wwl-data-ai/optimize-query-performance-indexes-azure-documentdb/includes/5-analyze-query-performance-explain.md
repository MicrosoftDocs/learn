The `explain()` method is the primary diagnostic tool for understanding how Azure DocumentDB executes a query. It shows you whether a query uses an index, how many documents it examines, and how long it takes, without modifying any data.

## Use the explain() method

Append `.explain()` to any query to see the execution plan. The method supports three verbosity modes:

| Mode | Description | Use case |
|------|-------------|----------|
| `"queryPlanner"` | Shows the selected execution plan without running the query. | Quick check of index selection. |
| `"executionStats"` | Runs the query and reports detailed performance metrics. | Performance diagnosis. Most useful mode. |
| `"allPlansExecution"` | Runs all candidate plans and reports stats for each. | Comparing which plan the optimizer chose and why. |

```javascript
// Default mode: queryPlanner
db.products.find({ "category.name": "Mountain Bikes" }).explain();

// Recommended: executionStats shows actual performance numbers
db.products.find({ "category.name": "Mountain Bikes" }).explain("executionStats");

// Full analysis: compare all candidate plans
db.products.find({ "category.name": "Mountain Bikes" }).explain("allPlansExecution");
```

## Read the execution stats output

The `executionStats` mode provides key metrics for diagnosing query performance. Here's what to look for:

Let's say you run this query with `explain("executionStats")`:

```javascript
db.products.find({ "category.name": "Mountain Bikes", price: { $lte: 2000 } }).explain("executionStats");
```

The output includes several important fields:

| Metric | Description | What to look for |
|--------|-------------|-----------------|
| `nReturned` | Number of documents returned by the query. | Your expected result count. |
| `totalKeysExamined` | Number of index entries scanned. | Should be close to `nReturned`. |
| `totalDocsExamined` | Number of full documents read from disk. | Should be close to `nReturned`. |
| `executionTimeMillis` | Total query execution time in milliseconds. | Lower is better. |
| `stage` | The execution strategy used. | `IXSCAN` (good) or `COLLSCAN` (needs an index). |

Different metrics tell you different things about query performance. We'll go through common patterns and what they indicate about your indexes in the next section.

### Identify ideal performance indicators

A well-indexed query has these characteristics:

- **`stage` equals `IXSCAN`**: the query uses an index instead of scanning the entire collection.
- **`totalKeysExamined` is close to `nReturned`**: the index efficiently narrows results without examining many extra entries.
- **`totalDocsExamined` is close to `nReturned`**: the database reads only the documents it returns.
- **`executionTimeMillis` is low**: relative to the dataset size and query complexity.

These indicators show that the query is efficiently using indexes to find results without unnecessary scanning or sorting. If any of these metrics are off, it points to specific issues with your indexing strategy that you can address.

### Calculate the efficiency ratio

The ratio between examined entries and returned documents tells you how efficiently the index serves the query:

```
Efficiency ratio = nReturned / totalKeysExamined
```

- A ratio of **1.0** means every examined index entry results in a returned document. That's perfect efficiency.
- A ratio of **0.1** means the query examines 10 index entries for every document it returns. The index isn't selective enough for this query pattern.

## Diagnose common performance problems

The `explain()` output reveals specific patterns that point to indexing issues. Here are the most common problems and how to fix them.

### Collection scan on a large collection

Consider the following explain output for a query that filters on `productType`:

```javascript
// Explain output shows COLLSCAN
db.products.find({ productType: "bike" }).explain("executionStats");
// stage: "COLLSCAN"
// totalDocsExamined: 500000
// nReturned: 230
// executionTimeMillis: 1850
```

**Problem:** No index on the `productType` field. The database scans all 500,000 documents to find 230 matches.

**Fix:** Create a single-field index on `productType`:

```javascript
db.products.createIndex({ productType: 1 });
```

When creating more indexes, remember that Azure DocumentDB has a maximum of 64 indexes per collection (with possible extensions up to 300). Plan your indexing strategy carefully to stay within these limits.

### Wrong index selected

Sometimes the database has an index that partially matches the query, but a better index is possible. Look for a large gap between `totalKeysExamined` and `nReturned`:

Let's say you have a single-field index on `category.name` but your query also sorts by `price`:

```javascript
// Query filters on category.name and sorts by price
db.products.find({ "category.name": "Mountain Bikes" }).sort({ price: 1 }).explain("executionStats");
// stage: "IXSCAN" (using {"category.name": 1} index)
// totalKeysExamined: 5000
// nReturned: 5000
// But there's also a SORT stage (in-memory sort on price)
```

**Problem:** The `{"category.name": 1}` index handles the filter but not the sort. The database performs an in-memory sort on the 5,000 matching documents.

**Fix:** Create a compound index that covers both the filter and sort:

```javascript
db.products.createIndex({ "category.name": 1, price: 1 });
```

Now the query can use the compound index to both filter and sort, eliminating the in-memory sort step.

### In-memory sort exceeding limits

If a sort operation exceeds the cluster's memory limit for sorting, the query fails with an error similar to:

```
Sort exceeded memory limit of 33554432 bytes
```

The specific limit varies by cluster tier. **Fix:** Apply `$match` stages early in your pipeline to reduce the number of documents that reach the sort stage, or ensure the sort field is included in the index.

## Use explain() for update and delete operations

The `explain()` method also works with update and delete operations to verify they use indexes for the filter criteria.

The verbosity mode matters for write operations. Use `"queryPlanner"` mode to analyze the execution plan without actually modifying any documents. Use `"executionStats"` only when you want real execution metrics and are willing to have the write execute:

First, analyze the plan without executing the write:

```javascript
// Safe: analyzes the plan without executing the write
db.products.explain("queryPlanner").updateMany(
  { "category.name": "Mountain Bikes", "inventory.quantityAvailable": 0 },
  { $set: { clearance: true } }
);
```

Then, if the plan looks good, execute the update and get performance stats:

```javascript
// Executes the write AND returns execution stats
db.products.explain("executionStats").updateMany(
  { "category.name": "Mountain Bikes", "inventory.quantityAvailable": 0 },
  { $set: { clearance: true } }
);
```

This metric is especially important for bulk operations. An update without an index performs a collection scan to find matching documents, which locks more resources and takes longer to complete.

## Build a diagnostic workflow

Follow this process when investigating slow queries:

1. **Identify the slow query**: check application logs or use the database profiler.
1. **Run explain("executionStats")**: look at the execution plan and key metrics.
1. **Check the stage**: if it's `COLLSCAN`, create an appropriate index.
1. **Compare examined vs. returned**: if `totalKeysExamined` is much higher than `nReturned`, the index isn't selective enough. Consider a more targeted compound index.
1. **Look for in-memory sorts**: if a `SORT` stage appears, add the sort field to the index following the ESR (Equality, Sort, Range) rule.
1. **Re-run explain()** after creating or modifying the index to verify the improvement.

The `explain()` command turns index optimization from guesswork into a data-driven process. Rather than creating indexes based on assumptions, you can measure exactly which queries need help, apply a targeted fix, and verify the result in seconds. In the next unit, you learn how to monitor index health over time and maintain an efficient index set as your application evolves.
