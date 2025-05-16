Once the client library is imported, you can begin using the namespaces and classes within your project.

::: zone pivot="csharp"

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
> At this point, you only have a logical client-side representation of the Azure Cosmos DB for NoSQL account. The SDK doesn't initially connect to the account until you perform an operation.

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

::: zone-end

::: zone pivot="python"

## Import the library

Before using the library, you need to import the **CosmosClient** and other necessary classes from the **azure.cosmos** module. Importing these classes allows you to access types without needing to fully qualify each type.

```python
from azure.cosmos import CosmosClient, PartitionKey, ThroughputProperties, ContainerProxy, exceptions
```

## Use the CosmosClient class

The three most common ways to create an instance for the **CosmosClient** class is to instantiate it with one of the following three constructors:

- A constructor that takes a single string value representing the connection string for the account.
- A constructor that takes two string values representing the endpoint and a key for the account.
- A constructor that takes a string value representing the endpoint and a token credential that enables Microsoft Entra ID authentication.

> [!NOTE]
> You can always retrieve the connection string, endpoint, or any of the keys from the Azure portal. For the examples in this section, we use a fictional endpoint of **https­://dp420.documents.azure.com:443/** and a sample key of **fDR2ci9QgkdkvERTQ==**.

> [!TIP]
> Using the CosmosClient class with the Microsoft Identity Platform directly for Microsoft Entra ID authentication is considered a best practice. Read the [security guidance for Azure Cosmos DB for NoSQL](/azure/cosmos-db/nosql/security/) for more information.

### Use with a connection string

The **CosmosClient** class can be instantiated by passing the connection string. This example uses a connection string in the format `AccountEndpoint=<account-endpoint>;AccountKey=<account-key>`.

```python
connection_string = "AccountEndpoint=https://dp420.documents.azure.com:443/;AccountKey=fDR2ci9QgkdkvERTQ=="

client = CosmosClient.from_connection_string(connection_string)
```

### Use with an endpoint and key

Alternatively, you can create an instance of the **CosmosClient** class by providing the endpoint and the key as two separate parameters.

```python
endpoint = "https://dp420.documents.azure.com:443/"
key = "fDR2ci9QgkdkvERTQ=="

client = CosmosClient(endpoint, key)
```

### Use with an endpoint and token credential

You can also use a constructor of the **CosmosClient** class that takes in an **endpoint** and a **token credential**. This constructor is used when you want to authenticate using Microsoft Entra ID. This example uses the fictional endpoint and a token credential.

```python
from azure.identity import DefaultAzureCredential

credential = DefaultAzureCredential()
endpoint = "https://dp420.documents.azure.com:443/"

client = CosmosClient(url=endpoint, credential=credential)
```

## Read properties of the account

> [!TIP]
> At this point, the client instance is just a logical representation of the Azure Cosmos DB account. No connection is made until you perform an operation.

Once the client instance is created, you can use it to perform various operations. For example, you can use the **client.get_database_account()** method to access account properties.

```python
account_info = client.get_database_account()
```

The `account_info` object represents an instance of the `DatabaseAccount`, which includes useful properties, such as:

| **Property** | **Description** |
| --- | --- |
| **EnableMultipleWritableLocations** | Flag on the Azure Cosmos account that indicates if writes can take place in multiple locations |
| **ReadableLocations** | A list of readable locations for the account |
| **WritableLocations** | A list of writable locations for the account |
| **ConsistencyPolicy** | The default consistency level for the account |

## Interact with a database

Once you have a client instance, you can retrieve or create a database using one of three methods:

- Retrieve an existing database using its name.
- Create a new database by passing a unique database name.
- Check for the existence of the database and either create or retrieve it automatically.

Any of these methods return a **DatabaseProxy** instance that you can use to interact with the database.

### Retrieve an existing database

```python
database = client.get_database_client("cosmicworks")
```

### Create a new database

```python
database = client.create_database("cosmicworks")
```

### Create a database if it doesn't already exist

```python
database = client.create_database_if_not_exists("cosmicworks")
```

## Interact with a container

With a database instance, you can retrieve or create a container using one of the following methods:

- Retrieve an existing container by name.
- Create a new container by specifying a unique container name, partition key path, and manually provisioned throughput.
- Check for the existence of the container and either create or retrieve it automatically.

Each method returns a **ContainerProxy** instance that you can use to interact with the container.

### Retrieve an existing container

```python
container = database.get_container_client("products")
```

### Create a new container

```python
container = database.create_container(
    id="products",
    partition_key=PartitionKey(path="/categoryId"),
    throughput=ThroughputProperties(auto_scale_max_throughput=1000)
)
```

### Create a container if it doesn't already exist

```python
container = database.create_container_if_not_exists(
    id="products",
    partition_key=PartitionKey(path="/categoryId"),
    offer_throughput=ThroughputProperties(auto_scale_max_throughput=1000)
)
```

::: zone-end

::: zone pivot="node"

## Import the library

Before using the library, you need to import the **CosmosClient** and other necessary classes from the **@azure/cosmos** package. Importing these classes allows you to access types without needing to fully qualify each type.

```javascript
const { CosmosClient, Database, Container } = require("@azure/cosmos");
```

## Use the CosmosClient class

The three most common ways to create an instance for the **CosmosClient** class is to instantiate it with one of the following three constructors:

- A constructor that takes a single string value representing the connection string for the account.
- A constructor that takes two string values representing the endpoint and a key for the account.
- A constructor that takes a string value representing the endpoint and a token credential that enables Microsoft Entra ID authentication.

> [!NOTE]
> You can always retrieve the connection string, endpoint, or any of the keys from the Azure portal. For the examples in this section, we use a fictional endpoint of **https­://dp420.documents.azure.com:443/** and a sample key of **fDR2ci9QgkdkvERTQ==**.

> [!TIP]
> Using the CosmosClient class with the Microsoft Identity Platform directly for Microsoft Entra ID authentication is considered a best practice. Read the [security guidance for Azure Cosmos DB for NoSQL](/azure/cosmos-db/nosql/security/) for more information.

### Use with a connection string

The **CosmosClient** class can be instantiated by passing the connection string. This example uses a connection string in the format `AccountEndpoint=<account-endpoint>;AccountKey=<account-key>`.

```javascript
const connectionString = "AccountEndpoint=https://dp420.documents.azure.com:443/;AccountKey=fDR2ci9QgkdkvERTQ==";

const client = new CosmosClient({ connectionString });
```

### Use with an endpoint and key

Alternatively, you can create an instance of the **CosmosClient** class by providing the endpoint and the key as two separate parameters.

```javascript
const endpoint = "https://dp420.documents.azure.com:443/";
const key = "fDR2ci9QgkdkvERTQ==";

const client = new CosmosClient({ endpoint, key });
```

### Use with an endpoint and key

You can also use a constructor of the **CosmosClient** class that takes in an **endpoint** and a **token credential**. This constructor is used when you want to authenticate using Microsoft Entra ID. This example uses the fictional endpoint and a token credential.

```javascript
const { DefaultAzureCredential } = require("@azure/identity");

const credential = new DefaultAzureCredential();
const endpoint = "https://dp420.documents.azure.com:443/";

const client = new CosmosClient({ endpoint, aadCredentials: credential });
```

## Read properties of the account

> [!TIP]
> At this point, the client instance is just a logical representation of the Azure Cosmos DB account. No connection is made until you perform an operation.

Once the client instance is created, you can use it to perform various operations. For example, you can retrieve account properties using the **getDatabaseAccount** method.

```javascript
async function readAccountProperties() {
    const { resource: accountInfo } = await client.getDatabaseAccount();
    console.log(accountInfo);
}

readAccountProperties().catch((error) => console.error(error));
```

The `accountInfo` object represents an instance of the **DatabaseAccount**, which includes useful properties, such as:

| **Property** | **Description** |
| --- | --- |
| **enableMultipleWritableLocations** | Flag on the Azure Cosmos account that indicates if writes can take place in multiple locations |
| **readableLocations** | A list of readable locations for the account |
| **writableLocations** | A list of writable locations for the account |
| **consistencyPolicy** | The default consistency level for the account |

## Interact with a database

Once you have a client instance, you can retrieve or create a database using one of three methods:

- Retrieve an existing database using its name.
- Create a new database by passing a unique database name.
- Check for the existence of the database and either create or retrieve it automatically.

Any of these methods return a **Database** instance that you can use to interact with the database.

### Retrieve an existing database

```javascript
const database = client.database("cosmicworks");
```

### Create a new database

```javascript
const { resource: database } = await client.databases.createIfNotExists({ id: "cosmicworks" });
```

### Create a database if it doesn't already exist

```javascript
const { resource: database } = await client.databases.createIfNotExists({ id: "cosmicworks" });
```

## Interact with a container

With a database instance, you can retrieve or create a container using one of the following methods:

- Retrieve an existing container by name.
- Create a new container by specifying a unique container name, partition key path, and manually provisioned throughput.
- Check for the existence of the container and either create or retrieve it automatically.

Each method returns a **Container** instance that you can use to interact with the container.

### Retrieve an existing container

```javascript
const container = database.container("products");
```

### Create a new container

```javascript
const { resource: container } = await database.containers.create({
    id: "products",
    partitionKey: {
        paths: ["/categoryId"]
    },
    maxThroughput: 1000
});
```

### Create a container if it doesn't already exist

```javascript
const { resource: container } = await database.containers.createIfNotExists({
    id: "products",
    partitionKey: {
        paths: ["/categoryId"]
    },
    maxThroughput: 1000
});
```

::: zone-end
