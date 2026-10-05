Some query logic gets written once and then copied forever. A storefront that groups products by their top-level category has to split `categoryName` on its comma in every query that does the grouping, and every one of those queries pays for a scan because the split happens at run time over loaded items. A computed property moves that logic into the container definition, where you can index it.

A computed property has a value derived from other properties in the same item, and that value isn't stored in the item. You reference it in a query as though it were a persisted property.

## Define a computed property

Each definition is a name and a query. The definition lives on the container, alongside the indexing policy:

```json
{
  "computedProperties": [
    {
      "name": "cp_primaryCategory",
      "query": "SELECT VALUE SUBSTRING(c.categoryName, 0, INDEX_OF(c.categoryName, ',')) FROM c"
    }
  ]
}
```

Against the CosmicWorks catalog, that definition turns a `categoryName` of `Bikes, Road Bikes` into `Bikes`, and the 295 products resolve to four values: `Components`, `Bikes`, `Clothing`, and `Accessories`.

The rules on the name are short and worth memorizing:

- Names have to be unique within the container, and the property is always at the top level, so its path is `/<name>`.
- Reserved system names such as `id`, `_rid`, and `_ts` aren't allowed.
- A name can't match a path that's already indexed, whether in included paths, excluded paths, spatial indexes, or composite indexes.
- Naming a computed property after a persisted property doesn't raise an error, but it produces confusing results, because queries then use the computed property instead of the persisted one. To prevent that collision, the documentation and this module use the `cp_` prefix.

The rules on the query are longer, because the query has to evaluate deterministically for every item in the container:

- The query needs a `FROM` clause that references the root item, such as `FROM c`.
- The projection has to use `VALUE`.
- No `JOIN`, and no scalar subqueries.
- No `WHERE`, `GROUP BY`, `ORDER BY`, `TOP`, `DISTINCT`, `OFFSET LIMIT`, `EXISTS`, `ALL`, `LAST`, `FIRST`, or `NONE`.
- No aggregate functions, spatial functions, user-defined functions, or nondeterministic functions such as `GetCurrentDateTime` or `RAND`.

A container holds at most 20 computed properties, and a computed property can't reference another computed property. Values that evaluate to null or undefined behave exactly like a persisted property with the same value.

> [!IMPORTANT]
> These SDK examples replace container properties through the data-plane endpoint. Microsoft Entra authentication doesn't authorize that operation. For a keyless account, update the definition through Data Explorer or a management-plane API instead.

::: zone pivot="csharp"

```csharp
Container container = client.GetDatabase("cosmicworks").GetContainer("product");

ContainerResponse response = await container.ReadContainerAsync();
ContainerProperties properties = response.Resource;

properties.ComputedProperties = new Collection<ComputedProperty>
{
    new ComputedProperty
    {
        Name = "cp_primaryCategory",
        Query = "SELECT VALUE SUBSTRING(c.categoryName, 0, INDEX_OF(c.categoryName, ',')) FROM c"
    }
};

await container.ReplaceContainerAsync(properties);
```

::: zone-end

::: zone pivot="python"

```python
database = client.get_database_client("cosmicworks")
container = database.get_container_client("product")
properties = container.read()

computed_properties = [
    {
        "name": "cp_primaryCategory",
        "query": "SELECT VALUE SUBSTRING(c.categoryName, 0, INDEX_OF(c.categoryName, ',')) FROM c",
    }
]

database.replace_container(
    container=container,
    partition_key=PartitionKey(path="/categoryId"),
  indexing_policy=properties["indexingPolicy"],
  default_ttl=properties.get("defaultTtl"),
    computed_properties=computed_properties,
)
```

::: zone-end

> [!IMPORTANT]
> Updating container properties overwrites the previous values. When you add a computed property to a container that already has one, send both definitions, or the existing one disappears.

The Python example preserves the catalog's indexing policy and time-to-live setting. The `replace_container` method resets omitted optional settings to their defaults, so pass any other container settings you need to retain.

## Index a computed property

Computed properties aren't indexed by default, and the `/*` wildcard doesn't cover them. Indexing them is the whole point, so this step isn't optional in practice.

Add the path explicitly, the same way you would for a persisted property:

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    { "path": "/*" },
    { "path": "/cp_primaryCategory/?" }
  ],
  "excludedPaths": [
    { "path": "/\"_etag\"/?" }
  ]
}
```

A computed property can also appear in a composite index, paired with a persisted property, which is how you serve a query that groups on the computed value and sorts on a stored one. Spatial indexes are the exception: a computed property can't have one.

Three lifecycle rules follow from the fact that indexing a computed property persists index terms at write time:

- Changing the definition of an indexed computed property doesn't trigger a reindex. Drop the property from the indexing policy, wait for that transformation to finish, then add it back.
- Deleting a computed property means removing it from the indexing policy first.
- When a computed property is indexed, its value is evaluated on every write to generate the index term, so write charges rise. Adding the definition itself costs nothing, and leaving a computed property unindexed raises write charges only slightly.

## Query with computed properties

Once defined, a computed property is available in the `SELECT`, `WHERE`, `GROUP BY`, and `ORDER BY` clauses of any query, from any SDK and from the Data Explorer.

```sql
SELECT
    COUNT(1) AS productCount,
    c.cp_primaryCategory
FROM c
GROUP BY c.cp_primaryCategory
```

Two behaviors surprise people:

- **Wildcard projection doesn't include computed properties.** `SELECT *` returns the persisted properties only. To see a computed property in the result, name it.
- **`ORDER BY` requires the index.** Ordering on a computed property fails unless that property is in the indexing policy, exactly as it does for a persisted property.

The performance argument is easiest to see in the grouping query. Indexing `cp_primaryCategory` lets the query use stored index terms instead of evaluating the composed `SUBSTRING` and `INDEX_OF` expression over each item at run time. This approach can reduce latency and request charge. `SUBSTRING` by itself can benefit from a range index when its starting position is 0, so it doesn't always require a full scan.

Learn more about [computed properties](/cosmos-db/query/computed-properties).
