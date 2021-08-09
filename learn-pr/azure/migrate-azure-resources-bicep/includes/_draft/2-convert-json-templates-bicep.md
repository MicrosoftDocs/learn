You've started the process of migrating your Azure resources to Bicep, and you want to start with converting your JSON templates to Bicep templates using the native tooling. You want to learn more about how Bicep works, how to use the Bicep decompiler, and how to refactor your decompiled templates. You want to accomplish these tasks following a recommended workflow.

## How does Bicep work?

Bicep is a Resource Manager template language that's used to declaratively deploy Azure resources. It's a domain-specific language, which means it's designed for a specific scenario or "domain." Bicep isn't meant to be used as a programming language for applications. Bicep is only used to create Resource Manager templates.

When you submit a Bicep template for deployment to Resource Manager, the tooling converts your Bicep template into a JSON template. This process is known as _transpilation_, which essentially treats the ARM template as an intermediate language. The conversion happens automatically when you submit your deployment, or you can do it manually.

:::image type="content" source="../../includes/media/bicep-to-json.png" alt-text="Diagram that shows a template author, a Bicep template, an emitted JSON template, and a deployment to Azure." border="false":::

> [!NOTE]
> Transpilation is the process of converting source code written in one language into another language.

## What is the Bicep decompiler?

Your first step in migrating your Azure resources to Bicep is to convert your JSON ARM templates to Bicep templates.

The Bicep tooling includes the `decompile` command, which is used to convert a JSON template to a Bicep template. You can invoke the `decompile` command from either the AZ CLI, or from the Bicep CLI.

The decompilation process is a best-effort process and doesn't guarantee a full mapping from JSON to Bicep. You may need to revise the generated Bicep file to meet your template best practices before using the file to deploy resources. Later in this unit, you'll learn how to fix any issues encountered in the decompilation process.

### Decompile an JSON ARM template to Bicep

To decompile an JSON ARM template to Bicep with the Azure CLI, use:

```azurecli
az bicep decompile --file main.json
```

To decompile an JSON ARM template to Bicep with the Bicep tooling, use:

```bicep
bicep decompile --file main.json
```

Both commands will create a file named main.bicep in the same directory as the original JSON template.

> [!NOTE]
> The [Bicep playground](https://bicepdemo.z22.web.core.windows.net/) is an online tool that compares JSON templates and Bicep templates side by side. You can choose an Azure quickstart template or upload your own template by clicking the `Decompile` button.

## Recommended workflow for converting templates to Bicep

To help your templates align with best practices, you can follow a recommended workflow when converting and exporting your templates to Bicep. This workflow consists of five phases: convert, migrate, refactor, test, and deploy. In this unit, we focus on the first three phases: convert, migrate, and refactor. Later in this module, you'll learn how to test and deploy your Bicep template.

### Convert phase

In the _convert_ phase of converting your templates to Bicep, the goal is to capture the initial representation of your Azure resources.

:::image type="content" source="../media/2-convert.png" alt-text="Diagram of converting a JSON template to Bicep." border="true":::

1. **Decompile the source JSON ARM template** - From a terminal window, run either the `az bicep decompile` or the `bicep decompile` command against your source JSON template to convert the file to a Bicep template. Using Visual Studio Code, open your decompiled JSON file.

### Migrate phase

In the _migrate_ phase of converting your templates to Bicep, the goal is to create an initial Bicep file that includes all of your Azure resources.

:::image type="content" source="../media/2-migrate.png" alt-text="Diagram of migrating a template to Bicep." border="true":::

1. **Create a new Bicep file** - Using [Visual Studio Code](https://code.visualstudio.com/), create a new Bicep file. This new file will become the main template file for your converted template. Open this file side-by-side with your decompiled Bicep file.

1. **Copy the resources from the converted Bicep file to your new Bicep file** - For each defined resource in your original JSON template, copy it from the converted Bicep file to the new Bicep file. Consider copying the resources individually, so that you can resolve any issues on a per resource basis.

1. **Create parameters for each environment** - If your infrastructure supports multiple environments, such as production and development, create parameters that support these environments. A good parameter naming convention will make it easy to customize your deployments per environment.

### Refactor phase

In the _refactor_ phase of converting your templates to Bicep, the goal is to improve the quality of your Bicep code.

:::image type="content" source="../media/2-refactor.png" alt-text="Diagram of refactoring a Bicep template." border="true":::

1. **Review the linter suggestions in your new Bicep file** - When creating Bicep files using the [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), the linter runs automatically and highlights suggestions and errors in your code. Many of the suggestions and errors include an option to apply a quick fix of the issue. Review these recommendations and adjust your Bicep file.

1. **Revise parameters, variables, and symbolic names** - It is possible that the names of parameters, variables, and symbolic names generated by the decompiler will not match your standard naming convention. Review the generated names and make adjustments as necessary.

1. **Simplify expressions** - The decompile process may not always take advantage of some of Biceps features. Review any expressions generated in the conversion and simplify them. The result may include a concat function that could be simplified using string interpolation. Review any suggestions from the linter and make adjustments as necessary.

1. **Review child and extension resources** - With Bicep, there are multiple ways to declare child and extension resources. Consider reviewing these resources after decompilation and make sure that the structure meets your standards. For example, Subnets can either be referenced as properties of a Virtual Network, or as a separate resource. Make any necessary changes to child and extension resources.

1. **Modularize** - If you're converting a template that has many resources, consider breaking the individual resource types into modules for simplicity. Bicep modules help to reduce the complexity of your template deployments.

   > [!NOTE]
   > It is possible to use your JSON templates as modules in a Bicep deployment. Bicep has the ability to recognize JSON modules and reference them similarly to how you use Bicep modules.

1. **Add comments** - Good Bicep code is _self-documenting_! Bicep allows you to add comments to your code that help you document your infrastructure. These comments can help your teammates understand the code, and increase confidence when changes are made. Comments are ignored when the Bicep file is deployed to Azure.

1. **Follow Bicep best practices** - Make sure that your Bicep file is following the recommended best practices. Review the [Bicep best practices](/azure/azure-resource-manager/bicep/best-practices) reference document for anything you might have missed.

## Refactor decompiled templates

After the convert and migrate phases of converting your templates to Bicep, you'll want to make some improvements to the file. This process is called refactoring. These improvements can include changes that bring the template in line with your team's code standards and general best practices with Bicep templates.

Take a look at the following JSON template that creates an Azure App Service Plan.

```json
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

```bicep
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

If you deploy this Bicep template as-is, the deployment would succeed, but there are a few things you could do to improve the template and bring it line with best practices.

### Revise parameters, variables, and symbolic names

One of the main tasks in converting our JSON templates to Bicep templates is to revise the names of parameters, variables, and symbolic names. The Bicep decompiler may add some extra text to these names that may not adhere to your template standards.

#### Revise parameters and variables

Review parameter and variable names. - In the converted template, take a look at the variable `appServicePlanName_var`. This variable name has `_var` appended to the end of the original variable name.

:::code language="bicep" source="code/2-app-service-plan.bicep" range="20-27" highlight="6" :::

For clarity, remove the `_var` as shown below:

```bicep
var appServicePlanName = 'plan-${environment}-001'
```

By making this change to the `appServicePlanName` variable, any reference to the original variable name will need to be updated. Look for any linting errors within the code that highlight where the variable needs to be updated. The value for `name:` needs to be updated with the new variable name.

:::code language="bicep" source="code/2-app-service-plan.bicep" range="27-29" highlight="2" :::

For clarity, remove the `_var` as shown below:

```bicep
name: appServicePlanName
```

> [!TIP]
> Pressing F2 in VS Code will help you rename a symbol and all references to that symbol.

#### Revise symbolic names

After updating the variable name and its references, notice that the `appServicePlanName` variable shares the same name as the `appServicePlanName` symbolic name.

:::code language="bicep" source="code/2-app-service-plan.bicep" range="27-29" highlight="1" :::

Modify the name of the symbolic name to `appServicePlan` as shown below:

```bicep
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
```

By making this change to the `appServicePlan` symbolic name, any reference to the original symbolic name will need to be updated. Look for any linting errors within the code that highlight where the symbolic name needs to be updated. The value for the `appServicePlanId` output needs to be updated based on the new symbolic name.

:::code language="bicep" source="code/2-app-service-plan.bicep" range="34-38" highlight="4" :::

Modify the value of the `appServicePlanId` output as shown below:

```bicep
output appServicePlanId string = appServicePlan.id
```

### Add comments

Another good practice is to add comments to your Bicep templates. These self-documenting comments can help make your templates easy to understand, even for teammates that may not be familiar with the resources declared in the template.

Bicep supports both single-line comments using a `//` character sequence and multi-line comments that start with a `/*` and end with a `*/`. You can comments to specific lines in your code and for sections of code.

You can add a multi-line comment at the beginning of the file as shown below:

```bicep
/*
  This Bicep file was developed by the web team.
  It deploys the resources we need for our toy company's website.
*/
```

Single-line comments can be added as headers for sections of code, or on individual lines to describe the code.

:::code language="bicep" source="code/2-app-service-plan-updated.bicep" range="34-46" highlight="1,6,9,12" :::

### The converted template

After making the appropriate improvements, review the final template before deployment. Take a look at the final converted template below that includes the revised names and added comments:

```bicep
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
