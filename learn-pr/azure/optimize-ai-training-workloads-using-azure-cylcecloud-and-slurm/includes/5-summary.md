The importance of incorporating Node Health Checks (NHCs), monitoring, and log collection to ensure the smooth running of AI training workloads. These tools can help ensure the health and performance of the cluster, provide valuable insights into the system’s metrics, and enable quick issue resolution through alert setups.

In this module, you learned as how to incorporate NHCs, monitoring and log collection to run your AI training workload smoothly. NHCs are important as the size of the cluster is every changing and the complexity of each job can affect the performance of the cluster. It is key to ensure all nodes are healthy. Monitoring the cluster, nodes, and performance using built in monitoring tools can help visualize and understand the metrics of your cluster as it's running your AI workloads. You can monitor your cluster using tools like Prometheus + Grafana, and Slurm accounting. Just like monitoring, log collection can be utilized to set up alerts to aid in the quick resolution of issues. Azure log managed service can also be used for this purpose.

**Node Health Checks:**

NHCs are crucial for maintaining the health of the nodes in a cluster, especially given the ever-changing size of the cluster and the complexity of each job. NHCs help ensure that all nodes are functioning correctly, which is vital for the performance of the cluster. You can run the NHC on deployment of Virtual Machine Scale Sets and on new or replacement VMs. The frequency of health checks can vary, running only before or after the jobs, or running before and after the jobs. Monitoring nodes into dashboards and alerting is essential. All the groups monitor performance metrics to identify issues while a job is running (for example, MFU, WPS, etc.).
 
**Monitoring:**

Prometheus is an open-source monitoring system that Grafana supports out-of-the-box. It allows you to create dashboards to display system metrics for a server monitored by Prometheus. It helps visualize and understand the metrics of your cluster as it runs your AI workloads. Dashboards and built-in monitoring tools are helpful check for issues, including failed NHC and gathered metrics exceeding workload-specific metrics.

Slurm accounting is enabled (The scheduler deploys and accesses MariaDB via a private endpoint) and configured to collect accounting information for every job and job step executed. Accounting records are written to a simple text file or a database, providing information about both currently executing jobs and terminated jobs. It's useful for tracking resource usage and monitoring job performance.

**Log Collection:** 

Azure Log Analytics managed service can be used for log collection to set up alerts, aiding in the quick resolution of issues. It’s part of Azure’s wide array of configurable security auditing and logging options. 

## Learn more

Read more about Azure AI Document Intelligence in the [service documentation](https://azure.microsoft.com/products/ai-services/ai-document-intelligence). 
