Contoso's web API handles product-browsing requests and order submissions simultaneously, sometimes in unpredictable bursts. With the SDK installed and the object hierarchy understood, the developer is ready to create a `CosmosClient`. How that client is created shapes the reliability and latency of every request the API processes, so the decision deserves careful attention. The singleton pattern is the single most important reliability practice in the Azure Cosmos DB SDK.

## Why a singleton matters

`CosmosClient` is more than a connection object; it's a resource manager. Internally, it maintains a pool of connections to Azure Cosmos DB, caches the DNS addresses of service endpoints, and stores a routing map that identifies which partition replica to contact for any given request. The .NET SDK defaults to direct mode. In this mode, connections are long-lived TCP (Transmission Control Protocol) sockets. The client also tracks partition layout changes, so it routes reads and writes to the correct backend node without an extra round-trip. The Python SDK reaches the service through the gateway over HTTPS, so its pooled connections are HTTP connections, but the caching and reuse benefits are the same.

Creating a new `CosmosClient` on each incoming request discards all of this accumulated state. The connection pool is abandoned and rebuilt and the address cache is lost, so the SDK pays the connection setup and routing discovery cost again on the next operation. The cumulative effect is measurable latency added to every operation, exactly the wrong outcome for a web API that must respond quickly under load.

The SDK team's guidance is unambiguous: **create one `CosmosClient` per account in each application domain and reuse it for the lifetime of the process.** A singleton keeps connection pools stable, avoids redundant initialization overhead, and lets the client build up the partition routing knowledge that makes direct-mode operations fast. This rule applies equally to web APIs, background workers, and Azure Functions.

## Creating a singleton client

How you express the singleton pattern depends on your hosting model. The following examples cover the two most common approaches for each language.

::: zone pivot="csharp"

**Console app or minimal API:** create the instance once at startup and use it throughout:

```csharp
using Azure.Identity;
using Microsoft.Azure.Cosmos;

string endpoint = "https://<account>.documents.azure.com:443/";
CosmosClient client = new CosmosClient(endpoint, new DefaultAzureCredential());
```

**ASP.NET Core or Azure Functions:** register a dependency injection (DI) singleton so the framework creates and disposes the client exactly once for the lifetime of the host:

```csharp
builder.Services.AddSingleton<CosmosClient>(_ =>
    new CosmosClient(
        accountEndpoint: builder.Configuration["CosmosDb:Endpoint"],
        tokenCredential: new DefaultAzureCredential()
    ));
```

The factory delegate defers construction until the first consumer requests the service, and the host disposes the instance when it stops, with no teardown code to write manually.

> [!TIP]
> Deferred construction means the first request that touches Azure Cosmos DB also pays for connection setup and routing discovery. To move that cost to start up instead, build the client with `CosmosClient.CreateAndInitializeAsync` and register the finished instance. The `containers` list tells the SDK which routing metadata to prefetch.
>
> ```csharp
> using CosmosClient client = await CosmosClient.CreateAndInitializeAsync(
>     accountEndpoint: builder.Configuration["CosmosDb:Endpoint"],
>     tokenCredential: new DefaultAzureCredential(),
>     containers: new List<(string, string)> { ("cosmicworks", "product") }
> );
>
> builder.Services.AddSingleton(client);
> ```
>
> This overload registers an existing instance, so the host doesn't dispose it. Keep the `using` scope alive until the host stops, then let it dispose the client.

::: zone-end

::: zone pivot="python"

**Module-level or application start up:** assign the client to a module-level variable during initialization:

```python
from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential

endpoint = "https://<account>.documents.azure.com:443/"
credential = DefaultAzureCredential()
client = CosmosClient(url=endpoint, credential=credential)
```

**FastAPI lifespan pattern:** use the `lifespan` context manager to create the client when the application starts and close it when the application stops:

```python
from contextlib import asynccontextmanager
from fastapi import FastAPI
from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential

cosmos_client: CosmosClient | None = None

@asynccontextmanager
async def lifespan(app: FastAPI):
    global cosmos_client
    cosmos_client = CosmosClient(
        url="https://<account>.documents.azure.com:443/",
        credential=DefaultAzureCredential()
    )
    yield
    cosmos_client.close()

app = FastAPI(lifespan=lifespan)
```

The `lifespan` function runs startup logic before `yield` and shutdown logic after, providing a clean boundary for initializing and releasing long-lived resources like `CosmosClient`.

::: zone-end

The two SDKs (Software Development Kits) differ in what construction costs. In .NET, the `CosmosClient` constructor makes no network calls, so the SDK defers the first connection to Azure Cosmos DB until the application runs its first operation. In Python, constructing the synchronous client is a heavier operation: it reads account metadata to discover the account's regional endpoints before the constructor returns. Either way, the work belongs at startup rather than on each request.

## Navigating from client to container

With a `CosmosClient` in hand, you obtain a reference to a specific database and then to a container before running any data operation. These calls are synchronous and make no network requests. The SDK returns a logical handle instead. It validates that handle only when you perform an actual read or write.

::: zone pivot="csharp"

```csharp
Database database = client.GetDatabase("cosmicworks");
Container container = database.GetContainer("product");
```

::: zone-end

::: zone pivot="python"

```python
database = client.get_database_client("cosmicworks")
container = database.get_container_client("product")
```

::: zone-end

> [!TIP]
> `GetDatabase`/`get_database_client` and `GetContainer`/`get_container_client` are zero-network, synchronous calls. Call them freely: at startup, in constructors, or at the start of a method, without any concern for network cost.

These handles follow the ownership chain from the previous unit: `CosmosClient` at the account level, database in the middle, container at the innermost scope. Holding a `Container` or `ContainerProxy` reference consumes no connection; it's a typed pointer into the Azure Cosmos DB resource hierarchy. All connection state remains in the single `CosmosClient` instance.

## Disposing the client

Because `CosmosClient` owns the underlying connection pool, release it when the application shuts down. Skipping this step leaks connections and can delay clean process termination.

::: zone pivot="csharp"

`CosmosClient` implements `IDisposable`. Singletons created by a DI factory are disposed automatically when the host stops. An existing instance registered with `AddSingleton(client)` remains the caller's responsibility. For manually created instances, use a lifetime-scoped `using` declaration or call `Dispose()` at shutdown:

```csharp
client.Dispose();
```

::: zone-end

::: zone pivot="python"

Call `close()` when the application exits. For short-lived scripts, use `CosmosClient` as a context manager and `close()` is called automatically on exit:

```python
client.close()
```

::: zone-end

Add the dispose step to the application's startup code from the beginning, instead of leaving it for later. This step keeps the connection lifecycle explicit, matching how the host manages other long-lived resources.

---

> **Try it yourself:** In a minimal console app, create two `CosmosClient` instances pointing at the same endpoint. Use each client to read an existing item with `ReadItemAsync()` (C#) or `read_item()` (Python), supplying its ID and partition key value. Compare those reads with repeated reads through a single reused client. Item reads exercise direct TCP connections in .NET direct mode; account metadata reads use the gateway instead. Timings depend on the network and workload, so compare multiple runs rather than expecting a fixed difference.
