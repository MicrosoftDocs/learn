This module is about expressing your infrastructure requirements as code. By adopting this practice, you can automatically provision the infrastructure that you need for your application or service.

In the [Deploy applications with Azure DevOps](https://docs.microsoft.com/learn/paths/deploy-applications-with-azure-devops?azure-portal=true) learning path, you built a release pipeline in Azure Pipelines. You deployed a web application to Azure App Service instances that you brought up manually through the Azure portal and through the Azure CLI.

Keeping up with changes in your infrastructure is a challenge. New resources need to be built. Old resources need maintenance. Environments need to be consistent. _Infrastructure as code_ enables you to describe, through code, the infrastructure that you need for your application.

The Tailspin team is making great progress. But how can they further automate their processes to allow them to scale and release even faster?

In this module, you continue your journey with the Tailspin team as they add automatic provisioning to their CI/CD pipeline for the _Space Game_ website.

## Learning objectives

In this module, you'll:

- Learn what we mean by _infrastructure as code_ and why it's a best practice in DevOps.
- Apply a Terraform plan that provisions everything you need to run your web application.
- Add a job to your Azure Pipelines configuration that provisions your infrastructure when the pipeline runs.

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete these learning paths:

- [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
- [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)
- [Deploy applications with Azure DevOps](https://docs.microsoft.com/learn/paths/deploy-applications-with-azure-devops?azure-portal=true)

If you want to start with this learning path, you need to set up a development environment on your Windows, macOS, or Linux system. You need:

* An [Azure DevOps organization](https://dev.azure.com?azure-portal=true)
* An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true)
* A [GitHub](https://github.com/join?azure-portal=true) account
* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
* [.NET Core 3.1 SDK](https://dotnet.microsoft.com/download/dotnet-core/3.1?azure-portal=true)
* [Git](https://git-scm.com/downloads?azure-portal=true)

You can get started with Azure and Azure DevOps for free. You don't need an Azure subscription to work with Azure DevOps, but here you'll use Azure DevOps to deploy to resources that exist in your Azure subscription.

This environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

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

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process by using Azure DevOps.