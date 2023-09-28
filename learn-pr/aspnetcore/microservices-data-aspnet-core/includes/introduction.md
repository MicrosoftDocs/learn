Imagine you're a software developer for an online retailer. Your company uses an app named *:::no-loc text="eShopOnContainers":::* as its online storefront. The storefront is a cloud-native, microservices-based ASP.NET Core app. The product owner has requested that you migrate some data services from your AKS cluster to managed services to reduce operational costs.

This module guides you through implementing managed data services in a microservices app. You'll begin with a simplified, revamped version of [:::no-loc text="eShopOnContainers":::](https://github.com/dotnet-architecture/eShopOnContainers), the companion reference app for the guide [.NET Microservices: Architecture for Containerized .NET Applications](/dotnet/architecture/microservices). After validating the app deployment using data services within the AKS cluster, you'll modify the app's basket service to use Azure Cache for Redis. Following that, you'll reconfigure the app's coupon service to use Azure Cosmos DB.

[!INCLUDE[Use your own Azure subscription](../../includes/microservices/your-own-az-subscription.md)]

[!INCLUDE[Dev containers](../../includes/dev-containers/required.md)]

In this module, you will:

- Deploy a base version of *:::no-loc text="eShopOnContainers":::* to an AKS instance in your subscription.
- Create an Azure Cache for Redis instance.
- Create an Azure Cosmos DB instance.
- Modify *:::no-loc text="eShopOnContainers":::* to use the above managed services instead of the Redis and MongoDB services in the initial cluster.

## Learning objectives

- Review fully managed data service offerings in Azure
- Provision an Azure Cache for Redis instance
- Provision an Azure Cosmos DB instance using the MongoDB API
- Modify an existing microservices app to use the managed data services

## Prerequisites

- Familiarity with C# and ASP.NET Core development at the beginner level
- Familiarity with basic data management concepts
- Access to an Azure subscription with **Owner** privilege
- Ability to run development containers in Visual Studio Code or GitHub Codespaces
