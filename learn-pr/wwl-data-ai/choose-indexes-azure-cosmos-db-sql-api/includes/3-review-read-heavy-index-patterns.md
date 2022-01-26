Some applications' workloads are read-centric, requiring SQL queries that filter on many different fields in each item. These read-centric workloads benefit from having an inverted index that includes as many fields as possible to maximize query performance and minimize request unit charges.

By default, Azure Cosmos DB SQL API creates containers that include an indexing policy that includes the root path. This strategy effectively includes all possible JSON properties in the index. The default indexing policy also excludes the **eTag** property path by default. In the inverted index, the result will be an index that indexes all properties except eTag.

This is the complete JSON object for the default indexing policy:

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
      "path": "/\"_etag\"/?"
    }
  ]
}
```

Let’s consider a JSON object for a product with a metadata object with fields never used in any queries and a description property used in query results but never included in a filter due to its sheer size.

```json
{
  "id": "3324789",
  "name": "Road-200 Green",
  "price": 510.55,
  "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras faucibus, turpis ut pulvinar bibendum, sapien mauris fermentum magna, a tincidunt magna diam tincidunt enim. Fusce convallis justo nulla, at tristique diam tempus vel. Suspendisse potenti. Curabitur rhoncus neque vel elit condimentum finibus. Nullam porta lorem vitae enim tincidunt elementum. Vestibulum id felis sit amet neque commodo scelerisque. Suspendisse euismod ex ut hendrerit eleifend. Quisque euismod consectetur vulputate.",
  "metadata": {
    "created_by": "sdfuouu",
    "created_on": "2020-05-05T19:21:27.0000000Z",
    "department": "cycling",
    "sku": "RD200-G"
  }
}
```

When designing an indexing policy, you should consider the needs of your SQL queries. In this fictional example, the **description** and **metadata** properties are never used in SQL queries. The easiest way to design this indexing policy is to include all paths and then selectively exclude the **description** and **metadata** property paths.

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
      "path": "/description/?"
    },
    {
      "path": "/metadata/*"
    }
  ]
}
```

Alternatively, you can exclude all paths and only selectively include the **name** and **price** property paths.

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    {
      "path": "/name/?"
    },
    {
      "path": "/price/?"
    }
  ],
  "excludedPaths": [
    {
      "path": "/*"
    }
  ]
}
```

> [!TIP]
> The drawback to this approach is that you will need to update the index anytime you change your schema.
