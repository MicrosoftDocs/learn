In the simplest terms, an indexing policy is really two sets of include/exclude expressions that are evaluated to determine which actual properties are indexed. By this very nature, conflicts between include and exclude paths will occur, as the existence of conflicts is by design. When a conflict occurs, the expression with the most precision takes precedence. For example, let’s evaluate these two include and exclude path sets:

- **Included path**: ``/category/name/?``

- **Excluded path**: ``/category/*``

The exclude path excludes all possible properties within the **category** path, however the include path is more precise and specifically includes the **category.name** property. The result is that all properties within **category** are not indexed, with the sole exception being the **category.name** property.

Indexing policies must include the root path and all possible values (``/*``) as either an included or excluded path. More customizations exist as a level of precision beyond that base. This leads to two fundamental indexing strategies you will see in many examples.

First, some indexing policies include all possible properties in the root path, and use the excluded paths list to exclude specific properties or paths as appropriate. This strategy is the case for the default indexing policy. What follows is an example indexing policy that includes all properties except **category.id**:

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
      "path": "/category/id/?"
    }
  ]
}
```

> [!TIP]
> In general, it's better to include all paths by default and only exclude certain paths from the index. With this strategy, you can modify your schema and the index will still work with the new set of properties.

Second, other indexing policies may choose to exclude all possible properties in the root path and then selectively include specific properties of paths. This example indexing policy excludes all properties and selectively indexes only the **name** and **tags[].name** properties:

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    {
      "path": "/name/?"
    },
    {
      "path": "/tags/[]/name/?"
    }
  ],
  "excludedPaths": [
    {
      "path": "/*"
    }
  ]
}
```
