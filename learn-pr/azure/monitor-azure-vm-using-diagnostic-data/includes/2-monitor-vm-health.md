In this unit, you explore the types of data you can monitor on an Azure VM and how you can collect each type of data by using Azure Monitor.

## Azure Monitor metrics

Azure Monitor has two main features for collecting and storing monitoring data: Azure Monitor Metrics and Azure Monitor Logs. Metrics are numerical values that are collected at predetermined intervals to describe some aspect of a system at a particular time. Metrics can measure performance, resource utilization, error counts, user behavior, or any other aspect of the system that you can quantify.

Azure Monitor Metrics automatically monitors a predefined set of metrics for every Azure VM, and retains the data for 93 days with some exceptions. In the Azure portal, you can see built-in graphs for several important VM metrics, and configure Azure Monitor Metrics to collect many other metrics. You can choose a specific metric and see graphs for that metric, or create customized graphs that show several metrics together.

:::image type="content" source="../media/2-vm-metrics-screenshot.png" alt-text="Screenshot showing CPU percentage usage and inbound flow chart." lightbox="../media/2-vm-metrics-screenshot.png":::

## VM monitoring

There are fundamentally four layers to a VM that require monitoring. Each layer has a distinct set of telemetry and monitoring requirements.

- The host VM
- Guest operating system (OS)
- Client workloads
- Applications that run on the VM

:::image type="content" source="../media/monitoring-layers.png" alt-text="Diagram that shows fundamental VM architecture."  lightbox="../media/monitoring-layers.png" border="false":::

## Host VM metrics

Azure automatically collects the following metrics for host VMs, and displays the data in a set of built-in charts on the VM's **Overview** page. You can view the built-in basic metrics charts for any Azure VM, and customize the displayed range from the past hour to the past 30 days.

- VM availability (preview)
- CPU usage percentage (average)
- OS disk usage
- Network operations
- Disk operations per second (average)

By using VM host metrics, you can:

- Know when your VMs are reaching their disk and CPU limits.
- Detect trends or patterns.
- Control your operational costs by sizing VMs according to usage and demand.

### Recommended alert rules

Azure Monitor alerts proactively notify you of certain occurrences and patterns in your VM host metrics. *Recommended alert rules* are a predefined set of alert rules based on common host metrics. These metrics include CPU percentage, available memory, and VM availability, which shows when the VM stops running.

You can quickly enable and configure recommended alert rules when you create an Azure VM, or afterwards from the VM's **Overview** page. You can also view, configure, and create custom alerts from the VM's **Alerts** page.

### Metrics Explorer

Azure Monitor Metrics Explorer is an Azure portal component that you can use to plot metrics charts and visually correlate trends to investigate metrics changes for your VMs. By using Metrics Explorer, you can:

- Plot multiple metrics on a graph to see how much traffic hits your VM and how the VM performs.
- Select flexible time ranges and granularity.
- Specify many other settings such as chart type and value ranges.
- Pin graphs to dashboards to quickly view server health and performance.

In Metrics Explorer, you can group metrics by time intervals, geographic regions, server clusters, or application components. Grouping metrics helps organize the data and allows for more granular analysis.

To view your VM's health quickly, you can save metrics charts to a dashboard on the Azure portal. A custom dashboard is especially helpful when you have to monitor more than one VM's performance. You can add a graph for each VM, or use *splitting* to draw the same metric for several VMs on one graph. A dashboard also lets you change the time range for all graphs at the same time, and has many other options.

:::image type="content" source="../media/4-kpi-dashboard.png" alt-text="Screenshot of an example KPI dashboard, showing CPU maximum and network total graphs." lightbox="../media/4-kpi-dashboard.png":::

## Client metrics

To use Azure Monitor to collect guest OS and client workload metrics, you install the Azure Monitor Agent on the VM and set up *data collection rules (DCRs)* to select the metrics to collect. You can create DCRs that send client metrics data to Azure Monitor Metrics to use for alerts, or to Azure Monitor Logs for archiving and further analysis.

### VM Insights

The VM Insights feature of Azure Monitor provides a set of predefined workbooks that show collected VM client metrics over time. VM Insights workbooks use the Azure Monitor Agent to create a DCR that sends the predefined metrics data to Azure Monitor Logs. Because the DCR sends its metrics to Azure Monitor Logs, you don't use Metrics Explorer to view the metrics data that VM Insights collects.

Prebuilt VM Insights workbooks show performance, connections, active ports, traffic, and other collected data from one or several VMs. You can edit the prebuilt workbook configurations or create your own custom workbooks. You can view VM Insights data directly from a single VM, or see a combined view of multiple VMs to view and assess trends and patterns across all of your VMs.

VM Insights is especially useful for exploring overall VM usage when you don't know the metric of primary interest in advance. Unlike other usage analytics tools, VM Insights workbooks let you combine multiple kinds of visualizations and analyses, such as CPU utilization, disk space, memory, and network dependencies.

## Logs

Azure Monitor doesn't collect any logs by default, but you can configure Azure Monitor Logs to collect and analyze logs from any Azure resource. You can configure Azure Monitor Agent DCRs to send client performance counter data to both Azure Monitor Metrics and Azure Monitor Logs, but you can send event log data only to Azure Monitor Logs. Azure Monitor stores and analyzes logs in a Log Analytics workspace, where you can access them by using a log query written in Kusto Query Language (KQL).

### Activity logs

Azure Monitor activity logs include information like VM startup or modifications. You can create diagnostic settings to send activity logs to the following destinations:

- Azure Monitor Logs, for more complex querying and alerting and for longer retention up to two years.
- Azure Storage, for cheaper, long-term archiving.
- Azure Event Hubs, to forward outside of Azure.

### Boot diagnostics

Boot diagnostics are host-level event monitoring you can use to help troubleshoot boot issues with your VMs. You enable boot diagnostics by default when you create a VM, or afterwards for an existing VM. Once you enable boot diagnostics, you can see screenshots from the VM's hypervisor for both Windows and Linux machines, and view the serial console log output of the VM boot sequence for Linux machines. Boot diagnostics stores data in a managed storage account.

