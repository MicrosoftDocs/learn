Including a path gets you a range index, and a range index supports many query shapes. It doesn't answer everything. Sorting across several properties requires a composite index, while filtering across several properties can benefit from one. Spatial indexes support efficient geospatial filters on coordinates. This unit covers both index types. You add the index to meet a specific query requirement or improve its performance, not because the property looks important.

## Composite indexes

A composite index covers an ordered list of two or more property paths. No composite indexes exist by default, so every one of them is a decision you make.

Composite paths follow different rules from included and excluded paths. Each path has an implicit `/?`, so you write `/price`, not `/price/?`. The `/*` wildcard isn't supported. Paths are case-sensitive. And the sequence you write the paths in is part of the index.

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    { "path": "/*" }
  ],
  "excludedPaths": [
    { "path": "/\"_etag\"/?" }
  ],
  "compositeIndexes": [
    [
      { "path": "/categoryId", "order": "ascending" },
      { "path": "/price", "order": "descending" }
    ]
  ]
}
```

### Sorting on multiple properties

An `ORDER BY` on a single property needs a range index and fails without one. An `ORDER BY` on two or more properties needs a composite index and fails without one, so a composite index is a requirement rather than an optimization.

The catalog query that lists a category from most to least expensive is exactly that shape:

```sql
SELECT *
FROM c
WHERE c.categoryId = "AE48F0AA-4F65-4734-A4CF-D48B8F82267F"
ORDER BY c.categoryId, c.price DESC
```

The composite index shown earlier serves it, and three rules explain why:

- The composite paths appear in the same sequence as the `ORDER BY` properties. A composite index on `(price, categoryId)` doesn't serve an `ORDER BY c.categoryId, c.price`.
- The `order` on each path matches the clause.
- The index also serves the fully reversed clause, `ORDER BY c.categoryId DESC, c.price ASC`, because reversing every path is the same traversal read backward. Reversing only one of them isn't.

Notice that the filter property is repeated in the `ORDER BY` clause. To bring a filtered query onto a composite index, use the standard approach: add the filtered properties to the front of the `ORDER BY`, with equality filters first.

### Filtering on multiple properties

Composite indexes also reduce the charge on queries that filter on several properties, even with no sorting involved. Here, the rules change:

- At least one filter has to be an equality filter, and equality filters come first in the index.
- A range filter (`>`, `<`, `>=`, `<=`, `!=`) has to be defined last, and one composite index optimizes at most one range filter. To optimize both range filters in a query, define two matching composite indexes. The query can still run with range indexes alone.
- Every property in the composite index has to appear in the query's filter. A property in the index that the query doesn't filter on means the index goes unused.
- The `order` values don't matter for filtering, only for sorting.

| Composite index | Query filter | Served |
| :--- | :--- | :--- |
| `(categoryId ASC, price ASC)` | `c.categoryId = "..." AND c.price > 2000` | Yes |
| `(price ASC, categoryId ASC)` | `c.categoryId = "..." AND c.price > 2000` | No |
| `(categoryId ASC, price ASC)` | `c.categoryId != "..." AND c.price > 2000` | No |

> [!NOTE]
> While a new composite index is being built, queries keep using the existing range indexes, so the performance improvement shows up only after the transformation completes. That's the reason for the add-before-remove rule from the previous unit.

## Spatial indexes

Azure Cosmos DB creates no spatial indexes by default. If you want to use the geospatial system functions, you define one on the path that holds the coordinates.

A spatial index declares which GeoJSON shapes to index at a path. Four types are supported: `Point`, `Polygon`, `MultiPolygon`, and `LineString`. Consider a store locator container whose items carry a `location` property holding a GeoJSON point:

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    { "path": "/*" }
  ],
  "excludedPaths": [
    { "path": "/\"_etag\"/?" }
  ],
  "spatialIndexes": [
    {
      "path": "/location/*",
      "types": [ "Point", "Polygon" ]
    }
  ]
}
```

With that index in place, filters using `ST_DISTANCE`, `ST_WITHIN`, and `ST_INTERSECTS` can use the spatial index. These functions don't benefit from the spatial index in queries with aggregates. The following nonaggregate query can use it:

```sql
SELECT s.name
FROM s
WHERE ST_DISTANCE(s.location, { "type": "Point", "coordinates": [-122.12827, 47.63980] }) < 40000
```

Two constraints are worth knowing before you design around spatial data. For the index to apply, the values have to be correctly formed GeoJSON. And Azure Cosmos DB spatial indexing isn't equivalent to the MongoDB `2dsphere` index, even through the API for MongoDB, so a migrated application can see different performance behavior for the same geospatial query.

## Choose between them

The two index types answer different questions, and the decision is mechanical once you look at the query:

| The query | Index requirement or optimization |
| :--- | :--- |
| Sorts on 1 property | Range index on that path, which the default policy already provides |
| Sorts on 2 or more properties | Composite index in the same sequence and order |
| Filters on 2 or more properties, at least 1 equality | Optional composite index for lower request charge, with equality paths first and 1 range path last |
| Uses `ST_DISTANCE`, `ST_WITHIN`, or `ST_INTERSECTS` in a nonaggregate filter | Spatial index on the coordinate path for indexed evaluation |

Learn more about [composite indexes](/azure/cosmos-db/index-policy#composite-indexes) and [indexing and querying GeoJSON data](/azure/cosmos-db/how-to-geospatial-index-query).
