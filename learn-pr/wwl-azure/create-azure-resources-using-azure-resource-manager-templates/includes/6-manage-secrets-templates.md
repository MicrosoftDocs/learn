**Managing secrets securely** is critical for production infrastructure deployments. Passwords, API keys, connection strings, and certificates should never be hardcoded in templates or stored in version control.

**Azure Key Vault integration** with ARM templates provides a secure solution by storing secrets centrally and referencing them during deployment without exposing sensitive values.

## Why use Key Vault with ARM templates?

**Security benefits:**

- **No secrets in code:** Sensitive values never appear in template files or version control.
- **Audit trail:** Key Vault logs all secret access for compliance and security monitoring.
- **Access control:** Use Azure RBAC to control who can read secrets.
- **Centralized management:** Update secrets in one location, affecting all deployments.
- **Encryption at rest:** Secrets are encrypted in Key Vault with HSM-backed keys.
- **Rotation support:** Update secrets without modifying templates.

**How it works:**

1. Store secrets in Azure Key Vault.
2. Reference the Key Vault and secret name in your parameter file.
3. During deployment, Resource Manager retrieves the secret value.
4. The actual value is **never exposed** in logs or deployment history.

**Cross-subscription support:** The Key Vault can exist in a different subscription than the resource group you're deploying to, providing flexibility for centralized secret management.

## Deploy a Key Vault and secret

To use Key Vault with ARM templates, you must first create the Key Vault and store secrets in it.

**Critical requirement:** The Key Vault property **enabledForTemplateDeployment** must be **true** to allow Resource Manager to retrieve secrets during deployment.

### Using Azure CLI

Create a Key Vault and secret with Azure CLI:

```bash
# Define variables (replace with your values)
keyVaultName='myTemplateVault'
resourceGroupName='myResourceGroup'
location='eastus'
userPrincipalName='user@example.com'

# Create a resource group
az group create \
  --name $resourceGroupName \
  --location $location

# Create a Key Vault with template deployment enabled
az keyvault create \
  --name $keyVaultName \
  --resource-group $resourceGroupName \
  --location $location \
  --enabled-for-template-deployment true

# Set access policy for your user
az keyvault set-policy \
  --upn $userPrincipalName \
  --name $keyVaultName \
  --secret-permissions set delete get list

# Generate a secure password and store as secret
password=$(openssl rand -base64 32)
echo "Generated password: $password"

az keyvault secret set \
  --vault-name $keyVaultName \
  --name 'vmAdminPassword' \
  --value $password
```

**Key commands explained:**

- **--enabled-for-template-deployment true:** Allows ARM templates to retrieve secrets during deployment.
- **az keyvault set-policy:** Grants permissions to specific users or service principals.
- **openssl rand -base64 32:** Generates a cryptographically secure random password.
- **az keyvault secret set:** Stores the secret in Key Vault.

### Using PowerShell

**Alternative with PowerShell:**

```powershell
# Define variables
$keyVaultName = "myTemplateVault"
$resourceGroupName = "myResourceGroup"
$location = "eastus"

# Create resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create Key Vault
New-AzKeyVault `
  -VaultName $keyVaultName `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -EnabledForTemplateDeployment

# Generate and store secret
$password = [System.Web.Security.Membership]::GeneratePassword(32, 10)
$secretValue = ConvertTo-SecureString $password -AsPlainText -Force

Set-AzKeyVaultSecret `
  -VaultName $keyVaultName `
  -Name "vmAdminPassword" `
  -SecretValue $secretValue
```

## Enable access to secrets

**Permission requirements:** Beyond setting **enabledForTemplateDeployment** to **true**, users deploying templates must have the `Microsoft.KeyVault/vaults/deploy/action` permission.

### Required permissions

**Scope:** Permissions must cover:

- The Key Vault resource
- The resource group containing the Key Vault
- The subscription containing the Key Vault

**Built-in roles with access:**

- **Owner:** Full access to all resources and permissions.
- **Contributor:** Can deploy resources but cannot manage permissions.
- **Key Vault Secrets User:** Can read secret contents (using RBAC).
- **Custom roles:** Define specific permissions for template deployment scenarios.

### Permission scenarios

**Scenario 1: You created the Key Vault**

- You're automatically the owner.
- You inherently have permission to deploy templates using secrets.

**Scenario 2: Key Vault in different subscription**

- The Key Vault owner must explicitly grant you access.
- Use `az keyvault set-policy` or assign RBAC role.

**Grant access example:**

```bash
# Grant access to a service principal (for CI/CD pipelines)
az keyvault set-policy \
  --name $keyVaultName \
  --spn <service-principal-id> \
  --secret-permissions get list

# Grant access using RBAC (recommended)
az role assignment create \
  --role "Key Vault Secrets User" \
  --assignee <user-or-service-principal-id> \
  --scope /subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.KeyVault/vaults/<key-vault-name>
```

**Best practice:** Use **Azure RBAC** (Role-Based Access Control) for Key Vault access instead of vault access policies. RBAC provides more granular control and easier auditing.

## Reference a secret with static ID

The most common approach is to **reference Key Vault secrets in the parameter file**, not in the template itself. This separation keeps templates clean and reusable across environments.

### How it works

**Deployment flow:**

1. **Template defines parameters** (with `securestring` type) but doesn't specify values.
2. **Parameter file references Key Vault** and specific secret names.
3. **During deployment,** Resource Manager retrieves secret values from Key Vault.
4. **Secret values are passed** to the template as parameters.
5. **Values are never logged** or exposed in deployment history.

```
Parameter File → Key Vault Reference → Resource Manager → Template
```

**Visual flow:**

```
parameters.json
    ↓ (references Key Vault)
Azure Key Vault
    ↓ (Resource Manager retrieves secret)
Template Deployment
    ↓ (secret value used securely)
Azure SQL Database (with admin password)
```

### Example: SQL Database with Key Vault password

**Template file (sqlserver.json):**

The template defines a `securestring` parameter but doesn't specify where the value comes from:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "adminLogin": {
      "type": "string",
      "metadata": {
        "description": "Administrator login name for SQL Server"
      }
    },
    "adminPassword": {
      "type": "securestring",
      "metadata": {
        "description": "Administrator password for SQL Server"
      }
    },
    "sqlServerName": {
      "type": "string",
      "metadata": {
        "description": "Name of the SQL Server"
      }
    },
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]",
      "metadata": {
        "description": "Location for SQL Server"
      }
    }
  },
  "resources": [
    {
      "type": "Microsoft.Sql/servers",
      "apiVersion": "2021-11-01",
      "name": "[parameters('sqlServerName')]",
      "location": "[parameters('location')]",
      "tags": {
        "Environment": "Production",
        "ManagedBy": "ARM Template"
      },
      "properties": {
        "administratorLogin": "[parameters('adminLogin')]",
        "administratorLoginPassword": "[parameters('adminPassword')]",
        "version": "12.0",
        "publicNetworkAccess": "Enabled"
      }
    }
  ],
  "outputs": {
    "sqlServerFqdn": {
      "type": "string",
      "value": "[reference(resourceId('Microsoft.Sql/servers', parameters('sqlServerName'))).fullyQualifiedDomainName]"
    }
  }
}
```

**Important points:**

- **adminPassword** is `securestring` type (not logged or displayed).
- Template doesn't specify where the password comes from.
- Template is reusable across environments with different Key Vaults.

### Parameter file with Key Vault reference

**Parameter file (sqlserver.parameters.json):**

Now create a parameter file that references the Key Vault secret. The parameter file provides the value for `adminLogin` but retrieves `adminPassword` from Key Vault:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "adminLogin": {
      "value": "sqladmin"
    },
    "adminPassword": {
      "reference": {
        "keyVault": {
          "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myKeyVaultRG/providers/Microsoft.KeyVault/vaults/myTemplateVault"
        },
        "secretName": "sqlAdminPassword"
      }
    },
    "sqlServerName": {
      "value": "myprodsqlserver2025"
    }
  }
}
```

**Parameter structure explained:**

- **adminLogin:** Regular value provided directly.
- **adminPassword:** Uses `reference` object instead of `value`.
- **keyVault.id:** Full resource ID of the Key Vault (static ID approach).
- **secretName:** Name of the secret in Key Vault.
- **sqlServerName:** Server name provided directly.

**How to get your Key Vault resource ID:**

```bash
# Azure CLI
az keyvault show \
  --name myTemplateVault \
  --resource-group myKeyVaultRG \
  --query id \
  --output tsv

# PowerShell
(Get-AzKeyVault -VaultName myTemplateVault -ResourceGroupName myKeyVaultRG).ResourceId
```

### Deploy the template with parameter file

**Azure CLI deployment:**

```bash
az deployment group create \
  --resource-group myResourceGroup \
  --template-file sqlserver.json \
  --parameters sqlserver.parameters.json
```

**PowerShell deployment:**

```powershell
New-AzResourceGroupDeployment `
  -ResourceGroupName myResourceGroup `
  -TemplateFile sqlserver.json `
  -TemplateParameterFile sqlserver.parameters.json
```

**What happens during deployment:**

1. Resource Manager reads the parameter file.
2. Detects the Key Vault reference for `adminPassword`.
3. Authenticates and retrieves the secret value from Key Vault.
4. Passes the secret value securely to the template.
5. Creates the SQL Server with the secure password.
6. **The password never appears in logs or deployment history.**

### Benefits of this approach

- **Security:** Secrets never stored in version control or template files.
- **Flexibility:** Use different Key Vaults per environment (dev, staging, prod).
- **Auditability:** Key Vault logs who accessed which secrets and when.
- **Centralized management:** Update secrets in Key Vault without changing templates.
- **Compliance:** Meets security requirements for password management.

### Dynamic ID reference (alternative approach)

Instead of hardcoding the Key Vault resource ID, you can build it dynamically using template functions:

```json
"adminPassword": {
  "reference": {
    "keyVault": {
      "id": "[resourceId(subscription().subscriptionId, parameters('keyVaultResourceGroup'), 'Microsoft.KeyVault/vaults', parameters('keyVaultName'))]"
    },
    "secretName": "sqlAdminPassword"
  }
}
```

This approach requires additional parameters for `keyVaultResourceGroup` and `keyVaultName`, but provides more flexibility for multi-environment deployments.

**For more information:** See [Azure Key Vault to pass secure parameter values during deployment](https://learn.microsoft.com/azure/azure-resource-manager/templates/key-vault-parameter) for advanced scenarios including dynamic IDs and cross-subscription references.
