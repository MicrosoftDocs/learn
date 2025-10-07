**Azure Resource Manager templates** are written in **JSON (JavaScript Object Notation)**, which allows you to express infrastructure as text-based, human-readable code. This makes templates easy to version control, review, and share across teams.

## Understanding JSON structure

A **JSON document** is a collection of key-value pairs. Each key is a string, and values can be:

- **A string:** `"name": "myStorageAccount"`
- **A number:** `"count": 3`
- **A Boolean:** `"enabled": true`
- **An array:** `"locations": ["eastus", "westus"]`
- **An object:** `"sku": { "name": "Standard_LRS", "tier": "Standard" }`

**Why JSON for infrastructure?** JSON provides a structured, machine-readable format that Azure Resource Manager can parse and execute. It's language-agnostic and widely supported by development tools.

## ARM template structure

A **Resource Manager template** contains specific sections using JSON notation. These sections define your infrastructure declaratively:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "variables": {},
  "functions": [],
  "resources": [],
  "outputs": {}
}
```

**Template sections explained:**

| Section            | Purpose                                                                                  | Required |
| ------------------ | ---------------------------------------------------------------------------------------- | -------- |
| **$schema**        | Specifies the template schema version and validates the template structure.              | Yes      |
| **contentVersion** | Your own version number for tracking template changes.                                   | Yes      |
| **parameters**     | Values that can be customized during deployment (environment names, sizes, credentials). | No       |
| **variables**      | Values calculated or reused within the template to reduce duplication.                   | No       |
| **functions**      | Custom user-defined functions for complex logic or calculations.                         | No       |
| **resources**      | The actual Azure resources to deploy (VMs, storage accounts, networks).                  | Yes      |
| **outputs**        | Values returned after deployment (IP addresses, FQDNs, connection strings).              | No       |

Let's explore each section in detail with practical examples.

## Parameters section

The **parameters section** defines which values are configurable when the template runs. This enables template reusability across different environments, customers, or scenarios.

**Common use cases:**

- Environment-specific settings (VM sizes, SKUs)
- Credentials (usernames, passwords)
- Naming conventions (prefixes, suffixes)
- Regional settings (locations, availability zones)

**Example:** Virtual machine credentials:

```json
"parameters": {
  "adminUsername": {
    "type": "string",
    "metadata": {
      "description": "Username for the Virtual Machine."
    }
  },
  "adminPassword": {
    "type": "securestring",
    "metadata": {
      "description": "Password for the Virtual Machine."
    }
  },
  "vmSize": {
    "type": "string",
    "defaultValue": "Standard_B2s",
    "allowedValues": [
      "Standard_B2s",
      "Standard_D2s_v3",
      "Standard_D4s_v3"
    ],
    "metadata": {
      "description": "Size of the virtual machine."
    }
  }
}
```

**Parameter types available:**

- **string:** Text values like names and descriptions.
- **securestring:** Sensitive text values like passwords (masked in logs).
- **int:** Integer numbers like counts or port numbers.
- **bool:** True or false values for feature flags.
- **object:** Complex structured data.
- **array:** Lists of values.
- **secureObject:** Sensitive structured data (masked in logs).

**Best practices:**

- Use **metadata descriptions** to document each parameter's purpose.
- Provide **defaultValue** for optional parameters.
- Use **allowedValues** to restrict choices and prevent errors.
- Use **securestring** for passwords and API keys to prevent logging.

## Variables section

The **variables section** defines values that are used throughout the template. Variables help make templates easier to maintain by avoiding duplication.

**When to use variables:**

- **Reduce repetition:** Define a value once and reference it multiple times.
- **Complex expressions:** Calculate values based on parameters or other variables.
- **Naming conventions:** Build consistent resource names with prefixes/suffixes.
- **Environment configuration:** Set different values based on parameters.

**Example:** Networking configuration for a VM:

```json
"variables": {
  "nicName": "myVMNic",
  "addressPrefix": "10.0.0.0/16",
  "subnetName": "Subnet",
  "subnetPrefix": "10.0.0.0/24",
  "publicIPAddressName": "myPublicIP",
  "virtualNetworkName": "MyVNET",
  "storageAccountName": "[concat('storage', uniqueString(resourceGroup().id))]",
  "vmName": "[concat(parameters('vmNamePrefix'), '-vm')]"
}
```

**Variable advantages:**

- **Single source of truth:** Change the NIC name in one place, and all references update automatically.
- **Cleaner resources section:** Keep complex expressions in variables for better readability.
- **Template functions:** Use ARM template functions like `concat()`, `uniqueString()`, and `resourceGroup()` to build dynamic values.

**Example use case:** If you need to change the subnet name from "Subnet" to "AppSubnet", you only update the variable definition, not every place it's referenced.

## Functions section

The **functions section** defines custom user-defined functions for procedures you don't want to repeat. Functions provide a way to encapsulate complex logic and make templates more maintainable.

**When to use functions:**

- **Complex naming logic:** Create consistent naming patterns across resources.
- **Reusable calculations:** Perform the same calculation multiple times with different inputs.
- **Business rules:** Implement organization-specific naming or tagging conventions.

**Example:** Creating unique names for globally unique resources:

```json
"functions": [
  {
    "namespace": "contoso",
    "members": {
      "uniqueName": {
        "parameters": [
          {
            "name": "namePrefix",
            "type": "string"
          }
        ],
        "output": {
          "type": "string",
          "value": "[concat(toLower(parameters('namePrefix')), uniqueString(resourceGroup().id))]"
        }
      }
    }
  }
]
```

**How to use this function:**

```json
"resources": [
  {
    "type": "Microsoft.Storage/storageAccounts",
    "name": "[contoso.uniqueName('mystorage')]",
    ...
  }
]
```

**Function benefits:**

- **Namespace isolation:** Group functions under a namespace (like `contoso`) to avoid conflicts.
- **Reusability:** Call the same function multiple times with different parameters.
- **Consistency:** Ensure all resources follow the same naming convention.

**Note:** For most cases, **built-in ARM template functions** (like `concat()`, `uniqueString()`, `reference()`) are sufficient. Custom functions are helpful for organization-specific logic.

## Resources section

The **resources section** is the core of your template where you define the **actual Azure resources** to deploy. This is the only required section (besides schema and contentVersion).

**Resource definition includes:**

- **type:** The Azure resource type (e.g., `Microsoft.Storage/storageAccounts`, `Microsoft.Compute/virtualMachines`).
- **apiVersion:** The API version determines available properties and features.
- **name:** The resource name (must follow Azure naming rules).
- **location:** The Azure region where the resource is deployed.
- **properties:** Resource-specific configuration settings.

**Example:** Public IP address resource:

```json
{
  "type": "Microsoft.Network/publicIPAddresses",
  "apiVersion": "2023-04-01",
  "name": "[variables('publicIPAddressName')]",
  "location": "[parameters('location')]",
  "properties": {
    "publicIPAllocationMethod": "Dynamic",
    "dnsSettings": {
      "domainNameLabel": "[parameters('dnsLabelPrefix')]"
    }
  },
  "tags": {
    "Environment": "[parameters('environment')]",
    "ManagedBy": "ARM Template"
  }
}
```

**Understanding resource properties:**

- **type:** `Microsoft.Network/publicIPAddresses` specifies a public IP address resource.
- **apiVersion:** `2023-04-01` determines which properties and features are available. Use recent API versions to access latest capabilities.
- **name:** References the `publicIPAddressName` variable using `[variables('publicIPAddressName')]`.
- **location:** Uses a parameter to make the region configurable.
- **properties:** Resource-specific settings like allocation method and DNS configuration.
- **tags:** Metadata for organization, cost tracking, and automation.

**Why API versions matter:** As Azure evolves, resource types gain new features. By updating `apiVersion`, you can access new properties without rewriting your template structure.

**Multiple resources example:**

```json
"resources": [
  {
    "type": "Microsoft.Network/virtualNetworks",
    "apiVersion": "2023-04-01",
    "name": "[variables('virtualNetworkName')]",
    ...
  },
  {
    "type": "Microsoft.Network/publicIPAddresses",
    "apiVersion": "2023-04-01",
    "name": "[variables('publicIPAddressName')]",
    ...
  },
  {
    "type": "Microsoft.Compute/virtualMachines",
    "apiVersion": "2023-03-01",
    "name": "[variables('vmName')]",
    ...
  }
]
```

## Outputs section

The **outputs section** defines information to return after deployment completes. Outputs are useful for values that aren't known until resources are created.

**Common output use cases:**

- **IP addresses:** Retrieve dynamically assigned public IP addresses.
- **Connection strings:** Get database or storage account connection strings.
- **FQDNs:** Obtain fully qualified domain names for applications.
- **Resource IDs:** Pass resource identifiers to other templates or scripts.
- **Keys and secrets:** Retrieve access keys for storage or service bus.

**Example:** Public IP address hostname output:

```json
"outputs": {
  "hostname": {
    "type": "string",
    "value": "[reference(variables('publicIPAddressName')).dnsSettings.fqdn]"
  },
  "publicIPAddress": {
    "type": "string",
    "value": "[reference(variables('publicIPAddressName')).ipAddress]"
  },
  "resourceId": {
    "type": "string",
    "value": "[resourceId('Microsoft.Network/publicIPAddresses', variables('publicIPAddressName'))]"
  }
}
```

**Using the reference() function:** The `reference()` function retrieves the runtime state of a resource. It's commonly used in outputs to access properties that are assigned during deployment (like IP addresses).

**Accessing outputs after deployment:**

```bash
# Azure CLI
az deployment group show \
  --resource-group myResourceGroup \
  --name myDeployment \
  --query properties.outputs

# PowerShell
(Get-AzResourceGroupDeployment -ResourceGroupName myResourceGroup -Name myDeployment).Outputs
```

**Output types available:**

- **string:** Text values like FQDNs or connection strings.
- **int:** Numbers like port numbers or counts.
- **bool:** True or false values.
- **array:** Lists of values.
- **object:** Complex structured data.

**Best practice:** Use outputs to pass information between linked templates or to external automation scripts. This makes your infrastructure more composable and automation-friendly.
