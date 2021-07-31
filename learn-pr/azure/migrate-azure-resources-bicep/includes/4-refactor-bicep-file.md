You've completed the process of converting and migrating your JSON ARM templates and Azure resources to Bicep. It's clear the converted templates could use some improvements to bring them inline with your template standards. You want to learn more about how to refactor your converted and migrated templates to improve their quality. You want to accomplish these tasks following a recommended workflow.

## Refactor phase

After the convert and migrate phases of converting your templates to Bicep, improvements can be made to the file. This process is called refactoring. The third phase of the recommended workflow for migrating your JSON ARM template and Azure resource to Bicep is the _refactor_ phase.

:::image type="content" source="../media/4-refactor-phase.png" alt-text="Diagram of the refactor phase of the recommended workflow for migrating Azure resources to Bicep." border="true":::

The main focus of this phase is to improve the quality of your Bicep code. These improvements can include changes that bring the template in line with your template standards and general best practices with Bicep templates.

:::image type="content" source="../media/4-refactor.png" alt-text="Diagram of refactoring a Bicep template." border="true":::

Take a look at the following JSON template that creates an Azure App Service Plan.

```JSON
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "location": {
            "type": "string",
            "defaultValue": "[resourceGroup().location]",
            "metadata": {
                "description": "Location for resources."
            }
        },
        "environment": {
            "type": "string",
            "defaultValue": "prod",
            "allowedValues": [
                "prod",
                "dev",
                "test"
            ],
            "metadata": {
                "description": "The list of allowed environment names."
            }
        },
        "appServicePlanSku": {
            "type": "string",
            "defaultValue": "P1v3",
            "allowedValues": [
                "P1v3",
                "P2v3",
                "P3v3"
            ],
            "metadata": {
                "description": "The list of allowed App Service Plan SKUs."
            }
        },
        "appServicePlanInstanceCount": {
            "type": "int",
            "defaultValue": 1,
            "minValue": 1,
            "maxValue": 10,
            "metadata": {
                "description": "The number of allowed App Service Plan instances."
            }
        }
    },
    "variables": {
        "appServicePlanName": "[concat('plan-', parameters('environment'), '-001')]"
    },
    "resources": [
        {
            "type": "Microsoft.Web/serverFarms",
            "apiVersion": "2020-12-01",
            "name": "[variables('appServicePlanName')]",
            "location": "[parameters('location')]",
            "sku": {
                "name": "[parameters('appServicePlanSku')]",
                "capacity": "[parameters('appServicePlanInstanceCount')]"
            },
            "kind": "app",
            "properties": {}
        }
    ],
    "outputs": {
        "appServicePlanId": {
          "type": "string",
          "value": "[resourceId('Microsoft.Web/serverFarms', variables('appServicePlanName'))]"
        }
    }
}
```

When you run the Bicep `decompile` command against this template, the following Bicep template is generated:

```Bicep
@description('Location for resources.')
param location string = resourceGroup().location

@allowed([
  'prod'
  'dev'
  'test'
])
@description('The list of allowed environment names.')
param environment string = 'prod'

@allowed([
  'P1v3'
  'P2v3'
  'P3v3'
])
@description('The list of allowed App Service Plan SKUs.')
param appServicePlanSku string = 'P1v3'

@minValue(1)
@maxValue(10)
@description('The number of allowed App Service Plan instances.')
param appServicePlanInstanceCount int = 1

var appServicePlanName_var = 'plan-${environment}-001'

resource appServicePlanName 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku
    capacity: appServicePlanInstanceCount
  }
  kind: 'app'
  properties: {}
}

output appServicePlanId string = appServicePlanName.id
```

If you deploy this Bicep template as-is, the deployment would succeed, but there are improvements that could be made to bring it line with your template standards.

### Review resource API versions

When exporting Azure resources, the exported template may not have the latest API version for a resource type. If there are specific properties that you need for future deployments, update the API to the appropriate version. It's good practice to review the API versions for each exported resource.

Consider using the [Azure ARM Template Reference](/azure/templates/) documentation to help verify the appropriate API versions and resource properties for your template.

### Review the linter suggestions in your new Bicep file

When creating Bicep files using the [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), the linter runs automatically and highlights suggestions and errors in your code. Many of the suggestions and errors include an option to apply a quick fix of the issue. Review these recommendations and adjust your Bicep file.

### Revise parameters, variables, and symbolic names

It's possible the names of parameters, variables, and symbolic names generated by the decompiler won't match your standard naming convention. Review the generated names and make adjustments as necessary.

#### Parameters and variables

In the converted template, take a look at the variable `appServicePlanName_var`. This variable name has `_var` appended to the end of the original variable name.

:::code language="bicep" source="code/2-app-service-plan.bicep" range="20-27" highlight="6" :::

For clarity, remove the `_var` as shown below:

```Bicep
var appServicePlanName = 'plan-${environment}-001'
```

By making this change to the `appServicePlanName` variable, any reference to the original variable name will need to be updated. Look for any linting errors within the code that highlight where the variable needs to be updated. The value for `name:` needs to be updated with the new variable name.

:::code language="bicep" source="code/2-app-service-plan.bicep" range="27-29" highlight="2" :::

For clarity, remove the `_var` as shown below:

```Bicep
name: appServicePlanName
```

> [!TIP]
> Pressing F2 in VS Code will help you rename a symbol and all references to that symbol.

#### Symbolic names

After updating the variable name and its references, notice that the `appServicePlanName` variable shares the same name as the `appServicePlanName` symbolic name.

:::code language="bicep" source="code/2-app-service-plan.bicep" range="27-29" highlight="1" :::

Modify the name of the symbolic name to `appServicePlan` as shown below:

```Bicep
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
```

By making this change to the `appServicePlan` symbolic name, any reference to the original symbolic name will need to be updated. Look for any linting errors within the code that highlight where the symbolic name needs to be updated. The value for the `appServicePlanId` output needs to be updated based on the new symbolic name.

:::code language="bicep" source="code/2-app-service-plan.bicep" range="34-38" highlight="4" :::

Modify the value of the `appServicePlanId` output as shown below:

```Bicep
output appServicePlanId string = appServicePlan.id
```

### Simplify expressions

The decompile process may not always take advantage of some of Biceps features. Review any expressions generated in the conversion and simplify them. The result may include a concat function that could be simplified using string interpolation. Review any suggestions from the linter and make adjustments as necessary.

### Review child and extension resources

With Bicep, there are multiple ways to declare child and extension resources. Consider reviewing these resources after decompilation and make sure the structure meets your standards. For example, Subnets can either be referenced as properties of a Virtual Network, or as a separate resource. Make any necessary changes to child and extension resources.

### Modularize

If you're converting a template that has many resources, consider breaking the individual resource types into modules for simplicity. Bicep modules help to reduce the complexity of your template deployments.

> [!NOTE]
> It's possible to use your JSON templates as modules in a Bicep deployment. Bicep has the ability to recognize JSON modules and reference them similarly to how you use Bicep modules.

### Add comments

Good Bicep code is _self-documenting_! Bicep allows you to add comments to your code that help you document your infrastructure. These comments can help your teammates understand the code, and increase confidence when changes are made. Comments are ignored when the Bicep file is deployed to Azure.

Bicep supports both single-line comments using a `//` character sequence and multi-line comments that start with a `/*` and end with a `*/`. You can comments to specific lines in your code and for sections of code.

You can add a multi-line comment at the beginning of the file as shown below:

```Bicep
/*
  This Bicep file was developed by the web team.
  It deploys the resources we need for our toy company's website.
*/
```

Single-line comments can be added as headers for sections of code, or on individual lines to describe the code.

:::code language="bicep" source="code/2-app-service-plan-updated.bicep" range="34-46" highlight="1,6,9,12" :::

### Follow Bicep best practices

Make sure your Bicep file is following the recommended best practices. Review the [Bicep best practices](/azure/azure-resource-manager/bicep/best-practices) reference document for anything you might have missed.

### The converted template

After making the appropriate improvements, review the final template before deployment. Take a look at the final converted template below that includes the revised names and added comments:

```Bicep
/*
  This Bicep file was developed by the web team.
  It deploys the resources we need for our toy company's website.
*/

// parameters
@description('Location For All Resources.')
param location string = resourceGroup().location

@allowed([
  'prod' // Production environment
  'dev' // Development environment
  'test' // Test environment
])
@description('The list of allowed environment names.')
param environment string = 'prod'

@allowed([
  'P1v3'
  'P2v3'
  'P3v3'
])
@description('The list of allowed App Service Plan SKUs.')
param appServicePlanSku string = 'P1v3'

@minValue(1)
@maxValue(10)
@description('The number of allowed App Service Plan instances.')
param appServicePlanInstanceCount int = 1

// variables
var appServicePlanName = 'plan-${environment}-001'

// resource - app service plan
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku // Specifies the SKU of the App Service Plan.
    capacity: appServicePlanInstanceCount
  }
  kind: 'app' // Specifies a Windows App service Plan.
}

output appServicePlanId string = appServicePlan.id // Outputs the resource Id of the App Service Plan.

```