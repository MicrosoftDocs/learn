You can configure, monitor, troubleshoot, and analyze Azure IoT Hub communications and data using Azure Monitor metrics, alerts, diagnostic settings, and log analytics. This unit provides an overview of the elements of Azure Monitor, how data flows through Azure Monitor, and a high-level overview of how Azure Iot Hub connects to Azure Monitor. Subsequent units of this module provider more detail about Azure Monitor diagnostic settings, alerts, and log analytics.

## Overview

Azure Monitor is a comprehensive monitoring solution for collecting, analyzing, and responding to monitoring data from your cloud and on-premises environments. It helps you understand how your applications are performing and allows you to respond to system events manually and programmatically.

Azure Monitor collects and aggregates data from every layer and component of your system across multiple Azure and non-Azure subscriptions and tenants. It stores the data in a common data platform for consumption by a common set of tools that can correlate, analyze, visualize, and/or respond to the data. You can also use Azure Monitor to integrate other Microsoft and non-Microsoft tools.

As soon as you create an Azure resource, Azure Monitor is enabled and starts collecting metrics and activity logs. With some configuration, you can gather more monitoring data and enable other features.
While resources from different Azure services have different monitoring requirements, they generate monitoring data in the same formats. You can use the same Azure Monitor tools to analyze all Azure resources.

### Overview diagram

The following diagram shows a high-level view of Azure Monitor system components. In this diagram, Azure Monitor follows a data flow pattern of:

1. **Collect** data from data sources
1. **Store** the collected data in the data platform
1. Authorized users **consume** the data using insight, visualize, analysis, and response tools

:::image type="content" source="../media/azure-monitor-overview.png" alt-text="Diagram that shows the different functions that Azure Monitor performs.":::

* The **Data Sources** section of the diagram shows the types of data that can be collected from each monitored resource. Azure Monitor **collects** data from the data sources and routes the data to the data platform.
* The **Data Platform** section of the diagram shows the categorized monitoring data. Azure Monitor's core data platform has stores for metrics, logs, traces, and changes.
* The **Consumption** section of the diagram shows the components that use data from the data platform. Azure Monitor's core consumption methods include tools to provide **insights**, **visualize**, **analyze**, and **respond** to data. The visualization tools build on the analysis tools and the insights build on top of both the visualization and analysis tools. Azure IoT Hub includes consumption support for Metric Explorer, Log Analytics, and Alerts.

The following sections provide more detail regarding data storage, collection, and consumption.

## Data collection

Azure Monitor automatically collects data for each resource in your configuration.

Azure Monitor collects data from each of the following tiers:

* **Application monitoring data**: Data about the performance and functionality of the code you write, regardless of its platform.
* **Guest OS monitoring data**: Data about the operating system on which your application is running. This OS could be running in Azure, another cloud, or on-premises.
* **Azure resource monitoring data**: Data about the operation of an Azure resource.
* **Azure subscription monitoring data**: Data about the operation and management of an Azure subscription, as well as data about the health and operation of Azure itself.
* **Azure tenant monitoring data**: Data about the operation of tenant-level Azure services, such as Microsoft Entra ID.

Data from platform metrics, the activity log, and resource logs have unique collection, storage, and routing specifications:

* **Activity log**: Subscription-level events that track operations for each Azure resource, for example, creating a new resource or starting a virtual machine. Activity log events are automatically generated and collected for viewing in the Azure portal. You can create a diagnostic setting to send the activity log to other destinations by using diagnostic settings.
* **Platform metrics**: Numerical values that are automatically collected at regular intervals and describe some aspect of a resource at a particular time. Platform metrics are automatically generated and collected in Azure Monitor Metrics.
* **Resource logs**: Provide insight into operations that were performed by an Azure resource. Examples of operation might be getting a secret from a key vault or making a request to a database. Resource logs are generated automatically, but you must create a diagnostic setting to send them to Azure Monitor Logs.
* **Virtual machine guest metrics and logs**: Performance and log data from the guest operating system of Azure virtual machines. You must install an agent on the virtual machine to collect this data and send it to Azure Monitor Metrics and Azure Monitor Logs.

For more information about Azure Monitor data sources, see [Sources of monitoring data for Azure Monitor](/azure/azure-monitor/data-sources).

## Data storage

All data collected by Azure Monitor is stored in two fundamental types: **Metrics** and **Logs**.

* **Metrics** stores numeric values into a time-sequenced database that describe some aspect of the system at a particular point in time from monitored resources. The metric database is automatically created for each Azure subscription. Metrics can support near real-time scenarios.

  Use Metrics Explorer to analyze data from Azure Monitor metrics.

* **Logs** collects logs and performance data where they can be retrieved and analyzed in different ways by using log queries.  Telemetry such as events and traces are stored as logs in addition to performance data so that it can all be combined for analysis.

  Resource logs aren't collected and stored until you create an Azure Monitor diagnostic setting and route them to one or more locations. You must create a Log Analytics workspace to collect resource log data.

  Use Log Analytics to analyze data from Azure Monitor Logs.

## Data Routing

You can use diagnostic settings to route metrics and logs to the following locations:

* The Azure Monitor Logs store via an associated Log Analytics workspace. There the data can be analyzed using Log Analytics.
* Azure Storage for archiving and offline analysis.
* An Event Hubs endpoint where they can be read by external applications, for example, third-party security information and event management (SIEM) tools.

Metric and log routing is described in more detail in the Examine diagnostic settings for Azure IoT Hub unit page.

## Data consumption

### Azure IoT Hub Analysis features

You can analyze Azure IoT Hub monitor data using the following built-in Azure IoT Hub features:

* IoT Hub **Overview** page - The IoT Hub overview page includes charts that show recent critical metrics. You can use this page to quickly assess the performance of the resource.
* **Metrics Explorer** - You can use Metrics Explorer to interactively work with metric data and create metric alerts. You need minimal training to use Metrics Explorer, but you must be familiar with the metrics you want to analyze. Metrics Explorer and IoT Hub metrics are described further in the Examine metrics for Azure IoT Hub unit page.
* **Log Analytics** - With Log Analytics, you can create log queries to interactively work with log data and create log query alerts. Log Analytics is described further in the Examine Log Analytics for Azure IoT Hub unit page.

### Visualization tools

You can visualize Azure Monitor data using the following built-in tools:

* **Workbooks** - Provide a flexible canvas for data analysis and the creation of rich visual reports. You can use workbooks to tap into multiple data sources from across Azure and combine them into unified interactive experiences. They're especially useful to prepare end-to-end monitoring views across multiple Azure resources. Insights use prebuilt workbooks to present you with critical health and performance information for a particular service.
* **Dashboards** - Are useful in providing a "single pane of glass" of your Azure infrastructure and services. While a workbook provides richer functionality, a dashboard can combine Azure Monitor data with data from other Azure services.
* **Grafana** - an open platform that excels in operational dashboards. It's useful for:
  * Detecting, isolating, and triaging operational incidents.
  * Combining visualizations of Azure and non-Azure data sources. These sources include on-premises, third-party tools, and data stores in other clouds.
* **Power BI** - Power BI is useful for creating business-centric dashboards and reports, along with reports that analyze long-term KPI trends. You can import the results of a log query into a Power BI dataset. Then you can take advantage of its features, such as combining data from different sources and sharing reports on the web and mobile devices.

For more information about built-in visualization tools, see [Built-in visualization tools](/azure/azure-monitor/best-practices-analysis#built-in-visualization-tools).
