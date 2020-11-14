After you connect to your cluster, you can use GitOps in the connected cluster, or you can use Azure Policy to manage the cluster.

## What is Azure Arc enabled Kubernetes?

Using Azure Arc, you can attach and then configure Kubernetes clusters, whether they're hosted on Azure or elsewhere. Similar to the way that you onboard servers to Azure Arc, you must also deploy agents to your Kubernetes clusters. The Kubernetes agent is responsible for:

- Connectivity to Azure.
- Collecting Azure Arc logs and metrics.
- Monitoring configuration requests.

After you deploy the agent, you can implement Azure Arc-enabled Kubernetes to:

- Support Kubernetes that's deployed outside Azure for inventorying, grouping, and tagging.
- Use GitOps-based configuration management to deploy applications and apply configurations.
- Use Azure Policy to apply policies to Kubernetes clusters.
- Use Azure Monitor for containers to display and monitor your clusters.


