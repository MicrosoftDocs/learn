**Template modularization** is a best practice that breaks large, complex templates into smaller, reusable components. This approach improves maintainability, promotes reusability, and makes templates easier to test and understand.

## Why modularize templates?

**Benefits of modularization:**

- **Reusability:** Create a networking template once and use it across multiple projects.
- **Maintainability:** Update one module instead of modifying multiple large templates.
- **Team collaboration:** Different teams can own different modules (networking, security, compute).
- **Testing:** Test individual modules in isolation before composing them.
- **Separation of concerns:** Each template focuses on a specific infrastructure domain.
- **Version control:** Track changes to individual components independently.

**Real-world example:** Create separate templates for:

- **Networking module:** Virtual networks, subnets, NSGs, route tables
- **Storage module:** Storage accounts, blob containers, file shares
- **Compute module:** Virtual machines, availability sets, load balancers
- **Security module:** Key Vault, managed identities, RBAC assignments

## Linked templates

**Linked templates** allow you to reference external template files from a main template. This is the primary methodology for creating modular ARM template architectures.

**How it works:**

1. Store child templates in accessible locations (Azure Storage, GitHub, etc.)
2. Main template references external templates via URI
3. Resource Manager downloads and executes linked templates during deployment

**Syntax:** Add a deployment resource to your main template:

```json
"resources": [
  {
    "apiVersion": "2022-09-01",
    "name": "linkedTemplate",
    "type": "Microsoft.Resources/deployments",
    "properties": {
      "mode": "Incremental",
      "templateLink": {
        "uri": "https://mystorageaccount.blob.core.windows.net/templates/networking.json",
        "contentVersion": "1.0.0.0"
      },
      "parameters": {
        "vnetName": {
          "value": "[parameters('virtualNetworkName')]"
        },
        "location": {
          "value": "[parameters('location')]"
        }
      }
    }
  }
]
```

**Key properties:**

- **type:** `Microsoft.Resources/deployments` indicates a nested or linked deployment.
- **mode:** Deployment mode (Incremental or Complete).
- **templateLink:** Points to the external template URI.
- **parameters:** Values passed to the linked template.

**Complete example with multiple linked templates:**

```json
"resources": [
  {
    "name": "networkingDeployment",
    "type": "Microsoft.Resources/deployments",
    "apiVersion": "2022-09-01",
    "properties": {
      "mode": "Incremental",
      "templateLink": {
        "uri": "[concat(parameters('templateBaseUrl'), '/networking.json')]"
      },
      "parameters": {
        "vnetName": { "value": "[parameters('vnetName')]" }
      }
    }
  },
  {
    "name": "storageDeployment",
    "type": "Microsoft.Resources/deployments",
    "apiVersion": "2022-09-01",
    "dependsOn": [
      "[resourceId('Microsoft.Resources/deployments', 'networkingDeployment')]"
    ],
    "properties": {
      "mode": "Incremental",
      "templateLink": {
        "uri": "[concat(parameters('templateBaseUrl'), '/storage.json')]"
      }
    }
  }
]
```

## Nested templates

**Nested templates** allow you to embed a complete template directly within the main template using the `template` property instead of `templateLink`.

**When to use nested templates:**

- **Simple scenarios:** Small, self-contained components that don't need external files.
- **Private logic:** Template logic you don't want to expose externally.
- **Dynamic generation:** Build template content programmatically during deployment.

**Drawback:** Nesting large components creates a sizeable main file, making it harder to maintain and read.

```json
"resources": [
  {
    "apiVersion": "2022-09-01",
    "name": "nestedStorageTemplate",
    "type": "Microsoft.Resources/deployments",
    "properties": {
      "mode": "Incremental",
      "template": {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "resources": [
          {
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2023-01-01",
            "name": "[variables('storageName')]",
            "location": "[parameters('location')]",
            "sku": {
              "name": "Standard_LRS"
            },
            "kind": "StorageV2",
            "properties": {
              "supportsHttpsTrafficOnly": true
            }
          }
        ]
      }
    }
  }
]
```

**Important limitations:**

> [!NOTE] > **Nested template scope:** Nested templates can only use parameters and variables from the main template. You cannot define new parameters or variables within the nested template itself.

**Linked vs. Nested templates:**

| Feature             | Linked Templates                 | Nested Templates                   |
| ------------------- | -------------------------------- | ---------------------------------- |
| **Location**        | External file (URI)              | Inline within main template        |
| **Reusability**     | High - use across projects       | Low - tied to main template        |
| **Maintainability** | Easy - separate files            | Harder - embedded in main file     |
| **Parameters**      | Can define own parameters        | Uses main template parameters only |
| **Variables**       | Can define own variables         | Uses main template variables only  |
| **Size**            | No impact on main template       | Increases main template size       |
| **Best for**        | Production modular architectures | Simple, one-off components         |

**Recommendation:** Use **linked templates** for production scenarios and **nested templates** only for simple, non-reusable components.

## Deployment modes

When deploying templates, you must choose a **deployment mode** that determines how Resource Manager handles existing resources in the target resource group.

### Three deployment options

1. **Validate mode**

**Purpose:** Test template without making changes.

**What it does:**

- Compiles the template and checks JSON syntax.
- Validates deployment logic (no circular dependencies).
- Ensures all resource types and API versions are valid.
- **Does not deploy** any resources.

**When to use:** Before production deployments to catch errors early.

**Command example:**

```bash
az deployment group validate \
  --resource-group myResourceGroup \
  --template-file main.json \
  --parameters @parameters.json
```

2. **Incremental mode (default)**

**Purpose:** Add or update resources without affecting existing ones.

**What it does:**

- **Deploys resources** defined in the template.
- **Leaves unchanged** resources not defined in the template.
- **Updates** resources if configurations change.

**Example scenario:**

- Template defines VM1, VM2, Storage1
- Resource group has VM1, VM3, Storage1
- **After deployment:** VM1 (updated), VM2 (added), VM3 (unchanged), Storage1 (updated)

**When to use:**

- Adding new resources to existing environments.
- Updating specific resources without risk to others.
- Development and testing environments.

3. **Complete mode**

**Purpose:** Ensure resource group matches template exactly (idempotency).

**What it does:**

- **Deploys resources** defined in the template.
- **Deletes resources** not defined in the template.
- Resource group contains ONLY what's in the template.

**Example scenario:**

- Template defines VM1, VM2, Storage1
- Resource group has VM1, VM3, Storage1, VM4
- **After deployment:** VM1 (updated), VM2 (added), Storage1 (updated), VM3 (deleted), VM4 (deleted)

**When to use:**

- Production environments requiring strict state control.
- Achieving idempotency (same deployment result every time).
- Removing unwanted or manual resources.

**⚠️ Warning:** Complete mode can delete resources. Test thoroughly before using in production!

### Setting deployment mode

**Azure CLI:**

```bash
# Incremental (default)
az deployment group create \
  --resource-group myResourceGroup \
  --template-file main.json \
  --mode Incremental

# Complete
az deployment group create \
  --resource-group myResourceGroup \
  --template-file main.json \
  --mode Complete
```

**PowerShell:**

```powershell
# Incremental
New-AzResourceGroupDeployment `
  -ResourceGroupName myResourceGroup `
  -TemplateFile main.json `
  -Mode Incremental

# Complete
New-AzResourceGroupDeployment `
  -ResourceGroupName myResourceGroup `
  -TemplateFile main.json `
  -Mode Complete
```

### Best practices

> [!NOTE] > **One resource group per deployment:** Use dedicated resource groups for each logical application or environment to simplify management and avoid accidental deletions.

> [!NOTE] > **Linked/nested templates limitation:** You can only use **incremental mode** for both linked and nested templates. Complete mode is not supported for child deployments.

**Recommendations:**

- **Development:** Use Incremental mode for flexibility and faster iteration.
- **Production:** Use Complete mode with CI/CD pipelines to ensure consistent state.
- **Before Complete mode:** Always validate first and test in non-production environments.
- **Resource locks:** Apply locks to critical resources to prevent accidental deletion.

## External templates and parameters

**External templates** provide the foundation for truly modular ARM template architectures. You store child templates in accessible locations and reference them via URI.

### Template accessibility requirements

**Resource Manager must be able to access linked templates** during deployment:

**What works:**

- ✅ **Azure Blob Storage:** Public or private with SAS tokens
- ✅ **GitHub:** Public repositories or private with access tokens
- ✅ **HTTPS endpoints:** Any publicly accessible HTTPS URL
- ✅ **Azure Container Instances:** Hosting template files in containers

**What doesn't work:**

- ❌ **Local files:** Files on your computer or local network
- ❌ **File:// protocol:** Local file system paths
- ❌ **HTTP (non-secure):** Only HTTPS is supported

### Using templateLink and parametersLink

**templateLink:** References an external template file.

**parametersLink:** References an external parameter file (alternative to inline parameters).

**Important:** You cannot use both inline parameters and parametersLink simultaneously. Choose one approach.

**Complete example with templateLink:**

```json
"resources": [
  {
    "name": "linkedStorageDeployment",
    "type": "Microsoft.Resources/deployments",
    "apiVersion": "2022-09-01",
    "properties": {
      "mode": "Incremental",
      "templateLink": {
        "uri": "https://mystorageaccount.blob.core.windows.net/templates/storage.json?sv=2021-06-08&sr=b&sig=ABC123...&se=2025-12-31T23:59:59Z&sp=r",
        "contentVersion": "1.0.0.0"
      },
      "parameters": {
        "storageAccountName": {
          "value": "[variables('storageAccountName')]"
        },
        "location": {
          "value": "[parameters('location')]"
        },
        "sku": {
          "value": "Standard_GRS"
        }
      }
    }
  }
]
```

**Key components:**

- **uri:** Full HTTPS URL to the linked template (includes SAS token if using private storage).
- **contentVersion:** Version of the linked template (must match what's in the linked template file).
- **parameters:** Values passed to the linked template (can reference main template parameters/variables).

### Using external parameter files

**Alternative to inline parameters:**

```json
{
  "name": "linkedDeployment",
  "type": "Microsoft.Resources/deployments",
  "apiVersion": "2022-09-01",
  "properties": {
    "mode": "Incremental",
    "templateLink": {
      "uri": "https://mystorageaccount.blob.core.windows.net/templates/main.json"
    },
    "parametersLink": {
      "uri": "https://mystorageaccount.blob.core.windows.net/parameters/prod.json"
    }
  }
}
```

**Benefits:**

- Separate parameter files per environment (dev.json, staging.json, prod.json).
- Sensitive parameters stored securely in parameter files.
- Easier to manage multi-environment deployments.

## Securing external templates

**External templates don't need to be public.** You can store them in private storage accounts and use **Shared Access Signature (SAS) tokens** for secure access.

### Steps to secure templates

1. **Store templates in private Azure Blob Storage:**

```bash
# Create storage account and container
az storage account create \
  --name mytemplatestorage \
  --resource-group myResourceGroup \
  --location eastus \
  --sku Standard_LRS

az storage container create \
  --name templates \
  --account-name mytemplatestorage \
  --public-access off
```

2. **Upload template files:**

```bash
az storage blob upload \
  --account-name mytemplatestorage \
  --container-name templates \
  --name networking.json \
  --file ./templates/networking.json
```

3. **Generate SAS token with expiration:**

```bash
# Create SAS token valid for 30 days
az storage blob generate-sas \
  --account-name mytemplatestorage \
  --container-name templates \
  --name networking.json \
  --permissions r \
  --expiry 2025-12-31T23:59:59Z \
  --https-only \
  --output tsv
```

4. **Use SAS token in templateLink URI:**

```json
"templateLink": {
  "uri": "https://mytemplatestorage.blob.core.windows.net/templates/networking.json?sv=2021-06-08&sr=b&sig=ABC123...&se=2025-12-31T23:59:59Z&sp=r"
}
```

### Security considerations

**SAS token logging:**

- Even though the token is passed securely, the URI (including SAS token) is **logged in deployment operations**.
- Deployment logs are visible to anyone with read access to the resource group.

**Best practices for security:**

- **Set expiration dates:** Create time-limited SAS tokens (30-90 days).
- **Use read-only permissions:** SAS tokens should only grant read (`r`) permission.
- **Rotate tokens regularly:** Generate new tokens and update templates periodically.
- **Use Azure Key Vault:** Store SAS tokens in Key Vault and reference them in templates.
- **Managed identities:** Consider using managed identities for template access instead of SAS tokens.
- **Private endpoints:** Use Azure Storage private endpoints for additional network security.

**Example with Key Vault reference:**

```json
"templateLink": {
  "uri": "[concat('https://mytemplatestorage.blob.core.windows.net/templates/networking.json', reference(resourceId('Microsoft.KeyVault/vaults/secrets', parameters('keyVaultName'), 'storageAccountSasToken')).secretValue)]"
}
```

This approach keeps SAS tokens out of your template code and deployment logs.
