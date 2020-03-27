In this module, you'll add functional tests to the pipeline. These tests verify an application's behavior.

In the [Manage database changes in Azure Pipelines](/learn/modules/manage-database-changes-in-azure-pipelines?azure-portal=true) module, you helped the Tailspin Toys web team connect their web application to Azure SQL Database. You also used a release approval to help the developers and the database administrator manage changes to the database schema.

The stages that you and the team defined provide the overall shape of your pipeline. But you can add more to each stage. For example, in the _Test_ stage, Amita still tests the web application manually as she always has. When she's satisfied, she manually promotes the application to _Staging_. In _Staging_, management reviews the new features and decides whether to make the release publicly available.

In the [Run quality tests in your build pipeline using Azure Pipelines](/learn/modules/run-quality-tests-build-pipeline?azure-portal=true) module, you incorporated unit and code coverage tests into the build process. These tests help avoid regression bugs and ensure that the code meets the company's standards for quality and style. But what kinds of tests can you run after a service is operational and deployed to an environment?

## Learning objectives

In this module, you will:

- Define functional tests and identify some popular kinds of tests.
- Map manual testing steps to automated test cases.
- Run automated UI tests locally and in the pipeline by using Selenium.

## Prerequisites

The modules in this learning path form a progression. To follow the progression from the beginning, complete these learning paths first:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)

We also recommend that you start at the beginning of the [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops?azure-portal=true) learning path.

If you want to go through just this module, you need to set up a development environment on your Windows, macOS, or Linux system. You need these assets:

* An [Azure DevOps organization](https://dev.azure.com?azure-portal=true).
* An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true).
* A [GitHub](https://github.com/join?azure-portal=true) account.
* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
* [.NET Core 3.1 SDK](https://dotnet.microsoft.com/download/dotnet-core/3.1?azure-portal=true).
* [Git](https://git-scm.com/downloads?azure-portal=true).

You can get started with Azure and Azure DevOps for free. You don't need an Azure subscription to work with Azure DevOps, but here you'll use Azure DevOps to deploy to resources that exist in your Azure subscription.

This environment lets you complete the exercises in this module and future modules. You can also use it to apply your new skills to your own projects.

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