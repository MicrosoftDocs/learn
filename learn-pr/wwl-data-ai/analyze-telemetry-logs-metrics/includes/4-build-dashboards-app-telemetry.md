Writing KQL queries is essential for investigating specific problems, but teams also need a persistent visual summary that shows the health of their application at a glance. Azure dashboards provide a shared surface where developers and operations teams pin metrics charts, log query results, and other tiles into a single view that answers the question "is the system healthy right now?" This unit covers how to build dashboards that combine Application Insights data into an operational monitoring view for your AI solution.

## Understand Azure dashboards for monitoring

Azure dashboards are customizable visual surfaces in the Azure portal that combine tiles from multiple Azure resources into a single view. Each tile displays a specific piece of information: a metrics chart, a log query result, a Markdown text block, or a resource from the Tile Gallery. Teams use dashboards for operational awareness during day-to-day monitoring, keeping them open on wall-mounted screens or checking them during stand-up meetings to confirm pipeline health.

Dashboards differ from workbooks in their design intent and interaction model. Dashboards are optimized for at-a-glance visibility with tiles that refresh on a schedule and display the latest data automatically. The layouts are relatively static. You arrange tiles once, and the dashboard continues to display updated data without manual intervention. Workbooks, which the next unit covers, are designed for interactive exploration where users adjust parameters and drill into data dynamically. Choose dashboards for ongoing operational monitoring and workbooks for incident investigation and ad-hoc analysis.

A single dashboard can combine resources from multiple subscriptions and resource groups. This capability means you can build a dashboard that shows metrics from your Application Insights resource alongside storage account throughput, Azure Kubernetes Service node health, and any other Azure resource data that's relevant to your application's overall health.

## Pin metrics to a dashboard

Application Insights collects standard metrics that provide immediate insight into application behavior without requiring any KQL queries. You can create metrics charts and pin them directly to a dashboard, building a monitoring view from precollected data.

To create a metrics chart, you open your Application Insights resource and navigate to the **Metrics** pane under **Monitoring**. You select a metric from the dropdown, such as server response time, failed requests, or dependency duration. You can apply filters to narrow the data, for example filtering to a specific `cloud_RoleName` to see metrics for just one service. You can also use splitting to break the chart into separate lines by a dimension like operation name or result code. Once the chart looks right, you select the pin icon to add it to an existing dashboard or create a new one.

Common metrics for AI application dashboards include:

- **Server response time:** Shows average and percentile response times for incoming requests, indicating overall application responsiveness.
- **Failed requests:** Tracks the rate and count of requests that return error status codes, highlighting reliability problems.
- **Dependency failures:** Monitors failed outgoing calls to databases, APIs, and model endpoints.
- **Server request rate:** Displays throughput in requests per second, showing traffic patterns and capacity utilization.
- **Availability:** Shows the success rate of configured availability tests, confirming that the application is reachable.

When configuring metrics charts, the aggregation type determines what value the chart displays. Average aggregation shows typical behavior and is appropriate for response times and latency. Sum aggregation works well for counting total events over a time period. Max aggregation reveals worst-case values, which is useful for identifying latency spikes that affect user experience even if they occur infrequently.

## Pin log query results to a dashboard

Metrics charts are limited to the precollected standard metrics and custom metrics your application emits. Log queries provide the flexibility to calculate values, join across tables, and create visualizations that metrics alone can't produce. You can pin KQL query results to a dashboard for richer analysis tiles.

To pin a log query result, you navigate to **Logs** under **Monitoring** in your Application Insights resource, write and run your query, switch to chart view if you want a visual tile, and select the pin icon. The chart type you select at the time of pinning is preserved on the dashboard tile. The following query provides a useful dashboard tile that shows failed requests grouped by service:

```kusto
requests
| where timestamp > ago(24h)
| where success == false
| summarize failedCount = count() by cloud_RoleName
| render barchart
```

The bar chart immediately reveals which services contribute the most failures, making it easy to spot a service that needs attention. For latency monitoring, the following query creates a tile that displays request latency percentiles over time:

```kusto
requests
| where timestamp > ago(24h)
| summarize p50 = percentile(duration, 50),
    p95 = percentile(duration, 95),
    p99 = percentile(duration, 99)
    by bin(timestamp, 1h)
| render timechart
```

This time chart displays three lines representing the 50th, 95th, and 99th percentile response times. A growing gap between the p50 and p95 lines indicates that while most requests remain fast, a significant portion of requests experiences degradation. This pattern is common in AI pipelines when a specific document type triggers more expensive processing.

Dashboard tiles refresh on a schedule and display the query results as of the last refresh. Tiles aren't real-time. The refresh frequency depends on the dashboard configuration, with the default being periodic automatic refresh. For real-time visibility during active incidents, consider using Live Metrics in Application Insights or workbooks with shorter time ranges.

## Organize and share dashboards

A dashboard with tiles in random positions is harder to read than one organized with clear groupings. Effective dashboard design requires deliberate arrangement that helps team members find the information they need quickly.

You can arrange tiles by selecting **Edit** mode at the top of the dashboard. In edit mode, you can drag tiles to new positions, resize them to show more or less detail, and rename them with descriptive titles. Grouping related tiles together helps teams scan the dashboard efficiently. For example, placing all latency-related tiles in one row and all error-related tiles in another row creates a logical reading flow.

To share a dashboard with team members, you select **Share** and then **Publish**. Publishing makes the dashboard available to other users in your organization. Access control uses Azure role-based access control (RBAC), so team members need read permissions on both the dashboard resource and the underlying data sources. If a team member has access to the dashboard but not to the Application Insights resource, the tiles that query that resource display an access error.

When designing dashboards for AI application monitoring, consider these best practices:

- **Separate concerns into different dashboards:** Create one dashboard for pipeline health (latency, throughput, error rates) and another for business metrics (documents processed, classifications made, violations detected). Combining too many concerns into a single dashboard makes it harder to scan.
- **Limit tile count:** Keep dashboards focused on 5 to 10 tiles that answer the most important operational questions. Too many tiles create visual clutter and dilute attention.
- **Use descriptive tile titles:** Rename each tile to describe what it shows ("Classification Service P95 Latency" rather than "Query 3"). Team members who didn't create the dashboard need clear titles to understand each tile's purpose.
- **Include a Markdown tile for context:** Add a Markdown tile at the top of the dashboard that describes the application being monitored, links to runbooks, and lists on-call contacts.

## Additional resources

- [Create a Log Analytics dashboard](/azure/azure-monitor/visualize/tutorial-logs-dashboards)
- [Application Insights overview dashboard](/azure/azure-monitor/app/overview-dashboard)
