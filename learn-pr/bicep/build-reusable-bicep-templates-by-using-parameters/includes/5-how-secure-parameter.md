In this unit, you'll learn how to secure parameters. You may want to pass sensitive value into Bicep as a parameter. When passing sensitive value, you want to avoid entering plaintext into a terminal. This leads to exposing of sensitive information. The value can be easily retrieved from the terminal command history and the deployment logs. You can protect sensitive value by applying the @secure decorator when declaring a parameter.

## Secure parameters

Sometimes, you need to pass sensitive values into your deployments, like logins and passwords. To secure these values, use parameters with the `@secure` decorator. You can apply `@secure` decorator to only string or object type parameters.

When you're prompted for a secure parameter, you can type in text as normal but the terminal will not display the text on your screen. The deployment logs also don't include any secure parameter values.

As part of the HR application migration, you need to deploy an Azure SQL server and database. You will provision the server with an administrative login and password. These values are sensitive, and you need the deployment to be secured. Here is an example declaration to secure string parameters:

```bicep
@secure()
param sqlServerAdministratorLogin string
@secure()
param sqlServerAdministratorPassword string
```

Note that both secure parameters don't have default value specified. When manually deploy the template using the Azure CLI or PowerShell, you'll get prompt to enter the values for `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameters. SQL Database enforces password complexity. You must meet these [guidelines]((/sql/relational-databases/security/password-policy?view=sql-server-ver15#password-complexity) when entering the password.

> [!TIP]
> * Always use parameters for usernames, passwords, API keys, certificates, and any other secrets.
> * Use the `@secure` decorator for all secret parameters.
> * Don't provide default values for usernames, passwords, or any other secure parameters.
> * Make sure you never create an output for sensitive data. Output values can be accessed by anyone who has access to the deployment history.

## Azure Key Vault integration

You learn in the previous unit that parameter files are used in automated deployments. While you can explicitly specify a secure parameter's value in a parameters file, it's not a good practice. This can potentially expose your sensitive information. Often in automation, you'll check the parameter files into a source control repository, and you don't want to include secret values in these files. If someone gain access to your repository, the sensitive information can be exposed.

Azure Key Vault is a service designed to store and provide access to secrets. You can integrate your Bicep templates with Key Vault by using a parameter file with a reference to a Key Vault secret.

You retrieve the value by referencing the key vault and secret in your parameter file. The value is never exposed because you only reference its key vault ID, which could even come from a different resource group or subscription.

:::image type="content" source="../media/5-parameter-file-key-vault.png" alt-text="Diagram that shows a parameter file reference Azure Key Vault and pass secret to Bicep template to deploy Azure resources" border="false":::

Below is another example of a parameter file with Azure Key Vault references for the Bicep template shown in the above example:

```JSON
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "sqlServerAdministratorLogin": {
      "reference": {
        "keyVault": {
        "id": "/subscriptions/c0c26c60-679b-49ca-91be-458adbaf4594/resourceGroups/PlatformResources/providers/Microsoft.KeyVault/vaults/sqlAdministratorLogin"
        },
        "secretName": "sqlAdminLogin"
      }
    },
    "sqlServerAdministratorPassword": {
      "reference": {
        "keyVault": {
        "id": "/subscriptions/c0c26c60-679b-49ca-91be-458adbaf4594/resourceGroups/PlatformResources/providers/Microsoft.KeyVault/vaults/sqlAdministratorLoginPassword"
        },
        "secretName": "sqlAdminLoginPassword"
      }
    }
  }
}
```

Before you can run a deployment using the parameter file with Key Vault references, you must enable the key vault for template deployments. This allows Azure Resource Manager to access the key vault during template deployments. Also, the user who deploys the template must have permission to access the key vault. You'll learn how to do this in the next unit.