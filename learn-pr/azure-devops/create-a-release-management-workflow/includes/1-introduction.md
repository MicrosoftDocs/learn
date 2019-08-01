In [Create a release pipeline with Azure Pipelines](/learn/modules/create-release-pipeline?azure-portal=true), you built a basic release pipeline. The pipeline has a build stage that builds the artifact and a deploy stage that installs the web app on Azure App Service. Mara and Andy built this pipeline as a proof of concept to demo to the rest of the team.

Of course, an actual release pipeline has more stages that take an artifact all the way to production.

In this module, you'll join the Tailspin web team as they design and build a more complete release management workflow. _Release management_ involves moving a build artifact through its various stages, such as testing and staging, all the way out to a production environment that's available to your users.

A good release management workflow enables you to release more frequently and more consistently. In practice, you'll want to define a process that maps to your team's needs. Here, you'll define a basic workflow that deploys the _Space Game_ web application to a development, test, and staging environment, each running on App Service.

## Learning objectives

In this module, you will:

- Compare the various tools and methods you can use to define a release management workflow
- Identify what makes a high-quality release pipeline
- Promote a build through the development, test, and staging environments

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)

We also recommend you start at the beginning of this learning path, [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops?azure-portal=true).

To take just this module, go through these modules first to set up Azure DevOps and your development environment.

* [Get started with Azure DevOps](/learn/modules/get-started-with-devops?azure-portal=true)
* [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true)

When you're ready, make sure you have the _Space Game_ project loaded in Visual Studio Code and your _Space Game_ project on GitHub handy.

> [!IMPORTANT]
> You also need your own Azure subscription to complete the exercises in this module. You can [get started for free](https://azure.microsoft.com?azure-portal=true) if you don't have an Azure subscription.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more automated process that uses Azure DevOps.