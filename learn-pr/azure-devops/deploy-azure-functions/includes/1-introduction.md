In the [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true) learning path, you built a basic release pipeline that deployed an ASP.NET Core application to Azure App Service. Although that scenario works for a single application, modern solutions often require a combination of applications, services, and other components. This module shows you how to build a more complicated pipeline.

In this module, you'll learn how to add an Azure Functions project to an existing CI/CD pipeline and deploy to both Azure App Service and Azure Functions in a single process. This module focuses on the core build and deployment tasks.

## Learning objectives

After completing this module, you'll be able to:

- Describe when to use Azure Functions for app development projects
- Create Azure App Service and Azure Functions environments
- Deploy to both Azure App Service and Azure Functions in a single pipeline with Azure Pipelines


## Prerequisites

The modules in this learning path form a progression:

* [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true)
* [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true)

This module also assumes you have basic familiarity with Azure Functions, although that knowledge is not required to complete it. If you're new to the topic, we recommend that you complete the [Create serverless applications](../../../paths/create-serverless-applications/index.yml?azure-portal=true) learning path first.

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!INCLUDE [](../../shared/includes/meet-andy-short-col.md)]

[!INCLUDE [](../../shared/includes/meet-irwin-short-col.md)]

[!INCLUDE [](../../shared/includes/meet-tim-short-col.md)]

[!INCLUDE [](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps. Mara is helping the team adopt a more automated process that uses Azure DevOps.
