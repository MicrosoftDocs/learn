
VM insights provides a quick and easy method for getting started monitoring the client workloads on your virtual machines and virtual machine scale sets. It displays an inventory of your existing VMs and provides a guided experience to enable base monitoring for them. It also monitors the performance and health of your virtual machines and virtual machine scale sets by collecting data on their running processes and dependencies on other resources. VM insights monitors key operating system performance indicators related to processor, memory, network adapter, and disk utilization.
 
VM insights provides a set of predefined workbooks that allow you to view trending of collected performance data over time. You can view this data in a single VM from the virtual machine directly, or you can use Azure Monitor to deliver an aggregated view of multiple VMs.

VM insights includes a set of performance charts that target several key performance indicators to help you determine how well a virtual machine is performing. The charts show resource utilization over a period of time. You can use them to identify bottlenecks and anomalies. You can also switch to a perspective that lists each machine to view resource utilization based on the metric selected.

VM insights provides the following benefits beyond other features for monitoring VMs in Azure Monitor:

- Simplified onboarding of the Azure Monitor agent and the Dependency agent, so that you can monitor a virtual machine guest operating system and workloads.
- Pre-defined data collection rules that collect the most common set of performance data.
- Pre-defined trending performance charts and workbooks, so that you can analyze core performance metrics from the virtual machine's guest operating system.
- The Dependency map, which displays processes that run on each virtual machine and the interconnected components with other machines and external sources.

:::image type="content" source="../media/insights-unit-3.png" alt-text="Screenshot of Performance tab in VM Insights showing data for a VM and the Dependency map showing processes running the VM and interconnected components with other machines and external sources." border="true":::

## Enable VM insights

To enable VM Insights, select Insights from your virtual machine's menu in the Azure portal. If VM insights isn't enabled, you see a short description of it and an option to enable it. 

Select **Enable** to open the Monitoring configuration pane. Leave the default option of **Azure Monitor agent**.

Enabling VM insights creates a default data collection rule that doesn't include collection of processes and dependencies. To enable this collection, select **Create New** to create a new data collection rule.

You will be asked to provide a Data collection rule name and then select **Enable processes and dependencies (Map)**. You can't disable collection of guest performance because it's required for VM insights.

You can use the default Log Analytics workspace for the subscription unless you have another workspace that you want to use.

1. Select **Create** to create the new data collection rule. 
1. Select **Configure** to start VM insights configuration.

## View VM performance

When the deployment completes, you see views on the Performance tab in VM insights with performance data for the machine. This data shows you the values of key guest metrics over time.

By default, the charts show the last 24 hours. By using the TimeRange selector, you can query for historical time ranges of up to 30 days to show past performance.

The following capacity utilization charts are available:

- CPU Utilization %: Defaults show the average and top 95th percentile.
- Available Memory: Defaults show the average, top 5th, and 10th percentile.
- Logical Disk Space Used %: Defaults show the average and 95th percentile.
- Logical Disk IOPS: Defaults show the average and 95th percentile.
- Logical Disk MB/s: Defaults show the average and 95th percentile.
- Max Logical Disk Used %: Defaults show the average and 95th percentile.
- Bytes Sent Rate: Defaults show the average bytes sent.
- Bytes Receive Rate: Defaults show the average bytes received.

:::image type="content" source="../media/performance-unit-3.png" alt-text="Screenshot of the Performance tab in VM insights, displaying performance data for disk, CPU, memory, and disk IOPS." border="true":::

## View dependencies

In VM insights, you can view discovered application components on Windows and Linux virtual machines (VMs) that run in Azure or your environment. You can view a map directly from a VM. You can also view a map from Azure Monitor to see the components across groups of VMs. This unit helps you to understand these two viewing methods and how to use the Map feature.

The Map feature visualizes the VM dependencies by discovering running processes that have:

- Active network connections between servers.
- nbound and outbound connection latency.
- Ports across any TCP-connected architecture over a specified time range.

To access VM insights map directly from a VM:

1. In the Azure portal, select **Virtual Machines**.
1. From the list, select a VM. In the **Monitoring** section, select **Insights**.
1. Select the **Map** tab.

The map visualizes the VM's dependencies by discovering running process groups and processes that have active network connections over a specified time range.

By default, the map shows the last 30 minutes. If you want to see how dependencies looked in the past, you can query for historical time ranges of up to one hour. To run the query, use the TimeRange selector in the upper-left corner. You might run a query, for example, during an incident or to see the status before a change.

:::image type="content" source="../media/map-unit-3.png" alt-text="Screenshot of the Map tab in VM Insights showing a visual representation of ContosoVM1's dependencies between running process groups and processes that have active network connections over a specified time range." border="true":::

In Azure Monitor, the Map feature provides a global view of your VMs and their dependencies. To access the Map feature in Azure Monitor:

1. In the Azure portal, select **Monitor**.
1. In the Insights section, select **Virtual Machines**.
1. Select the **Map** tab.

If you have more than one Log Analytics workspace, choose the workspace that's enabled with the solution and that has VMs reporting to it.

The Group selector returns subscriptions, resource groups, computer groups, and virtual machine scale sets of computers that are related to the selected workspace. Your selection applies only to the Map feature and doesn't carry over to Performance or Health.

:::image type="content" source="../media/monitor-map-unit-3.png" alt-text="Screenshot of Map feature in Azure Monitor, displaying a global view of VMs and their dependencies." border="true":::























