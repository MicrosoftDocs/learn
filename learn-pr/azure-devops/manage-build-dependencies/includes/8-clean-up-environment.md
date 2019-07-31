You're all done with the tasks for this module. Here, you'll move the work item to the **Done** state on Azure Boards, and clean up your Azure DevOps environment.

> [!IMPORTANT]
> This page contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps if you ran the template earlier in this module.

## Move the work item to Done

Move the work item you assigned to yourself earlier in this module, "Move model data to its own package," to the **Done** column.

In practice, the definition of "Done" often means having working software in the hands of your users. Here, for learning purposes, you'll mark this work as complete because you set up a build pipeline that publishes NuGet packages to Azure Artifacts.

At the end of each sprint, or work iteration, you and your team might hold a retrospective meeting. You share the work you completed, what went well in the sprint, and what could be improved.

To complete the work item:

1. From Azure DevOps, go to **Boards**, and then select **Boards** from the menu.
1. Move the **Move model data to its own package** work item from the **Doing** column to the **Done** column.

    ![Screenshot of Azure Boards, showing the card in the Done column](../media/8-azure-boards-wi6-done.png)

## Disable the pipeline or delete your project

> [!IMPORTANT]
> You can skip this part if you plan to continue to the next module by using the same Azure DevOps project.

Each module in this learning path provides a template you can run to create a clean environment for the duration of the module.

Running multiple templates gives you multiple Azure Pipelines projects, each pointing to the same GitHub repository. This can trigger multiple pipelines to run each time you push a change to your GitHub repository, which can cause you to run out of free build minutes on our hosted agents. Therefore, it's important that you disable or delete your pipeline before moving on to the next module.

Choose one of the following options.

### Option 1: Disable the pipeline

This option disables the pipeline so that it doesn't process further build requests. You can re-enable the build pipeline later if you want to. Choose this option if you want to keep your Azure DevOps project and your build pipeline for future reference.

To disable the pipeline:

1. From Azure Pipelines, go to your pipeline.
1. Select **Edit**.

    ![Screenshot of Azure Pipelines showing the location of the Edit button](../../shared/media/azure-pipelines-edit-button.png)
1. From the menu in the upper corner, select **Settings**.

    ![Screenshot of Azure Pipelines showing the Settings menu option](../../shared/media/azure-pipelines-settings-button.png)
1. Under **Processing of new run requests**, select **Disabled**, and then select **Save**.

    Your pipeline no longer processes build requests.

### Option 2: Delete the Azure DevOps project

This option deletes your Azure DevOps project, including what's on Azure Boards and your build pipeline. In future modules, you'll be able to run another template that brings up a new project in a state where this one leaves off. Choose this option if you don't need your Azure DevOps project for future reference.

To delete the project:

1. From Azure DevOps, go to your project. Earlier, we recommended that you name this project **Space Game - web - Dependencies**.
1. Select the gear icon next to the project name.

    The icon might not appear until you move your mouse over that area.

    ![Screenshot of Azure DevOps showing the gear icon](../../shared/media/azure-devops-project-gear.png)
1. From the **Project details** area, scroll to the bottom, and select **Delete**.

    ![Screenshot of Azure DevOps showing the Delete button](../../shared/media/azure-devops-delete-project.png)
1. From the window that appears, enter the project name and select **Delete** a second time.

    Your project is now deleted.
