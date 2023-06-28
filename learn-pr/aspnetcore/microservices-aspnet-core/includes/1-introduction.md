Imagine that you work as a software developer for an online retailer named *:::no-loc text="eShopOnContainers":::*. The retailer's online storefront is a cloud-native, microservices-based ASP.NET Core app that sells various products like pins, T-shirts, and coffee mugs.

A new project is underway to implement discount coupon codes that buyers can use in their shopping baskets at checkout time. A containerized ASP.NET Core web API named the *coupon service* manages the discount coupon feature. Your assignment is to finish writing and deploying the coupon service code.

## Learning objectives

- Examine an existing ASP.NET Core microservices app running in Azure Kubernetes Service (AKS).
- Implement and containerize a new ASP.NET Core coupon microservice for the app.
- Publish the Docker container image to Azure Container Registry.
- Deploy the Docker container to the existing multicontainer AKS cluster.

[!INCLUDE[Use your own Azure subscription](../../includes/microservices/your-own-az-subscription.md)]

## Prerequisites

### Required knowledge and skills

- Experience writing C# at the beginner level.
- Familiarity with RESTful service concepts and HTTP actions like `GET`, `POST`, `PUT`, and `DELETE`.
- Conceptual knowledge of containers at a beginner level.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.
- Basic Git commands, specifically cloning.

### Account requirements

- An Azure account, with Administrator access.
- A GitHub account.

### Software requirements

To simplify the setup process, this module uses a dev container. The dev container includes all the required software, including the Azure CLI, Docker, and Visual Studio Code extensions. You have two options for using the dev container:

#### Option 1: Use GitHub Codespaces (recommended)

Using the dev container in [GitHub Codespaces](https://code.visualstudio.com/docs/remote/codespaces) provides the easiest way to complete this module. Codespaces are hosted in the cloud and can be accessed from a web browser or Visual Studio Code.

#### Option 2: Use your local machine

You can run the same dev container locally on your machine. To do so, you need the following software:

- Visual Studio Code.
- The [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for Visual Studio Code.
- A compatible container runtime, such as Docker Desktop.
