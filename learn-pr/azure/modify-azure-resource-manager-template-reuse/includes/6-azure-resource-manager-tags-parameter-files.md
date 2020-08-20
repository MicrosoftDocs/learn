There are two features of Azure Resource Manager (ARM) templates that you'll want to use when you deploy to more than one Azure environment. These features are *resource tags* and *ARM template parameter files*.

As you add more resources to your environments, you'll quickly find that you need a way to identify the purpose of these resources. Resources have a ```tags:``` attribute for this purpose. And as you deploy to more environments, you'll need an efficient way to keep track of the input parameters. ARM templates can use parameter files to manage parameters for each deployment environment.

## What is an Azure resource tag?

You can tag resources to add values that help you identify their use. For example, you can add tags that list the environment and the project that a resource belongs to. Or you can add tags that identify a cost center or the team that owns a resource. Add any values that make sense for your organization.

The tag value will be displayed on the overview page for the Azure resource and in cost reports.

## How do I create an Azure resource tag?

Each resource has a ```tags:``` attribute. So far, you've been using the default ```displayName``` for the tag for your storage account:

```json
"tags": {
          "displayName": "[parameters('storageName')]"
        },
```

To make this attribute more useful, you can define a parameter that has more information and then use that parameter in the ```tags:``` attribute. For example, you can create a parameter to hold an object called `resourceTags`:

```json
"resourceTags": {
    "type": "object",
    "defaultValue": {
        "Environment": "Dev",
        "Project": "Inventory"
        }
    }
```

Here, you created an object to hold values for an environment name and a project name. You could have defined anything you wanted.

You then use that parameter for any resource that's for the Dev environment and the Inventory project. For example, your storage account.

```json
"resources": [{
        "name": "[variables('uniqueStorageName')]",
        "type": "Microsoft.Storage/storageAccounts",
        "apiVersion": "2019-06-01",
        "tags": "[parameters('resourceTags')]",
        ...
    }],
```

## What is an ARM template parameter file?

An ARM template parameter file holds values that will be passed in to the ARM template when the template is executed and that file is specified. If you use a parameter file for each environment that an ARM template will be deployed to, you ensure that the correct parameters are set for that specific environment. You also ensure that you can track the history and maintenance of those parameter values in source control.

## How do I use ARM template parameter files?

ARM template parameter files are JSON files that hold parameter values. For example, for the parameters you've used in the ARM template so far, you could create a template parameter file as follows:

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
      "storagePrefix": {
        "value": "storage"
      },
      "storageSKU": {
        "value": "Standard_LRS"
      },
      "resourceTags": {
        "value": {
          "Environment": "Dev",
          "Project": "Learn"
        }
      }
    }
  }
```

You could then create a file similar to this file for each environment. For example, these files might be called azuredeploy.parameters.dev.json and azuredeploy.parameters.prod.json and hold different values for the parameters.

To deploy an ARM template by using a parameter file, you specify the path to the parameter file in the deployment command. In Azure CLI, you'd use ```--parameters {path to parameter file}```. In PowerShell, you'd use ```-TemplateParameterFile {path to parameter file}```.

# [Azure CLI](#tab/azure-cli)

```azurecli
templateFile="{path-to-the-template-file}"
devParameterFile="{path-to-azuredeploy.parameters.dev.json}"
az group create \
  --name myResourceGroupDev \
  --location "East US"
az deployment group create \
  --name devenvironment \
  --resource-group myResourceGroupDev \
  --template-file $templateFile \
  --parameters $devParameterFile
```

# [PowerShell](#tab/azure-powershell)

```azurepowershell
$templateFile = "{path-to-the-template-file}"
$parameterFile="{path-to-azuredeploy.parameters.dev.json}"
New-AzResourceGroup `
  -Name myResourceGroupDev `
  -Location "East US"
New-AzResourceGroupDeployment `
  -Name devenvironment `
  -ResourceGroupName myResourceGroupDev `
  -TemplateFile $templateFile `
  -TemplateParameterFile $parameterFile
```

---
