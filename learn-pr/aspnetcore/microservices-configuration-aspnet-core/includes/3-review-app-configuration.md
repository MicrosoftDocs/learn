Configuration management in a microservices context can become a significant problem if not handled properly. A solution that separates each service's code from configuration is ideal.

In this unit, you'll explore how to integrate ASP.NET Core and Kubernetes configuration features with Azure App Configuration to tackle this scenario in an effective way.

You'll review the:

* ASP.NET Core configuration infrastructure.
* Kubernetes configuration abstraction&mdash;the ConfigMap.
* Azure App Configuration service.
* .NET Feature Management library.
* Feature flag components implemented in the app.

## ASP.NET Core configuration

Configuration in an ASP.NET Core project is supported by one or more .NET Core *configuration providers*. A [configuration provider](/aspnet/core/fundamentals/configuration/#configuration-providers) is an abstraction over a specific configuration source, such as a JSON file. The configuration source's values are represented as a collection of key-value pairs.

An ASP.NET Core app can register multiple configuration providers to read settings from various sources. With the default application host, several configuration providers are automatically registered. The following configuration sources are available in the order listed:

1. JSON file (*:::no-loc text="appsettings.json":::*)
1. JSON file (*:::no-loc text="appsettings.{environment}.json":::*)
1. User secrets
1. Environment variables
1. Command line

Each configuration provider can contribute its own key value. Furthermore, any provider can override a value from a provider that was registered earlier in the chain than itself. Given the registration order in the preceding list, a `UseFeatureManagement` command-line parameter overrides a `UseFeatureManagement` environment variable. Likewise, a `UseFeatureManagement` key in *appsettings.json* can be overridden by a `UseFeatureManagement` key stored in *appsettings.Development.json*.

Configuration key names can describe a hierarchy. For example, the notation `FeatureManagement:Coupons` refers to the `Coupons` key within the `FeatureManagement` section. This structure can also map configuration values to an object graph or an [array](/aspnet/core/fundamentals/configuration/#bind-an-array).

> [!IMPORTANT]
> Some platforms don't support a colon in environment variable names. To ensure cross-platform compatibility, a double underscore (`__`) is used instead of a colon (`:`) to delimit keys.

ASP.NET Core uses a [ConfigurationBinder](/dotnet/api/microsoft.extensions.configuration.configurationbinder) to map configuration values to objects and arrays. The mapping to key names occurs in a case-insensitive fashion. For example, `ConnectionString` and `connectionstring` are treated as equivalent keys. For more information, see [keys and values](/aspnet/core/fundamentals/configuration/#configuration-keys-and-values).

## Kubernetes configuration

In Kubernetes, one abstraction to handle configuration as a collection of plain text key-value pairs is the *ConfigMap*. A typical [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap) example looks like the following YAML:

:::code language="yaml" source="../code/deploy/k8s/helm-simple/webspa/templates/configmap.yaml" range="1-10" highlight="8-10":::

The ConfigMap's key-value pairs are:

* Stored in the `data` field of the YAML, as highlighted in the preceding snippet.
* Presented to the containerized app as environment variables.
* The primary mechanism to persist .NET Core configuration values in microservices apps.

Environment variables are a cross-platform mechanism for providing runtime configuration to apps hosted in the Kubernetes cluster.

## Azure App Configuration

A centralized configuration service is especially useful in microservices apps and other distributed apps. In this module, you'll use Azure App Configuration to manage app settings and feature flags.

In an ASP.NET Core app, Azure App Configuration is registered as a configuration provider. Aside from the provider registration, the app doesn't know about the App Configuration store. Configuration values can be retrieved from it via .NET Core's configuration abstraction&mdash;the `IConfiguration` interface.

## Feature Management library

The *Feature Management* library provides standardized .NET APIs for managing feature flags within apps. It's distributed via NuGet in the form of two different packages named `Microsoft.FeatureManagement` and `Microsoft.FeatureManagement.AspNetCore`. The latter package provides Tag Helpers for use in an ASP.NET Core project's Razor files. The former package is sufficient when the Tag Helpers aren't needed or when not using with an ASP.NET Core project.

The library is built atop `IConfiguration`. For this reason, it's compatible with any .NET Core configuration provider, including the provider for Azure App Configuration. Because the library is decoupled from Azure App Configuration, integration of the two is made possible via the configuration provider. Combining this library with Azure App Configuration enables you to dynamically toggle features without implementing supporting infrastructure.

### Integration with Azure App Configuration

To understand the integration of Azure App Configuration and the Feature Management library, see the following excerpt from an ASP.NET Core project's *Program.cs* file:

:::code language="csharp" source="../code/src/web/webspa/program.cs" id="snippet_CreateHostBuilder":::

In the preceding `CreateHostBuilder` method fragment:

* The `CreateDefaultBuilder` method registers the default configuration providers. As a result, values can be read from environment variables and *appsettings.\*.json* files, respectively.
* The host builder's `ConfigureAppConfiguration` method is called to register a configuration provider for the Azure App Configuration store. The configuration provider is registered via a call to `AddAzureAppConfiguration`.
* The Azure App Configuration provider's behavior is configured with the following options:
  * Authenticate to the corresponding Azure service via a connection string passed to the `Connect` method call. The connection string is retrieved from the `AppConfig:Endpoint` key. The registered configuration sources are made available via `configBuilder.Build`. This method call is necessary to retrieve the `AppConfig:Endpoint` key's value.
  * Enable feature flags support via a call to `UseFeatureFlags`.
* The Azure App Configuration provider supersedes all other registered configuration providers because it's registered after any others.

> [!TIP]
> In an ASP.NET Core project, you can access the registered providers list by analyzing the `configBuilder.Sources` property inside of `ConfigureAppConfiguration`.

## Review the app's feature flag components

To make a feature configurable, you have to make several changes to the *WebSPA* app. Some components have already been implemented for you. What follows is a review of those components.

### WebSPA overview

The *WebSPA* app contains both server-side and client-side code. Server-side processing is supported by a C#-based ASP.NET Core project. Client-side processing is supported by TypeScript and Angular&mdash;a JavaScript Single-Page Application (SPA) framework from Google. Knowledge of Angular isn't required. It's more important to understand the app's architecture.

:::image type="content" source="../media/3-review-app-configuration/client-to-server-integration.png" alt-text="A diagram showing how Angular communicates with ASP.NET Core" border="true" lightbox="../media/3-review-app-configuration/client-to-server-integration.png":::

### Feature flag directive for the Angular views

You're provided with a custom Angular *attribute directive*. An attribute directive is a component that changes the appearance of DOM elements. The custom directive considers a feature flag to toggle the visibility of the discount coupon DOM elements. The directive is implemented with the following files in the *src\Web\WebSPA\Client\src\modules\shared* directory:

* *directives\featureFlag.directive.ts*
* *models\featureFlag.model.ts*
* *services\featureFlag.service.ts*

An Angular component that contains the `featureFlag` attribute triggers the following sequence of events:

1. The Angular `featureFlag` directive, defined in *featureFlag.directive.ts*, calls the `getFeatures` function:

    :::code language="typescript" source="../code/src/web/webspa/client/src/modules/shared/directives/featureFlag.directive.ts" highlight="18":::

1. The `getFeatures` function, defined in *featureFlag.service.ts*, constructs a URL to send an HTTP GET request to the App Configuration store:

    :::code language="typescript" source="../code/src/web/webspa/client/src/modules/shared/services/featureFlag.service.ts" id="snippet_getFeatures":::

1. The response from the HTTP GET request is converted to an instance of `IFeatureFlag`:

    :::code language="typescript" source="../code/src/web/webspa/client/src/modules/shared/models/featureFlag.model.ts":::

The feature flag directive is used in any `div` element to determine whether it should be rendered, depending on the result from the feature flag service. The feature flag service queries the feature management middleware to check the feature status.

### Feature Management middleware for querying values

By default, the client can't access .NET's `IConfiguration` interface. To solve that problem, an ASP.NET Core middleware component:

* Enables the client to retrieve a feature's status via an HTTP request.
* Communicates with the .NET Feature Management library to access feature flags via `IConfiguration`.

You're provided with a custom middleware at *src\Web\WebSPA\Infrastructure\Middlewares\FeatureManagementMiddleware.cs*&mdash;a key component of the SPA's feature flag system:

:::code language="csharp" source="../code/src/web/webspa/infrastructure/middlewares/featuremanagementmiddleware.cs" id="snippet_Invoke" highlight="8":::

ASP.NET Core's request processing pipeline uses a middleware as a handler for HTTP requests. Think of it as a lightweight controller that processes the raw `HttpContext` and returns a value by writing directly to the `Response` object. For more in-depth information, see the [ASP.NET Core Middleware](/aspnet/core/fundamentals/middleware/) document.

The Feature Management library is implemented to work on the server side. Server-side execution is ideal when using the library with ASP.NET Core MVC or Razor Pages. However, you need to access the configuration data on the client side, in the SPA. To support the needs of the SPA, the Angular directive mentioned in the previous section will query the `/features` endpoint. This endpoint is mapped to the custom middleware, which supports retrieval of the feature state. More specifically, the middleware retrieves configuration values from the Feature Management library. The library then retrieves the values using the registered .NET configuration providers chain.

Think of this middleware as a proxy or broker between the SPA and the Feature Management library.
