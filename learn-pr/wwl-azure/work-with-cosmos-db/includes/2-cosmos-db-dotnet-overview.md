

This **unit** focuses on Azure Cosmos DB .NET SDK v3 for API for NoSQL. (**Microsoft.Azure.Cosmos** NuGet package.) If you're familiar with the previous version of the .NET SDK, you may be used to the terms collection and document.

The [azure-cosmos-dotnet-v3](https://github.com/Azure/azure-cosmos-dotnet-v3/tree/master/Microsoft.Azure.Cosmos.Samples/Usage) GitHub repository includes the latest .NET sample solutions. You use these solutions to perform CRUD (create, read, update, and delete) and other common operations on Azure Cosmos DB resources.

Because Azure Cosmos DB supports multiple API models, version 3 of the .NET SDK uses the generic terms "container" and "item". A ***container*** can be a collection, graph, or table. An ***item*** can be a document, edge/vertex, or row, and is the content inside a container.

Below are examples showing some of the key operations you should be familiar with. For more examples, please visit the GitHub link shown earlier. The examples below all use the async version of the methods.

## CosmosClient

Creates a new `CosmosClient` with a connection string. `CosmosClient` is thread-safe. It's recommended to maintain a single instance of `CosmosClient` per lifetime of the application that enables efficient connection management and performance.

```csharp
CosmosClient client = new CosmosClient(endpoint, key);
```

## Database examples

### Create a database

The `CosmosClient.CreateDatabaseIfNotExistsAsync` checks if a database exists, and if it doesn't, creates it. Only the database `id` is used to verify if there's an existing database. 

```csharp
// An object containing relevant information about the response
DatabaseResponse databaseResponse = await client.CreateDatabaseIfNotExistsAsync(databaseId, 10000);
```

### Read a database by ID

Reads a database from the Azure Cosmos DB service as an asynchronous operation.

```csharp
DatabaseResponse readResponse = await database.ReadAsync();
```

### Delete a database

Delete a Database as an asynchronous operation.

```csharp
await database.DeleteAsync();
```

## Container examples

### Create a container

The `Database.CreateContainerIfNotExistsAsync` method checks if a container exists, and if it doesn't, it creates it. Only the container `id` is used to verify if there's an existing container.

```csharp
// Set throughput to the minimum value of 400 RU/s
ContainerResponse simpleContainer = await database.CreateContainerIfNotExistsAsync(
    id: containerId,
    partitionKeyPath: partitionKey,
    throughput: 400);
```

### Get a container by ID

```csharp
Container container = database.GetContainer(containerId);
ContainerProperties containerProperties = await container.ReadContainerAsync();
```

### Delete a container

Delete a Container as an asynchronous operation.

```csharp
await database.GetContainer(containerId).DeleteContainerAsync();
```

## Item examples

### Create an item

Use the `Container.CreateItemAsync` method to create an item. The method requires a JSON serializable object that must contain an `id` property, and a `partitionKey`. 

```csharp
ItemResponse<SalesOrder> response = await container.CreateItemAsync(salesOrder, new PartitionKey(salesOrder.AccountNumber));
```

### Read an item

Use the `Container.ReadItemAsync` method to read an item. The method requires type to serialize the item to along with an `id` property, and a `partitionKey`. 

```csharp
string id = "[id]";
string accountNumber = "[partition-key]";
ItemResponse<SalesOrder> response = await container.ReadItemAsync(id, new PartitionKey(accountNumber));
```

### Query an item

The `Container.GetItemQueryIterator` method creates a query for items under a container in an Azure Cosmos database using a SQL statement with parameterized values. It returns a `FeedIterator`. 

```csharp
QueryDefinition query = new QueryDefinition(
    "select * from sales s where s.AccountNumber = @AccountInput ")
    .WithParameter("@AccountInput", "Account1");

FeedIterator<SalesOrder> resultSet = container.GetItemQueryIterator<SalesOrder>(
    query,
    requestOptions: new QueryRequestOptions()
    {
        PartitionKey = new PartitionKey("Account1"),
        MaxItemCount = 1
    });
```

## Other resources

* The [azure-cosmos-dotnet-v3](https://github.com/Azure/azure-cosmos-dotnet-v3/tree/master/Microsoft.Azure.Cosmos.Samples/Usage) GitHub repository includes the latest .NET sample solutions to perform CRUD and other common operations on Azure Cosmos DB resources. 

* Visit this article [Azure Cosmos DB.NET V3 SDK (Microsoft.Azure.Cosmos) examples for the SQL API](/azure/cosmos-db/sql-api-dotnet-v3sdk-samples) for direct links to specific examples in the GitHub repository.
