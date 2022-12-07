To accurately represent a health model, various datasets must be gathered from the system. These datasets include logs and performance metrics from application components and underlying Azure resources. It's important to correlate data across these datasets to be able to build the layered representation of health.

## Instrumenting code and infrastructure

A *unified data sink* is required to ensure all operational data is stored and made available for a single location where all data measurement is collected. Azure provides several data monitoring technologies under the umbrella of [Azure Monitor](/azure-monitor/overview#overview). Azure Monitor Log Analytics serves as the core Azure-native unified data sink to store and analyze operational data:

- Use Application Insights as a consistent Application Performance Monitoring (APM) tool across all application components to collect application logs, metrics, and traces.

- Deploy Application Insights in a workspace-based configuration to ensure each regional Log Analytics workspace contains logs and metrics from both application components and the underlying Azure resources. 

- Use a dedicated Log Analytics workspace and Application Insights instance for each stamp and globally shared resource (Azure Cosmos DB, for example), as per the [mission-critical guidance](/azure/architecture/framework/mission-critical/mission-critical-health-modeling#unified-data-sink-for-correlated-analysis). Doing so eliminates a single point of failure, in case a region is down. All stamps are short-lived and continuously replaced with each new release. The per-stamp Log Analytics workspaces are deployed as a global resource in a separate monitoring resource group as the stamp Log Analytics resources. These resources don't share the lifecycle of a stamp.

- Configure every service used in the architecture to send data collection to the same Log Analytics workspace, to make analysis and health calculations easier.

![Diagram showing an example of application health data collection.](../media/mission-critical-health-data-collection.png)

When you use Application Insights with one of the supported SDKs, the key benefit is transparent end-to-end tracing.

Contoso Shoes uses Azure Functions on .NET 6 for their backend services, so they can make use of the native integration.

Because the backend applications already exist, the team will create only a new Application Insights resource in Azure and configure the `APPLICATIONINSIGHTS_CONNECTION_STRING` setting on both Function Apps.

The Azure Functions runtime registers the Application Insights logging provider automatically. For additional custom logs, use ILogger.

## Health monitoring queries

Log Analytics and Application Insights, and Azure Data Explorer all use [Kusto Query Language (KQL)](/azure/data-explorer/kusto/query) for their queries. With KQL, you can build queries and use functions to fetch metrics and calculate health scores.

For individual services that calculate the health status, see the following sample queries:

- [Catalog API](https://github.com/Azure/Mission-Critical-Online/blob/feature/reactflowtest/src/infra/monitoring/queries/stamp/CatalogServiceHealthStatus.kql)

- [Azure Event Hubs](https://github.com/Azure/Mission-Critical-Online/blob/feature/reactflowtest/src/infra/monitoring/queries/stamp/EventHubHealthStatus.kql)

- [Azure Key Vault](https://github.com/Azure/Mission-Critical-Online/blob/feature/reactflowtest/src/infra/monitoring/queries/stamp/KeyvaultHealthStatus.kql)

## Set up query-based alerts

Alerts are an important part of the overall operations strategy. Proactive monitoring such as the use of dashboards should be used with alerts that raise immediate attention to issues.

These alerts form an extension of the health model, by alerting the operator to a change in health state, either to a degraded/yellow state or to an unhealthy/red state. By setting the alert to the root node of the health model, the operator is immediately aware of any business-level effect to the state of the solution. The operator can then direct their attention to the health model visualization for troubleshooting.

Azure Monitor provides an extensive alerting framework to detect, categorize, and respond to operational signals through Action Groups. Use Azure Monitor alerts to drive automated actions in response to current or potential deviations from a healthy application state.

## Use dashboards for visualization

Visually representing the health model with critical operational data is essential to achieve effective operations and maximize reliability. Use dashboards to provide near-real time insights into application health for DevOps teams, facilitating the swift diagnosis of deviations from steady state. A robust dashboard is essential to diagnose issues that have already occurred, and supports operational teams in detecting and responding to issues as they happen.

Microsoft provides several data visualization technologies, including Azure Dashboards, Power BI, and Azure Managed Grafana. Azure Dashboards provides a tightly integrated out-of-the-box visualization solution for operational data within Azure Monitor. However, if you can't use Azure Dashboards to accurately represent the health model, then it's recommended to consider Grafana as an alternative visualization solution. Grafana provides market-leading capabilities and an extensive open-source plugin ecosystem.
