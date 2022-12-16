[!INCLUDE [BYO subscription explanation](../../../includes/azure-exercise-subscription-prerequisite.md)]

Before you start to work on your toy company's website pipeline, you need to configure your environment. In this unit, you'll make sure that your Azure and Azure DevOps environments are set up to complete the rest of this module.

To meet these objectives, you'll do the following tasks:

> [!div class="checklist"]
>
> - Set up an Azure DevOps project for this module.
> - Clone the project's repository to your computer.
> - Create two resource groups in Azure.
> - Create two service connections and environments in Azure Pipelines.

## Get the Azure DevOps project

In this section, you make sure that your Azure DevOps organization is set up to complete the rest of this module. You set it up by running a template that creates a project in Azure DevOps.

The modules in this learning path are part of a progression. For learning purposes, each module has an associated Azure DevOps project.

> [!TIP]
> Even if you completed the preceding module in the learning path, follow these instructions to create a new project. Be sure to give the project a new name.

### Run the template

Run a template that sets up your Azure DevOps project.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?name=bicependtoend)

On the Azure DevOps Demo Generator site, do the following steps:

1. Select **Sign In**, and then agree to the site usage terms by selecting **Accept**.

1. On the **Create New Project** page, select your Azure DevOps organization and then, in the **New Project Name** box, enter a project name, such as _toy-website-end-to-end_.

    :::image type="content" source="../media/4-create-new-project.png" alt-text="Screenshot of the Azure DevOps Demo Generator pane for creating a new project.":::

1. Select **Create Project**.

    The template takes a few moments to run. It automatically creates a pipeline and Bicep file for you to work with in the next few exercises.

1. Select **Navigate to project** to go to your project in Azure DevOps.

[!INCLUDE [](../../includes/cleanup-steps.md)]

## Clone the repository

1. Select **Repos** > **Files**.

   :::image type="content" source="../media/4-repos-files.png" alt-text="Screenshot of Azure DevOps that shows the Repos menu, with Files highlighted.":::

1. Select **Clone**.

   :::image type="content" source="../media/4-clone.png" alt-text="Screenshot of Azure DevOps showing the repository, with the Clone button highlighted.":::

1. If you're using macOS, you need a special password to clone the Git repository. Select **Generate Git credentials**, and then copy the displayed username and password to somewhere safe.

1. Select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

    :::image type="content" source="../media/4-clone-visual-studio-code.png" alt-text="Screenshot of Azure DevOps that shows the repository settings, with the Clone in VS Code button highlighted.":::

1. If a dialog box appears, prompting you to allow an extension to open the repository URI, select **Open**.

1. Create a folder to use for the repository, and then select **Select Repository Location**.

1. You're using this repository for the first time, so you might be prompted to sign in.

   - If you're using Windows, enter the same credentials that you used to sign in to Azure DevOps earlier in this exercise.

   - If you're using macOS, enter the Git username and password that you generated a few moments ago.

1. Visual Studio Code prompts you to open the repository. Select **Open**.

   :::image type="content" source="../../includes/media/open-cloned-repo.png" alt-text="Screenshot of Visual Studio Code that shows a prompt to open the cloned repository, with the Open button highlighted.":::

[!INCLUDE [](../../includes/azure-template-pipeline-sign-in.md)]

## Create two resource groups in Azure

::: zone pivot="cli"

To create the two new resource groups, run the following Azure CLI commands in the Visual Studio Code terminal:

```azurecli
az group create --name ToyWebsiteTest --location westus3
az group create --name ToyWebsiteProduction --location westus3
```

::: zone-end

::: zone pivot="powershell"

To create the two new resource groups, run the following Azure PowerShell commands in the Visual Studio Code terminal:

```azurepowershell
New-AzResourceGroup -Name ToyWebsiteTest -Location westus3
New-AzResourceGroup -Name ToyWebsiteProduction -Location westus3
```

::: zone-end

## Create service connections in Azure Pipelines

Next, create two service connections in Azure Pipelines, one for your test environment and another for your production environment. This process automatically creates a service principal in Azure. It also grants the service principal the Contributor role on your resource group, which allows your pipeline to be deployed to the resource group.

1. In your browser, select **Project settings**.

   :::image type="content" source="../../includes/media/azure-devops-project-settings.png" alt-text="Screenshot of Azure DevOps that shows the menu, with the Project settings item highlighted.":::

1. Select **Service connections** > **Create service connection**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection.png" alt-text="Screenshot of Azure DevOps that shows the Service connections pane, with the Create service connection button highlighted.":::

1. Select **Azure Resource Manager** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-type.png" alt-text="Screenshot of Azure DevOps that shows the Service connections pane, with the Azure Resource Manager service connection type highlighted.":::

1. Select **Service principal (automatic)** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-principal-type.png" alt-text="Screenshot of Azure DevOps that shows the New Azure service connection pane, with the Service principal (automatic) option highlighted.":::

1. In the **Subscription** dropdown list, select your Azure subscription.

   If a popup window appears with a message asking you to sign in to Azure, enter your credentials and sign in.

1. In the **Resource group** dropdown list, select **ToyWebsiteTest**.

1. In the **Service connection name** box, enter **ToyWebsiteTest**. Ensure that the **Grant access permission to all pipelines** checkbox is selected.

   :::image type="content" source="../media/4-create-service-connection-principal-details-test.png" alt-text="Screenshot of Azure DevOps that shows the New Azure service connection pane for the test environment, with the details completed and the Save button highlighted.":::

   > [!TIP]
   > In this exercise, for simplicity, you're giving every pipeline access to your service connection. When you create real service connections that work with production resources, consider restricting access to only the pipelines that need them.

1. Select **Save**.

1. Repeat steps 1 through 8 to create another new service connection named **ToyWebsiteProduction**, which is deployed to the resource group named **ToyWebsiteProduction**:

   :::image type="content" source="../media/4-create-service-connection-principal-details-production.png" alt-text="Screenshot of Azure DevOps that shows the New Azure service connection pane for the production environment, with the details completed and the Save button highlighted.":::

   If the resource group list isn't shown, refresh the page in your browser, enter your credentials if prompted, and try again.

> [!NOTE]
> In previous modules in this learning path, you added an approval check to your production environment. In this module, for simplicity, you're skipping the approval check. However, you can add the approval check yourself if you'd like.
