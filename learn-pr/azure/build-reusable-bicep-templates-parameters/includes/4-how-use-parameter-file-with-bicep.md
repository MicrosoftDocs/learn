In the previous units, you provided the parameter values on the command line when you created a deployment. This approach works well when you're writing and testing your Bicep files, but it doesn't work well when you have many parameters or when you need to automate your deployments. In this unit, you'll learn about different ways that parameter values can be specified.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Create parameter files

_Parameter files_ make it easy to specify parameter values together as a set. Within the parameter file, you provide values for the parameters in your Bicep file. Parameter files are created by using the JavaScript Object Notation (JSON) language. You can supply a parameter file when you deploy your Bicep template. Here's what a parameter file looks like:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "appServicePlanInstanceCount": {
      "value": 3
    },
    "appServicePlanSku": {
      "value": {
        "name": "P1v3",
        "tier": "PremiumV3"
      }
    },
    "cosmosDBAccountLocations": {
      "value": [
        {
          "locationName": "australiaeast"
        },
        {
          "locationName": "southcentralus"
        },
        {
          "locationName": "westeurope"
        }
      ]
    }
  }
}
```

Let's look at each part of the parameter file in more detail:

- `$schema` helps Azure Resource Manager to understand that this file is a parameter file.
- `contentVersion` is a property that you can use to keep track of significant changes in your parameter file if you want. Usually, it's set to its default value of `1.0.0.0`.
- The `parameters` section lists each parameter and the value you want to use. The parameter value must be specified as an object. The object has a property called `value` that defines the actual parameter value to use.

Generally, you'll create a parameter file for each environment. It's a good practice to include the environment name in the name of the parameter file. For example, you might have a parameter file named _main.parameters.dev.json_ for your development environment and one named _main.parameters.production.json_ for your production environment.

> [!NOTE]
> Make sure you only specify values for parameters that exist in your Bicep template. When you create a deployment, Azure checks your parameters and gives you an error if you've tried to specify a value for a parameter that isn't in the Bicep file.

## Use parameter files at deployment time

::: zone pivot="cli"

When you create a new deployment by using the `az deployment group create` command, you can specify the name of the parameter file you want to use with the `--parameters` argument:

:::code language="azurecli" source="code/4-deployment.sh" highlight="3":::

::: zone-end

::: zone pivot="powershell"

When you create a new deployment by using the `New-AzResourceGroupDeployment` cmdlet, you can specify the name of the parameter file you want to use with the `-TemplateParameterFile` argument:

:::code language="azurepowershell" source="code/4-deployment.ps1" highlight="3":::

::: zone-end

## Override parameter values

You've now learned about three ways to specify parameter values: default values, the command line, and parameter files. It's common to use different approaches to specify different values for the same parameter. You've already seen this approach when you worked with default values. When you create a default value for a parameter, but then specify a different value by using the command line, the command-line value takes precedence. Let's look at how parameter files fit into this order of precedence.

:::image type="content" source="../media/4-precedence.png" alt-text="Diagram that shows the order of precedence for parameter values. Parameter files override default values, and command-line parameter values override parameter files." border="false":::

You can see that parameter files override default values, and command-line parameter values override parameter files.

Let's see how this approach works. Here's an example Bicep file that defines three parameters, each with default values:

```bicep
param location string = resourceGroup().location
param appServicePlanInstanceCount int = 1
param appServicePlanSku object = {
  name: 'F1'
  tier: 'Free'
}
```

Let's look at a parameter file that overrides the value of two of the parameters but doesn't specify a value for the `location` parameter:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "appServicePlanInstanceCount": {
      "value": 3
    },
    "appServicePlanSku": {
      "value": {
        "name": "P1v3",
        "tier": "PremiumV3"
      }
    }
  }
}
```

::: zone pivot="cli"

When you create the deployment, we also override the value for `appServicePlanInstanceCount`. Like with parameter files, you use the `--parameters` argument, but you add the value you want to override as its own value:

:::code language="azurecli" source="code/4-override.sh" highlight="4":::

::: zone-end

::: zone pivot="powershell"

When you create the deployment, you override one of the parameter values. You specify the parameter name as if it's an argument to the cmdlet:

:::code language="azurepowershell" source="code/4-override.ps1" highlight="4":::

::: zone-end

Let's look at what the values will be.

| Parameter | Value | Explanation |
|-|-|-|
| `location` | The resource group's location. | The Bicep file specifies this parameter as a default value, and it's not overridden. |
| `appServicePlanSku` | An object with a `name` property set to `P1v3` and a `tier` of `PremiumV3`. | The default value in the Bicep file is overridden by the parameter file. |
| `appServicePlanInstanceCount` | `5` | The value specified at deployment time overrides the default value and the value in the parameter file. |

By using a mixture of the approaches to specify parameter values, you can avoid having to duplicate parameter values in lots of places, while still getting the flexibility to override where you need to.
