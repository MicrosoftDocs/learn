Azure Arc centralizes and streamlines management by enabling a range of Azure services, such as Azure Policy and Azure Monitor. 

In this unit, you learn about using these services to manage and monitor Azure Arc-enabled Kubernetes clusters.

## Azure Policy

Azure Policy uses declarative rules based on properties of target resource types, including Kubernetes clusters and their components. These rules form policy definitions, which administrators can apply through policy assignment to resource groups, subscriptions, or management groups, including those that host Azure Arc-enabled resources.

### Azure Policy for Kubernetes

With Azure Policy for Kubernetes, companies can enforce uniform governance rules across all of their Azure Arc-enabled Kubernetes clusters to detect any noncompliance with organizational standards.

The Azure Policy extension for Arc-enabled Kubernetes takes the following actions:

- Checks periodically for Azure Policy assignments that target the Kubernetes cluster hosting the admission controller pods.
- Deploys policy definitions into the cluster as custom resources that apply constraints, which the admission controller pods enforce.
- Reports auditing and compliance data to Azure Policy, so you can review status via the Azure portal as for other Azure or Azure Arc-enabled resources.

### Built-in policy definitions for Arc-enabled Kubernetes

Azure Policy offers many built-in definitions for Azure Arc-enabled Kubernetes, including the following commonly used policy definitions:

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

Many more built-in policy definitions are available. To view all policy definitions, search for and select **Policy** in the Azure portal, select **Definitions** in the left menu, and then select **Kubernetes** in the **Category** dropdown list.

### Implement Azure Policy for Kubernetes

To implement Azure Policy for Kubernetes on connected clusters, you need to install the Azure Policy extension. For Azure Arc-enabled Kubernetes, the process consists of the following high-level steps.

1. Sign in to the Azure AD tenant with an account that has permissions to manage the Arc-enabled Kubernetes resource.
1. Create an Azure Policy extension instance on the cluster.
1. Create a policy assignment by using one of the Kubernetes-specific policy definitions.

Once the policy assignment is created, Azure Policy will begin to check for compliance.

## Azure Monitor

Azure Monitor extends comprehensive cloud-based management functionality beyond Azure to on-premises datacenters and non-Microsoft cloud providers. Monitor collects and monitors metrics, activity and diagnostics logs, and events from Azure services, Arc-enabled resources, and on-premises datacenter and third-party cloud resources.

The Monitor configuration and monitoring interface includes:

- Dashboards and workbooks.
- Metrics analysis with tools such as Metrics Explorer or Power BI.
- Common action groups that designate alert-triggered actions and alert recipients.

### Azure Monitor Container insights

Azure Monitor Container insights provides comprehensive insight into the state of the Kubernetes environment, helping to maintain operational stability and business continuity. Metrics are collected on controllers, nodes, and containers in Kubernetes environments, including Azure Arc-enabled Kubernetes.

Container insights provides the following capabilities:

- Identify containers running on each cluster node and their average processor and memory utilization, to help detect resource bottlenecks.
- Identify containers running in individual pods to help you track the pod's overall performance.
- Evaluate resource utilization of workloads running on the host that are unrelated to the standard processes that support the pod.
- Compare the behavior of the cluster under average and heaviest loads, to help assess capacity needs and estimate the maximum load the cluster can sustain.
- Configure alerts to proactively notify you when resource utilization exceeds acceptable thresholds or when a health state changes in the cluster.

### Monitor Azure Arc-enabled Kubernetes clusters

Azure Monitor Container insights relies on a containerized version of Azure Monitor Agent for Linux. This agent runs in the monitored cluster to collect performance metrics and logs from cluster nodes and containers. The agent interacts directly with the Kubernetes Metrics API and uploads the collected data to Azure.

The process to implement Azure Monitor Container insights for Azure Arc-enabled Kubernetes deployments consists of the following high-level steps.

1. Sign in to the Azure AD tenant with an account that has permissions to manage the Arc-enabled Kubernetes resource.
1. Identify the workspace ID of the Log Analytics workspace you want to use.
1. Create an Azure Monitor Container insights extension instance on the cluster, using the Log Analytics workspace ID.
