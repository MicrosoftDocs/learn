The management of configuration settings in a microservices context can become a significant problem if not handled properly. Since microservices-based solutions are composed of multiple services, it's important to have a sound configuration strategy that effectively separates code from configuration.

You'll explore how to integrate ASP.NET Core and Kubernetes configuration features with Azure App Configuration to tackle this scenario in an effective way.

In this unit, you'll review the:

* ASP.NET Core configuration infrastructure.
* Kubernetes configuration abstraction&mdash;the ConfigMap.
* Azure App Configuration service.
* ASP.NET Core Feature Management library.

## ASP.NET Core configuration

ASP.NET Core supplies a [configuration provider](/aspnet/core/fundamentals/configuration/#configuration-providers) abstraction that handles configurations as key-value pair collections. An app can register a chain of configuration providers, and any provider can override a value set by a prior provider in the chain.

Configuration key names can describe a hierarchy. For example, the notation `FeatureManagement:Coupons` refers to the `Coupons` property within the `FeatureManagement` section. This structure can also map configuration values to an object tree or an [array](/aspnet/core/fundamentals/configuration/#bind-an-array).

> [!IMPORTANT]
> Some platforms don't support a colon for environment variable names. In those cases, a double underscore (`__`) is used instead of a colon (`:`).

<!-- TODO: add this somewhere? [keys and values](/aspnet/core/fundamentals/configuration/#configuration-keys-and-values) -->

ASP.NET Core uses a [ConfigurationBinder](/dotnet/api/microsoft.extensions.configuration.configurationbinder) to map configuration values to objects and arrays, based on the property names in a case-insensitive fashion. This is the base that supports the implementation of the [Options pattern](/aspnet/core/fundamentals/configuration/options) that can help simplify using the configuration values in your app.

## Kubernetes configuration

The classical Kubernetes abstraction to handle configuration is the [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap). A ConfigMap is also (usually) a key-value pair collection and a typical one looks like this:

<!-- TODO: consider using Key Vault to store the AppConfig__Endpoint connection string -->

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

The ConfigMap's key-value pairs are typically presented to the containerized app as environment variables. This is the primary mechanism to get the configuration values in our ASP.NET Core apps.

## Azure App Configuration

Azure App Configuration provides a service to manage app settings and feature flags from a centralized store. App Configuration is also a good complement to [Azure Key Vault](/azure/key-vault/general/overview), which is designed to handle app secrets like connection strings, tokens, passwords, and digital certificates.

ASP.NET Core apps make use of Azure App Configuration as just another configuration provider, albeit one with quite some [useful features](/azure/azure-app-configuration/overview#why-use-app-configuration).

## Feature Management library

The Feature Management library provides an opinionated solution to handle feature flags. It's integrated with the Azure App Configuration service and allows you to dynamically toggle features without implementing supporting infrastructure.

The Feature Management library and Azure App Configuration build seamlessly on ASP.NET Core's configuration abstraction, to streamline configuration and feature management needs.

### Integration

To illustrate this integration, see the following excerpt from the *Program.cs* file's `CreateHostBuilder` method:

:::code language="csharp" source="../code/src/web/webspa/program.cs" id="snippet_CreateHostBuilder":::

In the highlighted code fragment:

1. There's no explicit registration of .NET Core configuration providers. The `CreateDefaultBuilder` method registers the environment variable and JSON file configuration providers. As a result, values can be read from environment variables and *appsettings.json*, respectively.
<!--TODO: finish creating this list-->
<!-- 2. If FeatureManagement is enabled and the App Configuration endpoint configured (line 27). (You can take a look at the ConfigMap above).
1. Add the `AzureAppConfiguration` provider (line 29). Being the second in the chain of providers, it can override any value taken from the ConfigMap.
1. Connect to the App Configuration endpoint (line 31).
1. Enable the feature flags (line 32).
1. Set the configuration refresh rate from the App Configuration store (line 35). -->

## Review the "infrastructure" feature flag components

:::image type="content" source="../media/4-implement-feature-flag/client-to-server-integration.png" alt-text="A diagram showing how Angular communicates with ASP.NET Core" border="true" lightbox="../media/4-implement-feature-flag/client-to-server-integration.png":::

To make a feature configurable, you have to make several changes to your app. Some "infrastructure" components have already been implemented for you. What follows is a review of those components.

### Feature flag directive for the views

This is implemented with the following files in the *src\Web\WebSPA\Client\src\modules\shared* directory:

* *directives\featureFlag.directive.ts*
* *models\featureFlag.model.ts*
* *services\featureFlag.service.ts*

An Angular component that contains the `featureFlag` attribute triggers the following sequence of events:

1. The Angular `featureFlag` directive, defined in *featureFlag.directive.ts*, calls the `getFeatures` function in *featureFlag.service.ts*:

    :::code language="typescript" source="../code/src/web/webspa/client/src/modules/shared/directives/featureFlag.directive.ts" highlight="18":::

1. The `getFeatures` function constructs a URL to initiate an HTTP GET request to the App Configuration store:

    :::code language="typescript" source="../code/src/web/webspa/client/src/modules/shared/services/featureFlag.service.ts" id="snippet_getFeatures":::

1. The HTTP response from the aforementioned HTTP GET request is converted to an instance of `IFeatureFlag`:

    :::code language="typescript" source="../code/src/web/webspa/client/src/modules/shared/models/featureFlag.model.ts":::

The feature flag directive is used in any `div` element to determine whether it should be rendered, depending on the result from the feature flag service. The feature flag service queries the feature management middleware to check the feature status.

### Feature Management middleware for querying values

A custom middleware, found at *src\Web\WebSPA\Infrastructure\Middlewares\FeatureManagementMiddleware.cs*, is a key component of the SPA's feature flag system. The middleware allows you to query the specific feature flag values so they can be used in the SPA:

:::code language="csharp" source="../code/src/web/webspa/infrastructure/middlewares/featuremanagementmiddleware.cs" id="snippet_Invoke" highlight="8":::

As a refresher, a middleware is added to ASP.NET Core's request processing pipeline as a handler for HTTP requests. Think of it like a "light" controller that processes the raw `HttpContext` and returns a value by writing directly to the `Response` object. For more in-depth information, see the [ASP.NET Core Middleware](/aspnet/core/fundamentals/middleware/) document.

The Feature Management library is implemented to work on the server side. That's fine when using MVC or Razor Pages, but you need to use the configuration data in the SPA. So the directive mentioned in the previous section will query the `/features` endpoint, implemented as this middleware, to get the feature state. The middleware retrieves the configuration values from the feature manager that, in turn, gets them from the ASP.NET Core configuration infrastructure.

Think of this middleware as a proxy or broker between the SPA and the Feature Management service.

## Resources

* [Configuration in ASP.NET Core](/aspnet/core/fundamentals/configuration)
* [Kubernetes ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap)
* [What is Azure App Configuration?](/azure/azure-app-configuration/overview)
* [Feature management overview](/azure/azure-app-configuration/concept-feature-management)
