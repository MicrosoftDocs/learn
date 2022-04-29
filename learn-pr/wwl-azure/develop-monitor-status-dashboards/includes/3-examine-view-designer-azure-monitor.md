[View Designer in Azure Monitor](/azure/log-analytics/log-analytics-view-designer) allows you to create custom visualizations with log data. They're used by [monitoring solutions](/azure/azure-monitor/insights/solutions) to present the data they collect.

:::image type="content" source="../media/view-designer-azure-monitor-60510459.png" alt-text="View Designer in Azure Monitor":::


## Advantages

 -  Rich visualizations for log data.
 -  Export and import views to transfer them to other resource groups and subscriptions.
 -  Integrates into Log Analytic management model with workspaces and monitoring solutions.
 -  [Filters](/azure/azure-monitor/platform/view-designer-filters) for custom parameters.
 -  Interactive supports multi-level drill-in (a view that drills into another view).

## Limitations

 -  Supports logs but not metrics.
 -  No personal views. Available to all users with access to the workspace.
 -  No automatic refresh.
 -  Limited layout options.
 -  No support for querying across multiple workspaces or Application Insights applications.
 -  Queries are limited in response size to 8 MB and query execution time of 110 seconds.
