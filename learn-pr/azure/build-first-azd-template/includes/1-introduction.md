Developers often face many challenging tasks and decisions when building apps for the cloud. Creating a properly architected and configured environment can be a time consuming and difficult process. Developers must account for many different concerns in these environments, such as creating resources, applying configurations, setting up monitoring and logging, building CI/CD pipelines, and other tasks. 

The Azure Developer CLI (`azd`) reduces and streamlines these responsibilities to help the developer on their journey from local development environment to an application successfully deployed on Azure. The tool is designed around a powerful template system that can automate provisioning cloud infrastructure and deploying application code. In this units ahead, you'll learn how to build a new `azd` template from scratch that accomplishes these goals.

## Example scenario

Suppose you work at a startup company that is building a new cloud native e-commerce platform. The app requires a front-end shopping UI and various backend services to process orders. You plan to host the app on Azure, which means you'll need to leverage Azure services such as App Service, Storage, SQL databases, CI/CD pipelines, and more. As your team grows and experiments with different environment configurations, you'd like to be able to package the essential cloud infrastructure with the app so that it can be created repeatedly. For example, you'd like to solve the following challenges:

* **Onboarding new teams** - Whether you are adding new teams internally or distributing open source software, you'd like to provide a simple way for new teams to create their own copy of the cloud infrastructure. Internal teams may need to redeploy the same infrastructure to new subscriptions, while external users may want the infrastructure created for them so they know it's correct. Azure Developer CLI templates include infrastructure as code templates that create and configure cloud environments for you.

* **Streamlined cloud skill requirements** - Although the app is designed to be cloud native, developers who are unfamiliar with the cloud may still want to deploy and work on the app. Azure Developer CLI templates allow you to automate the cloud setup and deployment process so that even users who are still learning these skills can still get started developing the app itself. As long as the developer understands how to run a few commands, they can recreate the same cloud architecture that would normally require advanced knowledge to build.

* **Dynamic infrastructure** - While the app is in very active development, the team does not want to have to worry about maintaining a perfectly managed cloud environment. They would like the ability to quickly tear down and recreate the cloud services when needed regardless of how significant the new changes are. Azure Developer CLI templates can tear down and recreate infrastructure quickly and reliably in an automated way.

## Learning objectives

In this module, you will:

- Create a simple Azure Developer CLI template from start to finish
- Explore essential Azure Developer CLI template components, features and workflows

## Prerequisites

- The Azure Developer CLI [installed locally](/azure/developer/azure-developer-cli/install-azd?tabs=winget-windows%2Cbrew-mac%2Cscript-linux&pivots=os-windows)
- Basic working knowledge of the Azure Developer CLI
- Basic knowledge of software development workflows, such as packaging, provisioning, and deploying resources

## What is the main goal?

By the end of this session, you'll discover and complete the essential tasks required to build Azure Developer CLI templates.
