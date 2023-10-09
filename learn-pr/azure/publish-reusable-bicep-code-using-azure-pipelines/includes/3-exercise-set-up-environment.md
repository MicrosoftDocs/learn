[!INCLUDE [BYO subscription explanation](../../../includes/azure-exercise-subscription-prerequisite.md)]

Before you start to publish your toy company's reusable Bicep code, you need to configure your environment. In this section, you make sure that your Azure and Azure DevOps environments are set up to complete the rest of this module.

To meet these objectives, you'll:

> [!div class="checklist"]
>
> - Set up an Azure DevOps project for this module.
> - Clone the project's repository to your computer.
> - Create a resource group in Azure.
> - Create a service connection in Azure Pipelines.

## Get the Azure DevOps project

In this section, you make sure that your Azure DevOps organization is set up to complete the rest of this module. You set it up by running a template that creates a project in Azure DevOps.

The modules in this learning path are part of a progression. For learning purposes, each module has an associated Azure DevOps project.

> [!TIP]
> Even if you completed the preceding module in the learning path, follow these instructions to create a new project. Be sure to give the project a new name.

### Run the template

Run a template that sets up your Azure DevOps project.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?name=bicepreusable)

On the Azure DevOps Demo Generator site, do the following:

1. Select **Sign In**, and then agree to the site usage terms by selecting **Accept**.

1. On the **Create New Project** page, select your Azure DevOps organization and then, in the **New Project Name** box, enter a project name, such as _toy-reusable_.

    :::image type="content" source="../media/3-create-new-project.png" alt-text="Screenshot of the Azure DevOps Demo Generator pane for creating a new project.":::

1. Select **Create Project**.

    The template takes a few moments to run. It automatically creates a pipeline and Bicep file for you to work with in the next few exercises.

1. Select **Navigate to project** to go to your project in Azure DevOps.

[!INCLUDE [](../../includes/cleanup-steps.md)]

## Clone the repository

1. Select **Repos** > **Files**.

   :::image type="content" source="../media/3-repos-files.png" alt-text="Screenshot of Azure DevOps that shows the Repos menu, with Files highlighted.":::

1. Select **Clone**.

   :::image type="content" source="../media/3-clone.png" alt-text="Screenshot of Azure DevOps showing the repository, with the Clone button highlighted.":::

1. If you're using macOS, you need a special password to clone the Git repository. Select **Generate Git credentials**, and then copy the displayed username and password to somewhere safe.

1. Select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

    :::image type="content" source="../media/3-clone-visual-studio-code.png" alt-text="Screenshot of Azure DevOps that shows the repository settings, with the Clone in VS Code button highlighted.":::

1. Create a folder to use for the repository, and then select **Select Repository Location**.

1. You're using this repository for the first time, so you might be prompted to sign in.

   - If you're using Windows, enter the same credentials that you used to sign in to Azure DevOps earlier in this exercise.

   - If you're using macOS, enter the Git username and password that you generated a few moments ago.

1. Visual Studio Code prompts you to open the repository. Select **Open**.

   :::image type="content" source="../../includes/media/open-cloned-repo.png" alt-text="Screenshot of Visual Studio Code that shows a prompt to open the cloned repository, with the Open button highlighted.":::

## Sign in to Azure

::: zone pivot="cli"

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli) tools.

[!INCLUDE [](../../includes/azure-exercise-terminal-cli.md)]

### Sign in to Azure by using the Azure CLI

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurecli
   az login
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps).

[!INCLUDE [](../../includes/azure-exercise-terminal-powershell.md)]

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurepowershell
   Connect-AzAccount
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a resource group in Azure

::: zone pivot="cli"

To create a new resource group, run this Azure CLI command in the Visual Studio Code terminal:

```azurecli
az group create --name ToyReusable --location westus3
```

::: zone-end

::: zone pivot="powershell"

To create a resource group, run this Azure PowerShell command in the Visual Studio Code terminal:

```azurepowershell
New-AzResourceGroup -Name ToyReusable -Location westus3
```

::: zone-end

## Create a service connection in Azure Pipelines

Next, create a service connection in Azure Pipelines. This process automatically creates a service principal in Azure. It also grants the service principal the Contributor role on your resource group, which allows your pipeline to deploy into the resource group.

1. In your browser, select **Project settings**.

   :::image type="content" source="../../includes/media/azure-devops-project-settings.png" alt-text="Screenshot of Azure DevOps that shows the menu, with the Project settings item highlighted.":::

1. Select **Service connections** > **Create service connection**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection.png" alt-text="Screenshot of Azure DevOps that shows the Service connections' pane, with the 'Create service connection' button highlighted.":::

1. Select **Azure Resource Manager** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-type.png" alt-text="Screenshot of Azure DevOps that shows the 'Service connections' pane, with the 'Azure Resource Manager' service connection type highlighted.":::

1. Select **Service principal (automatic)** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-principal-type.png" alt-text="Screenshot of Azure DevOps that shows the New Azure service connection' pane, with the Service principal (automatic) option highlighted.":::

1. In the **Subscription** dropdown list, select your Azure subscription.

   If a popup window appears with a message asking you to sign in to Azure, enter your credentials and sign in.

1. In the **Resource group** dropdown list, select **ToyReusable**.

1. In the **Service connection name** box, enter **ToyReusable**. Ensure that the **Grant access permission to all pipelines** checkbox is selected.

   :::image type="content" source="../media/3-create-service-connection-principal-details.png" alt-text="Screenshot of Azure DevOps that shows the 'New Azure service connection' pane, with the details completed and the Save button highlighted.":::

   > [!TIP]
   > In this exercise, for simplicity, you're giving every pipeline access to your service connection. When you create real service connections that work with production resources, consider restricting access to only the pipelines that need them.

1. Select **Save**.
