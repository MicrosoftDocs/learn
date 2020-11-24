Imagine you're a software developer for an online retailer named *:::no-loc text="eShopOnContainers":::*. The retailer's online storefront is a cloud-native, microservices-based ASP.NET Core app. You've developed and deployed a new discount coupon feature for the store's checkout page. The feature allows a customer to redeem a coupon code before their payment is applied. The product owner has requested support for disabling the discount coupon feature in real time.

This module guides you through implementing a feature flags library. With that library, you'll create a feature flag to toggle the visibility of the discount coupon feature. The configuration values that support this feature flag will be centralized by using the Azure App Configuration service. You'll begin with a simplified, revamped version of [:::no-loc text="eShopOnContainers":::](https://github.com/dotnet-architecture/eShopOnContainers)&mdash;the companion reference app for the guide [.NET Microservices: Architecture for Containerized .NET Applications](/dotnet/architecture/microservices). This new version includes the discount coupon feature.

You'll use your own Azure subscription to deploy the resources in this module. To estimate the expected resource costs, see the [preconfigured Azure Calculator estimate](https://aka.ms/microservices-configuration-aspnet-core-estimate?azure-portal=true). If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/dotnet/?azure-portal=true) before you begin.

> [!IMPORTANT]
> This module uses your own Azure subscription. To avoid unnecessary charges in your Azure subscription, remember to de-provision your Azure resources when you're done with this module.

## Learning objectives

- Review ASP.NET Core and Kubernetes app configuration concepts.
- Implement real-time feature toggling with the .NET Feature Management library.
- Implement a centralized Azure App Configuration store.

## Prerequisites

- Familiarity with C# and ASP.NET Core development at the beginner level
- Familiarity with RESTful service concepts at the beginner level
- Conceptual knowledge of containers and AKS at the intermediate level
- Access to an Azure subscription with **Owner** privilege
