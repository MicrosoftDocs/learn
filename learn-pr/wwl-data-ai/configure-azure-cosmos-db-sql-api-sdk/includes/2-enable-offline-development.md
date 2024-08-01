As you begin to use Azure Cosmos DB across multiple projects, there will eventually be a need to use and test Azure Cosmos DB in a local environment where you can validate new code quickly without creating a new instance in the cloud. The Azure Cosmos DB emulator is a great tool for common Dev+Test workflows that developers may need to implement on their local machine.

## Azure Cosmos DB emulator

The Azure Cosmos DB emulator is a local environment that is useful to develop and test applications locally without incurring the costs or complexity of an Azure subscription.

The emulator is available to run in **Windows**, **Linux**, or as a **Docker** container image.

The emulator is available as a download from the **Microsoft Learn** website and supports various APIs depending on the platform. The NoSQL API is universally supported across all platforms.

The Docker container image for the emulator is published to the Microsoft Container Registry and is syndicated across various container registries such as **Docker Hub**. To obtain the Docker container image from Docker Hub, use the Docker CLI to **pull** the image from ``mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator``.

```bash
docker pull mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator
```

## Configuring the SDK to connect to the emulator

The Azure Cosmos DB emulator uses the same APIs as the cloud service, so connecting to the emulator is not different from connecting to the cloud service. The emulator uses a single fixed account with a static authentication key that is the same across all instances

First, the emulator's endpoint is ``https://localhost:<port>/`` using SSL with the default port set to 8081. In C# code, you can configure this endpoint as a string variable using this example line of code.

```csharp
string endpoint = "https://localhost:8081/";
```

The emulator's key is a static well-known authentication key. The default value for this key is ``C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==``. In C# code, you can save this key as a variable using this example line of code.

```csharp
string key = "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==";
```

> [!TIP]
> You can start the emulator using the **/Key** option to generate a new key instead of using the default key.

Once those variables are set, create the **CosmosClient** like you typically would for a cloud-based account.

```csharp
CosmosClient client = new (endpoint, key);
```
