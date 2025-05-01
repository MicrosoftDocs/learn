In this unit, you ensure that your Microsoft Azure DevOps organization is set up to complete the rest of this module.

To do this configuration, you:

> [!div class="checklist"]
> * Set up an Azure DevOps project for this module.
> * On Azure Boards, move the work item for this module to the **Doing** column.
> * Make sure your project is set up locally so that you can push changes to the pipeline.

## Get the Azure DevOps project

Here, you make sure that your Azure DevOps organization is set up to complete the rest of this module. You do this set up by running a template that creates a project for you in Azure DevOps.

The modules in this learning path form a progression, where you follow the Tailspin web team through their DevOps journey. For learning purposes, each module has an associated Azure DevOps project.

### Run the template

Run a template that sets up your Azure DevOps organization.

1. [Get and run the ADOGenerator project](https://github.com/microsoft/AzDevOpsDemoGenerator/blob/main/docs/RunApplication.md) in Visual Studio or the IDE of your choice.

1. When prompted to **Enter the template number from the list of templates**, enter **27** for **Manage build dependencies with Azure Artifacts**, then press **Enter**.

1. Choose your authentication method. You can [set up and use a Personal Access Token (PAT)](/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate#create-a-pat) or use device login.

    > [!NOTE]
    > If you set up a PAT, make sure to authorize the necessary [scopes](/azure/devops/integrate/get-started/authentication/oauth#scopes). For this module, you can use **Full access**, but in a real-world situation, you should ensure you grant only the necessary scopes.

1. Enter your Azure DevOps organization name, then press **Enter**.

1. If prompted, enter your Azure DevOps PAT, then press **Enter**.

1. Enter a project name such as *Space Game - web - Dependencies*, then press **Enter**.

1. Once your project is created, go to your Azure DevOps organization in your browser (at `https://dev.azure.com/<your-organization-name>/`) and select the project.

### Fork the repository

If you haven't already, create a fork of the **mslearn-tailspin-spacegame-web** repository.

1. On GitHub, go to the [mslearn-tailspin-spacegame-web](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web) repository.

1. Select **Fork** at the top-right of the screen.

1. Choose your GitHub account as the **Owner**, then select **Create fork**.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/manage-build-dependencies/8-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps even if you don't complete this module.

[!include[](../../shared/includes/project-visibility.md)]

## Move the work item to Doing

In this section, you assign a work item to yourself that relates to this module on Azure Boards. You also move the work item to the **Doing** state. In practice, you and your team would create work items at the start of each sprint, or work iteration.

Assigning work in this way gives you a checklist from which to work. It gives others on your team visibility into what you're working on and how much work is left. It also helps the team enforce work-in-progress limits so that the team doesn't take on too much work at one time.

Recall that the team settled on these seven top issues:

:::image type="content" source="../../shared/media/build-all-tasks.png" alt-text="A screenshot of Azure Boards showing a backlog of issues.":::

> [!NOTE]
> Within an Azure DevOps organization, work items are numbered sequentially. In your project, the number that's assigned to each work item might not match what you see here.

Here, you move the sixth item, **Move model data to its own package** to the **Doing** column, and assign yourself to the work item.

Recall that **Move model data to its own package** relates to moving reusable code to its own NuGet package, so that package can be shared among multiple apps.

:::image type="content" source="../media/3-work-item-details.png" alt-text="A screenshot of Azure Boards showing work item details for the Move model data to its own package issue.":::

To set up the work item:

1. From Azure DevOps, go to **Boards**, and select **Boards** from the menu.

    :::image type="content" source="../../shared/media/azure-devops-boards-menu.png" alt-text="A screenshot of Azure DevOps showing the location of the Boards menu.":::

1. From the **Move model data to its own package** work item, select the down arrow at the bottom of the card, then assign the work item to yourself.

    :::image type="content" source="../../shared/media/azure-boards-down-chevron.png" alt-text="A screenshot of Azure Boards showing the location of the down arrow.":::

1. Move the work item from the **To Do** to the **Doing** column.

    :::image type="content" source="../media/3-azure-boards-wi6-doing.png" alt-text="A screenshot of Azure Boards, showing the card in the Doing column.":::

At the end of this module, after you complete the task, you move the card to the **Done** column.

[!include[](../../shared/includes/build-local-setup.md)]
