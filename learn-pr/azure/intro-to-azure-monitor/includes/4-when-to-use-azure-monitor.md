This unit describes how Azure Monitor Insights, visualizations, and dashboards can consume and transmit monitoring information about your web application. You can also use alerts and automated actions to proactively respond to and sometimes correct application issues.

## Insights

Some Azure resource providers have created visualizations that provide a customized monitoring experience and require minimal configuration. Insights are large, scalable, curated visualizations.

:::image type="content" source="../media/insights-box.svg"  alt-text="Diagram that shows the Insights part of Azure Monitor." border="false" lightbox="../media/insights-blowup.svg":::

Azure Monitor includes many types of Insights. In the Azure portal, select **Insights Hub** in the Azure Monitor left navigation to list and access all the available types of Insights.

The following sections describe some of the largest, most common Azure Monitor Insights.

## Application Insights

The Application Insights feature of Azure Monitor provides application performance monitoring (APM) from app development, through test, and into production. You can *proactively* monitor to see how well an application is performing, and *reactively* review application execution data to find the cause of an incident.

Along with collecting metrics and telemetry data that describe application activities and health, you can use Application Insights to collect and store application *trace logging* data. The log trace is associated with other telemetry to give a detailed view of activity. To add trace logging to existing applications, you only need to provide a destination for the logs. You seldom need to change the logging framework.

Application Insights supports *distributed tracing*, which is also known as distributed component correlation. This feature allows searching for and visualizing the end-to-end flow of a specific execution or transaction. The ability to trace activity from end to end is important for applications built as distributed components or microservices.

Application Insights also includes the following features:

- **Live metrics** observe activity from your deployed application in real time with no effect on the host environment.
- **Availability monitoring**, also known as *synthetic transaction monitoring*, probes the external endpoints of your applications to test overall availability and responsiveness over time.
- **Usage monitoring** helps you understand which features are popular with users and how users interact and use your application.
- **Smart detection** detects failures and anomalies automatically through proactive telemetry analysis.
- **Application Map** is a high-level, top-down view of your application architecture with at-a-glance visual references to component health and responsiveness.

### Container Insights

Container Insights gives you performance visibility into containerized workloads deployed to Azure Kubernetes Service (AKS) or Azure Container Instances. Container Insights collects container logs and metrics from controllers, nodes, and containers that are available through the Metrics API. After you enable monitoring from AKS clusters, these metrics and logs are automatically collected for you through a containerized version of the Log Analytics agent.

### VM Insights

VM Insights monitors and analyzes the performance and health of your Azure Windows and Linux VMs, including VMs hosted on-premises or in another cloud. VM Insights identifies VM processes, application dependencies, and interconnected dependencies on external processes.

### Network Insights

Network Insights provides a comprehensive visual representation of health and metrics for all deployed network resources through topologies, without requiring any configuration. Network Insights also provide access to network monitoring capabilities like Connection Monitor, flow logging for network security groups (NSGs), Traffic Analytics, and other diagnostic features.

## Visualizations

Visualizations such as charts and tables are effective tools for summarizing monitoring data and presenting it to audiences. Azure Monitor has its own features for visualizing monitoring data, and uses other Azure services for publishing data to different audiences. Power BI and Grafana aren't officially part of Azure Monitor, but are core integrations to tell the monitoring story.

:::image type="content" source="../media/visualize-box.svg" alt-text="Diagram that shows the Visualize part of Azure Monitor." border="false" lightbox="../media/visualize-blowup.svg":::

The following sections describe some Azure Monitor and external tools for visualizing and presenting monitoring data.

### Azure Monitor Workbooks

Workbooks provide a flexible canvas for analyzing data and creating rich visual reports in the Azure portal. Workbooks can query data from multiple data sources and combine and correlate data from multiple data sets in one visualization, giving you easy visual representation of your system. Workbooks are interactive, with data updating in real time, and can be shared across teams.

You can use the workbooks that Azure Monitor Insights provide, use the workbook template library, or create your own workbooks. In the Azure portal, select **Workbooks** in the Azure Monitor left navigation to see and access the available workbooks and templates.

### Azure Dashboards

Dashboards let you combine different kinds of data into a single pane in the Azure portal. You can add the output of any log query or metrics chart to an Azure dashboard, and optionally share the dashboard with other Azure users. For example, you could create a dashboard that shows a graph of metrics, a table of activity logs, and a usage chart from Application Insights.

### Power BI

Power BI is a business analytics service that provides interactive visualizations across various data sources. You can configure Power BI to automatically import log data from Azure Monitor to take advantage of these visualizations. Power BI is an effective way to make data available to other people within and outside your organization.

### Grafana

Grafana is an open platform for operational dashboards. Grafana includes the Azure Monitor data source plugin to visualize Azure Monitor metrics and logs. Azure Managed Grafana optimizes this experience for Azure-native data stores such as Azure Monitor and Azure Data Explorer.

Grafana also has popular plugins and dashboard templates for non-Microsoft application performance monitoring (APM) tools such as Dynatrace, New Relic, and AppDynamics. Grafana includes AWS CloudWatch and GCP BigQuery plugins for multicloud monitoring in a single pane of glass. You can use these resources to visualize Azure Monitor data alongside other metrics that these other tools collect.

## Actions

An effective monitoring solution proactively responds to critical events without the need for an individual or team to notice the issue. The response could be a text or email to an administrator, or an automated process that attempts to correct an error condition.

:::image type="content" source="../media/respond-box.svg" alt-text="Diagram that shows the Respond part of the Consumption section of the Azure Monitor system." border="false" lightbox="../media/respond-blowup.svg":::

Azure Monitor works with the following types of automated alerting and responses.

### Artificial Intelligence for IT Operations (AIOps)

AIOps describes the application of artificial intelligence and machine learning techniques to enhance and automate aspects of IT operations and infrastructure management. Azure Monitor provides features that use machine learning and artificial intelligence to automate data-driven tasks, predict capacity usage, identify performance issues, and detect anomalies.

These features simplify IT monitoring and operations without requiring machine learning expertise. If you have machine learning expertise, you can apply more machine learning to the data Azure Monitor collects by using Azure Machine Learning services.

### Azure Monitor alerts

Alerts notify you of critical conditions and can take corrective action. Alert rules can be based on metric or log data. Metric alert rules provide near-real time alerts based on collected metrics. Log alert rules based on log data allow for complex logic across data from multiple sources.

Alert rules use *action groups*, which can take actions such as sending email or SMS notifications. Action groups can send notifications using webhooks to trigger external processes or to integrate with IT service management tools. You can share action groups, actions, and sets of recipients across multiple rules.

### Autoscale

Autoscale lets you dynamically adjust the number of resources running to handle the load on your applications. To save money or increase performance, you can create rules that use Azure Monitor metrics to determine when to automatically add or remove resources. You can specify a minimum and maximum number of instances and the logic for when to increase or decrease resources.

