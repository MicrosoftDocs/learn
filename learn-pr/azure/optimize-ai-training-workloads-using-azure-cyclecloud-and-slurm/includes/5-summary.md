The importance of incorporating Node Health Checks (NHCs), monitoring, and log collection to ensure the smooth running of AI training workloads. These tools can help ensure the health and performance of the cluster, provide valuable insights into the system’s metrics, and enable quick issue resolution through alert setups.

In this module, you’ve gained knowledge on how to integrate NHCs, monitoring, and log collection to ensure the smooth operation of your AI training workload. Given the ever-changing size of the cluster and the complexity of each task, NHCs are crucial for maintaining the performance of the cluster by ensuring the health of all nodes. Utilizing built-in monitoring tools to monitor the cluster, nodes, and performance can aid in visualizing and comprehending your cluster’s metrics while it processes your AI workloads. Tools such as Prometheus + Grafana, and Slurm accounting can be used for monitoring your cluster. Similarly, log collection can be employed to establish alerts that assist in swiftly resolving issues. Azure’s managed log service can also be leveraged for this purpose.

## Node health checks

NHCs play a pivotal role in preserving the health of nodes within a cluster, particularly considering the dynamic nature of the cluster size and the intricacy of each task. They are instrumental in verifying the proper operation of all nodes, which is critical for the cluster’s performance. The NHC can be executed during the deployment of Virtual Machine Scale Sets and on new or substitute VMs. The frequency of health checks can differ, occurring only before or after tasks, or both before and after tasks. It’s crucial to monitor nodes into dashboards and set up alerts. All groups keep an eye on performance metrics to spot issues while a task is in progress (for instance, MFU, WPS, etc.).
 
## Monitoring

Prometheus is an open-source monitoring system that Grafana supports out-of-the-box. It allows you to create dashboards to display system metrics for a server monitored by Prometheus. It helps visualize and understand the metrics of your cluster as it runs your AI workloads. Dashboards and built-in monitoring tools are helpful check for issues, including failed NHC and gathered metrics exceeding workload-specific metrics.

Slurm accounting is enabled (The scheduler deploys and accesses MariaDB through a private endpoint) and configured to collect accounting information for every job and job step executed. Accounting records are written to a simple text file or a database, providing information about both currently executing jobs and terminated jobs. It's useful for tracking resource usage and monitoring job performance.

## Log collection 

Azure Log Analytics managed service can be used for log collection to set up alerts, aiding in the quick resolution of issues. It’s part of Azure’s wide array of configurable security auditing and logging options. 

## Learn more

Read more about Azure AI Document Intelligence in the [service documentation](https://azure.microsoft.com/products/ai-services/ai-document-intelligence). 
