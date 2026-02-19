AI applications often run in multiple environments with different configuration requirements. A document processing pipeline might use a smaller batch size and a test model endpoint in development, while production uses a larger batch size and the latest model deployment. Managing these differences through separate configuration files or environment-specific variable names creates maintenance overhead and increases the risk of configuration drift. Azure App Configuration provides labels and feature flags as built-in mechanisms to handle environment differentiation and runtime feature control without these complexities.

> [!NOTE]
> The code examples in this unit are patterns to adapt for your own applications. They demonstrate key concepts rather than providing complete runnable solutions.

## Use labels for environment differentiation

Labels create variants of the same key for different environments, regions, or application versions. A key like `Pipeline:BatchSize` can have a label of `Development` with a value of `10`, a label of `Staging` with a value of `50`, and a label of `Production` with a value of `200`. The key name stays the same across all environments, so your application code references `Pipeline:BatchSize` regardless of where it runs. The application selects the appropriate label at startup, and the provider loads the correct value for that environment.

Keys without a label use the null label, represented as `\0` in the provider's API. Null-labeled keys serve as defaults that apply when no environment-specific override exists. This approach eliminates the need for environment-specific configuration files, naming conventions that embed environment identifiers into key names (like `Pipeline_BatchSize_Prod`), or conditional logic in application code that checks which environment is active.

## Stack key-value pairs with composition

The provider supports loading multiple sets of key-value pairs in sequence, where later-loaded values override earlier ones for the same key. This composition pattern is the foundation for managing default settings alongside environment-specific overrides. You load default (null-labeled) settings first, then load environment-specific labeled settings on top. Any key that has an environment-specific value uses the override, while keys without an override retain their default values.

```python
# Code fragment - focus on key-value composition with stacking
from azure.appconfiguration.provider import load, SettingSelector
from azure.identity import DefaultAzureCredential
import os

endpoint = os.environ.get("AZURE_APPCONFIG_ENDPOINT")
environment = os.environ.get("APP_ENVIRONMENT", "Development")

selects = [
    SettingSelector(key_filter="*", label_filter="\0"),
    SettingSelector(key_filter="*", label_filter=environment)
]

config = load(
    endpoint=endpoint,
    credential=DefaultAzureCredential(),
    selects=selects
)

# Defaults load first, then environment-specific values override matching keys
batch_size = config["Pipeline:BatchSize"]
```

The order of `SettingSelector` entries matters. The second selector targets the current environment's label and overrides any matching keys from the first selector. This guarantees that every key has at least a default value while allowing specific environments to customize individual settings. The application doesn't need to know which settings have overrides. It accesses all settings the same way, and the provider handles the composition transparently.

## Design key naming conventions

A well-designed key naming convention makes your configuration store self-documenting and simplifies filtering with `SettingSelector`. Use a hierarchical structure with a consistent delimiter (`:` or `/`) to group related settings by service component. This structure lets you filter keys by prefix to load only the settings a specific service component needs.

Consider the following naming pattern for an AI document processing pipeline:

- **OpenAI:Endpoint** - The Azure OpenAI service endpoint URL
- **OpenAI:DeploymentName** - The model deployment name
- **OpenAI:MaxTokens** - The maximum token count per request
- **CosmosDB:DatabaseName** - The target database for document storage
- **CosmosDB:ContainerName** - The container within the database
- **Pipeline:BatchSize** - The number of documents to process per batch
- **Pipeline:RetryCount** - The maximum number of retry attempts
- **Pipeline:TimeoutSeconds** - The timeout for each processing step

This convention lets a component that only needs Azure OpenAI settings load keys with `key_filter="OpenAI:*"`, avoiding unnecessary settings from other components. Consistent naming also makes it straightforward for operators to browse and manage settings in the Azure portal, where keys sort alphabetically and hierarchical names group related settings together visually.

## Understand feature flags in App Configuration

Feature flags are special key-value pairs that App Configuration manages through a dedicated interface. Each feature flag has a name, an enabled or disabled state, and optional filters that control activation conditions. Azure App Configuration stores feature flags with a `.appconfig.featureflag/` key prefix and a content type of `application/vnd.microsoft.appconfig.ff+json;charset=utf-8`, but the provider and feature management libraries abstract these storage details so you work with simple flag names and boolean states.

Feature flags decouple feature lifecycle from deployment lifecycle. Instead of deploying new code to enable or disable a feature, operators toggle a flag in the Azure portal or through the Azure CLI. The application checks the flag's state at runtime and adjusts its behavior accordingly. This separation is especially valuable for AI applications where you might want to switch between model versions, disable a processing step that produces unexpected results, or gradually roll out a new capability.

## Evaluate feature flags with FeatureManager

The `featuremanagement` library integrates with the App Configuration provider to evaluate feature flags at runtime. You load feature flags by passing `feature_flags_enabled=True` to the provider's `load()` function, then create a `FeatureManager` instance from the loaded configuration. The `FeatureManager` provides an `is_enabled()` method that returns a boolean indicating whether a specific feature flag is active.

```python
# Code fragment - focus on loading feature flags and evaluating them
from azure.appconfiguration.provider import load
from azure.identity import DefaultAzureCredential
from featuremanagement import FeatureManager

config = load(
    endpoint=endpoint,
    credential=DefaultAzureCredential(),
    feature_flags_enabled=True
)

feature_manager = FeatureManager(config)

if feature_manager.is_enabled("UseNewEmbeddingsModel"):
    # Route to the new embeddings model
    process_with_new_model(document)
else:
    # Use the current embeddings model
    process_with_current_model(document)
```

The `FeatureManager` evaluates the flag's state each time `is_enabled()` is called. When combined with dynamic refresh (described in the next section), this means the application can respond to flag changes without a restart. The `featuremanagement` package is installed separately from the provider library using `pip install featuremanagement`.

## Refresh feature flags dynamically

Feature flags support dynamic refresh independently from regular configuration settings. You enable feature flag refresh by passing `feature_flag_refresh_enabled=True` to the `load()` function. When the provider refreshes, it checks all loaded feature flags for changes. The refresh for feature flags and regular configuration settings is independent. A feature flag change doesn't trigger a refresh of configuration settings, and a configuration setting change doesn't trigger a refresh of feature flags. Both refreshes happen when you call the `refresh()` method on the configuration object.

```python
# Code fragment - focus on enabling dynamic refresh for feature flags
from azure.appconfiguration.provider import load, WatchKey
from azure.identity import DefaultAzureCredential
from featuremanagement import FeatureManager

config = load(
    endpoint=endpoint,
    credential=DefaultAzureCredential(),
    feature_flags_enabled=True,
    feature_flag_refresh_enabled=True,
    refresh_on=[WatchKey("Sentinel")],
    refresh_interval=30
)

feature_manager = FeatureManager(config)

# In your application loop or request handler
config.refresh()

# Feature flag state reflects the latest value from the store
if feature_manager.is_enabled("UseNewEmbeddingsModel"):
    process_with_new_model(document)
```

This dynamic refresh capability lets operators control features in real time. An operator can enable a feature flag in the Azure portal, and the application picks up the change on the next refresh cycle without a restart or redeployment. This is useful for AI applications where you might need to disable a malfunctioning processing step immediately or enable a new model version during a specific maintenance window.

## Apply feature flags in AI application scenarios

Feature flags support several practical patterns in AI solutions that go beyond simple on/off toggles. Each pattern uses the same underlying mechanism (a boolean check at runtime) but applies it to different architectural decisions in the application.

- **Progressive model rollouts:** You can enable a new embeddings model for internal testing through a feature flag before exposing it to production traffic. The flag gates the code path that routes requests to the new model deployment, so you can validate results with real data before switching all traffic.
- **Kill switches:** A feature flag can serve as an emergency shutoff for a processing step that produces incorrect results. If a new document classification stage starts generating inaccurate labels, an operator disables the flag and the pipeline skips that stage. This response takes seconds rather than the minutes or hours required for a code rollback and redeployment.
- **A/B testing configurations:** Feature flags can route different requests through different processing paths to compare results. One path uses the current model configuration while the other uses an experimental configuration. The application logs results from both paths, and the team analyzes which configuration performs better before making a permanent switch.
- **Staged pipeline activation:** In a multi-stage processing pipeline, feature flags can gate individual stages. Operators enable stages one at a time as they verify that each stage processes data correctly. This staged activation reduces risk when deploying complex pipeline changes.

## Additional resources

- [Keys and values in Azure App Configuration](/azure/azure-app-configuration/concept-key-value)
- [Feature management overview](/azure/azure-app-configuration/concept-feature-management)
- [Add feature flags to a Python app](/azure/azure-app-configuration/quickstart-feature-flag-python)
