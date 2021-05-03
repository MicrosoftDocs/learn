In the previous units, you provided the parameter values on the command line when you created a deployment. This approach works well when you're writing and testing your Bicep files, but it doesn't work well when you have a lot of parameters or when you need to automate your deployments. In this unit, you'll learn about different ways that parameter values can be specified.

## Create parameter files

_Parameter files_ make it easy to specify parameter values together as a set. Within the parameter file, you provide values for the parameters in your Bicep file. Parameter files are created using the JavaScript Object Notation (JSON) language. You supply the JSON parameter file when you deploy your Bicep template. Here's what a parameter file looks like: 

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "appServicePlanSkuName": {
      "value": "P1v3"
    },
    "appServicePlanInstanceCount": {
      "value": 3
    },
    "cosmosDBAccountLocations": {
      "value": [
        {
          "locationName": "australiaeast"
        }
        {
          "locationName": "southcentralus"
        }
        {
          "locationName": "westeurope"
        }
      ]
    }
  }
}
```

Let's look at each part of this in more detail:

- `$schema` identifies that this is a parameters file when it's submitted to Azure Resource Manager.
- You can use `contentVersion` to keep track of significant changes in your parameter file if you want, but usually it's just kept as `1.0.0.0`.
- The `parameters` section lists each parameter and the value you want to use.
    - Parameter names in parameter files are case-insensitive. If you have defined a parameter in your Bicep template named `appServicePlanSkuName`, you can use the name `AppServicePlanSKUName` in your parameters file and it will work.
    - Notice that the parameter value has to be specified as an object. The object has a property called `value` that defines the actual value you want to use.

Generally you will create a parameter file for each environment. It's common to include an environment name in the name of the parameter file. For example, you might have parameter files named *main.parameters.dev.json* and *main.parameters.production.json* for your development and production environments.

> [!TIP]
> Make sure you only specify values for parameters that exist in your Bicep template. When you create a deployment, Azure will check your parameters and will tell you if you have tried to specify a value for a parameter it doesn't know about.

## Use parameter files at deployment time

::: zone pivot="cli"

When you create a new deployment using the `az group deployment create` command, you can specify the name of the parameter file you want to use with the  `--parameters` argument:

:::code language="azurecli" source="code/4-deployment.sh" highlight="3":::

::: zone-end

::: zone pivot="powershell"

When you create a new deployment using the `New-AzResourceGroupDeployment` cmdlet, you can specify the name of the parameter file you want to use with the `--TemplateParameterFile` argument:

:::code language="azurepowershell" source="code/4-deployment.ps1" highlight="3":::

::: zone-end

## Override parameter values

You've now learned about three ways to specify parameter values: default values, the command line, and parameter files. It's common to use different approaches to specify different values for the same parameter. You've already seen this when we worked with default values: if you specify a parameter's default value in a Bicep file, but then specify a different value using the command line, the command-line version takes priority. Let's look at how parameter files fit into this:

:::image type="content" source="../media/4-precedence.png" alt-text="Diagram that shows the order of precedence. Default values are overridden by parameter files, which are overridden by command-line parameter values." border="false":::

You can see that default values are overridden by values that you specify in a parameter file, and parameter file values are overridden by command-line parameter values.

Let's see how this works. Here's an example Bicep file that defines three parameters with default values:

```bicep
param location string = resourceGroup().location
param appServicePlanSkuName string = 'P1v3'
param appServicePlanInstanceCount int = 1
```

You can create a parameter file that overrides the value of two of the parameters:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "appServicePlanSkuName": {
      "value": "P2v3"
    },
    "appServicePlanInstanceCount": {
      "value": 3
    }
  }
}
```

::: zone pivot="cli"

When you create the deployment, you override one of the parameter values. Like with parameter files, you use the `--parameters` argument, but you add the value you want to override as its own value:

:::code language="azurecli" source="code/4-override.sh" highlight="4":::

::: zone-end

::: zone pivot="powershell"

When you create the deployment, you override one of the parameter values. You specify the parameter name as if it's an argument to the cmdlet:

:::code language="azurepowershell" source="code/4-override.ps1" highlight="4":::

::: zone-end

Let's look at what the values will be:

- `location` will be the resource group's location. The Bicep file specifies this as a default value, and it's not overridden.
- `appServicePlanSkuName` will be `P2v3`. The default value in the template is overridden by the parameter file.
- `appServicePlanInstanceCount` will be `5`. The value specified at deployment time overrides the default value and the value in the parameter file.

By using a mixture of the approaches to specify parameter values, you can avoid having to duplicate parameter values in lots of places, while still getting the flexibility to override it where you need to.
