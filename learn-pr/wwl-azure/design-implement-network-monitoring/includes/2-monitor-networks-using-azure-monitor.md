
## What is Azure Monitor?

[Azure Monitor](/azure/azure-monitor/fundamentals/overview) is a comprehensive monitoring solution for collecting, analyzing, and responding to monitoring data from your cloud and on-premises environments. You can use Azure Monitor to maximize the availability and performance of your applications and services. Azure Monitor helps you understand how your applications are performing and allows you to manually and programmatically respond to system events.

Here are a few usage cases for Azure Monitor.

 -  Use Application Insights to detect and diagnose issues across applications.
 -  Correlate infrastructure issues with VM insights and Container insights.
 -  Use Log Analytics to explore troubleshooting and diagnostics your monitoring data.
 -  Support operations at scale with smart alerts and automated actions.
 -  Create visualizations with Azure dashboards and workbooks.
 -  Collect data from monitored resources using Azure Monitor Metrics.

## Azure Monitor (video)

This video summarizes Azure Monitor capabilities and components. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=0dcc1e17-1904-4c1c-a63e-07e2168d51b3 ]


## Azure Monitor components

The next diagram offers a high-level view of Azure Monitor. At the center of the diagram are the two fundamental types of data stores: metrics and logs, In the left pane are the monitoring sources that populate these data stores. In the right pane are the different actions that Azure Monitor performs with this collected data. Actions include analysis, alerting, and streaming to external systems.

:::image type="content" source="../media/azure-monitor-overview-15b1f34a.png" alt-text="Screenshot of a high-level view of Azure Monitor. ":::

1. **Data sources** are the types of resources being monitored. Data sources can include: app/workloads, infrastructure, Azure platform, and even custom sources.

1. **The data platform** stores the collected data. Azure Monitor's core data platform has stores for metrics, logs, traces, and changes. Metrics  are numerical values that describe an aspect of a system at a particular point in time. Logs are recorded system events. 

1. **Insights** are large, scalable, curated visualizations. Insights are available for applications, containers, networks, and virtual machines. 

1. **Visualizations** such as charts and tables are effective tools for summarizing monitoring data and presenting it to different audiences. Visualizations can include: dashboards, workbooks, Power BI, and Grafana. Grafana is an open platform that excels in operational dashboards. 

1. **Analyze** monitoring data includes metric explorer and log analytics.

1. **Respond** proactively addresses critical events, before they become an issue. For example, the response could be a text or email to an administrator, or an automated process that attempts to correct an error condition.

1. **Integrate** allows other systems or custom solutions to use your monitoring data. Integrate can include: Event Hubs, Azure storage, Logic Apps, Azure Functions, and APIs. 

> [!TIP]
> Learn more about Azure Monitor in the [Introduction to Azure Monitor](/training/modules/intro-to-azure-monitor/) training module.