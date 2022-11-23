```csharp
using FeedIterator<Product> feed = container.GetItemLinqQueryable<Item>()
    .Where(i => i.id == "some-category")
    .ToFeedIterator();
```
