Metrics tell you that a container returned 4,000 rate-limited responses this afternoon and can split that count by operation type. They don't identify the individual requests, logical partition key values, or query text behind the count. Diagnostic logs provide those details through the relevant log categories. In this unit, you enable the log categories worth collecting, query them with Kusto Query Language (KQL), and join a log row back to the client request that produced it.

The difference from metrics is worth stating plainly: **metrics are collected automatically and cost nothing to read. Logs are collected only after you create a diagnostic setting, and you pay for what you ingest.** That asymmetry shapes how you use them. Metrics run continuously as the standing watch, and logs go on when you have a question that metrics raised.

## Enable the logs you need

A diagnostic setting names the log categories to collect and the destinations to send them to. Azure Cosmos DB can route logs to a Log Analytics workspace, an Azure Storage account, an event hub, or a partner solution. Log Analytics is where you query them, so this unit uses that destination.

:::image type="content" source="../media/monitoring-data-paths.png" alt-text="Diagram contrasting metrics collected automatically with resource logs that require a diagnostic setting before reaching Log Analytics." lightbox="../media/monitoring-data-paths.png":::

These categories serve an account using the API for NoSQL:

| Category | Records |
| :--- | :--- |
| `DataPlaneRequests` | Every operation that creates, updates, deletes, or reads data |
| `QueryRuntimeStatistics` | Query operations, with the query text obfuscated by default |
| `PartitionKeyStatistics` | Storage consumed by the largest logical partition keys, sampled and approximate |
| `PartitionKeyRUConsumption` | Request units consumed per logical partition key, aggregated per second |
| `ControlPlaneRequests` | Account-level changes: failover policy, indexing policy, role assignments, backup policy, network rules |
| `DataPlaneRequests5M`, `DataPlaneRequests15M` | The same data-plane rows pre-aggregated into 5-minute and 15-minute buckets |

The remaining categories, `MongoRequests`, `CassandraRequests`, `GremlinRequests`, and `TableApiRequests`, apply to accounts using those APIs and produce nothing on an API for NoSQL account.

`PartitionKeyStatistics` and `PartitionKeyRUConsumption` deserve particular attention, because they're the only place the two halves of a hot partition become visible at the level of an individual key. Metrics report per physical partition. Both categories report per logical partition key, which is the granularity at which you can act.

Create the setting with the Azure CLI:

```azurecli
az monitor diagnostic-settings create `
    --name "cosmos-diagnostics" `
    --resource $accountId `
    --workspace $workspaceId `
    --export-to-resource-specific true `
    --logs '[{"category":"DataPlaneRequests","enabled":true},{"category":"PartitionKeyRUConsumption","enabled":true}]'
```

In the portal, the same setting lives under **Monitoring** > **Diagnostic settings** on the account.

### Choose the destination table shape

The `--export-to-resource-specific` argument is the one decision that affects every query you write afterward, and it can't be changed retroactively for data already ingested.

**Resource-specific** mode, the recommended option, writes each category to a dedicated table named with a `CDB` prefix: `CDBDataPlaneRequests`, `CDBPartitionKeyRUConsumption`, `CDBQueryRuntimeStatistics`, and so on. Columns are strongly typed, queries are simpler, and ingestion costs less.

**Azure diagnostics** mode, the legacy option, writes every category into a single shared `AzureDiagnostics` table alongside logs from other Azure services. Queries must filter on `ResourceProvider == "MICROSOFT.DOCUMENTDB"` and again on `Category`, and column names carry type suffixes such as `requestCharge_s` and `statusCode_s`. Several fields in that table are also case sensitive, so a query that looks correct can silently return nothing.

Choose resource-specific for anything new. Recognize the legacy shape, because plenty of existing accounts and published sample queries still use it.

## Query the logs to answer a diagnostic question

Once logs arrive, open **Logs** on the account and write KQL. The queries that follow assume resource-specific tables.

To find which operations are being rate limited, and what share of each operation's requests they represent:

```kusto
CDBDataPlaneRequests
| where TimeGenerated >= ago(24h)
| summarize throttledOperations = dcountif(ActivityId, StatusCode == 429),
            totalOperations = dcount(ActivityId),
            totalConsumedRUPerMinute = sum(RequestCharge)
    by DatabaseName, CollectionName, OperationName, RequestResourceType, bin(TimeGenerated, 1min)
| extend averageRUPerOperation = 1.0 * totalConsumedRUPerMinute / totalOperations
| extend fractionOf429s = 1.0 * throttledOperations / totalOperations
| order by fractionOf429s desc
```

The result names the operation type behind the throttling and the average cost of each call, which turns a container-level number into something specific enough to change. A result showing that 30 percent of create operations were rate limited at an average of 17 request units each points somewhere different from the same fraction on queries.

To confirm a hot partition and name the key causing it:

```kusto
CDBPartitionKeyRUConsumption
| where TimeGenerated >= ago(24h)
| where CollectionName == "product"
| where isnotempty(PartitionKey)
| summarize sum(RequestCharge) by PartitionKey, OperationName, bin(TimeGenerated, 1s)
| order by sum_RequestCharge desc
```

If one partition key value consumes thousands of request units per second while the rest consume hundreds, and the pattern holds across the window where throttling occurred, the result indicates a hot key. Check whether that skew comes from a lasting partition-key design problem or a temporary change in the workload before choosing a remedy.

To audit account-level changes, first enable the `ControlPlaneRequests` category in your diagnostic setting. Audit changes made through Azure Resource Manager, such as Azure CLI or Azure PowerShell operations. If the account permits key-based metadata writes, review the [control-plane auditing prerequisites](/azure/cosmos-db/audit-control-plane-logs#disable-key-based-metadata-write-access) before relying on this log for a complete audit.

```kusto
CDBControlPlaneRequests
| summarize count() by OperationName
```

Control-plane metrics can indicate that a resource changed, while control-plane logs provide details about the operation. When latency shifts overnight and nobody deployed anything, an indexing policy update or a throughput change in this table can help explain it.

## Correlate a log row with the request that produced it

The activity ID from unit 2 is the join key between your application's logs and the service's logs. When your application catches an exception and records the activity ID, that same value identifies the request in `CDBDataPlaneRequests`:

```kusto
CDBDataPlaneRequests
| where ActivityId == "<activity-id-from-your-application>"
```

The row reports the status code the service returned, the request charge, the duration, the operation type, and the client's IP address. Comparing the service's duration against the elapsed time your client measured splits the latency between the two, which is the same comparison unit 3 made with metrics, now for one specific failed request rather than an aggregate.

Query text is obfuscated in `CDBQueryRuntimeStatistics` by default, so a slow query appears without its predicate. The **Diagnostics full-text query** feature, enabled under **Settings** > **Features** on the account, removes that obfuscation. Turn it on only while you need it. It puts your users' query parameters, which frequently contain personal data, into a log store, and it increases ingestion volume.

## Keep the cost bounded

Log Analytics bills on the volume you ingest, and `DataPlaneRequests` produces one row per request. On a busy account, that volume is substantial, and it accrues whether or not anyone queries it.

Treat diagnostic settings as an investigative tool rather than a permanent configuration:

- Turn on the categories a specific question needs, not every category available.
- Prefer the aggregated `DataPlaneRequests5M` or `DataPlaneRequests15M` categories when you want a trend rather than individual requests.
- Turn off a setting once the investigation closes.
- Delete a diagnostic setting before you delete, rename, or move the account it targets. A setting left behind can attach itself to a resource recreated with the same name and quietly resume ingesting.

Diagnostic logs connect account-level symptoms to specific requests and partition keys. You can now combine those records with metrics and client diagnostics while keeping log collection focused on the investigation.
