Azure App Configuration is a fully managed service that stores application settings as key-value pairs in a centralized, cloud-hosted store. AI solutions on Azure depend on numerous configuration settings that control model endpoints, batch sizes, retry policies, and service connection details. Azure App Configuration separates these settings from application code so developers can update configuration without rebuilding or redeploying the application. This unit covers the core concepts of App Configuration, how to connect from Python application code using the provider library, and how to authenticate securely with managed identity.

> [!NOTE]
> The code examples in this unit are patterns to adapt for your own applications. They demonstrate key concepts rather than providing complete runnable solutions.

## Understand the App Configuration data model

Azure App Configuration stores each setting as a key-value pair with several supporting properties that control how the setting is identified, interpreted, and managed. Understanding this data model helps you design a configuration schema that scales across multiple services and environments in your AI solution.

Each configuration setting consists of the following properties:

- **Key:** A case-sensitive unicode string that identifies the setting. Keys support hierarchical naming through delimiters such as `:` or `/`, which lets you organize related settings under logical groupings. For example, `OpenAI:Endpoint` and `OpenAI:ModelName` group Azure OpenAI settings together. There's no enforced schema on keys, so you can choose whatever hierarchy makes sense for your application.
- **Value:** A unicode string that holds the setting's data. The combined size of a key and its value can't exceed 10 KB. Values can hold plain strings, JSON objects, or references to other resources like Key Vault secrets.
- **Label:** An optional tag that creates variants of the same key. Labels let you store different values for the same key name across environments, regions, or versions. A key without a label uses the null label, which serves as the default.
- **Content type:** An optional property that indicates how the value should be interpreted. Setting the content type to `application/json` tells the provider to parse the value as a JSON object. Key Vault reference content types tell the provider to resolve the value from Azure Key Vault.
- **Tags:** Optional metadata key-value pairs that you can attach to a setting for filtering and organization.

## Install the Python provider library

The `azure-appconfiguration-provider` library provides a high-level interface for loading configuration settings from an App Configuration store into your Python application. The library creates a `Mapping` object that behaves like a Python dictionary, so you can access settings using standard dictionary syntax. You also need the `azure-identity` library for authentication.

```bash
pip install azure-appconfiguration-provider azure-identity
```

The provider's `load()` function connects to your App Configuration store, retrieves the settings you specify, and returns a dictionary-like configuration object. This approach loads all relevant settings in a single call rather than fetching them individually, which reduces network overhead and simplifies application initialization.

## Connect and retrieve settings

The `load()` function accepts an `endpoint` parameter for the App Configuration store URL and a `credential` parameter for authentication. The endpoint follows the pattern `https://<store-name>.azconfig.io`. The following code fragment shows how to connect to App Configuration and retrieve a setting value.

```python
# Code fragment - focus on connecting to App Configuration and accessing a setting
from azure.appconfiguration.provider import load
from azure.identity import DefaultAzureCredential
import os

endpoint = os.environ.get("AZURE_APPCONFIG_ENDPOINT")
credential = DefaultAzureCredential()

config = load(endpoint=endpoint, credential=credential)

# Access settings using dictionary syntax
model_endpoint = config["OpenAI:Endpoint"]
batch_size = config["Pipeline:BatchSize"]
```

The `config` object holds all loaded settings and supports standard dictionary operations like `in` for existence checks, `get()` for default values, and iteration over keys. By default, the provider loads all key-value pairs with the null label (no label assigned) from the store.

## Authenticate with DefaultAzureCredential

`DefaultAzureCredential` chains multiple authentication methods in a defined order, automatically selecting the first one that succeeds. In production on Azure-hosted services like App Service, Azure Kubernetes Service, Azure Functions, and Container Apps, managed identity authenticates the application without any stored credentials. In local development, the Azure CLI or Visual Studio Code credential provides access. This single credential class handles both scenarios, so your code doesn't need conditional authentication logic for different environments.

The application identity requires the **App Configuration Data Reader** Azure RBAC role to retrieve settings from the store. This role grants read-only access to key-value pairs, feature flags, and Key Vault references. For operators or CI/CD pipelines that need to create and modify settings, assign the **App Configuration Data Owner** role instead.

Using managed identities eliminates connection strings from your application configuration entirely. Instead of managing and rotating a connection string that grants full access to the store, the managed identity authenticates through Microsoft Entra ID and the RBAC role assignment controls exactly what the identity can do. This approach follows the principle of least privilege because you can grant read-only access to application identities while restricting write access to operators.

## Select and filter keys with SettingSelector

The `SettingSelector` class filters which keys the provider loads from the store. Without a selector, the provider loads every key-value pair with the null label, which might include settings from other applications sharing the same store. You can use `key_filter` to match keys by prefix or pattern (wildcards use `*`) and `label_filter` to select settings for a specific environment or version. This filtering approach loads only the configuration relevant to the current application context, reducing memory usage and avoiding key name collisions.

```python
# Code fragment - focus on SettingSelector for filtering keys by prefix and label
from azure.appconfiguration.provider import load, SettingSelector
from azure.identity import DefaultAzureCredential

selects = [
    SettingSelector(key_filter="Pipeline:*", label_filter="Production")
]

config = load(
    endpoint=endpoint,
    credential=DefaultAzureCredential(),
    selects=selects
)

# Only keys matching "Pipeline:*" with the "Production" label are loaded
batch_size = config["Pipeline:BatchSize"]
```

You can pass multiple `SettingSelector` instances to load several groups of settings in a single call. When multiple selectors match the same key, the last selector in the list takes priority. This stacking behavior is the foundation for environment-specific overrides, which the next unit covers in detail.

## Trim key prefixes

Hierarchical key names like `DocPipeline:OpenAI:Endpoint` keep the configuration store organized, but the full prefix is usually unnecessary inside application code. The `trim_prefixes` parameter removes specified prefixes from key names when loading configuration, so the application can access settings with shorter, cleaner names.

```python
# Code fragment - focus on trimming key prefixes for cleaner access
config = load(
    endpoint=endpoint,
    credential=DefaultAzureCredential(),
    trim_prefixes=["DocPipeline:"]
)

# Access "DocPipeline:OpenAI:Endpoint" as "OpenAI:Endpoint"
model_endpoint = config["OpenAI:Endpoint"]
```

Trimming is especially useful when multiple applications share a configuration store and each application's keys use a unique prefix. The application trims its own prefix and works with simple, application-scoped key names without awareness of the shared namespace.

## Enable dynamic configuration refresh

The provider supports dynamic configuration refresh so your application can pick up changes from App Configuration without a restart. You enable refresh by specifying one or more sentinel keys to watch through the `refresh_on` parameter. When the provider detects a change to a watched key, it reloads the entire configuration to maintain consistency. The `refresh_interval` parameter controls how frequently the provider checks for changes, specified in seconds.

```python
# Code fragment - focus on enabling dynamic refresh with a sentinel key
from azure.appconfiguration.provider import load, WatchKey
from azure.identity import DefaultAzureCredential

config = load(
    endpoint=endpoint,
    credential=DefaultAzureCredential(),
    refresh_on=[WatchKey("Sentinel")],
    refresh_interval=60
)

# Later in your application loop or request handler
config.refresh()

# Access settings - values reflect the latest from the store after refresh
batch_size = config["Pipeline:BatchSize"]
```

The sentinel key pattern involves a dedicated key (commonly named `Sentinel`) that you update whenever you want the application to reload its configuration. Changing the sentinel key signals the provider that a new set of configuration values is available. The provider's `refresh()` method must be called explicitly, typically in a request handler or application loop. If the `refresh_interval` didn't elapse since the last check, the `refresh()` call returns immediately without contacting the store.

This pattern gives operators control over when configuration updates take effect. An operator changes one or more settings in the store, then updates the sentinel key to trigger the refresh. The application picks up all changes together on the next refresh cycle, maintaining configuration consistency rather than applying partial updates.

## Additional resources

- [What is Azure App Configuration?](/azure/azure-app-configuration/overview)
- [Azure App Configuration Python provider quickstart](/azure/azure-app-configuration/quickstart-python-provider)
- [Azure App Configuration best practices](/azure/azure-app-configuration/howto-best-practices)
