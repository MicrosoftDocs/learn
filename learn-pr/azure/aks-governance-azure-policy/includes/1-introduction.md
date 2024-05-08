Imagine that you work for a browser based video game company. After a few months of planning, your team successfully migrated its technology stack to Azure Kubernetes Service (AKS).

You just came out of a review with the security and compliance teams. They expressed concerns about the compliance status of your cluster. For example, they only want you to deploy images from trusted registries.

You need to be able to block new deployments from untrusted registries, and present a report of the status of your cluster against that policy. It's up to you to find out how you can meet this requirement and present a solution to the security and compliance teams.

In this module, you learn how to govern your AKS cluster using Azure Policy for Kubernetes.

[!INCLUDE [azure-optional-exercise-subscription-prerequisite](../../../includes/azure-optional-exercise-subscription-prerequisite.md)]

## Learning objectives

By the end of this module, you're able to:

- Understand how Azure Policy integrates with Azure Kubernetes Service.
- Deploy the Azure Policy add-on for Azure Kubernetes Service.
- Configure policies to manage compliance state of an Azure Kubernetes Service cluster.
- Monitor cluster compliance status using Azure policy.

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes).
- An active [Azure subscription](https://azure.microsoft.com/free/services/kubernetes-service)
- Ability to use the [Azure CLI](/cli/azure/)