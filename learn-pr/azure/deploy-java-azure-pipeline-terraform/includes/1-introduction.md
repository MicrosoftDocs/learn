Imagine you're an infrastructure manager and have been asked to provision your Azure resources using Terraform. Once you've created your project, you plan to build/deploy your application with GitHub Actions.

## Provision, Build, and Deploy pipelines

As an Infrastructure Manager, you aim to achieve automation of both infrastructure **provisioning** and application **build/deploy** using **three** pipelines - **Account**, **Infrastructure** and **Application**:

1. **Account** – Azure subscriptions, resource groups, vnets, subnets, express route circuits…

1. **Infrastructure** - Databases and Azure App Service instances.

1. **Application** – Java applications, and their dependencies.

There are several tools available to help you achieve these goals. However, since you're already using GitHub for your code repository, you decide to investigate GitHub Actions to see if it provides the automation you need.

- For the **Account** pipeline, you'll use a personal Azure account.
- For the **Infrastructure** pipeline, you'll use Terraform and GitHub Actions to provision the Azure infrastructure.
- For the **Application** pipeline, you'll use Maven and GitHub Actions to build and deploy your application.

## Learning Goals

By the end of this module, you can:

- Create a Terraform configuration for your Azure resources
- Provision your Infrastructure and deploy to Azure
- Set up your project for Continuous Integration and Deployment (CI/CD)

## Prerequisites

As you complete the exercises in this module, you'll use a personal Azure and GitHub account.
