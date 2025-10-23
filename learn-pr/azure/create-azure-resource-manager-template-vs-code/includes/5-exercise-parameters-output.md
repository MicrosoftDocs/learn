In this exercise, you add a parameter to define the Azure storage account name during deployment. Then, you add a parameter to define which storage-account SKUs are allowed, and define which one to use for this deployment. You also add usefulness to the Azure Resource Manager template (ARM template) by adding an output that you can use later in the deployment process.

## Create parameters for the ARM template

Here, you make your ARM template more flexible by adding parameters that can be set at runtime. Create a parameter for the ```storageName``` value.

1. In the *azuredeploy.json* file in Visual Studio Code, update ```"parameters":{},```, so it looks like:

    ```json
    "parameters": {
      "storageName": {
        "type": "string",
        "minLength": 3,
        "maxLength": 24,
        "metadata": {
          "description": "The name of the Azure storage resource"
        }
      }
    },
    ```

    To format the JSON file correctly, press <kbd>Alt+Shift+F</kbd>.

1. Use the new parameter in the ```resources``` block in both the ```name``` and ```displayName``` values. The entire file looks like this code example:

   [!code-json[](code/parameter2.json?highlight=5-12,20,22)]

1. Save the file.

### Deploy the parameterized ARM template

Here, you change the name of the deployment to better reflect what this deployment does and fill in a value for the new parameter.

::: zone pivot="cli"

Run the following Azure CLI commands in the terminal. This script is identical to the one you used Previously, except the deployment name has been changed. Enter a unique value for the ```storageName``` parameter. It must be globally unique across Azure, contain 3 to 24 characters, and include only lowercase letters, numbers, and hyphens. You can reuse the unique name you created in the previous unit; if you do, Azure will update the existing resource instead of creating a new one.

```azurecli
templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="addnameparameter-"$today

az deployment group create \
  --name $DeploymentName \
  --template-file $templateFile \
  --parameters storageName={your-unique-name}
```

  ::: zone-end

  ::: zone pivot="powershell"

Run the following Azure PowerShell commands in the terminal. This script is identical to the one you used earlier, except the deployment name has been changed. Enter a unique value for the `storageName` parameter. It must be globally unique across Azure, contain 3 to 24 characters, and include only lowercase letters, numbers, and hyphens. You can reuse the unique name you created in the previous unit; if you do, Azure will update the existing resource instead of creating a new one.

```azurepowershell
$templateFile="azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addnameparameter-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -storageName {your-unique-name}
```

::: zone-end

### Check your deployment

1. When the deployment finishes, go back to the Azure portal in your browser. Go to your resource group, and see that there are now **3 Succeeded** deployments. Select this link.

    Notice that all three deployments are in the list.

1. Explore the *addnameparameter* deployment as you did previously.

### Add another parameter that limits allowed values

Here, you use parameters to limit the values allowed for a parameter.

1. Add a new parameter named ```storageSKU``` to the ```parameters``` section of the *azuredeploy.json* file. 

    ```json
    // This is the allowed values for an Azure storage account
    "storageSKU": {
       "type": "string",
       "defaultValue": "Standard_LRS",
       "allowedValues": [
         "Standard_LRS",
         "Standard_GRS",
         "Standard_RAGRS",
         "Standard_ZRS",
         "Premium_LRS",
         "Premium_ZRS",
         "Standard_GZRS",
         "Standard_RAGZRS"
       ]
     }
    ```

    The first line is a comment. ARM templates support ```//``` and ```/* */``` comments.

1. Update **resources** to use the ```storageSKU``` parameter. If you take advantage of IntelliSense in Visual Studio Code, it makes this step easier.

    ```json
    "sku": {
         "name": "[parameters('storageSKU')]"
       }
    ```

    The entire file looks like this code example:

    [!code-json[](code/parameter3.json?highlight=13-26,41)]

1. Save the file.

### Deploy the ARM template

Here, you deploy successfully by using a ```storageSKU``` parameter that's in the allowed list. Then, you try to deploy the template by using a ```storageSKU``` parameter that isn't in the allowed list. The second deployment fails as expected.

::: zone pivot="cli"

1. Deploy the template by running the following commands. Fill in a unique name for the ```storageName``` parameter. It must be globally unique across Azure, contain 3 to 24 characters, and include only lowercase letters, numbers, and hyphens. You can reuse the unique name you created in the previous unit; if you do, Azure will update the existing resource instead of creating a new one.

    ```azurecli
    templateFile="azuredeploy.json"
    today=$(date +"%d-%b-%Y")
    DeploymentName="addSkuParameter-"$today

    az deployment group create \
      --name $DeploymentName \
      --template-file $templateFile \
      --parameters storageSKU=Standard_GRS storageName={your-unique-name}
    ```

      Allow this deployment to finish. This deployment succeeds as expected. Your list of allowed values, prevents your template's users from passing in parameter values that don't work for the resource. Let's see what happens when you provide an invalid SKU.

1. Run the following commands to deploy the template with a parameter that isn't allowed. Here, you changed the ```storageSKU``` parameter to **Basic**. Fill in a unique name for the ```storageName``` parameter. It must be globally unique across Azure, contain 3 to 24 characters, and include only lowercase letters, numbers, and hyphens. You can reuse the unique name you created in the previous unit; if you do, Azure will update the existing resource instead of creating a new one.

    ```azurecli
    templateFile="azuredeploy.json"
    today=$(date +"%d-%b-%Y")
    DeploymentName="addSkuParameter-"$today

    az deployment group create \
      --name $DeploymentName \
      --template-file $templateFile \
      --parameters storageSKU=Basic storageName={your-unique-name}
    ```

    This deployment fails. Notice the error.

    :::image type="content" source="../media/3-deploy-validation-failed.png" alt-text="Screenshot of the Terminal window showing the deployment validation error." border="true":::

::: zone-end

::: zone pivot="powershell"

1. Deploy the template by running the following commands. Fill in a unique name for the ```storageName``` parameter. It must be globally unique across Azure, contain 3 to 24 characters, and include only lowercase letters, numbers, and hyphens. You can reuse the unique name you created in the previous unit; if you do, Azure will update the existing resource instead of creating a new one.


    ```azurepowershell
    $today=Get-Date -Format "MM-dd-yyyy"
    $deploymentName="addSkuParameter-"+"$today"
    New-AzResourceGroupDeployment `
      -Name $deploymentName `
      -TemplateFile $templateFile `
      -storageName {your-unique-name} `
      -storageSKU Standard_GRS
    ```

      Allow this deployment to finish. This deployment succeeds as expected. Your list of allowed values, prevents your template's users from passing in parameter values that don't work for the resource. Let's see what happens when you provide an invalid SKU.

1. Run the following commands to deploy the template with a parameter that isn't allowed. Here, you changed the ```storageSKU``` parameter to **Basic**. Fill in a unique name for the ```storageName``` parameter. It must be globally unique across Azure, contain 3 to 24 characters, and include only lowercase letters, numbers, and hyphens. You can reuse the unique name you created in the previous unit; if you do, Azure will update the existing resource instead of creating a new one.


    ```azurepowershell
    $today=Get-Date -Format "MM-dd-yyyy"
    $deploymentName="addSkuParameter-"+"$today"
    New-AzResourceGroupDeployment `
      -Name $deploymentName `
      -TemplateFile $templateFile `
      -storageName {your-unique-name} `
      -storageSKU Basic
    ```

    This deployment fails. Notice the error.

    :::image type="content" source="../media/3-deploy-validation-failed.png" alt-text="Screenshot of the Terminal window showing the deployment validation error." border="true":::

::: zone-end

## Add output to the ARM template

Here, you add to the ```outputs``` section of the ARM template to output the endpoints for the storage account resource.

1. In the *azuredeploy.json* file in Visual Studio Code, update ```"outputs":{},``` so it looks like:

    ```json
    "outputs": {
      "storageEndpoint": {
        "type": "object",
        "value": "[reference(parameters('storageName')).primaryEndpoints]"
      }
    }
    ```

1. Save the file.

### Deploy the ARM template with an output

Here, you deploy the template and see the endpoints output as JSON. You need to fill in a unique name for the ```storageName``` parameter. It must be globally unique across Azure, contain 3 to 24 characters, and include only lowercase letters, numbers, and hyphens. You can reuse the unique name you created in the previous unit; if you do, Azure will update the existing resource instead of creating a new one.


::: zone pivot="cli"

1. Deploy the template by running the following commands. Be sure to replace *{your-unique-name}* with a string unique to you.

    ```azurecli
    templateFile="azuredeploy.json"
    today=$(date +"%d-%b-%Y")
    DeploymentName="addoutputs-"$today

    az deployment group create \
      --name $DeploymentName \
      --template-file $templateFile \
      --parameters storageSKU=Standard_LRS storageName={your-unique-name}
    ```

    Notice the output.

    :::image type="content" source="../media/3-add-output-result.png" alt-text="Screenshot of the Terminal window showing the primary endpoints output as JSON." border="true":::

::: zone-end

::: zone pivot="powershell"

1. Deploy the template by running the following commands. Be sure to replace *{your-unique-name}* with a string unique to you.

    ```azurepowershell
    $today=Get-Date -Format "MM-dd-yyyy"
    $deploymentName="addOutputs-"+"$today"
    New-AzResourceGroupDeployment `
      -Name $deploymentName `
      -TemplateFile $templateFile `
      -storageName {your-unique-name} `
      -storageSKU Standard_LRS
    ```

    Notice the output.

    :::image type="content" source="../media/3-add-output-result.png" alt-text="Screenshot of the Terminal window showing the primary endpoints output as JSON." border="true":::

::: zone-end

### Check your output deployment

In the Azure portal, go to your *addOutputs* deployment. You can find your output there as well.

  :::image type="content" source="../media/3-portal-outputs.png" alt-text="Screenshot of the Azure portal showing the output selection in the left menu." border="true":::
