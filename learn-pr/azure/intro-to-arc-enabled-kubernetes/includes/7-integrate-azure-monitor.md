Kubernetes deployments such as Contoso's can be very complex, with multiple layers of abstraction hiding implementation details, and hundreds or thousands of containers hosting workloads. Comprehensive insight into the state of the Kubernetes environment is essential for operational stability and business continuity. Azure Monitor can be used to meet this goal. In this unit, you'll learn about Azure Monitor Container Insights and how to implement it.

## What is Azure Monitor?

Azure Monitor is a core component of the Microsoft strategy to extend comprehensive cloud-based management functionality beyond Azure to on-premises datacenters and non-Microsoft cloud providers. Customers maintaining their on-premises infrastructure can benefit from this functionality when tracking, auditing, or troubleshooting past events, optimizing administration of their existing deployments, and forecasting and planning the capacity of future deployments.

Azure Monitor supports collection and monitoring of metrics, activity and diagnostics logs, and events from Azure services, Arc-enabled resources, and computers residing in on-premises datacenters and third-party cloud providers. It provides a quick way to assess the status of your environment in the Azure portal. You can also access its data by using Azure PowerShell, Azure CLI, REST API, and .NET SDK. Additionally, Azure Monitor allows you to archive collected data for long-term analysis or compliance purposes in Azure Storage, or route it to Azure Stream Analytics or non-Microsoft services by using Event Hubs. You also can store and analyze near real-time and historical data by using Log Analytics.

Regardless of the resource being monitored, Azure Monitor offers a consistent interface for configuring and using its features, including:

- Dashboards and workbooks
- Metrics analysis via tools such as Metrics Explorer or Power Business Intelligence (BI)
- Common action groups that designate alert-triggered actions and alert recipients

You set up and use alerts to:

- Trigger notifications via text message or email.
- Trigger a remediation action.
- Raise an incident and create work items by taking advantage of the integration between Monitor and your internal IT Service Management platform.

## What is Azure Monitor Container Insights?

Azure Monitor Container Insights extends Azure Monitor to collect metrics on controllers, nodes, and containers running on:

- Managed Kubernetes clusters hosted on Azure Kubernetes Service (AKS)
- Self-managed Kubernetes clusters hosted on Azure using AKS Engine
- Azure Container Instances
- Self-managed Kubernetes clusters hosted on Azure Stack or on-premises
- Azure Arc-enabled Kubernetes

Capabilities of Azure Monitor Container Insights include:

- Identifying containers running on each cluster node and their average processor and memory utilization. This helps detect resource bottlenecks.
- Identifying containers running in individual pods. This allows you to track the pod's overall performance.
- Evaluating the resource utilization of workloads running on the host that are unrelated to the standard processes that support the pod.
- Understanding the behavior of the cluster under average and heaviest loads. This helps with assessing capacity needs and estimating the maximum load that the cluster can sustain.
- Configuring alerts to proactively notify you when resource utilization exceeds acceptable thresholds or when a health state change occurs in the cluster.

## How to monitor Azure Arc-enabled Kubernetes clusters

Azure Monitor Container Insights relies on a containerized version of the Log Analytics agent for Linux named omsagent. This agent runs in the monitored cluster to collect performance metrics and logs from its nodes and containers. The agent interacts directly with the Kubernetes Metrics API and uploads the collected  data to Azure.

You can set up Azure Monitor Container Insights for Azure Arc-enabled Kubernetes deployments by using either a Bash or PowerShell script. The implementation consists of the following high-level steps:

1. Verify that you satisfy all the prerequisites. You'll need:

   - An Azure Arc-enabled Kubernetes cluster. You'll need to know its Azure Resource ID.
   - An Azure Log Analytics workspace that will host the Kubernetes cluster metrics and logs.
   - Access to the cluster with a user account that has the cluster-admin role.
   - A work or school account in the Azure Active Directory (Azure AD) tenant associated with the subscription that hosts the Azure Arc-enabled Kubernetes resource. This account should have, at minimum, the **Contributor** Azure RBAC built-in role within the Log Analytics workspace and the Azure Arc-enabled Kubernetes resource.
   - Helm 3. Consider installing its latest release.
   - The latest version of Azure Command Line Interface (CLI) or PowerShell Core.
   - Outbound connectivity to Azure. For details regarding target URLs and ports, refer to the product documentation.

1. Start an Azure CLI or PowerShell Core session on a computer with connectivity to the Kubernetes cluster and to Azure.
1. Sign in to the Azure AD tenant associated with the subscription that hosts the Azure Arc-enabled Kubernetes resource.
1. Identify the Log Analytics workspace ID.
1. Download and install the Bash or PowerShell script that configures the Kubernetes cluster with the containerized version of the Log Analytics agent.
1. Configure limited connectivity from the pods running the Log Analytics agent to all nodes in the cluster to collect performance metrics.
1. Configure limited connectivity from the pods running the Log Analytics agent to the control plane to collect cluster inventory data.

Choose the best response for each of the following questions. Then select "Check your answers".
