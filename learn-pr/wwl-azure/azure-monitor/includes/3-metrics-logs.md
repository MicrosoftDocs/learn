
All data that Azure Monitor collects fits into one of two fundamental types: **metrics or logs**.

## Azure Monitor Metrics

Azure Monitor Metrics is a feature of Azure Monitor that collects numeric data from monitored resources into a time series database. Metrics are numerical values that are collected at regular intervals and describe some aspect of a system at a particular time.

### Azure Monitor Metrics - Navigation Example

Use Metrics Explorer to interactively analyze the data in your metric database and chart the values of multiple metrics over time. You can pin the charts to a dashboard to view them with other visualizations. You can also retrieve metrics by using the Azure monitoring REST API.

:::image type="content" source="../media/azure-metrics-navigation-example-a13fde6f.png" alt-text="Screenshot of Azure metrics navigation example.":::
 Behind the scene, log-based metrics translate into log queries. Their retention matches the retention of events in underlying logs. For Application Insights resources, logs are stored for 90 days.

## Types of metrics

There are multiple types of metrics supported by Azure Monitor Metrics:

:::image type="content" source="../media/azure-monitor-metrics-example-23e23235.png" alt-text="Screenshot of Azure monitor metrics example.":::


 -  **Native metrics** use tools in Azure Monitor for analysis and alerting.
     -  Platform metrics are collected from Azure resources. They require no configuration and have no cost.
     -  Custom metrics are collected from different sources that you configure, including applications and agents running on virtual machines.
 -  **Prometheus metrics** (preview) are collected from Kubernetes clusters, including Azure Kubernetes Service (AKS), and use industry-standard tools for analyzing and alerting, such as PromQL and Grafana.

**Additional Background and Information**

**What is Prometheus?** Prometheus is an **open-source toolkit** that **collects data** for **monitoring** and **alerting**.

**Prometheus Features:**

 -  A multi-dimensional data model with time series data identified by metric name and key/value pairs
 -  PromQL (**PromQL component called Prom Kubernetes - an extension to support Prometheus**) provides a flexible query language to use this dimensionality.
 -  Time series collection happens via a pull model over Hypertext Transfer Protocol (**HTTP**)
 -  Pushing time series is supported via an intermediary gateway
 -  Targets are discovered via service discovery or static configuration

**What is Azure Managed Grafana?**

Azure Managed Grafana is a data visualization platform built on top of the Grafana software by Grafana Labs. It's built as a fully managed Azure service operated and supported by Microsoft. Grafana helps you combine metrics, logs, and traces into a single user interface. With its extensive support for data sources and graphing capabilities, you can view and analyze your application and infrastructure telemetry data in real-time.

**Azure Managed Grafana** is optimized for the Azure environment. It works seamlessly with many Azure services. Specifically, for the current preview, it provides with the following integration features:

 -  Built-in support for Azure Monitor and Azure Data Explorer
 -  User authentication and access control using Azure Active Directory identities
 -  Direct import of existing charts from the Azure portal

**Why use Azure Managed Grafana?**

**Managed Grafana** lets you bring together all your telemetry data into one place. It can access various data sources supported, including your data stores in Azure and elsewhere. By combining charts, logs, and alerts into one view, you can get a holistic view of your application and infrastructure and correlate information across multiple datasets.

As a fully managed service, Azure Managed Grafana lets you deploy Grafana without having to deal with setup. The service provides high availability, service level agreement (SLA) guarantees, and automatic software updates.

You can share Grafana dashboards with people inside and outside your organization and allow others to join in for monitoring or troubleshooting.

Managed Grafana uses **Azure Active Directory (Azure AD)’s centralized identity management**, which allows you to control which users can use a Grafana instance, and you can use managed identities to access Azure data stores, such as Azure Monitor.

You can create dashboards instantaneously by importing existing charts directly from the Azure portal or by using prebuilt dashboards.

The differences between each of the metrics are summarized in the following table.

| **Category**  | **Native platform metrics**                                                                                                                                                          | **Native custom metrics**                                                                                                                                                            | **Prometheus metrics** (preview)                                                      |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------- |
| Sources       | Azure resources                                                                                                                                                                      | Azure Monitor agent<br>Application Insights<br>Representational State Transfer (REST) Application Programming Interface (API)                                                        | Azure Kubernetes Service (AKS) cluster<br>Any Kubernetes cluster through remote-write |
| Configuration | None                                                                                                                                                                                 | Varies by source                                                                                                                                                                     | Enable Azure Monitor managed service for Prometheus                                   |
| Stored        | Subscription                                                                                                                                                                         | Subscription                                                                                                                                                                         | Azure Monitor workspace                                                               |
| Cost          | No                                                                                                                                                                                   | Yes                                                                                                                                                                                  | Yes (free during preview)                                                             |
| Aggregation   | pre-aggregated                                                                                                                                                                       | pre-aggregated                                                                                                                                                                       | raw data                                                                              |
| Analyze       | Metrics Explorer                                                                                                                                                                     | Metrics Explorer                                                                                                                                                                     | Prometheus Querying (PromQL) LanguageGrafana dashboards                               |
| Alert         | metrics alert rule                                                                                                                                                                   | metrics alert rule                                                                                                                                                                   | Prometheus alert rule                                                                 |
| Visualize     | WorkbooksAzure dashboardGrafana                                                                                                                                                      | WorkbooksAzure dashboardGrafana                                                                                                                                                      | Grafana                                                                               |
| Retrieve      | Azure Command-Line Interface (CLI) Azure PowerShell cmdletsRepresentational State Transfer (REST) Application Programming Interface (API) or client library.NETGoJavaJavaScriptPython | Azure Command-Line Interface (CLI) Azure PowerShell cmdletsRepresentational State Transfer (REST) Application Programming Interface (API) or client library.NETGoJavaJavaScriptPython | Grafana                                                                               |

## Data collection

Azure Monitor collects metrics from the following sources. After these metrics are collected in the Azure Monitor metric database, they can be evaluated together regardless of their source:

 -  **Azure resources:** Platform metrics are created by Azure resources and give you visibility into their health and performance. Each type of resource creates a distinct set of metrics without any configuration required. Platform metrics are collected from Azure resources at a one-minute frequency unless specified otherwise in the metric's definition.
 -  **Applications:** Application Insights creates metrics for your monitored applications to help you detect performance issues and track trends in how your application is used. Values include Server response time and Browser exceptions.
 -  **Virtual machine agents:** Metrics are collected from the guest operating system of a virtual machine. You can enable guest operating system (OS) metrics for Windows virtual machines using the Windows diagnostic extension and Linux virtual machines by using the InfluxData Telegraf agent.
 -  **Custom metrics:** You can define metrics in addition to the standard metrics that are automatically available. You can define custom metrics in your application that are monitored by Application Insights. You can also create custom metrics for an Azure service by using the custom metrics Application Programming Interface (API).
 -  **Kubernetes clusters:** Kubernetes clusters typically send metric data to a local Prometheus server that you must maintain. Azure Monitor managed service for Prometheus provides a managed service that collects metrics from Kubernetes clusters and stores them in Azure Monitor Metrics.

A common type of log entry is an event, which is collected sporadically. Events are created by an application or service and typically include enough information to provide complete context on their own. For example, an event can indicate that a particular resource was created or modified, a new host started in response to increased traffic, or an error was detected in an application.

Because the format of the data can vary, applications can create custom logs by using the structure that they need. Metric data can even be stored in Logs to combine them with other monitoring data for trending and other data analysis.

The following is a list of the different ways that you can use Logs in Azure Monitor.

 -  **Analyze** \- Use Log Analytics in the Azure portal to write log queries and interactively analyze log data using the powerful Data Explorer analysis engine. Use the Application Insights analytics console in the Azure portal to write log queries and interactively analyze log data from Application Insights.
 -  **Visualize** \- Pin query results rendered as tables or charts to an Azure dashboard. Create a workbook to combine with multiple sets of data in an interactive report. Export the results of a query to Power BI to use different visualizations and share with users outside of Azure. Export the results of a query to Grafana to use its dashboarding and combine with other data sources.
 -  **Alert** \- Configure a log alert rule that sends a notification or takes automated action when the results of the query match a particular result. Configure a metric alert rule on certain log data logs extracted as metrics.
 -  **Retrieve** \- Access log query results from a command line using Azure command-line interface (CLI). Access log query results from a command line using PowerShell cmdlets. Access log query results from a custom application using Representational State Transfer (REST) Application Programming Interface (API).
 -  **Export** \- Build a workflow to retrieve log data and copy it to an external location using Logic Apps.

### Log queries

Data in Azure Monitor Logs is retrieved using a log query written with the Kusto query language, which allows you to quickly retrieve, consolidate, and analyze collected data. Use Log Analytics to write and test log queries in the Azure portal. It allows you to work with results interactively or pin them to a dashboard to view them with other visualizations.

:::image type="content" source="../media/az500-log-analytics-2-1692bd96.png" alt-text="Azure Logs retrieved using a log query":::


### Security tools use of Monitor logs

 -  **Microsoft Defender for Cloud** stores data that it collects in a Log Analytics workspace where it can be analyzed with other log data.
 -  **Azure Sentinel** stores data from data sources into a Log Analytics workspace.
