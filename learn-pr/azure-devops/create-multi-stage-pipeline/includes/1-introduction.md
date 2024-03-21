In [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true), you built a basic release pipeline. That pipeline has a *Build* stage that builds the artifact, and a *Deploy* stage that installs the web app on Azure App Service. Mara and Andy built this pipeline as a proof of concept that they showed to the rest of the team.

An actual release pipeline has more stages. Each stage has its own set of tasks that can potentially take an artifact all the way to production.

In this module, you join the Tailspin Toys web team as they design a realistic release pipeline that contains multiple stages. You also learn different ways to control how an artifact is promoted from one stage to the next.

A good release-management workflow enables you to release more frequently and more consistently. In practice, you want to define a process that maps to your team's needs. Here you create a basic workflow. That means first designing the environments. The environments define the runtimes of each stage in the pipeline.  Then, you deploy the *Space Game* web app to these stages: *Dev*, *Test*, and *Staging*. Each stage deploys the app to its own App Service instance.

## Learning objectives

After completing this module, you're able to:

- Identify the *stages*, or major divisions of the pipeline, that you need to implement in a multistage pipeline.
- Explain when to use conditions, triggers, and approvals to promote changes from one stage to the next.
- Promote a build through these stages: *Dev*, *Test*, and *Staging*.

## Prerequisites

The modules in this learning path form a progression. To follow the progression from the beginning, be sure to first complete these learning paths:

- [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true)
- [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true)

We also recommend you start at the beginning of this learning path: [Deploy applications with Azure DevOps](../../../paths/deploy-applications-with-azure-devops/index.yml?azure-portal=true).

If you want to go through just this module, you need to set up a development environment on your Windows, macOS, or Linux system. You need:

[!include[](../../shared/includes/prerequisites.md)]

You can get started with Azure and Azure DevOps for free. You don't need an Azure subscription to work with Azure DevOps. But in this module, you use Azure DevOps to deploy to Azure resources that exist in your Azure subscription.

Use this environment to complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the *Space Game* web team at Tailspin Toys in previous modules. As a refresher, here's who you work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps. She's helping the team adopt a more automated process that uses Azure DevOps.
