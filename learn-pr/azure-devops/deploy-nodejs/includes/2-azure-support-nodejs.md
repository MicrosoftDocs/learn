In this module, you'll explore creating a Node.js API for a bank and learn how Azure and Azure DevOps support Node.js applications.

This module uses a Bank API that's part of the Azure Developer Advocates' [Web Development for Beginners course](https://microsoft.github.io/Web-Dev-For-Beginners/#/?id=web-development-for-beginners-a-curriculum). If you'd like to learn more about the Bank API code, see the [Build a Bank project](https://github.com/microsoft/Web-Dev-For-Beginners/tree/main/7-bank-project) that's part of the course.

## Check for available parallel jobs

This project uses a Microsoft-hosted agent and requires access to a parallel job. To check if your organization has a parallel job available:

1. Open your Azure DevOps project. If you don't already have a project, [create one for free](/azure/devops/pipelines/get-started/pipelines-sign-up).

1. Select **Project Settings**.

    :::image type="content" source="../media/2-pipeline-project-settings.png" alt-text="Screenshot of project settings menu option.":::

1. Select **Pipelines** > **Parallel Jobs**.

    :::image type="content" source="../media/2-parallel-jobs-menu.png" alt-text="Screenshot of Parallel Jobs menu option.":::

1. Review the available number of Microsoft-hosted parallel jobs for private and public projects. You need to have at least one parallel job available.

    :::image type="content" source="../media/2-available-parallel-jobs.png" alt-text="Screenshot of Parallel Jobs availability chart.":::

1. If you do not have any parallel jobs available, you can request parallel jobs for free for public or private projects using [this form](https://aka.ms/azpipelines-parallelism-request). Your request will take 2-3 business days. 