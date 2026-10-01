With the singleton client registered, Contoso's developer has a stable entry point to Azure Cosmos DB. The next decision is the network path between the application and the service. The Azure Cosmos DB SDK supports two connectivity modes: gateway and direct, and the right choice depends on the network environment where the application runs. Beyond connectivity mode, client options for timeouts, retries, and region preference determine how the client performs under real workload conditions.

## Gateway mode vs. direct mode

The SDK routes requests to Azure Cosmos DB through one of two paths. Understanding how each path works makes the choice straightforward for most deployment environments.

| Mode | How it works | When to use |
|:-----|:-------------|:------------|
| **Direct** | The gateway supplies routing metadata at initialization and again whenever cached addresses go stale. Data requests travel directly to storage partition replicas over TCP (Transmission Control Protocol). Address information is cached locally. | Low-latency apps on Azure VMs (virtual machines), containers, or App Service with the required outbound TCP access. Public and service endpoints use ports 10000-20000; private endpoints can use the full range 0-65535, in addition to gateway access. Supported by the .NET and Java SDKs (software development kits) only. |
| **Gateway** | All requests (reads, writes, and queries) route through the Cosmos DB HTTPS gateway, which forwards them to the appropriate replica. | Environments behind strict firewalls or HTTP-only proxies, and hosts that limit outbound connections, such as Azure Functions on the Consumption plan. |

:::image type="content" source="../media/sdk-connectivity-modes.png" alt-text="Diagram comparing gateway mode (all requests via HTTPS gateway) and direct mode (data requests via TCP to partition replicas)." lightbox="../media/sdk-connectivity-modes.png":::

Where direct mode is available, it's the default and delivers lower latency, because data requests skip the gateway hop. The routing metadata the SDK fetches from the gateway tells the client exactly which partition replica holds the requested data, so each subsequent request travels the shortest path. That metadata is refetched whenever replica movement or service maintenance invalidates the cached addresses, so the gateway still handles metadata even in direct mode. Gateway mode trades the latency advantage for simpler network requirements: every request uses HTTPS on port 443, which passes through most corporate firewalls and proxy configurations without more rules. The Python SDK supports gateway mode only, so the choice applies to the C# examples in this unit.

When choosing between the two, consider where the application runs rather than which mode sounds more appealing. An app deployed to Azure App Service with unrestricted outbound TCP benefits from direct mode. The same app running behind a firewall that blocks everything except port 443 fails in direct mode; gateway mode is the correct choice for that environment.

## Configuring connectivity mode in code

Connectivity mode is set through a client options object passed to the `CosmosClient` constructor. The options object exposes the connection mode alongside all other tunable settings, keeping configuration in one place rather than scattered across multiple initialization steps.

::: zone pivot="csharp"

Create a `CosmosClientOptions` instance, set `ConnectionMode`, and pass it to the constructor:

```csharp
CosmosClientOptions options = new()
{
    ConnectionMode = ConnectionMode.Direct
};

CosmosClient client = new(endpoint, new DefaultAzureCredential(), options);
```

To use gateway mode instead, change the enum value:

```csharp
CosmosClientOptions options = new()
{
    ConnectionMode = ConnectionMode.Gateway
};
```

::: zone-end

::: zone pivot="python"

The Python SDK currently supports only gateway connectivity. Pass `connection_mode='Gateway'` explicitly, or omit the parameter; gateway is the default:

```python
from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential

client = CosmosClient(
    url=endpoint,
    credential=DefaultAzureCredential(),
    connection_mode='Gateway'
)
```

> [!NOTE]
> The Python SDK doesn't currently support direct connectivity mode. Gateway mode routes all requests through the Cosmos DB HTTPS gateway on port 443. The account endpoint must still be reachable, and network policies and the account firewall must permit the connection.

::: zone-end

Because the singleton is created once at application startup, connectivity mode is fixed for the lifetime of the process. There's no way to switch modes on a running client, so treat this task as a startup-time decision that reflects the deployment environment.

## Time out and retry settings

Rate limiting and transient network delays are normal in distributed systems. The SDK handles both automatically through built-in retry logic, but the default thresholds are designed for general-purpose workloads rather than tuned production scenarios. Adjusting timeout and retry settings lets you align the SDK's behavior with the latency budget and throughput expectations of Contoso's web API.

Two scenarios benefit most from tuning these settings. First, a web API with a tight response time SLA (service level agreement) can lower `RequestTimeout` to limit the wait for each network response. An SDK operation can make multiple requests and retries, so this setting doesn't impose an end-to-end deadline. Pass a `CancellationToken` to the operation to request cancellation across those requests and retries; cancellation is cooperative. Second, an account provisioned close to its throughput limit benefits from fewer retry attempts. Fewer retries surface the 429 rate-limit error to the application faster. The application can then queue or shed load intentionally, instead of burning time in the SDK's retry loop.

::: zone pivot="csharp"

`CosmosClientOptions` exposes three properties that control timeout and retry behavior:

| Option | Default | Purpose |
|:-------|:--------|:--------|
| `RequestTimeout` | 6 seconds | Time to wait for a network response on an individual request, not the entire SDK operation. |
| `MaxRetryAttemptsOnRateLimitedRequests` | 9 | Number of retries before surfacing a 429 to the caller. |
| `MaxRetryWaitTimeOnRateLimitedRequests` | 30 seconds | Maximum cumulative wait time across all retries for rate-limited requests. |

```csharp
CosmosClientOptions options = new()
{
    RequestTimeout = TimeSpan.FromSeconds(3),
    MaxRetryAttemptsOnRateLimitedRequests = 5,
    MaxRetryWaitTimeOnRateLimitedRequests = TimeSpan.FromSeconds(15)
};
```

::: zone-end

::: zone pivot="python"

The Python SDK exposes related settings as constructor parameters on `CosmosClient`. Use `read_timeout` to bound how long the client waits for a response after the connection is established, which is the closest match to the .NET `RequestTimeout` property. The separate `connection_timeout` parameter governs a different phase: establishing the connection itself.

```python
client = CosmosClient(
    url=endpoint,
    credential=DefaultAzureCredential(),
    read_timeout=30,
    retry_total=5,
    retry_backoff_max=15
)
```

> [!NOTE]
> `retry_total` and `retry_backoff_max` configure throttling and transport retry settings, while the .NET retry properties in the preceding table are scoped to HTTP 429 responses. They aren't a single global limit on every internal retry path. Python retry behavior also depends on the error, the operation, and separate policies such as the opt-in `retry_write` setting covered in the error-handling unit.

::: zone-end

In both languages, these settings combine with connectivity mode and region preference in the same options object or constructor call, so the full configuration remains readable at a glance.

## Preferred regions

By default, the client targets the account's primary write region for all requests. For multi-region Cosmos DB accounts, placing a nearby read region first in the preferred region list can reduce round-trip latency for read-heavy workloads like Contoso's product-browsing endpoint. The SDK uses the list as an ordered preference, not an automatic measurement of which region is closest: it tries the first available configured read region and falls back to subsequent entries. For a single-write-region account, writes still target the current write region.

::: zone pivot="csharp"

Set `ApplicationPreferredRegions` to an ordered list of Azure region names:

```csharp
CosmosClientOptions options = new()
{
    ApplicationPreferredRegions = new List<string> { "West US", "East US" }
};
```

> [!NOTE]
> `ApplicationPreferredRegions` and `ApplicationRegion` are mutually exclusive. `ApplicationRegion` takes a single region name and lets the SDK rank the remaining regions by proximity. Setting both properties on the same options object throws an exception when the client is constructed.

::: zone-end

::: zone pivot="python"

Pass `preferred_locations` as an ordered list:

```python
client = CosmosClient(
    url=endpoint,
    credential=DefaultAzureCredential(),
    preferred_locations=["West US", "East US"]
)
```

::: zone-end

> [!NOTE]
> The preferred region list is only the client side of multi-region behavior. How quickly a failover completes also depends on the account's replication and failover configuration, which is set on the Azure Cosmos DB account rather than in the SDK.

After the developer configures connectivity mode, timeouts, retries, and preferred regions, the `CosmosClient` is tuned for the Contoso web API's production environment. The next unit introduces the Azure Cosmos DB emulator so the developer can run the same code against a local instance during development, without a live Azure account.

---

> **Guiding question:** A web app runs inside Azure App Service behind a corporate network policy that blocks all outbound TCP traffic except on port 443. The developer configures `ConnectionMode.Direct`. What outcome do you expect, and which setting resolves it?
