```csharp
Container container = await database.CreateContainerIfNotExistsAsync(
    id: "products",
    partitionKeyPath: "/department",
    throughput: 400
);
```
