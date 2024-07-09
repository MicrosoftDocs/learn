In this exercise, you'll add a parameter to define the Azure storage account name during deployment. You'll then add a parameter to define what storage-account SKUs are allowed, and define which one to use for this deployment. You'll also add usefulness to the Azure Resource Manager template (ARM template) by adding an output that you can use later in the deployment process.

## Create parameters for the ARM template

Here, you'll make your ARM template more flexible by adding parameters that can be set at runtime. Create a parameter for the ```storageName``` value.

1. In the *azuredeploy.json* file in Visual Studio Code, place your cursor inside the braces in the *parameters* attribute. It looks like this: ```"parameters":{},```
1. Select <kbd>Enter</kbd>, and then enter **par**. You see a list of related snippets. Choose **new-parameter**, which adds a generic parameter to the template. It looks like this:

    ```json
     "parameters": {
        "parameter1": {
        "type": "string",
        "metadata": {
            "description": "description"
        }
      }
    },
    ```

1. Change the parameter to from **parameter1** to **storageName** and leave the type as a string. Add a **minLength** value of **3** and a **maxLength** value of **24**. Add a description value of **The name of the Azure storage resource**.
1. The parameter block should look like this:

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

1. Use the new parameter in the ```resources``` block in both the ```name``` and ```displayName``` values. The entire file will look like this:

   [!code-json[](code/parameter2.json?highlight=5-12,18,22)]

1. Save the file.

### Deploy the parameterized ARM template

Here, you'll change the name of the deployment to better reflect what this deployment does and fill in a value for the new parameter.

::: zone pivot="cli"

Run the following Azure CLI commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed. Fill in a unique name for the ```storageName``` parameter. Remember, this name must be unique across all of Azure. You can use the unique name you created in the last unit. In that case, Azure will update the resource instead of creating a new one.

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

Run the following Azure PowerShell commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed. Fill in a unique name for the ```storageName``` parameter. Remember, this name must be unique across all of Azure. You can use the unique name you created in the last unit. In that case, Azure will update the resource instead of creating a new one.

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

### Add another parameter to limit allowed values

Here, you'll use parameters to limit the values allowed for a parameter.

1. Place your cursor after the closing brace for the ```storageName```parameter. Add a comma, and select <kbd>Enter</kbd>.

1. Again, enter **par**, and select **new-parameter**.

1. Change the new generic parameter to the following:

    ```json
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

      Here, you're listing the values that this parameter will allow. If the template runs with a value that isn't allowed, the deployment will fail.

1. Add a comment to this parameter.

    :::image type="content" source="../media/5-add-comments.png" alt-text="Screenshot of the azuredeploy.json file showing the comment This is the allowed values for an Azure storage account in the line preceding the storageSKU parameter." border="true":::

    ARM templates support ```//``` and ```/* */``` comments.

1. Update **resources** to use the ```storageSKU``` parameter. Take advantage of IntelliSense in Visual Studio Code to make this step easier.

    ```json
    "sku": {
         "name": "[parameters('storageSKU')]"
       }
    ```

    The entire file will look like this:

    [!code-json[](code/parameter3.json?highlight=13-26,41)]

1. Save the file.

### Deploy the ARM template

Here, you'll deploy successfully by using a ```storageSKU``` parameter that's in the allowed list. Then, you'll try to deploy the template by using a ```storageSKU``` parameter that isn't in the allowed list. The second deployment will fail as expected.

::: zone pivot="cli"

1. Run the following commands to deploy the template. Fill in a unique name for the ```storageName``` parameter. Remember, this name must be unique across all of Azure. You can use the unique name you created in the last section. In that case, Azure will update the resource instead of creating a new one.

    ```azurecli
    templateFile="azuredeploy.json"
    today=$(date +"%d-%b-%Y")
    DeploymentName="addSkuParameter-"$today

    az deployment group create \
      --name $DeploymentName \
      --template-file $templateFile \
      --parameters storageSKU=Standard_GRS storageName={your-unique-name}
    ```

      Allow this deployment to finish. This deployment succeeds as expected. The allowed values prevent your template's users from passing in parameter values that don't work for the resource. Let's see what happens when you provide an invalid SKU.

1. Run the following commands to deploy the template with a parameter that isn't allowed. Here, you changed the ```storageSKU``` parameter to **Basic**. Fill in a unique name for the ```storageName``` parameter. Remember, this name must be unique across all of Azure. You can use the unique name you created in the last section. In that case, Azure will update the resource instead of creating a new one.

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

1. Run the following commands to deploy the template. Fill in a unique name for the ```storageName``` parameter. Remember, this name must be unique across all of Azure. You can use the unique name you created in the last section. In that case, Azure will update the resource instead of creating a new one.

    ```azurepowershell
    $today=Get-Date -Format "MM-dd-yyyy"
    $deploymentName="addSkuParameter-"+"$today"
    New-AzResourceGroupDeployment `
      -Name $deploymentName `
      -TemplateFile $templateFile `
      -storageName {your-unique-name} `
      -storageSKU Standard_GRS
    ```

      Allow this deployment to finish. This deployment succeeds as expected. The allowed values prevent your template's users from passing in parameter values that don't work for the resource. Let's see what happens when you provide an invalid SKU.

1. Run the following commands to deploy the template with a parameter that isn't allowed. Here, you changed the ```storageSKU``` parameter to **Basic**. Fill in a unique name for the ```storageName``` parameter. Remember, this name must be unique across all of Azure. You can use the unique name you created in the last section. In that case, Azure will update the resource instead of creating a new one.

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

Here, you'll add to the ```outputs``` section of the ARM template to output the endpoints for the storage account resource.

1. In the *azuredeploy.json* file in Visual Studio Code, place your cursor inside the braces in the outputs attribute ```"outputs":{},```.

1. Press <kbd>Enter</kbd>, and then enter *out*. You'll get a list of related snippets. Select **new-output**. It adds a generic output to the template. It will look like this:

    ```json
    "outputs": {
      "output1": {
        "type": "string",
        "value": "value"
      }
    ```

1. Change **"output1"** to **"storageEndpoint"**, then change the value of ```type``` to **"object"**. Change the value of ```value``` to **"[reference(parameters('storageName')).primaryEndpoints]"**. This expression is the one we described in the previous unit that gets the endpoint data. Because we specified *object* as the type, it'll return the object in JSON format.

    ```json
    "outputs": {
      "storageEndpoint": {
        "type": "object",
        "value": "[reference(parameters('storageName')).primaryEndpoints]"
      }
    ```

1. Save the file.

### Deploy the ARM template with an output

Here, you'll deploy the template and see the endpoints output as JSON. You need to fill in a unique name for the ```storageName``` parameter. Remember, this name must be unique across all of Azure. You can use the unique name you created in the last section. In that case, Azure will update the resource instead of creating a new one.

::: zone pivot="cli"

1. Run the following commands to deploy the template. Be sure to replace *{your-unique-name}* with a string unique to you.

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

1. Run the following commands to deploy the template. Be sure to replace *{your-unique-name}* with a string unique to you.

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
