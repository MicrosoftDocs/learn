Imagine you're a software developer for an online retailer named *eShopOnContainers*. The retailer's online storefront is a cloud-native, microservices-based .NET Core app. Management has asked you to enhance the agile development practices by implementing a continuous integration and continuous deployment (CI/CD) pipeline. You've decided to implement [GitHub Actions](https://help.github.com/actions/getting-started-with-github-actions/about-github-actions) to automate the build and deployment process.

This module guides you through the process of implementing a CI/CD pipeline using GitHub Actions. You'll begin with a *simplified* and *revamped* version of [eShopOnContainers](https://github.com/dotnet-architecture/eShopOnContainers), the companion reference app for the guide: [.NET Microservices: Architecture for Containerized .NET Applications](https://docs.microsoft.com/dotnet/architecture/microservices). This new version includes a discount coupon feature that can be used at checkout time in the shopping basket.

[!INCLUDE[Use your own Azure subscription](../../includes/microservices/your-own-az-subscription.md)]

## Learning objectives

In this module, you will:

- Create an Azure service principal to authenticate GitHub Actions to a container registry.
- Create secrets in GitHub to store sensitive information required for GitHub Actions to use the service principal.
- Implement a GitHub Action to build the container image for a microservice.
- Modify and commit the microservice code to trigger a build.
- Implement a GitHub Action to deploy a container image to a Kubernetes cluster from a container registry.
- Modify and commit a Helm chart to increment the app version number and trigger a deployment.
- Revert the microservice to a previous deployment.

## Prerequisites

- Familiarity with DevOps concepts
- Access to an Azure subscription with **Owner** privilege
- Access to a GitHub account
