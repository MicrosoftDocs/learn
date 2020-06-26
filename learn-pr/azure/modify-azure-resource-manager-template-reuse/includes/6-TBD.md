There are two features of Azure Resource Manager templates that you will want to use when deploying to more than one environment. These features are tags and parameter files.

As you add more resources to your environments you'll quickly find that you need a way to identify the purpose of these resources. Resources have a ```tags:``` attribute for this purpose. And as you deploy to more environments, you will need an efficient way to keep track of the input parameters. Azure Resource Manager templates can use parameter files to manage parameters for each deployment environment.

## What is a resource tag

You tag resources to add values that help you identify their use. For example, you can add tags that list the environment and the project that resource belongs to. Or, you can add tags that identify a cost center or the team that owns the resource. Add any values that make sense for your organization.

The tag value will be displayed in the overview page for that resource on Azure and in cost reports.

## How do I create a tag

Each resource has a ```tags:``` attribute. So far, you have been using the default ```displayName```.

```json
"tags": {
            "displayName": "[parameters('storageName')]"
        },
```

To make this attribute more useful you can define a parameter that has more information and then use that parameter in the ```tags:``` attribute. For example, you can create a parameter to hold an object called **resourceTags**.

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

Then, you use that parameter for any resource that is for the *Dev* environment and *Inventory* project. For example, your Azure storage account.

```json
"resources": [{
        "name": "[variables('uniqueStorageName')]",
        "type": "Microsoft.Storage/storageAccounts",
        "apiVersion": "2019-06-01",
        "tags": "[parameters('resourceTags')]",
        ...
    }],
```

## What is a parameter file

An Azure Resource Manager parameter file holds values that will be passed in to the Azure Resource Manager template when the template is executed and that file is specified. Using a parameter file for each environment that a template will be deployed to ensures that the correct parameters are set for that specific environment. Also, that the history and maintenance of those parameter values can be tracked in source control.

## How do I use parameter files

Parameter files are JSON files that hold parameter values. For example, for the parameters you have used in the Azure Resource Manager template so far, a template parameter file could be created for each deployment environment as follows.

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

Then, you can create a file similar to this for each environment. For example, these files might be called **azuredeploy.parameters.dev.json** and **azuredeploy.parameters.prod.json** and hold different values for the parameters.

To deploy an Azure Resource Manager template using a parameter file, you specify the path to the file in the deployment command. In Azure CLI it is ```--parameters {path to parameter file}``` and in PowerShell it is ```-TemplateParameterFile {path to parameter file}```.

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

Change the parameter file path when you run the command to deploy to the *Prod* environment.
