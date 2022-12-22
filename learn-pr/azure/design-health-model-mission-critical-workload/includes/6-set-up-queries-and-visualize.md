To accurately represent a health model, you must gather various datasets from the system. The datasets include logs and performance metrics from application components and underlying Azure resources. It's important to correlate data between the datasets to build a layered representation of health for the system.

## Instrumenting code and infrastructure

A *unified data sink* is required to ensure that all operational data is stored and available in a single location where all telemetry is collected. Azure provides several data monitoring technologies in [Azure Monitor](/azure/azure-monitor/overview#overview).

Azure Monitor Log Analytics serves as the core Azure-native unified data sink to store and analyze operational data:

- Use Application Insights as a consistent Application Performance Monitoring (APM) tool across all application components to collect application logs, metrics, and traces.

- Deploy Application Insights in a workspace-based configuration to ensure that each regional Log Analytics workspace contains logs and metrics from application components and the underlying Azure resources.

- Use a dedicated Log Analytics workspace and an Application Insights instance for each stamp and globally shared resource (Azure Cosmos DB, for example) per [mission-critical guidance](/azure/architecture/framework/mission-critical/mission-critical-health-modeling#unified-data-sink-for-correlated-analysis). By using this structure, you eliminate a single point of failure if a region is down. All stamps are short-lived and are continuously replaced with each new release. The per-stamp Log Analytics workspaces are deployed as a global resource in a separate monitoring resource group as the stamp Log Analytics resources. These resources don't share the lifecycle of a stamp.

- Set up every service that's used in the architecture to send data collection to the same Log Analytics workspace, to make analysis and health calculations easier.

:::image type="content" source="../media/mission-critical-health-data-collection.png" border="false" alt-text="Diagram that shows an example of application health data collection.":::

We recommend that you use Application Insights with one of the supported SDKs. The key benefit is transparent, end-to-end tracing so that you can track requests from the client through all layers of the system.

For example, when an employee creates a comment in their web browser, you can find this operation in Application Insights and see that the request went through the Catalog API to Azure Event Hubs. From there, the comment was picked up by the background processor and stored in Azure Cosmos DB.

Contoso Shoes uses Azure Functions on Microsoft .NET 6 for its back-end services for native integration. Because the back-end applications already exist, Contoso Shoes creates only a new Application Insights resource in Azure and configures the `APPLICATIONINSIGHTS_CONNECTION_STRING` setting on both function apps. The Azure Functions runtime registers the Application Insights logging provider automatically, so telemetry appears in Azure without additional effort. For more customized logging, you can use the ILogger interface.

## Health monitoring queries

Log Analytics, Application Insights, and Azure Data Explorer all use [Kusto Query Language (KQL)](/azure/data-explorer/kusto/query) for their queries. You can use KQL to build queries and use functions to fetch metrics and calculate health scores.

For individual services that calculate the health status, see the following sample queries.

### Catalog API

The following sample demonstrates a [Catalog API query](https://github.com/Azure/Mission-Critical-Online/blob/feature/reactflowtest/src/infra/monitoring/queries/stamp/CatalogServiceHealthStatus.kql):

```kusto

let _maxAge = 2d; // Include data only from the last two days
let _timespanStart = ago(_maxAge); // Start time for the time span
let _timespanEnd = now(-2m); // Account for ingestion lag by stripping the last 2m
    // For time frame, compare the averages to the following threshold values:
let Thresholds=datatable(MetricName: string, YellowThreshold: double, RedThreshold: double) [ 
    "failureCount", 10, 50, // Failed requests, anything non-200, allow a few more than 0 for user-caused errors like 404s
    "avgProcessingTime", 150, 500 // Average duration of the request, in ms
    ];
// Calculate average processing time for each request
let avgProcessingTime = AppRequests
| where AppRoleName startswith "CatalogService"
| where OperationName != "GET /health/liveness" // Liveness requests don't do any processing, including them would skew the results
| make-series Value = avg(DurationMs) default=0 on TimeGenerated from _timespanStart to _timespanEnd step 1m
| mv-expand TimeGenerated, Value
| extend TimeGenerated = todatetime(TimeGenerated), Value=toreal(Value), MetricName= 'avgProcessingTime';
// Calculate failed requests
let failureCount = AppRequests
| where AppRoleName startswith "CatalogService" // Liveness requests don't do any processing, including them would skew the results
| where OperationName != "GET /health/liveness"
| make-series Value=countif(Success != true) default=0 on TimeGenerated from _timespanStart to _timespanEnd step 1m
| mv-expand TimeGenerated, Value
| extend TimeGenerated = todatetime(TimeGenerated), Value=toreal(Value), MetricName= 'failureCount';
// Union all together and join with the thresholds
avgProcessingTime
| union failureCount
| lookup kind = inner Thresholds on MetricName
| extend IsYellow = iff(todouble(Value) > YellowThreshold and todouble(Value) < RedThreshold, 1, 0)
| extend IsRed = iff(todouble(Value) > RedThreshold, 1, 0)
| project-reorder TimeGenerated, MetricName, Value, IsYellow, IsRed, YellowThreshold, RedThreshold
| extend ComponentName="CatalogService"
```

### Azure Key Vault

The following sample demonstrates an [Azure Key Vault query](https://github.com/Azure/Mission-Critical-Online/blob/feature/reactflowtest/src/infra/monitoring/queries/stamp/KeyvaultHealthStatus.kql):

```kusto
let _maxAge = 2d; // Include data only from the last two days
let _timespanStart = ago(_maxAge); // Start time for the time span
let _timespanEnd = now(-2m); // Account for ingestion lag by stripping the last 2m
    // For time frame, compare the averages to the following threshold values:
let Thresholds = datatable(MetricName: string, YellowThreshold: double, RedThreshold: double) [
    "failureCount", 3, 10 // Failure count on key vault requests
    ];
let failureStats = AzureDiagnostics
| where TimeGenerated > _timespanStart
| where ResourceProvider == "MICROSOFT.KEYVAULT"
    // Ignore authentication operations that have a 401. This is normal when using Key Vault SDK. First an unauthenticated request is made, then the response is used for authentication:
| where Category=="AuditEvent" and not (OperationName == "Authentication" and httpStatusCode_d == 401)
| where OperationName in ('SecretGet','SecretList','VaultGet') or '*' in ('SecretGet','SecretList','VaultGet')
    // Exclude Not Found responses because these happen regularly during 'Terraform plan' operations, when Terraform checks for the existence of secrets:
| where ResultSignature != "Not Found"
// Create ResultStatus with all the 'success' results bucketed as 'Success'
// Certain operations like StorageAccountAutoSyncKey have no ResultSignature; for now, also set to 'Success'
| extend ResultStatus = case ( ResultSignature == "", "Success",
                               ResultSignature == "OK", "Success",
                               ResultSignature == "Accepted", "Success",
                               ResultSignature);
failureStats
| make-series Value=countif(ResultStatus != "Success") default=0 on TimeGenerated from _timespanStart to _timespanEnd step 1m
| mv-expand TimeGenerated, Value
| extend TimeGenerated = todatetime(TimeGenerated), Value=toreal(Value), MetricName="failureCount", ComponentName="Keyvault"
| lookup kind = inner Thresholds on MetricName
| extend IsYellow = iff(todouble(Value) > YellowThreshold and todouble(Value) < RedThreshold, 1, 0)
| extend IsRed = iff(todouble(Value) > RedThreshold, 1, 0)
```

### Catalog Service health score

Eventually, you can tie together various health *status* queries to calculate a health *score* of a component. The following sample query shows how to calculate a [Catalog Service health score](https://github.com/Azure/Mission-Critical-Online/blob/feature/reactflowtest/src/infra/monitoring/queries/stamp/CatalogServiceHealthScore.kql):

```kusto
CatalogServiceHealthStatus()
| union AksClusterHealthStatus()
| union KeyvaultHealthStatus()
| union EventHubHealthStatus()
| where TimeGenerated < ago(2m)
| summarize YellowScore = max(IsYellow), RedScore = max(IsRed) by bin(TimeGenerated, 2m)
| extend HealthScore = 1 - (YellowScore * 0.25) - (RedScore * 0.5)
| extend ComponentName = "CatalogService", Dependencies="AKSCluster,Keyvault,EventHub" // These values are added to build the dependency visualization
| order by TimeGenerated desc
```

> [!TIP]
>
> See more [query examples](https://github.com/Azure/Mission-Critical-Online/tree/feature/reactflowtest/src/infra/monitoring/queries) in the [Azure Mission-Critical Online](https://github.com/Azure/Mission-Critical-Online/tree/feature/reactflowtest) GitHub repository.

## Set up query-based alerts

Alerts are an important part of your overall operations strategy. Implement proactive monitoring with the use of dashboards and alerts to raise immediate attention to issues that reflect or affect health state. Alerts extend the health model, so you quickly become aware of a change in health state, either to a degraded (yellow) state or to an unhealthy (red) state. Set alerts at the root node of the health model to immediately become aware of any business-level change in the health state of the solution. Then, you can look at health model visualizations to get more information and to troubleshoot.

Azure Monitor provides an extensive alerting framework to detect, categorize, and respond to operational signals through action groups. Use Azure Monitor alerts to drive automated actions in response to current or potential deviations from a healthy application state.

## Use dashboards for visualization

It's important to visualize your health model and the data that it continuously collects. You can see the dependency tree and quickly understand the effect of a component outage on the whole system. The ultimate goal of a health model is to facilitate swift diagnosis by providing informed view into deviations from steady state.

A common way to visualize system health information is to combine a layered health model view with telemetry drill-down capabilities in a dashboard.

:::image type="content" source="../media/health-dashboard-example.png" alt-text="Screenshot that shows an example health model dashboard of a layered model above drill-down data tables.":::

Microsoft provides several data visualization technologies, including Azure Dashboards, Power BI, and Azure Managed Grafana. Azure Dashboards provides a tightly integrated, out-of-the-box visualization solution for operational data in Azure Monitor. However, if you can't use Azure Dashboards to accurately represent the health model, consider using Azure Managed Grafana as an alternative visualization solution. Azure Managed Grafana provides market-leading capabilities and an extensive open-source add-in ecosystem.
