
Azure App Configuration is a service for central management of application settings and feature flags.

Modern programs include distributed components, each that needs its settings.

It's prevalent with microservice-based applications and with serverless applications.

Distributed configuration settings can lead to hard-to-troubleshoot deployment errors.

Azure App Configuration service stores all the settings for your application and secures their access in one place.

Azure App Configuration service provides the following features:

 -  A fully managed service that can be set up in minutes.
 -  Flexible key representations and mappings.
 -  Tagging with labels.
 -  A point-in-time replay of settings.
 -  Dedicated UI for feature flag management.
 -  Comparison of two sets of configurations on custom-defined dimensions.
 -  Enhanced security through Azure managed identities.
 -  Complete data encryptions, at rest or in transit.
 -  Native integration with popular frameworks.

App Configuration complements Azure Key Vault, which is used to store application secrets. App Configuration makes it easier to implement the following scenarios:

 -  Centralize management and distribution of hierarchical configuration data for different environments and geographies.
 -  Dynamically change application settings without the need to redeploy or restart an application.
 -  Control feature availability in real time.

## Use App Configuration

The easiest way to add an App Configuration store to your application is through one of Microsoft's client libraries.

Based on the programming language and framework, the following best methods are available to you.

| **Programming language and framework** | **How to connect**                        |
| -------------------------------------- | ----------------------------------------- |
| .NET Core and ASP.NET Core             | App Configuration provider for .NET Core  |
| .NET Framework and ASP.NET             | App Configuration builder for .NET        |
| Java Spring                            | App Configuration client for Spring Cloud |
| Others                                 | App Configuration REST API                |
