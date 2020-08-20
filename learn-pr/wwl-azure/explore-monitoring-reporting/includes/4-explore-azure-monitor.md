![Azure Monitor icon.](../media/icon-azure-monitor.png)

[Azure Monitor](https://azure.microsoft.com/services/monitor?azure-portal=true) maximizes the availability and performance of your applications by delivering a comprehensive solution for collecting, analyzing, and acting on telemetry from your cloud and on-premises environments. It helps you understand how your applications are performing and proactively identifies issues affecting them and the resources they depend on.



## What data does Azure Monitor collect?

Azure Monitor can collect data from a variety of sources. You can think of monitoring data for your applications in tiers ranging from your application, any operating system and services it relies on, down to the platform itself. Azure Monitor collects data from each of the following tiers:

+ **Application monitoring data**: Data about the performance and functionality of the code you have written, regardless of its platform.
+ **Guest OS monitoring data**: Data about the operating system on which your application is running. This could be running in Azure, another cloud, or on-premises. 
+ **Azure resource monitoring data**: Data about the operation of an Azure resource.
+ **Azure subscription monitoring data**: Data about the operation and management of an Azure subscription, as well as data about the health and operation of Azure itself. 
+ **Azure tenant monitoring data**: Data about the operation of tenant-level Azure services, such as Azure Active Directory.

## Diagnostic settings

As soon as you create an Azure subscription and start adding resources such as virtual machines and web apps, Azure Monitor starts collecting data.
+ **Activity Logs** record when resources are created or modified. 
+ **Metrics** tell you how the resource is performing and the resources that it's consuming.

## Enabling diagnostics

You can extend the data you're collecting into the actual operation of the resources by enabling **diagnostics** and adding an agent to compute resources. Under the resource settings you can enable Diagnostics

+ **Enable guest-level monitoring**
+ **Performance counters**: collect performance data
+ **Event Logs**: enable various event logs
+ **Crash Dumps**: enable or disable
+ **Sinks**: send your diagnostic data to other services for more analysis
+ **Agent**: configure agent settings

