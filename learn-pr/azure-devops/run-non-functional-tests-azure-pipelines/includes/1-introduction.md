In this module, you'll add non-functional tests &mdash; tests that check characteristics like performance and reliability &mdash; to the pipeline.

In [Run functional tests in Azure Pipelines](/learn/modules/run-functional-tests-azure-pipelines?azure-portal=true), you and the Tailspin web team added UI tests, a form of functional testing, to the pipeline. Functional tests verify the functionality, or behavior, of software. In other words, functional tests verify that each function of the software does what it should.

But what about the non-functional aspects of an application, such as performance and reliability? Once your service is operational and deployed to an environment, how can you determine the performance of your application under both realistic and heavy loads? Does your application expose any possible loopholes or weaknesses that might cause an information breach?

In this module, you'll explore the types of non-functional tests you can run and run load tests in your pipeline with Apache JMeter.

## Learning objectives

In this module, you will:

- Define what non-functional tests are and how they compare to functional tests.
- Identify some of the more popular kinds of non-functional tests you can run.
- Run automated load tests in the pipeline with Apache JMeter.
- Convert test results to a format that Azure Pipelines can visualize for you.

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

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more automated process that uses Azure DevOps.