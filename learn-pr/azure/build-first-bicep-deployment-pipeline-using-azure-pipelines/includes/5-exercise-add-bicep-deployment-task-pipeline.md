Now that you have a basic pipeline, you want to use it to deploy your website's Bicep file to Azure.

In this exercise, you'll:

> [!div class="checklist"]
> * Add a Bicep file to your repository.
> * Create a resource group for your website.
> * Create a service principal and grant it access to the resource group.
> * Create a service connection and configure it with the service principal's credentials.
> * Add a pipeline step to deploy your Bicep file.
> * Execute your pipeline.
> * Verify that the pipeline runs successfully.

This exercise requires that you have permission to create applications and service principals in your Azure Active Directory (Azure AD) directory. If you can't meet this requirement with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant.

## Sign in to Azure

::: zone pivot="cli"

To work with service principals in Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli) tools.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. If the dropdown control at the right displays **bash**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../../includes/media/bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with bash displayed in the dropdown control." border="true":::

    If **bash** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **bash**.

    :::image type="content" source="../../includes/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, displaying the dropdown list for selecting a preferred terminal shell." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with Bash as the shell.

[!INCLUDE [Upgrade Azure CLI](../../includes/azure-template-bicep-exercise-upgrade-cli.md)]

### Sign in to Azure by using the Azure CLI

1. In the Visual Studio Code terminal, sign in to Azure by running the following command: 

    ```azurecli
    az login
    ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps), and sign in to the same account that activated the sandbox.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. If the dropdown control at the right displays **pwsh** or **PowerShell**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../../includes/media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with 'pwsh' displayed in the dropdown control." border="true":::

   If **pwsh** or **PowerShell** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **pwsh** or **PowerShell**.   

    :::image type="content" source="../../includes/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, displaying the dropdown list for selecting your preferred terminal shell." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with **pwsh** or **PowerShell** as the shell.

[!INCLUDE [Upgrade Azure PowerShell](../../includes/azure-template-bicep-exercise-upgrade-powershell.md)]

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, sign in to Azure by running the following command:

    ```azurepowershell
    Connect-AzAccount
    ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a resource group in Azure

::: zone pivot="cli"

Run this Azure CLI command in the Visual Studio Code terminal to create a new resource group:

```azurecli
az group create --name ToyWebsite --location westus
```

::: zone-end

::: zone pivot="powershell"

Run this Azure PowerShell commands in the Visual Studio Code terminal to create a resource group:

```azurepowershell
New-AzResourceGroup -Name ToyWebsite -Location westus
```

::: zone-end

## Create a service principal and grant it access to the resource group

::: zone pivot="cli"

1. Run this Azure CLI command in the Visual Studio Code terminal to create a service principal:

   ```azurecli
   az ad sp create-for-rbac \
     --name ToyWebsitePipeline \
     --role Contributor \
     --scopes TODO-RGID
   ```

1. Look at the JSON output from the previous command. It includes the following properties:
 
   - `appId`: The service principal's application ID.
   - `password`: The service principal's key.
   - `tenant`: Your Azure AD tenant ID.

   TODO need sub ID and sub name

   Copy these values somewhere safe. You'll use them soon. 

::: zone-end

::: zone pivot="powershell"

1. Run these Azure PowerShell commands in the Visual Studio Code terminal to create a service principal:

   ```azurepowershell
   $servicePrincipal = New-AzADServicePrincipal `
     -DisplayName ToyWebsitePipeline `
     -Role Contributor `
     -Scope TODO-RGID

   $plaintextSecret = [System.Net.NetworkCredential]::new('', $servicePrincipal.Secret).Password
   ```

1. Run the following command to show the service principal's application ID, the key, and your Azure AD tenant ID:

   ```azurepowershell
   Write-Output "Service principal application ID: $($servicePrincipal.ApplicationId)"
   Write-Output "Service principal key: $($plaintextSecret)"
   Write-Output "Azure subscription ID: $((Get-AzContext).Subscription.Id)"
   Write-Output "Azure subscription name: $((Get-AzContext).Subscription.Name)"
   Write-Output "Azure AD tenant ID: $((Get-AzContext).Tenant.Id)"
   ```

   Copy the values somewhere safe. You'll use them soon.

::: zone-end

## Create a service connection in Azure Pipelines

Now that you've created the resource group and service principal, you create a service connection in Azure Pipelines.

1. In your browser, select **Project settings**.

   TODO ss

1. Select **Service connections**.

   TODO ss

1. Select **Create service connection**.

   TODO SS

1. Select **Azure Resource Manager** and select **Next**.

   TODO SS

1. Select **Service principal (manual)** and select **Next**.

   TODO SS

   > [!NOTE]
   > It's a good idea to manually create service principals like you're doing here, rather than using the automatic service principal creation in Azure Pipelines. This is because, when Azure Pipelines creates a service principal for you, it grants it permissions to your whole subscription. It's more secure to grant permissions at a narrower scope like a resource group, and that requires you use the manual creation process.

1. Enter the subscription ID and subscription name that you saved earlier.

   TODO SS

1. In **Service principal ID**, enter the service principal's application ID that you saved earlier.

   TODO SS

1. In **Service principal key**, enter the service principal's key that you saved earlier.

1. In **Tenant ID**, enter the Azure tenant ID that you saved earlier.

1. Select the **Verify** button.

   TODO SS

   Azure Pipelines verifies it can access your Azure subscription.

1. In **Service connection name**, enter _ToyWebsite_.

   Leave **Grant access permission to all pipelines** checked.

1. Select **Verify and save**.

<!-- TODO below -->

## Add your website's Bicep file to the repository

1. In Visual Studio Code, in the _deploy_ folder, create a new file named _main.bicep_.

1. Copy the following into the _main.bicep_ file:

   :::code language="bicep" source="code/5-main.bicep" :::

1. Save the file.

1. In the Visual Studio Code **Terminal**, stage the changes, commit the changes and push the changes to your repository by using the following commands:

   ```bash
   git add -A
   git commit -m 'Add Bicep file'
   git push
   ```

##  Replace the existing tasks in the pipeline by a task that will deploy your Bicep template

You will now update your YAML pipeline to include tasks to deploy the bicep template to Azure using your service connection. 

1. Open your Visual Studio Code and open the azure-pipelines.yml file. 

<TODO: Insert image>

1. Remove all script steps that are already present. 
1. Add a task step. Type: -task: 
1. If a context menu does not appear, type Ctrl + space, this shows a context menu of available tasks.

<TODO: Insert image>

> [!Note]
> While working in Visual Studio Code the Ctrl + Space key combination is a handy one to bring up a context menu of suggestions at all times at the place where your cursor is. 

> [!Note]
> Keep an eye on indentation. If your indentation is off, your YAML file will not be correct. Visual Studio Code will also indicate faulty indication by means of squigly lines. 

1. Start typing `AzureCLI@2`, the context menu will filter down the entries based on the text you type. You can use the arrow keys to choose this task from the context menu and insert it by pressing `Enter`. 

<TODO: Insert image>

1. Add the following statements underneath the task. Be sure to have input at the same indentation level as task. You will notive that the task is already making use of variables. We will define these variables at a later step in the pipeline UI. 

```YAML
inputs:
  azureSubscription: $(serviceConnection)
  scriptType: 'bash'
  scriptLocation: 'inlineScript'
  inlineScript: 'az deployment group create --resource-group $(resourcegroup) --template-file deploy/main.bicep -n $(Build.BuildId) -p environmentType=$(environment)'
```

> [!Note]
> Notice that in the task we also add the extra system variable Build.BuildId for the name of the deployment. 

TODO mention the az bicep upgrade thing

1. Your resulting YAML file should look like this: 

```YAML
trigger: none

pool:
  vmImage: ubuntu-latest

jobs:
- job: 
  steps:
  - task: AzureCLI@2
    inputs:
      azureSubscription: $(serviceConnection)
      scriptType: 'bash'
      scriptLocation: 'inlineScript'
      inlineScript: 'az deployment group create --resource-group $(resourcegroup) --template-file deploy/main.bicep -n $(Build.BuildId) -p environmentType=$(environment)'
```

1. Save your YAML pipeline file.
1. Add your changes, commit and push them to your repository. 

```cmd
git add -A
git commit -m 'Added Azure CLI task'
git push
```

1. Go back to your project in Azure DevOps in the browser and navigate to `Pipelines`. 

<TODO: Insert image>

1. Select your pipeline.

<TODO: Insert image>

1. Click the `Edit` button. 

<TODO: Insert image>

1. On the top right, click the `Variables` button. 

<TODO: Insert image>

1. Click the `+` button. 

<TODO: Insert image>

1. Fill out `serviceConnection` for the `Name` and `Toywebsite` for the `Value`. 

<TODO: Insert image>

1. Click the `Ok` button.

<TODO: Insert image>

1. In the same way create the `resourcegroup` variable with a value of `ToyWebsite`.

<TODO: Insert image>

1. Also create an `environment` variable with a value of `Test`. For this variable check the checkbox to `Let users override this value when running this pipeline`.

<TODO: Insert image>

1. When you created all 3 variables, click the `Save` button.

<TODO: Insert image>


## Run your pipeline

1. Now that you created your variables and while you are still on the pipeline edit screen in Azure Devops, on the top right, click the `Run pipeline` button.

<TODO: Insert image>

1. In the Run pipeline flyout, expand the variables.

<TODO: Insert image>

1. Select the `environment` variable.

<TODO: Insert image>

1. Give it a new value of `Production`. 

<TODO: Insert image>

1. Click the `Update` button.

<TODO: Insert image>

1. Click the `<-` back arrow.

<TODO: Insert image>

1. Click the `Run` button to start a new pipeline run.

<TODO: Insert image>

1. Click on the `Job` to see its details. 

<TODO: Insert image>

1. On the `Job`, click open the `fx 3 queue time variables used`. This should show the 2 values for resourcegroup and serviceConnection as your set them up in the overall variable definitions. For environment it will show Production as you indicated this value for this specific run. 

<TODO: Insert image>

1. Also inspect the rest of your pipeline output. This should succeed. 

<TODO: Insert image>

1. Navigate to the resource group you created in the Azure portal and verify that your resources got deployed.

<TODO: Insert image>

1. Select the App Service Plan in the resource group.

<TODO: Insert image>

1.  Since you deployed the Production environmentType of the Bicep template, this will be a Standard 1 plan running 2 instances. 

<TODO: Insert image>

1. Navigate back to your resource group in the Azure portal. 

<TODO: Insert image>

1. Select the `Deployments` menu. You will notice that a new deployment was added, with as name your build ID.

<TODO: Insert image>

