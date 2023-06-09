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

Azure Monitor container insights rely on a containerized version of the Log Analytics agent for Linux. This agent runs in the monitored cluster to collect performance metrics and logs from cluster nodes and containers. The agent interacts directly with the Kubernetes Metrics API and uploads the collected data to Azure.

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
1. Download and install a Bash or PowerShell script that configures the Kubernetes cluster with the containerized version of the Log Analytics agent.
1. Configure limited connectivity from the pods running the Log Analytics agent to all cluster nodes to collect performance metrics.
1. Configure limited connectivity from the pods running the Log Analytics agent to the control plane nodes to collect cluster inventory data.

