Imagine you're a software developer for an online retailer named eShopOnContainers. The retailer uses a cloud-native, microservices-based application developed using .NET Core for its online storefront.

You've just completed and deployed to a test environment the implementation of a new feature but the Product Owner keeps asking for minor changes. So you've decided to implement a [GitHub Action](https://help.github.com/en/actions/getting-started-with-github-actions/about-github-actions) to automate the process.

This module guides you through the process to implement a CI/CD pipeline using GitHub Actions.

We'll begin with a *simplified* and *revamped* version of [eShopOnContainers](https://github.com/dotnet-architecture/eShopOnContainers), the companion reference application for the guide: [.NET Microservices: Architecture for Containerized .NET Applications](https://docs.microsoft.com/dotnet/architecture/microservices/). This new version includes a discount coupon feature, that you can use at checkout time in the shopping basket.

## Learning objectives

- Understand the key DevOps concepts.
- Implement a simple CI/CD pipeline to deploy the updated microservice to an AKS cluster.

## Prerequisites

- Familiarity with DevOps concepts
- Access to an Azure subscription with **Owner** privilege
- Access to a GitHub account
