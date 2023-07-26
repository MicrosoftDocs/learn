Having completed the assigned tasks for this module, the next steps involve cleaning up your Azure resources, transitioning the work item to the Done state on Azure Boards, and cleaning up your Azure DevOps environment.

> [!IMPORTANT]
> Performing this cleanup is essential in order to to prevent incurring charges for Azure resources beyond the completion of this module.

## Clean up Azure resources

The easiest way to clean up your Azure resources is to delete their parent resource group. When you delete a resource group, you delete all resources in that group. To delete your resource group:

1. Navigate to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.

1. Select Cloud Shell from the menu, and then select **Bash**.

    :::image type="content" source="../../shared/media/azure-portal-menu-cloud-shell.png" alt-text="Screenshot of the Azure portal showing the location of the Cloud Shell menu item.":::

1. Run the following command to delete the resource group you created. Type in **y** when prompted to confirm the deletion.

    ```azurecli
    az group delete --name tailspin-space-game-rg
    ```

1. Optionally, after the previous command finishes, you can run the following command to confirm the deletion. You will notice that the resource group *tailspin-space-game-rg* no longer appears in the list.

    ```azurecli
    az group list --output table
    ```

## Move the work item to Done

In this step, you will move the work item that you previously assigned to yourself in this module to the "Done" column. In practice, "Done" typically means delivering working software to users. However, for the purposes of this learning module, it means that the specific goal has been accomplished. To complete the work item:

1. Navigate to your Azure DevOps project, and then select **Boards** then **Boards**.

1. Move the **Create multi-container version of web site orchestrated with Kubernetes** work item to the **Done** column.

    :::image type="content" source="../media/5-azure-boards-wi1-done.png" alt-text="Screenshot of Azure Boards, showing the card in the Done column.":::

## Disable the pipeline or delete your project

This learning path provides a template for each module that you can use to create a fresh environment. If you run multiple templates, you'll end up with multiple Azure Pipelines projects that point to the same GitHub repository. This setup can cause multiple pipelines to run each time you push a change to your GitHub repository, which can create issues. Therefore, before moving to the next module, it's recommended to disable or delete the pipeline to avoid losing free build minutes.

Choose one of the following options:

### Option 1: Disable the pipeline

Disable the pipeline to stop it from processing new requests. You can choose to re-enable your pipeline later if you wish to. This option is suitable if you want to retain your DevOps project and deployment pipeline for future reference.

To disable the pipeline:

1. Select **Pipelines**, and then select your pipeline.

1. Select **Settings** from the drop-down menu.

    :::image type="content" source="../../shared/media/azure-pipelines-settings-button.png" alt-text="Screenshot of Azure Pipelines showing the location of the Settings menu.":::

1. Select **Disabled** and then select **Save**.

### Option 2: Delete the Azure DevOps project

If you don't need your DevOps project for future reference, you can delete it. For future modules, you can run another template that spins up a new project in the state where this project leaves off. This option is suitable if you're certain you won't need this project again.

To delete the project:

1. Navigate to your project in the Azure DevOps portal.

1. Select **Project settings** from the bottom-left corner.

1. From the **Overview** section, scroll all the way down and then select **Delete**.

    :::image type="content" source="../../shared/media/azure-devops-delete-project.png" alt-text="Screenshot of Azure Pipelines showing the location of the Delete button.":::

1. Confirm the project name and then select **Delete** to delete your project.
