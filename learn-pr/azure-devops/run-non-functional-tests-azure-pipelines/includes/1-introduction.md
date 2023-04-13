In this module, you'll add nonfunctional tests to the pipeline. These tests check characteristics like performance and reliability.

In [Run functional tests in Azure Pipelines](/training/modules/run-functional-tests-azure-pipelines?azure-portal=true), you and the Tailspin Toys web team added UI tests to the pipeline. UI tests are a form of functional testing. Functional tests verify the functionality, or behavior, of software. In other words, functional tests verify that each function of the software does what it should.

But what about the nonfunctional aspects of an application, such as performance and reliability? After your service is operational and deployed to an environment, how can you determine the application's performance under both realistic and heavy loads? Does your application expose any loopholes or weaknesses that might cause an information breach?

In this module, you'll explore the types of nonfunctional tests you can run. You'll run load tests in your pipeline by using Apache JMeter.

## Learning objectives

After completing this module, you'll be able to:

- Define the role of nonfunctional tests and explain how they compare to functional tests.
- Identify some popular kinds of nonfunctional tests you can run.
- Run automated load tests in the pipeline by using Apache JMeter.
- Convert test results to a format that Azure Pipelines can visualize for you.

## Prerequisites

The modules in this learning path are part of a progression. To follow the progression from the beginning, be sure to first complete these learning paths:

* [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true)
* [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true)

We also recommend that you start at the beginning of the [Deploy applications with Azure DevOps](../../../paths/deploy-applications-with-azure-devops/index.yml?azure-portal=true) learning path.

If you want to go through just this module, you need to set up a development environment on your Windows, macOS, or Linux system. You need the following resources:

- An [Azure DevOps organization](/azure/devops/pipelines/get-started/pipelines-sign-up) with access to [parallel jobs](/azure/devops/pipelines/licensing/concurrent-jobs). If your organization does not have access to parallel jobs, you can request parallel jobs for free for public or private projects using [this form](https://aka.ms/azpipelines-parallelism-request). Your request will take 2-3 business days.
- An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true)
- A [GitHub](https://github.com/join?azure-portal=true) account
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
- [.NET 6.0 SDK](https://dotnet.microsoft.com/download/dotnet/6.0?azure-portal=true)
- [Git](https://git-scm.com/downloads?azure-portal=true)

You can get started with Azure and Azure DevOps for free. You don't need an Azure subscription to work with Azure DevOps, but here you'll use Azure DevOps to deploy to resources that exist in your Azure subscription.

The development environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps. She's helping the team adopt a more automated process that uses Azure DevOps.
