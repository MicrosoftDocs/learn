Azure App Configuration provides a service to centrally manage application settings and feature flags. Modern programs, especially programs running in a cloud, generally have many components that are distributed in nature. Spreading configuration settings across these components can lead to hard-to-troubleshoot errors during an application deployment. Use App Configuration to store all the settings for your application and secure their accesses in one place.

App Configuration offers the following benefits:

* A fully managed service that can be set up in minutes
* Flexible key representations and mappings
* Tagging with labels
* Point-in-time replay of settings
* Dedicated UI for feature flag management
* Comparison of two sets of configurations on custom-defined dimensions
* Enhanced security through Azure-managed identities
* Encryption of sensitive information at rest and in transit
* Native integration with popular frameworks

App Configuration complements Azure Key Vault, which is used to store application secrets. App Configuration makes it easier to implement the following scenarios:

* Centralize management and distribution of hierarchical configuration data for different environments and geographies
* Dynamically change application settings without the need to redeploy or restart an application
* Control feature availability in real-time

## Use App Configuration

The easiest way to add an App Configuration store to your application is through a client library that Microsoft provides. Based on the programming language and framework, the following best methods are available to you.

| Programming language and framework | How to connect |
|--|--|
| .NET | App Configuration [provider](/dotnet/api/Microsoft.Extensions.Configuration.AzureAppConfiguration) for .NET |
| ASP.NET Core | App Configuration [provider](/dotnet/api/Microsoft.Extensions.Configuration.AzureAppConfiguration) for .NET |
| .NET Framework and ASP.NET | App Configuration [builder](https://github.com/aspnet/MicrosoftConfigurationBuilders/blob/main/README.md#azureappconfigurationbuilder) for .NET |
| Java Spring | App Configuration [provider](https://microsoft.github.io/spring-cloud-azure/docs/azure-app-configuration/2.9.0/reference/html/index.html) for Spring Cloud |
| JavaScript/Node.js | App Configuration [provider](https://github.com/Azure/azure-sdk-for-js/tree/main/sdk/appconfiguration/app-configuration) for JavaScript |
| Python | App Configuration [provider](https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/appconfiguration/azure-appconfiguration) for Python |
| Others | App Configuration [REST API](/rest/api/appconfiguration/) |  

