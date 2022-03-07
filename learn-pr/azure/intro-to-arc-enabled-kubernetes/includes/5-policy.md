Azure Arc centralizes and streamlines management by leveraging a range of Azure services, such as Azure Policy. With Azure Policy, companies like Contoso can enforce uniform governance rules across all of their Azure Arc enabled Kubernetes estate and detect any instances of non-compliance with organizational standards. In this unit, you'll learn about Azure Policy for Kubernetes and how to implement it.

## What is Azure Policy?

Azure Policy is a service that helps manage and evaluate internal and regulatory compliance of cloud and on-premises environments. Azure Policy uses declarative rules based on properties of target resource types, including Kubernetes clusters and their components. These rules form policy definitions, which administrators can apply through policy assignment to resource groups, subscriptions, or management groups that host Azure and Azure Arc enabled resources. To simplify management of policy definitions, it is possible to combine multiple policies into initiatives, and then create a few of initiative assignments in lieu of multiple policy assignments.

## What is Azure Policy for Kubernetes?

Azure Policy for Kubernetes leverages the Open Policy Agent (OPA), which is an open source, general-purpose, platform-agnostic, policy engine that provides policy evaluation and enforcement functionality. OPA provides a declarative language that allows you to create policy definitions along with the corresponding Application Programming Interface (API). 

Azure Policy for Kubernetes takes the form of an extension of Gatekeeper, which is an open-source admission controller Kubernetes-based implementation of OPA. The admission controller intercepts requests targeting the control plane of a Kubernetes cluster to create or update its resources, such as pods or deployments. The admission controller evaluates each request against the policies you define and, depending on the outcome of that evaluation, allows, or blocks the corresponding action. In addition, each request that is subject to evaluation is logged. 

Azure Policy for Kubernetes facilitates at-scale policy enforcements and safeguards Kubernetes clusters integrated with Azure in a centralized, uniform manner. It serves the following functions:

- Checks periodically for Azure Policy assignments targeting the Kubernetes cluster hosting the admission controller pods
- Deploys policy definitions into the cluster as custom resources that apply constraints, which, in turn, are enforced by the admission controller pods
- Reports auditing and compliance data to Azure Policy, allowing you to review their status via the Azure portal, similar to other Azure or Azure Arc enabled resource.

Azure Policy for Kubernetes supports the following types of Kubernetes environments:

- Azure Kubernetes Service (AKS), including AKS deployments on Azure Stack HCI
- Azure Arc enabled Kubernetes
- AKS Engine

Azure Policy offers a number of built-in definitions for Azure Arc enabled Kubernetes, including the following:

|Policy name|Policy description|
|-----------|------------------|
|Do not allow privileged containers in Kubernetes cluster|Prevents creation of privileged containers|
|Enforce HTTPS ingress in Kubernetes cluster|Ensures that HTTPS is used for ingress connections|
|Enforce internal load balancers in Kubernetes cluster|Prevents the use of public IP addresses for load balancers|
|Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster|Enforces container CPU and memory resource limits|
|Ensure containers listen only on allowed ports in Kubernetes cluster|Restricts containers to listen only on allowed ports|
|Ensure only allowed container images in Kubernetes cluster|Restricts images that can be used to deploy containers|
|Kubernetes clusters should not allow container privilege escalation|Prevents containers from using privilege escalation|

## How to implement Azure Policy for Kubernetes?

To implement Azure Policy for Kubernetes, you need to install an Azure Policy add-on. The add-on is available for each of the three supported types of Kubernetes environments. 

For Azure Arc enabled Kubernetes, the implementation consists of the following high-level steps:

1. Verifying that you satisfy all the prerequisites. You'll need:

- An Azure Arc enabled Kubernetes cluster.
- Access to the cluster with a user account that has the cluster-admin role.
- A work or school account in the Azure Active Directory (Azure AD) tenant associated with the subscription that hosts the Azure Arc enabled Kubernetes resource. To account for the need to register a provider, this account should be the subscription owner. It should also have permissions to create service principals in the Azure AD tenant.
- Helm 3. Consider installing its latest release. 
- Azure Command Line Interface (CLI) version 2.12.0 or newer. 
- Outbound connectivity to Azure. For details regarding target URLs and ports, refer to Microsoft Docs.
- Azure Resource ID of the Azure Arc enabled Kubernetes cluster

1. Starting an Azure CLI session on a computer with connectivity to the Kubernetes cluster and to Azure. 
1. Signing in to the Azure AD tenant associated with the subscription that hosts the Azure Arc enabled Kubernetes resource. 
1. Registering the Azure Policy resource provider if you haven't used the Azure Policy functionality in the target subscription before.
1. Granting the **Policy Insights Data Writer (Preview)** Azure role-based access control (Azure RBAC) privileges to the Azure Arc enabled Kubernetes cluster.
1. Verify connectivity to the Kubernetes cluster. 
1. Installing the Azure Policy Add-on using its Helm chart.
1. Creating a policy assignment using one of the Kubernetes-specific policy definitions.

Choose the best response for each of the following questions. Then select "Check your answers".
