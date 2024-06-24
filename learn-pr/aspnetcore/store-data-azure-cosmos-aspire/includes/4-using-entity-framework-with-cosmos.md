Entity Framework is a part of .NET that enables you to create database schemas and other objects in .NET code. It can ease database creation for .NET developers.

In your outdoor equipment company, the development team in charge of the shopping basket microservice want to use Cosmos DB with the NoSQL API. They have experience with Entity Framework from a previous project. You want to know if .NET Aspire supports Entity Framework for Cosmos DB connections.

In this unit, you'll see how to use .NET Aspire and Entity Framework to code against Azure Cosmos DB databases.

## Why use Entity Framework?

Entity Framework is an object-relational mapper. You can use it to work with database objects in your .NET code without having to write native Cosmos DB code.

For example, with Entity Framework, you define an class with properties in C# and create an instance of that class. Entity Framework automatically creates objects in the Cosmos DB database to store it.

To use Entity Framework, you also need a context object. The context represents a session open with a specific database. In .NET Aspire, the Cosmos DB Entity Framework component automatically creates the context for you and passes it to the consuming projects.

Let's see how that works.

## Configuring the App Host

When you use the .NET Aspire Cosmos DB Entity Framework component, the configuration steps in the app host are the same as in the last unit.

Install the `Aspire.Hosting.Azure.CosmosDB` package:

```dotnetcli
dotnet add package Aspire.Hosting.Azure.CosmosDB
```

In the app host's _Program.cs_ file, add the Cosmos DB component, create a database, and pass it to consuming packages. This example also configures the local Cosmos DB emulator:

```csharp
var builder = DistributedApplication.CreateBuilder(args);

var cosmos = builder.AddAzureCosmosDB("cosmos");
var cosmosdb = cosmos.AddDatabase("cosmosdb")
   .RunAsEmulator();

var consumingProject = builder.AddProject<Projects.ConsumingProject>()
                            .WithReference(cosmosdb);
```

## Configuring the consuming projects

The configuration code for the Cosmos DB Entity Framework component is different from the last unit. In each project that uses the Cosmos DB database, start by installing the `Aspire.Microsoft.EntityFrameworkCore.Cosmos` package:

```dotnetcli
dotnet add package Aspire.Microsoft.EntityFrameworkCore.Cosmos
```

In the _Program.cs_ code file, register an Entity Framework `DbContext` object in the dependency injection container:

```csharp
builder.AddCosmosDbContext<MyDbContext>("cosmosdb");
```

## Using the database context

Now, you can obtain the `DbContext` object wherever you need to use it, using dependency injection:

```csharp
public class ExampleMethod(MyDbContext context)
{
    // Use the DbContext here to interact with the database
}
```

For example, to add an item to a database, use this code:

```csharp
await context.Database.EnsureDeletedAsync();
await context.Database.EnsureCreatedAsync();

context.Add(
    new Order
    {
        Id = 1, 
        ShippingAddress = new StreetAddress 
        { 
            City = "London", 
            Street = "221 B Baker St" 
        },
        PartitionKey = "1"
    });

    await context.SaveChangesAsync();
```

The code requires you to define the `Order` and `ShippingAddress` classes:

```csharp
public class Order
{
    public int Id { get; set; }
    public int? TrackingNumber { get; set; }
    public string PartitionKey { get; set; }
    public StreetAddress ShippingAddress { get; set; }
}

public class StreetAddress
{
    public string Street { get; set; }
    public string City { get; set; }
}
```

## Learn more

- [.NET Aspire Microsoft Entity Framework Core Cosmos DB component](/dotnet/aspire/database/azure-cosmos-db-entity-framework-component)
