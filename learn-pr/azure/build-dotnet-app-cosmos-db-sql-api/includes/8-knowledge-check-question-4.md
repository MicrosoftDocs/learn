Here's an Azure Cosmos DB SQL API query using the LINQ method syntax:

```csharp
using FeedIterator<Product> feed = container.GetItemLinqQueryable<Item>()
    .Where(i => i.partitionKey == "some-category")
    .OrderBy(i => i.id)
    .ToFeedIterator();
```

What is the SQL query equivalent of this LINQ query?
