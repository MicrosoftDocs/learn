
Like other Azure resources, AKS generates platform metrics and resource logs that you can use to monitor its basic health and performance.

:::image type="content" source="../media/kubernetes-azure-monitoring-logs-102ad3d1.png":::


### Azure Monitor

AKS natively integrates with Azure Monitor. Azure Monitor stores metrics and logs in a central location called a Log Analytics workspace. This data is processed and analyzed to provide insights and alerts.

[Container Insights](/azure/azure-monitor/containers/container-insights-overview) is the feature of Azure Monitor that collects, indexes, and stores the data your AKS cluster generates. You can configure Container Insights to monitor managed Kubernetes clusters hosted on AKS and other cluster configurations. Container Insights can monitor AKS health and performance with visualization tailored to Kubernetes environments. Enabling Container Insights for AKS cluster deploys a containerized version of the Log Analytics agent, which is responsible for sending data to your Log Analytics workspace.

### AKS cluster and workload monitoring

An AKS deployment can divide into cluster level components, managed AKS components, Kubernetes objects and workloads, applications, and external resources. The following table shows a common strategy for monitoring an AKS cluster and workload applications. Each level has distinct monitoring requirements.

| **Level**                        | **Description**                                                                                     | **Monitoring requirements**                                                                  |
| -------------------------------- | --------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| Cluster level components         | Virtual machine scale sets abstracted as AKS nodes and node pools.                                  | Node status and resource utilization including CPU, memory, disk, and network                |
| Managed AKS components           | AKS control plane components including API servers, cloud controller, and kubelet.                  | Control plane logs and metrics from the kube-system namespace                                |
| Kubernetes objects and workloads | Kubernetes objects such as deployments, containers, and replica sets.                               | Resource utilization and failures                                                            |
| Applications                     | Application workloads running on the AKS cluster.                                                   | Monitoring specific to architecture, but including application logs and service transactions |
| External                         | External resources that aren't part of AKS but are required for cluster scalability and management. | Specific to each component                                                                   |

 -  **Cluster level components:** You can use existing Container Insights views and reports to monitor cluster level components to understand their health, readiness, performance, CPU and memory resource utilization, and trends.
 -  **Managed AKS components:** You can use Metrics Explorer to view the **Inflight Requests** counter. This view includes request latency and work queue processing time.
 -  **Kubernetes objects and workloads:** You can use existing Container Insights views and reports to monitor deployment, controllers, pods, and containers. Use the **Nodes** and **Controllers** views to view the health and performance of the pods that are running on nodes and controllers, and their resource consumption in terms of CPU and memory.
 -  **Applications:** You can use [Application Insights](/azure/azure-monitor/app/app-insights-overview) to monitor applications that are running on AKS and other environments. Application Insights is an application performance management tool that provides support for many programming languages.
 -  **External components**: You can monitor external components like service mesh, ingress, and egress with Prometheus and Grafana or other tools.
