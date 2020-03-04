In [Create a release pipeline with Azure Pipelines](/learn/modules/create-release-pipeline?azure-portal=true), you built a basic release pipeline that deployed an ASP.NET Core application to an Azure App Service. While this mainstream scenario covered the needs of a basic application, modern solutions often require a combination of applications, services, and other components.

One of the unique benefits cloud computing has delivered on is the broad array of *serverless* application options. *Serverless* applications are those where the application's execution and resources are dynamically allocated by the cloud provider as needed. As a result, they are never dependent on, or constrained by, a specific configuration of servers. While these applications still technically run on servers, they drastically simplify the development model by automatically provisioning, scaling, and managing the infrastructure required.

In this module, you'll join the Tailspin Toys web team as they explore one of Azure's core serverless application offerings, Azure Functions. You'll learn about how an Azure Functions project can be added to an existing CI/CD pipeline in order to deploy both an Azure App Service and an Azure Function as part of the same process.

While this module focuses on the core build and deploy jobs, it's important to understand that all of the other features of Azure Pipelines are still available for multi-project and Azure Functions solutions. You can integrate testing, multiple stages, and other tasks just like you would for other scenarios. They're just skipped for this module to keep things focused.

## Learning objectives

In this module, you will:

- Create Azure resources to support a multi-tier web application and an Azure Function.
- Extend a basic release pipeline to also deploy an Azure Functions application.
- Monitor the build, release, and deployment of the project.

## Prerequisites

The modules in this learning path form a progression. To follow the progression from the beginning, be sure to first complete these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)

We also recommend you start at the beginning of this learning path: [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops?azure-portal=true). This module picks up where [Create a release pipeline in Azure Pipelines](/learn/modules/create-release-pipeline/?azure-portal=true) leaves off.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-irwin-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps. She's helping the team adopt a more automated process that uses Azure DevOps.