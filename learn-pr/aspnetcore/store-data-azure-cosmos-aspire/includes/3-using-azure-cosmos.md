If one or more of your development teams chooses to use Cosmos DB to persist data from a microservice, they must connect to Azure from their code. If you use the .NET Aspire stack, this step is easier because you have built-in components that create supporting objects and connections for you.

In your outdoor equipment company, several development teams want to use Cosmos DB to support their microservices with different APIs. You want to code these connections in your .NET Aspire solution.

In this unit, you'll learn how to connect to and interact with Cosmos DB by using .NET Aspire components.

## Choosing a Cosmos DB .NET Aspire component

In a cloud-native solution, there are many microservices, each of which is the responsibility of a separate development team. Each team can choose to use a different database and if any of them prefer NoSQL or require global data distribution in a cloud-hosted database, it's likely that one or more may choose Cosmos DB.

.NET Aspire makes it easy to work with Cosmos DB in cloud-native microservices by providing built-in Cosmos DB components. You can initiate these components and create databases in the app host project and pass them to consuming microservices that read and write data.

Choose from these two components:

- **.NET Aspire Azure Cosmos DB component**: Use this component when your developers want direct access to Cosmos DB by using a `CosmosClient` object.
- **.NET Aspire Azure Cosmos DB Entity Framework component**: Use this component when your developers prefer to use Entity Framework to define data schemas in code by using a `DbContext` object.

> [!NOTE]
> This unit describes how to use the Cosmos DB component. You'll learn more about the Cosmos DB Entity Framework component in the next unit.

## Configuring the app host

If you decide to use the Azure Cosmos DB component, configure the app host to create a connection and optionally a database. 

Start by installing the `Aspire.Hosting.Azure.CosmosDB` package. Run this command in the app host folder:

```dotnetcli
dotnet add package Aspire.Hosting.Azure.CosmosDB
```

Next, in the app host's _Program.cs_ file, add the Cosmos DB component and create a database:

```csharp
var builder = DistributedApplication.CreateBuilder(args);

var cosmos = builder.AddAzureCosmosDB("cosmos");
var cosmosdb = cosmos.AddDatabase("cosmosdb");
```

Finally, pass the database to each microservice that uses it:

```csharp
var consumingProject = builder.AddProject<Projects.ConsumingProject>()
                            .WithReference(cosmosdb);
```

> [!TIP]
> The above code creates the database in your Azure subscription. For initial development and debugging, you may want to run Cosmos DB in a local emulator instead. Download and install the emulator, then add a call to the `RunAsEmulator()` method in the app host's _Program.cs_ file:
>
> ```csharp
> cosmos.RunAsEmulator();
> ```

## Configuring the consuming projects

In each project that uses the Cosmos DB database, start by installing the `Aspire.Microsoft.Azure.Cosmos` package:

```dotnetcli
dotnet add package Aspire.Microsoft.Azure.Cosmos
```

In the _Program.cs_ code file, register a `CosmosClient` object in the dependency injection container:

```csharp
builder.AddAzureCosmosClient("cosmosdb");
```

## Using the Cosmos DB client object

Now, you can obtain the `CosmosClient` object wherever you need to use it, using dependency injection:

```csharp
public class ExampleMethod(CosmosClient cosmosClient)
{
    // Use the CosmosClient here to interact with the database
}
```

For example, to create a new database and container, use this code:

```csharp
Database db = await cosmosClient.CreateDatabaseAsync("database-id");

ContainerProperties containerProperties = new ContainerProperties()
{
    Id = Guid.NewGuid().ToString(),
    PartitionKeyPath = "/pk",
    IndexingPolicy = new IndexingPolicy()
    {
        Automatic = false,
        IndexingMode = IndexingMode.Lazy,
    }
};

Container container = await db.CreateContainerAsync(
    containerProperties,
    ThroughputProperties.CreateAutoscaleThroughput(5000)
);
```

To add an item to that container, use this code:

```csharp
var item = new
{
    id = "68649263",
    name = "Large backpack"
};

await container.CreateItemAsync(item);
```

## Learn more

- [.NET Aspire Azure Cosmos DB component](/dotnet/aspire/database/azure-cosmos-db-component)
- [Develop locally using the Azure Cosmos DB emulator](/azure/cosmos-db/how-to-develop-emulator)
