You're deploying a template that a colleague has written. They give you a Bicep template named _main.bicep_ with these parameter definitions:

```bicep
@maxLength(5)
param projectName string = 'dog'

@secure()
param apiKey string
```

They also give you the following parameter file named _main.parameters.production.json_:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "projectName": {
      "value": "cat"
    },
    "apiKey": {
      "reference": {
        "keyVault": {
          "id": "/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/PlatformResources/providers/Microsoft.KeyVault/vaults/toysecrets"
        },
        "secretName": "KeyToAccessPartnerApi"
      }
    }
  }
}
```

::: zone pivot="cli"

You deploy the template by using this Azure CLI command:

```azurecli
az deployment group create \
  --template-file main.bicep \
  --parameters main.parameters.production.json \
               projectName=bird
```

::: zone-end

::: zone pivot="powershell"

You deploy the template by using this Azure PowerShell command:

```azurepowershell
New-AzResourceGroupDeployment `
  -TemplateFile main.bicep `
  -TemplateParameterFile main.parameters.production.json `
  -projectName bird
```

::: zone-end
