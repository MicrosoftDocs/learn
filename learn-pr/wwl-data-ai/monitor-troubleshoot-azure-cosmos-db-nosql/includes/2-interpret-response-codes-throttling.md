The Contoso checkout service logs a handful of failed writes every hour. Before anyone opens the Azure portal, the application already holds the cheapest diagnostic signal available: the status code on each response and the headers that come with it. In this unit, you read those codes, decide which ones your application retries, distinguish the four causes of a 429 response, and capture the diagnostics the SDK collects on every request.

## Read the status code before you change anything

Every response from Azure Cosmos DB carries an HTTP status code. A client timeout or network failure can occur without a response from the service. The code, when available, helps determine whether a retry is worth attempting. Some codes report a fault in the request itself and never succeed on retry. Some report a transient condition that clears on its own. A few sit in between, where retrying is safe but the underlying cause still deserves attention.

| Code | Meaning | Does the SDK retry? | Should your application add a retry? |
| :--- | :--- | :--- | :--- |
| 400 | Bad request. The JSON, the query syntax, or a required header is invalid | No | No |
| 401 | The authorization header is invalid for the requested resource | No | No |
| 403 | Forbidden. The token expired, a firewall rule blocks the caller, or a logical partition reached its storage limit | No | Optional |
| 404 | The item, container, or database doesn't exist | No | No |
| 408 | The operation didn't finish inside the allotted time | Yes | Yes |
| 409 | Conflict. The `id` and partition key are already taken, or a unique key constraint is violated | No | No |
| 410 | Gone. A transient condition that shouldn't breach the service level agreement | Yes | Yes |
| 412 | Precondition failed. The supplied ETag differs from the version on the server | No | No |
| 413 | The item exceeds the 2-MB limit | No | No |
| 423 | Locked. Another throughput scale operation is already running | No | No |
| 424 | Failed dependency. Another operation in the same transactional batch failed | No | No |
| 429 | Too many requests. The request is rate limited | Yes | Yes |
| 449 | Retry with. A transient conflict on a write, safe to retry | Yes in .NET; no in Python | Yes |
| 500 | An unexpected service error. Contact support if it persists | No in .NET; reads in Python | Depends on the operation and retry policy |
| 503 | Service unavailable | Yes | Yes |

A 403 deserves a second look, because the same code covers several unrelated conditions: an expired token, a firewall or network rule that excludes the caller, and a logical partition that reached its 20-GB limit. The **substatus code** and error message help separate them. A full logical partition returns substatus 1014 and the message Partition key reached maximum size. For a network-blocked request, the error message identifies whether the request reached Azure Cosmos DB through the public internet, a virtual-network service endpoint, or a private endpoint. Use that information to determine whether the client used the expected network path and whether the account configuration allows that path. Each SDK exposes the substatus code alongside the status code.

> [!TIP]
> Failed operations still consume request units, the currency provisioned throughput is measured in and expressed as request units per second (RU/s). A workload that generates a steady stream of 412 or 449 responses pays for every one of them, so a rise in those codes shows up as unexplained throughput consumption before it shows up as an error rate.

## Let the SDK retry what it should

Each SDK already retries the codes marked *Yes* in the previous table, so most transient failures never reach your application at all. On a 429, the SDK reads the `x-ms-retry-after-ms` response header, waits the interval the service asks for, and reissues the request. It retries up to **nine** times by default, giving a maximum of 10 attempts, and gives up after **30 seconds** of cumulative waiting.

That default explains a question that opens almost every investigation: why do Azure Monitor metrics show hundreds of 429 responses the application never logged? The service counts every rate-limited response, and the application sees only the ones that exhaust the retries.

Both defaults are configurable when your own service level objective is tighter than the SDK's patience, or when a short burst is worth absorbing inside the client.

::: zone pivot="csharp"

```csharp
CosmosClient client = new(
    accountEndpoint: endpoint,
    tokenCredential: new DefaultAzureCredential(),
    clientOptions: new CosmosClientOptions
    {
        MaxRetryAttemptsOnRateLimitedRequests = 5,
        MaxRetryWaitTimeOnRateLimitedRequests = TimeSpan.FromSeconds(10)
    });
```

Setting `MaxRetryAttemptsOnRateLimitedRequests` to `0` turns off the automatic retry entirely and surfaces every 429 to your code.

::: zone-end

::: zone pivot="python"

```python
client = CosmosClient(
    endpoint,
    credential=DefaultAzureCredential(),
    retry_throttle_total=5,
    retry_throttle_backoff_max=10,
)
```

The `retry_throttle_total` and `retry_throttle_backoff_max` keywords apply only to rate limiting. The broader `retry_total` and `retry_backoff_max` keywords also cover connection-level retries, so use the throttle-specific pair when you mean to change 429 behavior alone.

> [!NOTE]
> Passing `retry_throttle_total=0` doesn't disable the retry. The SDK treats zero as *unset* and falls back to the default of nine. To make rate limiting visible to your own code, pass `1` instead.

::: zone-end

There's one asymmetry worth holding onto. When a response never arrives, a client can't always tell whether the service applied a write. Read retries are safe, but blindly retrying a create can produce a 409 for an item that already exists. Don't assume that all write failures have the same retry behavior: the Python SDK retries 503 responses, while write retries for ambiguous timeouts are opt-in through `retry_write`. Enable those retries only when your application can tolerate or detect duplicate operations. Handling ambiguous write outcomes belongs to your application.

## Diagnose the four causes of a 429

A 429 means the service rate limited the request, but four different conditions produce that code, and only one responds to more throughput. Reaching for the throughput slider before identifying which condition applies is the most common mistake in this area.

:::image type="content" source="../media/throttling-diagnosis-path.png" alt-text="Diagram routing a 429 response to one of four causes, each with the evidence that confirms it and the remediation it calls for." lightbox="../media/throttling-diagnosis-path.png":::

| Cause | Error message | Where to confirm it | Does more RU/s help? |
| :--- | :--- | :--- | :--- |
| Request rate is large | *Request rate is large. More Request Units might be needed* | **Insights** > **Requests** > **Total Requests by Status Code** | Yes; temporary relief for a hot physical partition, not a fix for skew |
| Metadata rate limiting | *The request didn't complete due to a high rate of metadata requests* | **Insights** > **System** > **Metadata Requests By Status Code** | No |
| Transient service error | *The request didn't complete due to a transient service error* | Look for 503 responses in the same window | No |
| Transaction contention | `TXN_WAIT_FOR_TRANSACTION_END` | Concurrent batches or stored procedures on one logical partition key | No |

**Request rate is large** is the common case, and it splits again once you confirm it. If every partition key range sits near capacity, the container genuinely needs more throughput. If one range pins at 100 percent while the others idle, a hot partition causes the throttling, and adding throughput mostly buys capacity for partitions that don't need it. Unit 3 covers how to distinguish a container that needs more throughput from one with a hot partition.

**Metadata rate limiting** comes from a high volume of operations that list, create, modify, or delete databases and containers, or that read the current provisioned throughput. Those operations draw on a system-reserved allowance rather than your provisioned throughput, so raising RU/s changes nothing. The fixes are structural: hold a single client instance for the lifetime of the process, and cache database and container names instead of looking them up.

**Transaction contention** raises `TXN_WAIT_FOR_TRANSACTION_END`, and it's the cause most often misread as a capacity problem. Azure Cosmos DB processes one transactional operation at a time for a given logical partition key, so a new transactional batch or stored procedure can't start while another is still running against that key. Reduce the scope and duration of the transaction, add backoff, or redistribute writes across more logical partitions.

## Capture what the client already knows

The .NET SDK records request diagnostics, including contacted regions, stage timings, and retries. That record is available on successful responses and on exceptions. The Python SDK exposes response headers and supports opt-in diagnostic logging. These signals help establish whether latency accumulates in the service or on the client.

::: zone pivot="csharp"

```csharp
try
{
    ItemResponse<Product> response = await container.ReadItemAsync<Product>(id, new PartitionKey(categoryId));

    if (response.Diagnostics.GetClientElapsedTime() > TimeSpan.FromMilliseconds(100))
    {
        Console.WriteLine(response.Diagnostics.ToString());
    }
}
catch (CosmosException ex)
{
    Console.WriteLine($"Status: {ex.StatusCode} SubStatus: {ex.SubStatusCode}");
    Console.WriteLine($"Activity ID: {ex.ActivityId} Charge: {ex.RequestCharge} RU");
    Console.WriteLine($"Retry after: {ex.RetryAfter}");
    Console.WriteLine(ex.Diagnostics.ToString());
}
```

`GetClientElapsedTime` gives the time the operation spent inside the SDK, retries included, which is the number to compare against a server-side latency metric. Log the diagnostics string, but never parse it: its format changes between SDK releases by design.

::: zone-end

::: zone pivot="python"

```python
try:
    item = container.read_item(item=item_id, partition_key=category_id)
    headers = item.get_response_headers()
    print(f"Charge: {headers['x-ms-request-charge']} RU")
    print(f"Activity ID: {headers['x-ms-activity-id']}")
except exceptions.CosmosHttpResponseError as ex:
    print(f"Status: {ex.status_code} SubStatus: {ex.sub_status}")
    print(f"Message: {ex.http_error_message}")
    print(f"Retry after: {ex.headers.get('x-ms-retry-after-ms')} ms")
```

`CosmosHttpResponseError` carries `status_code`, `sub_status`, and the full response `headers`, so the request charge, the activity ID, and the retry interval are all available on the failure path and the success path.

::: zone-end

The **activity ID** matters more than it first appears. The service assigns it to each operation, and it appears both in the client's view of the request and in the diagnostic log row the service writes for it. When metrics show a problem and you need the specific request behind it, the activity ID joins the two halves. Unit 5 uses it for exactly that purpose.

Start an investigation with the response code, the SDK's retry behavior, and the client diagnostics. The next unit adds latency and partition metrics so you can distinguish capacity pressure from uneven request distribution.
