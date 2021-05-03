You are deploying a template that a colleague has written. They have given you a Bicep template named *main.bicep* with these parameter definitions:

```bicep
@maxLength(5)
param projectName string = 'alpha'

@secure
param apiKey string
```

They also gave you the following parameter file named *main.parameters.json*:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "projectName": {
      "value": "bravo"
    },
    "apiKey": {
      "reference": {
        "keyVault": {
          "id": "/subscriptions/c0c26c60-679b-49ca-91be-458adbaf4594/resourceGroups/PlatformResources/providers/Microsoft.KeyVault/vaults/toycompanysecrets"
        },
        "secretName": "apiKey"
      }
    }
  }
}
```

::: zone pivot="cli"

You deploy the template using this Azure CLI command:

```azurecli
az deployment group create \
  --template-file main.bicep \
  --parameters main.parameters.json \
  --parameters projectName=charlie
```

::: zone-end

::: zone pivot="powershell"

You deploy the template using this Azure PowerShell command:

```azurepowershell
New-AzResourceGroupDeployment `
  -TemplateFile main.bicep `
  -TemplateParameterFile main.parameters.json `
  -projectName charlie
```

::: zone-end
