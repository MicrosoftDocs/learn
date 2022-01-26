All data in Azure Cosmos DB SQL API containers is indexed by default. This occurs because the container includes a default **indexing policy** that’s applied to all newly created containers. The default indexing policy consists of the following settings:

- The inverted index is updated for all create, update, or delete operations on an item
- All properties for every item is automatically indexed
- Range indexes are used for all strings or numbers

Indexing policies are defined and managed in JSON. The default indexing policy for a new container in Azure Cosmos DB SQL API includes the following components:

| **Component** | **Description** | **Default value** |
| ---: | :--- | :--- |
| **Indexing mode** | Configures whether indexing is enabled (Consistent) or not (None) for the container | **Consistent** |
| **Automatic** | Configures whether automatically indexes items as they are written | **Enabled** |
| **Included paths** | Set of paths to include in the index | **All (\*)** |
| **Excluded paths** | Set of paths to exclude from the index | **_etag property path** |

The default indexing policy, in JSON, contains the following content:

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

## Configure indexing mode

There are two primary indexing mode options for most Azure Cosmos DB SQL API containers.

The **consistent** indexing mode updates the index synchronously as your perform individual operations that modify an item (create, update, or delete). This indexing mode will be the standard choice for most containers to ensure the index is updated as items change.

The **none** indexing mode completely disables indexing on a container. This indexing mode is a scenario-specific mode where the indexing operation is either unnecessary or could impact the solution's overall performance. Two examples include:

- A bulk operation to create, update, or delete multiple documents may benefit from disabling indexing during the bulk execution period. Once the bulk operations are complete, the indexing mode can be switched back to **consistent**.
- Solutions that use containers as a pure key-value store only perform point-read operations. These containers do not benefit from the secondary indexes created by running the indexer.

## Including and excluding paths

Indexing policies specify paths that are either explicitly included or excluded from the index. Using a path syntax, you can author expressions to describe various paths within a JSON item.

Consider this JSON object that represents a product item in our Azure Cosmos DB SQL API container:

```json
{
  "id": "8B363B8B-378E-402A-9E68-A935302000B8",
  "name": "HL Touring Frame - Yellow, 46",
  "category": {
    "id": "F3FBB167-11D8-41E4-84B4-5AAA92B1E737",
    "name": "Components, Touring Frames"
  },
  "metadata": {
    "sku": "FR-T98Y-46"
  },
  "price": 1003.91,
  "tags": [
    {
      "name": "accessory"
    },
    {
      "name": "yellow"
    },
    {
      "name": "frame"
    }
  ]
}
```

Three primary operators are used when defining a property path:

- The ``?`` operator indicates that a path terminates with a string or number (scalar) value
- The ``[]`` operator indicates that this path includes an array and avoids having to specify an array index value
- The ``*`` operator is a wildcard and matches any element beyond the current path

Using these operators, you can create a few example property path expressions for the example JSON item:

| **Path expression** | **Description** |
| ---: | :--- |
| **/\*** | All properties |
| **/name/?** | The scalar value of the **name** property |
| **/category/\*** | All properties under the **category** property |
| **/metadata/sku/?** | The scalar value of the **metadata.sku** property |
| **/tags/[]/name/?** | Within the **tags** array, the scalar values of all possible **name** properties |
