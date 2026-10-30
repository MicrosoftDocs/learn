In this unit, you explore Azure monitoring capabilities for VMs, and the types of monitoring data you can collect and analyze with Azure Monitor. Azure Monitor is a comprehensive monitoring solution for collecting, analyzing, and responding to monitoring data from Azure and non-Azure resources, including VMs. Azure Monitor has two main monitoring features: Azure Monitor Metrics and Azure Monitor Logs.

Metrics are numerical values collected at predetermined intervals to describe some aspect of a system. Metrics can measure VM performance, resource utilization, error counts, user responses, or any other aspect of the system that you can quantify. Azure automatically collects a predefined set of platform metrics for every Azure VM. Azure Monitor Metrics retains most platform metrics for 93 days.

Logs are timestamped records that contain different types of structured or free-form data, including events and performance measurements. Azure automatically records activity logs for Azure resources. This data is available at the resource level. Guest logs aren't collected by default; you configure their collection separately. Azure Monitor Logs stores log data in a Log Analytics workspace for querying and analysis.

## VM monitoring layers

Azure VMs have several layers that require monitoring. Each of the following layers has a distinct set of telemetry and monitoring requirements.

- Host VM
- Guest operating system (OS)
- Client workloads
- Applications that run on the VM

:::image type="content" source="../media/monitoring-layers.png" alt-text="Diagram that shows fundamental VM architecture." border="false":::

## Host VM monitoring

The VM host represents the compute, storage, and network resources that Azure allocates to the VM.

### VM host metrics

VM host metrics measure technical aspects of the VM such as processor utilization and whether the machine is running. You can use VM host metrics to:

- Trigger an alert when your VM is reaching its disk or CPU limits.
- Identify trends or patterns.
- Control your operational costs by sizing VMs according to usage and demand.

Azure automatically collects basic metrics for VM hosts. On the VM's **Overview** page in the Azure portal, the **Monitoring** tab includes built-in platform metrics graphs. Metrics Explorer provides access to additional host metrics, including:

- VM availability
- **Percentage CPU**: allocated compute utilization; use Average to view average utilization.
- **Disk Read Bytes** and **Disk Write Bytes**: bytes transferred during the measurement period; use Total/Sum.
- **Network In Total** and **Network Out Total**: bytes received and sent across the VM's network interfaces; use Total/Sum.
- Disk operations per second (average)

> [!NOTE]
> Disk I/O isn't filesystem occupancy. To investigate a full filesystem, collect guest logical-disk measurements with Azure Monitor Agent and inspect free/used space for the relevant Linux mount point. See the [guest free-disk query](/azure/azure-monitor/reference/queries/insightsmetrics#virtual-machine-free-disk-space).

For metric names, units, and supported aggregations, see the [VM metric definitions](/azure/azure-monitor/reference/supported-metrics/microsoft-compute-virtualmachines-metrics).

You can use Azure Monitor Metrics Explorer to plot more metrics graphs, investigate changes, and visually correlate metrics trends for your VMs. With Metrics Explorer you can:

- Plot multiple metrics on a graph to see how much traffic hits your VM and how the VM performs.
- Track the same metric over multiple VMs of the same resource type in the same subscription and region. In the classic multi-resource view, use splitting by resource ID to compare individual VMs, or by resource group where available.
- Select flexible time ranges and granularity.
- Specify many other settings such as chart type and value ranges.
- Send graphs to workbooks or pin them to dashboards for quickly viewing health and performance.

Filtering and splitting within a metric depend on the dimensions that metric exposes. **Percentage CPU** and **Inbound Flows** don't provide geographic-region, server-cluster, or application-component dimensions. Use an appropriately configured workbook or query for analyses that combine other scopes or telemetry. For more information, see [Metrics Explorer scope and dimensions](/azure/azure-monitor/metrics/analyze-metrics).

:::image type="content" source="../media/2-vm-metrics-screenshot.png" alt-text="Screenshot of CPU percentage usage and inbound flow charts." lightbox="../media/2-vm-metrics-screenshot.png":::

### Recommended alert rules

Alerts proactively notify you of specified occurrences and patterns in your VM host metrics. *Recommended alert rules* are a predefined set of alert rules based on commonly monitored host metrics. These rules define recommended CPU, memory, disk, and network usage levels to alert on. The rules also include VM availability, which can alert when the metric reports that a VM is unavailable.

> [!NOTE]
> Stopping a VM through the Azure portal, CLI, or PowerShell stops availability metric emission and produces null values rather than `0`. Don't rely on an availability threshold alert to notify you of those operations. If you need notifications for control-plane stop or deallocate operations, configure [activity log alerts](/azure/azure-monitor/alerts/alerts-create-activity-log-alert-rule) for the relevant operations and statuses. These supplement, rather than replace, availability alerts.

You can quickly enable and configure recommended alert rules when you create an Azure VM, or afterwards from the VM's portal page. You can also view, configure, and create custom alerts by using Azure Monitor Alerts.

### Activity logs

Azure Monitor automatically records and displays activity logs for Azure VMs. Activity logs include information like VM startup or modifications. You can create diagnostic settings to send activity logs to the following destinations:

- **Azure Monitor Logs:** For more complex querying and alerting, and analytics retention up to two years. Exported activity logs can have total retention up to 12 years; use a search job to retrieve data beyond analytics retention.
- **Azure Storage:** For cheaper, long-term archiving.
- **Azure Event Hubs:** To forward outside of Azure.

### Boot diagnostics

Boot diagnostics are host logs you can use to help troubleshoot boot issues with your VMs. You can enable boot diagnostics by default when you create a VM, or afterwards for existing VMs.

Once you enable boot diagnostics, you can see screenshots from the VM's hypervisor for both Windows and Linux machines, and view the serial console log output of the VM boot sequence for Linux machines. Boot diagnostics stores data in a managed storage account.

## Guest OS, client workload, and application monitoring

VM client monitoring can include monitoring the operating system (OS), workloads, and applications that run on the VM. To collect the guest performance data and Linux Syslog events in this module, install Azure Monitor Agent (AMA) and associate data collection rules (DCRs) with the VM. AMA also requires a managed identity and connectivity to the monitoring service. Application telemetry can require separate application instrumentation.

DCRs define what supported guest data to collect and where to send it. This module uses logs-based VM insights performance data in **InsightsMetrics** and Linux Syslog events in **Syslog**, both in the same explicitly selected **Log Analytics workspace**, where you use Kusto Query Language (KQL). A separate performance-counter DCR can send additional counters to **Perf**.

The generally available OpenTelemetry metrics-based path is the recommended metrics experience for new VM deployments. It sends guest metrics to an **Azure Monitor workspace** for PromQL analysis. This isn't a Log Analytics workspace, and those metrics don't automatically populate **InsightsMetrics**. Logs-based monitoring remains supported and is selected in this module for the KQL exercises. See the [monitoring experience comparison](/azure/azure-monitor/vm/metrics-opentelemetry-guest#compare-experiences).

The OpenTelemetry path is also distinct from the resource-associated **Azure Monitor Metrics (preview)** performance-counter destination. See [additional performance-counter destinations](/azure/azure-monitor/vm/data-collection-performance#add-destination).

### VM insights

VM insights is an Azure Monitor feature that helps get you started monitoring your VM clients. VM insights is especially useful for exploring overall VM usage and performance when you don't yet know the metric of primary interest. In this module, logs-based VM insights provides:

- Simplified Azure Monitor Agent onboarding to enable monitoring a VM's guest OS and workloads.
- A predefined performance DCR that collects guest measurements into **InsightsMetrics**.
- Performance views for exploring guest CPU, memory, and logical-disk measurements.
- Workbooks that visualize collected guest performance data over time.

You can view performance data from a single VM or use combined views to assess trends across multiple VMs. You can edit prebuilt workbook configurations or create custom workbooks. A workbook visualizes the data already collected; it doesn't itself install an agent or start collecting another data source.

> [!NOTE]
> VM insights Map and Dependency Agent are deprecated, with retirement scheduled for 30 June 2028. New portal onboarding is restricted. This module doesn't enable Map or install Dependency Agent, and AMA performance monitoring is unaffected. See the [Map lifecycle guidance](/azure/azure-monitor/vm/vminsights-maps-retirement). Application dependency visualization requires a separately configured solution such as an [instrumented Application Insights application](/azure/azure-monitor/app/app-map); it isn't a drop-in replacement for host-process discovery.

### Linux guest event data

The predefined logs-based VM insights performance DCR doesn't automatically collect Linux Syslog events. Keep that performance DCR intact and create a separate Linux Syslog DCR for the Ubuntu VM in this module. Select the facilities and severity thresholds to collect, and send the events to the same Log Analytics workspace used for performance data. Analyze the events in the **Syslog** table with KQL. For more information, see [Syslog collection](/azure/azure-monitor/vm/data-collection-syslog).
