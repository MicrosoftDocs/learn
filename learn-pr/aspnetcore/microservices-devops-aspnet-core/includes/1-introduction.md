Imagine that you work as a software engineer for an online retailer named *:::no-loc text="eShopOnContainers":::*. You're responsible for deploying and updating the retailer's online storefront, a cloud-native, microservices-based ASP.NET Core app.

To fulfill project requirements and enhance your team's agile development practices, you decide to implement continuous integration and continuous deployment (CI/CD) through [GitHub Actions](https://help.github.com/actions/getting-started-with-github-actions/about-github-actions). CI/CD pipelines use a series of automated steps to compile, test, configure, and deploy apps from build through all environments.

You begin with a simplified, revamped version of [:::no-loc text="eShopOnContainers":::](https://github.com/dotnet-architecture/eShopOnContainers), the companion reference app for the [.NET Microservices: Architecture for Containerized .NET Applications](/dotnet/architecture/microservices) guide. Because each microservice deploys independently, you start by setting up CI/CD for a single service.

The new app version includes a discount coupon that buyers can use in the shopping basket at checkout time. An ASP.NET Core web API named the *coupon service* supports the discount coupon feature. In this module, you use GitHub Actions to implement a CI/CD pipeline for the coupon service.

This module guides you through the following steps:

- Authenticate GitHub Actions to a container registry.
- Securely store sensitive information that GitHub Actions uses.
- Implement an action to build the container image for a microservice.
- Modify and commit the microservice code to trigger a build.
- Implement an action to deploy the updated container to an Azure Kubernetes Service (AKS) cluster.
- Modify and commit a Helm chart to trigger the deployment.
- Revert the microservice to the previous deployment.

[!INCLUDE[Use your own Azure subscription](../../includes/microservices/your-own-az-subscription.md)]

## Prerequisites

- Conceptual knowledge of DevOps practices.
- Conceptual knowledge of containers, Docker, and AKS.
- Access to an Azure subscription with **Owner** permissions.
- Access to a GitHub account.
- Ability to run *development containers* in Visual Studio Code or GitHub Codespaces, set up as described in the following section.

[!INCLUDE[Dev containers](../../includes/dev-containers/required.md)]
