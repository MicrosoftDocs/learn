You're all done with the tasks for this module. Here, you'll move the work item to the **Done** state on Azure Boards and clean up your Microsoft Azure DevOps environment.

> [!IMPORTANT]
> This page contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps if you ran the template earlier in this module.

## Move the work item to Done

Move the work item you assigned to yourself earlier in this module, "Move model data to its own package," to the **Done** column.

In practice, the definition of "Done" often means having working software in the hands of your users. Here, for learning purposes, you'll mark this work as complete because you set up a build pipeline that publishes NuGet packages to Azure Artifacts.

At the end of each sprint, or work iteration, you and your team might hold a retrospective meeting. You share the work you completed, what went well in the sprint, and what could be improved.

To complete the work item:

1. From Azure DevOps, go to **Boards**, and from the menu, select **Boards**.
1. Move the **Move model data to its own package** work item from the **Doing** column to the **Done** column.

    :::image type="content" source="../media/8-azure-boards-wi6-done.png" alt-text="A screenshot of Azure Boards showing the work item in the Done column.":::

## Disable the pipeline or delete your project

Each module in this learning path provides a template you can run to create a clean environment for the duration of the module.

Running multiple templates gives you multiple Azure Pipelines projects, each pointing to the same GitHub repository. This can trigger multiple pipelines to run each time you push a change to your GitHub repository, which can cause you to run out of free build minutes on our hosted agents. Therefore, it's important that you disable or delete your pipeline before moving on to the next module.

Choose one of the following options.

### Option 1: Disable the pipeline

This option disables the pipeline so that it doesn't process further build requests. You can re-enable the build pipeline later if you want to. Select this option if you want to keep your Azure DevOps project and your build pipeline for future reference.

To disable the pipeline:

1. In Azure Pipelines, navigate to your pipeline.
1. From the dropdown, select **Settings**.

    :::image type="content" source="../../shared/media/azure-pipelines-settings-button.png" alt-text="A screenshot of Azure Pipelines showing the location of the Settings menu.":::
1. Under **Processing of new run requests**, select **Disabled**, and then select **Save**.

    Your pipeline will no longer process build requests.
1. Repeat the process for the second pipeline.

### Option 2: Delete the Azure DevOps project

This option deletes your Azure DevOps project, including what's on Azure Boards and your build pipeline. In future modules, you'll be able to run another template that creates a new project in a state where this one leaves off. Select this option if you don't need your Azure DevOps project for future reference.

To delete the project:

1. From Azure DevOps, go to your project. Earlier, we recommended that you name this project **Space Game - web - Dependencies**.
1. Select **Project settings** in the lower-left corner.
1. From the **Project details** area, scroll to the bottom, and select **Delete**.

    :::image type="content" source="../../shared/media/azure-devops-delete-project.png" alt-text="A screenshot of Azure Pipelines showing the location of the Delete button.":::
1. From the window that appears, enter the project name and select **Delete** a second time.

    Your project is now deleted.
