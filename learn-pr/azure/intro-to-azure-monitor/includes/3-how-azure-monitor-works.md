Let's take a peek under the hood of Azure Monitor. You'll learn a bit about how Azure Monitor provides insights into the performance of your hosted services.

You can monitor and start investigations in Azure Monitor directly in the Azure portal or access Azure Monitor capabilities in the Monitoring section of your Azure resource blade.

You can enable Azure Monitor for your resources at-scale programmatically with Azure CLI, Azure Resource Manager (ARM), templates and Powershell. You can ingest and export data via APIs and you can use Azure Event Hubs to stream data out in near real time.

You'll learn how Azure Monitor can:
* Display metrics for your services
* How Azure Monitor agents are used with compute resources
* How Azure Monitor makes use of logs for data storage

## Azure Monitor metrics
Azure Monitor Metrics is a feature of Azure Monitor that collects numeric data from monitored resources into a time series database. You can use this information to evaluate the performance of your hosted services. You can view the metrics in graphs on the Azure portal and you can evaluate the metrics data by understanding its data structure. Each set of recorded values contains the following set of properties:

* A time stamp from when the value was collected.
* The associated resource for the value.
* A namespace, which acts as a category for the metric.
* A metric name.
* The actual value that was recorded.
* Multi-dimensional metrics for supported recorded values.

As soon as you create a resource in Azure, the Azure Monitor begins collecting data. You choose the values to display in the metrics graph for that resource. You can find **Metrics** under the **Monitoring** category of the resource pane in the Azure portal. Once you select **Metrics**, you will be able to select the **Metric Namespace**, **Metric** category, and **Aggregation** from the drop-down menu choices above the graph.

:::image type="content" source="../media/azure-metrics.png" alt-text="Metrics graph selected for a web app depicting average memory working set in a line graph format":::

## Azure Monitor agents
Virtual machines and other compute resources require an agent to collect monitoring data required to measure the performance and availability of their guest operating system and workloads. The Azure Monitor agent (AMA), currently in preview, collects monitoring data from the guest operating system of virtual machines and delivers it to Azure Monitor.

The Azure Monitor agent has replaced the Log Analytics agent, the diagnostic extension, and the Telegraf agent. By utilizing the Azure Monitor Agent, you can realize the following benefits:

* Centrally configure data collection for different data from different sets of virtual machines
* Send data from Linux virtual machines to multiple workspaces
* Use XPATH queries to filter Windows events for collection

You can still use the existing agents in lieu of the Azure Monitor agent. These existing agents are listed in the following table with a brief introduction to their usage:

| Agent Name | Usage |
| --- | --- |
| Log Analytics Agent | Collects monitoring data from the guest operating system and workloads of virtual machines in Azure, other cloud providers, and on-premises machines. It sends data to a Log Analytics workspace. |
| Azure diagnostics extension | Collects monitoring data from the guest operating system and workloads of Azure virtual machines and other compute resources. It primarily collects data into Azure Storage but also allows you to define data sinks to also send data to other destinations such as Azure Monitor Metrics and Azure Event Hubs. |
| Telegraf agent | Collects performance data from Linux computers and sent data to Azure Monitor Metrics. |
| Dependency agent | Collects discovered data about processes running on the machine and external process dependencies. |
| Virtual machine extensions | The Log Analytics extension for Windows and Linux install the Log Analytics agent on Azure virtual machines. The Azure Monitor Dependency extension for Windows and Linux install the Dependency agent on Azure virtual machines. These are the same agents described above but allow you to manage them through virtual machine extensions. You should use extensions to install and manage the agents whenever possible. |

## Azure Monitor logs
Azure Monitor Logs is a feature of Azure Monitor that collects and organizes log and performance data from monitored resources. Data can come from various sources such as:

* platform logs for Azure services
* virtual machine agents
* application usage and performance data

All of this data can be consolidated into a workspace for analysis. The workspace that is referred to here, is a Log Analytics workspace. You must configure this workspace initially and then configure the different sources to send their data to the workspace. Unlike metrics, this data is not automatically collected.

Once you have the workspace configured and data is being logged, it can be analyzed together using a sophisticated query language that's capable of quickly analyzing millions of records. You may perform a simple query that just retrieves a specific set of records or perform sophisticated data analysis to identify critical patterns in your monitoring data. Work with log queries and their results interactively using Log Analytics, use them in an alert rules to be proactively notified of issues, or visualize their results in a workbook or dashboard.

In the log overview image below, data sources on the left indicate Azure resources, applications, virtual machine agents, and the data collector API, feeding into the log database in the middle.  Using a log query, you can output to the sources on the right which indicate Insights, Dashboards, workbooks, log analytics, alerts, and other services.

:::image type="content" source="../media/logs-overview.png" alt-text="Graphic depicting an overview of logging, showing the ability to query the log files to create dashboards, or alerts.":::

> [!NOTE]
> The log query is read-only
