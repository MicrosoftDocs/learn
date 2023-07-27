Azure Arc extends the scope of the Azure management plane to resources located on-premises and in other clouds. To enable this, you must establish an outbound connection from these resources to Azure.

In this unit, you learn how to connect a Kubernetes cluster to Azure Arc.

## Connect a Kubernetes clusters to Azure Arc

To connect a Kubernetes cluster to Azure Arc, you deploy the Azure Arc agents for Kubernetes into the `azure-arc` namespace on the cluster. 

### Prerequisites

Before you get started, you need:

- An existing Kubernetes cluster. Any cluster type is supported, as long as it is Cloud Native Computing Foundation (CNCF) certified.
- Outbound connectivity from the cluster to Azure and other Microsoft endpoints. For details regarding target URLs and ports, refer to your product documentation.
- A user account or service principal in the Azure Active Directory (Azure AD) tenant for the subscription that hosts Azure Arc-enabled Kubernetes. This account must have at least the **Kubernetes Cluster - Azure Arc Onboarding** Azure role-based access control (Azure RBAC) built-in role.
- The latest version of Azure CLI or Azure PowerShell installed on your management computer. This example uses Azure CLI.

### Connection process

Use the following high-level steps to connect a Kubernetes cluster to Azure Arc.

1. Start an Azure CLI session on a computer with connectivity to the Kubernetes cluster and to Azure.
1. Sign in to an Azure AD account that has permissions to manage Azure Arc-enabled Kubernetes in the subscription.
1. Register the Azure resource providers that let you manage Azure Arc-enabled Kubernetes.
1. Designate a new or existing Azure resource group to host the resource that represents the Azure Arc-enabled Kubernetes cluster.
1. Connect the Kubernetes cluster to Azure by running the `az connectedk8s connect` Azure CLI command. This command installs the agents on the cluster and creates the cluster resource in the specified resource group.
1. Verify the connection by running the `az connectedk8s list` command to list connected clusters.

After you deploy the agent on a cluster, you can manage the cluster in Azure along with other cluster resoources. You can also deploy applications and Azure services to connected clusters.

## Connect to clusters from anywhere

Azure Arc-enabled Kubernetes provides a *cluster connect* feature that lets you access Arc-enabled Kubernetes clusters from anywhere, allowing for interactive development and debugging. This feature lets you securely connect to your clusters without requiring any inbound port to be enabled on the firewall. A reverse proxy agent that runs on the cluster can securely start a session with the Azure Arc service in an outbound manner.

You can use cluster connect to provide cluster access to Azure services for custom locations and their deployed resources. You can use hosted agents or runners from Azure Pipelines, GitHub Actions, or any hosted continuous integration and continuous deployment (CI/CD) service to deploy applications to on-premises clusters.

