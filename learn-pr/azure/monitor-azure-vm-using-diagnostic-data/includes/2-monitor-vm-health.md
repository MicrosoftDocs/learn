In this unit, you explore the monitoring capabilities of Azure Monitor, and the types of data it can collect and analyze for an Azure VM. Azure Monitor collects two main types of monitoring data for VMs: Metrics and Logs.

Metrics are numerical values collected at predetermined intervals to describe some aspect of a system at a particular time. Metrics can measure performance, resource utilization, error counts, user behavior, or any other aspect of the system that you can quantify. Azure Monitor Metrics automatically monitors a predefined set of metrics for every Azure VM, and retains the data for 93 days with some exceptions.

Logs are recorded system events that contain a timestamp and different types of structured or free-form data. Azure Monitor doesn't collect logs by default, but you can configure Azure Monitor Logs to collect and analyze logs from any Azure resource. Azure Monitor stores structured and unstructured log data in Azure Monitor Logs, and can route data to Log Analytics workspaces for querying and analysis.

VMs have several layers that require monitoring. Each of the following layers has a distinct set of telemetry and monitoring requirements.

- Host VM
- Guest operating system (OS)
- Client workloads
- Applications that run on the VM

:::image type="content" source="../media/monitoring-layers.png" alt-text="Diagram that shows fundamental VM architecture."  lightbox="../media/monitoring-layers.png" border="false":::

## Host VM monitoring

For an Azure VM, the VM host represents the compute, storage, and network resources that Azure allocates to the VM.

### VM host metrics

VM host metrics track and alert on activity such as configuration changes, processor utilization, and whether the machine is running. By viewing VM host metrics, you can:

- Get alerts when your VMs are reaching their disk and CPU limits.
- Detect trends or patterns.
- Control your operational costs by sizing VMs according to usage and demand.

Azure automatically collects basic metrics for host VMs. In the Azure portal, you can see built-in graphs for several important VM host metrics, and configure many other metrics graphs. You can choose a specific metric and see graphs for that metric, or create customized graphs that show several metrics together.

:::image type="content" source="../media/2-vm-metrics-screenshot.png" alt-text="Screenshot showing CPU percentage usage and inbound flow chart." lightbox="../media/2-vm-metrics-screenshot.png":::

On a VM's **Overview** page in the Azure portal, you can view the following built-in metrics graphs for any Azure VM, and customize the displayed range from the past hour to the past 30 days.

- VM availability (preview)
- CPU usage percentage (average)
- OS disk usage (total)
- Network operations (total)
- Disk operations per second (average)

You can also use Azure Monitor Metrics Explorer to plot metrics charts, investigate changes, and visually correlate metrics trends for your VMs. With Metrics Explorer, you can:

- Plot multiple metrics on a graph to see how much traffic hits your VM and how the VM performs.
- Track the same metric over multiple VMs in a resource group or other scope, and use splitting to show each VM on the graph.
- Select flexible time ranges and granularity.
- Specify many other settings such as chart type and value ranges.
- Pin graphs to dashboards to quickly view server health and performance.
- Group metrics by time intervals, geographic regions, server clusters, or application components.

### Recommended alert rules

Azure Monitor alerts proactively notify you of specified occurrences and patterns in your VM host metrics. *Recommended alert rules* are a predefined set of alert rules based on common host metrics. These rules define CPU, memory, disk, and network usage levels to alert on, including VM availability, which alerts when the VM stops running.

You can quickly enable and configure recommended alert rules when you create an Azure VM, or afterwards from the VM's **Overview** page. You can also view, configure, and create custom alerts from the VM's **Alerts** page.

### Activity logs

Azure Monitor activity logs include information like VM startup or modifications. You can create diagnostic settings to send activity logs to the following destinations:

- Azure Monitor Logs, for more complex querying and alerting and for longer retention up to two years.
- Azure Storage, for cheaper, long-term archiving.
- Azure Event Hubs, to forward outside of Azure.

### Boot diagnostics

Boot diagnostics are host-level event monitoring you can use to help troubleshoot boot issues with your VMs. You enable boot diagnostics by default when you create a VM, or afterwards for an existing VM. Once you enable boot diagnostics, you can see screenshots from the VM's hypervisor for both Windows and Linux machines, and view the serial console log output of the VM boot sequence for Linux machines. Boot diagnostics stores data in a managed storage account.

## Guest OS, client workload, and application monitoring

To collect metrics and logs from guest OS and client workloads and applications, you install the Azure Monitor Agent on the VM and set up a data collection rule (DCR). Data collection rules define what data to collect and where to send that data. You can send the data to Azure Monitor Logs and Azure Monitor Metrics. Azure Monitor Metrics stores only metric data, but Azure Monitor Logs can store both metrics and performance counters.

### Monitor client performance by using VM Insights

VM Insights is a feature in Azure Monitor that helps get you started monitoring your VM clients by providing the following benefits:

- Simplified Azure Monitor Agent onboarding to enable monitoring a VM's guest OS and workloads.
- A preconfigured DCR that collects the most common performance counters for Windows and Linux.
- A set of predefined workbooks that show collected VM client metrics over time.
- Predefined trending performance charts and workbooks you can use to analyze core performance metrics from the VM's guest OS.
- Optional collection of the processes running on the VM, dependencies with other services, and a dependency map that displays interconnected components with other machines and external sources.

VM Insights creates a DCR that sends client VM performance counters to Azure Monitor Logs. Because the DCR sends its metrics to Azure Monitor Logs, you don't use Metrics Explorer to view the metrics data that VM Insights collects.

Prebuilt VM Insights workbooks show performance, connections, active ports, traffic, and other collected data from one or several VMs. You can edit the prebuilt workbook configurations or create your own custom workbooks. You can view VM Insights data directly from a single VM, or see a combined view of multiple VMs to view and assess trends and patterns across VMs.

VM Insights is especially useful for exploring overall VM usage when you don't yet know the metric of primary interest. Unlike other usage analytics tools, VM Insights workbooks let you combine multiple kinds of visualizations and analyses, such as CPU utilization, disk space, memory, and network dependencies.

### Collect client event logs

VM Insights creates a DCR that collects a specific set of performance counters. To collect other data, such as event logs, you can create a separate DCR that specifies the data you want to collect from the VM.

Azure Monitor Agent DCRs to send client performance counter data to both Azure Monitor Metrics and Azure Monitor Logs, but you can send event log data only to Azure Monitor Logs. Azure Monitor stores and analyzes logs in a Log Analytics workspace, where you can access them by using a log query written in Kusto Query Language (KQL).

