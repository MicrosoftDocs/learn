::: zone pivot="csharp"

The Microsoft.Azure.Cosmos.Container class in the SDK has a series of built-in classes to create a query, issue the query to Azure Cosmos DB for NoSQL, set up an asynchronous stream in C#, and return items efficiently back to the client.

To start, let’s use a straightforward SQL command that returns all products:

```sql
SELECT * FROM products p
```

The equivalent command definition in C# would use the **QueryDefinition** class:

```csharp
QueryDefinition query = new ("SELECT * FROM products p");
```

First, define a C# type to represent the type of item you query, for this example, a simple C\# **Product** class suffices:

```csharp
public class Product
{
    public string id { get; set; }

    public string name { get; set; }

    public string price { get; set; }
}
```

Next, use the **GetItemQueryIterator** generic method with the C\# **Product** type to in the **await foreach** loop. The asynchronous stream structure automatically handles the looping and pagination to go to the server and get each subsequent page of results. Within the foreach loop, add your code to handle each item; in this example, each item’s **id**, **name**, and **price** is output to the console:

```csharp
using (FeedIterator<Product> feedIterator = this.Container.GetItemQueryIterator<Product>(
    query,
    null,
    new QueryRequestOptions() { }))
{
    while (feedIterator.HasMoreResults)
    {
        foreach(var item in await feedIterator.ReadNextAsync())
        {
            Console.WriteLine($"[{item.productid}]\t{item.name,35}\t{item.price,15:C}");
        }
    }
}
```

::: zone-end

::: zone pivot="python"

The `azure-cosmos` Python SDK provides efficient methods for querying data using SQL-like syntax, handling pagination, and streaming results back to the client.

To start, let’s use a straightforward SQL command that returns all products:

```sql
SELECT * FROM products p
```

In Python, this query can be passed directly as a string to the `query_items` method.

Define a Python dictionary to represent the structure of your items. For example, consider a product structure like this:

```python
product = {
    "id": "string",
    "name": "string",
    "price": "string"
}
```

Next, use the **query_items** method. The method accepts the SQL query string and options for partition key and other configurations. The results are streamed efficiently using a loop. Within the loop, add your code to handle each item; in this example, each item’s **id**, **name**, and **price** is output to the console:

```python
query = "SELECT * FROM products p"
for item in container.query_items(
    query=query,
    enable_cross_partition_query=True):
    print(f"{item['id']}\t{item['name']}\t{item['price']}")
```

::: zone-end

::: zone pivot="node"

The JavaScript SDK allows you to create a query, issue the query to Azure Cosmos DB for NoSQL, set up an asynchronous stream in JavaScript, and return items efficiently back to the client.

To start, let’s use a straightforward SQL command that returns all products:

```sql
SELECT * FROM products p
```

To execute this query using the JavaScript SDK, create a `QuerySpec` object or use a query string. Here's how you define the query string in your code:

```javascript
const query = "SELECT * FROM products p";
```

For structured handling of query results, you can define a JavaScript class representing the `Product` data:

```javascript
class Product {
    constructor(id, name, price) {
        this.id = id;
        this.name = name;
        this.price = price;
    }
}
```

Next, use the **query** method to create an instance of the `QueryIterator` class. The method accepts the SQL query string and options for partition key and other configurations. The asynchronous stream structure automatically handles the looping and pagination to go to the server and get each subsequent page of results. Within the loop, add your code to handle each item; in this example, each item’s **id**, **name**, and **price** is output to the console:

```javascript
const iterator = container.items.query(
    query,
    { enableCrossPartitionQuery: true }
);

while (iterator.hasMoreResults()) {
    const { resources } = await iterator.fetchNext();
    for (const item of resources) {
        console.log(`[${item.id}]	${item.name.padEnd(35)}	${item.price.toFixed(2)}`);
    }
}
```

If you prefer to use the **Product** class to represent your items, you can use the following code:

```javascript
const iterator = container.items.query(
    query,
    { enableCrossPartitionQuery: true }
);

while (iterator.hasMoreResults()) {
    const { resources } = await iterator.fetchNext();
    // Bind the results to the Product class.
    const products = resources.map((product) => {
        return new Product(product.id, product.name, 0);
    });
}
```

::: zone-end
