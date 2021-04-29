In this exercise, you'll create a parameter file that provide inputs to the Bicep template that you previously created. In the same parameter file, you'll also referencing Azure Key Vault to provide sensitive information.

During the process, you'll:

> [!div class="checklist"]

> * Add secure parameters
> * Create a parameter file.
> * Test the deployment to ensure that the parameter file is valid.
> * Create Azure Key Vault and secrets.
> * Update the parameter file with Azure Key Vault references.
> * Re-test the deployment to ensure that the parameter file is still valid.

This exercise uses [Bicep for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Add secure parameters and database parameters

1. In the *main.bicep* file in Visual Studio Code, find a `location` parameter. Add `sqlDatabaseName`, `sqlServerAdministratorLogin`, and `sqlServerAdministratorPassword` parameters below the `location` parameter. Also add a `sqlServerName` variable for the Azure SQL server name. When finished, the parameter section should look like this:

    :::code language="json" source="code/6-add-secure-parameters.bicep" highlight="22-35":::

    Notice that you're specifying value for each parameter except `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameters.

### Add Azure SQL server and database

1. In the *main.bicep* file in Visual Studio Code, append the following code to the bottom of the file.

    ```bicep

    resource sqlServer 'Microsoft.Sql/servers@2020-11-01-preview' = {
      name: sqlServerName
      location: location
      properties: {
        administratorLogin: sqlServerAdministratorLogin
        administratorLoginPassword: sqlServerAdministratorPassword
      }
    }
    
    resource sqlDatabase 'Microsoft.Sql/servers/databases@2020-11-01-preview' = {
      parent: sqlServer
      name: sqlDatabaseName
      location: location
      sku: {
        name: 'Standard'
        tier: 'Standard'
      }
    }
    ```

1. Save the changes to the file.

## Create a parameter file

1. Open Visual Studio Code, and open folder where _main.bicep_ is located. In the same folder, create a new file called _parameters.dev.json_.

1. In *main.parameters.dev.json* file, add the following code:

    ```json
    {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
          "environmentName": {
              "value": "dev"
          },
          "appServicePlanInstanceCount": {
              "value": 2
          },
          "sqlDatabaseName": {
              "value": "employeeDB"
          },
          "location": {
              "value": "WestUS"
          }
      }
    }
    ```

1. Save the changes to the file.

## Deploy the Bicep template with parameter file

::: zone pivot="cli"

Run the following Azure CLI command in the terminal. You are providing a parameter file along with a Bicep file this time.

```azurecli
az deployment group create \
    --template-file main.bicep \
    --parameters main.parameters.dev.json
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal. You are providing a parameter file along with a Bicep file this time.

```azurepowershell
New-AzResourceGroupDeployment `
    -TemplateFile main.bicep `
    -TemplateParameterFile main.parameters.dev.json
```

::: zone-end

Notice that you're prompted to enter the values for `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameters when you execute the deployment. You don't need to specify `solutionName` since its default value are specified. You also don't need to specify the other parameter values because their values are specified in the parameter file.

### Check your deployment

1. In your browser, go back to the Azure portal. Go to your resource group. You'll still see one successful deployment, because the deployment used the same name as the first deployment.

1. Select the **1 Succeeded** link.

1. Select the deployment called **main**, and then select **Deployment details** to expand the list of deployed resources.

    :::image type="content" source="../media/6-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with App Service and Azure SQL Database resources listed with generated names." border="true":::

1. Notice that the resources have been deployed.

## Deploy Azure Key Vault and secrets

::: zone pivot="cli"

The following Azure CLI samples show how to create the key vault, and add a secret. Replace $keyVaultName

```azurecli
az keyvault create \
    --name $keyVaultName \
    --enabled-for-template-deployment true

az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorLogin" --value "sqlAdmin"

az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorPassword" --value "$ql@dm!nP@$$w0rd"
```

::: zone-end

::: zone pivot="powershell"

The following Azure PowerShell samples show how to create the key vault, and add a secret.

```azurepowershell
New-AzKeyVault `
    -VaultName $keyVaultName `
    -EnabledForTemplateDeployment

$sqlServerAdministratorLogin = ConvertTo-SecureString 'sqlAdmin' -AsPlainText -Force
$sqlServerAdministratorPassword = ConvertTo-SecureString '$ql@dm!nP@$$w0rd' -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyVaultName -Name 'sqlServerAdministratorLogin' -SecretValue $sqlServerAdministratorLogin

Set-AzKeyVaultSecret -VaultName $keyVaultName -Name 'sqlServerAdministratorPassword' -SecretValue $sqlServerAdministratorPassword
    ```

::: zone-end

Once you successfully creating the key vault, you should get JSON output similar to below. Copy the value of `id` (highlighted) from the JSON output. This is your key vault id, and you'll need it later.

:::code language="json" source="code/6-new-keyvault.json" highlight="2":::

Notice that you are setting the --enabled-for-template-deployment setting on the vault. This allows Azure to use the secrets from your vault during deployments. If you don't set this then, by default, your deployments can't access secrets in your vault. You also must have the `Microsoft.KeyVault/vaults/deploy/action` permission for the scope of the resource group and key vault. The [Owner](/azure/role-based-access-control/built-in-roles#owner) and [Contributor](/azure/role-based-access-control/built-in-roles#contributor) roles both grant this access. Since you created the key vault, you're the owner so you won't have to explicitly grant the permission in this exercise.

## Add key vault reference to parameter file

1. In *main.parameters.dev.json* file, append the following code after `location` parameter. Make sure that you replace `<keyVaultId>` with the value of the key vault id you copied earlier.

```json
"sqlServerAdministratorLogin": {
    "reference": {
        "keyVault": {
            "id": "<keyVaultId>"
            },
        "secretName": "sqlServerAdministratorLogin"
    }
},
"sqlServerAdministratorPassword": {
    "reference": {
        "keyVault": {
            "id": "<keyVaultId>"
            },
        "secretName": "sqlServerAdministratorPassword"
    }
}
```

1. Save the changes to the file.

## Deploy the Bicep template with parameter file and Azure key vault references

::: zone pivot="cli"

Run the following Azure CLI command in the terminal. You are providing a parameter file along with a Bicep file this time.

```azurecli
az deployment group create \
    --template-file main.bicep \
    --parameters main.parameters.dev.json
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal. You are providing a parameter file along with a Bicep file this time.

```azurepowershell
New-AzResourceGroupDeployment `
    -TemplateFile main.bicep `
    -TemplateParameterFile main.parameters.dev.json
    ```

::: zone-end

Notice that you're not prompted to enter the values for `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameters when you execute the deployment this time.

### Check your deployment

1. In your browser, go back to the Azure portal. Go to your resource group. You'll still see one successful deployment, because the deployment used the same name as the first deployment.

1. Select the **1 Succeeded** link.

1. Select the deployment called **main**, and then select **Deployment details** to expand the list of deployed resources.

    :::image type="content" source="../media/6-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with App Service and Azure SQL Database resources listed with generated names." border="true":::

1. Notice that the resources have been deployed.
