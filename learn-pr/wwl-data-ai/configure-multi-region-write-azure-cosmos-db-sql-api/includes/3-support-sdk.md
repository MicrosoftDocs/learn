In the .NET SDK for Azure Cosmos DB SQL API, configuring the preferred region to write to is a matter of selecting between two different properties in the **CosmosClientOptions** object.

> [!TIP]
> If you do not specify a preferred region, the SDK will automatically default to the primary region for your account. The primary region is the first region in the region list, and is typically the region you selected first when you created the Azure Cosmos DB account.

## Selecting a single write region

The **ApplicationRegion** property specifies which region you want the SDK to use for its operations. Effectively, this is the writable region you will use. In this example, the selected region is **West US**.

```csharp
CosmosClientOptions options = new()
{
    ApplicationRegion = Regions.WestUS
};
using CosmosClient client = new(connectionString, options);
```

You can also use the **CosmosClientBuilder** to configure the preferred region.

```csharp
using CosmosClient client = builder
    .WithApplicationRegion(Regions.WestUS)
    .Build();
```

Once the client connects to Azure Cosmos DB, the client will pull a list of regions and prioritize them based on proximity from the region you chose. If the region you selected is not available, the client will try the alternative regions in the established order.

## Building a preferred write regions list

If you want to create your own prioritized list of regions to attempt read and write operations, you can use the **ApplicationPreferredRegions** property. In the first example, this property is set to a list of three regions in a custom prioritization.

```csharp
CosmosClientOptions options = new()
{
    ApplicationPreferredRegions = new List<string>
    {
        Regions.WestUS,
        Regions.AustraliaSoutheast,
        Regions.NorthEurope
    }
};
using CosmosClient client = new(connectionString, options);
```

Again, this same example could be implemented using the **CosmosClientBuilder** class.

```csharp
using CosmosClient client = builder
    .WithApplicationPreferredRegions(
        new List<string>
        {
            Regions.WestUS,
            Regions.AustraliaSoutheast,
            Regions.NorthEurope
        }
    )
    .Build();
```
