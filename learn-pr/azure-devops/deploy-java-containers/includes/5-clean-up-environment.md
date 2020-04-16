You're finished with the tasks for this module. Here you'll clean up your Azure resources and clean up your Azure DevOps environment.

> [!IMPORTANT]
> This page contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. It also helps ensure that you're not charged for Azure resources after you complete this module.

## Clean up Azure resources

Here you delete your Azure App Service instance. The easiest way to delete the instance is to delete its parent resource group. When you delete a resource group, you delete all resources in that group.

You may use the Azure portal user interface or Azure CLI to manage resources. Here you tear down your deployment by using the Azure CLI through Azure Cloud Shell. The steps are similar to the steps that you used when you created the resources.

To clean up your resource group:

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. From the menu bar, select Cloud Shell. When prompted, select the **Bash** experience.

    ![Selecting Cloud Shell from the menu bar](../../shared/media/azure-portal-menu-cloud-shell.png)

1. Run the following `az group delete` command to delete the resource group that you used, `java-containers-cicd-rg`.

    ```bash
    az group delete --name java-containers-cicd-rg
    ```

    When prompted, enter `y` to confirm the operation.

1. As an optional step, after the previous command finishes, run the following `az group list` command.

    ```bash
    az group list --output table
    ```

    You see that the resource group `java-containers-cicd-rg` no longer exists.

## Disable the pipeline or delete your project

This project was configured to automatically run a pipeline each time there was a change to the repo. The pipeline runs use up free build minutes on our hosted agents. To avoid losing those free build minutes, disable or delete your pipeline before you move to the next module.

Choose one of the following options.

### Option 1 - Disable the pipeline

Disable the pipeline so that it doesn't process build requests. You can re-enable the build pipeline later if you want to. Choose this option if you want to keep your DevOps project and your build pipeline for future reference.

To disable the pipeline:

1. In Azure Pipelines, navigate to your pipeline.
1. Select **Edit**.

    ![Azure Pipelines, showing the location of the Edit button](../../shared/media/azure-pipelines-edit-button.png)
1. From the menu in the upper corner, select **Settings**.

    ![Azure Pipelines, showing the Settings menu option](../../shared/media/azure-pipelines-settings-button.png)
1. Under **Processing of new run requests**, select **Disabled** > **Save**.

    Your pipeline will no longer process build requests.

### Option 2 - Delete the Azure DevOps project

Delete your Azure DevOps project, including the build pipeline. Choose this option if you don't need your DevOps project for future reference.

To delete the project:

1. In Azure DevOps, navigate to your project. This will be the name you entered when creating the project after installing the Azure Pipelines extension in GitHub.
1. Select the gear icon next to the project name.

    The icon might not appear until you move your mouse over the area.

    ![Azure DevOps, showing the gear icon](../../shared/media/azure-devops-project-gear.png)
1. In the **Project details** area, go to the bottom and select **Delete**.

    ![Azure DevOps, showing the Delete button to delete your project](../../shared/media/azure-devops-delete-project.png)
1. In the window that appears, enter the project name. Select **Delete** again.

    Your project is now deleted.