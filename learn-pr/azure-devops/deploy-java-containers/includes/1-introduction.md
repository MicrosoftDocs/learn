Azure and Azure DevOps support developing almost any kind of application, including Java. You can build and deploy a Java application to an Azure virtual machine, app service, serverless solution, or container, or to another cloud or on-premises.

In this module, you create an automated pipeline to deploy a Java application in a Docker container to Azure App Service. You begin a project in GitHub and set up a continuous integration/continuous deployment (CI/CD) flow through Azure Pipelines to build, publish, and deploy to Azure.

>[!NOTE]
>This module focuses on the core tasks to build and deploy the example app, but Java applications can use all the same Azure Pipelines features as all other apps. You can integrate testing, define multiple stages, and do the same tasks as for your existing apps. This module omits those features to focus on the learning path.

## Learning objectives

- Understand how Azure and Azure DevOps support Java applications.
- Create a project in GitHub that builds and deploys a containerized Java application to Azure.
- Create an automated Azure Pipelines CI/CD pipeline that builds and deploys your app to App Service.

## Prerequisites

To complete this module, you need the following prerequisites:

- A GitHub account.
- Access to an Azure subscription with **Owner** role. If you don't have one, [get an Azure account for free](https://azure.microsoft.com/free/?azure-portal=true).
- An Azure DevOps organization with **Owner** role, [Project Collection Administrators](/azure/devops/organizations/security/change-organization-collection-level-permissions) group membership, or collection-level **Create new projects** permission. Organization owners are automatically members of the **Project Collection Administrators** group. If you don't have an Azure DevOps organization, [create one for free](/azure/devops/organizations/accounts/create-organization).

  >[!IMPORTANT]
  >To run the pipeline in this module, your Azure DevOps project must be able to run parallel jobs on Microsoft-hosted machines. Most free Azure DevOps projects allow one Microsoft-hosted parallel job with a certain amount of free minutes available. For more information, see [Check for available parallel jobs](/azure/devops/pipelines/troubleshooting/troubleshooting#check-for-available-parallel-jobs).

The module is self-contained so you can complete it on its own, but assumes some familiarity with the following technologies:

- Java language and programming
- Azure deployment environments like App Service
- Azure DevOps components and processes

If you're new to Azure DevOps, see the following learning path series for guidance:

* [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true)
* [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true)
* [Deploy applications with Azure DevOps](../../../paths/deploy-applications-with-azure-devops/index.yml?azure-portal=true)

In the next unit, you set up your GitHub repo, Azure DevOps organization, and Azure resources for this module.