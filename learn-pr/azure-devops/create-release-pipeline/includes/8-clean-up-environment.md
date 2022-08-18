You're finished with the tasks for this module. Here you tear down the Azure resources you created for this module and also clean up your Azure DevOps environment.

> [!IMPORTANT]
> This page contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. It also ensures that you don't pay for Azure resources you no longer need.

## Clean up Azure resources

Here you delete your Azure App Service instance. One way to delete Azure resources, such as an App Service instance, is to delete its parent resource group. Deleting a resource group deletes all resources in that group.

To clean up your resource group:

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. Select **Resource groups** from the menu.
1. Select your resource group, **tailspin-space-game-rg**.
1. Select **Delete resource group**.
1. Enter **tailspin-space-game-rg** into the text box, and then select **Delete**.

    After the deletion process finishes, you return to the list of resource groups in your Azure subscription.

## Disable the pipeline or delete your project

Each module in this learning path provides a template you can run to create a clean environment for the module.

When you run multiple templates, you get multiple Azure Pipelines projects, each pointing to the same GitHub repository. This setup can trigger multiple pipelines to run each time you push a change to your GitHub repository, consuming free build minutes on our hosted agents. Therefore, it's important to disable or delete your pipeline before you move to the next module.

Choose one of the following options.

### Option 1: Disable the pipeline

This option disables the pipeline so that it doesn't process further build requests. You can re-enable the build pipeline later if you want to. Choose this option if you want to keep your DevOps project, and your build pipeline for future reference.

To disable the pipeline:

1. In Azure Pipelines, go to your pipeline.
1. From the dropdown menu, select **Settings**:

    :::image type="content" source="../../shared/media/azure-pipelines-settings-button.png" alt-text="A screenshot of Azure Pipelines showing the location of the Settings menu.":::
1. Under **Processing of new run requests**, select **Disabled** and then select **Save**.

    Your pipeline will no longer process build requests.

### Option 2: Delete the Azure DevOps project

This option deletes your Azure DevOps project, including content on Azure Boards and your build pipeline. In future modules, you'll run another template that brings up a new project that reflects the state in which this module ends. Choose this option if you don't need your DevOps project for future reference.

To delete the project:

1. From Azure DevOps, go to your project. Earlier, we recommended that you name this project **Space Game - web - Release**.
1. Select **Project settings** in the lower-left corner of your Azure DevOps page.
1. In the **Project details** area, scroll down, and then select **Delete**.

    :::image type="content" source="../../shared/media/azure-devops-delete-project.png" alt-text="A screenshot of Azure Pipelines showing the location of the Delete button.":::
1. From the window that appears, enter the project name and select **Delete** a second time.

    Your project is now deleted.
