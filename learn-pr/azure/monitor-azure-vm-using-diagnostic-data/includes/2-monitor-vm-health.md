Azure Monitor allows you to view metrics on all of your Azure resources. 

Your band is on tour next month, so you need to identify which metrics you want to use to monitor the health of your virtual machines.

In this unit, you'll look at how to use Azure metrics to monitor the health of a virtual machine. You'll explore the different metrics available in Azure.

## Azure host-level metrics

Metrics are numerical values, available to view on the Azure portal, that helps you understand the health, operation, and performance of your virtual machines. You can choose a specific metric and get a graph of that metric.

You can get data such as:

- CPU usage
- Network traffic
- OS disk usage
- Boot success

Azure can collect these host-level metrics by default for hosted virtual machines without any additional software. To capture the boot diagnostics, you'll need to create, and associate, a storage account. You'll associate the storage account at the time you create your VM, or you can associate one later if you have an existing VM.

### Viewing metrics

You can choose multiple metrics and plot them on the graph to get an understanding of the amount of traffic that hits your web server, and how it performs. The Azure portal offers a flexible timeline range for graphs from the last 30 minutes, the last four hours, or going back for up to 30 days. This data shows trends or patterns, and you can choose the custom time range. Azure also lets you pin these graphs to your dashboard to view server health quickly.

![CPU percentage usage and  inbound flow chart](../media/vm-metrics-screenshot.png)

After you enable the metric, you can:

- Know when your virtual machines are reaching their disk and CPU limits.
- Detect trends.
- Control your operational costs by sizing according to usage and demand.

### Additional monitoring

To give you a full set of metrics, you'll need to install two utilities directly on the VM. The **Azure Diagnostics extension**, and the **Log Analytics agent**. Both utilities are available for Windows and Linux. The agents need a storage account to save the data they collect. After they've been installed, you can access near real-time metric alerts and:

- Investigate boot issues with enhanced boot diagnostics
- Archive logs and metrics for future analysis
- Autoscale virtual machine scale sets depending on virtual machine performance
- Get app-level metrics using Application Insights
- Automate OS updates
- Track VM configuration changes over time

You can install these extensions by using the Azure portal or Azure CLI.