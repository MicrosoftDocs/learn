The Contoso catalog API answers a narrow set of questions over and over: show every product in a category, show products inside a price band, show the products tagged for a promotion. Each question becomes a query, and the running cost of the catalog is mostly the sum of those queries. In this unit, you build the mental model you need to read a query and predict both what it returns and what it charges.

## The shape of the data

Queries in Azure Cosmos DB for NoSQL run over JSON items, not rows. The Contoso catalog uses the `product` container, which stores one item per product and uses `/categoryId` as its partition key path:

```json
{
    "id": "80D3630F-B661-4FD6-A296-CD03BB7A4A0C",
    "categoryId": "629A8F3C-CFB0-4347-8DCC-505A4789876B",
    "categoryName": "Clothing, Vests",
    "sku": "VE-C304-L",
    "name": "Classic Vest, L",
    "description": "The product called \"Classic Vest, L\"",
    "price": 63.5,
    "tags": [
        { "id": "2CE9DADE-DCAC-436C-9D69-B7C886A01B77", "name": "Tag-101" },
        { "id": "CA170AAD-A5F6-42FF-B115-146FADD87298", "name": "Tag-186" }
    ]
}
```

Three properties set up everything that follows. `price` is a scalar at the top level, which makes filtering on it direct. `categoryName` is a copy of the category's name, stored on the product so a catalog page can render without a second lookup. `tags` is an array of objects, so reaching inside it takes syntax that the rest of this module covers.

Nothing enforces that every item carries every property, or that a property holds the same type on every item. Plenty of products in this container carry an empty `tags` array, and a product loaded by a partner feed might arrive with `price` stored as the string `"63.50"` instead of a number. The container accepts all of it, which means your queries carry the responsibility for handling it.

## Anatomy of a query

A query has three parts: a `FROM` clause that names the source, an optional `WHERE` clause that filters it, and a `SELECT` clause that shapes what comes back.

```sql
SELECT
    p.name,
    p.price
FROM
    product p
WHERE
    p.price >= 50 AND p.price <= 100
```

The identifier after `FROM` is an alias for the items in the container, not a table name. `product p`, a bare `p`, and `catalog c` all refer to the same source, because a query always runs against exactly one container: the one the SDK addresses. Most teams settle on a single-letter alias and stay consistent.

`SELECT *` returns each matching item whole. Naming properties instead returns a smaller payload, which matters because the request unit (RU) charge for a query grows with the volume of data the service reads and returns.

### How missing properties behave

A property that doesn't exist on an item evaluates to *undefined*, and a comparison against undefined isn't true or false. The item quietly fails the filter and drops out of the result set.

```sql
SELECT p.name FROM product p WHERE p.price < 100
```

A partner product with no `price` property doesn't appear in these results, and no error surfaces. That behavior is convenient when you want it and a silent data-quality bug when you don't. When the distinction matters, test for it:

| Function | Returns true when |
|:---|:---|
| `IS_DEFINED(p.price)` | The property exists on the item, even if its value is `null` |
| `IS_NULL(p.price)` | The property exists and its value is JSON `null` |
| `IS_NUMBER(p.price)` | The value is a number |
| `IS_STRING(p.price)` | The value is a string |
| `IS_ARRAY(p.tags)` | The value is an array |
| `IS_OBJECT(p.dimensions)` | The value is an object |

The following query finds the catalog items a partner feed left incomplete:

```sql
SELECT p.id, p.sku
FROM product p
WHERE NOT IS_NUMBER(p.price)
```

That query is worth running as a data-quality check, but it isn't a pattern to build a request path on. The `IS_*` functions benefit from the range index that the default policy creates, so the cost here isn't the function itself. The problem is the negation: the predicate matches every item whose `price` is missing or stored as the wrong type, which is an open-ended set on a request path that expects a page of products.

### Types and case both matter

Comparisons don't coerce across types. If one partner feed writes `"63.50"` as a string, then `p.price >= 50` skips that item regardless of its numeric value. The fix belongs in the write path or an ingestion step, not in a query that wraps every filter in a type check.

Everything about a query is case-sensitive: property names, string values, and the alias. `p.categoryName` and `p.categoryname` are two different properties, and `WHERE p.categoryName = "clothing, vests"` matches nothing when the stored value is `"Clothing, Vests"`. Keyword casing is the exception, though writing keywords in uppercase is the common convention.

## What the index does for you

Every container has an indexing policy, and by default that policy indexes every property of every item. As a result, a filter on `p.price` or `p.categoryName` resolves from the index without the engine reading each item, and a query that filters on a property added last week works without any schema change.

Two properties of a query drive most of its cost:

- **How much the engine has to read.** A filter that the index can serve touches far less data than one that forces a scan.
- **How many partitions it touches.** A query that matches the partition key value with an equality filter, or that supplies it through the SDK, runs against a single physical partition. An `IN` filter on the partition key narrows the query to only the physical partitions that hold those values. A range filter on the partition key narrows nothing: it fans out to every partition, exactly as a query that omits the partition key does.

The Contoso catalog partitions by `/categoryId`, so a category-scoped browse is a single-partition query and a global "search everything" query isn't. That difference is often larger than any tuning you apply to the query text.

---

> **Guiding question:** Look at the queries your own application runs most often. For each one, ask two questions: does the filter include the partition key value, and does the `SELECT` return properties nobody uses? Those two answers usually account for most of what a read-heavy workload costs.
