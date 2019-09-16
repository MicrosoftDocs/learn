In [Create a release pipeline with Azure Pipelines](/learn/modules/create-release-pipeline?azure-portal=true), you built a basic release pipeline. That pipeline has a _Build_ stage that builds the artifact and a _Deploy_ stage that installs the web app on Azure App Service. Mara and Andy built this pipeline as a proof of concept that they showed to the rest of the team.

Of course, an actual release pipeline has more stages, each with its own set of tasks, that take an artifact all the way to production.

In this module, you'll join the Tailspin web team as they design a release management workflow, which lays out the stages for a release pipeline. _Release management_ is the process of moving a build artifact through various pipeline stages, such as _Test_ and _Staging_, all the way out to a production environment that's available to your users.Next you'll implement that workflow by creating an actual release pipeline. 

A good release management workflow enables you to release more frequently and more consistently. In practice, you'll want to define a process that maps to your team's needs. Here, you'll create a basic workflow. That means first designing the environments, which define the runtimes of each stage in the pipeline.  You'll then deploy the _Space Game_ web application to these stages: _Dev_, _Test_ and _Staging_. Each stage runs on App Service.

## Learning objectives

In this module, you will:

- Identify the stages, or major divisions of the pipeline, that you need.
- Understand when to use conditions, triggers, and approvals to promote changes from one stage to the next.
- Promote a build through _Dev_, _Test_, and _Staging_.

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)

We also recommend you start at the beginning of this learning path, [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops?azure-portal=true).

If you want to complete just this module, first through the following modules to set up Azure DevOps and your development environment.

* [Get started with Azure DevOps](/learn/modules/get-started-with-devops?azure-portal=true)
* [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true)

When you're ready, make sure you have:

* Your _Space Game_ project loaded in Visual Studio Code.
* A browser window pointing to your fork of the _Space Game_ web site project on GitHub.
* A browser window pointing to your Azure DevOps organization.

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