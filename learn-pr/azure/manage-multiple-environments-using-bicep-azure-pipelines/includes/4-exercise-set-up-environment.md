[!INCLUDE [BYO subscription explanation](../../../includes/azure-exercise-subscription-prerequisite.md)]

Before you start to work on your toy company's website pipeline, you need to configure your environment. In this unit, you make sure that your Azure and Azure DevOps environments are set up to complete the rest of this module.

To meet these objectives, you'll:

> [!div class="checklist"]
>
> - Set up an Azure DevOps project for this module.
> - Clone the project's repository to your computer.
> - Create two resource groups in Azure.
> - Create two service connections and environments in Azure Pipelines.
> - Remove the resources that you don't need in the pre-created Azure DevOps project.

## Get the Azure DevOps project

Make sure that your Azure DevOps organization is set up to complete the rest of this module. You set it up by running a template that creates a project in Azure DevOps.

The modules in this learning path are part of a progression. For learning purposes, each module has an associated Azure DevOps project.

> [!TIP]
> Even if you completed the previous module in the learning path, please follow these instructions to create a new project. Be sure to give it a new name.

### Run the template

Run a template that sets up your Azure DevOps project.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?name=bicepenvironments)

On the Azure DevOps Demo Generator site, follow these steps:

1. Select **Sign In** and accept the usage terms.

1. On the **Create New Project** page, select your Azure DevOps organization. Then enter a project name, such as _toy-website-environments_.

    :::image type="content" source="../media/4-create-new-project.png" alt-text="Screenshot that shows creating a project through the Azure DevOps Demo Generator.":::

1. Select **Create Project**.

    The template takes a few moments to run. It automatically creates a pipeline and Bicep file for you to work with in the subsequent exercises.

1. Select **Navigate to project** to go to your project in Azure DevOps.

[!INCLUDE [](../../includes/cleanup-steps.md)]

## Clone the repository

1. Select **Repos** > **Files**.

   :::image type="content" source="../media/4-repos-files.png" alt-text="Screenshot of Azure DevOps that shows the Repos menu and the Files item.":::

1. Select **Clone**.

   :::image type="content" source="../media/4-clone.png" alt-text="Screenshot of Azure DevOps that shows the repository and the Clone button.":::

1. If you're using macOS, you need a special password to clone the Git repository. Select **Generate Git credentials** and copy the displayed username and password to somewhere safe.

1. Select **Clone in VS Code**. If you're prompted to allow Visual Studio Code to open, select **Open**.

    :::image type="content" source="../media/4-clone-visual-studio-code.png" alt-text="Screenshot of Azure DevOps that shows the repository settings and the button for cloning in Visual Studio Code.":::

1. If a dialog box appears, prompting you to allow an extension to open the repository URI, select Open.

1. Create a folder to use for the repository, and then choose **Select Repository Location**.

1. You're using this repository for the first time, so you're prompted to sign in.

   - If you're using Windows, enter the same credentials that you used to sign in to Azure DevOps earlier in this exercise.

   - If you're using macOS, enter the Git username and password that you generated a few moments ago.

1. Visual Studio Code prompts you to open the repository. Select **Open**.

   :::image type="content" source="../../includes/media/open-cloned-repo.png" alt-text="Screenshot of Visual Studio Code that shows a prompt to open the cloned repository.":::

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

Next, create two service connections in Azure Pipelines: one for your test environment and another for your production environment. This process automatically creates a service principal in Azure. It also grants the service principal the Contributor role on your resource group, which allows your pipeline to deploy to the resource group.

1. In your browser, select **Project settings**.

   :::image type="content" source="../../includes/media/azure-devops-project-settings.png" alt-text="Screenshot of Azure DevOps that shows the menu item for project settings.":::

1. Select **Service connections** > **Create service connection**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection.png" alt-text="Screenshot of Azure DevOps that shows the button for creating a service connection.":::

1. Select **Azure Resource Manager** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-type.png" alt-text="Screenshot of Azure DevOps that shows the Azure Resource Manager service connection type.":::

1. Select **Service principal (automatic)** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-principal-type.png" alt-text="Screenshot of Azure DevOps that shows the service principal option.":::

1. In the **Subscription** dropdown list, select your Azure subscription.

   A popup window might appear, asking you to sign in to Azure. If it does, enter your credentials and sign in.

1. In the **Resource group** dropdown list, select **ToyWebsiteTest**.

1. In **Service connection name**, enter **ToyWebsiteTest**. Ensure that the **Grant access permission to all pipelines** checkbox is selected, and then select **Save**.

   :::image type="content" source="../media/4-create-service-connection-principal-details-test.png" alt-text="Screenshot of Azure DevOps that shows completed details for creating a service connection for the test environment.":::

   > [!TIP]
   > For simplicity, you're giving every pipeline access to your service connection. When you create real service connections that work with production resources, consider restricting access to only the pipelines that need them.

1. Repeat the preceding process to create another new service connection named **ToyWebsiteProduction**, which deploys to the resource group named **ToyWebsiteProduction**.

   :::image type="content" source="../media/4-create-service-connection-principal-details-production.png" alt-text="Screenshot of Azure DevOps that shows the page for creating a service connection for the production environment, with completed details.":::

   If the resource group list isn't updated, refresh the page in your browser and try again.

## Create environments in Azure Pipelines

1. In your browser, go to **Pipelines** > **Environments**.

   :::image type="content" source="../media/4-environments.png" alt-text="Screenshot of the Azure DevOps interface that shows the Pipelines menu and the Environments item.":::

1. Select **New environment**.

   :::image type="content" source="../media/4-environments-new.png" alt-text="Screenshot of the Azure DevOps interface that shows the Environments page and the button for creating an environment.":::

1. Enter **Test** as the environment name.

   Leave the description blank. For **Resource**, select **None**. Then select **Create**.

   > [!NOTE]
   > In Azure Pipelines, environments are used to enable deployment features. Some of these features apply only when you're deploying to Kubernetes or to virtual machines. In this module, we don't use these features and you can ignore them.

   :::image type="content" source="../media/4-environments-new-details-test.png" alt-text="Screenshot of the Azure DevOps page for a new environment named Test, with completed details and the Create button.":::

   Before a pipeline can use the environment, you must grant it permission. For simplicity, you allow all pipelines to access the environment. In your own pipelines, you should restrict access to environments to just the pipelines that require it.

1. Select the button with three dots and select **Security**.

   :::image type="content" source="../media/4-environment-security.png" alt-text="Screenshot of the Azure DevOps page for an environment named Test, with the More Actions menu displayed and the Security item highlighted.":::

1. In the section named **Pipeline permissions**, if there's a button titled **Restrict permission**, select it.

1. Select the button with three dots. Select **Open access**.

   :::image type="content" source="../media/4-environment-security-open.png" alt-text="Screenshot of the Azure DevOps page for an environment named Test, with the More Actions menu displayed and the Open access item highlighted.":::

1. Select the left arrow twice to return to the environments list.

   :::image type="content" source="../media/4-environment-back.png" alt-text="Screenshot of the Azure DevOps page for an environment named Test, including the arrow button.":::

1. Repeat the process to create another environment named **Production**. Remember to set it to open access.

   :::image type="content" source="../media/4-environments-new-details-production.png" alt-text="Screenshot of the Azure DevOps page for a new environment named Production, with completed details.":::

   Leave the production environment page open.

## Add an approval check to the production environment

1. Near the upper right of the page, select the button with three dots and select **Approvals and checks** from the pop-up menu.

   :::image type="content" source="../media/4-add-check.png" alt-text="Screenshot of the Azure DevOps interface that shows the Website environment and the button with three dots.":::

1. Select **Approvals**.

   :::image type="content" source="../media/4-add-check-approval.png" alt-text="Screenshot of the Azure DevOps interface that shows the page for adding a check and the Approvals item.":::

1. In the **Approvers** text box, type your own name and select yourself.

1. Select the arrow button next to **Advanced**.

   Notice that, by default, approvers are allowed to approve the runs that they've triggered. Because you're the only person using this pipeline, leave this checkbox selected. In other organizations, you might need to specify a different approver to meet compliance requirements.

1. Select **Create**.

   :::image type="content" source="../media/4-add-check-approval-details.png" alt-text="Screenshot of the Azure DevOps interface that shows the page for adding an approval check, with completed details and the Create button.":::

## Delete the old environment

In the previous versions of the pipeline, you used a single environment named _Website_. Now that you've created pipeline environments that represent your new environments, you can delete the old pipeline environment.

1. Go to **Pipelines** > **Environments**.

1. Select the **Website** environment.

   :::image type="content" source="../media/4-environments-website.png" alt-text="Screenshot of the Azure DevOps interface that shows the list of environments and the Website environment.":::

1. Near the upper right of the page, select the button with three dots and select **Delete** from the pop-up menu.

   :::image type="content" source="../media/4-environment-delete.png" alt-text="Screenshot of the Azure DevOps interface that shows the test environment, with the More Actions menu and the Delete button highlighted.":::

1. Select **Delete** to confirm the deletion.

## Delete the old variables

In the previous versions of the pipeline, you used a single set of variables to define the parameters and deployment configuration. Now that you're deploying to multiple environments, you can delete those variables and replace them with environment-specific sets of variables soon.

1. Go to **Pipelines** > **Pipelines**.

1. Select the **toy-website-environments** pipeline.

1. Select the **Edit** button.

   :::image type="content" source="../media/4-pipeline-edit.png" alt-text="Screenshot of the Azure DevOps interface that shows the pipeline and the Edit button.":::

1. Select the **Variables** button.

   :::image type="content" source="../media/4-pipeline-variables.png" alt-text="Screenshot of the Azure DevOps interface that shows the pipeline and the Variables button.":::

1. Select the **Delete variable** button for each of the three variables.

   :::image type="content" source="../media/4-variables-delete.png" alt-text="Screenshot of the Azure DevOps interface that shows the list of variables and the delete button.":::

1. Select **Save**.

   :::image type="content" source="../media/4-variables-delete-save.png" alt-text="Screenshot of the Azure DevOps interface that shows the deletion of three variables and the Save button.":::
