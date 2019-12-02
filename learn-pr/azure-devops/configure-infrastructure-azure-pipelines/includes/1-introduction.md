This module is about automatically configuring your infrastructure to meet the requirements for your application.

In the [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines?azure-portal=true) module, you learned how _infrastructure as code_ enables you to describe, through code, the infrastructure you need for your application.

_Configuration as code_ is a similar concept. However, instead of describing the infrastructure itself, with configuration as code you describe how your infrastructure needs to be configured to run your application or service.

If you’ve ever received a middle-of-the-night emergency support call because of a crashed server, you know the pain of searching through multiple spreadsheets &mdash; or even your memory &mdash; to access the manual steps of setting up a new machine. There is also the difficulty of keeping the development and production environments consistent. An easier way to remove the possibility of human error when initializing machines is to configure them automatically through code. By treating configuration as code, you can configure many systems identically from a single consistent definition.

In this module, you continue your journey with the Tailspin team as they add automatic configuration tasks to their CI/CD pipeline for the _Space Game_ website.

## Learning objectives

In this module, you'll:

- Learn what we mean by _configuration as code_ and the kinds of tools you can use to configure your systems.
- Apply a Ansible playbook that configures service accounts on a Linux virtual machine running on Azure.
- Add a job to your Azure Pipelines configuration that configures your infrastructure when the pipeline runs.

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete these learning paths:

- [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
- [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)
- [Deploy applications with Azure DevOps](https://docs.microsoft.com/learn/paths/deploy-applications-with-azure-devops?azure-portal=true)

We also recommend that you go through the previous module, [Provision infrastructure in Azure Pipelines](/learn/modules/provision-infrastructure-azure-pipelines?azure-portal=true).

If you want to start with this learning path, you need to set up a development environment on your Windows, macOS, or Linux system. You need:

* An [Azure DevOps organization](https://dev.azure.com?azure-portal=true)
* An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true)
* A [GitHub](https://github.com/join?azure-portal=true) account
* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
* [.NET Core 2.1](https://www.microsoft.com/net/download?azure-portal=true)
* [Git](https://git-scm.com/downloads?azure-portal=true)

You can get started with Azure and Azure DevOps for free. You don't need an Azure subscription to work with Azure DevOps, but here you'll use Azure DevOps to configure Azure resources that exist in your Azure subscription.

This environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

TODO: Add Mara to the narrative.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process using Azure DevOps.