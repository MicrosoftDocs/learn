# Introduction

Imagine you're a software developer for an online retailer named eShopOnContainers. The retailer uses a cloud-native, microservices-based application developed using .NET Core for its online storefront.

You've just completed and deployed to a test environment the implementation of a new feature but the Product Owner has a last-minute request to make the new feature toggleable so they are able to make some tests in production with real users.

So for this sprint you'll focus on enabling feature toggling in your application, later on you'll go for some way to enable the feature for a set of users, but that'll be a goal for another sprint 😉.

For thid module you'll begin with a *simplified* and *revamped* version of [eShopOnContainers](https://github.com/dotnet-architecture/eShopOnContainers), the companion reference application for the guide: [.NET Microservices: Architecture for Containerized .NET Applications](https://docs.microsoft.com/dotnet/architecture/microservices/). This new version includes a discount coupon feature, that you can use at checkout time in the shopping basket.

The initial application also contains the implementation of some "infrastructure" components to implement feature toggles, to make it easier to complete the exercise.

In this module you will:

- Review some key ASP.NET Core and Kubernetes configuration concepts.

- Implement a feature management option so you can turn features on or off using configuration.

- Create an Azure App Configuration store to centralize configuration management, and enable remote feature toggling.

## Learning objectives

- Understand the key configuration concepts.
- Learn to implement a basic feature toggling functionality.
- Learn to implement a basic centralized Azure App Configuration store.

## Prerequisites

- Familiarity with C# and ASP.NET Core.
- Familiarity with Kubernetes.
- Access to an Azure subscription with **Owner** privilege.
- Access to a GitHub account
