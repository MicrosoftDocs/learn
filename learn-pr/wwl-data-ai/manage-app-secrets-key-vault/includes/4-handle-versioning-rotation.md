Every time you store a secret with the same name in Azure Key Vault, the vault creates a new version rather than overwriting the existing value. This versioning model is fundamental to supporting credential rotation in AI applications because it allows old and new credentials to coexist during a transition window. Developers need to understand how versioning works, what rotation strategies are available, and how to write application code that handles credential transitions without downtime.

## Understand how Key Vault versions secrets

Every call to `set_secret()` with the same secret name creates a new version and assigns it a unique version identifier (a GUID string). The `get_secret()` call without a version parameter always returns the latest enabled version. You can also call `get_secret()` with a specific version identifier to retrieve that exact version regardless of whether newer versions exist. Previous versions remain accessible until you explicitly disable or delete them.

```python
# Code fragment - focus on creating a new version and retrieving by version ID
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient

credential = DefaultAzureCredential()
client = SecretClient(
    vault_url="https://kv-ragpipeline-prod.vault.azure.net/",
    credential=credential
)

# Create initial version
initial = client.set_secret("cosmosdb-connection-string", "AccountEndpoint=https://...")
print(f"Version 1: {initial.properties.version}")

# Create new version with updated value
updated = client.set_secret("cosmosdb-connection-string", "AccountEndpoint=https://new...")
print(f"Version 2: {updated.properties.version}")

# Retrieve latest version (returns version 2)
latest = client.get_secret("cosmosdb-connection-string")

# Retrieve specific version (returns version 1)
specific = client.get_secret("cosmosdb-connection-string",
                              version=initial.properties.version)
```

This versioning behavior means your applications don't need to know version identifiers in advance. By default, `get_secret()` returns the latest version, so storing a new version and having the application refetch the secret is enough to complete a rotation. Version identifiers become important when you need to audit which credential version was in use at a specific time or when you need to roll back to a previous version.

## List and inspect secret versions

The `list_properties_of_secret_versions()` method enumerates all versions of a specific secret. Each version entry includes the version identifier, creation date, expiration date, and enabled status. This operation is useful for auditing rotation history, verifying that a rotation occurred successfully, and identifying older versions that should be disabled to prevent continued use after rotation.

```python
# Code fragment - focus on listing and inspecting secret versions
versions = client.list_properties_of_secret_versions("cosmosdb-connection-string")

for version in versions:
    print(f"Version: {version.version}")
    print(f"  Created: {version.created_on}")
    print(f"  Enabled: {version.enabled}")
    print(f"  Expires: {version.expires_on}")
```

After a successful rotation, consider disabling previous versions to enforce that all application instances use the new credential. You can disable a version by calling `update_secret_properties()` with `enabled=False`, which prevents the version from being retrieved even if an application references it by version identifier.

## Choose a rotation strategy

Credential rotation is the process of replacing an active credential with a new one. The right rotation strategy depends on the target service, your team's operational maturity, and how quickly you need to respond to a compromised credential. AI applications typically manage credentials for multiple downstream services, and each service might use a different rotation approach.

**Manual rotation** is the simplest approach. A human operator or CI/CD pipeline creates a new secret version in Key Vault and then restarts or signals the application to pick up the new value. This strategy works well for services that change credentials infrequently, such as a third-party AI model provider that issues long-lived API keys. The downside is that there's a window between when the new secret is stored and when the application restarts to pick it up. During that window, the application still uses the old credential.

**Automated rotation with Event Grid** removes the human step from the rotation process. Key Vault integrates with Azure Event Grid to emit events when secrets approach their expiration date. The `SecretNearExpiry` event fires thirty days before a secret's expiration date, and the `SecretExpired` event fires when the current version's expiration date passes. An Azure Function or other event handler listens for these events, generates a new credential with the target service, and stores the new value as a new secret version in Key Vault. This pattern automates the entire rotation lifecycle. The automated rotation flow works as follows:

1. Key Vault emits a `SecretNearExpiry` event.
1. Event Grid delivers the notification to a registered handler.
1. An Azure Function receives the event.
1. The function generates a new credential with the target service.
1. The function stores the new credential as a new secret version in Key Vault.

**Dual-credential rotation** addresses services that support two active keys simultaneously, such as Azure Storage accounts and Azure Cosmos DB. The rotation process follows these steps:

1. Generate a new secondary key on the target service.
1. Store the new key as a new secret version in Key Vault.
1. Wait for all application instances to pick up the new value.
1. Regenerate the old primary key on the target service.

This two-phase approach guarantees that at least one valid credential always exists. No application instance experiences an authentication failure during the rotation window because the old credential remains valid until every instance transitions to the new one.

## Implement zero-downtime rotation in application code

Regardless of which rotation strategy you choose, your application code must handle the transition between old and new credentials gracefully. The recommended pattern catches authentication failures from downstream services, refetches the secret from Key Vault (which returns the latest version), and retries the operation with the new credential. This approach avoids hard restarts and supports rotation at any time without coordination between the operator and the running application.

```python
# Code fragment - focus on retry-on-auth-failure pattern for rotation
from azure.core.exceptions import HttpResponseError

def call_downstream_service(client, secret_name, max_retries=1):
    """Retrieve secret and call service, refreshing on auth failure."""
    secret_value = client.get_secret(secret_name).value

    for attempt in range(max_retries + 1):
        try:
            # Use secret_value to authenticate with downstream service
            result = connect_to_service(secret_value)
            return result
        except AuthenticationError:
            if attempt < max_retries:
                # Credential might be rotated - refresh from Key Vault
                secret_value = client.get_secret(secret_name).value
            else:
                raise
```

This pattern limits the performance impact of rotation to a single extra Key Vault call when the first authentication attempt fails. During normal operation, the application uses the cached credential without calling Key Vault. The retry only triggers when the downstream service rejects the credential, which signals that a rotation did occur and the application needs to retrieve the updated value.

## Set expiration dates on secrets

The `expires_on` property defines an expiration date when you create or update a secret. Expired secrets still exist in Key Vault and can be retrieved through `get_secret()`, so expiration is informational rather than a hard access block. The expiration date signals to applications and monitoring systems that the credential is stale and should be replaced. Combining expiration dates with Event Grid notifications creates an automated workflow that triggers rotation before a secret expires.

```python
# Code fragment - focus on setting expiration when creating a secret
from datetime import datetime, timezone, timedelta

expiration_date = datetime.now(timezone.utc) + timedelta(days=90)

client.set_secret(
    "openai-api-key",
    "sk-newkey789",
    expires_on=expiration_date,
    content_type="text/plain",
    tags={"rotation-policy": "90-days", "service": "azure-openai"}
)
```

A common pattern for AI applications is to set a ninety-day expiration on API keys and subscribe to the `SecretNearExpiry` event through Event Grid. The event fires thirty days before expiration, giving your rotation automation or operations team a thirty-day window to generate and store a new credential. This approach prevents expired credentials from causing unexpected failures in production.

## Additional resources

- [Automate secret rotation for resources with two sets of authentication credentials](/azure/key-vault/secrets/tutorial-rotation-dual)
- [Monitoring Key Vault with Azure Event Grid](/azure/key-vault/general/event-grid-overview)
- [Understanding autorotation in Azure Key Vault](/azure/key-vault/general/autorotation)
