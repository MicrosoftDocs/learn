Azure Arc extends the scope of Azure management plane to resources located on-premises and in other clouds. To enable this, you must establish an outbound connection from these resources to Azure. In this unit, you'll learn how to connect a Kubernetes cluster to Azure Arc.

## How to connect Kubernetes clusters to Azure Arc

To connect a Kubernetes cluster to Azure Arc, you deploy the Azure Arc agents for Kubernetes into the `azure-arc` namespace on the cluster. This process consists of the following high-level steps:

1. Verify that you satisfy all the prerequisites. You'll need:

   - An existing Kubernetes cluster.
   - Outbound connectivity from the cluster to Azure and Microsoft container registry hosting the container images required during installation. For details regarding target URLs and ports, refer to the product documentation.
   - A user account or service principal in the Azure Active Directory (Azure AD) tenant associated with the subscription that will be hosting the Azure Arc-enabled Kubernetes resource. This account must have, at minimum, the **Kubernetes Cluster - Azure Arc Onboarding** Azure role-based access control (Azure RBAC) built-in role.
   - The latest version of Azure Command Line Interface (CLI) or Azure PowerShell installed on your management computer. For this example, we'll refer to Azure CLI.

1. Start an Azure CLI session on a computer with connectivity to the Kubernetes cluster and to Azure.
1. Sign in to the Azure AD tenant associated with the subscription that will be hosting the Azure Arc-enabled Kubernetes resource. Use the account that you identified when verifying the prerequisites.
1. Register the Azure resource providers that allow you to manage Azure Arc-enabled Kubernetes from the command line.
1. Designate a new or existing Azure resource group to host the resource representing the Azure Arc-enabled Kubernetes cluster.
1. Connect the Kubernetes cluster to Azure by running the `az connectedk8s connect` Azure CLI command. This command installs the agents on the cluster and creates the cluster resource in the specified resource group.
1. Verify the outcome by running the `az connectedk8s list` command to list the connected clusters.

After you deploy the agent on a cluster, you can use Azure Arc-enabled Kubernetes functionality such as:

- Organize and track Kubernetes clusters by using Azure Resource Manager and Azure Graph Explorer.
- Automate cluster configuration by using GitOps-based configuration management.
- Monitor status of the cluster and its workloads by using Azure Monitor.
- Implement governance and validate compliance of the cluster and its pods by using Azure Policy.

## Connecting to clusters from anywhere

Azure Arc-enabled Kubernetes provides a *cluster connect* feature, which lets you access Arc-enabled Kubernetes clusters from anywhere, allowing for interactive development and debugging. This feature lets you securely connect to your clusters without requiring any inbound port to be enabled on the firewall. A reverse proxy agent running on the cluster can securely start a session with the Azure Arc service in an outbound manner.

Cluster connect can be used to provide cluster access to Azure services for custom locations and the resources deployed on them. You can even use hosted agents/runners of Azure Pipelines, GitHub Actions, or any other hosted CI/CD service to deploy applications to on-premises clusters, without requiring self-hosted agents.

Choose the best response for each of the following questions. Then select "Check your answers".
