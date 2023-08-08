Developers often face many challenging tasks and decisions when building apps for the cloud. Creating a properly architected and configured environment can be a time consuming and difficult process. Developers must account for many different concerns in these environments, such as creating resources, applying configurations, setting up monitoring and logging and other tasks. 

The [Azure Developer CLI](/azure/developer/azure-developer-cli/overview) (`azd`) reduces and streamlines these responsibilities to help the developer on their journey from a local development environment to an application successfully deployed on Azure. The tool is designed around a powerful template system that can automate provisioning cloud infrastructure and deploying application code. In the units ahead, you'll learn how to build a new `azd` template from scratch that accomplishes these goals.

> [!NOTE]
> Before working through this module, it's recommended that you have basic working knowledge of the Azure Developer CLI or have completed the [Introduction to Azure Developer CLI](/training/modules/introduction-to-azure-developer-cli/) training module.

## Example scenario

Suppose you work at a startup company that is building a new cloud native e-commerce platform. The app requires a front-end shopping UI and various backend services to process orders. You plan to host the app using Azure services such as App Service, Storage, NoSQL databases and more. As your team grows and experiments with different cloud architectures, you'd like to solve the following project challenges:

* **Rapidly changing infrastructure** - While the app is in active development, the team would like the ability to quickly tear down and recreate the cloud services as architecture changes are made.

* **Onboarding new teams** - Whether you're adding new teams internally or distributing the software as open source code, you'd like to provide a way for new users to easily create their own instance of the cloud infrastructure with the correct configurations.

* **Streamlined cloud skill requirements** - Although the app is designed to be cloud native, developers who are unfamiliar with the cloud may still want to be able to deploy and work on the app.

The Azure Developer CLI solves these challenges by using templates. `azd` templates reliably manage cloud infrastructure and deployments in an automated way using infrastructure as code. They help automate the cloud setup and deployment process using only a few commands, allowing developers who are new to the cloud to still get up and running.

## Learning objectives

In this module, you will:

- Create an Azure Developer CLI template from start to finish
- Explore essential Azure Developer CLI template components, features and workflows

## Prerequisites

- [Installed the Azure Developer CLI](/azure/developer/azure-developer-cli/install-azd?tabs=winget-windows%2Cbrew-mac%2Cscript-linux&pivots=os-windows) locally
- Completed the [Introduction to Azure Developer CLI](/training/modules/introduction-to-azure-developer-cli/) training module
- Basic knowledge of software development workflows, such as packaging, provisioning, and deploying resources

## What is the main goal?

By the end of this session, you'll discover and complete the essential tasks required to build Azure Developer CLI templates.
