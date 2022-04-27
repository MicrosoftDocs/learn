Bulk execution must be enabled by creating a new instance of the **CosmosClientOptions** class and setting the **AllowBulkExecution** property of that instance to true.

```csharp
CosmosClientOptions options = new () 
{ 
    AllowBulkExecution = true 
};
```

You can pass in this options instance as the last parameter to the **CosmosClient** constructor parameter. This options parameter can be used if you are using an endpoint and key pair.

```csharp
CosmosClient client = new (endpoint, key, options);  
```

This options parameter can also be used if you are using a connection string constructor.

```csharp
CosmosClient client = new (connectionString, options);
```

For context, how do we usually perform a single “Create Item” operation? Here, we invoke the **CreateItemAsync** method, which returns a **Task**, which is in turn immediately invoked using the **await** keyword, so we never really handle the **Task** object. It’s just a syntax shortcut to make our code easier to read.

```bash
await container.CreateItemAsync<Product>(product, partitionKey);
```

Under the hood, we could handle the task objects and even add them to lists. Here is an example where we create two tasks for two “Create Item” operations that would create two products. We don’t start the tasks yet; we add them to a list to start them later.

```csharp
List<Task> concurrentTasks = new List<Task>();

PartitionKey firstPartitionKey = new("some-value");
Task<ItemResponse<Product>> firstTask = container.CreateItemAsync<Product>(firstProduct, firstPartitionKey);
concurrentTasks.Add(firstTask);

PartitionKey secondPartitionKey = new("some-value");
Task<ItemResponse<Product>> secondTask = container.CreateItemAsync<Product>(secondProduct, secondPartitionKey);
concurrentTasks.Add(secondTask);
```

This code is ugly; we could make it relatively cleaner. Here, we have a method called **GetOurProductsFromSomeWhere** that generates **250,000** products. We then create a list of tasks. We can then use a clean C# foreach loop that most developers can understand quickly.

```csharp
List<Product> productsToInsert = GetOurProductsFromSomeWhere();

List<Task> concurrentTasks = new List<Task>();

foreach(Product product in productsToInsert)
{
    concurrentTasks.Add(
        container.CreateItemAsync<Product>(
            product, 
            new PartitionKey(product.partitionKeyValue))
    );
}
```

For each product in the products list, add a task to create an item in our Azure Cosmos DB SQL API container. How much simpler can it get? Remember, nothing has happened yet. Even better, we haven’t written any Azure Cosmos DB-specific code yet other than the **container.CreateItemAsync** part. This is all C# code.

When we invoke **Task.WhenAll**, the SDK will kick in to create batches to group our operations by physical partition, then distribute the requests to run concurrently. Grouping operations greatly improves efficiency by reducing the number of back-end requests, and allowing batches to be dispatched to different physical partitions in parallel. It also reduces thread count on the client making it easier to consume more throughput that you could if done as individual operations using individual threads.

```csharp
Task.WhenAll(concurrentTasks);
```

Once each batch is done, the SDK will translate the batches back to the results for the client-side application. This is seemless and transparent to the developer.
