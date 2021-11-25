The Microsoft.Azure.Cosmos.Container class in the SDK has a series of built-in classes to create a query, issue the query to Azure Cosmos DB SQL API, set up an asynchronous stream in C#, and return items efficiently back to the client.

To start, let’s use a straightforward SQL command that returns all products:

```sql
SELECT * FROM products p
```

The equivalent command definition in C# would use the **QueryDefinition** class:

```csharp
QueryDefinition query = new ("SELECT * FROM products p");
```

First, define a C# type to represent the type of item you will query, for this example, a simple C\# **Product** class will suffice:

```csharp
public class Product
{
    public string id { get; set; }

    public string name { get; set; }

    public string price { get; set; }
}
```

Next, use the **GetItemQueryIterator** generic method with the C\# **Product** type to in the **await foreach** loop. The asynchronous stream structure will automatically handle the looping and pagination to go to the server and get each subsequent page of results. Within the foreach loop, add your code to handle each item; in this example, each item’s **id**, **name**, and **price** is output to the console:

```csharp
await foreach (Product product in container.GetItemQueryIterator<Product>(query))
{
    Console.WriteLine($"[{product.id}]\t{product.name,35}\t{product.price,15:C}");
}
```
