Before you start to work on your toy company's website pipeline, you need to configure your environment. In this section, you make sure that your Azure and Azure DevOps environments are set up to complete the rest of this module.

To meet these objectives, you'll:

> [!div class="checklist"]
> * Set up an Azure DevOps project for this module.
> * Clone the project's repository to your computer.
> * Create two resource groups in Azure.
> * Create two service connections and environments in Azure Pipelines.

## Get the Azure DevOps project

Here you make sure that your Azure DevOps organization is set up to complete the rest of this module. You set it up by running a template that creates a project in Azure DevOps.

The modules in this learning path are part of a progression. For learning purposes, each module has an associated Azure DevOps project.

> [!TIP]
> Even if you completed the previous module in the learning path, please follow these instructions to create a new project and ensure you give it a new name.

### Run the template

Run a template that sets up your Azure DevOps project.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator-staging.azurewebsites.net/?name=bicepenvironments&azure-portal=true) <!-- TODO use correct URL -->

On the Azure DevOps Demo Generator site, follow these steps to run the template:

1. Select **Sign In** and accept the usage terms.

1. On the **Create New Project** page, select your Azure DevOps organization. Then enter a project name, such as *toy-website-environments*.

    :::image type="content" source="../media/4-create-new-project.png" alt-text="Creating a project through the Azure DevOps Demo Generator.":::

1. Select **Create Project**.

    The template takes a few moments to run. It automatically creates a pipeline and Bicep file for you to work with in the subsequent exercises.

1. Select **Navigate to project** to go to your project in Azure DevOps.

> [!IMPORTANT]
> The final exercise in this module contains important cleanup steps. Be sure to follow the cleanup steps even if you don't complete this module.

## Clone the repository

1. Select **Repos** > **Files**.

   :::image type="content" source="../media/4-repos-files.png" alt-text="Screenshot of Azure DevOps that shows the Repos menu, with Files highlighted.":::

1. Select **Clone**.

   :::image type="content" source="../media/4-clone.png" alt-text="Screenshot of Azure DevOps showing the repository, with the Clone button highlighted.":::

1. If you're using macOS, you need a special password to clone the Git repository. Select **Generate Git credentials** and copy the username and password displayed to somewhere safe.

1. Select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

    :::image type="content" source="../media/4-clone-visual-studio-code.png" alt-text="Screenshot of Azure DevOps that shows the repository settings, with the Clone in VS Code button highlighted.":::

1. Create a folder to use for the repository, and then choose **Select Repository Location**.

1. You're using this repository for the first time, so you're prompted to sign in.

    If you're using Windows, enter the same credentials you used to sign in to Azure DevOps earlier in this exercise.

    If you're using macOS, enter the Git username and password that you generated a few moments ago.

1. Visual Studio Code prompts you to open the repository. Select **Open**.

   :::image type="content" source="../../includes/media/open-cloned-repo.png" alt-text="Screenshot of Visual Studio Code that shows a prompt to open the cloned repository, with the Open button highlighted.":::

## Sign in to Azure

::: zone pivot="cli"

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true) tools.

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

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true).

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

## Create two resource groups in Azure

::: zone pivot="cli"

To create the two new resource groups, run the following Azure CLI commands in the Visual Studio Code terminal:

```azurecli
az group create --name ToyWebsiteTest --location westus
az group create --name ToyWebsiteProduction --location westus
```

::: zone-end

::: zone pivot="powershell"

To create the two new resource groups, run the following Azure PowerShell commands in the Visual Studio Code terminal:

```azurepowershell
New-AzResourceGroup -Name ToyWebsiteTest -Location westus
New-AzResourceGroup -Name ToyWebsiteProduction -Location westus
```

::: zone-end

## Create service connections in Azure Pipelines

Next, create two service connections in Azure Pipelines - one for your test environment and another for your production environment. This process automatically creates a service principal in Azure. It also grants the service principal the Contributor role on your resource group, which allows your pipeline to deploy to the resource group.

1. In your browser, select **Project settings**.

   :::image type="content" source="../../includes/media/azure-devops-project-settings.png" alt-text="Screenshot of Azure DevOps that shows the menu, with the 'Project settings' item highlighted.":::

1. Select **Service connections** > **Create service connection**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the 'Create service connection' button highlighted.":::

1. Select **Azure Resource Manager** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-type.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the Azure Resource Manager service connection type highlighted.":::

1. Select **Service principal (automatic)** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-principal-type.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the Service principal (automatic) option highlighted.":::

1. In the **Subscription** drop-down, select your Azure subscription.

   A popup window might appear, asking you to sign in to Azure. If it does, enter your credentials and sign in.

1. In the **Resource group** drop-down, select **ToyWebsiteTest**.

1. In **Service connection name**, enter **ToyWebsiteTest**. Ensure that the **Grant access permission to all pipelines** checkbox is selected.

   :::image type="content" source="../media/4-create-service-connection-principal-details-test.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page for the test environment, with the details completed and the Next button highlighted.":::

   > [!TIP]
   > For simplicity, you're giving every pipeline access to your service connection. When you create real service connections that work with production resources, consider restricting access to only the pipelines that need them.

1. Select **Save**.

1. Repeat the above process to create another new service connection named **ToyWebsiteProduction**, which deploys to the resource group named **ToyWebsiteProduction**:

   :::image type="content" source="../media/4-create-service-connection-principal-details-production.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page for the production environment, with the details completed and the Next button highlighted.":::

   If the resource group list doesn't update, refresh the page in your browser and try again.

## Create environments in Azure Pipelines

1. In your browser, go to **Pipelines** > **Environments**.

   :::image type="content" source="../media/4-environments.png" alt-text="Screenshot of the Azure DevOps interface that shows the Pipelines menu, with the Environments item highlighted.":::

1. Select **New environment**.

   :::image type="content" source="../media/4-environments-new.png" alt-text="Screenshot of the Azure DevOps interface that shows the Environments page, with the button for creating an environment highlighted.":::

1. Enter **Test** as the environment name.

   Leave the description blank. For **Resource**, select **None**.

   > [!NOTE]
   > In Azure Pipelines, environments are used to enable deployment features. Some of these features apply only when you're deploying to Kubernetes or to virtual machines. In this module, we don't use these features and you can ignore them.

1. Select **Create**.

   :::image type="content" source="../media/4-environments-new-details-test.png" alt-text="Screenshot of the Azure DevOps page for a new environment named Test, with the details completed and the Create button highlighted.":::

1. Repeat the process to create another environment named **Production**.

   :::image type="content" source="../media/4-environments-new-details-production.png" alt-text="Screenshot of the Azure DevOps page for a new environment named Production, with the details completed and the Create button highlighted.":::

   Leave the production environment page open.

## Add an approval check to the production environment

1. Near the upper right of the page, select the button with three dots and select **Approvals and checks** from the pop-up menu.

   :::image type="content" source="../media/4-add-check.png" alt-text="Screenshot of the Azure DevOps interface that shows the Website environment, with the three dots button highlighted.":::

1. Select **Approvals**.

   :::image type="content" source="../media/4-add-check-approval.png" alt-text="Screenshot of the Azure DevOps interface that shows the page for adding a check, with the Approvals item highlighted.":::

1. In the **Approvers** text box, type your own name and select yourself.

1. Select the arrow button next to **Advanced**.

   Notice that, by default, approvers are allowed to approve the runs that they've triggered. Because you're the only person who will work with this pipeline, leave this checkbox selected.

1. Select **Create**.

   :::image type="content" source="../media/4-add-check-approval-details.png" alt-text="Screenshot of the Azure DevOps interface that shows the page for adding an approval check, with the details completed and the Create button highlighted.":::

## Delete the old environment

In the previous versions of the pipeline, you used a single environment named *Website*. Now that you've created pipeline environments that represent your new environments, you'll delete the old pipeline environment.

1. Go to **Pipelines** > **Environments**.

1. Select the **Website** environment.

   :::image type="content" source="../media/4-environments-website.png" alt-text="Screenshot of the Azure DevOps interface that shows the list of environments, with the Website environment highlighted.":::

1. Near the upper right of the page, select the button with three dots and select **Delete** from the pop-up menu.

1. Select **Delete** to confirm the deletion.

## Delete the old variables

In the previous versions of the pipeline, you used a single set of variables to define the parameters and deployment configuration. Now that you're deploying to multiple environments, you'll delete these variables and replace them with environment-specific sets of variables.

1. Go to **Pipelines** > **Pipelines**.

1. Select the **toy-website-environments** pipeline.

   :::image type="content" source="../media/4-pipeline-variables.png" alt-text="Screenshot of the Azure DevOps interface that shows the pipeline, with the Variables button highlighted.":::

1. Select the **Edit** button.

   :::image type="content" source="../media/4-pipeline-edit.png" alt-text="Screenshot of the Azure DevOps interface that shows the pipeline, with the Edit button highlighted.":::

1. Select the **Variables** button.

1. Select the **Delete variable** button for each of the three variables.

   :::image type="content" source="../media/4-variables-delete.png" alt-text="Screenshot of the Azure DevOps interface that shows the list of variables, with the delete button highlighted.":::

1. Select the **Save** button.