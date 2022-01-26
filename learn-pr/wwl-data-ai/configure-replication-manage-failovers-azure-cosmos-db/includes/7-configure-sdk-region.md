The .NET SDK for Azure Cosmos DB SQL API includes configuration classes that can be used with the **CosmosClient** class to configure which region you want the SDK to target for requests.

There are two ways to configure the SDK client:

- Use the **ApplicationRegion** property to configure a single region for requests
- Use the **ApplicationPreferredRegions** property to configure a list of preferred regions

## Setting an application region

The **CosmosClientOptions** class contains a set of configuration options for new SDK client instances. Using this class, you can configure the preferred region for your queries and read operations. In this example, the **ApplicationRegion** property is configured to **UK South**.

```csharp
CosmosClientOptions options = new () 
{ 
    ApplicationRegion = "UK South"
};
CosmosClient client = new (connectionString, options);
```

Alternatively; you can use the **Microsoft.Azure.Cosmos.Regions** static class which includes built-in string properties for various Azure regions.

```csharp
CosmosClientOptions options = new () 
{ 
    ApplicationRegion = Regions.UKSouth
};
CosmosClient client = new (connectionString, options);
```

As another alternative, you can use the **CosmosClientBuilder** fluent classes to construct a new client with the application region set.

```csharp
CosmosClient client = new CosmosClientBuilder(connectionString)
    .WithApplicationRegion(Regions.UKSouth)
    .Build();
```

## Setting a list of preferred application regions

The **ApplicationPreferredRegions** property is used to set a prioritized list of geo-replicated regions to use with the SDK. In this first example, a string collection is created with the region values of **East Asia**, **South Africa North**, and **West US**. This collection is then used to assign the **ApplicationPreferredRegions** property.

```csharp
List<string> regions = new()
{
    "East Asia",
    "South Africa North",
    "West US"
};

CosmosClientOptions options = new () 
{ 
    ApplicationPreferredRegions = regions
};
CosmosClient client = new (connectionString, options);

```

This example could also be simplified with the use of the **Regions** static class and the **CosmosClientBuilder**.

```csharp
CosmosClient client = new CosmosClientBuilder(connectionString)
    .WithApplicationPreferredRegions(
        new List<string>
        {
            Regions.EastAsia
            Regions.SouthAfricaNorth
            Regions.WestUS
        }
    )
    .Build();
```
