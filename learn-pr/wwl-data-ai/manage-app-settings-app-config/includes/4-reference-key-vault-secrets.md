AI applications typically need both nonsensitive configuration settings and sensitive credentials to operate. A document processing pipeline might need an Azure OpenAI endpoint URL (nonsensitive) and an API key (sensitive) for the same service. Storing both types of values directly in App Configuration means they share the same access controls, and sensitive data doesn't benefit from the audit logging, rotation, and HSM-backed encryption that Azure Key Vault provides. Key Vault references solve this problem by letting App Configuration point to secrets stored in Key Vault, so the application retrieves everything through a single configuration path while sensitive data stays protected in Key Vault.

> [!NOTE]
> The code examples in this unit are patterns to adapt for your own applications. They demonstrate key concepts rather than providing complete runnable solutions.

## Understand how Key Vault references work

A Key Vault reference is a special key-value pair in App Configuration where the value contains a URI pointing to a secret in Azure Key Vault. App Configuration stores the reference metadata, including the vault URI, secret name, and an optional version, with a content type of `application/vnd.microsoft.appconfig.keyvaultref+json;charset=utf-8`. The key name behaves like any other App Configuration key. You can apply labels to it, include it in `SettingSelector` filters, and access it through standard dictionary syntax in your application code.

When the provider encounters a key with the Key Vault reference content type, it recognizes the key as a reference and resolves the actual secret value from Key Vault automatically. The application code accesses the resolved value the same way it accesses any other configuration setting. There's no need to write separate Key Vault SDK calls or conditional logic to distinguish between regular settings and secrets. The provider handles the resolution transparently, so the application sees a flat dictionary of settings where some values come directly from App Configuration and others come from Key Vault.

This indirection means that App Configuration never stores the actual secret value. It stores only the pointer to where the secret lives in Key Vault. Updating a secret in Key Vault automatically provides the new value when the application next loads or refreshes configuration, without requiring any change to the reference in App Configuration.

## Create Key Vault references

You can create Key Vault references through the Azure portal or the Azure CLI. In the portal, the Configuration explorer provides a **Create > Key Vault reference** option where you specify the key name, the target Key Vault, and the secret name. The portal builds the reference URI and sets the correct content type automatically.

Through the Azure CLI, you can use `az appconfig kv set-keyvault` to create a reference. The following command creates a Key Vault reference in your App Configuration store that points to a secret named `openai-api-key` in your Key Vault.

```azurecli
az appconfig kv set-keyvault \
    --name myAppConfigStore \
    --key "OpenAI:ApiKey" \
    --secret-identifier "https://my-keyvault.vault.azure.net/secrets/openai-api-key" \
    --label "Production"
```

The `--secret-identifier` parameter accepts the full URI to the secret in Key Vault. You can include a specific version by appending the version identifier to the URI (for example, `https://my-keyvault.vault.azure.net/secrets/openai-api-key/abc123def456`), or omit the version to always resolve the latest version. Omitting the version is the recommended approach for most scenarios because it lets the application automatically pick up rotated secrets without any configuration change.

You can also apply labels to Key Vault references, which lets you point to different secrets for different environments. A `Production` label might reference a production Key Vault, while a `Development` label references a development Key Vault with test credentials.

## Configure the Python provider for Key Vault resolution

The `azure-appconfiguration-provider` library resolves Key Vault references automatically when you supply a Key Vault credential through the `keyvault_credential` parameter. You pass a `DefaultAzureCredential` instance that authenticates to both App Configuration and Key Vault using the same managed identity. The provider uses this credential to connect to any Key Vault referenced in the configuration.

```python
# Code fragment - focus on resolving Key Vault references through the provider
from azure.appconfiguration.provider import load
from azure.identity import DefaultAzureCredential
import os

endpoint = os.environ.get("AZURE_APPCONFIG_ENDPOINT")
credential = DefaultAzureCredential()

config = load(
    endpoint=endpoint,
    credential=credential,
    keyvault_credential=credential
)

# Regular settings and resolved Key Vault secrets are accessed the same way
model_endpoint = config["OpenAI:Endpoint"]     # Regular value from App Configuration
api_key = config["OpenAI:ApiKey"]               # Resolved from Key Vault
batch_size = config["Pipeline:BatchSize"]       # Regular value from App Configuration
```

The `config` object contains all settings, whether they come from App Configuration directly or are resolved from Key Vault. The application code doesn't distinguish between the two sources. This unified retrieval path simplifies application initialization because a single `load()` call retrieves everything the application needs.

## Set up authentication for both services

The application identity must have permissions on both App Configuration and Key Vault for Key Vault references to resolve successfully. Each service uses its own set of Azure RBAC roles, and the identity needs at least one role on each service.

For App Configuration, the identity requires the **App Configuration Data Reader** role to retrieve settings and references. For Key Vault, the identity requires the **Key Vault Secrets User** role to read the secret values that references point to. When the application runs on an Azure-hosted service with a system-assigned or user-assigned managed identity, the same identity authenticates to both services through `DefaultAzureCredential`.

This dual-role setup means you need to create two role assignments for the application's managed identity: one on the App Configuration store and one on the Key Vault. If the identity has App Configuration access but lacks Key Vault access, the provider throws an error when it attempts to resolve a Key Vault reference. The error message identifies which Key Vault and secret the provider couldn't access, which helps you diagnose missing role assignments.

For applications that access secrets from multiple Key Vaults, the identity needs the **Key Vault Secrets User** role on each vault referenced in the configuration. Alternatively, you can provide vault-specific credentials through the `keyvault_client_configs` parameter in the `load()` function, which maps Key Vault URIs to individual credential configurations.

## Understand refresh behavior for Key Vault references

The provider supports refreshing Key Vault secret values independently from regular configuration settings through the `secret_refresh_interval` parameter. While the Key Vault reference URI in App Configuration remains unchanged, the underlying secret in Key Vault might rotate as part of your security practices. The `secret_refresh_interval` parameter tells the provider how often to retrieve fresh secret values from Key Vault, regardless of whether any changes are detected in the App Configuration store itself.

```python
# Code fragment - focus on configuring independent secret refresh
config = load(
    endpoint=endpoint,
    credential=credential,
    keyvault_credential=credential,
    refresh_on=[WatchKey("Sentinel")],
    refresh_interval=60,
    secret_refresh_interval=7200  # Re-resolve Key Vault secrets every 2 hours
)
```

The `secret_refresh_interval` is specified in seconds and controls the Key Vault secret refresh cycle independently of the `refresh_interval` that governs regular configuration settings. When the application calls the `refresh()` method and the secret refresh interval elapsed, the provider retrieves fresh secret values from Key Vault. This separation lets you check for configuration changes frequently (every 60 seconds, for example) while re-resolving secrets on a longer cycle that aligns with your rotation schedule.

This behavior integrates well with Key Vault's rotation capabilities. Azure Key Vault supports automated secret rotation through rotation policies, and several Azure services can rotate their own credentials automatically. When a rotation occurs, the new secret version becomes the latest version in Key Vault. The next time the provider's secret refresh interval elapses and the application calls `refresh()`, it resolves the reference against the latest version and provides the updated secret value to the application.

Keep in mind that each Key Vault reference resolution generates a request to the Key Vault service. If your configuration contains many Key Vault references, consider the aggregate request volume against [Key Vault service limits](/azure/key-vault/general/service-limits) when choosing a secret refresh interval.

## Additional resources

- [Use Key Vault references in a Python app](/azure/azure-app-configuration/use-key-vault-references-python-provider)
- [Azure App Configuration best practices](/azure/azure-app-configuration/howto-best-practices)
- [About Azure Key Vault](/azure/key-vault/general/overview)
