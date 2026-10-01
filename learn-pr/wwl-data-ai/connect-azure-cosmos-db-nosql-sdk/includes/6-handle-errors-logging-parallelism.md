The client is configured, connectivity mode is tuned, and the emulator confirms the setup works locally. The final step before Contoso's web API goes to production is making the connection layer both resilient and observable. This unit covers three concerns that compound each other in production. First, which errors the SDK handles automatically versus which need application-level logic. Second, how to enable logging to see exactly what the SDK does at runtime. Third, how to tune async and parallelism settings to sustain the throughput the API demands.

## Understand built-in retry

Distributed systems experience transient failures regularly: rate-limit responses, brief service restarts, and network hiccups that resolve within milliseconds. The SDK handles many of these issues automatically by catching the response, waiting the service-recommended interval, and resubmitting the request. From the application's perspective, the call eventually succeeds without any extra code.

By default, which codes the SDK retries depends on the operation:

| Status code | Meaning | Retried automatically on |
|:------------|:--------|:-------------------------|
| 408 | Request timed out | Reads and queries |
| 410 | Gone: transient routing or replica change | All operations |
| 429 | Too Many Requests: rate limit exceeded | All operations |
| 449 | Retry With: transient error | Writes |
| 503 | Service unavailable | Reads and queries |

Timeout and connectivity failures on writes are the notable gap. When a write times out, the SDK can't tell whether the request reached the service. Item writes are atomic, but not every write is idempotent: retrying a create that already succeeded returns 409 Conflict, and repeating a non-idempotent update can apply its effects twice. The application needs to judge whether a retry is safe when the outcome is unknown. Rate limiting behaves differently, because a 429 means the request was rejected outright, so the SDK retries it even on writes.

Other status codes indicate problems that retrying can't fix; the application must address them directly:

| Status code | Meaning |
|:------------|:--------|
| 400 | Bad request: malformed request |
| 401 | Unauthorized: invalid credentials |
| 403 | Forbidden: expired auth token, exceeded quota, or firewall rule |
| 404 | Not found: resource doesn't exist |
| 500 | Internal server error: contact Azure support |

> [!TIP]
> Always use the latest SDK version; built-in retry logic and error handling improve with each release.

## Implement application-level retry for writes

The SDK's automatic retries are bounded. Once the .NET SDK's `MaxRetryAttemptsOnRateLimitedRequests` is exhausted, a 429 surfaces to your code. Write timeouts with an unknown outcome aren't retried by default. In both cases, the application decides whether and how to retry. The pattern is to catch the SDK exception, inspect the status code, and retry only for transient errors, using the delay the service recommends rather than a fixed interval. This approach respects the provisioned throughput of the account and avoids amplifying a rate-limit situation by firing rapid successive retries.

The Python SDK also supports opt-in native write retries through `retry_write`, an integer retry count, for timeouts and connectivity failures such as HTTP 408 and 5xx responses. Enable it only when the application tolerates or detects duplicate effects. It can be set on the client or an individual request, but patch operations require request-level opt-in. The examples here leave this option disabled and retry only 429 responses.

::: zone pivot="csharp"

Catch `CosmosException`, check `StatusCode`, and use `RetryAfter` for the delay:

```csharp
using Microsoft.Azure.Cosmos;

async Task<ItemResponse<T>> RetryableWriteAsync<T>(
    Container container, T item, PartitionKey partitionKey, int maxRetries = 3)
{
    int attempts = 0;
    while (true)
    {
        try
        {
            return await container.UpsertItemAsync(item, partitionKey);
        }
        catch (CosmosException ex) when (ex.StatusCode == System.Net.HttpStatusCode.TooManyRequests && attempts < maxRetries)
        {
            attempts++;
            await Task.Delay(ex.RetryAfter ?? TimeSpan.FromSeconds(attempts));
        }
    }
}
```

::: zone-end

::: zone pivot="python"

Catch `CosmosHttpResponseError`, check `status_code`, and read the retry-after header from the underlying response:

```python
import time
from azure.cosmos.exceptions import CosmosHttpResponseError

def retryable_upsert(container, item, max_retries=3):
    attempts = 0
    while True:
        try:
            return container.upsert_item(item)
        except CosmosHttpResponseError as ex:
            if ex.status_code == 429 and attempts < max_retries:
                attempts += 1
                retry_after = ex.response.headers.get("x-ms-retry-after-ms") if ex.response else None
                time.sleep(int(retry_after) / 1000 if retry_after else attempts)
            else:
                raise
```

::: zone-end

> [!NOTE]
> The `RetryAfter` property (C#) and `x-ms-retry-after-ms` header (Python) carry the service-recommended wait time before the next attempt. Using this value produces better back-off behavior than a fixed delay.

## Configure SDK logging

Logging exposes SDK request information: status codes, request URIs (Uniform Resource Identifiers), and request-unit charges appear in your output stream. Exceptions and response diagnostics also expose error details, so logs aren't the only way to distinguish a 403 from a 404. Recording those details helps diagnose a misconfigured credential, a missing resource, or a wrong endpoint. Logged request-unit charges also give you an early signal when a query is more expensive than expected, long before it causes a production incident.

::: zone pivot="csharp"

Register a custom `RequestHandler` through `CosmosClientBuilder`. The handler logs requests that pass through the SDK's middleware pipeline and their final responses. It isn't a complete network trace: internal retries run downstream, and some metadata requests bypass this pipeline. Use response or exception `Diagnostics` to inspect retries and other request details:

```csharp
using Azure.Identity;
using Microsoft.Azure.Cosmos;
using Microsoft.Azure.Cosmos.Fluent;

CosmosClient client = new CosmosClientBuilder(endpoint, new DefaultAzureCredential())
    .AddCustomHandlers(new LogHandler())
    .Build();

public class LogHandler : RequestHandler
{
    public override async Task<ResponseMessage> SendAsync(
        RequestMessage request, CancellationToken cancellationToken)
    {
        Console.WriteLine($"[{request.Method.Method}] {request.RequestUri}");
        ResponseMessage response = await base.SendAsync(request, cancellationToken);
        Console.WriteLine($"  → {(int)response.StatusCode} {response.StatusCode}  RU: {response.Headers.RequestCharge}");
        return response;
    }
}
```

`CosmosClientBuilder` is in the `Microsoft.Azure.Cosmos.Fluent` namespace.

::: zone-end

::: zone pivot="python"

The Azure SDK for Python routes diagnostics through the standard `logging` module. Basic HTTP session information, including request URLs, headers, and response status, is logged at `INFO` level on the `azure.cosmos` logger, so configuring logging is enough to see what the SDK does at runtime:

```python
import logging
import sys

logging.basicConfig(
    stream=sys.stdout,
    level=logging.INFO,
    format="%(asctime)s %(name)s %(levelname)s %(message)s"
)

client = CosmosClient(url=endpoint, credential=credential)
```

For deeper diagnostics, pass `logging_enable=True` when you create the client and raise the `azure.cosmos` logger to `DEBUG`. That combination adds request and response bodies and unredacted headers to the output, without changing logging levels across the rest of your application:

```python
logging.getLogger("azure.cosmos").setLevel(logging.DEBUG)

client = CosmosClient(url=endpoint, credential=credential, logging_enable=True)
```

::: zone-end

> [!TIP]
> In production, use `logging.WARNING` or `logging.INFO` rather than `logging.DEBUG`; debug-level logging is verbose and affects throughput.

## Tune async and parallelism settings

Asynchronous code is the foundation of efficient SDK usage. When the application awaits a Cosmos DB operation, the calling thread is free to handle other requests rather than sitting idle waiting for a network response. This process matters most for a web API like Contoso's, where dozens of requests arrive simultaneously and each one awaits a database operation. Blocking even one thread per request quickly exhausts the thread pool under load.

::: zone pivot="csharp"

Blocking on task results with `.Result` or `.Wait()` defeats the benefit of async. Many synchronous blocking calls lead to thread pool starvation and degraded response times:

```csharp
// Avoid: blocks the calling thread
DatabaseResponse response = client.GetDatabase("cosmicworks").ReadAsync().Result;
```

Using `await` releases the thread while the SDK waits for a response:

```csharp
DatabaseResponse response = await client.GetDatabase("cosmicworks").ReadAsync();
Database database = response.Database;
```

For cross-partition queries, `QueryRequestOptions` provides two settings that control how aggressively the SDK queries multiple partitions in parallel:

| Option | Effect |
|:-------|:-------|
| `MaxConcurrency` | Number of concurrent partition queries. Set it below 0 (for example, `-1`) to let the system decide the number of concurrent operations, or match the number of physical partitions for maximum throughput. |
| `MaxBufferedItemCount` | Items buffered client-side during parallel query execution. Set to `-1` to let the SDK manage it. |

```csharp
QueryRequestOptions options = new()
{
    MaxConcurrency = 5,
    MaxBufferedItemCount = 1000
};
```

Increasing `MaxConcurrency` beyond the number of partitions the query visits doesn't improve throughput. When you set a positive value, the SDK runs the lesser of that value and the number of partitions it needs to visit, so the extra concurrency is ignored.

::: zone-end

::: zone pivot="python"

The Python SDK handles concurrency through the async client or thread pools at the application level. The async client lives in `azure.cosmos.aio` and returns awaitable results and async iterators. Use `async for` when iterating over query results from an async container so other coroutines run between iterations:

```python
from azure.cosmos.aio import CosmosClient

# async for requires an azure.cosmos.aio container; the sync client returns a plain iterable
async for item in container.query_items(
    query="SELECT * FROM c WHERE c.categoryId = @id",
    parameters=[{"name": "@id", "value": "4F34E180-384D-42FC-AC10-FEC30227577F"}]
):
    process(item)
```

::: zone-end

With error handling in place, logging active, and parallelism tuned, the Contoso web API has a production-ready connection layer. The next unit provides an exercise to connect an app to Azure Cosmos DB and apply these settings.

---

> **Synthesis prompt:** Review the three concerns in this unit: error handling, logging, and parallelism. Which one has the highest priority before the Contoso web API goes to production, and why? Consider the tradeoffs: logging is observable but costs overhead; retry logic protects writes but can mask underlying provisioning problems; parallelism improves throughput but increases client CPU and memory use.
