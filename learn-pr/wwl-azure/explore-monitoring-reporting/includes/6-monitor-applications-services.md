Data monitoring is only useful if it improves your visibility of the operations in your computing environment. **Azure Monitor** includes several features and tools that provide valuable insights into your applications, and the other resources they may depend on. Monitoring solutions and features, such as **Application Insights** and **Container Insights**, provide you with a deeper look into different aspects of your application and Azure services.

Azure Monitor features can be organized into four categories, these categories are: **Analyze**, **Respond**, **Visualize** and **Integrate**.


## Analyze

+ **Application Insights** is a service that monitors the availability, performance, and usage of your web applications, whether they're hosted in the cloud or on-premises. It leverages the powerful data analysis platform in Log Analytics to provide you with deeper insights into your application's operations.  Application Insights can diagnose errors, without waiting for a user to report them. Application Insights includes connection points to a variety of development tools and integrates with Microsoft Visual Studio to support your DevOps processes.

+ **Azure Monitor for containers** is a service that is designed to monitor the performance of container workloads, which are deployed to managed Kubernetes clusters hosted on Azure Kubernetes Service (AKS). It gives you performance visibility by collecting memory and processor metrics from controllers, nodes, and containers, which are available in Kubernetes through the metrics API. Container logs are also collected.

+ **Azure Monitor for VMs** is a service that monitors your Azure VMs at scale, by analyzing the performance and health of your Windows and Linux VMs (including their different processes and interconnected dependencies on other resources, and external processes). Azure Monitor for VMs includes support for monitoring performance and application dependencies for VMs hosted on-premises, and for VMs hosted with other cloud providers.

Integrating any, or all, of these monitoring services with Azure Service Health has additional benefits. Staying informed of the health status of Azure services will help you understand if, and when, an issue affecting an Azure service is impacting your environment. What may seem like a localized problem could be the result of a more widespread issue, and Azure Service Health provides this kind of insight. Azure Service Health identifies any issues with Azure services that might affect your application. Azure Service Health also helps you to plan for scheduled maintenance.

## Respond

In addition to allowing you to analyze your monitoring data interactively, an effective monitoring solution must respond proactively to any critical conditions that are identified within the data it collects. This might involve, for example, sending a text or email to an administrator who is responsible for investigating an issue, or launching an automated process that attempts to correct an error condition.

+ **Alerts**. Azure Monitor proactively notifies you of critical conditions using Alerts and can potentially attempt to take corrective actions. Alert rules based on metrics can provide alerts in almost real-time, based on numeric values.  Alert rules based on logs allow for complex logic across data, from multiple sources.

+ **Autoscale**. Azure Monitor uses Autoscale to ensure that you have the right amount of resources running to manage the load on your application effectively. Autoscale enables you to create rules that use metrics, collected by Azure Monitor, to determine when to automatically add resources to handle increases in load. Autoscale can also help reduce your Azure costs by removing resources that are not being used. You can specify a minimum and maximum number of instances and provide the logic that determines when Autoscale should increase or decrease resources.


## Visualize

Visualizations, such as charts and tables, are effective tools for summarizing monitoring data and for presenting data to different audiences. Azure Monitor has its own features for visualizing monitoring data, and it leverages other Azure services for publishing data for different audiences. Other tools you may use for visualizing data, for specific audiences and scenarios, include:

+ **Dashboards**
+ **Views**
+ **Power BI**


## Integrate

You'll often need to integrate Azure Monitor with other systems, and build customized solutions that use your monitoring data. Other Azure services can work with Azure Monitor to provide this integration.
