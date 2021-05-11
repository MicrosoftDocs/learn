Imagine you're a software developer for an online retailer named *:::no-loc text="eShopOnContainers":::*. The retailer's online storefront is a cloud-native, microservices-based ASP.NET Core app. The product owner has requested your team migrate some data services functionality from your AKS cluster to managed services to reduce operational costs.

This module guides you through implementing managed data services in a microservices app. You'll begin with a simplified, revamped version of [:::no-loc text="eShopOnContainers":::](https://github.com/dotnet-architecture/eShopOnContainers)&mdash;the companion reference app for the guide [.NET Microservices: Architecture for Containerized .NET Applications](/dotnet/architecture/microservices). After validating the app deployment using data services within the AKS cluster, you'll modify the app's basket service to use Azure Cache for Redis. Following that, you'll reconfigure the app's coupon service to use Azure Cosmos DB.

You'll use your own Azure subscription to deploy the resources in this module. To estimate the expected resource costs, see the [preconfigured Azure Calculator estimate](https://aka.ms/microservices-configuration-aspnet-core-estimate?azure-portal=true). If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/dotnet/?azure-portal=true) before you begin.

> [!IMPORTANT]
> This module uses your own Azure subscription. To avoid unnecessary charges in your Azure subscription, remember to de-provision your Azure resources when you're done with this module.

In this module, you will:

- Deploy a base version of *:::no-loc text="eShopOnContainers":::* to an AKS instance in your subscription.
- Create an Azure Cache for Redis instance.
- Create an Azure Cosmos DB instance.
- Modify *:::no-loc text="eShopOnContainers":::* to use the above managed services instead of the Redis and MongoDB services in the initial cluster.

> [!IMPORTANT]
> This module uses your own Azure subscription. To avoid unnecessary charges in your Azure subscription, remember to de-provision your Azure resources when you're done with this module.

## Learning objectives

- Review fully managed data service offerings in Azure.
- Provision an Azure Cache for Redis instance.
- Provision an Azure Cosmos DB instance using the MongoDB API.
- Modify an existing microservices app to use the managed data services.

## Prerequisites

- Familiarity with C# and ASP.NET Core development at the beginner level
- Familiarity with basic data management concepts
- Access to an Azure subscription with **Owner** privilege
