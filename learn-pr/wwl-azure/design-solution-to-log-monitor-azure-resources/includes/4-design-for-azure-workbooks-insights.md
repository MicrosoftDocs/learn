Azure Workbooks is a feature of Azure Monitor. Workbooks provide a flexible canvas for data analysis and the creation of rich visual reports within the Azure portal. Customers use Workbooks to explore the usage of an app, to do root cause analysis, put together an operational playbook, and many other tasks.

The real power of Workbooks is the ability to combine data from disparate sources within a single report. You can create composite resource views or joins across resources enabling richer data and insights that would otherwise be impossible. 

### Things to know about Azure Workbooks

Tailwind Traders would like to use Azure Workbooks in its monitoring strategy. Think about how the following characteristics of Workbooks.

- Azure Workbooks lets you tap into multiple data sources from across Azure and combine them into unified interactive experiences. 

- Authors of workbooks can transform ingested data to provide insights into the availability, performance, usage, and overall health of the underlying components.

- You can analyze performance logs from virtual machines to identify high CPU or low memory instances and display the results as a grid in an interactive report.

- Workbooks are currently compatible with the following data sources:
   - [Logs](/azure/azure-monitor/visualize/workbooks-data-sources)
   - [Metrics](/azure/azure-monitor/visualize/workbooks-data-sources)
   - [Azure Resource Graph](/azure/azure-monitor/visualize/workbooks-data-sources)
   - [Alerts](/azure/azure-monitor/visualize/workbooks-data-sources)
   - [Workload Health](/azure/azure-monitor/visualize/workbooks-data-sources)
   - [Azure Resource Health](/azure/azure-monitor/visualize/workbooks-data-sources)
   - [Azure Data Explorer](/azure/azure-monitor/visualize/workbooks-data-sources)

### Azure insights and Workbooks

The reputation of your organization depends on the performance, reliability, and security of its systems. It's critical to monitor your systems closely to identify any performance problems or attacks before they can affect users. If your payment system can't process user transactions during a high-volume holiday sales period, your customers might lose confidence in your business. 

For an effective monitoring solution, combine Azure insights about your resources and apps with Azure Workbooks.

### Things to know about Azure insights

Azure insights can help you identify performance issues in the Tailwind Traders architecture. Consider these characteristics about insights:

- Azure insights provide a customized monitoring experience for particular applications and services.

- Azure insights collect and analyze both logs and metrics. 

- Many insights are provided as features of Azure Monitor. Here are some examples:

   | Insight | Description |
   | --- | --- |
   | [Application Insights](/azure/azure-monitor/app/app-insights-overview)| Monitor your live web application on any platform by using this extensible Application Performance Management (APM) service that's available in Azure Monitor. |
   | [Container insights](/azure/azure-monitor/containers/container-insights-overview)| Check the performance of container workloads deployed to either Azure Container Instances or managed Kubernetes clusters hosted on Azure Kubernetes Service (AKS). |
   | [Networks insights](/azure/azure-monitor/insights/network-insights-overview)| Obtain comprehensive information on the health and metrics for all your network resources. Use the advanced search capability to identify resource dependencies. Searching by your website name to locate resources that host your website. |
   | [Resource group insights](/azure/azure-monitor/insights/resource-group-insights)| Triage and diagnose any problems your individual resources encounter, while offering context as to the health and performance of the resource group as a whole. |
   | [Virtual machine insights](/azure/azure-monitor/vm/vminsights-overview)| Monitor your Azure Virtual Machines, Virtual Machine Scale Sets, and other virtual machines. Analyze the performance and health of your Windows and Linux Virtual Machines, and monitor their processes and dependencies on other resources and external processes. |   
   | [Azure Cache for Redis insights](/azure/azure-monitor/insights/redis-cache-insights-overview)| Review a unified, interactive report of overall performance, failures, capacity, and operational health. |   
   | [Azure Cosmos DB insights](/azure/azure-monitor/insights/cosmosdb-insights-overview)| Get information on the overall performance, failures, capacity, and operational health of all your Azure Cosmos DB resources in a unified interactive experience. |  
   | [Azure Key Vault insights](/azure/azure-monitor/insights/key-vault-insights-overview)| Monitor your key vaults by using a unified report of your Key Vault requests, performance, failures, and latency. |    
   | [Azure Storage insights](/azure/storage/common/storage-insights-overview?toc=/azure/azure-monitor/toc.json)| Do comprehensive monitoring of your Storage accounts via a unified report of your Storage performance, capacity, and availability. |

### Things to consider when using Azure insights and Workbooks 

Tailwind Traders is interested in using Azure insights and Workbooks in their monitoring strategy. What recommendations would you suggest based on their Azure environment and business needs? Consider these points as you prepare your plan.

- **Consider Azure Workbooks**. Explore how Tailwind Traders apps can be used with Azure Workbooks. Investigate the root cause analysis of incidents, and put together an operational playbook for your team.

- **Consider Azure insights and data analysis**. Include Azure insights for a custom monitoring experience for Tailwind Traders apps and services. Review insights about your network, VMs, and other Azure resources. Collect Logs and Metrics data from Workbooks and analyze the data. 

- **Consider combined data sources and visual reporting**. Combine data from Tailwind Traders sources in a single report. Create composite resource views for more robust data and greater insights. Prepare rich visual reports within the Azure portal.