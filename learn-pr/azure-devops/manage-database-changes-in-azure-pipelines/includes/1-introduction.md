In [Create a release management workflow with Azure Pipelines](/learn/modules/create-a-release-management-workflow?azure-portal=true), you created a comprehensive Azure pipeline that deployed an application to separate App Services for each environment, _dev_, _test_, _staging_, and _production_. Each stage of the pipeline had a trigger or approval before the next stage could run. 

However, the web site is still using the test data files from within the application.

In this module, you'll join the Tailspin web team as they design and build a pipeline that manages the database as well as build and deploy the application that uses that database.

Frequently, when an application uses a database, the database administrator and the developers of the application must work together to design and maintain the schema of that database. DevOps helps with the collaboration between the developers and operations, in this case the database administrator.

## Learning objectives

In this module, you:

- Access an Azure SQL database from your App Service.
- Add database schema changes to Azure pipeline approvals.
- TBD

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)

We also recommend you start at the beginning of this learning path, [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops?azure-portal=true).

To take just this module, go through these modules first to get set up with Azure DevOps and set up your development environment.

* [Get started with Azure DevOps](/learn/modules/get-started-with-devops?azure-portal=true)
* [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true)

When you're ready, make sure you have:

* Your _Space Game_ project loaded in Visual Studio Code.
* A browser window pointing to your fork of the _Space Game_ web site project on GitHub.
* A browser window pointing to your Azure DevOps organization.

> [!IMPORTANT]
> You also need your own Azure subscription to complete the exercises in this module. You can [get started for free](https://azure.microsoft.com?azure-portal=true) if you don't have an Azure subscription.

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
