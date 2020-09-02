Imagine you're a software developer for an online retailer named *eShopOnContainers*. The retailer uses a cloud-native, microservices-based app developed using .NET Core for its online storefront. You've completed and deployed a new feature to a test environment, but the Product Owner has requested minor changes. You've decided to implement a [GitHub Action](https://help.github.com/actions/getting-started-with-github-actions/about-github-actions) to automate the deployment process.

This module guides you through the process of implementing a continuous integration and continuous deployment (CI/CD) pipeline using GitHub Actions. You'll begin with a *simplified* and *revamped* version of [eShopOnContainers](https://github.com/dotnet-architecture/eShopOnContainers), the companion reference app for the guide: [.NET Microservices: Architecture for Containerized .NET Applications](https://docs.microsoft.com/dotnet/architecture/microservices/). This new version includes a discount coupon feature that can be used at checkout time in the shopping basket.

## Learning objectives

- Understand the key DevOps concepts.
- Implement a simple CI/CD pipeline to deploy the updated microservice to an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- Familiarity with DevOps concepts
- Access to an Azure subscription with **Owner** privilege
- Access to a GitHub account
