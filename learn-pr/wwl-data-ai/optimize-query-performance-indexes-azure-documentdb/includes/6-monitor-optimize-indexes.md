Creating indexes improves query performance, but indexes themselves need ongoing monitoring. Unused indexes waste storage and slow writes. Over time, application query patterns change, and your indexing strategy should evolve with them.

## Track index usage with $indexStats

The `$indexStats` aggregation stage reports how often each index is used. Run it to identify which indexes are actively serving queries and which are sitting idle:

```javascript
db.products.aggregate([{ $indexStats: {} }]);
```

The output includes one document per index with usage statistics:

```javascript
{
  name: "category.name_1_price_-1",
  key: { "category.name": 1, price: -1 },
  accesses: {
    ops: 45230,          // Total operations using this index
    since: ISODate("2026-03-01T00:00:00Z")  // When tracking started
  }
}
```

An index with zero operations (`ops: 0`) since the tracking start date is a candidate for removal. Before dropping it, confirm that the tracking period covers your full range of query patterns, including periodic reports or batch jobs that run weekly or monthly.

## Identify and remove unused indexes

Each unused index consumes storage and slows every insert, update, and delete operation. Use this process to safely identify and remove them:

1. **Collect usage stats** over a representative time period (at least one full business cycle):

    ```javascript
    db.products.aggregate([
      { $indexStats: {} },
      { $project: { name: 1, "accesses.ops": 1, "accesses.since": 1 } },
      { $sort: { "accesses.ops": 1 } }
    ]);
    ```

2. **Identify candidates**: indexes with zero or very low `ops` values relative to the tracking period.

3. **Verify with explain()**: to confirm the index isn't needed, run your known query patterns with `explain("executionStats")`:

    ```javascript
    // Verify no critical queries rely on this index
    db.products.find({ productType: "bike" }).explain("executionStats");
    ```

4. **Drop the index** once confirmed it's not needed:

    ```javascript
    db.products.dropIndex("productType_1");
    ```

> [!TIP]
> You can drop an index by its name string or by its key pattern. Use `db.collection.getIndexes()` to see both the name and key of each index.

## Identify redundant indexes

Two indexes are redundant when one is a prefix of the other. For example, if you have both `{ "category.name": 1 }` and `{ "category.name": 1, price: -1 }`, the compound index already covers queries that only filter on `category.name`. The single-field index is redundant and can be dropped:

```javascript
// These indexes exist:
// { "category.name": 1 }            ← redundant (prefix of the compound index)
// { "category.name": 1, price: -1 } ← covers single-field queries via prefix

// Safe to drop the single-field index
db.products.dropIndex("category.name_1");
```

Review your index list for prefix overlaps whenever you create a new compound index.

## Monitor index build progress

When you create an index on a collection that already contains data, the build can take time based on the data volume. Track the progress with `db.currentOp()`:

```javascript
db.currentOp();
```

Look for entries where the `command` field contains `createIndexes`. The output shows the operation's elapsed time and build progress.

By default, Azure DocumentDB responds to a `createIndex()` command only after the index is fully built. For large collections, the command might appear unresponsive for minutes. You can use the nonblocking approach to allow other operations to continue while the index builds:

```javascript
// Issue the createIndex and interrupt the wait with Ctrl+C
// The index build continues on the server
db.products.createIndex({ productType: 1 });
// Press Ctrl+C to stop waiting. The build continues asynchronously
```

> [!NOTE]
> Pressing Ctrl+C in the MongoDB Shell stops the shell from waiting for the response. It doesn't cancel the index build on the server.

## Apply an optimization workflow

Use this systematic workflow to maintain optimal index performance:

1. **Audit existing indexes**: list all indexes and their usage stats.
1. **Identify slow queries**: review application logs for queries that exceed your performance thresholds.
1. **Run explain() on slow queries**: determine whether they use collection scans or inefficient index scans.
1. **Create or refine indexes**: apply the ESR (Equality, Sort, Range) rule for compound indexes. Create specialized indexes (partial, wildcard) where appropriate.
1. **Verify improvements**: rerun explain() to confirm the new index is selected and performance improved.
1. **Drop unused indexes**: to reduce write overhead, remove indexes with zero or negligible usage.
1. **Repeat periodically**: query patterns change as applications evolve. Review your indexes on a regular schedule.

> [!NOTE]
> Index Advisor (preview) is a built-in performance tuning assistant that automates this workflow. It analyzes your query structure alongside collection and index statistics, then generates specific index recommendations with plain-English explanations. Use it as a starting point before manually tuning compound indexes. For more information, see [Tune query performance with Index Advisor in Azure DocumentDB](/azure/documentdb/index-advisor).

## Follow indexing best practices

Apply these principles when designing your indexing strategy:

- **Index queryable fields**: create indexes for fields used in filter conditions, sort operations, and aggregation pipeline stages.
- **Avoid indexing every field**: Azure DocumentDB indexes only `_id` by default for good reason. Index only the fields your queries actually use.
- **Use compound indexes strategically**: one well-designed compound index can serve multiple query patterns through prefix matching.
- **Apply the ESR rule**: order fields as Equality, Sort, Range for optimal compound index performance.
- **Consider index costs for write-heavy workloads**: if your application performs more writes than reads, limit the number of indexes to reduce write overhead.

- **Create indexes before loading data**: for migrations and bulk imports, create indexes on empty collections using the blocking option, then load data:

    ```javascript
    db.runCommand({
      createIndexes: "products",
      indexes: [{ key: { "category.name": 1, price: 1 }, name: "category_price_idx" }],
      blocking: true
    });
    ```

- **Stay within limits**: plan for a maximum of 64 indexes per collection (extendable to 300 upon request).

Index monitoring isn't a one-time task. As your application evolves and query patterns change, the indexes that were essential six months ago might be unused today while new queries go unindexed. Building a regular audit cycle into your operations workflow ensures your indexing strategy stays aligned with your actual workload.

:::image type="content" source="../media/index-types-overview.png" alt-text="Diagram of Azure DocumentDB index types organized by structure, by purpose, and index options and behaviors." lightbox="../media/index-types-overview.png":::

Throughout this module, you explored how indexes work internally. How indexes are created, how to create single-field and compound indexes using the ESR rule. How to apply specialized index types like partial, wildcard, and text indexes, and how to monitor and maintain your indexes over time. With these tools and techniques, you can design an indexing strategy that keeps your Azure DocumentDB queries fast and your write overhead under control.

