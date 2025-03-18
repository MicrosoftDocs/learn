::: zone pivot="csharp"

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

::: zone-end

::: zone pivot="python"

The Python SDK for Azure Cosmos DB supports asynchronous iteration for retrieving results, but it also allows you to manually paginate through result sets using a feed iterator. In scenarios where you wish to manually control pagination and the size of each page, you can configure these options and retrieve results incrementally.

First, define the SQL query string that you wish to execute.

```python
sql = "SELECT * FROM products WHERE p.price > 500"
```

The `query_items` method allows you to specify options such as `max_item_count` to limit the number of items returned per page.

```python
iterator = container.query_items(
    query=query,
    enable_cross_partition_query=True,
    max_item_count=100  # Set maximum items per page
)
```

The feed iterator contains a **by_page** method that returns an iterator of pages. Each page contains a list of items that can be iterated over. Use a for loop to iterate over each page and another for loop to iterate over each item.

```python
for page in iterator.by_page():
    for product in page:
        print(f"[{product['id']}]	{product['name']}	${product['price']:.2f}")
```

::: zone-end

::: zone pivot="node"

The `Container` class in the Azure Cosmos DB JavaScript SDK supports paginated queries for scenarios where you wish to manage pagination between results manually. In such cases, you can retrieve the feed iterator and read each page of results.

First, define the SQL query string that you wish to execute.

```javascript
const query = "SELECT * FROM products WHERE products.price > 500";
```

Use the `container.items.query` method to create a query iterator. Set the maximum number of items to return for each page using the `maxItemCount` option:

```javascript
const options = {
    maxItemCount: 100 // Set the maximum number of items per page
};

const iterator = container.items.query(query, options);
```

The `iterator.getAsyncIterator` method returns an async iterator that can be used to fetch the `for await...of` loop to retrieve each page of results. This loop automatically handles the asynchronous iteration over the pages:

```javascript
for await (const page of iterator.getAsyncIterator()) {
    page.resources.forEach(product => {
        console.log(`[${product.id}] ${product.name} $${product.price.toFixed(2)}`);
    });
}
```

::: zone-end
