Azure Functions stores configuration as application settings, which the runtime injects into the process as environment variables. For AI backends, these settings typically include service endpoints, model identifiers, connection strings, and feature flags. Managing these values securely across development, staging, and production environments require a layered approach that separates nonsecret configuration from sensitive credentials and provides auditability for secret access.

## Use application settings for configuration

Application settings are key-value pairs that you configure in the Azure portal, Azure CLI, or through infrastructure-as-code templates. The Azure Functions runtime exposes these settings to your function code as environment variables, making them accessible through standard language mechanisms. Azure encrypts application settings at rest and decrypts them only when injecting them into the app's process memory, so they aren't stored in plaintext on disk.

In Python, you access application settings using `os.environ` for required settings or `os.getenv` for settings with fallback defaults. This pattern keeps your function code environment-agnostic, since the same code reads configuration from `local.settings.json` during development and from Azure-managed application settings in production.

```python
# Code fragment - focus on reading application settings
import os

ai_endpoint = os.environ["AI_SERVICE_ENDPOINT"]
model_id = os.environ["MODEL_ID"]
confidence_threshold = float(os.getenv("CONFIDENCE_THRESHOLD", "0.85"))
max_batch_size = int(os.getenv("MAX_BATCH_SIZE", "10"))
```

Common application settings for AI workloads include Azure AI service endpoints, model deployment names, inference confidence thresholds, concurrency limits, and feature flags that toggle processing behavior. Keep each setting focused on a single value to make updates granular. Avoid encoding complex structures in a single setting when separate key-value pairs provide clearer configuration management.

Locally, application settings live in `local.settings.json` under the `Values` object. This file is excluded from source control by the default `.gitignore` because it often contains connection strings and other sensitive values. When deploying, the runtime reads settings from the Azure-managed configuration store rather than from this file.

## Reference secrets from Azure Key Vault

Key Vault references let you store sensitive values in Azure Key Vault and reference them from application settings. Instead of placing an API key or connection string directly in an application setting, you set the value to a Key Vault reference expression. The runtime resolves the reference at app startup, retrieves the secret from Key Vault, and injects the actual value as an environment variable. Your function code reads the setting with `os.environ` as usual, unaware that the value originates from Key Vault.

Two reference syntaxes are available. The URI syntax points to a specific secret version or the latest version:

```
@Microsoft.KeyVault(SecretUri=https://myvault.vault.azure.net/secrets/AiServiceKey/)
```

The named syntax uses vault name and secret name as separate components:

```
@Microsoft.KeyVault(VaultName=myvault;SecretName=AiServiceKey)
```

Both syntaxes require the function app to have a managed identity (system-assigned or user-assigned) with the `Key Vault Secrets User` role on the target vault. Without this role assignment, the runtime can't retrieve the secret and the application setting resolves to an error indicator rather than the secret value.

Key Vault references resolve at app startup and are periodically re-resolved. When you use a versionless secret URI (omitting the version GUID), the runtime automatically detects new secret versions and begins using the latest version within 24 hours. Any configuration change to the app triggers an immediate refetch of all referenced secrets. If you specify a version in the URI, the reference remains pinned to that version until you update the application setting with a new version identifier. For AI backends that use API keys with scheduled rotation, use versionless URIs so the runtime picks up rotated secrets automatically.

The benefits of Key Vault references extend beyond security. They centralize secret management across multiple function apps and services, provide audit logging through Key Vault's access policies and diagnostic settings, and separate secret ownership from application deployment. A security team can manage and rotate secrets without modifying application configuration.

## Integrate with Azure App Configuration

Azure App Configuration provides a centralized store for non-secret configuration values and feature flags. While application settings work well for individual function apps, App Configuration becomes valuable when multiple function apps or microservices share configuration values such as model endpoint URLs, inference thresholds, or feature toggles. Changing a setting once in App Configuration propagates the update across all connected applications.

You connect to App Configuration using the App Configuration provider library for your language. In Python, the `azure-appconfiguration-provider` library loads configuration values during function startup and makes them available throughout the function's lifetime. The provider supports label-based filtering, which lets you load different configuration sets for different environments (development, staging, production) from the same App Configuration store.

```python
# Code fragment - focus on loading configuration from App Configuration
from azure.appconfiguration.provider import load
from azure.identity import DefaultAzureCredential
import os

config = load(
    endpoint=os.environ["APP_CONFIG_ENDPOINT"],
    credential=DefaultAzureCredential(),
    selects=[{"key_filter": "AIBackend/*"}]
)

model_endpoint = config["AIBackend/ModelEndpoint"]
inference_timeout = int(config["AIBackend/InferenceTimeout"])
```

A common architecture combines App Configuration for nonsecret values with Key Vault for secrets. App Configuration even supports Key Vault references as configuration values, creating a unified configuration surface where developers retrieve both regular settings and secrets through the same provider. This layered approach provides centralized management for shared configuration while maintaining strict access control over sensitive values.

## Handle configuration in the local development workflow

Local development requires reproducing the same configuration structure that runs in Azure, but pointing to local services and emulators instead of cloud resources. The `local.settings.json` file mirrors the application settings that the Azure portal manages, giving developers a local equivalent of the production configuration surface.

You can pull current application settings from a deployed function app into your local configuration using the Azure Functions Core Tools command. This command downloads all settings and writes them to `local.settings.json`, which is useful when you need to quickly replicate a production or staging environment's configuration locally.

```bash
func azure functionapp fetch-app-settings <function-app-name>
```

Because `local.settings.json` might contain connection strings or API keys after fetching settings, you can encrypt the file with Core Tools to protect secrets at rest on your development machine. The encrypted file is still readable by the local Functions runtime, but the values aren't visible in plaintext in your editor or file system.

```bash
func settings encrypt
```

For day-to-day development, maintain separate configuration values that point to local resources. Set `AzureWebJobsStorage` to `UseDevelopmentStorage=true` for Azurite, configure Cosmos DB connection strings to target the local emulator endpoint, and use local Redis or PostgreSQL instances. When the app is deployed, these values are replaced by production application settings, Key Vault references, or identity-based connections. This separation ensures that local development never accidentally touches production data or services.

## Additional resources

- [App settings reference for Azure Functions](/azure/azure-functions/functions-app-settings)
- [Use Key Vault references for App Service and Azure Functions](/azure/app-service/app-service-key-vault-references)
- [Azure App Configuration documentation](/azure/azure-app-configuration/overview)
