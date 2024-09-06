You're all done with the tasks for this module. In this unit, you'll move the work item to the **Done** state on Azure Boards and clean up your Azure DevOps environment.

> [!IMPORTANT]
> This page contains important cleanup instructions. Cleaning up your resources helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup if you ran the template earlier in this module.

## Move the work item to Done

In this section, you move the work item that you previously assigned to yourself, **Create a Git-based workflow**, to the **Done** column.

In practice, the definition of "Done" often means that working software is in the hands of your users. In this unit, for learning purposes, you'll mark this work as complete because you and the Tailspin team have started an improved code workflow that uses Git and GitHub.

At the end of each sprint, or work iteration, you and your team might hold a retrospective meeting in which you share the work you completed, what went well in the sprint, and what could be improved.

To complete the work item:

1. In Microsoft Azure DevOps, select **Boards** on the left menu, then select **Boards**.
1. Drag the **Create a Git-based workflow** work item from the **Doing** column to the **Done** column.

    :::image type="content" source="../media/9-azure-boards-wi2-done.png" alt-text="Screenshot of Azure Boards showing the work item in the Done column.":::

## Disable the pipeline or delete your project

Each module in this learning path provides a template that you can run to create a clean environment for the duration of the module.

Running multiple templates creates multiple Microsoft Azure Pipelines projects, each pointing to the same GitHub repository. This action can cause multiple pipelines to run each time you push a change to your GitHub repository. This action, in turn, can cause you to run out of free build minutes on our hosted agents. Therefore, it's important to disable or delete your pipeline before you move on to the next module.

Choose either of the next two options.

### Option 1: Disable the pipeline

This option disables the pipeline so that it doesn't process further build requests. You can reenable the build pipeline later if you want to. Choose this option if you want to keep your DevOps project and your build pipeline for future reference.

To disable the pipeline:

1. In Azure Pipelines, navigate to your pipeline.
1. Select the ellipsis (**...**), then select **Settings**:

    :::image type="content" source="../../shared/media/azure-pipelines-settings-button.png" alt-text="Screenshot of Azure Pipelines showing the location of the Settings menu.":::
1. Under **Processing of new run requests**, select **Disabled**, then select **Save**.

    Your pipeline will no longer process build requests.

### Option 2: Delete the Azure DevOps project and GitHub repository

This option deletes your Azure DevOps project, including what's on Azure Boards and your build pipeline, and your GitHub repository. In future modules, you'll be able to run another template that brings up a new project in a state where this one leaves off. Choose this option if you don't need your DevOps project for future reference.

To delete the project:

1. In Azure DevOps, go to your project. Earlier, we recommended that you name this project *Space Game - web - Workflow*.
1. Select **Project settings** in the lower-left corner.
1. In the **Project details** area, scroll to the bottom and select **Delete**.

    :::image type="content" source="../../shared/media/azure-devops-delete-project.png" alt-text="Screenshot of Azure Pipelines showing the location of the Delete button.":::

1. In the window that appears, enter the project name and select **Delete** a second time.

    Your project is now deleted.

To delete the repository:

1. In GitHub, go to your repository, `https://github.com/username/mslearn-tailspin-spacegame-web`.
1. Select the **Settings** tab, then select **General** in the left menu.
1. Scroll down and select **Delete this repository**.
1. Select **I want to delete this repository**.
1. Select **I have read and understand these effects**.
1. Type the repository name, then select **Delete this repository**.
