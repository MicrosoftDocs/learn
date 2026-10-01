With connectivity mode, timeouts, and preferred regions all configured, the client is tuned for production, and iteration speed becomes the next challenge. Each code change that requires a round-trip to Azure consumes request units and adds network latency to the development loop. The Azure Cosmos DB emulator runs the Cosmos DB for NoSQL wire protocol on a local machine, so the SDK connects to it exactly as it connects to a cloud account, without a live Azure account or any cloud cost.

## What the emulator provides

The emulator replicates the Cosmos DB for NoSQL API wire protocol locally. Because it implements the same protocol the SDK uses, application code written against the emulator remains mostly unchanged except for the SDK connection itself for authentication, certificate handling, and connection mode when pointed at a cloud account. There are also some small feature differences as new features are released. That said, the overall compatibility makes the emulator genuinely useful when used for development and testing.

Three development scenarios benefit most from running against the emulator:

- **Zero-cost testing:** unit and integration tests run locally without consuming request units or requiring network access.
- **Rapid data model iteration:** schema and query changes are explored in a tight local loop before touching a shared cloud account, where mistakes are harder to reverse.
- **Restricted network environments:** development continues even when outbound internet access is unavailable, such as in regulated or air-gapped environments.

The emulator is available in several forms depending on your operating system:

| Form | How to obtain |
|:-----|:-------------|
| Windows Installer | Download from the Azure Cosmos DB emulator page on Microsoft Learn |
| Windows Docker container | `docker pull mcr.microsoft.com/cosmosdb/windows/azure-cosmos-emulator` |

The Linux-based vNext emulator is the recommended local development option for Azure Cosmos DB for NoSQL. It runs as a Docker container on Windows, macOS, and Linux, including supported ARM64 environments. vNext supports the NoSQL API in gateway mode and implements the core operations needed for most local development and integration testing. It doesn't emulate every cloud-service capability. In particular, it doesn't implement request-unit accounting, Direct mode, or server-side JavaScript through stored procedures, triggers, and user-defined functions. Use the Windows local emulator or legacy Linux container only when your tests require capabilities that vNext doesn't yet support. Always validate performance, throughput, regional behavior, and unsupported features against an Azure Cosmos DB account before release.

The NoSQL API is supported across all forms.

Start the legacy Linux container with the gateway port and the direct-mode port range published:

```bash
docker run --publish 8081:8081 --publish 10250-10255:10250-10255 --name linux-emulator --detach mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator:latest
```

The vNext image publishes the gateway port, a health probe port, and the Data Explorer port instead. Adding `--protocol https` switches it from its default HTTP mode:

```bash
docker run --detach --publish 8081:8081 --publish 8080:8080 --publish 1234:1234 mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator:vnext-latest --protocol https
```

> [!NOTE]
> The emulator is a local development tool only. It doesn't replicate all service-side behaviors such as cross-region replication, global consistency enforcement, or performance at scale. The legacy Linux container doesn't run on ARM64 devices, so use the vNext image on that hardware. 

## Connect the SDK to the emulator

The vNext emulator accepts key-based authentication by using a well-known local-development key. It doesn't use Microsoft Entra ID authentication. The key is public and is safe to use only with a local emulator.

This unit starts the emulator in HTTPS mode because the .NET and Java software development kits (SDKs) don't support its HTTP mode:

```bash
docker run \
  --detach \
  --name cosmos-emulator \
  --publish 8081:8081 \
  --publish 8080:8080 \
  --publish 1234:1234 \
  mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator:vnext-latest \
  --protocol https
```

The emulator uses these connection values:

Endpoint: 

```text
https://localhost:8081/
```

Authentication key:

```text
C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==
```

Connection mode: Gateway

The HTTPS endpoint presents a locally generated development certificate. Before connecting, export and trust the emulator certificate by using the certificate-import process for your operating system or language runtime. After the certificate is trusted, the SDK validates it normally.

> [!IMPORTANT]
> Don’t disable TLS validation with DangerousAcceptAnyServerCertificateValidator, connection_verify=False, or an equivalent option. Those settings can accidentally disable certificate validation when the application later connects to Azure.

::: zone pivot="csharp"

### C# example

```csharp
using Microsoft.Azure.Cosmos;

const string endpoint = "https://localhost:8081/";
const string emulatorKey =
    "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==";

CosmosClientOptions options = new()
{
    ConnectionMode = ConnectionMode.Gateway
};

CosmosClient client = new(
    accountEndpoint: endpoint,
    authKeyOrResourceToken: emulatorKey,
    clientOptions: options);
```

::: zone-end

The vNext emulator supports gateway mode only. Explicitly configuring gateway mode prevents a client that normally uses Direct mode from attempting unsupported direct connections.

::: zone pivot="python"

### Python example

```python
from azure.cosmos import CosmosClient

endpoint = "https://localhost:8081/"
emulator_key = (
    "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw=="
)
client = CosmosClient(
    url=endpoint,
    credential=emulator_key,
    connection_mode="Gateway",
)
```

::: zone-end

After creating the client, application code can use the same SDK operations for databases, containers, and items that it uses with Azure. The client configuration still differs: Azure should normally use Microsoft Entra ID, and production workloads can use Direct mode.

## Switch between the emulator and Azure

Keep application data-access code independent of the target environment, but configure the CosmosClient differently for the emulator and Azure.

The vNext emulator:

- Uses its well-known account key.
- Supports gateway mode only.
- Uses a locally trusted development certificate when started with HTTPS.

An Azure Cosmos DB account should normally:

- Authenticate with Microsoft Entra ID by using DefaultAzureCredential.
- Use the connection mode selected for the production workload.
- Trust the service’s publicly signed TLS certificate without custom certificate handling.

Use an explicit environment setting rather than assuming that missing configuration means the emulator. This approach prevents a deployed application with incomplete configuration from silently connecting to an unintended endpoint.

::: zone pivot="csharp"

### C# example

```csharp
using Azure.Identity;
using Microsoft.Azure.Cosmos;

const string emulatorKey = "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==";

string target = Environment.GetEnvironmentVariable("COSMOS_TARGET")
    ?? throw new InvalidOperationException("COSMOS_TARGET must be Emulator or Azure.");

CosmosClient client;

if (target.Equals("Emulator", StringComparison.OrdinalIgnoreCase))
{
    string endpoint = Environment.GetEnvironmentVariable("COSMOS_ENDPOINT")
        ?? "https://localhost:8081/";

    client = new CosmosClient(
        endpoint,
        emulatorKey,
        new CosmosClientOptions
        {
            ConnectionMode = ConnectionMode.Gateway
        });
}
else if (target.Equals("Azure", StringComparison.OrdinalIgnoreCase))
{
    string endpoint = Environment.GetEnvironmentVariable("COSMOS_ENDPOINT")
        ?? throw new InvalidOperationException(
            "COSMOS_ENDPOINT is required when COSMOS_TARGET is Azure.");

    client = new CosmosClient(
        endpoint,
        new DefaultAzureCredential(),
        new CosmosClientOptions
        {
            ConnectionMode = ConnectionMode.Direct
        });
}
else
{
    throw new InvalidOperationException(
        "COSMOS_TARGET must be Emulator or Azure.");
}
```

::: zone-end

::: zone pivot="python"

### Python example

```python
import os

from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential

EMULATOR_KEY = ("C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==")

target = os.environ.get("COSMOS_TARGET")

if target == "Emulator":
    endpoint = os.environ.get("COSMOS_ENDPOINT", "https://localhost:8081/")
    client = CosmosClient(endpoint, credential=EMULATOR_KEY)

elif target == "Azure":
    endpoint = os.environ.get("COSMOS_ENDPOINT")
    if not endpoint:
        raise ValueError(
            "COSMOS_ENDPOINT is required when COSMOS_TARGET is Azure."
        )

    client = CosmosClient(
        endpoint,
        credential=DefaultAzureCredential(),
    )

else:
    raise ValueError("COSMOS_TARGET must be Emulator or Azure.")
```

::: zone-end

For local Azure development, DefaultAzureCredential can use the developer’s Azure CLI sign-in. In Azure, it can use the application’s managed identity. Assign that identity an appropriate data-plane role, such as Cosmos DB Built-in Data Contributor.

> [!IMPORTANT]
> Import and trust the emulator certificate when using HTTPS. Don’t disable TLS validation in shared application code. Certificate-validation callbacks and connection_verify=False can accidentally disable validation when the application connects to Azure.

Changing the target configuration doesn’t copy databases, containers, or data between environments. Provision cloud resources separately through infrastructure as code, and use explicit seed or migration processes when test data is required.

Before release, run integration tests against Azure to validate behavior the emulator doesn’t reproduce, including request charges, indexing behavior, Direct mode, regional distribution, consistency, availability, and performance.
