Azure Monitor is a service for collecting and analyzing telemetry allowing maximum performance and availability on your cloud and on on-premises resources and applications. Its purpose is to show you how your applications are performing as well as identifying any issues regarding them.

## Data collection in Azure Monitor

Azure Monitor collects two fundamental types of data: logs and metrics. Logs contain records that indicate when resources are created or modified. Metrics tell you how the resource is performing, and the other resources that it's consuming.

The following diagram gives a high-level view of Azure Monitor. On the left are the sources of monitoring data, which include Azure, operating systems, and custom sources. At the center of the diagram, are the data stores for metrics and logs. Metrics and logs are the two fundamental types of data used by Azure Monitor. On the right, are the different functions that Azure Monitor performs with this collected data such as analysis, alerting, and streaming to external systems.

![Azure Monitor architecture.](../media/2-azure-monitor.svg)

Azure Monitor collects data automatically from a range of components. For example:

- **Application data**- Data that relates to your custom application code. 
- **Operating system data** - Data from the Windows or Linux virtual machines that host your application.
- **Azure resource data** - Data that relates to the operations of an Azure resource, such as a web app or a load balancer.
- **Azure subscription data** - Data that relates to your subscription, and includes data about Azure health and availability.
- **Azure tenant data** - Data about your Azure tenent-level services, such as Azure Active Directory.

Because Azure Monitor is an automatic system, it begins to collect data from these sources as soon as you create Azure resources such as virtual machines and web apps. However, you can extend the data that Azure Monitor collects by:

- **Enabling diagnostics** - For some resources, such as Azure SQL Database, you only receive full information about a resource after you have enabled diagnostic logging for it. You can use the Azure portal, Azure CLI, or PowerShell to enable diagnostics.
- **Adding an agent** - For virtual machines, you can install the Log Analytics agent and configure it to send data to a Log Analytics workspace. This agent increases the amount of information that is sent to Azure Monitor.

Your developers might also want to send data to Azure Monitor from custom code, such as a Web app, Azure Function, or mobile app. They send data by calling the Data Collector API. This is a REST interface, that you communicate with through HTTP, and is compatible with a wide variety of development frameworks, such as .NET Framework, Node.JS, and Python. Developers can choose their favorite language and framework to log data in Azure Monitor.

### Logs

Logs contain timestamped information about changes made to resources. The type of information recorded varies by log source. The log data is organized into records, with different sets of properties for each type of record. The logs can include numeric values such as Azure Monitor Metrics but most include text data rather than numeric values.

The most common type of log entry records an event. Events can occur sporadically rather than at fixed intervals or according to some schedule. Events are created by applications and services, which provide the context for the events. Metric data can be stored in logs to combine them with other monitoring data for other data analysis.

Log data from Azure Monitor in a Log Analytics workspace. Azure provides an analysis engine and rich query language. The logs are used to show enough context of the issue being identified and are useful for identifying the root case of any problems.

![An example query against Azure logs](../media/2-azure-logs-query-example.png)

### Metrics

Metrics are numerical values that describe some aspect of a system at a particular point in time. Azure Monitor is capable of capturing metrics in near real time. The metrics are collected at regular intervals and are useful for alerting due to their frequent sampling. With a variety of algorithms, a metric can be compared to other metrics to observe trends over time.

Metrics are stored in a time-series database. This data store is most effective for analyzing time stamped data. Metrics are particularly suited for alerting and fast detection of issues. They can tell you about system performance, but if needed they can be combined with logs to identify the root cause of issues.

![An example chart in Azure Metrics](../media/2-azure-monitor-metrics.png)

## Analyzing logs with Kusto

To retrieve, consolidate and analyze data, you specify a query that Azure Monitor Logs runs. You write a log query with the **Kusto** query language, which is also used by **Azure Data Explorer**. Log queries can be tested in the Azure portal so you can work with them interactively. You'll typically start with basic queries and then progress to use more advanced functions as your requirements become more complex.

In the Azure portal, you can create custom dashboards, which are targeted displays of resources and data. Each dashboard is built of a set of tiles and each tile might show a set of resources, a chart, a table of data, or some custom text. Azure Monitor provides tiles that you can add to dashboards. For example, you could use a tile to display the results of a Kusto query in a dashboard.

In the example scenario, the operations team can consolidate their data by visualizing monitoring data such as charts and tables. These tools are effective for summarizing data and presenting it to different audiences. The use of Azure Dashboards enables you to combine different kinds of data, including both logs and metrics, into a single pane in the Azure portal. For example, you might wish to create a dashboard that combines tiles that show a graph of metrics, a table of activity logs, charts from Application Insights and the output of a log query.
