Imagine that you work for a browser-based video game company. After a few months of planning, your team successfully migrated its technology stack to Azure Kubernetes Service (AKS).

You just came out of a review with the security and compliance teams. They expressed concerns about the compliance status of your cluster. For example, they only want you to deploy images from trusted registries.

You need to be able to block new deployments from untrusted registries, and present a report of the status of your cluster against that policy. It's up to you to find out how you can meet this requirement and present a solution to the security and compliance teams.

In this module, you learn how to govern your AKS cluster using Azure Policy for Kubernetes.

## Learning objectives

By the end of this module, you're able to:

- Understand how Azure Policy integrates with Azure Kubernetes Service.
- Deploy the Azure Policy add-on for Azure Kubernetes Service.
- Configure policies to manage compliance state of an Azure Kubernetes Service cluster.
- Monitor cluster compliance status using Azure Policy.

## Prerequisites

Before you begin, make sure you have:

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the Kubernetes basics resource in the summary unit's **More info** section.
- An active Azure subscription.
- The ability to use the Azure CLI.

Use a subscription and a dedicated resource group approved for training. Your identity must be authorized to register the required resource providers, create and delete the lab resources, obtain AKS credentials, assign Azure Policy definitions and initiatives at the lab scope, import and inspect Azure Container Registry (ACR) images, and grant the AKS kubelet identity registry pull access.

Azure Policy assignment requires the appropriate policy-assignment operations; **Resource Policy Contributor** and **Owner** include them. **Contributor** alone doesn't allow policy assignment. Registry attachment also requires permission to create Azure role assignments at the registry scope, such as an appropriately scoped role that includes `Microsoft.Authorization/roleAssignments/write`.

For the RBAC-mode registry used in this module, ensure your identity can import images and list repositories, and that the kubelet identity can pull them. Azure Policy assignment access and registry access are separate permissions. If you don't have all these capabilities, ask an administrator to prepare the resources or perform the privileged steps rather than requesting unnecessary subscription-wide permissions. See Azure Policy RBAC permissions, AKS-ACR integration, and ACR image-import prerequisites in the summary unit's **More info** section.

Ensure that the approved lab subscription has available AKS managed-cluster quota and sufficient regional and VM-family vCPU quota for the cluster's worker nodes. Regional VM capacity also affects deployment. Before beginning, review AKS quotas, SKUs, and regions in the summary unit's **More info** section.

> [!IMPORTANT]
> Use a nonproduction lab. Existing management-group or subscription policies still apply and can affect deployment or compliance. Don't disable organizational policy to complete the exercise; use an approved lab environment. AKS, ACR, and public LoadBalancer resources can incur charges.