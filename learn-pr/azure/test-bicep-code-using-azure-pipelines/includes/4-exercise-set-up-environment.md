In this section, you make sure that your Azure DevOps organization is set up to complete the rest of this module.

To meet these objectives, you:

> [!div class="checklist"]
> * Set up an Azure DevOps project for this module.
> * Clone the project's repository to your computer.
> * Create a resource group and service principal in Azure.
> * Create a service connection in Azure Pipelines.

## Get the Azure DevOps project

Here you make sure that your Azure DevOps organization is set up to complete the rest of this module. You set it up by running a template that creates a project in Azure DevOps.

The modules in this learning path are part of a progression. For learning purposes, each module has an associated Azure DevOps project.

> [!TIP]
> Even if you completed the previous module in the learning path, please follow these instructions to create a new project.

### Run the template

Run a template that sets up your Azure DevOps organization.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?x-ms-routing-name=self&name=deliveryplans&azure-portal=true)

On the Azure DevOps Demo Generator site, follow these steps to run the template:

1. Select **Sign In** and accept the usage terms.
1. On the **Create New Project** page, select your Azure DevOps organization. Then enter a project name, such as *toy-website-test*.

    <!--:::image type="content" source="../media/4-create-new-project.png" alt-text="Creating a project through the Azure DevOps Demo Generator.":::-->

1. Select **Create Project**.

    The template takes a few moments to run.
1. Select **Navigate to project** to go to your project in Azure DevOps.

> [!IMPORTANT]
> The final exercise in this module contains important cleanup steps. Be sure to follow the cleanup steps even if you don't complete this module.

### Update the pipeline settings

TODO explain

1. In the left menu, select **Pipelines**.

1. Select **toy-website-test**.

1. Select the **Edit** button.

1. Select the button with three dots and select **Triggers** from the popup menu.

1. Deselect the checkbox next to **Override the YAML continuous integration trigger from here**.

1. Select the **YAML** tab.

1. Select **Pipeline**.

1. In the **Default agent pool for YAML**, select **Azure Pipelines**.

1. Select the down arrow next to **Save and queue**, and select **Save**.

1. Select **Save**.

## Generate a Git password (macOS)

<!-- TODO can we simplify this section? Maybe fold into the 'If you're using macOS' thing below? -->

When you work with Azure Repos in Visual Studio Code on macOS, you use a special password that's different from the password you use to sign in.

> [!NOTE]
> If you're using Windows, skip to the next section, *Clone the repository*.

1. On a computer running macOS, in Azure DevOps, select **Generate Git credentials**.

    Azure Repos creates a random password for you to use.

1. Copy the **Password** value somewhere safe. You'll use the password in the next section.

## Clone the repository

In Visual Studio Code, clone your repository.

1. In **Clone to your computer**, select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

    :::image type="content" source="../../build-first-bicep-deployment-pipeline-using-azure-pipelines/media/3-clone-visual-studio-code.png" alt-text="Screenshot of Azure DevOps that shows the repository settings, with the Clone in VS Code button highlighted.":::

1. Create a folder to use for the repository, and then choose **Select Repository Location**.

1. You're using this repository for the first time, so you're prompted to sign in.

    If you're using Windows, enter the same credentials you used to sign in to Azure DevOps earlier in this exercise.

    If you're using macOS, paste the password that you generated earlier in this exercise.

1. Visual Studio Code prompts you to open the repository. Select **Open**.

    :::image type="content" source="../../build-first-bicep-deployment-pipeline-using-azure-pipelines/media/3-open-cloned-repo.png" alt-text="Screenshot of Visual Studio Code that shows a prompt to open the cloned repository, with the Open button highlighted.":::

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

## Create a resource group in Azure

::: zone pivot="cli"

1. To create a new resource group, run this Azure CLI command in the Visual Studio Code terminal:

   ```azurecli
   az group create --name ToyWebsiteTest --location westus
   ```

1. Look at the JSON output from the command. It includes an `id` property, which is the resource group's ID.

   Copy the resource group ID somewhere safe. You'll use it soon.

::: zone-end

::: zone pivot="powershell"

1. To create a resource group, run this Azure PowerShell command in the Visual Studio Code terminal:

   ```azurepowershell
   New-AzResourceGroup -Name ToyWebsiteTest -Location westus
   ```

1. Look at the output from the command. It includes a `ResourceId`, which is the resource group's fully qualified ID.

   Copy the resource group ID somewhere safe. You'll use it soon.

::: zone-end

## Create a service connection in Azure Pipelines

You've created a resource group. Next, create a service connection in Azure Pipelines. This automatically creates a service principal and grants the service principal the Contributor role on your resource group.

1. In your browser, select **Project settings** > **Service connections** > **Create service connection**.

   :::image type="content" source="../../build-first-bicep-deployment-pipeline-using-azure-pipelines/media/5-create-service-connection.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the 'Create service connection' button highlighted.":::

1. Select **Azure Resource Manager** > **Next**.

   :::image type="content" source="../../build-first-bicep-deployment-pipeline-using-azure-pipelines/media/5-create-service-connection-type.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the Azure Resource Manager service connection type highlighted.":::

1. Select **Service principal (automatic)** > **Next**.

1. In the **Subscription** drop-down, select your Azure subscription. A popup window may appear, asking you to sign in to Azure. If it does, enter your credentials and sign in.

1. In the **Resource group** drop-down, select **ToyWebsiteTest**.

1. In **Service connection name**, enter **ToyWebsiteTest**. Ensure that the **Grant access permission to all pipelines** checkbox is selected.

1. Select **Save**.
