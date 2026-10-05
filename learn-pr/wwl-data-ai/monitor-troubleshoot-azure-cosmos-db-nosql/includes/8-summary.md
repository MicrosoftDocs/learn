Monitoring Azure Cosmos DB is a matter of knowing which signal answers which question. Response codes tell you what failed, metrics tell you what's degrading, alerts tell you when to look, and diagnostic logs name the request behind it.

## What you learned

- Every response carries a status code, a failure can also carry a substatus code, and only some codes are worth retrying. The software development kits (SDKs) retry a rate-limited request nine times by default, which is why the service counts 429 responses your application never sees.
- A 429 has four distinct causes, and only one responds to more throughput. Metadata rate limiting, transient service errors, and `TXN_WAIT_FOR_TRANSACTION_END` each call for a different fix.
- Server-side latency, reported separately for direct and gateway modes, isolates the service's contribution, and normalized request unit consumption split by partition key range separates a container at capacity from one with a hot partition.
- An alert rule combines a scope, a condition, and an action group, and its threshold has to be sized against expected traffic. A rule that fires during normal operation gets muted.
- Diagnostic logs are opt-in and billed by volume. They add individual request records, logical partition key values, and query details to the aggregate operation information available in metrics.


## Learn more

- [Monitor Azure Cosmos DB](/azure/cosmos-db/monitor)
- [Azure Cosmos DB monitoring data reference](/azure/cosmos-db/monitor-reference)
- [Diagnose and troubleshoot request rate too large exceptions](/azure/cosmos-db/troubleshoot-request-rate-too-large)
- [Design resilient applications with Azure Cosmos DB SDKs](/azure/cosmos-db/conceptual-resilient-sdk-applications)
- [Monitor normalized request units](/azure/cosmos-db/monitor-normalized-request-units)
- [Monitor server-side latency](/azure/cosmos-db/monitor-server-side-latency)
- [Create alerts by using Azure Monitor](/azure/cosmos-db/create-alerts)
- [Monitor data by using diagnostic settings](/azure/cosmos-db/monitor-resource-logs)
