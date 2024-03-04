Creating microservices for a distributed environment presents a significant challenge. Cloud-hosted microservices often run in multiple containers in various regions. Implementing a solution that separates each service's code from configuration eases the triaging of issues across all environments.

In this unit, explore how to integrate ASP.NET Core and Docker configuration features with Azure App Configuration to tackle this challenge in an effective way.

You'll review the:

* ASP.NET Core configuration infrastructure.
* Kubernetes configuration abstraction&mdash;the :::no-loc text="ConfigMap":::.
* Azure App Configuration service.
* .NET Feature Management library.
* Feature flag components implemented in the app.

## ASP.NET Core configuration

Configuration in an ASP.NET Core project is contained in one or more .NET *configuration providers*. A [configuration provider](/aspnet/core/fundamentals/configuration/#configuration-providers) is an abstraction over a specific configuration source, such as a JSON file. The configuration source's values are represented as a collection of key-value pairs.

An ASP.NET Core app can register multiple configuration providers to read settings from various sources. With the default application host, several configuration providers are automatically registered. The following configuration sources are available in the order listed:

1. JSON file (*:::no-loc text="appsettings.json":::*)
1. JSON file (*:::no-loc text="appsettings.{environment}.json":::*)
1. User secrets
1. Environment variables
1. Command line

Each configuration provider can contribute its own key value. Furthermore, any provider can override a value from a provider that was registered earlier in the chain than itself. Given the registration order in the preceding list, a `UseFeatureManagement` command-line parameter overrides a `UseFeatureManagement` environment variable. Likewise, a `UseFeatureManagement` key within *:::no-loc text="appsettings.json":::* can be overridden by a `UseFeatureManagement` key stored in *:::no-loc text="appsettings.Development.json":::*.

Configuration key names can describe a hierarchy. For example, the notation **eShop:Store:SeasonalSale** refers to the **SeasonalSale** feature within the **Store** microservice of the **eShop** app. This structure can also map configuration values to an object graph or an [array](/aspnet/core/fundamentals/configuration/#bind-an-array).

> [!IMPORTANT]
> Some platforms don't support a colon in environment variable names. To ensure cross-platform compatibility, a double underscore (`__`) is used instead of a colon (`:`) to delimit keys. For example, `eShop__Store__SeasonalSale` is the cross-platform equivalent notation for `eShop:Store:SeasonalSale`.

ASP.NET Core uses a [ConfigurationBinder](/dotnet/api/microsoft.extensions.configuration.configurationbinder) to map configuration values to objects and arrays. The mapping to key names occurs in a case-insensitive fashion. For example, `ConnectionString` and `connectionstring` are treated as equivalent keys. For more information, see [keys and values](/aspnet/core/fundamentals/configuration/#configuration-keys-and-values).

## Docker configuration

In Docker, one abstraction to handle configuration as a key-value pairs collection is the environment variable section of a container's YAML file. The following snippet is an excerpt from the app's `docker-compose.yml` file:

```dockerfile
services: 

  frontend:
    image: storeimage
    build:
      context: .
      dockerfile: DockerfileStore
    environment: 
      - ProductEndpoint=http://backend:8080
      - ConnectionStrings:AppConfig=Endpoint=https://eshop-app-features.azconfig.io;Id=QWQy;Secret=V/4r/rhg/0tdy2L/AmMfBUcgTrYC4krRC7uFqbjRvDU=
    ports:
      - "32000:8080"
    depends_on: 
      - backend
```

The file snippet defines:

* Variables stored in the `environment` section of the YAML file, as highlighted in the preceding snippet.
* Presented to the containerized app as environment variables.
* A mechanism to persist .NET configuration values in microservices apps.

Environment variables are a cross-platform mechanism for providing runtime configuration to apps hosted in the Docker containers.

## Azure App Configuration

A centralized configuration service is especially useful in microservices apps and other distributed apps. This module introduces Azure App Configuration as a service for centrally managing configuration values&mdash;specifically for feature flags. The service eases the troubleshooting of errors that arise when configuration is deployed with an app.

App Configuration is a fully managed service that encrypts key values both at rest and in transit. Configuration values stored with it can be updated in real time without the need to redeploy or restart an app.

In an ASP.NET Core app, Azure App Configuration is registered as a configuration provider. Aside from the provider registration, the app doesn't know about the App Configuration store. Configuration values can be retrieved from it via .NET's configuration abstraction&mdash;the `IConfiguration` interface.

## Feature Management library

The *Feature Management* library provides standardized .NET APIs for managing feature flags within apps. The library is distributed via NuGet in the form of two different packages named `Microsoft.FeatureManagement` and `Microsoft.FeatureManagement.AspNetCore`. The latter package provides Tag Helpers for use in an ASP.NET Core project's Razor files. The former package is sufficient when the Tag Helpers aren't needed or when not using with an ASP.NET Core project.

The library is built atop `IConfiguration`. For this reason, it's compatible with any .NET configuration provider, including the provider for Azure App Configuration. Because the library is decoupled from Azure App Configuration, integration of the two is made possible via the configuration provider. Combining this library with Azure App Configuration enables you to dynamically toggle features without implementing supporting infrastructure.

### Integration with Azure App Configuration

To understand the integration of Azure App Configuration and the Feature Management library, see the following excerpt from an ASP.NET Core project's `Program.cs` file:

```csharp
string connectionString = builder.Configuration.GetConnectionString("AppConfig");

// Load configuration from Azure App Configuration
builder.Configuration.AddAzureAppConfiguration(options => {
  options.Connect(connectionString)
    .UseFeatureFlags();
});
```

In the preceding code fragment:

* The app's `builder.Configuration` method is called to register a configuration provider for the Azure App Configuration store. The configuration provider is registered via a call to `AddAzureAppConfiguration`.
* The Azure App Configuration provider's behavior is configured with the following options:
  * Authenticate to the corresponding Azure service via a connection string passed to the `Connect` method call. The connection string is retrieved from the `connectionString` variable. The registered configuration sources are made available via `builder.Configuration`.
  * Enable feature flags support via a call to `UseFeatureFlags`.
* The Azure App Configuration provider supersedes all other registered configuration providers because it's registered after any others.

> [!TIP]
> In an ASP.NET Core project, you can access the registered providers list by analyzing the `configBuilder.Sources` property inside of `ConfigureAppConfiguration`.
