# Use monitoring and analytics to gain operational insights

Lamna Healthcare is a national healthcare provider with several thousand physicians and clinicians across multiple facilities throughout the country. Their IT organization has recently undertaken an effort to exit their data center footprint and move the majority of their IT systems to Azure. They have a mixture of in-house developed applications open source and off-the-shelf applications, with varying architectures and technology platforms. They have invested a lot in high-availability where possible but last month they suffered an outage resulting in staff no longer able to create or update appointments with patients. Given the application was deployed in a high available setup this was a huge surprise to the IT staff. After performing a root cause analysis it became clear that one of the nodes in the two-node cluster become unhealthy weeks ago but it had gone unnoticed until the other node experienced a problem.

Lamna Healthcare is looking to implement the following services to ensure the various components of their services are monitored in an appropriate way.

![Monitoring overview](../media/3-use-monitoring-and-analytics-to-gain-operational-insights/monitoring-products-overview.png)

## Core monitoring

Core monitoring provides fundamental, required monitoring across Azure resources. These services require minimal configuration and collect core telemetry that the premium monitoring services use.

### Azure Monitor
[Azure Monitor](https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-azure-monitor) enables core monitoring for Azure services by allowing the collection of [metrics](https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-metrics), [activity logs](https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-activity-logs), and [diagnostic logs](https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-of-diagnostic-logs). For example, the activity log tells you when new resources are created or modified.

Metrics are available that provide performance statistics for different resources and even the operating system inside a virtual machine. You can view this data with one of the explorers in the Azure portal and create alerts based on these metrics. Azure Monitor provides the fastest metrics pipeline (5 minute down to 1 minute), so you should use it for time critical alerts and notifications.

You can also send these metrics and logs Azure Log Analytics for trending and detailed analysis, or create additional alert rules to proactively notify you of critical issues as a result of that analysis.  

### Azure Advisor
[Azure Advisor](https://docs.microsoft.com/en-us/azure/advisor/advisor-overview) constantly monitors your resource configuration and usage telemetry. It then gives you personalized recommendations based on best practices. Following these recommendations helps you improve the performance, security, and availability of the resources that support your applications.

### Service Health
The health of your application relies on the Azure services that it depends on. [Azure Service Health](https://docs.microsoft.com/en-us/azure/service-health/service-health-overview) identifies any issues with Azure services that might affect your application. Service Health also helps you plan for scheduled maintenance.

![Service Health](../media/3-use-monitoring-and-analytics-to-gain-operational-insights/azure-service-health-overview-2.png)

### Activity Log
[Activity Log](https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-activity-logs) provides data about the operation of an Azure resource. This information includes:

* Configuration changes to the resource.
* Service health incidents.
* Recommendations on better utilizing the resource.
* Information related to autoscale operations.

You can view logs for a particular resource on its page in the Azure portal. Or you can view logs from multiple resources in Activity Log Explorer.

You can also send activity log entries to Log Analytics. There, you can analyze the logs by using data collected by management solutions, agents on virtual machines, and other sources.

## Shared capabilities
The core and deep monitoring service share functionality which provides the following capabilities. 

### Alerts
[Azure alerts](https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-alerts) proactively notify you of critical conditions and potentially take corrective action. Alert rules can use data from multiple sources, including metrics and logs. They use [action groups](https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-action-groups), which contain unique sets of recipients and actions in response to an alert. Based on your requirements, you can have alerts start external actions by using webhooks and integrate with your ITSM tools.

### Dashboards
You can use [Azure dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards) to combine different kinds of data into a single pane in the [Azure portal](https://portal.azure.com). You can then share the dashboard with other Azure users.

For example, you can create a dashboard that combines:

* Tiles that show a graph of metrics
* A table of activity logs
* A usage chart from Application Insights
* The output of a log search in Log Analytics

You can also export Log Analytics data to [Power BI](https://docs.microsoft.com/power-bi/). There, you can take advantage of additional visualizations. You can also make the data available to others within and outside your organization.

## Deep monitoring services
The following Azure services provide rich capabilities for collecting and analyzing monitoring data at a deeper level. These services build on core monitoring and take advantage of common functionality in Azure. They provide powerful analytics with collected data to give you unique insights into your applications and infrastructure. They present data in the context of scenarios that are targeted to different audiences.

### Deep application monitoring
#### Application Insights
You can use [Azure Application Insights](http://azure.microsoft.com/documentation/services/application-insights) to monitor availability, performance, and usage of your application, whether it's hosted in the cloud or on-premises.

By instrumenting your application to work with Application Insights, you can achieve deep insights and implement DevOps scenarios. You can quickly identify and diagnose errors without waiting for a user to report them. With the information that you collect, you can make informed choices on your application's maintenance and improvements.

Application Insights has extensive tools for interacting with the data that it collects. Application Insights stores its data in a common repository. It can take advantage of shared functionality such as alerts, dashboards, and deep analysis with the Log Analytics query language.

### Deep infrastructure monitoring
#### Log Analytics
[Log Analytics](http://azure.microsoft.com/documentation/services/log-analytics) plays a central role in Azure monitoring by collecting data from a variety of resources (including non-Microsoft tools) into a single repository. There, you can analyze the data by using a powerful query language.

Application Insights and Azure Security Center store their data in the Log Analytics data store and use its analytics engine. Data is also collected from Azure Monitor, management solutions, and agents installed on virtual machines in the cloud or on-premises. This shared functionality helps you form a complete picture of your environment.

#### Management solutions
[Management solutions](https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-add-solutions) are packaged sets of logic that provide insights for a particular application or service. They rely on Log Analytics to store and analyze the monitoring data that they collect. 

Management solutions are available from Microsoft and partners to provide monitoring for various Azure and third-party services. Examples of monitoring solutions include:
* [Container Monitoring](https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-containers), which helps you view and manage your container hosts.
* [Azure SQL Analytics](https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-azure-sql), which collects and visualizes performance metrics for Azure SQL databases.

You can view all available management solutions in the Azure Portal under the *Monitor* screen. 

#### Network monitoring
There are several tools that work together to monitor various aspects of your network, whether in Azure or on-premises.  

[Network Watcher](https://docs.microsoft.com/en-us/azure/network-watcher/network-watcher-monitoring-overview) provides scenario-based monitoring and diagnostics for different network scenarios in Azure. It stores data in Azure metrics and diagnostics for further analysis. It works with the following solutions for monitoring various aspects of your network.

[Network Performance Monitor (NPM)](https://blogs.msdn.microsoft.com/azuregov/2017/09/05/network-performance-monitor-general-availability/) is a cloud-based network monitoring solution that monitors connectivity across public clouds, datacenters, and on-premises environments.

[ExpressRoute Monitor](https://azure.microsoft.com/blog/monitoring-of-azure-expressroute-in-preview/) is an  NPM capability that monitors the end-to-end connectivity and performance over Azure ExpressRoute circuits.

[DNS Analytics](https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-dns) is a solution that provides security, performance, and operations-related insights, based on your DNS servers.

[Service Endpoint Monitor](https://docs.microsoft.com/en-us/azure/networking/network-monitoring-overview) tests the reachability of applications and detects performance bottlenecks across on-premises, carrier networks, and cloud/private data centers.
