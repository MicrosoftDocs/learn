 In the previous units, you learn how to use inline parameters with your deployments. This approach worked for testing your Bicep files. When automating deployments, it's often better to define a set of values for the environment you're deploying to. _Parameter files_ make it easy to package parameter values together. You supply the JSON parameter file when deploy your Bicep template. You often will create and check-in a parameter file for each environment. It's common to include an environment name in the naming convention of the parameter file, e.g. _*.parameters.{environmentName}.json_. Here, you'll learn how to use parameter files with Bicep.

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

## Review Bicep file

Here is an example of parameters of a Bicep template to deploy Azure App Service plan and App Service app as part of HR application migration. It has many parameters you can provide during deployment.

```bicep
@allowed([
      'dev'
      'test'
      'prod'
])
@description('Name of environment to deploy - only accept dev, test, and prod')
param environmentName string

@minLength(5)
@maxLength(30)
@description('Unique name of solution you want to deploy')
param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'

@minValue(2)
@maxValue(10)
@description('Number of App Service Plan Instance to run at all time - allowed number between 2 and 10')
param appServicePlanInstanceCount int = 2
      
@description('Azure region where you want to deploy')
param location string = resourceGroup().location
```

Here is an example of a parameter file for a Bicep template shown in the first example:

```JSON
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "environmentName": {
      "value": "dev"
    }
  }
}
```

Consider the example above, you're providing value for the `environmentName` parameter. The other parameters will use their default value during deployment.

> [!Note]
> Parameter names in parameter files are case-insensitive.

```JSON
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "environmentName": {
      "value": "dev"
    },
    "appServicePlanInstanceCount": {
      "value": 5
    }    
  }
}
```

In the example above, you're also providing a value for the `appServicePlanInstanceCount` parameter. The value provided in the parameter file will override the parameter's default value.
