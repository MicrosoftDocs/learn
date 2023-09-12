
When passing a secure value (such as a password) as a parameter during deployment, you can retrieve the value from an Azure Key Vault.

Reference the Key Vault and secret in your parameter file.

The value is never exposed because you only reference its Key Vault ID.

The Key Vault can exist in a different subscription than the resource group you're deploying it to.

## Deploy a Key Vault and secret

To create a Key Vault and secret, use either Azure CLI or PowerShell.

To access the secrets inside this Key Vault from a Resource Manager deployment, the Key Vault property **enabledForTemplateDeployment** must be **true**.

## Using Azure CLI

The following code snippet is an example of how you can deploy a Key Vault and secret using Azure CLI:

```PowerShell
keyVaultName='{your-unique-vault-name}'
resourceGroupName='{your-resource-group-name}'
location='centralus'
userPrincipalName='{your-email-address-associated-with-your-subscription}'

# Create a resource group
az group create --name $resourceGroupName --location $location

# Create a Key Vault
az keyvault create \
  --name $keyVaultName \
  --resource-group $resourceGroupName \
  --location $location \
  --enabled-for-template-deployment true
az keyvault set-policy --upn $userPrincipalName --name $keyVaultName --secret-permissions set delete get list

# Create a secret with the name, vmAdminPassword
password=$(openssl rand -base64 32)
echo $password
az keyvault secret set --vault-name $keyVaultName --name 'vmAdminPassword' --value $password

```

## Enable access to the secret

Other than setting the Key Vault property **enabledForTemplateDeployment** to **true**, the user deploying the template must have `Microsoft.KeyVault/vaults/deploy/action` permission for the Key Vault scope.

Also including the resource group and Key Vault. The Owner and Contributor roles both grant this access.

If you create the Key Vault, you're the owner, so you inherently have permission.

However, if the Key Vault is under a different subscription, the owner of the Key Vault must grant access.

## Reference a secret with static ID

The Key Vault is referenced in the parameter file and not the template.

The following image shows how the parameter file references the secret and passes that value to the template.

:::image type="content" source="../media/flow-secret-template-deployment-d278f75c.png" alt-text="Diagram showing the illustration of the flow of a secret during template deployment. The parameter file references the secret from the template and passes that value to the template.":::


The following template deploys an SQL database that includes an administrator password.

The password parameter is set to a secure string. However, the template doesn't specify where that value comes from:

```JSON
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "adminLogin": {
      "type": "string"
    },
    "adminPassword": {
      "type": "securestring"
    },
    "sqlServerName": {
      "type": "string"
    }
  },
  "resources": [
    {
      "name": "[parameters('sqlServerName')]",
      "type": "Microsoft.Sql/servers",
      "apiVersion": "2015-05-01-preview",
      "location": "[resourceGroup().location]",
      "tags": {},
      "properties": {
        "administratorLogin": "[parameters('adminLogin')]",
        "administratorLoginPassword": "[parameters('adminPassword')]",
        "version": "12.0"
      }
    }
  ],
  "outputs": {
  }
}

```

Now you can create a parameter file for the preceding template. In the parameter file, specify a parameter that matches the parameter's name in the template.

For the parameter value, reference the secret from the Key Vault. You reference the secret by passing the resource identifier of the Key Vault and the secret's name.

The Key Vault secret must already exist in the following parameter file, and you provide a static value for its resource ID.

Copy this file locally, and set the subscription ID, vault name, and SQL server name:

```JSON
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "adminLogin": {
            "value": "exampleadmin"
        },
        "adminPassword": {
            "reference": {
              "keyVault": {
                "id": "/subscriptions/<subscription-id>/resourceGroups/examplegroup/providers/Microsoft.KeyVault/vaults/<vault-name>"
              },
              "secretName": "examplesecret"
            }
        },
        "sqlServerName": {
            "value": "<your-server-name>"
        }
    }
}

```

You would need to deploy the template and pass the parameter file to the template.

For more information, use[ Azure Key Vault to pass secure parameter values during deployment](/azure/azure-resource-manager/resource-manager-keyvault-parameter) for more details.

There are also details on this web page for reference to a secret with a dynamic ID.
