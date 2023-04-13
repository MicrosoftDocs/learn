[!INCLUDE [BYO subscription explanation](../../../includes/azure-exercise-subscription-prerequisite.md)]

Before you start to work on your toy company's website pipeline, you need to configure your environment. In this section, you'll make sure that your Azure and Azure DevOps environments are set up to complete the rest of this module.

To meet these objectives, you'll:

> [!div class="checklist"]
> - Set up an Azure DevOps project for this module.
> - Clone the project's repository to your computer.
> - Create a resource group in Azure.
> - Create a service connection in Azure Pipelines.

## Get the Azure DevOps project

Here, you'll make sure that your Azure DevOps organization is set up to complete the rest of this module. You'll set it up by running a template that creates a project in Azure DevOps.

The modules in this learning path are part of a progression. For learning purposes, each module has an associated Azure DevOps project.

> [!TIP]
> Even if you completed the previous module in the learning path, please follow these instructions to create a new project and ensure that you give it a new name.

### Run the template

Run a template that sets up your Azure DevOps project.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?name=testbicep&azure-portal=true)

On the Azure DevOps Demo Generator site, follow these steps to run the template:

1. Select **Sign In** and accept the usage terms.

1. On the **Create New Project** page, select your Azure DevOps organization. Then enter a project name, such as **toy-website-test**.

    :::image type="content" source="../media/4-create-new-project.png" alt-text="Screenshot that shows creating a project through the Azure DevOps Demo Generator.":::

1. Select **Create Project**.

    The template takes a few moments to run. It automatically creates a pipeline and Bicep file for you to work with in the subsequent exercises.

1. Select **Navigate to project** to go to your project in Azure DevOps.

[!include[](../../includes/cleanup-steps.md)]

## Clone the repository

1. Select **Repos** > **Files**.

   :::image type="content" source="../media/4-repos-files.png" alt-text="Screenshot of Azure DevOps that shows the Repos menu, with Files highlighted.":::

1. Select **Clone**.

   :::image type="content" source="../media/4-clone.png" alt-text="Screenshot of Azure DevOps that shows the repository, with the Clone button highlighted.":::

1. If you're using macOS, you need a special password to clone the Git repository. Select **Generate Git credentials** and copy the displayed username and password to somewhere safe.

1. Select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

    :::image type="content" source="../media/4-clone-visual-studio-code.png" alt-text="Screenshot of Azure DevOps that shows the repository settings, with the button for cloning in Visual Studio Code highlighted.":::

1. If a dialog box appears, prompting you to allow an extension to open the repository URI, select Open.

1. Create a folder to use for the repository, and then choose **Select Repository Location**.

1. You're using this repository for the first time, so you're prompted to sign in.

   - If you're using Windows, enter the same credentials that you used to sign in to Azure DevOps earlier in this exercise.

   - If you're using macOS, enter the Git username and password that you generated a few moments ago.

1. Visual Studio Code prompts you to open the repository. Select **Open**.

   :::image type="content" source="../../includes/media/open-cloned-repo.png" alt-text="Screenshot of Visual Studio Code that shows a prompt to open the cloned repository, with the Open button highlighted.":::

[!include[](../../includes/azure-template-pipeline-sign-in.md)]

## Create a resource group in Azure

::: zone pivot="cli"

To create a new resource group, run this Azure CLI command in the Visual Studio Code terminal:

```azurecli
az group create --name ToyWebsiteTest --location westus3
```

::: zone-end

::: zone pivot="powershell"

To create a resource group, run this Azure PowerShell command in the Visual Studio Code terminal:

```azurepowershell
New-AzResourceGroup -Name ToyWebsiteTest -Location westus3
```

::: zone-end

## Create a service connection in Azure Pipelines

Next, create a service connection in Azure Pipelines. This connection automatically creates a service principal in Azure. It also grants the service principal the Contributor role on your resource group, which allows your pipeline to deploy to the resource group.

1. In your browser, select **Project settings**.

   :::image type="content" source="../../includes/media/azure-devops-project-settings.png" alt-text="Screenshot of Azure DevOps that shows the menu item for project settings highlighted.":::

1. Select **Service connections** > **Create service connection**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection.png" alt-text="Screenshot of Azure DevOps that shows selections for creating a service connection.":::

1. Select **Azure Resource Manager** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-type.png" alt-text="Screenshot of Azure DevOps that shows the Azure Resource Manager service connection type highlighted.":::

1. Select **Service principal (automatic)** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-principal-type.png" alt-text="Screenshot of Azure DevOps that shows the service principal option highlighted.":::

1. In the **Subscription** dropdown list, select your Azure subscription.

   A pop-up window might appear, asking you to sign in to Azure. If it does, enter your credentials and sign in.

1. In the **Resource group** dropdown list, select **ToyWebsiteTest**.

1. In **Service connection name**, enter **ToyWebsiteTest**. Ensure that the **Grant access permission to all pipelines** checkbox is selected.

   :::image type="content" source="../media/4-create-service-connection-principal-details.png" alt-text="Screenshot of Azure DevOps that shows the details completed for creating a service connection, with the Save button highlighted.":::

   > [!TIP]
   > For simplicity, you're giving every pipeline access to your service connection. When you create real service connections that work with production resources, consider restricting access to only the pipelines that need them.

1. Select **Save**.
