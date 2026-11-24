As the Adventure Works Cycles issue list grows, managers need to browse multiple pages and see a summary of issues by status. This unit explains pagination and aggregation through code examples, which you apply in the next exercise.

## Single-page query results

`execute()` returns a single page, with 100 records by default, without pagination metadata. When a query matches more rows than the page size, the result contains only that page, not all matching rows. A single-page query suits a bounded result, such as a small lookup table. Pagination supports lists that can grow beyond one page.

## Cursor-based pagination

The `first(n)` method specifies the page size for `executePaginated()`. The result has `items`, `hasNextPage`, and `endCursor`. In the following example, `after()` takes the returned cursor to fetch the next page, and the loop collects the items across all pages:

```typescript
const query = client.data.Issue
  .select(['id', 'title', 'reportedOn'])
  .orderBy({ reportedOn: 'desc' })
  .orderBy({ id: 'asc' })
  .first(25);

let page = await query.executePaginated();
const all = [...page.items];
while (page.hasNextPage && page.endCursor) {
  page = await query.after(page.endCursor).executePaginated();
  all.push(...page.items);
}
```

The `select`, `where`, and `orderBy` settings stay identical across every page in a sequence. The cursor advances correctly only with a stable sort order. In the example, `reportedOn` can hold duplicate timestamps, so the unique `id` column serves as the last sort key.

Three limits shape UI design:

- **Pagination is forward-only.** There is no `before` or `last`. A paged UI keeps the next-page cursor in state.
- **`totalCount` is never populated.** The type has the field, but you can't rely on it.
- **A page size has a maximum.** `first(n)` is bounded by 100,000. Smaller pages let an app load results incrementally rather than request everything in one large call.

## Server-side aggregation

Aggregation computes values across many rows on the server instead of reading rows and reducing them in the browser. The following example groups issues by status, counts issues, and sums the affected units with `groupBy()`, `aggregate()`, and `execute()`:

```typescript
const byStatus = await client.data.Issue
  .groupBy(['status'])
  .aggregate({
    issues: { count: 'unitsAffected' },
    affected: { sum: 'unitsAffected' },
  })
  .execute();

for (const row of byStatus) {
  console.log(row.fields.status, row.aggregations.issues, row.aggregations.affected);
}
```

Each result row has `fields`, the grouped values, and `aggregations`, one entry per alias you choose. The operations are `sum`, `avg`, `min`, `max`, and `count`. Each alias takes exactly one operation. A query without `groupBy()` returns one grand-total row.

The following rules describe how aggregation queries work:

| Behavior | Consequence |
| :--------- | :------------ |
| Every operation, including `count`, accepts numeric fields only | `count` counts non-null numeric values, not rows. You can't count a text field. |
| There is no `count()` on the query chain | A `count` on a non-nullable numeric column gives a row count. Another approach totals the number of items across all result pages. |
| Aggregation can't combine with `select`, `orderBy`, `first`, or `after` | Aggregation runs as a separate query. The returned array can be sorted in TypeScript. |

`sum`, `avg`, `min`, and `max` return `number | null`, because a group with no values returns `NULL`. `count` is always a number.

In the previous example, `unitsAffected` is a required numeric field that every row populates, so `count` on it equals the number of issues in each group.

A coding agent can also generate a paged list or a summary. The same rules apply to generated code: pagination uses `first` and `executePaginated`, aggregation runs as a separate query, and aggregate operations accept only numeric fields.

## Next step

In the next exercise, you generate more than 100 issues, compare single-page results with cursor pagination, and add a status summary.
