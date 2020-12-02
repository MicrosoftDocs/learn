Imagine you're an infrastructure manager and have been asked to provision resources using Terraform. Once you've created your project, you plan to provision your resources with GitHub Actions.

### Provisioning pipelines

In this module, you'll be using Terraform to provision your resources and Maven to build and deploy your application.

Typically there are three steps to deliver application resources:

1. Provision the Account – Provision Azure subscription and resource group.

1. Provision the Application –  Build and deploy the application and configure it.

1. Provision the Infrastructure - Provision database and Azure App Service.

For step 1, you'll use a personal Azure account, with the following items installed:
>  
- An Azure Subscription
- Local installations of Java JDK (1.8+), Maven (3.0+), and the Azure CLI (2.12+)
>

For step 2, you'll use Maven to build and deploy the application.
For step 3, you'll use Terraform to provision the Azure infrastructure.

![Build, Deploy and Provision Pipelines.](../media/1-pipelines.png)

> [!IMPORTANT]
> More information on using Terraform to deploy and build using external State can be located in the summary unit of this module.

## Learning objectives

By the end of this module, you can:

- Create a Terraform configuration for your Azure resources
- Provision your Infrastructure and deploy to Azure
- Set up your project for Continuous Integration and Deployment (CI/CD)

## Prerequisites

As you complete the exercises in this module, you'll use a personal Azure account, you would need to make sure that you have the following items installed:
>  
- An Azure Subscription
- Local installations of Java JDK (1.8+), Maven (3.0+), and the Azure CLI (2.12+)
>