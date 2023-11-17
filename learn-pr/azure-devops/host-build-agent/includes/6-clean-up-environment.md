You're all done with the tasks for this module. In this unit, you move the work item to the **Done** state on Microsoft Azure Boards and clean up your Microsoft Azure DevOps environment.

> [!IMPORTANT]
> This page contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps if you ran the template earlier in this module.

## Clean up Azure resources

Here, you delete your Azure VM. The easiest way to delete resources is to delete their parent resource group. When you delete a resource group, you delete all resources in that group.

In the [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true) module, you managed Azure resources through the Azure portal. Here you tear down your deployment by using the Azure CLI through Azure Cloud Shell. The steps are similar to the steps that you used when you created the resources.

To clean up your resource group:

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true), and sign in.
1. From the menu bar, select Cloud Shell. When prompted, select the **Bash** experience.

    :::image type="content" source="../../shared/media/azure-portal-menu-cloud-shell.png" alt-text="A screenshot of the Azure portal showing the location of the Cloud Shell menu item.":::

1. To delete the resource group that you used, `tailspin-space-game-rg`, run the following `az group delete` command.

    ```azurecli
    az group delete --name tailspin-space-game-rg
    ```

    When prompted, to confirm the operation, enter `y`.

    > [!NOTE]
    > If you are still signed in to SSH in Cloud Shell window from the previous step, run the `exit` command to exit SSH and then run the `az delete` command.

1. As an optional step, after the previous command finishes, run the following `az group list` command.

    ```azurecli
    az group list --output table
    ```

    You see that the resource group `tailspin-space-game-rg` no longer exists.

## Move the work item to Done

In this section, you move the work item that you previously assigned to yourself, **Investigate hosted vs private build servers**, to the **Done** column.

In practice, the definition of "Done" often means that working software is in the hands of your users. In this unit, for learning purposes, you mark this work as complete, because you have a private build agent working on Azure Pipelines.

At the end of each sprint or work iteration, you and your team might hold a retrospective meeting. In the meeting, you can share the work you completed, what went well in the sprint, and what could be improved.

To complete the work item:

1. From Azure DevOps, go to **Boards** and then, in the left pane, select **Boards**.
1. Drag the **Investigate hosted vs private build servers** work item from the **Doing** column to the **Done** column.

    :::image type="content" source="../media/6-azure-boards-wi7-done.png" alt-text="A screenshot of Azure Boards showing the work item in the Done column.":::

## Disable the pipeline or delete your project

Each module in this learning path provides a template that you can run to create a clean environment for the duration of the module.

Running multiple templates creates multiple Azure Pipelines projects, each pointing to the same GitHub repository. This action can cause multiple pipelines to run each time you push a change to your GitHub repository. This action, in turn, can cause you to run out of free build minutes on your hosted agents. Therefore, it's important to disable or delete your pipeline before you move on to the next module.

Choose either of the next two options.

### Option 1: Disable the pipeline

This option disables the pipeline so that it doesn't process further build requests. You can reenable the build pipeline later if you want to. Choose this option if you want to keep your DevOps project and your build pipeline for future reference.

To disable the pipeline:

1. In Azure Pipelines, go to your pipeline.
1. From the dropdown menu, select **Settings**:

    :::image type="content" source="../../shared/media/azure-pipelines-settings-button.png" alt-text="A screenshot of Azure Pipelines showing the location of the Settings menu.":::
1. Under **Processing of new run requests**, select **Disabled** and then select **Save**.

    Your pipeline will no longer process build requests.

### Option 2: Delete the Azure DevOps project

This option deletes your Azure DevOps project, including what's on Azure Boards and your build pipeline. In future modules, you'll be able to run another template that brings up a new project in a state where this one leaves off. Choose this option if you don't need your DevOps project for future reference.

To delete the project:

1. In Azure DevOps, go to your project. Earlier, we recommended that you name this project **Space Game - web - Agent**.
1. Select **Project settings** in the **lower left** corner of the Azure DevOps page.
1. In the **Project details** area, scroll down, and then select **Delete**.

    :::image type="content" source="../../shared/media/azure-devops-delete-project.png" alt-text="A screenshot of Azure Pipelines showing the location of the Delete button.":::
1. In the window that appears, enter the project name, and then select **Delete** a second time.

    Your project is now deleted.
