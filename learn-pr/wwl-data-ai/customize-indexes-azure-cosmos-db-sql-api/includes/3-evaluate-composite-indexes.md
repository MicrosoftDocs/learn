It’s not uncommon to have a query sort or filter on multiple properties. In these scenarios, customizing the indexing policy in small ways could reap benefits in the performance of those queries.

For example, if you are writing SQL queries that filters on multiple properties simultaneously, you could benefit from a particular type of index called a **composite index** that combines two paths in a specific order.

Let’s look at an example query:

```sql
SELECT * FROM products p WHERE p.name = "Road Saddle" AND p.price > 50
```

This query includes two filters:

- An equality filter that checks the value of the **name** property for equivalency to the string ``Road Saddle``.

- A range filter that checks to see if the value of the **price** property is greater than the number ``50``.

If the query is able to use a composite index, that includes both the **name** and **price** properties. That composite index could be:

- ``(name ASC, price ASC)``

- ``(name DESC, price ASC)``

> [!NOTE]
> In this example, the range filter appeared last. This is a best practice for queries with multiple filters that leverage a composite index.

Going even deeper, queries that order the results using multiple properties must include a composite index.

Let’s look at another example query:

```sql
SELECT * FROM products p ORDER BY p.price ASC, p.name ASC
```

The composite index that will support this query must exactly match the sequence of the properties in the ORDER BY clause. A composite index of ``(name ASC, price ASC)`` would not work in this example. Composite indexes such as these will work in this scenario:

- ``(price ASC, name ASC)``

- ``(price DESC, name ASC)``

> [!TIP]
> You can also use composite indexes with queries that have different permutations of filters and order by clauses.

To create a raw JSON indexing policy with a composite index, you should include the optional **compositeIndexes** array property. This external array consists of a series of internal arrays for each composite index definition.

For example, to create a composite index of ``(name ASC, price DESC)``, you can define a JSON object with this structure:

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    {
      "path": "/*"
    }
  ],
  "excludedPaths": [
    {
      "path": "/_etag/?"
    }
  ],
  "compositeIndexes": [
    [
      {
        "path": "/name",
        "order": "ascending"
      },
      {
        "path": "/price",
        "order": "descending"
      }
    ]
  ]
}
```

> [!TIP]
> Remember, you can define multiple composite indexes within your indexing policy for various important queries that your application\[s\] require.
