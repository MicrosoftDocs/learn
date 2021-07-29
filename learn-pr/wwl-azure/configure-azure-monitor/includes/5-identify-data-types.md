Azure Monitor can collect data from various sources. You can think of monitoring data for your applications in tiers ranging from your application, any operating system and services it relies on, down to the platform itself. Azure Monitor collects data from each of the following tiers:

 -  **Application monitoring data**: Data about the performance and functionality of the code you have written, regardless of its platform.
 -  **Guest OS monitoring data**: Data about the operating system on which your application is running. The application could be running in Azure, another cloud, or on-premises.
 -  **Azure resource monitoring data**: Data about the operation of an Azure resource.
 -  **Azure subscription monitoring data**: Data about the operation and management of an Azure subscription, as well as data about the health and operation of Azure itself.
 -  **Azure tenant monitoring data**: Data about the operation of tenant-level Azure services, such as Azure Active Directory.

Azure Monitor starts collecting data as soon as you create an Azure subscription and add resources. Activity Logs record when resources are created or modified. Metrics tell you how the resource is performing and the resources it is consuming.

Extend the data you're collecting into the actual operation of the resources by enabling diagnostics and adding an agent to compute resources. Extending your data sources will collect data for the internal operation of the resource. It will also let you configure different data sources to collect logs and metrics from Windows and Linux guest operating systems.

> [!NOTE]
> Azure Monitor can collect log data from any REST client using the Data Collector API. The Data Collector API lets you create custom monitoring scenarios and extend monitoring to resources that don't expose data through other sources.
