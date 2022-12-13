When you migrate to the cloud, you'll want to make sense of all the data available from all your applications and data. All the monitored information flows into one common pot, from the whole Azure infrastructure. It comes from your applications but also your on-premises monitoring if that's available.

Using powerful tools you can make sense of the information. For example artificial intelligence and machine language tools can detect anomalies in the data and warn you if something is detected.

There are also lots of possible integrations with DevOps tools, ticketing system, Security Information and Event Management (SIEM) systems, IT Security Management (ITSM) systems and more.

## Azure Monitor explained

Azure Monitor is a service for collecting, analyzing, and acting on telemetry from your cloud and on-premises environments. Azure Monitor is used by IT Operations, DevOps, and developer teams to maximize the availability and performance of applications and services.

Azure Monitor provides a broad set of capabilities with a varying set of prerequisites depending on your specific monitoring goal. On one end of the spectrum, getting started with Azure Monitor metrics requires no incoming experience because metric collection is on by default for Azure resources. Viewing metrics in Metric Explorer is straightforward in the Azure portal UI.

## What can Azure Monitor do?

Azure Monitor isn't a single tool but a set of tools with each performing a specific set of functions. The tools included in Azure Monitor are Application Insights, VM Insights, Container insights, Log Analytics, and others.

* **Application Insights**: Application Insights monitors the availability, performance, and usage of your web applications whether they're hosted in the cloud or on-premises. It uses the powerful data analysis platform in Azure Monitor to provide you with deep insights into your application's operations. It enables you to diagnose errors without waiting for a user to report them.

* **Container Insights**: Container Insights monitors the performance of container workloads that are deployed to managed Kubernetes clusters hosted on Azure Kubernetes Service (AKS) and Azure Container Instances. It gives you performance visibility by collecting metrics from controllers, nodes, and containers that are available in Kubernetes through the Metrics API. Container logs are also collected.

* **VM Insights**: VM Insights monitors your Azure virtual machines (VM) at scale. It analyzes the performance and health of your Windows and Linux VMs and identifies their different processes and interconnected dependencies on external processes.

Here are some of the capabilities of this tool set

* Azure Monitor can collect performance and availability telemetry for all of the layers in your stack, from applications, infrastructure, the Azure platform, and any custom sources you integrate.

* Storage of the collected data in one of two data stores, Azure Monitor Metrics for numerical time-series values and Azure Monitor Logs for storing log data.

* Azure Monitor metrics are automatically collected and stored for Azure resources, but user configuration is required to send and store resource logs in Azure Monitor Logs.

* Azure Monitor includes Insights, which are out-of-the box monitoring and troubleshooting experiences for Azure resources. Available Insights include Azure Monitor VM insights, Azure Monitor application insights, and Azure Monitor container insights.

* Azure Monitor can be used to visualize data with workbooks and dashboards as well as analyze data with custom charts and analytics. Azure Monitor enables you to receive notification and take automated action based on performance and availability criteria.

With the data provided by Azure Monitor, you can detect issues before they become significant and find ways to optimize your app service so it performs at its peak at all times.
