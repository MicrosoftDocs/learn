In this module, you learned how to analyze application telemetry using Azure Monitor logs and metrics. You started by writing KQL queries that filter, aggregate, and visualize data from the Application Insights tables, using operators like `where`, `summarize`, `bin()`, and `render` to transform raw telemetry into actionable insights. You explored log data to identify error patterns, correlate failures across services using `operation_Id`, and measure dependency latency with percentile calculations. You built Azure dashboards by pinning metrics charts and log query results to create shared operational views that teams use for day-to-day monitoring. You also created Azure Monitor Workbooks with parameters and conditional visibility to enable interactive investigation and drill-down analysis. Finally, you configured alert rules using KQL queries to detect failure spikes and performance degradation, set up action groups for notifications, and explored smart detection for automatic anomaly identification.

## Additional resources

- [KQL overview](/azure/azure-monitor/logs/log-query-overview)
- [Azure Monitor alerts overview](/azure/azure-monitor/alerts/alerts-overview)
- [Azure Monitor Workbooks overview](/azure/azure-monitor/visualize/workbooks-overview)
- [Application Insights data model](/azure/azure-monitor/app/data-model-complete)
