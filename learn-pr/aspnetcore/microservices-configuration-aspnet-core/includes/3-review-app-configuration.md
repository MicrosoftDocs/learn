Configuration is a key part of app development and even more so for deployment, especially when dealing with many deployment environments. Managing multiple configuration settings in a microservices context can easily become a significant problem and can lead to hard-to-troubleshoot problems if not handled properly.

In this module, we'll explore how to integrate ASP.NET Core and Kubernetes configuration features together with Azure App Configuration services to tackle this kind of scenarios in an effective way.

The key idea to keep in mind is that code and configuration are different concerns and must be kept separate. Configuration is a deployment concern while code is a development concern.

The main topics we'll explore here are:

- The ASP.NET Core configuration infrastructure.
- The Kubernetes configuration abstraction, the ConfigMap.
- The Azure App Configuration service.
- The Feature Management library from Azure App Configuration.

## ASP.NET Core configuration

ASP.NET Core supplies the "[Configuration provider](/aspnet/core/fundamentals/configuration/#configuration-providers)" abstraction that handles configurations as key-value pair collections. An app can register a chain of configuration providers, and any provider can override a value set by a prior provider in the chain.

The key values can have a structure that express a hierarchy, in such a way that the key `FeatureManagement:Coupons` means the `Coupons` configuration in the `FeatureManagement` section. This structure can also be used to map configuration values to an object tree or an array. you can find more information in the official documentation on [keys and values](/aspnet/core/fundamentals/configuration/#configuration-keys-and-values) and [array binding](/aspnet/core/fundamentals/configuration/#bind-an-array) sections. Some platforms don't support a colon for environment variable names, so you can use a double underscore (`__`) instead of the colon (`:`).

ASP.NET Core uses a [ConfigurationBinder](/dotnet/api/microsoft.extensions.configuration.configurationbinder) to map configuration values to objects and arrays, based on the property names in a case-insensitive fashion. This is the base that supports the implementation of the [Options pattern](/aspnet/core/fundamentals/configuration/options) that can help simplify using the configuration values in your app.

## Kubernetes configuration

The classical Kubernetes abstraction to handle configuration is the [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap). A ConfigMap is also (usually) a key-value pair collection and a typical one looks like this:

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

The ConfigMap's key-value pairs are typically presented to the containerized app as environment variables. This is the primary mechanism to get the configuration values in our ASP.NET Core applications.

## Azure App Configuration

Azure App Configuration provides a service to manage app settings and feature flags from a centralized store. App Configuration is also a good complement to [Azure Key Vault](/azure/key-vault/general/overview), that's specifically built to handle app secrets like connection strings, tokens, passwords, and digital certificates.

ASP.NET Core apps make use of Azure App Configuration as just another configuration provider, albeit one with quite some [useful features](/azure/azure-app-configuration/overview#why-use-app-configuration).

## Feature Management library

This library provides an opinionated solution to handle feature flags, integrated with the Azure App Configuration, that allows you to dynamically toggle features without having to implement any supporting infrastructure.

The feature management library and Azure App Configuration build seamlessly on ASP.NET Core's configuration abstraction, to streamline the whole configuration and feature management needs.

### Integration

Perhaps the best way to illustrate this integration is to peek into the *Program.cs* configuration section on program startup:

![Image description follows in text.](media/configuration-section-in-program-startup.png)

In the previous code fragment, notice that:

1. Add the `EnvironmentVariables` configuration provider first (line 24). Note: The `CreateDefaultBuilder()` method adds the JSON file configuration provider to get values from *appsettings.json*.
2. If FeatureManagement is enabled and the App Configuration endpoint configured (line 27). (You can take a look at the ConfigMap above).
3. Add the `AzureAppConfiguration` provider (line 29). Being the second in the chain of providers, it can override any value taken from the ConfigMap.
4. Connect to the App Configuration endpoint (line 31).
5. Enable the feature flags (line 32).
6. Set the configuration refresh rate from the App Configuration store (line 35).

## Resources

- [Configuration in ASP.NET Core](/aspnet/core/fundamentals/configuration)
- [Kubernetes ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/)
- [What is Azure App Configuration?](/azure/azure-app-configuration/overview)
- [Feature management overview](/azure/azure-app-configuration/concept-feature-management)
