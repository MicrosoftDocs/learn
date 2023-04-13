In [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true), you built a basic release pipeline that deploys an ASP.NET Core application to Azure App Service. Although this process covers the needs for basic applications, modern solutions often require a combination of applications, services, and other components.

Azure provides great support for traditional app deployments, such as to virtual machines or application services. Another option you might consider is to deploy your app by using a container. A *container* app is one that's packaged and published as a single artifact that can be deployed with all of its dependencies to run in an isolated environment.

In this module, you'll join the Tailspin Toys web team as they explore one way to use containers in Azure. You'll learn how to update your CI/CD pipeline to build a Docker container, publish the container to Azure Container Registry, and deploy the container to App Service.

While this module focuses on the core tasks that are required to build and deploy your container app, it's important to understand that all of the other features of Azure Pipelines are still available for Docker container deployments. You can integrate testing, define multiple stages, and perform other tasks just like you would for your existing applications. We omit these tasks here to keep things focused.

## Learning objectives

After completing this module, you'll be able to:

- Create Azure resources to support a Docker container web application.
- Use YAML pipeline to build, publish, and deploy a Docker container.
- Monitor the build and deployment of your project.

## Prerequisites

The modules in this learning path form a progression. If you want to follow the progression from the beginning, complete the following learning paths:

- [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true)
- [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true)

This module assumes you have basic familiarity with Docker, although that knowledge isn't required to complete it. If you're new to the topic, it's recommended that you complete the [Introduction to Docker containers](/training/modules/intro-to-docker-containers/?azure-portal=true) module first.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the *Space Game* web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps. She's helping the team adopt a more automated process that uses Azure DevOps.
