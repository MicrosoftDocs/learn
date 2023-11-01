Azure Monitor can collect data from various sources. You can think of the collected data as being categorized by tier. Tiers can include data collected from many sources, such as:
- Your application
- The operating system
- Services and resources used by your application
- The platform that supports your application

### Things to know about data collection

Review the following details about how Azure Monitor collects different categories of data.

- Azure Monitor begins collecting data as soon as you create your Azure subscription and add resources.

- When you create or modify resources, this data is stored in Azure Monitor activity logs.

- Performance data about resources, along with the amount of resources consumed, is stored as Azure Monitor metrics.

- Extend the data you're collecting by enabling diagnostics and adding Azure Monitor Agent to compute resources. By extending your data sources, you can collect data for the internal operation of the resources.
   
- Azure Monitor Agent also lets you configure different data sources to collect logs and metrics from Windows and Linux guest operating systems.

- Azure Monitor can collect log data from any REST client by using the Data Collector API. The Data Collector API lets you create custom monitoring scenarios and extend monitoring to resources that don't expose data through other sources.

#### Monitoring data tiers

The following table summarizes the tiers of monitoring data that are collected by Azure Monitor.

| Data tier | Description |
| --- | --- |
| **Application** | The Application tier contains monitoring data about the performance and functionality of your application code. This data is collected regardless of your platform. |
| **Guest OS** | Monitoring data about the operating system on which your application is running is organized into the Guest OS tier. Your application can run in Azure, another cloud, or on-premises. |
| **Azure resource** | The Azure resource tier holds monitoring data about the operation of any Azure resource you utilize, including consumption details for the resource. |
| **Azure subscription** | The Azure subscription tier contains monitoring data about the operation and management of your Azure subscription. The tier also contains data about the health and operation of Azure itself. |
| **Azure tenant** | Data about the operation of your tenant-level Azure services, such as Microsoft Entra ID, is organized into the Azure tenant tier. |
