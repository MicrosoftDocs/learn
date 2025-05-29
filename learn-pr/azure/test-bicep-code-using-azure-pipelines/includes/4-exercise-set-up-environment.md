[!INCLUDE [BYO subscription explanation](../../../includes/azure-exercise-subscription-prerequisite.md)]

Before you start to work on your toy company's website pipeline, you need to configure your environment. In this section, you'll make sure that your Azure and Azure DevOps environments are set up to complete the rest of this module.

To meet these objectives, you'll:

> [!div class="checklist"]
> - Set up an Azure DevOps project for this module.
> - Clone the project's repository to your computer.
> - Create a resource group in Azure.
> - Create a service connection in Azure Pipelines.

## Get the Azure DevOps project

In this section, you'll make sure that your Azure DevOps organization is set up to complete the rest of this module. You'll set it up by running a template that creates a project in Azure DevOps.

The modules in this learning path are part of a progression. Each module has an associated Azure DevOps project.

> [!TIP]
> Even if you completed the previous module in the learning path, follow these instructions to create a new project and ensure that you give it a new name.

### Run the template

Run a template that sets up your Azure DevOps organization.

1. [Get and run the ADOGenerator project](https://github.com/microsoft/AzDevOpsDemoGenerator/blob/main/docs/RunApplication.md) in Visual Studio or the IDE of your choice.

1. When prompted to **Enter the template number from the list of templates**, enter **41** for **Test your Bicep code by using Azure Pipelines**, and then select **Enter**.

1. Choose your authentication method. You can [set up and use a Personal Access Token (PAT)](/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate#create-a-pat) or use device login.

   > [!NOTE]
   > If you set up a PAT, be sure to authorize the necessary [scopes](/azure/devops/integrate/get-started/authentication/oauth#scopes). For this module, you can use **Full access**, but in a real-world situation, you should grant only the necessary scopes.

1. Enter your Azure DevOps organization name, and then select **Enter**.

1. If prompted, enter your Azure DevOps PAT, then select **Enter**.

1. Enter a project name such as *toy-website-test*, then select **Enter**.

1. After your project is created, go to your Azure DevOps organization in your browser (at `https://dev.azure.com/<your-organization-name>/`) and select the project.

## Fork the repository

If you haven't already, create a fork of the **mslearn-test-bicep-code-using-github-actions** repository.

1. On GitHub, go to the [mslearn-tailspin-spacegame-web](https://github.com/MicrosoftDocs/mslearn-test-bicep-code-using-github-actions) repository.

1. Select **Fork** at the top-right of the screen.

1. Choose your GitHub account as the **Owner**, then select **Create fork**.

## Clone the repository

1. Select **Repos** > **Files**.

   :::image type="content" source="../media/4-repos-files.png" alt-text="Screenshot of Azure DevOps that shows the Repos menu. Files is highlighted.":::

1. Select **Clone**.

   :::image type="content" source="../media/4-clone.png" alt-text="Screenshot of Azure DevOps that shows the repository. The Clone button is highlighted." lightbox="../media/4-clone.png":::

1. If you're using macOS, you need a special password to clone the Git repository. Select **Generate Git credentials** and copy the displayed username and password somewhere safe.

1. Select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

    :::image type="content" source="../media/4-clone-visual-studio-code.png" alt-text="Screenshot of Azure DevOps that shows the repository settings. The button for cloning in Visual Studio Code is highlighted.":::

1. If a dialog prompts you to allow an extension to open the repository URI, select **Open**.

1. Create a folder to use for the repository, and then click **Select Repository Location**.

1. You're using this repository for the first time, so you're prompted to sign in.

   - If you're using Windows, enter the same credentials that you used to sign in to Azure DevOps earlier in this exercise.

   - If you're using macOS, enter the Git username and password that you generated a moment ago.

1. Visual Studio Code prompts you to open the repository. Select **Open**.

   :::image type="content" source="../../includes/media/open-cloned-repo.png" alt-text="Screenshot of the Visual Studio Code prompt to open the cloned repository. The Open button is highlighted.":::

[!include[](../../includes/azure-template-pipeline-sign-in.md)]

## Create a resource group in Azure

::: zone pivot="cli"

To create a resource group, run this Azure CLI command in the Visual Studio Code terminal:

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

   :::image type="content" source="../../includes/media/azure-devops-project-settings.png" alt-text="Screenshot of Azure DevOps. The menu item for project settings is highlighted.":::

1. Select **Service connections** > **Create service connection**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection.png" alt-text="Screenshot of Azure DevOps that shows the steps for creating a service connection.":::

1. Select **Azure Resource Manager** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-type.png" alt-text="Screenshot of Azure DevOps. The Azure Resource Manager service connection type is selected.":::

1. Select **Service principal (automatic)** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-principal-type.png" alt-text="Screenshot of Azure DevOps. The service principal option is selected.":::

1. In the **Subscription** dropdown list, select your Azure subscription.

   A pop-up window might prompt you to sign in to Azure. If it does, enter your credentials and sign in.

1. In the **Resource group** dropdown list, select **ToyWebsiteTest**.

1. In **Service connection name**, enter **ToyWebsiteTest**. Ensure that the **Grant access permission to all pipelines** checkbox is selected.

   :::image type="content" source="../media/4-create-service-connection-principal-details.png" alt-text="Screenshot that shows the steps for creating a service connection.":::

   > [!TIP]
   > For the sake of simplicity, you're giving every pipeline access to your service connection. When you create real service connections that work with production resources, consider restricting access to only the pipelines that need them.

1. Select **Save**.
