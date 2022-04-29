Let's review a few sample queries to understand better how you can use the information in the indexing metrics.

This first SQL query returns all items in the container with a price property whose value is greater than 500.

```sql
SELECT 
    * 
FROM 
    products p 
WHERE 
    p.price > 500
```

All queries in this example assume that we are using the default indexing policy that:

- Uses the **consistent** indexing mode and automatically indexes items
- Includes all property paths
- Expressly excludes the **eTag** property path
- Does not contain any composite indexes

If you run this query and output the indexing metrics, you will find that the metrics indicate the ``/price/?`` field in the index is impacted significantly by this query. The default indexing policy includes this field, so the indexing metrics do not recommended to add this field to the index.

```bash
Index Utilization Information
  Utilized Single Indexes
    Index Spec: /price/?
    Index Impact Score: High
    ---
  Potential Single Indexes
  Utilized Composite Indexes
  Potential Composite Indexes
```

The filter is slightly more complex for the following query by using a built-in string function to find items whose **name** property starts with the term **Touring**.

```sql
SELECT 
    * 
FROM 
    products p 
WHERE 
    p.price > 500 AND 
    startsWith(p.name, 'Touring')
```

The indexing metrics for this query indicate that both the ``/price/?`` and ``/name/?`` property paths have a high impact. The default indexing policy covers both of these fields, so no extra indexes are recommended at this time.

```bash
Index Utilization Information
  Utilized Single Indexes
    Index Spec: /price/?
    Index Impact Score: High
    ---
    Index Spec: /name/?
    Index Impact Score: High
    ---
  Potential Single Indexes
  Utilized Composite Indexes
  Potential Composite Indexes
```

The final sample query uses an equality filter based on the value of the **categoryName** field. In this example, the field must equal **Bikes, Touring Bikes** per the filter expression.

```sql
SELECT 
    * 
FROM 
    products p 
WHERE 
    p.price > 500 AND 
    p.categoryName = 'Bikes, Touring Bikes'
```

Now, the indexing metrics will make a stronger recommendation. As expected, the impact of the ``/price/?`` and ``/categoryName/?`` property paths is high. However, the indexing metrics now recommend that we create a composite index with both property paths to improve the performance of future queries.

```bash
Index Utilization Information
  Utilized Single Indexes
    Index Spec: /price/?
    Index Impact Score: High
    ---
    Index Spec: /categoryName/?
    Index Impact Score: High
    ---
  Potential Single Indexes
  Utilized Composite Indexes
  Potential Composite Indexes
    Index Spec: /categoryName ASC, /price ASC
    Index Impact Score: High
    ---
```

You can create a new indexing policy with a composite index that includes both the price and categoryName property paths in ascending order to implement this recommendation.

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    {
      "path": "/*"
    }
  ],
  "excludedPaths": [],
  "compositeIndexes": [
    [
      {
        "path": "/categoryName",
        "order": "ascending"
      },
      {
        "path": "/price",
        "order": "ascending"
      }
    ]
  ]
}
```

After allowing the index to update, you can then rerun the query in .NET to observe the latest indexing metrics. The new metrics metadata indicates that the composite index was utilized in the latest execution of the query.

```bash
Index Utilization Information
  Utilized Single Indexes
  Potential Single Indexes
  Utilized Composite Indexes
    Index Spec: /categoryName ASC, /price ASC
    Index Impact Score: High
    ---
  Potential Composite Indexes
```
