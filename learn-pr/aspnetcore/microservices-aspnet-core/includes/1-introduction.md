Imagine that you work as a software developer for an online retailer named *:::no-loc text="eShopOnContainers":::*. The retailer's online storefront is a cloud-native, microservices-based ASP.NET Core app that sells various products like pins, T-shirts, and coffee mugs.

A new project is underway to implement discount coupon codes that buyers can use in their shopping baskets at checkout time. A containerized ASP.NET Core web API named the *coupon service* manages the discount coupon feature. Your assignment is to finish writing and deploying the coupon service code.

## Learning objectives

- Examine an existing ASP.NET Core microservices app running in Azure Kubernetes Service (AKS).
- Implement and containerize a new ASP.NET Core coupon microservice for the app.
- Publish the Docker container image to Azure Container Registry.
- Deploy the Docker container to the existing multicontainer AKS cluster.

[!INCLUDE[Use your own Azure subscription](../../includes/microservices/your-own-az-subscription.md)]

## Prerequisites

- Beginner-level experience with C# code.
- Familiarity with RESTful service concepts and HTTP actions like `GET`, `POST`, `PUT`, and `DELETE`.
- Conceptual knowledge of containers, Docker, and AKS.
- Access to an Azure subscription.
- Ability to run *development containers* in Visual Studio Code or GitHub Codespaces, as described in the following section.

[!INCLUDE[Dev containers](../../includes/dev-containers/required.md)]

