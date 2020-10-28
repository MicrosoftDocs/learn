Managing configuration settings in a microservices context can easily become a significant problem if not handled properly. Since microservices apps are composed of multiple services, it's important to have a sound configuration strategy that effectively separates code from configuration.

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

To illustrate this integration, see the *Program.cs* file's `CreateHostBuilder` method:

:::code language="csharp" source="../code/src/web/webspa/program.cs" id="snippet_CreateHostBuilder":::

In the highlighted code fragment:

1. There's no explicit registration of .NET Core configuration providers. The `CreateDefaultBuilder` method registers the environment variable and JSON file configuration providers. As a result, values can be read from environment variables and *appsettings.json*, respectively.
<!--TODO: finish creating this list-->
<!-- 2. If FeatureManagement is enabled and the App Configuration endpoint configured (line 27). (You can take a look at the ConfigMap above).
1. Add the `AzureAppConfiguration` provider (line 29). Being the second in the chain of providers, it can override any value taken from the ConfigMap.
1. Connect to the App Configuration endpoint (line 31).
1. Enable the feature flags (line 32).
1. Set the configuration refresh rate from the App Configuration store (line 35). -->

## Resources

* [Configuration in ASP.NET Core](/aspnet/core/fundamentals/configuration)
* [Kubernetes ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap)
* [What is Azure App Configuration?](/azure/azure-app-configuration/overview)
* [Feature management overview](/azure/azure-app-configuration/concept-feature-management)
