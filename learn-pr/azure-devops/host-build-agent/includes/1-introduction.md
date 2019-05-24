In this module, you'll set up your own build agent running on an Azure virtual machine.

Up until now, you used a Microsoft-hosted agent running Ubuntu to build the _Space Game_ web application. Many times, a Microsoft-hosted agent can do everything you need.

However, there are times when you need additional processing power, disk space, or time to build your applications. In this module, you'll see how to set up your own build agent, which can run either in the cloud or on-premises. You'll follow along with the Tailspin web team as they set up a build agent running on an Azure virtual machine (VM).

## Learning objectives

In this module, you will:

- Choose when to use Microsoft-hosted build agents and when to host your own
- Describe the options you have when managing your own build agents
- Bring up and configure your own agent to work with Azure Pipelines
- Connect your agent to a pipeline and build your application

## Prerequisites

The prerequisites are the same as the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true) module.

Make sure you have the _Space Game_ project loaded in Visual Studio Code and your _Space Game_ project on GitHub handy.

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process using Azure DevOps.