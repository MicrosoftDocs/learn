```csharp
using FeedIterator<Product> feed = container.GetItemLinqQueryable<Item>()
    .Where(i => i.partitionKey == "some-category")
    .OrderBy(i => i.id)
    .ToFeedIterator();
```
