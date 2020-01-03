This module is about building automation to provision databases in Azure Pipelines, by using Azure Resource Manager templates and Azure SQL Database as an example.

In this module, you use _infrastructure as code_ to deploy the _Space Game_ web application that's using a SQL database. You deploy your infrastructure by using an Azure Resource Manager template and a multistage pipeline with Azure Pipelines. This pipeline will also manage changes to the database schema. You use Azure Key Vault to store secrets and later access those secrets from the Azure Resource Manager template and Azure Pipelines.

In [Manage database changes in Azure Pipelines](/learn/modules/manage-database-changes-in-azure-pipelines/?azure-portal=true), you added stages to your pipeline. These stages checked for database schema changes, waited for DBA approval of those changes, and then applied the changes to the database.

However, you created the SQL Server logical instance, the SQL database, and the Azure App Service infrastructure manually. Here, you automate the infrastructure creation from a stage in Azure Pipelines.

## Learning objectives

In this module, you:

- Deploy your infrastructure by using an Azure Resource Manager template in Azure Pipelines.
- Create your Azure SQL database with data from a *.bacpac* file in your Azure Resource Manager template.
- Use Azure Key Vault to store and access secrets from Azure Pipelines and your Azure Resource Manager template.

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)
* [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops?azure-portal=true)

This module builds on [Manage database changes in Azure Pipelines](/learn/modules/manage-database-changes-in-azure-pipelines/?azure-portal=true), from the [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops?azure-portal=true) learning path. In that module, you provisioned infrastructure manually. In this module, you build an Azure Resource Manager template that produces the same result through automation.

We also recommend that you start at the beginning of this learning path: [Automate your deployments with Azure DevOps](/learn/paths/automate-deployments-azure-devops?azure-portal=true).

If you want to go through just this module, you need to set up a development environment on your Windows, macOS, or Linux system. You need:

* An [Azure DevOps organization](https://dev.azure.com?azure-portal=true).
* An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true).
* A [GitHub](https://github.com/join?azure-portal=true) account.
* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
* [.NET Core 2.1](https://dotnet.microsoft.com/download/dotnet-core/2.1?azure-portal=true).
* [Git](https://git-scm.com/downloads?azure-portal=true).

You can get started with Azure and Azure DevOps for free.

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