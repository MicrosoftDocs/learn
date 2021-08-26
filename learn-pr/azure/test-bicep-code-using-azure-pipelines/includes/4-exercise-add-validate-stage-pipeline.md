You want to further automate your deployment and build better confidence in what you deploy by adding a validation stages to your pipeline. 

During the process you will: 

- Start from an existing Azure DevOps project.
- Update the existing pipeline to make use of a service principal and service connection for your environment.
- Update the existing pipeline with a _Validate_ stages. 
- Run your pipeline and watch validation fail. 
- Fix the error in your Bicep template.
- Watch your pipeline execution succeed. 


## Create a project in Azure DevOps

1. In a browser, go to [dev.azure.com](https://dev.azure.com?azure-portal=true). Sign in or create a new account.

1. If you created a new account, follow the prompts to create an Azure DevOps organization. Azure DevOps then prompts you to create a new project. Continue to the next step to set up the project.

    If you signed in to an existing Azure DevOps organization, select **New project** to create a new project.

    :::image type="content" source="../../includes/media/azure-devops-create-project.png" alt-text="Screenshot of Azure DevOps that shows the button to create a new project.":::

1. Enter the details of your new project:

    * **Project name**: Use a meaningful but short name. For this exercise, enter **toy-website**.
    * **Visibility**: You can use Azure DevOps to create public and private repositories. You create a private repository because your toy company website files should be accessed only by people inside your organization. You can grant access to other users later.

    When you're finished, your project configuration should look like this example:

    :::image type="content" source="../../includes/media/azure-devops-new-project-details.png" alt-text="Screenshot of Azure DevOps that shows the configuration for the project to create.":::

1. Select **Create project**.

1. On the project page, in the left menu, select **Repos**.

    :::image type="content" source="../../includes/media/azure-devops-repos-menu.png" alt-text="Screenshot of Azure DevOps that shows the menu, with the Repos menu item highlighted.":::

## Generate a Git password (macOS)

When you work with Azure Repos in Visual Studio Code on macOS, you use a special password that's different from the password you use to sign in.

> [!NOTE]
> If you're using Windows, skip to the next section, *Clone the repository*.

1. On a computer running macOS, in Azure DevOps, select **Generate Git credentials**.

    Azure Repos creates a random password for you to use.

1. Copy the **Password** value somewhere safe. You'll use the password in the next section.

## Clone the repository

In Visual Studio Code, clone your repository.

1. In **Clone to your computer**, select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

    :::image type="content" source="../media/3-clone-visual-studio-code.png" alt-text="Screenshot of Azure DevOps that shows the repository settings, with the Clone in VS Code button highlighted.":::

1. Create a folder to use for the repository, and then choose **Select Repository Location**.

1. You're using this repository for the first time, so you're prompted to sign in.

    If you're using Windows, enter the same credentials you used to sign in to Azure DevOps earlier in this exercise.

    If you're using macOS, paste the password that you generated earlier in this exercise.

1. Visual Studio Code prompts you to open the repository. Select **Open**.

    :::image type="content" source="../media/3-open-cloned-repo.png" alt-text="Screenshot of Visual Studio Code that shows a prompt to open the cloned repository, with the Open button highlighted.":::

## Install the Azure Pipelines extension

Microsoft publishes an Azure Pipelines extension for Visual Studio Code. The extension can help you write pipeline YAML files. It's a good idea to install this extension, so your YAML files are validated as you work.

1. In Visual Studio Code, select **View** > **Extensions**.

1. In **Search**, enter **Azure Pipelines**, and then find the Azure Pipelines extension published by Microsoft. Select **Install**.

    :::image type="content" source="../media/3-visual-studio-code-extension.png" alt-text="Screenshot of the Visual Studio Code Extensions, with the search field displaying 'Azure Pipelines' and the Install button for the Microsoft Azure Pipelines extension highlighted.":::

## Create a YAML pipeline definition

Now that you've created your organization, project, and repository, you're ready to create a basic pipeline definition.

1. In Visual Studio Code, open the Explorer.

1. At the root of your current folder structure, create a new folder named *deploy*.

1. In the *deploy* folder, create a new file named *azure-pipelines.yml*.

    :::image type="content" source="../media/3-visual-studio-code-pipeline-file.png" alt-text="Screenshot of the Visual Studio Code Explorer, with the deploy folder and the azure-pipelines dot Y M L file shown.":::

1. Copy the following pipeline definition into the file:

    :::code language="yaml" source="code/3-pipeline.yml":::

1. To open the Visual Studio Code terminal window, select **Terminal** > **New Terminal**. The window usually opens at the bottom of your screen.

1. To commit and push the *azure-pipelines.yml* file to your Git repository, run this code:

    ```bash
    git add deploy/azure-pipelines.yml
    git commit -m "Add initial pipeline definition"
    git push
    ```

## Set up the pipeline in Azure Pipelines

You've created a pipeline definition. Next, register the pipeline with Azure Pipelines.

1. In Azure DevOps in your browser, select **Pipelines** > **Create Pipeline**.

    :::image type="content" source="../media/3-create-pipeline.png" alt-text="Screenshot of Azure DevOps that shows the Pipelines page and the Create Pipeline button highlighted.":::

1. Select **Azure Repos Git**.

    :::image type="content" source="../media/3-create-pipeline-repo-type.png" alt-text="Screenshot of Azure DevOps that shows the Create Pipeline flow's Connect step, with the Azure Repos Git option selected.":::

1. Select **toy-website**.

    :::image type="content" source="../media/3-create-pipeline-repo.png" alt-text="Screenshot of Azure DevOps that shows the Create Pipeline flow's Select step, with the toy-website repository selected.":::

1. Select **Existing Azure Pipelines YAML file**.

    :::image type="content" source="../media/3-create-pipeline-configure.png" alt-text="Screenshot of Azure DevOps that shows the Create Pipeline flow's Configure step, with the Existing Azure Pipelines YAML File option selected.":::

1. In **Path**, select */deploy/azure-pipelines.yml*. Then, select **Continue**.

    :::image type="content" source="../media/3-create-pipeline-yaml-file.png" alt-text="Screenshot of the Azure DevOps 'Select an existing YAML file' pane, with Path set to the pipeline file and the Continue button highlighted.":::

    Your YAML pipeline definition is shown.

    > [!TIP]
    > The Azure Pipelines web interface provides an editor that you can use to manage your pipeline definition. In this module, you work with the definition file in Visual Studio Code, but you can explore the Azure Pipelines editor to see how it works.

1. TODO select Save

## Sign in to Azure

::: zone pivot="cli"

To work with service principals in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true) tools.

1. To open a Visual Studio Code terminal window, select **Terminal** > **New Terminal**. The window usually opens at the bottom of your screen.

1. If the dropdown control on the right displays **bash**, the correct shell is open and you can skip to the next section.

   :::image type="content" source="../../includes/media/bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with bash displayed in the dropdown control.":::

   If **bash** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **bash**.

   :::image type="content" source="../../includes/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window that displays the dropdown list for selecting a preferred terminal shell.":::

1. In the terminal, select the plus sign (**+**) to create a new terminal with Bash as the shell.

[!INCLUDE [Upgrade Azure CLI](../../includes/azure-template-bicep-exercise-upgrade-cli.md)]

### Sign in to Azure by using the Azure CLI

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurecli
   az login
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true), and sign in to the same account that you used to activate the sandbox.

1. To open a Visual Studio Code terminal window, select **Terminal** > **New Terminal**. The window usually opens at the bottom of your screen.

1. If the dropdown control at the right displays **pwsh** or **PowerShell**, the correct shell is open and you can skip to the next section.

   :::image type="content" source="../../includes/media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with 'pwsh' displayed in the dropdown control.":::

   If **pwsh** or **PowerShell** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **pwsh** or **PowerShell**.

   :::image type="content" source="../../includes/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window that displays the dropdown list for selecting your preferred terminal shell.":::

1. In the terminal, select the plus sign (**+**) to create a new terminal with pwsh or PowerShell as the shell.

[!INCLUDE [Upgrade Azure PowerShell](../../includes/azure-template-bicep-exercise-upgrade-powershell.md)]

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurepowershell
   Connect-AzAccount
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a resource group in Azure

::: zone pivot="cli"

1. To create a new resource group, run this Azure CLI command in the Visual Studio Code terminal:

   ```azurecli
   az group create --name ToyWebsite --location westus
   ```

1. Look at the JSON output from the command. It includes an `id` property, which is the resource group's ID.

   Copy the resource group ID somewhere safe. You'll use it soon.

::: zone-end

::: zone pivot="powershell"

1. To create a resource group, run this Azure PowerShell command in the Visual Studio Code terminal:

   ```azurepowershell
   New-AzResourceGroup -Name ToyWebsite -Location westus
   ```

1. Look at the output from the command. It includes a `ResourceId`, which is the resource group's fully qualified ID.

   Copy the resource group ID somewhere safe. You'll use it soon.

::: zone-end

## Create a service principal and grant it access to the resource group

::: zone pivot="cli"

1. To create a service principal and assign it the Contributor role for your resource group, run the following Azure CLI command in the Visual Studio Code terminal. Replace the placeholder with the resource group ID you copied in the last step.

   ```azurecli
   az ad sp create-for-rbac \
     --name ToyWebsitePipeline \
     --role Contributor \
     --scopes RESOURCE_GROUP_ID
   ```

1. Look at the JSON output from the command. It includes the following properties:

    * `appId`: The service principal's application ID.
    * `password`: The service principal's key.
    * `tenant`: Your Azure AD tenant ID.

   Copy these values somewhere safe. You'll use them soon.

1. To view information about your Azure subscription, run this Azure CLI command:

   ```azurecli
   az account show
   ```

1. Look at the JSON output from the command. It includes the following properties:

    * `id`: Your Azure subscription ID.
    * `name`: Your Azure subscription name.

   Copy these values somewhere safe. You'll use them soon.

::: zone-end

::: zone pivot="powershell"

1. To create a service principal and assign it the Contributor role for your resource group, run the following Azure PowerShell code in the Visual Studio Code terminal. Replace the placeholder with the resource group ID you copied in the last step.

   ```azurepowershell
   $servicePrincipal = New-AzADServicePrincipal `
     -DisplayName ToyWebsitePipeline `
     -Role Contributor `
     -Scope RESOURCE_GROUP_ID

   $plaintextSecret = [System.Net.NetworkCredential]::new('', $servicePrincipal.Secret).Password
   ```

1. Run this code to show the service principal's application ID, the key, and your Azure AD tenant ID:

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

You've created a resource group and a service principal. Next, create a service connection in Azure Pipelines.

1. In your browser, select **Project settings** > **Service connections** > **Create service connection**.

   :::image type="content" source="../media/5-create-service-connection.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the 'Create service connection' button highlighted.":::

1. Select **Azure Resource Manager** > **Next**.

   :::image type="content" source="../media/5-create-service-connection-type.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the Azure Resource Manager service connection type highlighted.":::

1. Select **Service principal (manual)** > **Next**.

   :::image type="content" source="../media/5-create-service-connection-principal-type.png" alt-text="Screenshot of the Azure DevOps 'Create service connection' page, with the 'Service principal (manual)' authentication method highlighted.":::

   > [!NOTE]
   > It's a good idea to manually create service principals like you're doing here, rather than using the automatic service principal creation that's available in Azure Pipelines. When you use the automatic method, Azure Pipelines grants the service principal permissions to your entire subscription. It's more secure to grant permissions with a narrower scope, like a resource group. Granting specific permissions requires you to use the manual creation process.

1. In **Subscription Id** and **Subscription Name**, enter the subscription ID and subscription name that you saved earlier.

   :::image type="content" source="../media/5-create-service-connection-principal-details-1.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with a subscription ID and subscription name entered.":::

1. In **Service principal Id** and **Service principal key**, enter the service principal's application ID and the key that you saved earlier. In **Tenant ID**, enter the Azure tenant ID that you saved earlier. Select **Verify**.

   :::image type="content" source="../media/5-create-service-connection-principal-details-2.png" alt-text="Screenshot of the Azure DevOps 'Create service connection' page, with the details completed and the Verify button highlighted.":::

1. Azure Pipelines verifies that it can access your Azure subscription. Check that*Verification succeeded* is shown.

   > [!NOTE]
   > If the verification doesn't succeed, check that you copied the correct values for the service principal, subscription, and tenant. Wait a few minutes to allow time for Azure's role assignments to replicate globally, and then try again.

1. In **Service connection name**, enter **ToyWebsite**. Ensure that the **Grant access permission to all pipelines** checkbox is selected. Select **Verify and save**.

   :::image type="content" source="../media/5-create-service-connection-principal-details-3.png" alt-text="Screenshot of the Azure DevOps 'Create service connection' page, with the 'Verify and save' button highlighted.":::

   > [!TIP]
   > For simplicity, you're giving every pipeline access to your service connection. When you create real service connections that work with production resources, consider restricting access to only the pipelines that need them.

1. In **Service connections**, verify that your new service connection is shown in the list of service connections.

   :::image type="content" source="../media/5-service-connection-created.png" alt-text="Screenshot of Azure DevOps that shows the list of service connections, with the ToyWebsite service connection included.":::


<!-- TODO decide if the above should be in its own unit -->



## Add a validation stage to your pipeline

1. Open the **azure-pipelines.yml** file. 

   :::image type="content" source="../media/4-pipeline-yml.png" alt-text="Screenshot of the Visual Studio Code user interface, with the azure-pipelines.yml file highlighted." border="false":::

1. Replace the content of the file with this: 

   :::code language="yaml" source="code/4-azure-pipeline.yml" :::

   This pipeline definition now has 3 stages, one for validating your code with `bicep build`, one for performing a pre-flight check with `az deployment group validate` and one for performing the actual deployment with `az deployment group create`. 

1. Save your file.

1. Add a new file in the deploy folder and call it `bicepconfig.json`. Copy the following into the file:    

   :::code language="json" source="code/4-bicepconfig.json" :::

   > [!NOTE]
   > The *bicepconfig.json* file also controls how Visual Studio Code shows errors and warnings in the editor. It displays red and yellow squiggly lines under misconfigured parts in your Bicep template. This gives you even quicker feedback when you're writing your Bicep code, further reducing the chance of an error.

1. Save your file.

1. Commit and push your changes to your Git repository by using the following commands: 

   ```bash
   git add .
   git commit -m "Added stages"
   git push
   ```

1. In your browser, navigate to your pipeline. 

   :::image type="content" source="../media/4-pipeline.png" alt-text="Screenshot of the Azure DevOps interface, with the Pipelines menu item and the pipeline highlighted." border="false":::

1. Notice that your pipeline run now shows the 3 stages you have in your YAML file. Your first stage will fail, since there are syntax errors in your Bicep template. Select the **Validate** stage to see its details.

   :::image type="content" source="../media/4-stage1-fail.png" alt-text="Screenshot of the Azure DevOps interface pipeline run detail screen, with the failing first stage highlighted." border="false":::

1. Inspect the failure messages. Navigate back to Visual Studio Code and fix the errors. Once fixed save the Bicep template file again, commit and push it to the repository to trigger another run. If all syntax errors were fixed, your first stage should now succeed. If your first stage still does not succeed, inspect the errors again and try and fix them again. Your second stage will fail, but don't worry, we will fix that as a next step. Your fixed Bicep template might look like this: 

   :::code language="bicep" source="code/4-main-fix1.bicep" :::

1. In your browser, navigate to the most recent run of your pipeline. It will now show the second stage failing. Select the failing **PreFlight** stage to see its details.

   :::image type="content" source="../media/4-stage2-fail.png" alt-text="Screenshot of the Azure DevOps interface pipeline run detail screen, with the failing second stage highlighted." border="false":::

1. Inspect the failure message. Navigate back to Visual Studio Code and fix the error. Once fixed save the Bicep template file again, commit and push it to the repository to trigger another run. If all pre-flight errors were fixed, your second stage should now succeed as well as the third and final stage. If your second stage still does not succeed, inspect the error again and try and fix them again. Your fixed Bicep template might look like this: 

   :::code language="bicep" source="code/4-main.bicep" :::

Notice that for fixing this error, your need to remove the dash from the name of the storage account, since this is an illegal charachter for a storage account, as well as add the resourceNameSuffix to it, to make it unique. Both errors will make the pre-flight check fail. 

You now have a pipeline that can successfully detect errors in your Bicep code early in your proces.
