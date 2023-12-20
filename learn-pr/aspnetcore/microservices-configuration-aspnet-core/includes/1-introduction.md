Imagine you're a software developer for an online retailer. The retailer's online storefront is a cloud-native, microservices-based ASP.NET Core app. You've been asked to add the ability to the app to have seasonal sales. The sales and the discounts need to be controlled by the sales team, so that app can't be recompiled or redeployed to see the changes.

This module guides you through implementing a feature flags library. This library creates a feature flag to toggle the visibility of the seasonal sale. The configuration values that support this feature flag are centralized by using the Azure App Configuration service.

[!INCLUDE[Use your own Azure subscription](../../includes/microservices/your-own-az-subscription.md)]

[!INCLUDE[Dev containers](../../includes/dev-containers/required.md)]

## Learning objectives

- Review ASP.NET Core  app configuration concepts.
- Implement real-time feature toggling with the .NET Feature Management library.
- Implement a centralized Azure App Configuration store.
- Implement code to use features and configuration settings from the Azure App Configuration store.

## Prerequisites

- Familiarity with C# and ASP.NET Core development at the beginner level.
- Familiarity with RESTful service concepts at the beginner level.
- Conceptual knowledge of containers.
- Access to an Azure subscription with **Owner** privilege.
- Ability to run development containers in Visual Studio Code or GitHub Codespaces.
