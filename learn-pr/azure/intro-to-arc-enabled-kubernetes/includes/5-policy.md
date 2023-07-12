Azure Arc centralizes and streamlines management by enabling a range of Azure services, such as Azure Policy. In this unit, you learn about Azure Policy for Kubernetes and how to implement it for Azure Arc-enabled clusters.

Azure Policy for Kubernetes facilitates at-scale policy enforcement and safeguards Kubernetes clusters integrated with Azure in a centralized, uniform manner. With Azure Policy for Kubernetes, companies can enforce uniform governance rules across all of their Azure Arc-enabled Kubernetes clusters to detect any noncompliance with organizational standards.

## Azure Policy

Azure Policy is a service that helps manage and evaluate internal and regulatory compliance in cloud and on-premises environments. Azure Policy uses declarative rules based on properties of target resource types, including Kubernetes clusters and their components. These rules form policy definitions, which administrators can apply through policy assignment to resource groups, subscriptions, or management groups that host Azure and Azure Arc-enabled resources.

## Azure Policy for Kubernetes

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

