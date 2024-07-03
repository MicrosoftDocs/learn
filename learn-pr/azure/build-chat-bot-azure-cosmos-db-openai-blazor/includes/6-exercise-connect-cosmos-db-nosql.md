The `CosmosDbService` class contains a stub implementation of a service similar to the `OpenAiService` class you worked on previously in this module. In contrast, this class uses the .NET SDK for Azure Cosmos DB, which works slightly different.

There are a few key requirements to tackle in this exercise:

- Import the .NET SDK for Azure Cosmos DB for NoSQL
- Add the Azure Cosmos DB for NoSQL endpoint and key to the application settings
- Modify the service class with various members and a client instance

## Import the .NET SDK

The [`Microsoft.Azure.Cosmos`](https://www.nuget.org/packages/Microsoft.Azure.Cosmos) NuGet package is a typed library that simplifies the process of accessing Azure Cosmos DB for NoSQL from a .NET application.

1. Open a new terminal.

1. Import the `Microsoft.Azure.Cosmos` package from NuGet with `dotnet add package`.

    ```bash
    dotnet add package Microsoft.Azure.Cosmos --version 3.*
    ```

1. Build the .NET project one more time.

    ```bash
    dotnet build
    ```

1. Close the terminal.

## Add application settings

Use the `appsettings.Development.json` file again to provide current values for the Azure Cosmos DB for NoSQL endpoint and key.

1. Open the **appsettings.Development.json** file.

1. Within the file, create another new JSON object with a placeholder property for `CosmosDb` settings.

    ```json
    {
      "OpenAi": {
        "Endpoint": "<your-azure-openai-endpoint>",
        "Key": "<your-azure-openai-key>"
      },
      "CosmosDb": {
      }
    }
    ```

1. Within the `CosmosDb` property, create two new properties for the `Endpoint` and `Key`. Use the Azure Cosmos DB endpoint and key settings you recorded earlier in this project.

    ```json
    {
      "OpenAi": {
        "Endpoint": "<your-azure-openai-endpoint>",
        "Key": "<your-azure-openai-key>"
      },
      "CosmosDb": {
        "Endpoint": "<your-azure-cosmos-db-endpoint>",
        "Key": "<your-azure-cosmos-db-key>"
      }
    }
    ```

    Assuming the name of the Azure Cosmos DB account is **nybncrsna76fo-cosmos-nosql** and the key is `Aj2OSQqWhXfFzkITIi4MIbocWAAoBCUWnSPzHlQbDYA3TiyZCJlk8A6R1l6WqD45BxAG5vrsyQ4SCXEkPS1pLh==`, you would configure the JSON object like this example.

    ```json
    {
      "OpenAi": {
        "Endpoint": "<your-azure-openai-endpoint>",
        "Key": "<your-azure-openai-key>"
      },
      "CosmosDb": {
        "Endpoint": "https://nybncrsna76fo-cosmos-nosql.documents.azure.com:443/",
        "Key": "Aj2OSQqWhXfFzkITIi4MIbocWAAoBCUWnSPzHlQbDYA3TiyZCJlk8A6R1l6WqD45BxAG5vrsyQ4SCXEkPS1pLh=="
      }
    }
    ```

    > [!NOTE]
    > The key in this example is fictitious.

1. Save the **appsettings.Development.json** file.

## Add required members and a client instance

Finally, implement the class variables and client required to access Azure Cosmos DB for NoSQL using the client. For this step, use the SDK's client classes to implement an instance of type `Container` in the `CosmosDbService` class.

1. Open the **Services/CosmosDbService.cs** file.

1. Add using directives for the following namespaces.

    - `Microsoft.Azure.Cosmos`

    - `Microsoft.Azure.Cosmos.Fluent`

    ```csharp
    using Microsoft.Azure.Cosmos;
    using Microsoft.Azure.Cosmos.Fluent;
    ```

1. Within the `CosmosDbService` class, add a new `Container`-typed variable named `_container`.

    ```csharp
    private readonly Container _container;
    ```

1. Within the constructor, add `ArgumentNullException.ThrowIfNullOrEmpty` checks to throw an error if either the `endpoint` or `key` parameters are null.

    ```csharp
    ArgumentNullException.ThrowIfNullOrEmpty(endpoint);
    ArgumentNullException.ThrowIfNullOrEmpty(key);
    ```

1. Now, create a variable named `options` of type [`CosmosSerializationOptions`](/dotnet/api/microsoft.azure.cosmos.cosmosserializationoptions). Set the `PropertyNamingPolicy` property of the variable to `CosmosPropertyNamingPolicy.CamelCase`.

    ```csharp
    CosmosSerializationOptions options = new()
    {
        PropertyNamingPolicy = CosmosPropertyNamingPolicy.CamelCase
    };
    ```

    > [!NOTE]
    > Setting this property will ensure that the JSON produced by the SDK is both serialized and deserialized in *camel case* regardless of how it's corresponding property is cased in the .NET class.

1. Create a new instance of type [`CosmosClient`](/dotnet/api/microsoft.azure.cosmos.cosmosclient) named `client` using the [`CosmosClientBuilder`](/dotnet/api/microsoft.azure.cosmos.fluent.cosmosclientbuilder) class, endpoint, key, and serialization options you specified earlier.

    ```csharp
    CosmosClient client = new CosmosClientBuilder(endpoint, key)
        .WithSerializerOptions(options)
        .Build();
    ```

1. Create a new nullable variable of type `Database` named `database` by calling the `GetDatabase` method of the client variable.

    ```csharp
    Database? database = client?.GetDatabase(databaseName);
    ```

1. Create another nullable variable named `container` of type `Container` by calling the `GetContainer` method of the database variable.

    ```csharp
    Container? container = database?.GetContainer(containerName);
    ```

1. Finally, assign the constructor's `container` variable to the class' `_container` variable only if it's not null. If it's null, throw an `ArgumentException`.

    ```csharp
    _container = container ??
        throw new ArgumentException("Unable to connect to existing Azure Cosmos DB container or database.");
    ```

    > [!TIP]
    > This block of code uses the null coalescing operator to check if the variable is null before performing the assignment.

1. Save the **Services/CosmosDbService.cs** file.

## Check your work

At this point, your constructor should include enough logic to create a container instance that the rest of the service uses. Since the class doesn't do anything with the container yet, there's no point in running the web application, but there's value in building the application to make sure your code doesn't have any omissions or errors.

### [Validate application](#tab/validate-app)

1. Open a new terminal.

1. Build the .NET project.

    ```bash
    dotnet build
    ```

1. Observe the build output and check to make sure there aren't any build errors.

    ```output
    MSBuild version 17.5.1+f6fdcf537 for .NET
      Determining projects to restore...
      All projects are up-to-date for restore.
      cosmoschatgpt -> /workspaces/cosmosdb-chatgpt/bin/Debug/net8.0/cosmoschatgpt.dll
    
    Build succeeded.
        0 Warning(s)
        0 Error(s)
    
    Time Elapsed 00:00:06.45
    ```

1. Close the terminal.

### [Review code](#tab/review-code)

1. Review the *CosmosDbService.cs* code file to make sure that your code matches this sample.

    ```csharp
    using Cosmos.Chat.GPT.Models;
    using Microsoft.Azure.Cosmos;
    using Microsoft.Azure.Cosmos.Fluent;
    
    namespace Cosmos.Chat.GPT.Services;

    public class CosmosDbService
    {
        private readonly Container _container;

        public CosmosDbService(string endpoint, string key, string databaseName, string containerName)
        {
            // Implementation removed for brevity
        }
    
        // Other methods removed for brevity
    }
    ```

1. Within the **CosmosDbService** class, review the constructor to make sure that your code matches this sample.

    ```csharp
    ArgumentNullException.ThrowIfNullOrEmpty(databaseName);
    ArgumentNullException.ThrowIfNullOrEmpty(containerName);
    
    ArgumentNullException.ThrowIfNullOrEmpty(endpoint);
    ArgumentNullException.ThrowIfNullOrEmpty(key);

    CosmosSerializationOptions options = new()
    {
        PropertyNamingPolicy = CosmosPropertyNamingPolicy.CamelCase
    };

    CosmosClient client = new CosmosClientBuilder(endpoint, key)
        .WithSerializerOptions(options)
        .Build();

    Database? database = client?.GetDatabase(databaseName);
    Container? container = database?.GetContainer(containerName);
    
    _container = container ??
            throw new ArgumentException("Unable to connect to existing Azure Cosmos DB container or database.");
    ```

1. Review the **appsettings.Development.json** file to ensure you have valid credentials for the Azure Cosmos DB service.

    ```json
    {
      "OpenAi": {
        "Endpoint": "<your-azure-openai-endpoint>",
        "Key": "<your-azure-openai-key>"
      },
      "CosmosDb": {
        "Endpoint": "<your-azure-cosmos-db-endpoint>",
        "Key": "<your-azure-cosmos-db-key>"
      }
    }
    ```

---
