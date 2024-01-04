You've completed all the tasks for this module. Here, you'll clean up your Azure resources, move the work item to the **Done** state in Azure Boards, and clean up your Azure DevOps environment.

## Clean up Azure resources

The easiest way to delete your Azure App Service instances is to delete their parent resource group. When you delete a resource group, you delete all resources within that group. To delete your resource group:

1. Navigate to [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.

1. From the menu bar, select Cloud Shell. When prompted, select the **Bash** experience.

    :::image type="content" source="../../shared/media/azure-portal-menu-cloud-shell.png" alt-text="Screenshot of the Azure portal showing the location of the Cloud Shell menu item.":::

1. Run the following command to delete your resource group (*tailspin-space-game-rg*). When prompted, enter *y* to confirm your choice.

    ```azurecli
    az group delete --name tailspin-space-game-rg
    ```

1. To confirm the deletion, execute the following command and ensure that your resource group is not listed anymore.

    ```azurecli
    az group list --output table
    ```

## Move the work item to Done

Here, you'll move the work item that you assigned to yourself earlier in this module. You'll move **Create container version of web site using Docker** to the **Done** column.

In practice, "Done" often means putting working software into the hands of your users. For learning purposes, you'll mark this work as "Done" because you fulfilled the goal for the Tailspin team. They wanted to package and deploy their web app as a Docker container.

At the end of each *sprint*, or work iteration, you and your team can hold a retrospective meeting. In the meeting, share the work you completed, what went well, and what you can improve.

To complete the work item:

1. From Azure DevOps, navigate to **Boards** and then select **Boards** from the menu.
1. Move the **Create container version of web site using Docker** work item from the **Doing** column to the **Done** column.

    :::image type="content" source="../media/5-azure-boards-wi1-done.png" alt-text="Screenshot of Azure Boards, showing the card in the Done column.":::

## Disable the pipeline or delete your project

Each module in this learning path provides a template. You can run the template to create a clean environment for the module.

Running multiple templates gives you multiple Azure Pipelines projects. Each project points to the same GitHub repository. This setup can trigger multiple pipelines to run each time you push a change to your GitHub repository. The pipeline runs use up free build minutes on our hosted agents. To avoid losing those free build minutes, disable or delete your pipeline before you move to the next module.

Choose one of the following options:

### Option 1: Disable the pipeline

Disable the pipeline so that it doesn't process build requests. You can re-enable the build pipeline later if you want to. Choose this option if you want to keep your DevOps project and your build pipeline for future reference.

To disable the pipeline:

1. In Azure Pipelines, navigate to your pipeline.
1. From the **More actions** (***...***) drop-down menu, select **Settings**:

    :::image type="content" source="../../shared/media/azure-pipelines-settings-button.png" alt-text="Screenshot of Azure Pipelines showing the location of the Settings menu.":::

1. Under **Processing of new run requests**, select **Disabled**, then select **Save**. Your pipeline will no longer process new build requests.

### Option 2: Delete the Azure DevOps project

Delete your Azure DevOps project, including the contents of Azure Boards and your build pipeline. In future modules, you can run another template that brings up a new project in a state where this project leaves off. Choose this option if you don't need your DevOps project for future reference.

To delete the project:

1. In Azure DevOps, navigate to your project. Earlier, we recommended that you name this project **Space Game - web - Docker**.
1. Select **Project settings** in the lower corner.
1. Navigate to the bottom of the **Project details** section and choose the **Delete** option.

    :::image type="content" source="../../shared/media/azure-devops-delete-project.png" alt-text="Screenshot of Azure Pipelines showing the location of the Delete button.":::

1. Once the new window appears, input the project name and select **Delete** once more.
