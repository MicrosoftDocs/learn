In the last exercise, you created an Azure Resource Manager template and added an Azure storage account to the template. Recall that in our scenario each deployment may have a different type of Azure storage account. You can make your template more flexible and reusable by adding a parameter for the Azure storage accoung SKU.

Here, you delve into detail on the *parameters* and *outputs* sections of the template.

## What are template parameters

Parameters enable you to customize the deployment by providing values that are tailored for a particular environment. For example, you pass in different values based on whether you're deploying to an environment for development, test, production or others. For example, the template above uses the *Standard_LRS* SKU. You can reuse this template for other deployments that create a storage account by making the name of the SKU a parameter. Then, you pass in the name of the SKU you would like for this particular deployment when the template is executed. You can do this either at the command line, or using a parameter file.

### How do I use parameters in my template

Here is an example of a template file with a parameter for the storage SKU defined in the *parameters* section of the template. Notice that you can provide a default for the parameter to be used if no value is specified at execution.

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

Then, use the parameter in the resource definition. Notice the syntax is ```[parameters('name of the parameter')]```

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

When you execute the template, you can give a value for the parameter. Notice the last line in the command below.

```azurecli
templateFile="azuredeploy.json"
az deployment group create \
  --name testdeployment1 \
  --template-file $templateFile \
  --parameters storageAccountType=Standard_LRS
```

## What are template outputs

In the *outputs* section of your template, you can specify values that will be returned after a successful deployment. Here are the elements that make up the outputs section.

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

### How do I use outputs in my template

Here is an example to output the Azure storage account's endpoints.

```json
 "outputs": {
       "storageEndpoint": {
           "type": "object",
           "value": "[reference(learntemplatestorage123).primaryEndpoints]"
       }
   }
```

Notice the ```reference``` part of the expression. This function gets the runtime state of the storage account.

