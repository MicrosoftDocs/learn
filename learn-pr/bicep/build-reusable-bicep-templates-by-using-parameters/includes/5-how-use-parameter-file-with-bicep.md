 In the previous units, you learn how to use inline parameters with your deployments. This approach worked for testing your Bicep files. When automating deployments, it's often better to define a set of values for the environment you're deploying to. _Parameter files_ make it easy to package parameter values together. You supply the JSON parameter file when deploy your Bicep template. You often will create and check-in a parameter file for each environment. It's common to include an environment name in the naming convention of the parameter file, e.g. _*.parameters.{environmentName}.json_. Here, you'll learn how to use parameter files with Bicep.

## Review Bicep file

Here is an example of a Bicep template to deploy an Azure SQL Database as part of HR application migration. It has many parameters you can provide during deployment.

```bicep
@allowed([
    'dev'
    'test'
    'prod'
])
param environment string
param serverName string = '${environment}-tailspintoys-hr-sql'
param sqlDatabaseName string = 'employeeDB'
param location string = resourceGroup().location

@secure()
param administratorLogin string

@secure()
param administratorLoginPassword string
```

## Parameter file

Parameter files are created using the JavaScript Object Notation (JSON) language.

Within the parameter file, you provide values for the parameters in your Bicep file. Make sure you don't try to specify values for parameters that don't exist, because Bicep won't let you do this.

You don't have to provide a value for every parameter. If you don't specify the value for a parameter, its default value will be used during deployment. You can also specify parameter values during each deployment, and these will override both the default value and the value in the parameter file. If you aren't sure what values were used and need to debug, you can always inspect the values of a parameter by opening the portal or by querying the deployment.

The parameter values always take the following precedence:

- Default values are used if specified and no parameter value provided.
- The default values are overridden by value defined in a parameter file.
- The Parameter file values are overridden by command-line arguments. If the DevOps pipelines is used, parameter values injected from the pipelines take priority.

A parameter file looks like this:

```JSON
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "<first-parameter-name>": {
      "value": "<first-value>"
    },
    "<second-parameter-name>": {
      "value": "<second-value>"
    }
  }
}
```

> [!Note]
> The parameter file must have `$schema` and `contentVersion` specified. You can provide any value for this `contentVersion`. Use this value to document significant changes in your parameter file. However, `$schema` must follow `https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json` schema and version. The `2019-04-01` is the latest at the time of writing.

Here is an example of a parameter file for a Bicep template shown in the first example:

```JSON
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "environment": {
      "value": "dev"
    }
  }
}
```

Consider the example above, you're providing value for the environment parameter. The other parameters will use their default value during deployment. You also will be prompted to enter secure parameters.

> [!WARNING]
> While you can explicitly specify a secure parameter's value in a parameters file, it's not a good practice. This can potentially expose your sensitive information.

> [!Note]
> Parameter names in parameter files are case-insensitive.

```JSON
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "environment": {
      "value": "dev"
    },
    "sqlDatabaseName": {
      "value": "staffDB"
    }    
  }
}
```

In the example above, you're also providing a value for the `sqlDatabaseName` parameter. The value provided in the parameter file will override the parameter's default value.

## Azure Key Vault integration

You can see the parameter file above is missing the two secure parameters. Often in automation, you'll check the parameter file into a source control repository, and you don't want to include secret values in those files. If someone gain access to your repository, the sensitive information can be exposed.

Azure Key Vault is a service designed to store and provide access to secrets. You can integrate your Bicep templates with Key Vault by using a parameter file with a reference to a Key Vault secret.

You retrieve the value by referencing the key vault and secret in your parameter file. The value is never exposed because you only reference its key vault ID, which could even come from a different resource group or subscription.

:::image type="content" source="../media/5-parameter-file-key-vault.png" alt-text="Diagram that shows a parameter file reference Azure Key Vault and pass secret to Bicep template to deploy Azure resources" border="false":::

Below is another example of a parameter file with Azure Key Vault references for the Bicep template shown in the first example:

```JSON
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "environment": {
      "value": "dev"
    },
    "administratorLogin": {
      "reference": {
        "keyVault": {
        "id": "/subscriptions/c0c26c60-679b-49ca-91be-458adbaf4594/resourceGroups/PlatformResources/providers/Microsoft.KeyVault/vaults/sqlAdministratorLogin"
        },
        "secretName": "sqlAdminLogin"
      }
    },
    "administratorLoginPassword": {
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