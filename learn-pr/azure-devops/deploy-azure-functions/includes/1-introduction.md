In the [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true) learning path, you built a basic release pipeline that deployed an ASP.NET Core application to Azure App Service. Although that scenario works for a single application, modern solutions often require a combination of applications, services, and other components. This module shows you how to build a more complicated pipeline.

One of the unique benefits of cloud computing is the broad array of *serverless* application options. With *serverless* applications, the execution and resources are dynamically allocated by the cloud provider. As a result, they are never dependent on, nor constrained by, a specific configuration of servers. Although serverless applications technically still run on servers, the development model is drastically simplified by automatically provisioning, scaling, and managing the required infrastructure.

In this module, you'll join the Tailspin Toys web team as they explore one of Azure's core serverless application offerings, Azure Functions. You'll learn how to add an Azure Functions project to an existing CI/CD pipeline and deploy to both Azure App Service and Azure Functions in a single process.

This module focuses on the core build and deployment tasks, but it's important to understand that all of the other features of Azure Pipelines are available for multi-project and Azure Functions solutions. You can integrate testing, multiple stages, and other tasks just as you would for other scenarios. We omit these details here to focus on the core learning objectives.

## Learning objectives

After completing this module, you'll be able to:

- Explain the benefits of Azure Functions and when to use them.
- Extend a basic release pipeline to also deploy an Azure Function app.
- Monitor the build, release, and deployment of your project.

## Prerequisites

The modules in this learning path form a progression. Be sure to first complete these learning paths first:

* [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true)
* [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true)

We also recommend you start at the beginning of this learning path: [Deploy applications with Azure DevOps](../../../paths/deploy-applications-with-azure-devops/index.yml?azure-portal=true). This module extends the knowledge you gained from the [Create a release pipeline in Azure Pipelines](/training/modules/create-release-pipeline/?azure-portal=true) learning path.

[!INCLUDE [](../../shared/includes/project-details-note.md)]

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
