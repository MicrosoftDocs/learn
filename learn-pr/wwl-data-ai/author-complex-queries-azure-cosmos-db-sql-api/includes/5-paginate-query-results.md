The **Microsoft.Azure.Cosmos.Container** class supports asynchronous streams for the simplest and easiest way to iterate over multiple pages of results. In scenarios where you wish to paginate between results manually, you can retrieve the feed iterator and read each page of results.

First, define a SQL query string that you wish to execute, and then use it as a constructor parameter for a variable of type **QueryDefinition**.

```csharp
string sql = "SELECT * FROM products WHERE p.price > 500";
QueryDefinition query = new (sql);
```

Then, build an object of type **QueryRequestOptions** using the **MaxItemCount** property to specify how many items you wish to return for each page of results.

```csharp
QueryRequestOptions options = new()
{
    MaxItemCount = 100
};
```

Finally, create a new **FeedIterator\<\>** using your generic type and the **GetItemQueryIterator** method.

```csharp
FeedIterator<Product> iterator = container.GetItemQueryIterator<Product>(query, requestOptions: options);
```

The feed iterator class contains a **HasMoreResults** boolean property that indicates more pages to return server-side. This property is ideal to use within a while loop. The iterator also has a **ReadNextAsync** method that gets the next set of items into an enumerable collection that can be iterated over with a foreach loop.

```csharp
while(iterator.HasMoreResults)
{
    foreach(Product product in await iterator.ReadNextAsync())
    {
        // Handle individual items
    }
}
```
