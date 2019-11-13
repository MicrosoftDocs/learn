In this learning path, you've been helping the Tailspin team set up an automated release pipeline, complete with multiple stages and both functional and non-functional tests. 

In this module, you help the team solve another problem. How do they implement a deployment pattern that lets them release to production in a way that's best both for the company and for their users? You'll help them evaluate the different possibilities and then implement the one they decide on.

## Learning objectives

In this module, you will:

- Learn why deployment patterns matter.
- Compare different deployment patterns so you can choose the one that best suits your needs.
- Apply the blue-green deployment pattern in your pipeline.

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)

We also recommend you start at the beginning of this learning path, [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops?azure-portal=true).

If you want to go through just this module, you need to set up a development environment on your Windows, macOS, or Linux system. You need:

* An [Azure DevOps organization](https://dev.azure.com?azure-portal=true)
* An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true)
* A [GitHub](https://github.com/join?azure-portal=true) account
* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
* [.NET Core 2.1](https://www.microsoft.com/net/download?azure-portal=true)
* [Git](https://git-scm.com/downloads?azure-portal=true)

You can get started with Azure and Azure DevOps for free. You don't need an Azure subscription to work with Azure DevOps, but here you'll use Azure DevOps to deploy to Azure resources that exist in your Azure subscription.

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

Mara has prior experience with DevOps and is helping the team adopt a more automated process that uses Azure DevOps.