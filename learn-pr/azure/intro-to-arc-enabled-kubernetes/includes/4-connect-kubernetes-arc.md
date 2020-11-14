Azure Arc extends the scope of Azure management plane to non-Azure resources. This, however, requires that you first establish an outbound connection from these resources to Azure. 

## Connect an Azure Arc-enabled Kubernetes cluster

To connect a Kubernetes cluster to Azure Arc, you need to deploy Azure Arc Agents for Kubernetes as pods into a designated namespace named `azure-arc`. The implementation consists of the following high-level steps:

1. Take care of the prerequisites. You'll need:

- An existing Kubernetes cluster.
- Access to the cluster with a user account that has the cluster-admin role.
- A work or school account in the Azure Active Directory (Azure AD) tenant associated with the subscription that will be hosting Azure Arc enabled Kubernetes resource. This account must have, at minimum, the **Kubernetes Cluster - Azure Arc Onboarding** Role Based Access Control (RBAC) role.
- Helm 3. Consider installing its latest release. 
- Azure Command Line Interface (CLI) version 2.3 or newer. This is necessary to install Azure Arc enabled Kubernetes CLI extensions. 
- Outbound connectivity to Azure and Microsoft container registry hosting the container images required during installation. For details regarding target URLs and ports, refer to Microsoft Docs.

2. Register the Azure resource providers that implement the Azure Arc-enabled Kubernetes functionality.
3. Create a resource group, unless you already have one.
4. Connect a cluster by using the `az connectedk8s connect` Azure CLI command.
5. Verify the connection with the `az connectedk8s list` command.


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


To streamline the process of Azure Arc integration, you can use Windows Admin Center or script the deployment steps.
