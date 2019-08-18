In the [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true) learning path, you helped the Tailspin team use Azure DevOps to plan and build a continuous integration (CI) pipeline for the _Space Game_ website.

The Tailspin team's big release is approaching quickly. The team can use Azure DevOps to build and test their code, but how will they deploy the application to an environment that's available to their users?

In this module, you'll continue your journey with the Tailspin team as they set up a continuous delivery (CD) pipeline for the _Space Game_ website.

## Learning objectives

In this module, you'll:

- Learn what continuous delivery (CD) is, why it's important, and what tools you can use.
- Create a basic release pipeline that deploys a web application to Azure App Service.
- Create a release dashboard that monitors the status of each deployment.

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)

To take just this module, go through these modules first to get set up with Azure DevOps and set up your development environment.

* [Get started with Azure DevOps](/learn/modules/get-started-with-devops?azure-portal=true)
* [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true)

When you're ready, make sure you have:

* Your _Space Game_ project loaded in Visual Studio Code.
* A browser window pointing to your fork of the _Space Game_ web site project on GitHub.
* A browser window pointing to your Azure DevOps organization.

> [!IMPORTANT]
> You also need your own Azure subscription to complete the exercises in this module. Don't have an Azure subscription? [Create a free account](https://azure.microsoft.com/free/?azure-portal=true).

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

[!include[](../../shared/includes/meet-irwin-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process using Azure DevOps.