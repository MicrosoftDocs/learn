You're all done with the tasks for this module. You'll now clean up your Azure DevOps environment.

::: zone pivot="ms-hosted-agents"

> [!IMPORTANT]
> This page has important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes for Microst-hosted agents ([check your usage](/azure/devops/pipelines/troubleshooting/troubleshooting#check-for-available-parallel-jobs)). Be sure to do the cleanup steps even if you didn't complete this module.

::: zone-end

::: zone pivot="github-codespaces-agent"

> [!IMPORTANT]
> This page has important cleanup steps. Cleaning up helps ensure that you don't run out of free GitHub Codespaces [included usage hours and storage](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts) ([charges may apply if you exceed the free tier - check your usage](https://docs.github.com/billing/managing-billing-for-github-codespaces/viewing-your-github-codespaces-usage)). Be sure to do the cleanup steps even if you don't complete this module.

::: zone-end

## Disable the pipeline or delete your project

To create a clean environment for the duration of the module, each module in this learning path provides a template that you can run.

Running multiple templates gives you multiple Azure Pipelines projects, each pointing to the same GitHub repository. This can trigger multiple pipelines to run each time you push a change to your GitHub repository, which can cause you to run out of free build minutes on our hosted agents. That's why it's important that you disable or delete your pipeline before moving on to the next module.

Select one of the following options:

### Option 1: Delete the Azure DevOps project

This option deletes your Azure DevOps project, including what's on Azure Boards and your build pipeline. In future modules, you'll be able to run another template that brings up a new project in a state where this one leaves off. Select this option if you don't need your Azure DevOps project for future reference.

> [!TIP]
> This project isn't needed for subsequent training modules, as each module includes a template that creates a new project that includes the required steps from previous modules.

To delete the project:

1. In Azure DevOps, go to your project. Earlier, we recommended that you name the project *Space Game - web - Pipeline*.
1. Select **Project settings** in the bottom left corner.
1. In the **Project details** area, scroll to the bottom, and select **Delete**.

    :::image type="content" source="../../shared/media/azure-devops-delete-project.png" alt-text="Screenshot of Azure DevOps showing the location of the Delete button.":::

1. In the window that appears, enter the project name, and select **Delete** a second time.

    Your project is now deleted.

### Option 2: Disable the pipeline

This option disables the pipeline so that it doesn't process further build requests. You can re-enable the build pipeline later if you want to. Select this option if you want to keep your Azure DevOps project and your build pipeline for future reference.

To disable the pipeline:

1. In Azure Pipelines, navigate to your pipeline.
1. From the dropdown, select **Settings**.

    :::image type="content" source="../../shared/media/azure-pipelines-settings-button.png" alt-text="Screenshot of Azure Pipelines showing the location of the Settings menu.":::
    
1. Under **Processing of new run requests**, select **Disabled** and then select **Save**.

    Your pipeline will no longer process build requests.

::: zone pivot="github-codespaces-agent"

## Delete your GitHub Codespace

1. In your forked GitHub repository, select **Code**.

1. Select the **Codespaces** tab.

1. Select **...** by your Codespace, and choose **Delete**.

    :::image type="content" source="../media/9-delete-codespace.png" alt-text="Screenshot of deleting a Codespace. ":::

::: zone-end