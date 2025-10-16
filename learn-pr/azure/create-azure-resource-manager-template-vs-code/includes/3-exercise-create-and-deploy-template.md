In this exercise, you create an Azure Resource Manager (ARM) template, deploy it to Azure, and then update that ARM template to add parameters and outputs.

## Create an ARM template

1. Open Visual Studio Code and create a new file called *azuredeploy.json*.

1. Copy and paste the following code into the file.

    ```json
    {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {},
      "functions": [],
      "variables": {},
      "resources": [],
      "outputs": {}
    }
    ```

    Notice that this file has all of the sections of an ARM template that we described in the previous unit.

1. Save the changes to the file by pressing <kbd>Ctrl+S</kbd>.

## Deploy the ARM template to Azure

::: zone pivot="cli"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have the [Azure CLI](/cli/azure/install-azure-cli) tools installed.

1. Select **Terminal > New Terminal** to open a terminal window.

1. If the command bar of the terminal window says **bash**, you have the right shell to work from and you can skip to the next section.

    1. If not, select the drop-down and choose **Select Default Profile**.
    
          :::image type="content" source="../media/3-bash.png" alt-text="Screenshot of the Visual Studio Code terminal window with bash in the drop-down.":::
    
    1. Select **Git Bash**.
    
          :::image type="content" source="../media/3-select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window showing the select shell drop-down.":::

1. Change directory to the folder containing your ARM template file.

### Sign in to Azure

In the terminal window, run this command to sign in to Azure.

```azurecli
az login
```

In the browser window that opens, sign in to your account. After you sign in, a list of the subscriptions associated with this account displays in the terminal. The default subscription is marked with an asterisk (*). If you have multiple subscriptions, select the subscription you want to use for this exercise.

### Create and set the default resource group

```azurecli
az group create --name <resource-group-name> --location <location>
```

Replace *\<resource-group-name>* with a unique name for your resource group. Replace *\<location>* with the Azure region closest to you. For example, use *eastus* for East US.

By setting the default resource group, you can omit that parameter from the Azure CLI commands in this exercise. To set the resource group, run the following command.

```azurecli
az configure --defaults group="<resource-group-name>"
```

Replace *\<resource-group-name>* with your resource group name.

### Deploy the template to Azure

Run the following commands to deploy the ARM template to Azure. The ARM template doesn't have any resources yet, so there aren't any resources created. You should get a successful deployment.

```azurecli
templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="blanktemplate-"$today

az deployment group create \
 --name $DeploymentName \
 --template-file $templateFile
```

The top section of the preceding code sets the Azure CLI variables, which include the path to the template file to deploy and the name of the deployment. The bottom section,  ```az  deployment group create```, deploys the template to Azure. Notice that the deployment name is `blanktemplate` with the date as a suffix.

You should see ```Running...``` in the terminal.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure that Azure PowerShell Tools are installed from the Visual Studio Code Extensions.

1. In the command bar, select **Terminal > New Terminal** to open a PowerShell window.

1. If the command bar of the terminal window shows **PowerShell**, you have the right shell from which to work, and you can skip to the next section.

      :::image type="content" source="../media/3-pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window with the 'pwsh' terminal selected.":::

    1. If not, select the down arrow and in the dropdown list select PowerShell. If that option is missing, then select **Select Default Profile**.

    1. In the input field, scroll down and select **PowerShell**.

          :::image type="content" source="../media/3-select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window showing the select shell drop-down.":::

1. Change directory to the folder containing your ARM template files.

### Sign in to Azure by using Azure PowerShell

From the terminal in Visual Studio Code, run the following command to sign in to Azure. A browser opens so you can sign in to your account.

  ```azurepowershell
  Connect-AzAccount
  ```

In the browser window that opens (the browser window could be opened behind the current window, minimize the current window to see it), sign in to your account. After you sign in, a list of the subscriptions associated with this account displays in the terminal. The default subscription is marked with an asterisk (*). If you have multiple subscriptions, select the subscription you want to use for this exercise.

### Deploy the template to Azure

```azurepowershell
New-AzResourceGroup -Name <ResourceGroupName> -Location <Location>
```

Replace with a unique name for your resource group. Replace with the Azure region closest to you. For example, use eastus for East US.

By setting the default resource group, you can omit that parameter from the Azure CLI commands in this exercise. To set the resource group, run the following command.

```azurepowershell
Set-AzDefault -ResourceGroupName [sandbox resource group name]
```

replace *[sandbox resource group name]* with your resource group name.

Deploy the template to Azure by running the following commands. The ARM template doesn't have any resources yet, so there aren't any resources created.

```azurepowershell
$templateFile="azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="blanktemplate-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile
```

The top section of the preceding code sets Azure PowerShell variables, which includes the path to the deployment file and the name of the deployment. Then, the ```New-AzResourceGroupDeployment``` command deploys the template to Azure. Notice that the deployment name is `blanktemplate` with the date as a suffix.

::: zone-end

When you deploy your ARM template to Azure, go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. In the resource menu, select **Resource groups**.

1. Select the resource group you created in this exercise.

1. On the **Overview** pane, you see that one deployment succeeded.

    :::image type="content" source="../media/3-deployment-succeeded.png" alt-text="Azure portal interface for the resource group overview with the deployments section showing that one succeeded.":::

1. Select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/3-blanktemplate.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status.":::

1. Select `blanktemplate` to see what resources were deployed. In this case, it's empty because you didn't specify any resources in the template yet.

    :::image type="content" source="../media/3-no-results.png" alt-text="Azure portal interface for the specific deployment with no resources listed.":::

1. Leave the page open in your browser so that you can check on deployments again.

## Add a resource to the ARM template

In the previous task, you learned how to create a blank template and deploy it. Now, you're ready to deploy an actual resource. In this task, you add an Azure storage account resource to the ARM template.

1. In the *azuredeploy.json* file in Visual Studio Code, update the file so it looks like:

    [!code-json[](code/parameter1.json)]

1. Change the values of the resource *name* and *displayName* to something unique (for example, **learnexercise12321**). This name must be globally unique across Azure, contain 3 to 24 characters, and include only lowercase letters, numbers, and hyphens. 

1. The resource location is set to the same location as the resource group where the resource is deployed. Leave the default here.

1. Save the file.

### Deploy the updated ARM template

Here, you change the name of the deployment to better reflect what this deployment does.

::: zone pivot="cli"

Run the following Azure CLI commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed.

```azurecli
templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="addstorage-"$today

az deployment group create \
  --name $DeploymentName \
  --template-file $templateFile
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed.

```azurepowershell
$templateFile="azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addstorage-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile
```

::: zone-end

### Check your deployment

1. When the deployment finishes, go back to the Azure portal in your browser. Go to your resource group, and you see that there are now **2 Succeeded** deployments. Select this link.

    Notice that both deployments are in the list.

    :::image type="content" source="../media/3-addstorage-deployment.png" alt-text="Screenshot of the Azure portal interface for the deployments with the two deployments listed and succeeded statuses.":::

1. Select **addstorage**.

    :::image type="content" source="../media/3-show-resource-deployed.png" alt-text="Screenshot of the Azure portal interface for the specific deployment with one resource listed." :::

Notice that the storage account is deployed.
