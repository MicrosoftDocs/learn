In the last unit, you created an Azure Resource Manager (ARM) template and added an Azure Storage Account to the ARM template. You may have noticed that there's a problem with your template. The Storage Account name is hard-coded. You can only use this template to deploy the same Storage Account every time. To deploy a storage account with a different name, you would have to create a new template, which isn't a practical way to automate your deployments. The Storage Account SKU is also hard-coded which means you can't vary the type of Storage Account for different environments. Recall that in our scenario each deployment may have a different type of Storage Account. You can make your template more reusable by adding a parameter for the Storage Account SKU.

Here, you learn about the *parameters* and *outputs* sections of the template.

## What are ARM template parameters

ARM template parameters enable you to customize the deployment by providing values that are tailored for a particular environment. For example, you pass in different values based on whether you're deploying to an environment for development, test, production or others. For example, the template above uses the *Standard_LRS* Storage Account SKU. You can reuse this template for other deployments that create a Storage Account by making the name of the Storage Account SKU a parameter. Then, you pass in the name of the SKU you would like for this particular deployment when the template is deployed. You can do this either at the command line, or using a parameter file.

In the parameters section of the template, you specify which values you can input when deploying the resources. You're limited to 256 parameters in a template and parameter definitions can use most template functions.

The available properties for a parameter are:

```json
"parameters": {
  "<parameter-name>" : {
    "type" : "<type-of-parameter-value>",
    "defaultValue": "<default-value-of-parameter>",
    "allowedValues": [ "<array-of-allowed-values>" ],
    "minValue": <minimum-value-for-int>,
    "maxValue": <maximum-value-for-int>,
    "minLength": <minimum-length-for-string-or-array>,
    "maxLength": <maximum-length-for-string-or-array-parameters>,
    "metadata": {
      "description": "<description-of-the parameter>"
    }
  }
}
```

The allowed types of parameters are:

- string
- secureString
- integers
- boolean
- object
- secureObject
- array

### Recommendations for using parameters

It is recommended that you use parameters for settings that vary according to the environment, like SKU, size, or capacity, and for resource names that you want to specify yourself for easy identification or to comply with internal naming conventions. You'll also want to be sure to provide a description for each parameter and use default values whenever possible.

For security reasons, it is important to never hard code or provide default values for usernames and/or passwords in templates. Always use parameters for usernames and passwords (or secrets). Use *secureString* for all passwords and secrets. If you pass sensitive data in a JSON object, use the secureObject type. Template parameters with *secureString* or *secureObject* types can't be read or harvested after the deployment of the resource.

### How do I use parameters in my ARM template

In the parameters section of the ARM template, you specify the parameters that can be input when deploying the resources. You're limited to 256 parameters in a template.

Here is an example of a template file with a parameter for the Storage Account SKU defined in the *parameters* section of the template. Notice that you can provide a default for the parameter to be used if no value is specified at execution.

```json
"parameters": {
   "storageAccountType": {
       "type": "string",
       "defaultValue": "Standard_GRS",
       "metadata": {
           "description": "The type of the new storage account created to store the VM disks."
       }
   }
```

Then, use the parameter in the resource definition. Notice the syntax is ```[parameters('name of the parameter')]```. You use the ```parameters``` function. You learn more about functions in the next module.

```json
"resources": [
     {
       "type": "Microsoft.Storage/storageAccounts",
       "apiVersion": "2019-04-01",
       "name": "learntemplatestorage123",
       "location": "{Location}",
       "sku": {
         "name": "[parameters('storageAccountType')]"
       },
       "kind": "StorageV2",
       "properties": {
         "supportsHttpsTrafficOnly": true
       }
     }
   ]
  }
```

When you deploy the template, you can give a value for the parameter. Notice the last line in the command below.

# [Azure CLI](#tab/azure-cli)

```azurecli
templateFile="azuredeploy.json"
az deployment group create \
  --name testdeployment1 \
  --template-file $templateFile \
  --parameters storageAccountType=Standard_LRS
```

# [PowerShell](#tab/azure-powershell)

```azurepowershell
$templateFile = "azuredeploy.json"
New-AzResourceGroupDeployment `
  -Name testdeployment1 `
  -TemplateFile $templateFile `
  -storageAccountType Standard_LRS
```

---

## What are ARM template outputs

In the *outputs* section of your ARM template, you can specify values that will be returned after a successful deployment. Here are the elements that make up the outputs section.

```json
"outputs": {
   "<output-name>": {
       "condition": "<boolean-value-whether-to-output-value>",
       "type": "<type-of-output-value>",
       "value": "<output-value-expression>",
       "copy": {
           "count": <number-of-iterations>,
           "input": <values-for-the-variable>
       }
   }
}
```

- *output-name*: Must be a valid JavaScript identifier.
- *condition*: (Optional) A boolean value that indicates whether this output value is returned. When true, the value is included in the output for the deployment. When false, the output value is skipped for this deployment. When not specified, the default value is true.
- *type*: The type of the output value.
- *value*: (Optional) A template language expression that is evaluated and returned as output value.
- *copy*: (Optional) Copy is used to return more than one value for an output.

### How do I use outputs in my ARM template

Here is an example to output the Storage Account's endpoints.

```json
 "outputs": {
       "storageEndpoint": {
           "type": "object",
           "value": "[reference('learntemplatestorage123').primaryEndpoints]"
       }
   }
```

Notice the ```reference``` part of the expression. This function gets the runtime state of the Storage Account.

## What happens if I deploy an ARM template again

Recall that ARM templates are idempotent, meaning you can deploy the template to the same environment again and if nothing was changed in the template, nothing will change in the environment. However, if there was a change made to the template, for example, you changed a parameter value, only that change will be deployed. Your template can contain all of the resources you need for your Azure solution and you can safely execute a template again. Resources will only be created if they didn't already exist, and updated only if there is a change.
