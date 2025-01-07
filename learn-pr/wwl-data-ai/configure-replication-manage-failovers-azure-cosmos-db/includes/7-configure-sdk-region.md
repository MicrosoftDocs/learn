The .NET SDK for Azure Cosmos DB for NoSQL includes configuration classes that can be used with the **CosmosClient** class to configure which region you want the SDK to target for requests.

There are two ways to configure the SDK client:

- Use the **ApplicationRegion** property to configure a single region for requests
- Use the **ApplicationPreferredRegions** property to configure a list of preferred regions

## Setting an application region

The **CosmosClientOptions** class contains a set of configuration options for new SDK client instances. Using this class, you can configure the preferred region for your queries and read operations. In this example, the **ApplicationRegion** property is configured to **UK South**.

```csharp
using Azure.Identity;
using Microsoft.Azure.Cosmos;

// Configure the account endpoint
string accountEndpoint = "https://<cosmos-account-name>.documents.azure.com:443/";

// Define the preferred application region
CosmosClientOptions options = new()
{
    ApplicationRegion = "UK South"
};

// Use DefaultAzureCredential for Microsoft Entra Managed Identity authentication
DefaultAzureCredential credential = new DefaultAzureCredential();

// Initialize CosmosClient with endpoint, credential, and options
CosmosClient client = new(accountEndpoint, credential, options);
```

Alternatively; you can use the **Microsoft.Azure.Cosmos.Regions** static class which includes built-in string properties for various Azure regions.

```csharp
using Azure.Identity;
using Microsoft.Azure.Cosmos;

// Configure the account endpoint
string accountEndpoint = "https://<cosmos-account-name>.documents.azure.com:443/";

// Define the preferred application region using the Regions static class
CosmosClientOptions options = new()
{
    ApplicationRegion = Regions.UKSouth
};

// Use DefaultAzureCredential for Microsoft Entra Managed Identity authentication
DefaultAzureCredential credential = new DefaultAzureCredential();

// Initialize CosmosClient with endpoint, credential, and options
CosmosClient client = new(accountEndpoint, credential, options);
```

As another alternative, you can use the **CosmosClientBuilder** fluent classes to construct a new client with the application region set.

```csharp
using Azure.Identity;
using Microsoft.Azure.Cosmos.Fluent;

// Configure the account endpoint
string accountEndpoint = "https://<cosmos-account-name>.documents.azure.com:443/";

// Use DefaultAzureCredential for Microsoft Entra Managed Identity authentication
DefaultAzureCredential credential = new DefaultAzureCredential();

// Build the CosmosClient with the specified application region
CosmosClient client = new CosmosClientBuilder(accountEndpoint, credential)
    .WithApplicationRegion(Regions.UKSouth)
    .Build();
```

## Setting a list of preferred application regions

The **ApplicationPreferredRegions** property is used to set a prioritized list of geo-replicated regions to use with the SDK. In this first example, a string collection is created with the region values of **East Asia**, **South Africa North**, and **West US**. This collection is then used to assign the **ApplicationPreferredRegions** property.

```csharp
using Azure.Identity;
using Microsoft.Azure.Cosmos;
using System.Collections.Generic;

// Configure the account endpoint
string accountEndpoint = "https://<cosmos-account-name>.documents.azure.com:443/";

// Create a list of preferred regions
List<string> regions = new()
{
    "East Asia",
    "South Africa North",
    "West US"
};

// Define the CosmosClientOptions with the preferred regions
CosmosClientOptions options = new()
{
    ApplicationPreferredRegions = regions
};

// Use DefaultAzureCredential for Microsoft Entra Managed Identity authentication
DefaultAzureCredential credential = new DefaultAzureCredential();

// Initialize CosmosClient with endpoint, credential, and options
CosmosClient client = new(accountEndpoint, credential, options);
```

This example could also be simplified with the use of the **Regions** static class and the **CosmosClientBuilder**.

```csharp
using Azure.Identity;
using Microsoft.Azure.Cosmos.Fluent;
using System.Collections.Generic;

// Configure the account endpoint
string accountEndpoint = "https://<cosmos-account-name>.documents.azure.com:443/";

// Use DefaultAzureCredential for Microsoft Entra Managed Identity authentication
DefaultAzureCredential credential = new DefaultAzureCredential();

// Build the CosmosClient with a list of preferred regions
CosmosClient client = new CosmosClientBuilder(accountEndpoint, credential)
    .WithApplicationPreferredRegions(new List<string>
    {
        Regions.EastAsia,
        Regions.SouthAfricaNorth,
        Regions.WestUS
    })
    .Build();
```
