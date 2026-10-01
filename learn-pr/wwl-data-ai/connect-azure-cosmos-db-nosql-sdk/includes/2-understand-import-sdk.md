Before Contoso's developer writes a single read or write operation, two prerequisites need to be in place: the SDK installed in the project and a mental model of how the library represents Azure Cosmos DB resources in code. This unit covers both: the object hierarchy the SDK exposes and the steps to add the library to your project.

## The SDK client hierarchy

The Azure Cosmos DB SDK mirrors the resource hierarchy of the service itself. An **account** contains one or more **databases**, and each database contains one or more **containers**. The SDK exposes a dedicated class for each level of this hierarchy, so your code interacts with exactly the resource scope it needs rather than routing everything through a single all-purpose object. Think of these classes as a set of concentric scopes: account at the outermost level, database in the middle, container at the innermost. Your code navigates inward from `CosmosClient` to reach a specific container before running any data operation.

::: zone pivot="csharp"

The **Microsoft.Azure.Cosmos** library provides three core classes:

| Class | Description |
|---|---|
| `CosmosClient` | Client-side representation of the account. Entry point for all SDK operations. |
| `Database` | Represents a single database. Provides methods to manage containers and throughput. |
| `Container` | Represents a single container. Provides methods to read, write, query, and manage items. |

::: zone-end

::: zone pivot="python"

The **azure-cosmos** library provides three core classes:

| Class | Description |
|---|---|
| `CosmosClient` | Client-side representation of the account. Entry point for all SDK operations. |
| `DatabaseProxy` | Interface representing a database. Obtain from `CosmosClient`, not by direct instantiation. |
| `ContainerProxy` | Interface representing a container. Obtain from `DatabaseProxy`, not by direct instantiation. |

::: zone-end

In Python, obtain a `DatabaseProxy` from its parent `CosmosClient` and a `ContainerProxy` from its parent `DatabaseProxy`. The `get_database_client()` and `get_container_client()` methods return these handles without creating resources. Creation methods such as `create_database()` and `create_container()` also return proxies. The proxy classes have constructors, but the SDK documentation advises against calling them directly. In C#, parent methods similarly return `Database` and `Container` handles.

This separation goes beyond naming conventions. `CosmosClient` holds the underlying HTTP connections, so the application creates one instance and reuses it for its entire lifetime. The database and container objects are lightweight handles obtained from the client; they carry no connection state of their own. This design concentrates connection pool management at the `CosmosClient` level, not scattered across individual database or container references.

## Installing the SDK

Both SDK packages are open source. The .NET library is maintained in the `Azure/azure-cosmos-dotnet-v3` repository on GitHub and published on NuGet as **Microsoft.Azure.Cosmos**. The Python library lives in the `Azure/azure-sdk-for-python` repository on GitHub and published on PyPI as **azure-cosmos**.

To install the latest stable version, run the appropriate command for your language:

::: zone pivot="csharp"

```bash
dotnet add package Microsoft.Azure.Cosmos
```

To pin to a specific version, append the version flag:

```bash
dotnet add package Microsoft.Azure.Cosmos --version 3.62.1
```

After adding the package, your `.csproj` file includes this entry. The SDK needs `Newtonsoft.Json` as an explicit direct dependency, and the documentation recommends 13.0.4 or higher for SDK 3.54.0 and later. Add it alongside the SDK reference:

```xml
<PackageReference Include="Microsoft.Azure.Cosmos" Version="3.62.1" />
<PackageReference Include="Newtonsoft.Json" Version="13.0.4" />
```

> [!IMPORTANT]
> `Newtonsoft.Json` isn't automatically managed. The SDK build raises an error if it's missing or referenced under version 10.0.2. Add it explicitly at 13.0.4 or higher: the 10.x line the SDK compiles against carries a known security vulnerability, and 13.0.4 is the minimum secure version listed for SDK 3.54.0 and later.

Add the namespace import at the top of any file that uses the SDK:

```csharp
using Microsoft.Azure.Cosmos;
```

::: zone-end

::: zone pivot="python"

```bash
pip install azure-cosmos
```

To pin to a specific version:

```bash
pip install azure-cosmos==4.16.3
```

Add the import at the top of any file that uses the SDK:

```python
from azure.cosmos import CosmosClient, PartitionKey
```

::: zone-end

## Authentication overview

With the package installed, the next decision is how to authenticate with your Azure Cosmos DB account. The SDK supports two approaches: **account keys** and **Microsoft Entra ID**. Understanding when to use each shapes how your application handles credentials across environments.

**Account keys** are primary or secondary keys available in the Azure portal under the account's **Keys** blade. They're simple to use and work immediately, but they're long-lived secrets that require rotation and secure storage. Account keys are appropriate for local tooling, scripts, and the Azure Cosmos DB Emulator during development.

**Microsoft Entra ID** authentication accepts a token credential from the Azure Identity library. `DefaultAzureCredential` tries an ordered, configurable chain of sources, including environment credentials, workload identity, managed identity, and developer sign-ins. The available sources vary by language, platform, and installed packages. An earlier configured credential can take precedence over managed identity or the Azure CLI, so assigning a managed identity or running `az login` doesn't guarantee which identity the client uses. Managed identity avoids stored application secrets, but an environment credential can use a client secret.

Microsoft Entra ID is the recommended approach for Azure-hosted workloads. For production, select a specific credential, such as `ManagedIdentityCredential`, to make identity selection deterministic. `DefaultAzureCredential` remains useful during development. The connection examples use it for development against a cloud account, while the exercise uses `AzureCliCredential` to select the signed-in CLI identity explicitly. Emulator examples use the well-known local key. For the role assignments that back Entra ID access, see [Connect using role-based access control and Microsoft Entra ID](/azure/cosmos-db/how-to-connect-role-based-access-control).

> [!TIP]
> Install the Azure Identity library to enable `DefaultAzureCredential` in your project. In C#, run `dotnet add package Azure.Identity`. In Python, run `pip install azure-identity`.

With the SDK installed, the object model understood, and an authentication approach selected, you have everything the client initialization code needs. The next unit shows how to wire these pieces together into a properly configured `CosmosClient` instance.

---

> **Guiding question:** The SDK splits the account, database, and container into three separate class types rather than one all-purpose class. Why does that separation matter when you write application code, specifically for connection management and resource lifecycle?
