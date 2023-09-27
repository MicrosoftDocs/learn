Once the **Microsoft.Azure.Cosmos** library is imported, you can begin using the namespaces and classes within your .NET project.

## Import the namespace

Before using the library, you should import the **Microsoft.Azure.Cosmos** namespace using a **directive**. The using directive allows you to use types within the namespace without being forced to fully qualify each type.

```csharp
using Microsoft.Azure.Cosmos;
```

## Use the CosmosClient class

The two most common ways to create an instance for the **CosmosClient** class is to instantiate it with one of the following two constructors:

- A constructor that takes a single string value representing the connection string for the account.
- A constructor that takes two string values representing the endpoint and a key for the account.

> [!NOTE]
> You can always retrieve the connection string, endpoint, or any of the keys from the Azure portal. For the examples in this section, we will use a fictional endpoint of **https­://dp420.documents.azure.com:443/** and a sample key of **fDR2ci9QgkdkvERTQ==**.

> [!TIP]
> You can also use the CosmosClient class with the Microsoft Identity Platform directly for Azure AD authentication, but that is beyond the scope of this module.

### Use with a connection string

The **CosmosClient** class has a constructor that only takes a single string value. Pass in the connection string of the account to use this constructor. This example uses a connection string in the ``AccountEndpoint=<account-endpoint>;AccountKey=<account-key>`` format with the fictional endpoint and key.

```csharp
string connectionString = "AccountEndpoint=https­://dp420.documents.azure.com:443/;AccountKey=fDR2ci9QgkdkvERTQ==";

CosmosClient client = new (connectionString);
```

### Use with an endpoint and key

Alternatively, you can use a constructor of the **CosmosClient** class that takes in two string parameters representing the account's **endpoint** and **key** in that order. This example uses the fictional endpoint and key.

```csharp
string endpoint = "https­://dp420.documents.azure.com:443/";
string key = "fDR2ci9QgkdkvERTQ==";

CosmosClient client = new (endpoint, key);
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

Any of these three methods will return an instance of type **Database** that you can use to interact with the database.

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

- Retrieve an existing container using just the name
- Create a new container passing in a unique container name, partition key path, and the amount of throughput to manually provision
- Have the SDK check for the existence of the container and either create or retrieve it automatically

Any of these three methods will return an instance of type **Container** that you can use to interact with the container.

### Retrieve an existing container

```csharp
Container container = database.GetContainer("products");
```

### Create a new container

```csharp
Container container = await database.CreateContainerAsync(
    "products", 
    "/categoryId", 
    400
);
```

### Create container if it doesn't already exist

```csharp
Container container = await database.CreateContainerIfNotExistsAsync(
    "products", 
    "/categoryId", 
    400
);
```
