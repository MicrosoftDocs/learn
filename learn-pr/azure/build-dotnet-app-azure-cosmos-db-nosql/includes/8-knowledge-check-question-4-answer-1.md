```csharp
using FeedIterator<Product> feed = container.GetItemLinqQueryable<Item>()
    .OrderBy(i => i.partitionKey)
    .ToFeedIterator();
```
