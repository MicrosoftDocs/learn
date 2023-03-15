You're all done with the tasks for this module. You'll now move the work item to the **Done** state on Azure Boards, and clean up your Azure DevOps environment.

> [!IMPORTANT]
> This page has important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes for Microst-hosted agents, or GitHub Codespaces [included usage hours and storage](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts). [Check your GitHub Codespaces usage](https://docs.github.com/billing/managing-billing-for-github-codespaces/viewing-your-github-codespaces-usage). Be sure to do the cleanup steps even if you don't complete this module.

## Move the work item to Done

You'll now move the work item you assigned to yourself earlier in this module, **Stabilize the build server**, to the **Done** column.

In practice, "Done" often means that your users have working software. Here, you'll mark this work as complete because you have a working build system on Azure Pipelines.

At the end of each Sprint or work iteration, you and your team might hold a retrospective meeting. At these meetings, you share the work you completed, what went well during the Sprint, and what could be improved.

To complete the work item:

1. From Microsoft Azure DevOps, go to **Boards**, and from the menu, select **Boards**.
1. Move the **Stabilize the build server** work item from the **Doing** column to the **Done** column:

    :::image type="content" source="../media/9-azure-boards-wi1-done.png" alt-text="Screenshot of Azure Boards showing the work item in the Done column.":::

## Disable the pipeline or delete your project

To create a clean environment for the duration of the module, each module in this learning path provides a template that you can run.

Running multiple templates gives you multiple Azure Pipelines projects, each pointing to the same GitHub repository. This can trigger multiple pipelines to run each time you push a change to your GitHub repository, which can cause you to run out of free build minutes on our hosted agents. That's why it's important that you disable or delete your pipeline before moving on to the next module.

Select one of the following options:

### Option 1: Disable the pipeline

This option disables the pipeline so that it doesn't process further build requests. You can re-enable the build pipeline later if you want to. Select this option if you want to keep your Azure DevOps project and your build pipeline for future reference.

To disable the pipeline:

1. In Azure Pipelines, navigate to your pipeline.
1. From the dropdown, select **Settings**.

    :::image type="content" source="../../shared/media/azure-pipelines-settings-button.png" alt-text="Screenshot of Azure Pipelines showing the location of the Settings menu.":::
    
1. Under **Processing of new run requests**, select **Disabled** and then select **Save**.

    Your pipeline will no longer process build requests.

### Option 2: Delete the Azure DevOps project

This option deletes your Azure DevOps project, including what's on Azure Boards and your build pipeline. In future modules, you'll be able to run another template that brings up a new project in a state where this one leaves off. Select this option if you don't need your Azure DevOps project for future reference.

To delete the project:

1. In Azure DevOps, go to your project. Earlier, we recommended that you name the project *Space Game - web - Pipeline*.
1. Select **Project settings** in the bottom left corner.
1. In the **Project details** area, scroll to the bottom, and select **Delete**.

    :::image type="content" source="../../shared/media/azure-devops-delete-project.png" alt-text="Screenshot of Azure DevOps showing the location of the Delete button.":::

1. In the window that appears, enter the project name, and select **Delete** a second time.

    Your project is now deleted.

#### [GitHub Codespaces](#tab/codespaces)

#### Delete your GitHub Codespace

1. In your forked GitHub repository, select **Code**.

1. Select the **Codespaces** tab.

1. Select **...** by your Codespace, and choose **Delete**.

    :::image type="content" source="../media/9-delete-codespace.png" alt-text="Screenshot of deleting a Codespace. ":::

#### [Microsoft-hosted agent](#tab/hosted-agent)

No additional clean-up steps are required when using Microsoft-hosted agents.

---