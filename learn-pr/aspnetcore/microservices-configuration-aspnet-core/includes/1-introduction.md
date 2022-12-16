Imagine you're a software developer for an online retailer named *:::no-loc text="eShopOnContainers":::*. The retailer's online storefront is a cloud-native, microservices-based ASP.NET Core app. You've developed and deployed a new discount coupon feature for the store's checkout page. The feature allows a customer to redeem a coupon code before their payment is applied. The product owner has requested support for disabling the discount coupon feature in real time.

This module guides you through implementing a feature flags library. With that library, you'll create a feature flag to toggle the visibility of the discount coupon feature. The configuration values that support this feature flag will be centralized by using the Azure App Configuration service. You'll begin with a simplified, revamped version of [:::no-loc text="eShopOnContainers":::](https://github.com/dotnet-architecture/eShopOnContainers)&mdash;the companion reference app for the guide [.NET Microservices: Architecture for Containerized .NET Applications](/dotnet/architecture/microservices). This new version includes the discount coupon feature.

[!INCLUDE[Use your own Azure subscription](../../includes/microservices/your-own-az-subscription.md)]

[!INCLUDE[Dev containers](../../includes/dev-containers/required.md)]

## Learning objectives

- Review ASP.NET Core and Kubernetes app configuration concepts.
- Implement real-time feature toggling with the .NET Feature Management library.
- Implement a centralized Azure App Configuration store.

## Prerequisites

- Familiarity with C# and ASP.NET Core development at the beginner level
- Familiarity with RESTful service concepts at the beginner level
- Conceptual knowledge of containers and AKS at the intermediate level
- Access to an Azure subscription with **Owner** privilege
- Ability to run development containers in Visual Studio Code or GitHub Codespaces
