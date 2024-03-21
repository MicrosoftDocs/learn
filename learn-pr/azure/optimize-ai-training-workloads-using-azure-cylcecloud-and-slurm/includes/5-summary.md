You've learned:

To run your AI training workload smoothly you must incorporate NHC’s, monitoring and log collection. NHC’s are very important as the size of the cluster is every changing and the complexity of each job can affect the performance of the cluster. It is key to ensure all nodes are healthy. Monitoring the cluster, nodes, and performance using built in monitoring tools can help visualize and understand the metrics of your cluster as it is running your AI workloads. You can monitor your cluster using tools like Prometheus + Grafana, and Slurm accounting. Just like monitoring, log collection can be utilized to set up alerts to aid in the quick resolution of issues. Azure log managed service can also be used for this purpose. 

**Node Health Checks:**

- Run Node Health Checks on all nodes to ensure they are healthy. This can be done on deployment of VMSS or new/replacement VMs.
- The frequency of health checks can vary. Some groups run only before or after jobs, while others run before and after jobs.
- All groups monitor some metric for performance to identify issues while a job is running (e.g. MFU, WPS, etc.).
- Monitoring nodes into dashboards and alerting is essential. 

**Monitoring:**

- Monitor cluster, node, and job performance using tools such as Moneo (Prometheus + Grafana), node_exporter, and dcgm-exporter.
- Utilize dashboards and built-in monitoring to check for issues, including Failed Node Health Checks and Gathered metrics exceeding workload-specific metrics.
- Slurm accounting is enabled (MariaDB is deployed and accessed by scheduler via a private endpoint). 

**Log Collection:**

- Collect logs and set up alerting to aid in quick resolution of issues.
- Azure Log Analytics managed service can be used for this purpose.

## Additional Resources to optimize your AI Workloads.

- [Azure CycleCloud Documentation - Azure CycleCloud | Microsoft Learn](https://learn.microsoft.com/azure/cyclecloud/?view=cyclecloud-8)
- [Help + support - Microsoft Azure](https://ms.portal.azure.com/) 
