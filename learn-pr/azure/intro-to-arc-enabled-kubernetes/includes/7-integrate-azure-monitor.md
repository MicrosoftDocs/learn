Kubernetes deployments can be complex, with multiple layers of abstraction obscuring implementation details, and hundreds or thousands of containers hosting workloads. Comprehensive insight into the state of the Kubernetes environment is essential for operational stability and business continuity.

You can use Azure Monitor to help meet this goal. In this unit, you learn about Azure Monitor container insights and how to use them for Azure Arc-enabled Kubernetes clusters.

## Azure Monitor

Azure Monitor extends comprehensive cloud-based management functionality beyond Azure to on-premises datacenters and non-Microsoft cloud providers. Monitor collects and monitors metrics, activity and diagnostics logs, and events from Azure services, Arc-enabled resources, and on-premises datacenter and third-party cloud resources.

Organizations that maintain on-premises infrastructure can use Monitor to:

- Track, audit, or troubleshoot past events.
- Optimize administration of existing deployments.
- Forecast and plan capacity for future deployments.

Monitor provides a quick way to assess the status of your environment by using the Azure portal. You can also access Monitor data by using Azure PowerShell, Azure CLI, REST API, or .NET SDK commands.

Monitor lets you archive collected data in Azure Storage for longterm analysis or compliance purposes, or route the data to Azure Stream Analytics or non-Microsoft services by using Event Hubs. You also can store and analyze near real-time and historical data.

Monitor uses a consistent configuration and monitoring interface regardless of the resource it monitors. The Monitor interface includes the following features:

- Dashboards and workbooks.
- Metrics analysis with tools such as Metrics Explorer or Power BI.
- Common action groups that designate alert-triggered actions and alert recipients.

You can set up and use Monitor alerts to:

- Trigger notifications via text message or email.
- Trigger remediation actions.
- Raise incidents and create work items by using the integration between Monitor and your internal IT service management platform.

## Azure Monitor container insights

Azure Monitor container insights extend Monitor to collect metrics on controllers, nodes, and containers in the following environments:

- Managed Kubernetes clusters hosted on Azure Kubernetes Service (AKS)
- Self-managed Kubernetes clusters hosted on Azure by using AKS Engine
- Azure Container Instances
- Self-managed Kubernetes clusters hosted on Azure Stack or on-premises
- Azure Arc-enabled Kubernetes

Container insights provide the following capabilities:

- Identify containers running on each cluster node and their average processor and memory utilization, to help detect resource bottlenecks.
- Identify containers running in individual pods to help you track the pod's overall performance.
- Evaluate resource utilization of workloads running on the host that are unrelated to the standard processes that support the pod.
- Compare the behavior of the cluster under average and heaviest loads, to help assess capacity needs and estimate the maximum load the cluster can sustain.
- Configure alerts to proactively notify you when resource utilization exceeds acceptable thresholds or when a health state changes in the cluster.

## Monitor Azure Arc-enabled Kubernetes clusters

Azure Monitor container insights relies on a containerized version of Azure Monitor Agent for Linux. This agent runs in the monitored cluster to collect performance metrics and logs from cluster nodes and containers. The agent interacts directly with the Kubernetes Metrics API and uploads the collected data to Azure.

>[!NOTE]
>The Azure Monitor container insights agent name has changed from OMSAgent to Azure Monitor Agent. Rules, scripts, and queries that used or referred to `omsagent` might no longer work or might return only old data. Update these references to use the new name of `ama-logs`. For more information, see [Name update for Agent and associated resources in Azure Monitor - Container Insights](https://techcommunity.microsoft.com/t5/azure-monitor-status-archive/name-update-for-agent-and-associated-resources-in-azure-monitor/ba-p/3576810).

Use the following high-level steps to implement Azure Monitor container insights for Azure Arc-enabled Kubernetes deployments. You can use either a Bash or PowerShell script for setup.

### Prerequisites

- An Azure Arc-enabled Kubernetes cluster. You need to know the Azure Arc Cluster Resource ID.
- A Log Analytics workspace to host the Kubernetes cluster metrics and logs.
- Access to the cluster with a user account that has the **cluster-admin** role.
- Access to a work or school Azure Active Directory (Azure AD) account for the subscription that hosts Azure Arc-enabled Kubernetes. The account must have at least the **Contributor** Azure role-based access control (RBAC) built-in role in the Log Analytics workspace and the Azure Arc-enabled Kubernetes resource.
- Helm 3, ideally the latest release.
- The latest version of Azure CLI or PowerShell Core.
- Outbound connectivity to Azure. For details regarding target URLs and ports, refer to your product documentation.

### Configuration steps

1. Start an Azure CLI or PowerShell Core session on a computer with connectivity to the Kubernetes cluster and to Azure.
1. Sign in to the Azure AD tenant associated with the subscription that hosts Azure Arc-enabled Kubernetes.
1. Identify the Log Analytics workspace ID.
1. Download and install a Bash or PowerShell script that configures the Kubernetes cluster with the containerized version of Azure Monitor Agent.
1. Configure limited connectivity from the pods running Azure Monitor Agent to all cluster nodes to collect performance metrics.
1. Configure limited connectivity from the pods running Azure Monitor Agent to the control plane nodes to collect cluster inventory data.

## Azure Policy for Kubernetes

Azure Policy is a service that helps manage and evaluate internal and regulatory compliance in cloud and on-premises environments. Azure Policy uses declarative rules based on properties of target resource types, including Kubernetes clusters and their components. These rules form policy definitions, which administrators can apply through policy assignment to resource groups, subscriptions, or management groups that host Azure and Azure Arc-enabled resources.

Azure Policy for Kubernetes uses Open Policy Agent (OPA), an open-source, general-purpose, platform-agnostic policy evaluation and enforcement engine. OPA and its REST APIs provide a declarative language that lets you create and manage policy definitions.

Azure Policy for Kubernetes is an extension of Gatekeeper, an open-source, Kubernetes-based OPA admission controller. This admission controller acts as follows:

1. Intercepts requests for the Kubernetes cluster control plane to create or update its resources, such as pods or deployments.
1. Evaluates each request against the policies you define, and logs each request it evaluates.
1. Depending on the outcome of the evaluation, allows or blocks the corresponding action.

Azure Policy for Kubernetes also takes the following actions:

- Checks periodically for Azure Policy assignments that target the Kubernetes cluster hosting the admission controller pods.
- Deploys policy definitions into the cluster as custom resources that apply constraints, which the admission controller pods enforce.
- Reports auditing and compliance data to Azure Policy, so you can review status via the Azure portal as for other Azure or Azure Arc-enabled resources.

Azure Policy offers built-in definitions for Azure Arc-enabled Kubernetes, including the following commonly used policy definitions:

|Policy name|Policy description|
|-----------|------------------|
|**Kubernetes cluster should not allow privileged containers**|Prevents creation of privileged containers in a cluster.|
|**Kubernetes clusters should be accessible only over HTTPS**|Ensures that HTTPS is used for ingress connections.|
|**Kubernetes cluster services should only use allowed external IPs**|Ensures that only allowed external IP addresses are used.|
|**Kubernetes cluster containers CPU and memory resource limits should not exceed the specified limits**|Enforces container CPU and memory resource limits.|
|**Kubernetes cluster services should listen only on allowed ports**|Restricts services to listen only on allowed ports.|
|**Kubernetes cluster containers should only use allowed images**|Restricts images that can be used to deploy containers to only images from trusted registries.|
|**Kubernetes cluster containers should only use allowed capabilities**|Restricts capabilities to reduce the attack surface of containers.|
|**Kubernetes cluster pods should only use approved host network and port range**|Restricts pod access to the host network and the allowable host port range in a cluster.|

Many more built-in policy definitions are available. To view all policy definitions, search for and select **Policy** in the Azure portal, select **Definitions** in the left menu, and then select **Kubernetes** in the **Category** dropdown list. Azure Policy for Kubernetes also supports Azure Kubernetes Service (AKS), including AKS deployments on Azure Stack HCI.

## Implement Azure Policy for Kubernetes

To implement Azure Policy for Kubernetes on connected clusters, you need to install the Azure Policy Add-on. For Azure Arc-enabled Kubernetes, the process consists of the following high-level steps:

### Prerequisites

- An Azure Arc-enabled Kubernetes cluster. You need to know the Azure Arc Cluster Resource ID.
- Access to the cluster with a user account that has the **cluster-admin** role.
- Access to a work or school Azure Active Directory (Azure AD) account for the subscription that hosts Azure Arc-enabled Kubernetes. The account must have the subscription **Owner** Azure role-based access control (Azure RBAC) role, so you can register a provider and create service principals in the Azure AD tenant.
- A user account or service principal in the Azure AD tenant that has at least the **Kubernetes Cluster - Azure Arc Onboarding** Azure RBAC built-in role.
- Helm 3, ideally the latest release.
- Azure CLI version 2.12.0 or later.
- Outbound connectivity to Azure. For details regarding target URLs and ports, refer to your product documentation.

### Installation steps

1. Start an Azure CLI session on a computer with connectivity to the Kubernetes cluster and to Azure.
1. Sign in to the Azure AD tenant associated with the subscription that hosts the Azure Arc-enabled Kubernetes resource.
1. Grant the **Policy Insights Data Writer (Preview)** Azure RBAC built-in role to the Azure Arc-enabled Kubernetes cluster.
1. Verify connectivity to the Kubernetes cluster.
1. Install the Azure Policy Add-on by using its Helm chart.
1. Create a policy assignment by using one of the Kubernetes-specific policy definitions.