In this module, learn how Azure and Azure DevOps support Node.js applications.

## Check for available parallel jobs

This project uses a Microsoft-hosted agent and requires access to a parallel job. To check if your organization has a parallel job available:

1. Open your Azure DevOps project. If you don't already have a project, [create one for free](/azure/devops/pipelines/get-started/pipelines-sign-up).

1. Select **Project Settings**.

   :::image type="content" source="../media/2-pipeline-project-settings.png" alt-text="Screenshot of project settings menu option.":::

1. Select **Pipelines** > **Parallel Jobs**.

   :::image type="content" source="../media/2-parallel-jobs-menu.png" alt-text="Screenshot of Parallel Jobs menu option.":::

1. Review the available number of Microsoft-hosted parallel jobs for private and public projects. You need to have at least one parallel job available.

   :::image type="content" source="../media/2-available-parallel-jobs.png" alt-text="Screenshot of Parallel Jobs availability chart.":::

1. If you don't have any parallel jobs available, you can request parallel jobs for free for public or private projects using [this form](https://aka.ms/azpipelines-parallelism-request). Your request takes 2-3 business days.
