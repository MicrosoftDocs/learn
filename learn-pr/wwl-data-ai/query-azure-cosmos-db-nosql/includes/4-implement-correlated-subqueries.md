The Contoso merchandising team labels products with tags, and the promotions page asks a question the previous unit can't answer: which products carry a given tag? The condition lives inside an array of objects, and a top-level comparison such as `p.tags = @tag` doesn't reach it. In this unit, you use subqueries to filter and reshape data nested inside an item.

## What a subquery is

A subquery is a query nested inside another query. Azure Cosmos DB for NoSQL supports two kinds, and the difference is whether the subquery depends on the item the outer query is examining.

- A **non-correlated** subquery doesn't reference anything from the outer query, so it can run on its own.
- A **correlated** subquery references a value from the outer query, so the engine evaluates it once per outer item.

Almost every subquery you write against nested data is correlated, because the point is to look inside the item the outer query is currently examining.

Here's the catalog item again, with the array that matters:

```json
{
    "id": "80D3630F-B661-4FD6-A296-CD03BB7A4A0C",
    "categoryId": "629A8F3C-CFB0-4347-8DCC-505A4789876B",
    "name": "Classic Vest, L",
    "price": 63.5,
    "tags": [
        { "id": "2CE9DADE-DCAC-436C-9D69-B7C886A01B77", "name": "Tag-101" },
        { "id": "CA170AAD-A5F6-42FF-B115-146FADD87298", "name": "Tag-186" }
    ]
}
```

Each tag is an object with its own identifier and a name, and the same tag appears on many products. Plenty of products carry an empty `tags` array, which matters later in this module.

Inside a subquery, `IN` iterates an array. The expression `t IN p.tags` binds `t` to each element of the current item's `tags` array in turn, and `p` is the correlation back to the outer query:

```sql
SELECT VALUE t FROM t IN p.tags WHERE t.name = @tag
```

On its own, that fragment isn't a complete query. It's the building block the rest of this unit composes.

## Filter items by what's inside an array

`EXISTS` takes a subquery and returns true when the subquery produces at least one result. `EXISTS` is therefore the tool for "products that have a tag matching this condition":

```sql
SELECT p.id, p.name
FROM product p
WHERE EXISTS (
    SELECT VALUE t
    FROM t IN p.tags
    WHERE t.name = @tag
)
```

Each item appears at most once in the results, no matter how many tags match. That property matters: the promotions page wants a list of products, not a list of product-and-tag pairs.

### One element, or two different elements

The subtlest decision with `EXISTS` appears when a match depends on more than one property of an array element. The `salesOrder` documents in this dataset make it concrete, because each order line carries four properties:

```json
{
    "id": "06794E40-1A3E-49B6-9914-94438A2D8813",
    "type": "salesOrder",
    "customerId": "44A6D5F6-AF44-4B34-8AB5-21C5DC50926E",
    "orderDate": "2014-03-30T00:00:00",
    "shipDate": "2014-04-06T00:00:00",
    "details": [
        { "sku": "TI-R982", "name": "HL Road Tire", "price": 32.6, "quantity": 1 },
        { "sku": "TT-R982", "name": "Road Tire Tube", "price": 3.99, "quantity": 1 },
        { "sku": "HL-U509-R", "name": "Sport-100 Helmet, Red", "price": 34.99, "quantity": 1 }
    ]
}
```

Both conditions inside one subquery ask whether a **single line** costs more than 30 and is a road part:

```sql
SELECT o.id, o.orderDate
FROM customer o
WHERE o.type = 'salesOrder'
  AND EXISTS (
      SELECT VALUE d
      FROM d IN o.details
      WHERE d.price > 30 AND STARTSWITH(d.name, 'Road')
  )
```

Splitting them into two separate `EXISTS` clauses asks a different question: it matches an order that has *some* line over 30 and *some* road part, even when they're different lines. This order matches the second version and fails the first, because no single line satisfies both conditions: the two lines over 30 are a tire and a helmet, and the only line whose name starts with `Road` costs 3.99. Deciding which question you're asking is the part that's easy to get wrong.

### Simpler membership checks

When the question is plain membership, `ARRAY_CONTAINS` expresses it with less syntax. Against an array of scalars, it compares values directly. Against an array of objects, a third argument enables partial matching, so you can test one property of an element without writing a subquery:

```sql
SELECT p.id, p.name
FROM product p
WHERE ARRAY_CONTAINS(p.tags, { "name": @tag }, true)
```

Two related functions test several values at once, matching on exact equality rather than on part of an object. `ARRAY_CONTAINS_ANY` matches when the array holds at least one of the listed values, and `ARRAY_CONTAINS_ALL` matches only when it holds every one.

The boundary between these functions and `EXISTS` is clear. They answer membership questions and nothing else. As soon as a match depends on a comparison other than equality, the way `d.price > 30` does in the order lines, `EXISTS` is the option that works.

Index behavior differs across the three. `ARRAY_CONTAINS` benefits from the range index. The partial-match form can still lead to inefficient execution, and an equivalent `EXISTS` subquery is the better choice on a request path. `ARRAY_CONTAINS_ANY` and `ARRAY_CONTAINS_ALL` don't use the index at all, so keep them behind an indexed filter such as the partition key rather than running them across a whole container.

## Project a filtered array

An `ARRAY` expression wraps a subquery and returns its results as an array, which lets you return part of a nested array instead of all of it:

```sql
SELECT
    p.id,
    p.name,
    ARRAY(
        SELECT VALUE t.name
        FROM t IN p.tags
    ) AS tagNames
FROM product p
WHERE p.categoryId = @category
```

```json
{
    "id": "80D3630F-B661-4FD6-A296-CD03BB7A4A0C",
    "name": "Classic Vest, L",
    "tagNames": ["Tag-101", "Tag-186"]
}
```

The item keeps its identity and gains a flattened array of names instead of the full tag objects. To return only part of the array, add a `WHERE` clause inside the subquery. Either way, items whose array is empty still appear, with an empty array. That behavior is the difference between shaping results with `ARRAY` and filtering them with `EXISTS`.

### Compute a scalar from nested data

A subquery that returns a single value can be projected directly. Aggregates work inside a subquery, so the catalog can report how many tags each product carries:

```sql
SELECT
    p.name,
    (SELECT VALUE COUNT(1) FROM t IN p.tags) AS tagCount
FROM product p
WHERE p.categoryId = @category
```

Wrapping the subquery in parentheses without `ARRAY` yields the scalar rather than a one-element array.

## Where the cost goes

A correlated subquery runs once per item that reaches it. Indexed outer filters can reduce that work, but index lookups and document loading still consume request units. Give the outer query indexed predicates to work with:

```sql
SELECT p.id, p.name
FROM product p
WHERE p.categoryId = @category
  AND p.price <= @max
  AND EXISTS (SELECT VALUE t FROM t IN p.tags WHERE t.name = @tag)
```

The `categoryId` and `price` comparisons resolve from the index, and the engine applies them before it walks any arrays. Where those comparisons sit in the `WHERE` clause makes no difference, because the query engine works out which predicates are most selective and orders the evaluation itself. What matters is that the indexed predicates are there at all: without them, the subquery runs against every item the query reaches.

Two more habits keep subquery costs predictable. Project inside the subquery with `SELECT VALUE t.name` rather than `SELECT VALUE t` when you need only one field of each element. And keep the partition key in the outer filter, because a correlated subquery does nothing to reduce the number of partitions a query touches.

---

> **Guiding question:** Think about an array property in your own data, such as tags, line items, or permissions. Are your current queries reading whole items into application code and filtering the array there? Each of those queries is a candidate for `EXISTS` or `ARRAY`, which moves the filter to the service and shrinks what crosses the network.
