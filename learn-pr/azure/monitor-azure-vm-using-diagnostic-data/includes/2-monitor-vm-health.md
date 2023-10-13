In this unit, you explore the metrics available in Azure, and look at ways to use Azure Monitor Metrics to monitor a virtual machine (VM).

## Azure Monitor metrics

Azure Monitor has two main features for collecting and storing monitoring data: Azure Monitor Metrics and Azure Monitor Logs. Metrics are numerical values that are collected at regular intervals and describe some aspect of a system at a particular time. Metrics can measure performance, resource utilization, error counts, user behavior, or any other aspect of the system that you can quantify.

Azure Monitor Metrics automatically monitors a predefined set of metrics for every Azure resource, and retains the data for 93 days with some exceptions. In the Azure portal, you can see built-in graphs for several important VM metrics, and configure Azure Monitor Metrics to collect many other metrics. You can choose a specific metric and see graphs for that metric, or create customized graphs that show several metrics together.

:::image type="content" source="../media/2-vm-metrics-screenshot.png" alt-text="Screenshot showing CPU percentage usage and inbound flow chart.":::

## Host VM metrics

Fundamental VM architecture consists of the *host* VM, the *guest* or client VM operating system and workloads, and the applications that run on the VMs. Each component has a distinct set of telemetry and monitoring requirements.

Azure collects the following metrics for host VMs by default, and displays the data in a set of built-in charts on the VM's **Overview** page. You can view the built-in basic metrics charts for any Azure VM, and customize the displayed range from 24 hours to 30 days.

- VM availability (preview)
- CPU usage percentage (average)
- OS disk usage
- Network operations
- Disk operations per second (average)

By using VM host metrics, you can:

- Know when your VMs are reaching their disk and CPU limits.
- Detect trends or patterns.
- Control your operational costs by sizing VMs according to usage and demand.

## Metrics Explorer

Azure Monitor Metrics Explorer is an Azure portal component that you can use to plot metrics charts, visually correlate trends, and investigate changes in metrics for your Azure resources. By using Metrics Explorer, you can select, graph, and analyze many metrics on your host VM. With Metrics Explorer, you can:

- Plot multiple metrics on a graph to see how much traffic hits your server and how the server performs.
- Select flexible time ranges and granularity.
- Specify many other settings such as chart type and value ranges.
- Pin graphs to dashboards to quickly view server health and performance.

In Metrics Explorer, you can group metrics by time intervals, geographic regions, server clusters, or application components. Grouping metrics helps organize the data and allows for more granular analysis.

## VM Insights

The VM Insights feature of Azure Monitor provides a set of predefined workbooks that show collected VM metrics over time. You can view this data directly from a single VM, or you can see a combined view of multiple VMs. You can use VM Insights to view and assess trends and patterns across data from all of your VMs.

Prebuilt VM Insights workbooks show performance, connections, active ports, traffic, and other collected data from one or several VMs. You can edit the prebuilt workbook configurations or create your own custom workbooks.

VM Insights is especially useful for exploring overall VM usage when you don't know the metric of primary interest in advance. Unlike other usage analytics tools, VM Insights workbooks let you combine multiple kinds of visualizations and analyses, such as CPU utilization, disk space, memory, and network dependencies.

VM Insights creates a *data collection rule (DCR)* that sends its predefined metrics data to Azure Monitor Logs. Because the DCR sends its metrics to Azure Monitor Logs, you don't use Metrics Explorer to view the metrics data that VM Insights collects.

## DCRs for guest VM metrics

Azure Monitor collects host VM metrics automatically. To collect guest OS and workload metrics from client VMs, you install the Azure Monitor Agent on the VMs and set up DCRs to select the guest metrics to collect.

You can create DCRs that send client metrics data to Azure Monitor Metrics to use for alerts, or to Azure Monitor Logs for archiving and further analysis. Azure Monitor doesn't collect logs by default. You can configure Azure Monitor Logs to collect and analyze logs from any resource.

VM Insights workbooks use the Azure Monitor Agent to create a DCR that collects metrics data and sends it to Azure Monitor Logs. For client VMs, you can configure a DCR to send client VM logs to Azure Monitor Logs.

## Alert rules

Azure Monitor alerts proactively notify you of certain occurrences and patterns in your monitoring data. *Recommended alert rules* are a predefined set of alert rules based on the VM host metrics. These host metrics include the VM availability metric, which alerts when the VM stops running.

You can quickly enable and configure recommended alert rules when you create an Azure VM, or later from the VM's **Overview** page. You can also view, configure, and create custom alerts from the VM's **Alerts** page.

## Boot diagnostics

Boot diagnostics display a screenshot or the serial log of the VM boot sequence to help you troubleshoot boot issues with your VMs. Azure metrics complement boot diagnostics.

You can enable boot diagnostics when you create a VM, or later for an existing VM. Once you enable boot diagnostics, you can see screenshots from the VM's hypervisor for both Windows and Linux machines, and view the output of the console log for Linux machines.

## Dashboards

To be able to view your VM's health quickly, you can save metrics charts to a dashboard on the Azure portal. A custom dashboard is especially helpful when you have to monitor more than one VM's performance. You can add a graph for each VM, or use *splitting* to draw the same metric for several VMs on one graph.

A dashboard also lets you to change the time range for all graphs at the same time, and has many more options than the built-in graphs on a VM's **Overview** page.

:::image type="content" source="../media/4-kpi-dashboard.png" alt-text="Screenshot of an example KPI dashboard, showing CPU maximum and network total graphs.":::

