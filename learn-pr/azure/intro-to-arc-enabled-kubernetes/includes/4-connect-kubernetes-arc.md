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
3. Create a new or designate an existing Azure resource group that will host the resource representing the Azure Arc-enabled Kubernetes cluster.
4. Verify connectivity to the Kubernetes cluster. 
5. Connect the Kubernetes cluster to Azure by running the `az connectedk8s connect` Azure CLI command. The command requires that you specify the name of the target cluster and the name of the resource group that will host the resource representing the Azure Arc-enabled Kubernetes cluster.
6. Verify the outcome by running the `az connectedk8s list` command to list the connected clusters. The command requires that you specify the name of the resource group you specified in the previous step.