
## What is Azure Monitor?

Azure Monitor helps you maximize the availability and performance of your applications and services. Azure Monitor delivers a comprehensive solution for collecting, analyzing, and acting on telemetry from your cloud and on-premises environments. This information helps you understand how your applications are performing and proactively identify issues affecting them and the resources they depend on.

Here are a few features of Azure Monitor.

 -  Use Application Insights to detect and diagnose issues across applications.
 -  Correlate infrastructure issues with VM insights and Container insights.
 -  Use Log Analytics to explore troubleshooting and diagnostics your monitoring data.
 -  Support operations at scale with smart alerts and automated actions.
 -  Create visualizations with Azure dashboards and workbooks.
 -  Collect data from monitored resources using Azure Monitor Metrics.

The next diagram offers a high-level view of Azure Monitor. At the center of the diagram are the two fundamental types of data stores: metrics and logs, In the left pane are the monitoring sources that populate these data stores. In the right pane are the different actions that Azure Monitor performs with this collected data. Actions include analysis, alerting, and streaming to external systems.

:::image type="content" source="../media/azure-monitor-overview-15b1f34a.png" alt-text="Screenshot of a high-level view of Azure Monitor. ":::


### Monitor data types in Azure Monitor

There are two types of data collected by Azure Monitor. 

 -  **Metrics**. Azure Monitor Metrics is a feature that collects numeric data from monitored resources into a time series database. Metrics are numerical values that are collected at regular intervals and describe some aspect of a system at a particular time. Metrics in Azure Monitor are lightweight and capable of supporting near real-time scenarios making them useful for alerting and fast detection of issues.
 -  **Logs**. Logs contain different kinds of data organized into records with different sets of properties for each type. Telemetry such as events and traces are stored as logs in addition to performance data so that it can all be combined for analysis. 

### Azure Monitor metric sources

There are four fundamental sources of metrics collected by Azure Monitor. 

:::image type="content" source="../media/azure-monitor-metrics-overview-bb85daba.png" alt-text="Diagram of the high-level Azure Monitor metrics.":::

 -  **Azure resources**. Azure resources create platform metrics that give you visibility into the resources health and performance. Each type of resource creates a distinct set of metrics. Platform metrics are collected from Azure resources at one-minute frequency unless specified otherwise in the metric's definition.
 -  **Applications**. Application Insights shows metrics for your monitored applications and helps you detect performance issues and track trends. Application metrics include server response times and browser exceptions.
 -  **Virtual machine agents**. Metrics are collected from the guest operating system of a virtual machine. Enable guest OS metrics for Windows virtual machines with Windows Diagnostic Extension (WAD) and for Linux virtual machines with InfluxData Telegraf Agent.
 -  **Custom metrics**. You can define custom metrics in your application that is monitored with Application Insights or create custom metrics for an Azure service using the custom metrics API.

### Azure Monitor metric tasks

 The next table summarizes the tasks you can perform using metrics. 

| **Task**  |                                                                                                                     **Description**                                                                                                                     |
|:---------:|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  Analyze  |                                                                       Use metrics explorer to analyze collected metrics on a chart and compare metrics from different resources.                                                                        |
|   Alert   |                                                              Configure a metric alert rule that sends a notification or takes automated action when the metric value crosses a threshold.                                                               |
| Visualize | Pin a chart from Metrics Explorer to an Azure dashboard.<br>Create a workbook to combine with multiple sets of data in an interactive report. |
| Automate  |                                                                              Use Autoscale to increase or decrease resources based on a metric value crossing a threshold.                                                                              |
| Retrieve  |                                Access metric values from the command line or REST API.           |
|  Export   |             Route Metrics to Logs to analyze data.<br>Stream Metrics to an event hub to route them to external systems.             |
|  Archive  |                                                                   Archive the performance or health history of your resource for compliance, auditing, or offline reporting purposes.                                                                   |

## Metrics Explorer

 Data collected by Azure Monitor is shown in the Azure portal on the **Monitoring** tab of a resource's **Overview** page.

The next image shows the Monitoring tab for a virtual machine. Note the different charts displaying several key performance metrics. These metrics include **CPU**, **Network**, and **Disk**.


:::image type="content" source="../media/monitoring-tab.png" alt-text="Screenshot of the Azure Monitor Metrics Explorer." lightbox="../media/monitoring-tab.png":::

## Monitor network resources with Azure Monitor Network Insights

You can use the **Insights > Networks** section in **Azure Monitor** for a high-level view of network resources health and metrics. Azure Insights provides access to network monitoring features such as Connection Monitor, flow logging for network security groups (NSG) flow logs, and Traffic Analytics. Azure Monitor Network Insights is structured around these key components.

 -  **Network health and metrics**. Offers a simple method for visualizing an inventory of your networking resources, together with resource health and alerts. Health is divided into four key areas: search and filtering, resource health and metrics, alerts, and dependency view.
 -  **Connectivity**. Provides an easy way to visualize Connection Monitor tests. Tests are grouped by **Sources** and **Destinations**. 
 -  **Traffic**. Provides access to **NSG flow logs** and **Traffic Analytics** for the selected set of subscriptions, grouped by location. You can search for any IP address in your environment.
 -  **Diagnostic Toolkit**. Provides access to all the diagnostic features available for troubleshooting your networks and their components. Most of these tools use Network Watcher. 
    -  *Capture packets* help to diagnose network anomalies, both reactively, and proactively. 
    -  *Troubleshoot VPN* diagnoses the health of a virtual network gateway or connection.
    -  *Troubleshoot connectivity* checks TCP connections. Connections can include the fully qualified domain name (FQDN), URI, or IPv4 address.
    -  *Identify next hops* obtains the next hop type and IP address of a packet from a specific VM and NIC. Knowing the next hop can help you establish if traffic is being directed to the expected destination, or whether the traffic is being dropped.
    -  *Diagnose traffic filtering issues* verifies if a packet is allowed or denied, to or from a virtual machine. The security group decision and the name of the rule that denied the packet is returned.

:::image type="content" source="../media/network-insights-diagnostic-toolkit-0e306787.png" alt-text="Screenshot of Azure Monitor Network Insights, with the Diagnostic Toolkit highlighted.":::
