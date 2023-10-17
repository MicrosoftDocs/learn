When you finish the tasks for this module, it's important to clean up your Azure resources and Azure DevOps environment. Remove or disable your resources to ensure that you don't run out of free Azure DevOps build minutes and aren't charged for Azure resources.

> [!IMPORTANT]
> This unit contains important cleanup steps. Be sure to follow these steps if you created any Azure or Azure Pipelines resources for this module, even if you didn't complete the module.

## Clean up Azure resources

The easiest way to delete your Azure App Service instance and related resources is to delete their parent resource group. When you delete a resource group, you delete all the resources in that group.

You can use the Azure portal or Azure CLI to delete the resource group. The following steps use Azure CLI through Azure Cloud Shell, similar to the way you created the resources.

To delete your resource group:

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), select the **Cloud Shell** icon in the top menu bar.

1. When the Cloud Shell interface appears, verify that **Bash** is selected at the top of the interface.

1. Run the following `az group delete` command to delete the resource group `java-containers-cicd-rg`.

   ```azurecli
   az group delete --name java-containers-cicd-rg
   ```

   When prompted, enter `y` to confirm.

1. Optionally, after the previous command finishes, run the following `az group list` command to confirm that the resource group `java-containers-cicd-rg` no longer exists.

   ```azurecli
   az group list --output table
   ```

## Disable the pipeline or delete your project

The Azure Pipelines CI/CD pipeline runs automatically every time there's a change in the GitHub repository, using your allotted build minutes on hosted agents. To avoid using up your free build minutes, disable or delete your pipeline, or delete your Azure DevOps project, when you're finished with this module.

### Option 1: Disable the pipeline

Disable the pipeline so that it doesn't process build requests. You can reenable the pipeline later if you want to. Choose this option if you want to keep your DevOps project and pipeline for future reference.

To disable the pipeline:

1. In Azure Pipelines, select your pipeline.
1. On the pipeline page, select the **More options** icon at upper right, and then select **Settings** from the dropdown menu.

   :::image type="content" source="../../shared/media/azure-pipelines-settings-button.png" alt-text="A screenshot of Azure Pipelines showing the location of the Settings menu.":::

1. On the **Pipeline settings** screen, under **Processing of new run requests**, select **Disabled**, and then select **Save**. Your pipeline now no longer processes build requests.

You can also delete the pipeline, by selecting **Delete** from the dropdown **More options** menu.

### Option 2: Delete the Azure DevOps project

If you don't need your Azure DevOps project, you can delete it, which also deletes the build pipeline.

To delete the project:

1. In your Azure DevOps project, select **Project settings** at lower left.
1. At the bottom of the **Project details** page, select **Delete**.

   :::image type="content" source="../../shared/media/azure-devops-delete-project.png" alt-text="A screenshot showing the location of the Delete button.":::

1. Enter the project name and select **Delete** again. Your project is deleted.
