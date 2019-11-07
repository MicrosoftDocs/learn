In the [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true) learning path, you helped the Tailspin Toys team use Azure DevOps to plan and build a continuous integration pipeline for the _Space Game_ website.

The Tailspin team's big release is approaching. The team can use Azure DevOps to build and test their code. But how can they quickly deploy the application to an environment that's available to their users?

In this module, you'll continue your journey with the Tailspin team as they set up a continuous delivery (CD) pipeline for the _Space Game_ website.

## Learning objectives

In this module, you'll:

- Learn what continuous delivery is, why it's important, and what tools you can use.
- Create a basic release pipeline that deploys a web application to Azure App Service.
- Examine pipeline analytics to understand the health and history of your releases.

## Prerequisites

The modules in this learning path and previous learning paths form a progression.

To follow the progression from the beginning, be sure to first complete these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)

If you want to start with this learning path, set up a development environment on your Windows, macOS, or Linux system. You need:

* An [Azure DevOps organization](https://dev.azure.com?azure-portal=true).
* An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true).
* A [GitHub](https://github.com/join?azure-portal=true) account.
* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
* [.NET Core 2.1](https://www.microsoft.com/net/download?azure-portal=true).
* [Git](https://git-scm.com/downloads?azure-portal=true).

You can get started with Azure and Azure DevOps for free. You don't need an Azure subscription to work with Azure DevOps. But here you'll use Azure DevOps to deploy to Azure resources in your Azure subscription.

You'll use this environment to complete the exercises in this module and future modules. You can also use this environment to apply your new skills to your own projects.

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

Mara has prior experience with DevOps. She's helping the team adopt a more streamlined process by using Azure DevOps.