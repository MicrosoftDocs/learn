Azure Arc extends the scope of Azure management plane to non-Azure resources. This, however, requires that you first establish an outbound connection from these resources to Azure. 

## Connect an Azure Arc-enabled Kubernetes cluster

To connect a Kubernetes cluster to Azure Arc, you need to deploy Azure Arc Agents for Kubernetes as pods into a designated namespace named `azure-arc`. The implementation consists of the following high-level steps:

1. Verifying that you satisfy all the prerequisites. You'll need:

- An existing Kubernetes cluster.
- Access to the cluster with a user account that has the cluster-admin role.
- A work or school account in the Azure Active Directory (Azure AD) tenant associated with the subscription that will be hosting Azure Arc enabled Kubernetes resource. This account must have, at minimum, the **Kubernetes Cluster - Azure Arc Onboarding** Role Based Access Control (RBAC) role.
- Helm 3. Consider installing its latest release. 
- Azure Command Line Interface (CLI) version 2.3 or newer. This is necessary to install Azure Arc enabled Kubernetes CLI extensions. 
- Outbound connectivity to Azure and Microsoft container registry hosting the container images required during installation. For details regarding target URLs and ports, refer to Microsoft Docs.

1. Starting an Azure CLI session on a computer with connectivity to the Kubernetes cluster and to Azure. 
1. Signing in to the Azure AD tenant associated with the subscription that will be hosting Azure Arc enabled Kubernetes resource. Use the account that you identified when verifying the prerequisites.
1. Registering the Azure resource providers that implement the Azure Arc-enabled Kubernetes functionality.
1. Creating a new or designate an existing Azure resource group that will host the resource representing the Azure Arc-enabled Kubernetes cluster.
1. Verifying connectivity to the Kubernetes cluster. 
1. Connecting the Kubernetes cluster to Azure by running the `az connectedk8s connect` Azure CLI command. The command requires that you specify the name of the target cluster and the name of the resource group that will host the resource representing the Azure Arc-enabled Kubernetes cluster. It automatically deploys the Helm 3-based package containing the agents.
1. Verifying the outcome by running the `az connectedk8s list` command to list the connected clusters. The command requires that you specify the name of the resource group you specified in the previous step.

> [!NOTE] 
> It is possible to automate this process by creating an Azure AD service principal, which eliminates the need for interactive sign in to Azure AD. For details, refer to Microsoft documentation.

After you deploy the agent, you can leverage Azure Arc-enabled Kubernetes functionality to:

- Implement governance and validate compliance of the cluster and its pods by using Azure Policy.
- Automate cluster configuration by using GitOps-based configuration management. 
- Monitor status of the cluster and its workloads by using Azure Monitor.
- Organize and track Kubernetes clusters by using Azure Resource Manager and Azure Graph Explorer.
