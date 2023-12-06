Now that you've used a deployment script to migrate some manual work into your Azure Resource Manager (ARM) template, another partner application team in your organization has asked for some help.

The team's process has similar requirements, but the team needs to deploy multiple files to its storage account. The team has a PowerShell script that can take a list of files as a parameter and upload them, similar to the script that you were already using in your template.

In this exercise, you'll take your previous template as a starting point and update the PowerShell script to use the one from your partner team. Then, you'll add a way to enable the person who's deploying the template to specify what configuration files to deploy (one or more).

During the process, you'll:

> [!div class="checklist"]
> * Update the deployment script.
> * Add an environment variable and template parameter, and pass these to your deployment script.
> * Add an output to the deployment script.
> * Add a parameters file.
> * Deploy the template, and verify the outcome.

## Create the starting template

You start with the template that you created in the last exercise.

::: zone pivot="jsoncli,jsonpowershell"

1. Open Visual Studio Code, and create a new file called *azuredeploy.json*.

1. Copy the following starting template into *azuredeploy.json*.

    :::code language="json" source="code/3-template-with-deploymentscript.json" :::

1. Save the template.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

1. Open Visual Studio Code, and create a new file called *main.bicep*.

1. Copy the following starting template into *main.bicep*.

    :::code language="bicep" source="code/3-template-with-deploymentscript.bicep" :::

1. Save the template.

::: zone-end

## Update the PowerShell script

Because the other team has done the hard work in creating a PowerShell script to copy multiple files, you decide to use that script in your template.

Edit `scriptContent` in the `properties` section to include the script that your partner team has provided.

::: zone pivot="jsoncli,jsonpowershell"

:::code language="powershell" source="code/5-template-with-deploymentscript-parameters.json" range="122-136" :::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

:::code language="powershell" source="code/5-template-with-deploymentscript-parameters.bicep" range="91-105" :::

::: zone-end

## Add an environment variable

::: zone pivot="jsoncli,jsonpowershell"

The script you've adopted requires some environment variables. You can specify them directly in the template, but it'll be more flexible to use template functions to get some of the values.

1. Add an `environmentVariables` property to the `properties` section of the deployment script.

    :::code language="json" source="code/5-template-with-deploymentscript-parameters.json" range="106,119" :::

1. Add an environment variable for `ResourceGroupName`.

    :::code language="json" source="code/5-template-with-deploymentscript-parameters.json" range="106-109, 118-119" highlight="2-5" :::

1. Add an environment variable for `StorageAccountName`.

    :::code language="json" source="code/5-template-with-deploymentscript-parameters.json" range="106-113, 118-119" highlight="6-9":::

1. Add an environment variable for `StorageContainerName`.

    :::code language="json" source="code/5-template-with-deploymentscript-parameters.json" range="106-119" highlight="10-13":::

> [!TIP]
> Use [template functions](/azure/azure-resource-manager/templates/template-functions-resource) to access common values like `[resourceGroup().name]` and `[variables()]`.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

The script you've adopted requires some environment variables. You can specify them directly in the template, but it'll be more flexible to use Bicep variables to get some of the values.

1. Add an `environmentVariables` property to the `properties` section of the deployment script.

    :::code language="bicep" source="code/5-template-with-deploymentscript-parameters.bicep" range="75, 88" :::

1. Add an environment variable for `ResourceGroupName`.

    :::code language="bicep" source="code/5-template-with-deploymentscript-parameters.bicep" range="75-79, 88" highlight="2-5" :::

1. Add an environment variable for `StorageAccountName`.

    :::code language="bicep" source="code/5-template-with-deploymentscript-parameters.bicep" range="75-83, 88" highlight="6-9":::

1. Add an environment variable for `StorageContainerName`.

    :::code language="bicep" source="code/5-template-with-deploymentscript-parameters.bicep" range="75-88" highlight="10-13":::

::: zone-end

## Add a template parameter

To make your template easier for the two teams to use, you can add a parameter to the template so that each team can specify the files that it wants to copy.

::: zone pivot="jsoncli,jsonpowershell"

Add a parameter to the template to take an array of filenames.

:::code language="json" source="code/5-template-with-deploymentscript-parameters.json" range="5-7, 9-13" :::

As a bonus, you can supply a default value so the template will continue to work for your team with no changes to the deployment process. Although not required, entering a new default value can help you understand the pattern of making it easier for teams to adopt new versions of templates if they continue to behave as they've previously done, with the new functionality being the reward. In other words, this step shows you how to maintain the existing behavior while making the changes to support future work.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

Add a parameter to the template to take an array of filenames.

```bicep
@description('List of files to copy to application storage account.')
param filesToCopy array
```

As a bonus, you can supply a default value so the template will continue to work for your team with no changes to the deployment process. Although not required, entering a new default value can help you understand the pattern of making it easier for teams to adopt new versions of templates if they continue to behave as they've previously done, with the new functionality being the reward. In other words, this step shows you how to maintain the existing behavior while making the changes to support future work.

::: zone-end

## Add an argument to pass in the files to copy

::: zone pivot="jsoncli,jsonpowershell"

Next, you can take the parameter that you just defined and pass it in to the deployment script. Passing command-line arguments can be tricky, because the strings are evaluated at multiple levels. Properly escaping quotes and picking the right quotes for the job are essential for success.

> [!TIP]
> Use [template functions](/azure/azure-resource-manager/templates/template-functions-resource) to access common functions like `[string()]` to convert values of one type to a string.

1. Add an `arguments` property to the deployment script.  The PowerShell script takes a parameter named `File`, which is a string of filenames that should come from the `filesToCopy` template parameter. Make sure there are quotes around the whole argument so it gets passed in properly.

    > [!CAUTION]
    > This `arguments` property is invalid. If you're using the Azure Resource Manager extension in Visual Studio Code, it might flag this line. You'll fix this problem in the next steps.

    ```json
    "arguments": "[concat( '-File '', string(parameters('filesToCopy')), ''' )]",
    ```

    > [!TIP]
    > Quoting things in JSON can be hard, especially when you're passing in command-line arguments. You can use a template variable to represent a character that's hard to escape.

1. Add a template variable to represent the single-quote character.

    :::code language="json" source="code/5-template-with-deploymentscript-parameters.json" range="14-22" highlight="2" :::

1. Replace the single quotes in the `arguments` property with the variable that you just defined.

    :::code language="json" source="code/5-template-with-deploymentscript-parameters.json" range="105" :::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

Next, you can take the parameter that you just defined and pass it in to the deployment script. Passing command-line arguments can be tricky, because the strings are evaluated at multiple levels. Properly escaping quotes and picking the right quotes for the job are essential for success.

Add an `arguments` property to the deployment script. The PowerShell script takes a parameter named `File`, which is a string of filenames that should come from the `filesToCopy` template parameter.

:::code language="bicep" source="code/5-template-with-deploymentscript-parameters.bicep" range="74" :::

Notice this uses several Bicep features:

* String interpolation, to combine the strings.
* We use the `\` escape character to allow us to include a single quote character (`'`) inside the string, because a single quote is normally a reserved character in Bicep.
* We use the `string()` function to convert the `filesToCopy` array to a string.

::: zone-end

## Update the template output

Because you're changing the deployment script to deploy one or more files, you need to update the template output to provide all the necessary information.

::: zone pivot="jsoncli,jsonpowershell"

1. Update the `outputs` in the template to return the whole object, which will have a URI per file.

    :::code language="json" source="code/5-template-with-deploymentscript-parameters.json" range="126-135" highlight="3-4" :::

1. Add another output with the storage account name (which has a random identifier). You'll use this later to validate that the deployment script did what you expected.

    :::code language="json" source="code/5-template-with-deploymentscript-parameters.json" range="126-135" highlight="6-9" :::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

1. Update the outputs in the template to return the whole object, which will have a URI per file.

    :::code language="bicep" source="code/5-template-with-deploymentscript-parameters.bicep" range="115" :::

1. Add another output with the storage account name (which has a random identifier). You'll use this later to validate that the deployment script did what you expected.

    :::code language="bicep" source="code/5-template-with-deploymentscript-parameters.bicep" range="116" :::

::: zone-end

## Verify your template

Your template should look similar to:

::: zone pivot="jsoncli,jsonpowershell"

:::code language="json" source="code/5-template-with-deploymentscript-parameters.json" :::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

:::code language="bicep" source="code/5-template-with-deploymentscript-parameters.bicep" highlight="1-4, 74-88, 91-105, 115-116" :::

::: zone-end

If it doesn't, either copy the example or adjust your template to match the example.

### Create a parameters file

Now that you've got the template set, you can validate the new deployment script by using a parameters file with new files specified.

::: zone pivot="jsoncli,jsonpowershell"

1. Either create an *azuredeploy.parameters.json* file manually or use [the VS Code extension](/azure/azure-resource-manager/templates/quickstart-create-templates-use-visual-studio-code?tabs=CLI#create-a-parameter-file) to do so.

1. Edit the file to have two `filesToCopy` specified:

   :::code language="json" source="code/5-parameters.json" :::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

1. Create an *azuredeploy.parameters.json* file.

1. Edit the file to have two `filesToCopy` specified:

   :::code language="json" source="code/5-parameters.json" :::

::: zone-end

## Deploy the template

### Create a resource group for the exercise

You need to create a resource group to contain the resources that you'll create as part of this exercise. By using a new resource group, you'll make cleaning up after the exercise much easier.

From the terminal in Visual Studio Code, run this command to create the resource group for this exercise.

::: zone pivot="jsoncli,bicepcli"

```azurecli
resourceGroupName="learndeploymentscript_exercise_2"
az group create --location eastus --name $resourceGroupName
```

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

```azurepowershell
$resourceGroupName = 'learndeploymentscript_exercise_2'
New-AzResourceGroup -Location eastus -Name $resourceGroupName
```

::: zone-end

::: zone pivot="jsoncli"

### Deploy the template to Azure

Deploy the template by using Azure CLI commands in the Visual Studio Code terminal.

```azurecli
templateFile="azuredeploy.json"
templateParameterFile="azuredeploy.parameters.json"
today=$(date +"%d-%b-%Y")
deploymentName="deploymentscript-"$today

az deployment group create \
    --resource-group $resourceGroupName \
    --name $deploymentName \
    --template-file $templateFile \
    --parameters $templateParameterFile
```

::: zone-end

::: zone pivot="jsonpowershell"

### Deploy the template to Azure

Deploy the template by using Azure PowerShell commands in the terminal.

```azurepowershell
$templateFile = 'azuredeploy.json'
$templateParameterFile = 'azuredeploy.parameters.json'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "deploymentscript-$today"

New-AzResourceGroupDeployment `
    -ResourceGroupName $resourceGroupName `
    -Name $deploymentName `
    -TemplateFile $templateFile `
    -TemplateParameterFile $templateParameterFile
```

::: zone-end

::: zone pivot="bicepcli"

### Deploy the template to Azure

Deploy the template by using Azure CLI commands in the Visual Studio Code terminal.

```azurecli
templateFile="main.bicep"
templateParameterFile="azuredeploy.parameters.json"
today=$(date +"%d-%b-%Y")
deploymentName="deploymentscript-"$today

az deployment group create \
    --resource-group $resourceGroupName \
    --name $deploymentName \
    --template-file $templateFile \
    --parameters $templateParameterFile
```

::: zone-end

::: zone pivot="biceppowershell"

### Deploy the template to Azure

Deploy the template by using Azure PowerShell commands in the terminal.

```azurepowershell
$templateFile = 'main.bicep'
$templateParameterFile = 'azuredeploy.parameters.json'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "deploymentscript-$today"

New-AzResourceGroupDeployment `
    -ResourceGroupName $resourceGroupName `
    -Name $deploymentName `
    -TemplateFile $templateFile `
    -TemplateParameterFile $templateParameterFile
```

::: zone-end

### Review the result of your template

After the deployment is complete, you can validate that both files were copied to your storage account by listing the contents of the blob container.

::: zone pivot="jsoncli,bicepcli"

1. List the contents of the blob container.

    ```azurecli
    storageAccountName=$(az deployment group show --resource-group $resourceGroupName --name $deploymentName --query 'properties.outputs.storageAccountName.value' --output tsv)
    az storage blob list --account-name $storageAccountName --container-name config --query '[].name'
    ```

    The command returns the following code:

    ```json
    [
      "swagger.Staging.json",
      "appsettings.Staging.json"
    ]
    ```

1. You can also review the logs (and other details about the deployment) from the Azure portal or by using the following command.

    ```azurecli
    az deployment-scripts show-log --resource-group $resourceGroupName --name CopyConfigScript
    ```

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

1. List the contents of the blob container.

    ```azurepowershell
    $storageAccountName = (Get-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name $deploymentName).Outputs.storageAccountName.Value
    $storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName
    Get-AzStorageBlob -Context $storageAccount.Context -Container config |
        Select-Object Name
    ```

    The command returns the following code:

    ```
    Name
    ----
    swagger.Staging.json
    appsettings.Staging.json
    ```

1. You can also review the logs (and other details about the deployment) from the Azure portal or by using the following command.

    ```azurepowershell
    Get-AzDeploymentScriptLog -ResourceGroupName $resourceGroupName -Name CopyConfigScript
    ```

::: zone-end

### Clean up the resource group

You've successfully deployed an ARM template with a deployment script and used different methods to pass data in to customize its behavior. You can remove the resource group that contains all the resources and role assignments you've created.

::: zone pivot="jsoncli,bicepcli"

```azurecli
az group delete --name $resourceGroupName
```

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

```azurepowershell
Remove-AzResourceGroup -Name $resourceGroupName
```

::: zone-end
