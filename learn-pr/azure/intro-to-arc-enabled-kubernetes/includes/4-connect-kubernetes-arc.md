In this unit, you learn how to connect a Kubernetes cluster to Azure Arc. Azure Arc extends the scope of the Azure management plane to resources located on-premises and in other clouds. To enable this extension, you must establish an outbound connection from these resources to Azure. 

## Connect a Kubernetes cluster to Azure Arc

To connect a Kubernetes cluster to Azure Arc, you deploy the Azure Arc agents for Kubernetes into the `azure-arc` namespace on the cluster. The process consists of the following high-level steps.

### Prerequisites

To complete the process, you need:

- An existing Kubernetes cluster.
- Outbound connectivity from the cluster to Azure and to the Microsoft container registry that hosts the container images required for installation. For details regarding target URLs and ports, refer to your product documentation.
- A user account or service principal in the Azure Active Directory (Azure AD) tenant for the subscription that hosts Azure Arc-enabled Kubernetes. This account must have at least the **Kubernetes Cluster - Azure Arc Onboarding** Azure role-based access control (Azure RBAC) built-in role.
- The latest version of Azure CLI or Azure PowerShell installed on your management computer. This example uses Azure CLI.

### Connection steps

1. Start an Azure CLI session on a computer with connectivity to the Kubernetes cluster and to Azure.
1. Sign in to an Azure AD account that can host Azure Arc-enabled Kubernetes.
1. If necessary, register the Azure resource providers that let you manage Azure Arc-enabled Kubernetes.
1. Designate a new or existing Azure resource group to host the resource that represents the Azure Arc-enabled Kubernetes cluster.
1. Connect the Kubernetes cluster to Azure by running the `az connectedk8s connect` Azure CLI command. This command installs the agents on the cluster and creates the cluster resource in the specified resource group.
1. Verify the connection by running the `az connectedk8s list` command to list connected clusters.

After you deploy the agent on a cluster, you can use the following Azure Arc-enabled Kubernetes functionality:

- Organize and track Kubernetes clusters by using Azure and Azure Graph Explorer.
- Automate cluster configuration by using GitOps-based configuration management.
- Monitor cluster status and workloads by using Azure Monitor.
- Implement cluster and pod governance and validate compliance by using Azure Policy.

## Connect to clusters from anywhere

Azure Arc-enabled Kubernetes provides a *cluster connect* feature that lets you access Arc-enabled Kubernetes clusters from anywhere, allowing for interactive development and debugging. This feature lets you securely connect to your clusters without requiring any inbound port to be enabled on the firewall. A reverse proxy agent that runs on the cluster can securely start a session with the Azure Arc service in an outbound manner.

You can use cluster connect to provide cluster access to Azure services for custom locations and their deployed resources. You can use hosted agents or runners from Azure Pipelines, GitHub Actions, or any hosted continuous integration and continuous deployment (CI/CD) service to deploy applications to on-premises clusters, without needing self-hosted agents.

