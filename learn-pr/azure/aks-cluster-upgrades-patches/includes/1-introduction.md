Imagine you work for a music-software company called Nod Publishers. Nod Publishers provides music software as a service (SaaS) applications to help musicians and artists around the world share their music. The music applications have been containerized. Your job as part of the deployment team is to take those containerized applications and deploy them to Azure Kubernetes Service (AKS).

To get started, your deployment team created some AKS clusters. A few months later, your deployment team successfully deployed all of the music application containers to those AKS clusters.

Your deployment team ends the week with celebrations, or as the CEO of Nod Publishers would say, "Good job everyone, we've ended the week on a high note".

However, when you get to work on Monday morning, you find the following email in your inbox:

:::image type="content" source="../media/1-introduction-email.png" border="false" alt-text="An image that shows an alert from Azure about Azure Kubernetes Service (AKS) clusters support for 1.18 going out of support. The email suggests that an immediate upgrade for AKS cluster is recommended.":::

It looks like you received an email in your inbox from Microsoft Azure notifying you that the current Kubernetes version that your AKS cluster deployments are running will go out of support soon.

This must have happened because the deployment took months to complete. During this time, Kubernetes rolled out newer cluster versions. You must now upgrade your clusters immediately to the latest supported Kubernetes version. You want to understand how this could have happened and what your next steps should be.

By the end of this module, you should be able to upgrade and apply patches to your AKS clusters to the latest supported versions.

[!INCLUDE [azure-optional-exercise-subscription-prerequisite](../../../includes/azure-optional-exercise-subscription-prerequisite.md)]

## Learning objectives

Upon completing this module, you should be able to:

- Understand what Kubernetes versions are supported by Azure Kubernetes Services (AKS).
- Upgrade your existing Azure Kubernetes Services (AKS) clusters components to the latest supported Kubernetes version.
- Understand how to adopt a Blue/Green deployment to upgrade your Azure Kubernetes Services clusters in a production environment.

## Prerequisites

- A basic understanding of [containerization](/training/modules/intro-to-docker-containers/)
- A basic understanding of [Azure Kubernetes Service](/training/modules/intro-to-azure-kubernetes-service/)
