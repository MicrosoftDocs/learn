Monitoring is an important aspect of operationalizing any technology. Considering the complexity of Kubernetes deployments, with multiple layers of abstraction hiding its implementation details and hundreds or thousands of containers hosting workloads, being able to gain a comprehensive insight into the state of the Kubernetes environment is essential for operational stability and business continuity. To accomplish this goal, companies like Contoso can use Azure Monitor. In this unit, you'll learn what Azure Monitor for containers is and how to implement it.

## What is Azure Monitor?

Azure Monitor is a core component of the Microsoft strategy to extend comprehensive cloud-based management functionality beyond Azure to on-premises datacenters and non-Microsoft cloud providers. Customers maintaining their on-premises infrastructure can benefit from this functionality when tracking, auditing, or troubleshooting past events, optimizing administration of their existing deployments, and forecasting and planning the capacity of future deployments.

Azure Monitor supports collection and monitoring of metrics, activity and diagnostics logs, and events from Azure services, Arc-enabled resources, and computers residing in on-premises datacenters and third-party cloud providers. It provides a quick way to assess the status of your environment in the Azure portal. You can also access its data by using Azure PowerShell, Azure CLI, REST API, and .NET SDK. Additionally, Azure Monitor allows you to archive collected data for long-term analysis or compliance purposes in Azure Storage or route it to Azure Stream Analytics or non-Microsoft services by using Event Hub. You also can store and analyze near real-time and historical data by using Log Analytics. 

Regardless of the resource being monitored, Azure Monitor offers a consistent interface for configuring and using its features, including:

- Dashboards and workbooks
- Metrics analysis via tools such as Metrics Explorer or Power Business Intelligence (BI)
- Common action groups that designate alert-triggered actions and alert recipients

You set up and use alerts to:

- Trigger notifications via text message or email.
- Trigger a remediation action.
- Raise an incident and work items by taking advantage of the integration between Monitor and your internal IT Service Management platform.

## What is Azure Monitor for containers?

Azure Monitor for containers extends Azure Monitor to enable monitoring the state of nodes, pools, and containers running on:

- Managed Kubernetes clusters hosted on AKS
- Self-managed Kubernetes clusters hosted on Azure using AKS Engine
- Azure Container Instances
- Self-managed Kubernetes clusters hosted on Azure Stack or on-premises
- Azure Red Hat OpenShift
- Azure Arc enabled Kubernetes

With Azure Monitor for containers you can:

- Identify containers running on each cluster node and their average processor and memory utilization. This helps identifying resource bottlenecks.
- Identify containers running in individual pods. This allows you to track pod's overall performance.
- Evaluate the resource utilization of workloads running on the host that are unrelated to the standard processes that support the pod.
- Determine the behavior of the cluster under average and heaviest loads. This helps with assessing capacity needs and estimating the maximum load that the cluster can sustain.
- Configure alerts to proactively notify you when resource utilization exceeds acceptable thresholds or when a health state change occurs in the cluster.

## How to implement monitoring of Azure Arc enabled Kubernetes clusters?

Azure Monitor for containers relies on a containerized version of the Log Analytics agent for Linux named omsagent, that runs in the monitored cluster to collect performance metrics and logs from its nodes and containers. The agent interacts directly with the Kubernetes Metrics API and uploads the collected  data to Azure. Metrics reside in the metrics store, while log data persists in the logs store in the Log Analytics workspace you designate.

You can set up of Azure Monitor for containers for Azure Arc enabled Kubernetes deployments by using either a PowerShell or Bash script. The implementation consists of the following high-level steps:

1. Verifying that you satisfy all the prerequisites. You'll need: 

    - An Azure Arc enabled Kubernetes cluster
    - An Azure Log Analytics workspace that will host Kubernetes cluster metrics and logs
    - Access to the cluster with a user account that has the cluster-admin role
    - A work or school account in the Azure Active Directory (Azure AD) tenant associated with the subscription that hosts the Azure Arc enabled Kubernetes resource. This account should have, at minimum, the Contributor role within the Log Analytics workspace and the Azure Arc enabled Kubernetes resource.
    - Helm 3. Consider installing its latest release. 
    - Azure Command Line Interface (CLI) version 2.12.0 or newer or PowerShell Core
    - Outbound connectivity to Azure. For details regarding target URLs and ports, refer to Microsoft Docs.
    - Azure Resource ID of the Azure Arc enabled Kubernetes cluster

1. Starting an Azure CLI or PowerShell Core session on a computer with connectivity to the Kubernetes cluster and to Azure. 
1. Signing in to the Azure AD tenant associated with the subscription that hosts the Azure Arc enabled Kubernetes resource. 
1. Identifying the Log Analytics workspace ID.
1. Verify connectivity to the Kubernetes cluster. 
1. Downloading and installing the bash or PowerShell script that configures the Kubernetes cluster with the containerized version of the Log Analytics agent.
1. Configuring limited connectivity from the pods running the Log Analytics agent to all nodes in the cluster to collect performance metrics.
1. Configuring limited connectivity from the pods running the Log Analytics agent to the control plane to allow collecting cluster inventory data. 

Choose the best response for each of the following questions. Then select "Check your answers".
