In this module, you set up your own build agent running on an Azure virtual machine.

Up until now, you used a Microsoft-hosted agent that runs Ubuntu to build the _Space Game_ web application. Most of the time, a Microsoft-hosted agent can do everything you need.

However, you occasionally need additional processing power, disk space, or time to build your applications. In this module, you learn how to set up your own build agent, which can run either in the cloud or on-premises. You follow along with the Tailspin web team as they set up a build agent that runs on an Azure virtual machine (VM).

## Learning objectives

In this module, you will:

- Choose when to use Microsoft-hosted build agents and when to host your own.
- Describe your options for managing your own build agents.
- Bring up and configure your own agent to work with Azure Pipelines.
- Connect your agent to a pipeline and build your application.

## Prerequisites

The prerequisites are the same as those in the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true) module.

Make sure that the _Space Game_ project is loaded in Visual Studio Code and available on GitHub.

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here are the team members you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process by using Azure DevOps.