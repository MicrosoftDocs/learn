Azure Arc centralizes and streamlines management by enabling a range of Azure services, such as Azure Policy. With Azure Policy, companies like Contoso can enforce uniform governance rules across all of their Azure Arc-enabled Kubernetes clusters and detect any instances of non-compliance with organizational standards. In this unit, you'll learn about Azure Policy for Kubernetes and how to implement it with Azure Arc-enabled clusters.

## What is Azure Policy?

Azure Policy is a service that helps manage and evaluate internal and regulatory compliance of cloud and on-premises environments. Azure Policy uses declarative rules based on properties of target resource types, including Kubernetes clusters and their components. These rules form policy definitions, which administrators can apply through policy assignment to resource groups, subscriptions, or management groups that host Azure and Azure Arc-enabled resources.

## What is Azure Policy for Kubernetes?

Azure Policy for Kubernetes leverages the Open Policy Agent (OPA). OPA is an open source, general-purpose, platform-agnostic engine that provides policy evaluation and enforcement functionality. It provides a declarative language that allows you to create policy definitions along with the corresponding Application Programming Interface (API).

Azure Policy for Kubernetes takes the form of an extension of Gatekeeper, which is an open-source admission controller Kubernetes-based implementation of OPA. The admission controller intercepts requests targeting the control plane of a Kubernetes cluster to create or update its resources, such as pods or deployments. The admission controller evaluates each request against the policies you define and, depending on the outcome of that evaluation, allows, or blocks the corresponding action. In addition, each request that is subject to evaluation is logged.

Azure Policy for Kubernetes supports Azure Kubernetes Service (AKS), including AKS deployments on Azure Stack HCI, as well as Azure Arc-enabled Kubernetes. It facilitates at-scale policy enforcements and safeguards Kubernetes clusters integrated with Azure in a centralized, uniform manner by doing the following:

- Checks periodically for Azure Policy assignments targeting the Kubernetes cluster hosting the admission controller pods.
- Deploys policy definitions into the cluster as custom resources that apply constraints, which, in turn, are enforced by the admission controller pods.
- Reports auditing and compliance data to Azure Policy, allowing you to review status via the Azure portal, similar to other Azure or Azure Arc-enabled resources.

Azure Policy offers built-in definitions for Azure Arc-enabled Kubernetes. A few commonly used policy definitions include:

|Policy name|Policy description|
|-----------|------------------|
|Kubernetes cluster should not allow privileged containers|Prevents creation of privileged containers in a cluster.|
|Kubernetes clusters should be accessible only over HTTPS|Ensures that HTTPS is used for ingress connections.|
|Kubernetes cluster services should only use allowed external IPs|Ensures that only allowed external IP addresses are used.|
|Kubernetes cluster containers CPU and memory resource limits should not exceed the specified limits|Enforces container CPU and memory resource limits.|
|Kubernetes cluster services should listen only on allowed ports|Restricts services to listen only on allowed ports.|
|Kubernetes cluster containers should only use allowed images|Restricts images that can be used to deploy containers to only those from trusted registries.|
|Kubernetes cluster containers should only use allowed capabilities|Restricts capabilities to reduce the attack surface of containers.|
|Kubernetes cluster pods should only use approved host network and port range|Restricts pod access to the host network and the allowable host port range in a cluster.|

There are many more built-in policy definitions available. To view all policy definitions, start the Azure Policy service in the Azure portal, select **Definitions**, then select **Kubernetes** in the **Category** dropdown list.

## How to implement Azure Policy for Kubernetes on connected clusters

To implement Azure Policy for Kubernetes, you need to install an Azure Policy add-on. For Azure Arc-enabled Kubernetes, this consists of the following high-level steps:

1. Verify that you satisfy all the prerequisites. You'll need:

   - An Azure Arc-enabled Kubernetes cluster. You'll need to know its Azure Resource ID.
   - Access to the cluster with a user account that has the cluster-admin role.
   - A work or school account in the Azure Active Directory (Azure AD) tenant associated with the subscription that hosts the Azure Arc-enabled Kubernetes resource. Because you'll need to register a provider, this account should be the subscription owner. It should also have permissions to create service principals in the Azure AD tenant.
   - Helm 3. Consider installing its latest release.
   - Azure Command Line Interface (CLI) version 2.12.0 or newer.
   - Outbound connectivity to Azure. For details regarding target URLs and ports, refer to the product documentation.

1. Start an Azure CLI session on a computer with connectivity to the Kubernetes cluster and to Azure.
1. Sign in to the Azure AD tenant associated with the subscription that hosts the Azure Arc-enabled Kubernetes resource.
1. Register the Azure Policy resource provider if you haven't used the Azure Policy functionality in the target subscription before.
1. Grant the **Policy Insights Data Writer (Preview)** Azure role-based access control (Azure RBAC) built-in role to the Azure Arc-enabled Kubernetes cluster.
1. Verify connectivity to the Kubernetes cluster.
1. Install the Azure Policy Add-on using its Helm chart.
1. Create a policy assignment using one of the Kubernetes-specific policy definitions.

Choose the best response for each of the following questions. Then select "Check your answers".
