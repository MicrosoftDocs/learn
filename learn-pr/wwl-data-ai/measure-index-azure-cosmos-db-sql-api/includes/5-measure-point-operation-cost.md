You can also use the .NET SDK to measure the cost, in RU/s, of individual operations. Since this is already included in a response header, there is no need to use a custom options object.

Here is an example block of C\# code that gets a container, creates a new object, and then uses the **CreateItemAsync** method of the **Container** class to execute a create operation and store the results in a variable of type **ItemResponse\<\>**.

```csharp
Container container = client.GetContainer("cosmicworks", "products");

Product item = new(
    $"{Guid.NewGuid()}",
    $"{Guid.NewGuid()}",
    "Road Bike",
    500,
    "rd-bk-500"
);

ItemResponse<Product> response = await container.CreateItemAsync<Product>(item);
```

The **ItemResponse\<\>** variable is helpful for many things, but this example only focuses on two uses.

First, the variable contains a **Resource** property that will output a deserialized instance of your item in the specified generic type. This resource is the item that was recently created server-side in Azure Cosmos DB SQL API.

Second, the variable contains a **RequestCharge** property that returns a value of type **double,** indicating the number of request units consumed by this operation.

```csharp
Product createdItem = response.Resource;

Console.WriteLine($"RUs:\t{response.RequestCharge:0.00}");
```

Once you run the code, the output window will show a request unit charge for creating the item in a single operation.

```bash
RUs:    7.05
```
