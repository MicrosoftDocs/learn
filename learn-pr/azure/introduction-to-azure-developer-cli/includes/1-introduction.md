Developers often face many challenging tasks and decisions when building apps for the cloud. Creating a properly architected and configured environment can be a time consuming and difficult process. Developers must account for many different concerns in these environments, such as creating resources, applying configurations, setting up monitoring and logging, building CI/CD pipelines, and other tasks. The Azure Developer CLI (`azd`) reduces and streamlines these responsibilities to help the developer on their journey from local development environment to an application successfully deployed on Azure.

## Example scenario

Suppose you work at a financial company that is building a cloud native application to manage communication with customers. The app needs to be able to collect user submitted data, send messages to customers and other applications, integrate with backend systems, and scale for future growth and promotions. The necessary Azure architecture to support an enterprise solution like this might include the following Azure resources:

- An App Service and App Service Plan to host the application and APIs
- A Storage Account to hold uploaded files and other assets
- A Service Bus to manage scalable messaging
- A Key Vault instance to store secure app secrets
- Application Insights resources to perform logging and monitoring
- A Cosmos DB for NoSQL instance to permanently store app data
- CI/CD pipelines to ensure changes are reliably deployed through an automated process

Developers spend significant amounts of time and energy creating and properly configuring these types of resources. Setting up Azure environment resources is often a barrier to development progress on the app itself. The Azure Developer CLI is designed to greatly streamline and accelerate the process of moving from local development to provisioning and deploying your application resources to Azure.

## Learning objectives

In this module, you will:

- Evaluate whether the Azure Developer CLI is an appropriate fit for your project
- Describe core Azure Developer CLI workflows and features and how they integrate with an app

## Prerequisites

- Basic knowledge of fundamental cloud concepts
- Basic knowledge of software development workflows, such as packaging, provisioning, and deploying resources

## What is the main goal?

By the end of this session, you'll understand the advantages of the Azure Developer CLI and evaluate whether it's a good fit for optimizing your project workflows.
