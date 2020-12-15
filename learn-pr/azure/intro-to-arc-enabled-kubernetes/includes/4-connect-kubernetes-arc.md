Azure Arc extends the scope of Azure management plane to resources located on-premises and in other clouds. This, however, requires that you first establish an outbound connection from these resources to Azure. In this unit, you'll learn how to connect a Kubernetes cluster with Azure Arc.

## Connect an Azure Arc enabled Kubernetes cluster

To connect a Kubernetes cluster to Azure Arc, you first deploy the Azure Arc Agents for Kubernetes. These agents are deployed as pods into the `azure-arc` namespace. The implementation consists of the following high-level steps: 

1. Verifying that you satisfy all the prerequisites. You'll need:

- An existing Kubernetes cluster.
- Access to the cluster with a user account that has the cluster-admin role.
- Outbound connectivity from the cluster to Azure and Microsoft container registry hosting the container images required during installation. For details regarding target URLs and ports, refer to Microsoft Docs.
- A user account or service principal in the Azure Active Directory (Azure AD) tenant associated with the subscription that will be hosting the Azure Arc enabled Kubernetes resource. This account must have, at minimum, the **Kubernetes Cluster - Azure Arc Onboarding** Azure role-based access control (Azure RBAC).
- Helm 3 installed on your management computer. Consider installing its latest release. 
- Azure Command Line Interface (CLI) version 2.15 or newer installed on your management computer. This is necessary to install Azure Arc enabled Kubernetes CLI extensions. 

2. Starting an Azure CLI session on a computer with connectivity to the Kubernetes cluster and to Azure.
3. Signing in to the Azure AD tenant associated with the subscription that will be hosting Azure Arc enabled Kubernetes resource. Use the account that you identified when verifying the prerequisites.
4. Registering the Azure resource providers that allow you to manage Azure Arc enabled Kubernetes from the command line.
5. Creating a new or designating an existing Azure resource group that will host the resource representing the Azure Arc enabled Kubernetes cluster.
6. Verifying connectivity to the Kubernetes cluster. 
7. Connecting the Kubernetes cluster to Azure by running the `az connectedk8s connect` Azure CLI command. The command requires that you specify the name that the connected cluster will have in Azure and the name of the resource group that will contain the resource representing the Azure Arc enabled Kubernetes cluster. It automatically deploys the Helm three-based package containing the agents.
8. Verifying the outcome by running the `az connectedk8s list` command to list the connected clusters. The command requires that you specify the name of the resource group you specified in the previous step.

> [!NOTE] 
> It is possible to automate this process by creating an Azure AD service principal, which eliminates the need for interactive sign in to Azure AD. For details, refer to Microsoft documentation.

After you deploy the agent, you can leverage Azure Arc enabled Kubernetes functionality to:

- Organize and track Kubernetes clusters by using Azure Resource Manager and Azure Graph Explorer.
- Automate cluster configuration by using GitOps-based configuration management. 
- Monitor status of the cluster and its workloads by using Azure Monitor.
- Implement governance and validate compliance of the cluster and its pods by using Azure Policy.


Choose the best response for each of the following questions. Then select "Check your answers".
