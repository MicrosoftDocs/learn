In a solution with a large amount of throughput, it’s not uncommon to selectively optimize the number of paths indexed to reduce both the latency and RU charge of individual operations that create or modify an item. To accomplish this, you would need to create a container using a custom indexing policy.

Let’s start with a simple example JSON document. This document has multiple properties, but the goal is to only index the **categoryName** and **name** properties.

```json
{
  "id": "8B363B8B-378E-402A-9E68-A935302000B8",
  "name": "HL Touring Frame - Yellow, 46",
  "categoryId": "F3FBB167-11D8-41E4-84B4-5AAA92B1E737",
  "categoryName": "Components, Touring Frames",
  "sku": "FR-T98Y-46",
  "price": 1003.91
}
```

In raw JSON, this indexing policy would start by excluding all possible paths, and then opt-in to only including the ``/name/?`` and ``/categoryName/?`` paths.

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    {
      "path": "/name/?"
    },
    {
      "path": "/categoryName/?"
    }
  ],
  "excludedPaths": [
    {
      "path": "/*"
    }
  ]
}
```

> [!NOTE]
> We are excluding all paths here for demonstration purposes. In general, it's much better to include all paths by default and only exclude specific paths.

The .NET SDK ships with a **Microsoft.Azure.Cosmos.IndexingPolicy** class that is a representation of the typical JSON policy object. When creating a new instance of the class, you can immediately set the **IndexingMode** and **Automatic** properties much like their JSON counterparts. In this example, the indexing mode is set to consistent and automatic indexing is enabled.

```csharp
IndexingPolicy policy = new ()
{
    IndexingMode = IndexingMode.Consistent,
    Automatic = true
};
```

The class also includes an **ExcludedPaths** collection with an **Add** method to add new object of type **ExcludedPath**. In this example, the ``\*`` path is added to the list of excluded paths.

```csharp
policy.ExcludedPaths.Add(
    new ExcludedPath{ Path = "/*" }
);
```

Similarly, the class includes an **IncludedPaths** collection. This example illustrates the /name/? and /categoryName/? paths being added to the list of included paths.

```csharp
policy.IncludedPaths.Add(
    new IncludedPath{ Path = "/name/?" }
);
policy.IncludedPaths.Add(
    new IncludedPath{ Path = "/categoryName/?" }
);
```

Once the indexing policy is configured, the **Microsoft.Azure.Cosmos.ContainerProperties** class is used to configure properties of a container such as a name, partition key path, and indexing policy. This class instance is then passed into the **CreateContainerIfNotExistsAsync** method as the first parameter to create a new container with the custom indexing policy.

```csharp
ContainerProperties options = new ()
{
    Id = "products",
    PartitionKeyPath = "/categoryId",
    IndexingPolicy = policy
};
Container container = await database.CreateContainerIfNotExistsAsync(options, throughput: 400);
```
