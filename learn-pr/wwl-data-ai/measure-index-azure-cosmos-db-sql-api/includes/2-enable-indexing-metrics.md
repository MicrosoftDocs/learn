You may often wonder how your index and indexing policy specifically impact a SQL query you authored. Azure Cosmos DB SQL API includes opt-in indexing metrics that illuminate how the current state of the index affects your query filters. The indexing metrics will go even further and recommend single or composite indexes to improve future query performance.

Using the Azure Cosmos DB SQL API SDK for .NET, you can build a typical query request to select all items from your container.

```csharp
Container container = client.GetContainer("cosmicworks", "products");

string sql = "SELECT * FROM products p";

QueryDefinition query = new(sql);

FeedIterator<Product> iterator = container.GetItemQueryIterator<Product>(query);

while(iterator.HasMoreResults)
{
    FeedResponse<Product> response = await iterator.ReadNextAsync();
    foreach(Product product in response)
    {
        Console.WriteLine($"[{product.id}]\t{product.name,35}\t{product.price,15:C}");       
    }    
}
```

This sample code creates a **QueryDefinition** variable with the SQL query and then passes in that variable to the **GetItemQueryIterator\<\>** method of the **Container** class. Once the iterator is available, the code uses a combination of a while loop and a foreach loop to iterator over pages of results as long as there is another page available.

To enable index metrics, you must first create an object of type **QueryRequestOptions** and set the **PopulateIndexMetrics** property to true.

> [!NOTE]
> By default, **PopulateIndexMetrics** is disabled. You should only enable this if you are troubleshooting query performance or are unsure how to modify your indexing policy.

```csharp
QueryRequestOptions options = new()
{
    PopulateIndexMetrics = true
};
```

Once created, you can pass in the options variable as an extra parameter to the **GetItemQueryIterator\<\>** method of the **Container** class.

```csharp
FeedIterator<Product> iterator = container.GetItemQueryIterator<Product>(query, requestOptions: options);
```

Next, you can iterate over results like normal using a combination of a while and foreach loop. However, the **FeedResponse\<\>** object within the while loop will contain an **IndexMetrics** string property with information about the query’s performance relative to the current index.

In this example, the content of the **IndexMetrics** property is sent to the console output.

```csharp
while(iterator.HasMoreResults)
{
    FeedResponse<Product> response = await iterator.ReadNextAsync();
    foreach(Product product in response)
    {
        // Do something with each product
    }

    Console.WriteLine(response.IndexMetrics);    
}
```
