## Insights, visualizations, and reports

[Please base this section on the Insights and Visualize sections of the Azure Monitor overview article]

:::image type="content" source="../media/metrics.png" alt-text="Depiction of a metrics data element feeding values into a chart available in the Azure portal under the Monitoring category for many resources.":::

## Insights

Some Azure resource providers have curated visualizations that provide a customized monitoring experience and require minimal configuration. Insights are large, scalable, curated visualizations.

:::image type="content" source="media/overview/insights-box-opt.svg"  alt-text="Diagram that shows the Insights part of the Consumption section of the Azure Monitor system." border="false" lightbox="media/overview/insights-blowup-type-2-opt.svg":::

The following table describes some of the larger insights:

|Insight  |Description  |
|---------|---------|
|[Application Insights](app/app-insights-overview.md)|Application Insights monitors the availability, performance, and usage of your web applications.|
|[Container Insights](containers/container-insights-overview.md)|Container Insights gives you performance visibility into container workloads that are deployed to managed Kubernetes clusters hosted on Azure Kubernetes Service. Container Insights collects container logs and metrics from controllers, nodes, and containers that are available in Kubernetes through the Metrics API. After you enable monitoring from Kubernetes clusters, these metrics and logs are automatically collected for you through a containerized version of the Log Analytics agent for Linux.|
|[VM Insights](vm/vminsights-overview.md)|VM Insights monitors your Azure VMs. It analyzes the performance and health of your Windows and Linux VMs and identifies their different processes and interconnected dependencies on external processes. The solution includes support for monitoring performance and application dependencies for VMs hosted on-premises or another cloud provider.|
|[Network Insights](../network-watcher/network-insights-overview.md)|Network Insights provides a comprehensive and visual representation through topologies, of health and metrics for all deployed network resources, without requiring any configuration. It also provides access to network monitoring capabilities like Connection Monitor, flow logging for network security groups (NSGs), and Traffic Analytics as well as other diagnostic features. |

For more information, see the [list of insights and curated visualizations in the Azure Monitor Insights overview](insights/insights-overview.md).

## Visualizations

:::image type="content" source="media/overview/visualize-box-opt.svg" alt-text="Diagram that shows the Visualize part of the Consumption section of the Azure Monitor system." border="false" lightbox="media/overview/visualize-blowup-type-2-opt.svg":::

Visualizations such as charts and tables are effective tools for summarizing monitoring data and presenting it to different audiences. Azure Monitor has its own features for visualizing monitoring data and uses other Azure services for publishing it to different audiences. Power BI and Grafana are not officially part of the Azure Monitor product, but they're a core integration and part of the Azure Monitor story.

|Visualization|Description  |
|---------|---------|
|[Dashboards](visualize/tutorial-logs-dashboards.md)|Azure dashboards allow you to combine different kinds of data into a single pane in the Azure portal. You can optionally share the dashboard with other Azure users. You can add the output of any log query or metrics chart to an Azure dashboard. For example, you could create a dashboard that combines tiles that show a graph of metrics, a table of activity logs, a usage chart from Application Insights, and the output of a log query.|
|[Workbooks](visualize/workbooks-overview.md)|Workbooks provide a flexible canvas for data analysis and the creation of rich visual reports in the Azure portal. You can use them to query data from multiple data sources. Workbooks can combine and correlate data from multiple data sets in one visualization giving you easy visual representation of your system. Workbooks are interactive and can be shared across teams with data updating in real time. Use workbooks provided with Insights, utilize the library of templates, or create your own.|
|[Power BI](logs/log-powerbi.md)|Power BI is a business analytics service that provides interactive visualizations across various data sources. It's an effective means of making data available to others within and outside your organization. You can configure Power BI to automatically import log data from Azure Monitor to take advantage of these visualizations. |
|[Grafana](visualize/grafana-plugin.md)|Grafana is an open platform that excels in operational dashboards. All versions of Grafana include the Azure Monitor data source plug-in to visualize your Azure Monitor metrics and logs. Azure Managed Grafana also optimizes this experience for Azure-native data stores such as Azure Monitor and Azure Data Explorer. In this way, you can easily connect to any resource in your subscription and view all resulting monitoring data in a familiar Grafana dashboard. It also supports pinning charts from Azure Monitor metrics and logs to Grafana dashboards. <br/><br/> Grafana has popular plug-ins and dashboard templates for non-Microsoft APM tools such as Dynatrace, New Relic, and AppDynamics as well. You can use these resources to visualize Azure platform data alongside other metrics from higher in the stack collected by these other tools. It also has AWS CloudWatch and GCP BigQuery plug-ins for multicloud monitoring in a single pane of glass.|

## Automated actions

An effective monitoring solution proactively responds to critical events, without the need for an individual or team to notice the issue. The response could be a text or email to an administrator, or an automated process that attempts to correct an error condition.

:::image type="content" source="media/overview/respond-box-opt.svg" alt-text="Diagram that shows the Respond part of the Consumption section of the Azure Monitor system." border="false" lightbox="media/overview/respond-blowup-type-2-opt.svg":::

[**Artificial Intelligence for IT Operations (AIOps)**](logs/aiops-machine-learning.md) can improve service quality and reliability by using machine learning to process and automatically act on data you collect from applications, services, and IT resources into Azure Monitor. It automates data-driven tasks, predicts capacity usage, identifies performance issues, and detects anomalies across applications, services, and IT resources. These features simplify IT monitoring and operations without requiring machine learning expertise. 

**[Azure Monitor Alerts](alerts/alerts-overview.md)** notify you of critical conditions and can take corrective action. Alert rules can be based on metric or log data.
 
- Metric alert rules provide near-real-time alerts based on collected metrics. 
- Log alerts rules based on logs allow for complex logic across data from multiple sources.

Alert rules use [action groups](alerts/action-groups.md), which can perform actions such as sending email or SMS notifications. Action groups can send notifications using webhooks to trigger external processes or to integrate with your IT service management tools. Action groups, actions, and sets of recipients can be shared across multiple rules.

:::image type="content" source="media/overview/alerts.png" alt-text="Screenshot that shows the Azure Monitor alerts UI in the Azure portal." lightbox="media/overview/alerts.png":::

SCOM MI currently uses it's own separate traditional SCOM alerting mechanism in the Ops Console. 

**[Autoscale](autoscale/autoscale-overview.md)** allows you to dynamically control the number of resources running to handle the load on your application. You can create rules that use Azure Monitor metrics to determine when to automatically add resources when the load increases or remove resources that are sitting idle. You can specify a minimum and maximum number of instances, and the logic for when to increase or decrease resources to save money and to increase performance.

:::image type="content" source="media/overview/autoscale.png" border="false" alt-text="Conceptual diagram showing how autoscale grows" :::

**[Azure Logic Apps](../logic-apps/logic-apps-overview.md)** is also an option. For more information, see the [Integrate](#integrate) section below. 

