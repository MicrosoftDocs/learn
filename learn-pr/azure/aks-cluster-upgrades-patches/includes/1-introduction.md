Imagine you work for a music-software company called Nod Publishers. Nod Publishers provides music software as a service (SaaS) applications to help musicians and artists around the world share their music. Your job on the deployment team is to take the containerized applications and deploy them to Azure Kubernetes Service (AKS).

You and your team began by creating some AKS clusters. A few months later, you successfully deployed all of the music application containers to those AKS clusters.

Your team ends the week with celebrations. The CEO of Nod Publishers recognizes your team's hard work, saying "Good job everyone! We've ended the week on a high note."

However, when you get to work on Monday morning, you find the following email in your inbox:

:::image type="content" source="../media/1-introduction-email.png" border="false" alt-text="An image that shows an alert from Azure about Azure Kubernetes Service (AKS) clusters support for 1.18 going out of support. The email suggests that an immediate upgrade for AKS cluster is recommended.":::

Microsoft Azure sent the email to notify you that they're ending support for the current Kubernetes version on your AKS cluster deployments.

It took a few months to complete the deployment, and during this time, Kubernetes rolled out newer cluster versions. You now need to upgrade your clusters to the latest supported Kubernetes version. You want to understand how to handle cluster upgrades and patches moving forward so you don't run into this issue again.

By the end of this module, you will know how to apply upgrades and patches to your AKS clusters to ensure they remain in a supported state.

[!INCLUDE [azure-optional-exercise-subscription-prerequisite](../../../includes/azure-optional-exercise-subscription-prerequisite.md)]

## Learning objectives

By the end of the module, you should be able to:

- Understand what Kubernetes versions AKS supports.
- Upgrade your existing AKS cluster components to the latest supported Kubernetes version.
- Upgrade your AKS clusters in production environments using a Blue/Green deployment.

## Prerequisites

- Access to an Azure subscription.
- A basic understanding of [containerization](/training/modules/intro-to-docker-containers/) and [AKS](/training/modules/intro-to-azure-kubernetes-service/).
