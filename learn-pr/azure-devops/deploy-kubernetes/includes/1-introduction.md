By following the instructions outlined in the [Automate Docker container deployments with Azure Pipelines](/training/modules/deploy-docker?azure-portal=true), you were able to enhance a release pipeline to build and publish an ASP.NET Core application as a Docker container, which was then deployed to Azure App Service. This migration to a container-based project resulted in numerous benefits for the product team. Moreover, the adoption of container technologies has the potential to unlock various innovative opportunities for the future.

As development organizations expand, the complexity of the solutions they provide also grows. As various products and services become more interdependent, different development and operations requirements arise for various components within a given application. One way to enhance architectural efficiency is by refactoring those components as their own separate microservices.

A microservice is a small, independent service designed to be self-contained and fulfill a specific business capability. Containers provide an excellent technical foundation for building and deploying these services, but this raises a new question: how do we manage all of these containers that are in use?

This is where orchestration technologies such as Kubernetes can be useful. Kubernetes is a platform designed to manage containerized workloads and services. It is an excellent choice for organizations that have an increasing number of containers that must be deployed, integrated, and monitored across various environments.

In this module, you join the Tailspin Toys web team as they explore one way to use Kubernetes on Azure. You learn how to update a release pipeline to build, publish, and deploy multiple Docker containers to a Kubernetes cluster.

While this module focuses on the core tasks that are required to build and deploy your container app, it's important to understand that all the other features of Azure Pipelines are still available for container deployments to Kubernetes. You can integrate testing, define multiple stages, and perform other tasks just like you would for your existing applications. We omit these tasks here to keep things focused.

## Learning objectives

After completing this module, you'll be able to:

- Explain the benefits of Kubernetes and when to use it.
- Create Azure resources to support a Kubernetes cluster.
- Update a basic release pipeline to build, publish, and deploy multiple Docker containers to the Kubernetes cluster.
- Monitor the build and deployment of your project.

## Prerequisites

The modules in this learning path form a progression. To follow the progression of this series from the beginning, complete the [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true) and [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true) learning paths.

To begin this learning path from the start, follow the link here: [Deploy applications with Azure DevOps](../../../paths/deploy-applications-with-azure-devops/index.yml?azure-portal=true). This module picks up where [Automate Docker container deployments with Azure Pipelines](/training/modules/deploy-docker?azure-portal=true) leaves off.

This module also assumes you have basic familiarity with Kubernetes, although that knowledge isn't required to complete it. If you're new to the topic, we recommend that you complete the [Administer containers in Azure learning path](../../../paths/administer-containers-in-azure/index.yml?azure-portal=true) learning path first. You'll also find additional resources at the end of this module.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

In earlier modules, you met the *Space Game* web team at Tailspin Toys. The *Space Game* web team is here again to work with you in this module:

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps. She's helping the team adopt a more automated process that uses Azure DevOps.
