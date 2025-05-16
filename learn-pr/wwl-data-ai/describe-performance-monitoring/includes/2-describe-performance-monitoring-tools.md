Azure provides multiple methods to monitor the performance of your resources and create a baseline. Each method can be tailored for a specific metric. The metrics that you can monitor vary depending on the type of Azure resource you're monitoring. For example, Azure SQL Database and SQL Server on an Azure Virtual Machine have different metrics available in the Azure portal.

The following examples are focused on an Azure Virtual Machine. When you deploy an Azure Virtual Machine from Azure Marketplace, an agent is installed in the virtual machine that provides a basic set of operating system metrics that are presented to you in the Azure portal. This agent supplies metrics to a service called Azure Monitor, which is a comprehensive platform monitoring solution that collects and displays a standard set of metrics from Azure resources. If you're using a virtual machine, the default metrics captured include CPU usage, network utilization, and disk read and write operations. You can capture extra metrics beyond what is captured in Azure monitor by enabling Monitoring Insights for your virtual machine as shown in the following image.

![Screenshot of Azure monitor displaying logical disk performance, CPU Utilization, and Available memory.](../media/module-44-optimize-resources-final-01.png#lightbox)

These metrics pertain to the operating system, not SQL Server. Notice that the namespace for each metric is the virtual machine host, not SQL Server.

You're unable to view SQL Server-specific metrics from within the portal. For detailed SQL Server-specific metrics, you need to gather them from the virtual machine itself.

Azure Monitoring Insights allows you to collect extra data points like storage latency, available memory, and disk capacity. These Azure Monitor Insights can be one way of viewing a baseline of performance for your Azure Virtual Machine including I/O performance, memory, and CPU utilization. This data is stored in an Azure Log Analytics workspace. Azure Log Analytics is the primary tool in Azure for storing and querying log files of all kinds. Log Analytics is queried by a SQL-like language called Kusto Query Language (KQL).

If you create a virtual machine with one of the preconfigured SQL Server images in Azure Marketplace, you can also get the SQL virtual machine resource provider as shown in the following image.

![Screenshot of SQL VM resource provider.](../media/module-44-optimize-resources-final-02.png#lightbox)

You can launch this screen in the Azure portal by navigating to the **Settings** section of the main blade for an Azure Virtual Machine, and then selecting the **SQL Server configuration** option.

![Screenshot of directions to register with SQL IaaS Agent Extension.](../media/install-extension-img.png#lightbox)

This dashboard allows you to see how much space your database files and transaction log file are consuming, and allows you to manage the features provided by the resource provider like automated patching and storage configuration. You can manually install the SQL Resource Provider for other installations of SQL Server on Azure Virtual Machine that weren't defined as part of the virtual machine.

## Performance Monitor with SQL Server on an Azure Virtual Machine

Whether you're using an on-premises server or on an Azure Virtual Machine, the Windows Server platform has a native tool called Performance Monitor (commonly shortened to *perfmon* after the name of its executable file) that allows you to easily and routinely monitor performance metrics. *Perfmon* operates with counters for both the operating systems and installed programs. When SQL Server is installed on the operating system, the database engine creates its own group of specific counters.

![Screenshot of native Performance Monitor displaying the reporting interface, with a single counter being collected.](../media/module-44-optimize-resources-final-03.png#lightbox)

The image shows the reporting interface of Performance Monitor, with a single counter being collected. This screen is reached from launching Performance Monitor in Windows and shows a live tracker of a specific performance counter. In many cases, you capture multiple counters in the same session. *Perfmon* data can be stored locally and analyzed, but in larger environments you can forward performance monitor results into Azure Monitor, where you can have a single view across many servers.
