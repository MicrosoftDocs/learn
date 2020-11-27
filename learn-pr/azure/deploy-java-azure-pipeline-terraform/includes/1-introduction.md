Imagine you're an infrastructure manager and have been asked to provision resources using Terraform. Once you've created your project, you plan to use CI/CD to deploy to Azure.

## Three pipelines

![Build, Deploy and Provision Pipelines.](../media/1-pipelines.png)

### Build/Deploy

- Maven

### Provision

Multiple provisioning pipelines

- IT infra team – provisions subscription, resource group, vnet, subnet, express route circuits …

- Business project app team – provisions apps and configures them

- Business project infra team - provisions database, cache, Azure App Service …
  - Use terraform

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