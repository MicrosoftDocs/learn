The Python `azure-keyvault-secrets` library provides the `SecretClient` class for all secret operations against Azure Key Vault. Combined with the `azure-identity` library for authentication, these two packages give your AI application everything it needs to retrieve credentials at runtime without storing any vault credentials in code. This unit walks through client setup, secret retrieval, listing operations, error handling, and async patterns for high-throughput AI services.

> [!NOTE]
> All code examples in this unit are patterns to adapt to your application's architecture. The `azure-keyvault-secrets` library requires Python 3.9 or later and is updated regularly. Visit the [Azure Key Vault secrets client library for Python](/python/api/overview/azure/keyvault-secrets-readme) for the most current API reference.

## Install and configure the SDK

The Key Vault secrets SDK requires two packages: `azure-keyvault-secrets` for vault operations and `azure-identity` for authentication. You install both packages together because every `SecretClient` instance requires a credential object to authenticate with Key Vault. The `SecretClient` class provides all CRUD and listing operations for secrets, and you initialize it with the vault URL and a credential.

```bash
pip install azure-keyvault-secrets azure-identity
```

The vault URL follows the pattern `https://<vault-name>.vault.azure.net/`. You can find this URL in the Azure portal on the vault's overview page, or retrieve it with the Azure CLI using `az keyvault show --name <vault-name> --query properties.vaultUri`.

## Authenticate with DefaultAzureCredential

`DefaultAzureCredential` from the `azure-identity` library chains multiple authentication methods in a defined order, trying each one until authentication succeeds. This single credential class works across development and production environments without code changes. In production, managed identity authenticates the application without any stored credentials. In local development, the Azure CLI or Azure Developer CLI credential provides access.

The authentication chain follows this order:

1. **EnvironmentCredential:** Reads `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, and `AZURE_CLIENT_SECRET` environment variables for service principal authentication.
1. **WorkloadIdentityCredential:** Authenticates using Kubernetes workload identity tokens.
1. **ManagedIdentityCredential:** Uses the Azure managed identity (system-assigned or user-assigned) attached to the compute resource.
1. **AzureCliCredential:** Authenticates using the account from `az login`.
1. **AzureDeveloperCliCredential:** Authenticates using the account from `azd auth login`.
1. **AzurePowerShellCredential:** Authenticates using the account from `Connect-AzAccount`.

For deployed AI services running on Azure compute resources (such as Azure Container Apps, Azure Kubernetes Service, or Azure App Service), managed identity is the recommended authentication method. The application authenticates to Key Vault through Microsoft Entra ID without any stored credentials. You assign the `Key Vault Secrets User` role to the managed identity, and the application gains read access to secrets in the vault.

## Retrieve a secret by name

The `get_secret()` method retrieves the current version of a secret from Key Vault. The returned `KeyVaultSecret` object contains the secret value, name, and a `properties` object with metadata such as version, creation date, expiration date, enabled status, content type, and tags. Retrieving a single secret is the most common operation in AI application code because your services call it at startup or on-demand to load credentials for downstream services.

```python
# Code fragment - focus on retrieving a secret with DefaultAzureCredential
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient

credential = DefaultAzureCredential()
client = SecretClient(
    vault_url="https://kv-ragpipeline-prod.vault.azure.net/",
    credential=credential
)

secret = client.get_secret("openai-api-key")

# Access the secret value and metadata
api_key = secret.value
version = secret.properties.version
created = secret.properties.created_on
content_type = secret.properties.content_type
```

The `secret.value` property contains the secret string that your application passes to downstream service clients. The `properties` object provides metadata for logging and debugging. You can log the secret name and version for audit purposes without exposing the actual secret value.

## List secret properties

The `list_properties_of_secrets()` method enumerates all secrets in the vault without retrieving their values. This operation returns `SecretProperties` objects that contain metadata such as name, version, content type, tags, and enabled status. You can use this method to discover available secrets, build configuration maps at startup, or verify that expected secrets exist before your application begins processing requests.

```python
# Code fragment - focus on listing secret properties for discovery
secret_properties = client.list_properties_of_secrets()

for prop in secret_properties:
    print(f"Secret: {prop.name}, Enabled: {prop.enabled}, "
          f"Content type: {prop.content_type}")
    if prop.tags:
        print(f"  Tags: {prop.tags}")
```

This listing operation is useful during application startup to validate that all required credentials exist in the vault. If your AI service needs five specific secrets (such as an API key, a database connection string, and three service tokens), you can check for their existence before attempting to retrieve values. This approach surfaces configuration errors early rather than failing on the first request that needs a missing credential.

## Handle errors and exceptions

The SDK raises specific exception types for different failure scenarios, and your application should handle each type differently. A missing secret indicates a configuration error that requires operator intervention, while a transient network error warrants a retry. Distinguishing between these cases in your error handling logic prevents your application from retrying errors that won't resolve on their own and helps operators diagnose issues faster.

```python
# Code fragment - focus on structured error handling for secret retrieval
from azure.core.exceptions import (
    ResourceNotFoundError,
    HttpResponseError,
    ServiceRequestError
)

def get_secret_safely(client, secret_name):
    try:
        secret = client.get_secret(secret_name)
        return secret.value
    except ResourceNotFoundError:
        # Secret doesn't exist - configuration error
        print(f"Secret '{secret_name}' not found in vault. "
              "Verify the secret name and vault configuration.")
        raise
    except HttpResponseError as e:
        # Authentication or authorization failure
        print(f"Access denied or server error for '{secret_name}': "
              f"{e.status_code} - {e.message}")
        raise
    except ServiceRequestError:
        # Network connectivity issue - may be transient
        print(f"Network error retrieving '{secret_name}'. "
              "Check connectivity to Key Vault.")
        raise
```

`ResourceNotFoundError` fires when the secret name doesn't exist in the vault. `HttpResponseError` covers authentication failures (the identity lacks the required RBAC role), authorization errors, and server-side issues. `ServiceRequestError` indicates a network-level problem, such as DNS resolution failure or a timeout, which might resolve on retry.

## Use the async client for high-throughput applications

The `azure.keyvault.secrets.aio` module provides an async `SecretClient` for applications that use asyncio. AI services that process concurrent requests benefit from async secret retrieval because it avoids blocking the event loop during vault calls. The async client exposes the same API surface as the synchronous client, so you can switch between them without changing your application logic.

```python
# Code fragment - focus on async secret retrieval
from azure.identity.aio import DefaultAzureCredential
from azure.keyvault.secrets.aio import SecretClient

async def get_ai_credentials():
    credential = DefaultAzureCredential()
    client = SecretClient(
        vault_url="https://kv-ragpipeline-prod.vault.azure.net/",
        credential=credential
    )

    async with client:
        secret = await client.get_secret("openai-api-key")

    await credential.close()
    return secret.value
```

The async client and credential are both async context managers. You should use `async with` or explicitly call `await client.close()` and `await credential.close()` when you're done with them. In web frameworks like FastAPI or aiohttp, create the client once at application startup and reuse it across requests to avoid the overhead of creating new connections for each operation.

## Additional resources

- [Azure Key Vault secrets client library for Python](/python/api/overview/azure/keyvault-secrets-readme)
- [DefaultAzureCredential overview](/python/api/overview/azure/identity-readme#defaultazurecredential)
- [Key Vault developer's guide](/azure/key-vault/general/developers-guide)
