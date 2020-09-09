Contoso currently host a number of Kubernetes clusters in a datacenter in London. They want to be able to manage these resources using a consistent collection of tools and processes. In addition to managing servers, Contoso could use Azure Arc to configure Kubernetes clusters. These clusters can be hosted on Azure or elsewhere.

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

## Connect an Azure Arc-enabled Kubernetes cluster

To connect a Kubernetes cluster to Azure Arc, you connect it to the `Azure-arc` namespace. To complete this task, you must perform the following high-level steps:

1. Meet the prerequisites. You'll need:
    - An existing Kubernetes cluster.
    - A `kubeconfig` file. You need this file to access the cluster and Cluster-admin role on the cluster for deployment of Azure Arc-enabled Kubernetes agents.
    - Membership of the Kubernetes Cluster - Azure Arc Onboarding role.
    - To install Helm 3.
    - To install the Azure Arc-enabled Kubernetes command-line interface (CLI) extensions.
    - To meet a number of [network requirements](https://docs.microsoft.com/azure/azure-arc/kubernetes/connect-cluster#network-requirements?azure-portal=true).
2. Register the two providers for Azure Arc-enabled Kubernetes.
3. Create a resource group, unless you already have one.
4. Connect a cluster by using the `az connectedk8s connect` Azure CLI command.
5. Verify the connection with the `az connectedk8s list` command.

## Azure Arc agents for Kubernetes

Azure Arc-enabled Kubernetes provides a number of agents. These agents run in the Kubernetes cluster that you deploy to the `azure-arc` namespace. The following table describes these agents.

|Agent|Description|
|---|---|
|`deployment.apps/config-agent`|Monitors the connected cluster for updates, compliance state, and source control configuration resources applied on the cluster.|
|`deployment.apps/controller-manager`|Orchestrates interactions between Azure Arc components.|
|`deployment.apps/metrics-agent`|Collects metrics from other Azure Arc agents to optimize the performance of these other agents.|
|`deployment.apps/cluster-metadata-operator`|Gathers cluster metadata, including cluster version, node count, and Azure Arc agent version.|
|`deployment.apps/resource-sync-agent`|Syncs cluster metadata to Azure.|
|`deployment.apps/clusteridentityoperator`|Maintains the certificate for the managed identities for Azure resources that other agents use for communication with Azure.|
|`deployment.apps/flux-logs-agent`|Collects logs from the flux operators that deploy as a part of source control configuration.|

> [!NOTE]
> For more detailed information about connecting an Azure Arc-enabled Kubernetes cluster, follow the guidance in the [Connect an Azure Arc-enabled Kubernetes cluster (Preview)](https://docs.microsoft.com/azure/azure-arc/kubernetes/connect-cluster?azure-portal=true) tutorial.

After you connect to your cluster, you can use GitOps in the connected cluster, or you can use Azure Policy to manage the cluster.
