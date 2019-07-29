Releasing and delivering software can be a long and tedious process. A build may have to move from a *development* environment to a *testing* environment and then to *staging* and finally to *production*. Each of these stages in the deployment process may have extensive set up procedures and gates and approval processes before the build is allowed to move to the next stage. 

A good release and deployment strategy will have deployments happening quickly. Automation of a majority of the deployment processes allows new software feature to move through the stages at a faster pace, which allows for faster deployments, and thus faster feature releases. Azure Pipelines provides this automation.

## Learning objectives

In this module, you:

- Learn about continuous delivery
- Create a release pipeline that deploys an app to an Azure AppService
- Create a release dashboard that monitors the success of the deployments

## Prerequisites

The modules in this learning path form a progression.

We recommend that you go through the [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true) and [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true) learning paths before starting this module.

If you'd rather take just this module, go through [Get started with Azure DevOps](/learn/modules/get-started-with-devops?azure-portal=true) and [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true) first to set up your Azure DevOps account and set up a development environment on your Windows, macOS, or Linux system.

Make sure you have the _Space Game_ project loaded in Visual Studio Code and your _Space Game_ project on GitHub handy.

> [!IMPORTANT]
> You also need your own Azure subscription to complete the exercises in this module. [Get started for free](https://azure.microsoft.com?azure-portal=true).

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process using Azure DevOps.