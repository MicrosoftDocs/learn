As you begin to use Azure Cosmos DB across multiple projects, eventually there might be a need to use and test Azure Cosmos DB in a local environment. With the option to test locally, you can validate new code quickly without creating a new instance in the cloud. The Azure Cosmos DB emulator is a great tool for common Dev+Test workflows that developers may need to implement on their local machine.

## Azure Cosmos DB emulator

The Azure Cosmos DB emulator is a local environment that is useful to develop and test applications locally without incurring the costs or complexity of an Azure subscription.

The emulator is available to run in **Windows**, **Linux**, or as a **Docker** container image.

The emulator is available as a download from the [**Microsoft Learn** website](/azure/cosmos-db/local-emulator) and supports various APIs depending on the platform. The NoSQL API is universally supported across all platforms.

> [!TIP]
> You may optionally install the [new Linux-based Azure Cosmos DB Emulator (in preview)](/azure/cosmos-db/emulator-linux), which is available as a Docker container. It supports running on a wide variety of processors and operating systems.

The Docker container image for the emulator is published to the Microsoft Container Registry and is syndicated across various container registries such as **Docker Hub**. To obtain the Docker container image from Docker Hub, use the Docker CLI to **pull** the image from ``mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator``.

```bash
docker pull mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator
```

## Configuring the SDK to connect to the emulator

The Azure Cosmos DB emulator uses the same APIs as the cloud service, so connecting to the emulator isn't different from connecting to the cloud service. The emulator uses a single fixed account with a static authentication key that is the same across all instances

::: zone pivot="csharp"

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

Once those variables are set, create the **CosmosClient** like you typically do for a cloud-based account.

```csharp
CosmosClient client = new (endpoint, key);
```

::: zone-end

::: zone pivot="python"

First, the emulator's endpoint is ``https://localhost:<port>/`` using SSL with the default port set to 8081. In Python code, you can configure this endpoint as a string variable using this example line of code.

```Python
endpoint = "https://localhost:8081/"
```

The emulator's key is a static well-known authentication key. The default value for this key is ``C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==``. In Python code, you can save this key as a variable using this example line of code.

```Python
key = "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw=="
```

> [!TIP]
> You can start the emulator using the **/Key** option to generate a new key instead of using the default key.

Once those variables are set, create the **CosmosClient** like you typically do for a cloud-based account.

```python
client = CosmosClient(endpoint, key)
```

::: zone-end

::: zone pivot="node"

First, the emulator's endpoint is ``https://127.0.0.1:<port>/`` using SSL with the default port set to 8081. In JavaScript code, you can configure this endpoint as a string variable using this example line of code.

```javascript
const endpoint = "https://127.0.0.1:8081/";
```

> [!NOTE]
> When you use the emulator, the endpoint is typically ``https://localhost:8081/``. However, sometimes Node.js applications attempt to convert the localhost address to an IPv6 address, causing an error such as "RestError: connect ECONNREFUSED ::1:8081". If you encounter this issue, use the IPv4 loopback address ``https://127.0.0.1:8081/``.

The emulator's key is a static well-known authentication key. The default value for this key is ``C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==``. In JavaScript code, you can save this key as a variable using this example line of code.

```javascript
const key = "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==";
```

> [!TIP]
> You can start the emulator using the **/Key** option to generate a new key instead of using the default key.

Once those variables are set, create the **CosmosClient** like you typically do for a cloud-based account.

```javascript
const client = new CosmosClient({ endpoint, key });
```

> [!WARNING]
> If you get an SSL error, you may need to disable TLS/SSL for your application. This error commonly occurs if you're developing on your local machine using the Azure Cosmos DB emulator in a container, and haven't [imported the container's SSL certificate](/azure/cosmos-db/how-to-develop-emulator?tabs=windows%2Cjavascript&pivots=api-nosql#import-the-emulators-tlsssl-certificate). To resolve this issue, configure the application to disable TLS/SSL validation before creating the client:
>
>
> ```javascript
> process.env.NODE_TLS_REJECT_UNAUTHORIZED = 0
> ```
>

::: zone-end
