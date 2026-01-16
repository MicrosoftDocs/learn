Application settings provide configuration values to your containerized application at runtime. App Service injects these values as environment variables when the container starts. Using app settings instead of hardcoded values allows you to deploy the same container image across different environments with environment-specific configuration.

## App settings

App settings are name-value pairs that App Service injects as environment variables. Your application reads these values using standard environment variable access methods for your programming language.

Create or update app settings using the Azure CLI:

```azurecli
az webapp config appsettings set \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --settings \
        STORAGE_ACCOUNT_NAME=mystorageaccount \
        LOG_LEVEL=INFO \
        MAX_DOCUMENT_SIZE_MB=50
```

Your application accesses these values as environment variables:

```python
import os

storage_account = os.environ.get('STORAGE_ACCOUNT_NAME')
log_level = os.environ.get('LOG_LEVEL', 'WARNING')
max_size = int(os.environ.get('MAX_DOCUMENT_SIZE_MB', 10))
```

All app settings are encrypted at rest. App Service stores settings in encrypted form and decrypts them only when injecting them into the container environment. This encryption applies to all settings regardless of whether they contain sensitive data.

App setting names can contain only letters, numbers, and underscores. For Linux containers, nested configuration keys that use colons in .NET applications should use double underscores instead. For example, `ConnectionStrings:DefaultConnection` becomes `ConnectionStrings__DefaultConnection`.

## Connection strings

Connection strings are a specialized form of app settings designed for database connectivity. App Service prefixes connection string environment variables with a type identifier that indicates the database type.

Configure a connection string:

```azurecli
az webapp config connection-string set \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --connection-string-type SQLAzure \
    --settings DefaultConnection="Server=myserver.database.windows.net;Database=mydb;..."
```

The connection string is available as an environment variable with a type prefix:

| Type | Environment Variable Prefix |
|------|----------------------------|
| SQL Server | `SQLCONNSTR_` |
| SQL Azure | `SQLAZURECONNSTR_` |
| MySQL | `MYSQLCONNSTR_` |
| PostgreSQL | `POSTGRESQLCONNSTR_` |
| Custom | `CUSTOMCONNSTR_` |

For the previous example, the environment variable name is `SQLAZURECONNSTR_DefaultConnection`.

For non-.NET applications, app settings are typically simpler than connection strings. The type prefix adds complexity without providing benefits for frameworks that don't expect the prefixed format. Use app settings for database connections in Python, Node.js, and similar runtimes.

## Bulk editing

When configuring many settings, bulk editing is more efficient than individual commands. You can export settings as JSON, modify them, and import the updated configuration.

Export current settings:

```azurecli
az webapp config appsettings list \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --output json > settings.json
```

The exported JSON contains an array of setting objects:

```json
[
  {
    "name": "STORAGE_ACCOUNT_NAME",
    "value": "mystorageaccount",
    "slotSetting": false
  },
  {
    "name": "LOG_LEVEL",
    "value": "INFO",
    "slotSetting": false
  }
]
```

Edit the file and import the updated settings. You can also pass JSON directly to the CLI using the `@` prefix to read from a file:

```azurecli
az webapp config appsettings set \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --settings @settings.json
```

In the Azure portal, the Environment variables option provides an Advanced edit option that displays settings in JSON format for bulk modifications.

## Slot settings

Deployment slots allow you to run different versions of your application side-by-side within the same App Service plan. Each slot has its own hostname and configuration, but it shares the underlying compute resources of the plan with the production slot. You can swap slots to promote changes from staging to production.

Some settings should stay with the slot rather than swapping with the application code. Mark these settings as slot settings:

```azurecli
az webapp config appsettings set \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --slot staging \
    --slot-settings \
        ENVIRONMENT=staging \
        API_ENDPOINT=https://api-staging.example.com
```

Settings marked as slot settings remain with the slot during swap operations. This behavior is important for:

- **Environment identifiers:** Settings like `ENVIRONMENT=production` shouldn't swap to staging
- **Environment-specific endpoints:** API URLs or database connections that differ between environments
- **Feature flags:** Settings that enable features only in specific environments
- **Diagnostic settings:** Verbose logging in staging that shouldn't affect production

View which settings are configured as slot settings:

```azurecli
az webapp config appsettings list \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --query "[?slotSetting==\`true\`].name"
```

## Key Vault references

For secrets that require centralized management, audit trails, or automatic rotation, App Service supports referencing values stored in Azure Key Vault. The application reads resolved values as standard environment variables without code changes.

A Key Vault reference uses special syntax in the app setting value:

```azurecli
az webapp config appsettings set \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --settings \
        API_KEY="@Microsoft.KeyVault(SecretUri=https://myvault.vault.azure.net/secrets/api-key)"
```

App Service resolves the reference and injects the secret value as the `API_KEY` environment variable. Your application code reads `API_KEY` without knowing the value came from Key Vault.

Key Vault references require:

1. A managed identity enabled on the web app
1. The managed identity granted access to read secrets from the Key Vault
1. The Key Vault reference syntax in the app setting value

References without a version specifier automatically resolve to the latest secret version. When a secret rotates, App Service refreshes resolved values within 24 hours. Any configuration change that triggers an app restart also forces an immediate refetch of referenced secrets.

Key Vault integration is outside the scope of this module but provides important capabilities for production secrets management. See the additional resources for detailed configuration guidance.

## Verify configuration

After configuring settings, verify that the app is resolving and applying the expected values. For App Service, the SCM (Kudu) site provides a convenient view of configuration and diagnostics.

Access the SCM site at `https://<app-name>.scm.azurewebsites.net` and navigate to **Environment** (or browse to `https://<app-name>.scm.azurewebsites.net/Env`) to view environment variables that App Service applies to the app. This view shows both your app settings and system-provided variables.

You can also verify settings programmatically by adding a diagnostic endpoint to your application that returns nonsensitive configuration values, or by checking application logs for configuration-related messages at startup.

## Additional resources

- [Configure app settings in Azure App Service](/azure/app-service/configure-common)
- [Use Key Vault references as app settings](/azure/app-service/app-service-key-vault-references)
- [Set up staging environments in Azure App Service](/azure/app-service/deploy-staging-slots)
