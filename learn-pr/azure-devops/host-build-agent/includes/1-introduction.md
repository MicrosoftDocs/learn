In this module, you set up your own build agent running on a Microsoft Azure virtual machine.

Up until now, you used a Microsoft-hosted agent that runs Ubuntu to build the _Space Game_ web application. Most of the time, a Microsoft-hosted agent can do everything you need.

However, you occasionally need additional processing power, disk space, or time to build your applications. In this module, you learn how to set up your own build agent, which can run either in the cloud or on-premises. You follow along with the Tailspin web team as they set up a build agent that runs on an Azure virtual machine (VM).

## Learning objectives

After completing this module, you'll be able to:

- Choose when to use Microsoft-hosted build agents and when to host your own
- Describe the options you have when you're managing your own build agents
- Bring up and configure your own agent to work with Azure Pipelines
- Connect your agent to a pipeline and build your application

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete the [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true) learning path.

We also recommend you start at the beginning of this learning path, [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true).

If you want to go through just this module, you need to set up a development environment on your Windows, macOS, or Linux system. You need:

- An [Azure DevOps organization](https://dev.azure.com?azure-portal=true)
- An Azure subscription
- A [GitHub](https://github.com/join?azure-portal=true) account
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
- [.NET 6.0 SDK](https://dotnet.microsoft.com/download/dotnet/6.0?azure-portal=true)
- [Git](https://git-scm.com/downloads?azure-portal=true)

You can get started with Azure DevOps for free.

This environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here are the team members you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process by using Azure DevOps.