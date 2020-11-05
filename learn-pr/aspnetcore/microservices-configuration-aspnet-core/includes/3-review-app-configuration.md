Configuration management in a microservices context can become a significant problem if not handled properly. With multiple services in use, it's important to use a configuration strategy that separates code from configuration.

In this unit, you'll explore how to integrate ASP.NET Core and Kubernetes configuration features with Azure App Configuration to tackle this scenario in an effective way.

You'll review the:

* ASP.NET Core configuration infrastructure.
* Kubernetes configuration abstraction&mdash;the ConfigMap.
* Azure App Configuration service.
* ASP.NET Core Feature Management library.
* Feature flag components implemented in the app.

## ASP.NET Core configuration

Configuration in an ASP.NET Core project is supported by one or more .NET Core *configuration providers*. A [configuration provider](/aspnet/core/fundamentals/configuration/#configuration-providers) is an abstraction over a specific configuration source, such as a JSON file. The configuration source's values are represented as a collection of key-value pairs.

An app can register a chain of configuration providers. By default, ASP.NET Core apps register the following configuration providers in the order listed:

1. JSON file (*:::no-loc text="appsettings.json":::*)
1. JSON file (*:::no-loc text="appsettings.{environment}.json":::*)
1. User secrets (*:::no-loc text="secrets.json":::*)
1. Environment variables
1. Command line

Each configuration provider can contribute its own key value. Furthermore, any provider can override a value from a provider that was registered earlier in the chain than itself. Given the registration order in the preceding list, a `UseFeatureManagement` command-line parameter overrides a `UseFeatureManagement` environment variable. Likewise, a `UseFeatureManagement` key in *appsettings.json* can be overridden by a `UseFeatureManagement` key stored in user secrets.

Configuration key names can describe a hierarchy. For example, the notation `FeatureManagement:Coupons` refers to the `Coupons` key within the `FeatureManagement` section. This structure can also map configuration values to an object graph or an [array](/aspnet/core/fundamentals/configuration/#bind-an-array).

> [!IMPORTANT]
> Some platforms don't support a colon in environment variable names. To ensure cross-platform compatibility, a double underscore (`__`) is used instead of a colon (`:`) to delimit keys.

ASP.NET Core uses a [ConfigurationBinder](/dotnet/api/microsoft.extensions.configuration.configurationbinder) to map configuration values to objects and arrays. The mapping to key names occurs in a case-insensitive fashion. For example, `ConnectionString` and `connectionstring` are treated as equivalent keys. For more information, see [keys and values](/aspnet/core/fundamentals/configuration/#configuration-keys-and-values).

## Kubernetes configuration

In Kubernetes, one abstraction to handle configuration as a collection of plain text key-value pairs is the *ConfigMap*. A typical [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap) example looks like the following YAML:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: webspa-cm
  labels:
    app: eshop
    service: webspa
data:
  ASPNETCORE_ENVIRONMENT: Docker
  ASPNETCORE_URLS: http://0.0.0.0:80
  #...
  UseFeatureManagement: "True"
  FeatureManagement__Coupons: "False"
  AppConfig__Endpoint: "Endpoint=https://eshoplearn20200630195254680.azconfig.io;Id=...;Secret=..."
```

The ConfigMap's key-value pairs are:

* Presented to the containerized app as environment variables.
* The primary mechanism to persist .NET Core configuration values in microservices apps.

## Azure App Configuration

A centralized configuration service is especially useful in microservices apps and other distributed apps. In this module, you'll use Azure App Configuration to manage app settings and feature flags.

In an ASP.NET Core app, Azure App Configuration is registered as another configuration provider. The rest of the app doesn't know about the App Configuration service as it works with configuration values.

## Feature Management library

The *Feature Management* library, distributed as a NuGet package named `Microsoft.FeatureManagement`, provides standardized APIs for managing feature flags within apps. It's designed to work with any configuration source, including Azure App Configuration. Combining this library with Azure App Configuration enables you to dynamically toggle features without implementing supporting infrastructure.

Like Azure App Configuration, the Feature Management library also builds on ASP.NET Core's configuration abstraction. They integrate together to provide a complete feature management solution.

### Integration

To understand the integration of Azure App Configuration and the Feature Management library, see the following excerpt from the *Program.cs* file's `CreateHostBuilder` method:

:::code language="csharp" source="../code/src/web/webspa/program.cs" id="snippet_CreateHostBuilder":::

In the preceding code fragment:

* The `CreateDefaultBuilder` method registers the environment variable and JSON file configuration providers. As a result, values can be read from environment variables and *appsettings.json*, respectively.
* The `ConfigureAppConfiguration` method is called to register a configuration provider for the Azure App Configuration store. The configuration provider is registered, via a call to `AddAzureAppConfiguration`, if the following conditions are satisfied:
  * The `UseFeatureManagement` key value in *appsettings.json* is `true`.
  * The Azure App Configuration connection string, found in the `AppConfig:Endpoint` key's value, has been provided.
* The Azure App Configuration provider is registered by providing a connection string to the resource. Feature flags support is enabled via a call to `UseFeatureFlags`.

<!--
1. Add the `AzureAppConfiguration` provider (line 29). Being the second in the chain of providers, it can override any value taken from the ConfigMap.
1. Set the configuration refresh rate from the App Configuration store (line 35).

Configuration providers can be combined to load settings from multiple sources. Configuration is automatically added when using the default application host.

The order in which configuration providers are called/registered is important. The order affects the final configuration values. A set of default providers are added by the host builder.

`ConfigureAppConfiguration` is called on the `IHostBuilder`. It causes the default configuration providers to be added.

config.AddJsonFile (appsettings.json)
config.AddJsonFile (appsettings.{env}.json)
config.AddUserSecrets
config.AddEnvironmentVariables
config.AddCommandLine

If command-line arguments have been provided when the app starts, those arguments override those found in the other configuration providers. Each provider can contribute its own key value. The last value provided by a provider is the one that wins. For cross-platform compatibility, a double underscore is used instead of a colon to delimit keys.

With environment variables, the colon doesn't work on all platforms. Therefore, __ is used instead.

With the rise of containers, environment variables are a cross-platform and container-compatible way to provide runtime configuration.

The Azure App Configuration provider should supersede the other providers. Therefore, it's registered last in the ConfigureAppConfiguration method.

You can access the list of registered providers by analyzing the builder.Sources property inside of ConfigureAppConfiguration. builder.Sources.Clear(); would give you clean starting point, with no providers registered.
-->

## Review the app's feature flag components

:::image type="content" source="../media/3-review-app-configuration/client-to-server-integration.png" alt-text="A diagram showing how Angular communicates with ASP.NET Core" border="true" lightbox="../media/3-review-app-configuration/client-to-server-integration.png":::

To make a feature configurable, you have to make several changes to your app. Some components have already been implemented for you. What follows is a review of those components.

### Feature flag directive for the views

The *WebSPA* app is built with a JavaScript SPA framework from Google called Angular. Knowledge of Angular isn't required, but it's important to understand the architecture of this app.

You're provided with a custom Angular *attribute directive*&mdash;a component that changes the appearance of DOM elements. In this case, the directive considers a feature flag to toggle the visibility of the discount coupon DOM elements. The directive is implemented with the following files in the *src\Web\WebSPA\Client\src\modules\shared* directory:

* *directives\featureFlag.directive.ts*
* *models\featureFlag.model.ts*
* *services\featureFlag.service.ts*

An Angular component that contains the `featureFlag` attribute triggers the following sequence of events:

1. The Angular `featureFlag` directive, defined in *featureFlag.directive.ts*, calls the `getFeatures` function in *featureFlag.service.ts*:

    :::code language="typescript" source="../code/src/web/webspa/client/src/modules/shared/directives/featureFlag.directive.ts" highlight="18":::

1. The `getFeatures` function constructs a URL to send an HTTP GET request to the App Configuration store:

    :::code language="typescript" source="../code/src/web/webspa/client/src/modules/shared/services/featureFlag.service.ts" id="snippet_getFeatures":::

1. The response from the HTTP GET request is converted to an instance of `IFeatureFlag`:

    :::code language="typescript" source="../code/src/web/webspa/client/src/modules/shared/models/featureFlag.model.ts":::

The feature flag directive is used in any `div` element to determine whether it should be rendered, depending on the result from the feature flag service. The feature flag service queries the feature management middleware to check the feature status.

### Feature Management middleware for querying values

A custom middleware, found at *src\Web\WebSPA\Infrastructure\Middlewares\FeatureManagementMiddleware.cs*, is a key component of the SPA's feature flag system. The middleware queries the specific feature flag values so they can be used in the SPA:

:::code language="csharp" source="../code/src/web/webspa/infrastructure/middlewares/featuremanagementmiddleware.cs" id="snippet_Invoke" highlight="8":::

ASP.NET Core's request processing pipeline uses a middleware as a handler for HTTP requests. Think of it like a "light" controller that processes the raw `HttpContext` and returns a value by writing directly to the `Response` object. For more in-depth information, see the [ASP.NET Core Middleware](/aspnet/core/fundamentals/middleware/) document.

The Feature Management library is implemented to work on the server side. That's fine when using MVC or Razor Pages, but you need to use the configuration data in the SPA. So the directive mentioned in the previous section will query the `/features` endpoint, implemented as this middleware, to get the feature state. The middleware retrieves the configuration values from the feature manager that, in turn, gets them from the ASP.NET Core configuration infrastructure.

Think of this middleware as a proxy or broker between the SPA and the Feature Management service.

## Resources

* [Configuration in ASP.NET Core](/aspnet/core/fundamentals/configuration)
* [Kubernetes ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap)
* [What is Azure App Configuration?](/azure/azure-app-configuration/overview)
* [Feature management overview](/azure/azure-app-configuration/concept-feature-management)
