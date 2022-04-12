## Design for Azure workbooks

Workbooks provide a flexible canvas for data analysis and the creation of rich visual reports within the Azure portal. They allow you to tap into multiple data sources from across Azure and combine them into unified interactive experiences. Authors of workbooks can transform this data to provide insights into the availability, performance, usage, and overall health of the underlying components. For instance, analyzing performance logs from virtual machines to identify high CPU or low memory instances and displaying the results as a grid in an interactive report.

Workbooks are currently compatible with the following data sources:

- [Logs](/azure/azure-monitor/visualize/workbooks-data-sources)

- [Metrics](/azure/azure-monitor/visualize/workbooks-data-sources)

- [Azure Resource Graph](/azure/azure-monitor/visualize/workbooks-data-sources)

- [Alerts](/azure/azure-monitor/visualize/workbooks-data-sources)

- [Workload Health](/azure/azure-monitor/visualize/workbooks-data-sources)

- [Azure Resource Health](/azure/azure-monitor/visualize/workbooks-data-sources)

- [Azure Data Explorer](/azure/azure-monitor/visualize/workbooks-data-sources)

 

But the real power of workbooks is the ability to combine data from disparate sources within a single report. This allows for the creation of composite resource views or joins across resources enabling richer data and insights that would otherwise be impossible. 

Customers use workbooks in several ways—exploring the usage of an app, going through a root cause analysis, and putting together an operational playbook, for example.

How would you leverage Azure workbooks for Tailwind Traders? What recommendations would you have based on their Azure environment and business needs? 

## Design for Azure Insights 

The reputation of your organization depends on the performance, reliability, and security of its systems. It's critical to monitor your systems closely to identify any performance problems or attacks before they can affect users. For example, if your payment system is unable to process user transactions during a high-volume holiday sales period, your customers will likely lose confidence in your business. Designing insights as a part of your overall architecture will help identify performance issues. 

### Insights

Insights provide a customized monitoring experience for particular applications and services. They collect and analyze both logs and metrics. Here are just a few of the insights that are provided. 

| **Insight**| **Description** |
| - | - |
| [Application Insights](/azure/azure-monitor/app/app-insights-overview)| Extensible Application Performance Management (APM) service to monitor your live web application on any platform. |
| [Container insights](/azure/azure-monitor/containers/container-insights-overview)| Monitors the performance of container workloads deployed to either Azure Container Instances or managed Kubernetes clusters hosted on Azure Kubernetes Service (AKS). |
| [Cosmos DB insights](/azure/azure-monitor/insights/cosmosdb-insights-overview)| Provides information on the overall performance, failures, capacity, and operational health of all your Azure Cosmos DB resources in a unified interactive experience. |
| [Networks insights](/azure/azure-monitor/insights/network-insights-overview)| Provides comprehensive information on the health and metrics for all your network resource. The advanced search capability helps you identify resource dependencies, enabling scenarios like identifying resource that are hosting your website, by simply searching for your website name. |
| [Resource Group insights](/azure/azure-monitor/insights/resource-group-insights)| Triage and diagnose any problems your individual resources encounter, while offering context as to the health and performance of the resource group as a whole. |
| [Storage insights](/azure/storage/common/storage-insights-overview?toc=/azure/azure-monitor/toc.json)| Provides comprehensive monitoring of your Azure Storage accounts by delivering a unified report of your Azure Storage services performance, capacity, and availability. |
| [VM insights](/azure/azure-monitor/vm/vminsights-overview)| Monitors your Azure virtual machines (VM) and virtual machine scale sets at scale. It analyzes the performance and health of your Windows and Linux VMs, and monitors their processes and dependencies on other resources and external processes. |
| [Key Vault insights](/azure/azure-monitor/insights/key-vault-insights-overview)| Provides comprehensive monitoring of your key vaults by delivering a unified report of your Key Vault requests, performance, failures, and latency. |
| [Azure Cache for Redis insights](/azure/azure-monitor/insights/redis-cache-insights-overview)| Provides a unified, interactive report of overall performance, failures, capacity, and operational health. |


 

### Use Application Insights to:

- Analyze and address issues and problems that affect your application's health and performance.

- Improve your application's development lifecycle.

- Measure your user experience and analyze users' behavior.

Application Insights is aimed at the development team, to help you understand how your app is performing and how it's being used. It monitors:

- **Request rates, response times, and failure rates** - Find out which pages are most popular, at what times of day, and where your users are. Determine which pages perform best. If your response times and failure rates go high when there are more requests, then perhaps you have a resourcing problem.

- **Dependency rates, response times, and failure rates** - Find out whether external services are slowing you down.

- **Exceptions** - Analyze the aggregated statistics, or pick specific instances and drill into the stack trace and related requests. Both server and browser exceptions are reported.

- **Page views and load performance** - reported by your users' browsers.

- **AJAX calls** from web pages - rates, response times, and failure rates.

- **User and session counts**.

- **Performance counters** from your Windows or Linux server machines, such as CPU, memory, and network usage.

- **Host diagnostics** from Docker or Azure.

- **Diagnostic trace logs** from your app - so that you can correlate trace events with requests.

- **Custom events and metrics** that you write yourself in the client or server code, to track business events such as items sold or games won.

 

### Use Azure Monitor VM insights to:

- View the health and performance of your VMs

- Monitor your VMs at-scale across multiple subscriptions and resource groups.

- Want a topology view that shows the processes, and network connection details of your VMs and scale sets.

- Insights supports Azure virtual machines and scale sets

- Hybrid virtual machines connected with Azure Arc

- On-premises virtual machines

- Virtual machines hosted in another cloud environment

 

### Use Azure Monitor container insights to:

- View the health and performance of your Kubernetes workloads at-scale across multiple subscriptions and resource groups.

- Want visibility into memory and processor performance metrics from controllers, nodes, and containers.

- Want view and store container logs for real time and historical analysis.

- Identify AKS containers that are running on the node and their average processor and memory utilization. This knowledge can help you identify resource bottlenecks.

- Identify processor and memory utilization of container groups and their containers hosted in Azure Container Instances.

- Identify where the container resides in a controller or a pod. This knowledge can help you view the controller's or pod's overall performance.

- Review the resource utilization of workloads running on the host that are unrelated to the standard processes that support the pod.

- Understand the behavior of the cluster under average and heaviest loads. This knowledge can help you identify capacity needs and determine the maximum load that the cluster can sustain.

- Configure alerts to proactively notify you or record it when CPU and memory utilization on nodes or containers exceed your thresholds, or when a health state change occurs in the cluster at the infrastructure or nodes health rollup.

- Integrate with [Prometheus](https://prometheus.io/docs/introduction/overview/) to view application and workload metrics it collects from nodes and Kubernetes using [queries](/azure/azure-monitor/containers/container-insights-log-query) to create custom alerts, dashboards, and perform detailed analysis.

- Monitor container workloads [deployed to AKS Engine](https://github.com/Azure/aks-engine) on-premises and [AKS Engine on Azure Stack](/azure-stack/user/azure-stack-kubernetes-aks-engine-overview).

- Monitor container workloads [deployed to Azure Red Hat OpenShift](/azure/openshift/intro-openshift).

- Monitor container workloads [deployed to Azure Arc enabled Kubernetes](/azure/azure-arc/kubernetes/overview).

