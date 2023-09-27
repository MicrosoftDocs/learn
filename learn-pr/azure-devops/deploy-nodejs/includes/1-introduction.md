In this module, you create an automated CI/CD pipeline for a Node.js application hosted on Azure. You learn how a project can begin in GitHub and flow through Azure Pipelines to build, publish, and deploy to Azure App Service.

This module focuses on the core tasks that are required to build and deploy your app. It's also important to understand that all of the other features of Azure Pipelines are still available for Node.js applications. You can integrate testing, define multiple stages, and perform other tasks just like you would for your existing applications. We omit these tasks here to keep things focused.

> [!NOTE]
> This is a **_guided project_** module where you complete an end-to-end project by following step-by-step instructions.

## Learning objectives

In this module, you practice how to:

- Fork a GitHub repo.
- Create an App Service environment.
- Create an Azure Pipeline that builds and deploys a basic Node.js application to Azure App Service.

## Prerequisites

- A GitHub account where you can create a repository. [Create one for free](https://github.com).
- An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true). You can get started with Azure for free.
- An [Azure DevOps organization](/azure/devops/pipelines/get-started/pipelines-sign-up) with access to [parallel jobs](/azure/devops/pipelines/licensing/concurrent-jobs). If your organization doesn't have access to parallel jobs, you can request parallel jobs for free for public or private projects using [this form](https://aka.ms/azpipelines-parallelism-request). Your request takes 2-3 business days.
- Familiarity with Azure App Service and Azure DevOps. If you're new to Azure or Azure DevOps, review these learning paths:

  - [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true)
  - [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true)
  - [Deploy applications with Azure DevOps](../../../paths/deploy-applications-with-azure-devops/index.yml?azure-portal=true)
