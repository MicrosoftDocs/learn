In this learning path, you've been helping the Tailspin Toys team set up an automated release pipeline. The pipeline includes multiple stages, and both functional and nonfunctional tests. 

In this module, you help the team solve another problem, which is how to implement a deployment pattern to release to production in a way that's best for the company and their users. You'll help them evaluate the possibilities and then implement the one they choose.

## Learning objectives

After completing this module, you'll be able to:

- Explain why deployment patterns matter.
- Compare different deployment patterns so that you can choose the one that best suits your needs.
- Apply the blue-green deployment pattern in your pipeline.

## Prerequisites

The modules in this learning path are part of a progression.

To follow the progression from the beginning, be sure to first complete these learning paths:

* [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true)
* [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true)

We also recommend that you start at the beginning of this learning path, [Deploy applications with Azure DevOps](../../../paths/deploy-applications-with-azure-devops/index.yml?azure-portal=true).

If you want to go through just this module, then you need to set up a development environment on your Windows, macOS, or Linux system. You'll need the following resources:

- An [Azure DevOps organization](/azure/devops/pipelines/get-started/pipelines-sign-up) with access to [parallel jobs](/azure/devops/pipelines/licensing/concurrent-jobs). If your organization does not have access to parallel jobs, you can request parallel jobs for free for public or private projects using [this form](https://aka.ms/azpipelines-parallelism-request). Your request will take 2-3 business days.
- An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true)
- A [GitHub](https://github.com/join?azure-portal=true) account
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
- [.NET 6.0 SDK](https://dotnet.microsoft.com/download/dotnet/6.0?azure-portal=true)
- [Git](https://git-scm.com/downloads?azure-portal=true)

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

Mara has prior experience with DevOps. She's helping the team adopt a more automated process that uses Azure DevOps.