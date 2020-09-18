In this module, you connect a web application to a database. You manage changes to the database schema in Azure Pipelines.

In the [Create a multistage pipeline by using Azure Pipelines](/learn/modules/create-multi-stage-pipeline?azure-portal=true) module, you helped the Tailspin Toys web team design and build a multistage release pipeline. The team uses the pipeline to move changes through a series of stages. Changes move through the _Dev_ stage, the _Test_ stage, and finally the _Staging_ stage, which resembles a production environment.

The stages that you and the team defined provide the overall shape of the pipeline. But you can add more to each stage. For example, in the _Dev_ stage you can verify that multiple components, such as the web application and a database, work as expected in a real environment.

Currently the web application reads test data from local files. In this module, you connect the website to Azure SQL Database and load your database with sample data.

When an application uses a database, the database administrator (DBA) and the app developers work together to design and maintain the *database schema*. Think of the schema as a blueprint that dictates how the data will be organized. Azure DevOps can help developers and DBAs coordinate their plans and deploy database schema changes quickly and safely.

## Learning objectives

In this module, you:

- Connect a relational database to your website. For this example, you use Azure SQL Database and Azure App Service.
- Coordinate changes to the database schema by using a release approval.
- Use PowerShell to share variables among pipeline stages.

## Prerequisites

The modules in this learning path form a progression. To follow the progression from the beginning, start with these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)

We also recommend that you start at the beginning of the [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops?azure-portal=true) learning path.

If you want to go through just this module, set up a development environment on your Windows, macOS, or Linux system. You need these assets:

* An [Azure DevOps organization](https://dev.azure.com?azure-portal=true).
* An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true).
* A [GitHub](https://github.com/join?azure-portal=true) account.
* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
* [.NET Core 3.1 SDK](https://dotnet.microsoft.com/download/dotnet-core/3.1?azure-portal=true).
* [Git](https://git-scm.com/downloads?azure-portal=true).

You can get started with Azure and Azure DevOps for free. You don't need an Azure subscription to work with Azure DevOps. But here you'll use Azure DevOps to deploy to resources that exist in your Azure subscription.

In this environment, you'll complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

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