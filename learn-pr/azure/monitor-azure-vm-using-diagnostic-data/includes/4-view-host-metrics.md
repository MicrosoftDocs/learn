Now that you've created your new virtual machine (VM), you'd like to assess its health quickly. You decide to save some metric charts to a new dashboard on the portal.

In this unit, you'll see how to build rich charts using the host-level metrics, and then pin these charts to a new health dashboard.

## Metrics available

Azure metrics are numerical values available from the Azure portal that help you understand the health, operation, and performance of your VMs. You can choose specific metrics and get a graph of that metric.

The following table lists the host-level metrics that are available.

|Kind  | Host-level metric  | Description  |
|---------|---------|---------|
| CPU     | CPU Credits Consumed [or Remaining]  | Number of credits consumed, or number of credits available to burst       |
|      | Percentage CPU        | Percentage of allocated compute units that are currently in use        |
| All Disks     | Disk Read [or Write] Bytes        | Bytes read [or written] from disk during monitoring period        |
|       | Disk Read [or Write] Operations/Sec        | Read [or write] IOPS during monitoring period        |
| OS Disk     | OS Disk Queue Depth        |  Length of the queue to be written to the OS disk (will increase when disk is being throttled)       |
|      | OS Disk Read [or Write] Bytes/Sec       | Read [or writes] from the OS disk during monitoring period in bytes per second       |
|      | OS Disk Read [or Write] Operations/Sec        |  Read [or writes] from the OS disk during monitoring period in IOPS       |
|      | Premium OS Disk Cache Read Hit [or Miss]       | How often is data read from cache versus the OS disk        |
| Data Disk     | Data Disk Queue Depth       | Length of the queue to be written to the data disk (will increase when disk is being throttled)         |
|      | Data Disk Read [or Write] Bytes/Sec       | Read [or writes] from the data disk during monitoring period in bytes per second        |
|      | Data Disk Read [or Write] Operations/Sec        | Read [or writes] from the data disk during monitoring period in IOPS        |
|      | Premium Data Disk Cache Read Hit [or Miss]      | How often is data read from cache versus the data disk        |
| Network     | Inbound [or Outbound] Flows        | Number of current flows in the inbound [or outbound] direction        |
|      | Network In [or Out] Billable        | Number of billable bytes received [or sent] on all network interfaces        |
|      | Network In [or Our] Total        |  Number of bytes received [or sent] on all network interfaces       |

You can choose multiple metrics and plot them on the graph to get a better understanding of the traffic hitting your web server. Azure also offers a flexible timeline range; you can choose options from the last 30 minutes to the last 30 days, or specify a custom range with any start and end date. Furthermore, you can specify a granularity from one minute to one month. This data enables you to see trends or patterns.

Azure metrics complement boot diagnostics. Boot diagnostics can display a screenshot of the boot sequence of the virtual machine, and you can view the serial log. Azure captures all these metrics without installing extensions on the VM. Remember that you do need to create a storage account to store the boot diagnostics data, boot screenshots, and logs).

## Overview graphs

You don't need to build metric graphs for your VM manually. The Azure portal creates four graphs for your VM that you view on the Overview page.

![Screenshot of the four graphs available from the Overview page](../media/4-default-graphs.png)

The Overview page also allows you to change the range of all the graphs with six options.

## KPI dashboard

You can have greater control, with more options, by creating a custom key performance indicator (KPI) dashboard for your VM, that still only uses the host-level metrics. The two graphs you'd want quick access to are:

- How hot is the VM - how much CPU is being used
- How busy is the VM - how much network traffic is the VM processing

![Screenshot of an example KPI dashboard, showing CPU max and Network total graphs](../media/4-KPI-dashboard.png)

You can reuse the prebuilt graph for network traffic. However, the average CPU usage isn't the most useful metric; the maximum CPU usage is a better metric to use. Navigate to the Monitor section of the VM, and using the metrics option, create a new maximum CPU graph and pin it to a new shared dashboard. Now that you have a KPI dashboard, you can return to the Overview page and pin the Network (total) graph to that dashboard. You can add more, but with these two graphs you have a quick way to view the performance of your VM. The dashboards also enable you to change the range shown on both graphs at the same time, with many more options than you have on the Overview page, including changing the timezone.

![Screenshot showing the dashboard range options](../media/4-dashboard-range-options.png)

The power of using a custom dashboard is increased when you have to monitor more than one VMs' performance. You can add graph for each VM, or use splitting to draw the same metric all on one graph.