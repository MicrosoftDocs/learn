Once the **Microsoft.Azure.Cosmos** library is imported, you can begin using the namespaces and classes within your .NET project.

## Import the namespace

Before using the library, you should import the **Microsoft.Azure.Cosmos** namespace using a **directive**. The using directive allows you to use types within the namespace without being forced to fully qualify each type.

```csharp
using Microsoft.Azure.Cosmos;
```

### Use the CosmosClient Class

The recommended way to create an instance of the **CosmosClient** class is to use **Azure Entra ID Managed Identity** for authentication. This method eliminates the need to manage secrets like connection strings or keys and enhances security.

To authenticate with a Managed Identity, the CosmosClient class can be instantiated using the following approach:

- A constructor that takes the Azure Cosmos DB account's endpoint and a Microsoft Entra ID credential.

### Use with Microsoft Entra Managed Identity

The **CosmosClient** class can be configured to use Microsoft Entra ID authentication via a Managed Identity, eliminating the need for connection strings or account keys. Managed Identity is a secure and modern authentication method for Azure-hosted resources.

```csharp
using Azure.Identity;
using Microsoft.Azure.Cosmos;

// Configure the account endpoint
string accountEndpoint = "https://<youraccountname>.documents.azure.com:443/";

// Use DefaultAzureCredential for Azure Entra Managed Identity authentication
DefaultAzureCredential credential = new DefaultAzureCredential();

// Initialize CosmosClient with the endpoint and Azure Entra Managed Identity
CosmosClient client = new CosmosClient(accountEndpoint, credential);
```

## Read properties of the account

> [!TIP]
> At this point, you only have a logical client-side representation of the Azure Cosmos DB for NoSQL account. The SDK won't initially connect to the account until you perform an operation.

Once the client instance is instantiated, you can use various methods directly. For example, you can asynchronously invoke the **ReadAccountAsync** method to get an object of type **AccountProperties** with various properties.

```csharp
AccountProperties account = await client.ReadAccountAsync();
```

The **AccountProperties** class includes useful properties such as, but not limited to:

| **Property** | **Description** |
| --- | --- |
| **Id** | Gets the unique name of the account |
| **ReadableRegions** | Gets a list of readable locations for the account |
| **WritableRegions** | Gets a list of writable locations for the account |
| **Consistency** | Gets the default consistency level for the account |

## Interact with a database

Once you have a client instance, you can retrieve or create a database using one of three methods:

- Retrieve an existing database using the name
- Create a new database passing in a unique database name
- Have the SDK check for the existence of the database and either create or retrieve it automatically

Any of these three methods return an instance of type **Database** that you can use to interact with the database.

### Retrieve an existing database

```csharp
Database database = client.GetDatabase("cosmicworks");
```

### Create a new database

```csharp
Database database = await client.CreateDatabaseAsync("cosmicworks");
```

### Create database if it doesn't already exist

```csharp
Database database = await client.CreateDatabaseIfNotExistsAsync("cosmicworks");
```

## Interact with a container

Now that you have a database instance, you can retrieve or create a container using one of three methods:

- Retrieve an existing container using just the name.
- Create a new container passing in a unique container name, partition key path, and the amount of throughput to manually provision.
- Have the SDK check for the existence of the container and either create or retrieve it automatically.

Any of these three methods return an instance of type **Container** that you can use to interact with the container.

### Retrieve an existing container

```csharp
Container container = database.GetContainer("products");
```

### Create a new container

```csharp
Container container = await database.CreateContainerAsync(
    new ContainerProperties(chatContainerName, "/categoryId"), 
    ThroughputProperties.CreateAutoscaleThroughput(1000)
);
```

### Create container if it doesn't already exist

```csharp
Container container = await database.CreateContainerIfNotExistsAsync(
    new ContainerProperties(chatContainerName, "/categoryId"), 
    ThroughputProperties.CreateAutoscaleThroughput(1000)
);
```
