In this section, you'll ensure that your Microsoft Azure DevOps organization is set up to complete the rest of this module.

The modules in this learning path form a progression in which you follow the Tailspin web team through its DevOps journey.

This learning path also builds on the [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true) learning path. There, you used the Basic process to set up your Azure DevOps organization and created a task backlog on Azure Boards.

## Get the Azure DevOps project

Here, you ensure that your Azure DevOps organization is set up to complete the rest of this module. You do this by running a template that creates a project for you in Azure DevOps.

The modules in this learning path form a progression, where you follow the Tailspin web team through their DevOps journey. For learning purposes, each module has an associated Azure DevOps project.

### Run the template

To set up everything in your Azure DevOps organization, run a template.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?x-ms-routing-name=self&name=create-build-pipeline&azure-portal=true)

On the Azure DevOps Demo Generator site, to run the template, do these steps:

1. Select **Sign In** and accept the usage terms.
1. On the **Create New Project** page, select your Azure DevOps organization, and enter a project name, like *Space Game - web - Pipeline*. Next, select **Create Project**.

    :::image type="content" source="../media/5-create-new-project.png" alt-text="Screenshot of creating a project through the Azure DevOps Demo Generator.":::

    It takes a moment for the template to run.
1. To go to your project in Azure DevOps, select **Navigate to project**.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/create-a-build-pipeline/9-clean-up-environment?azure-portal=true) unit in this module provides important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes for Microst-hosted agents ([check your usage](/azure/devops/pipelines/troubleshooting/troubleshooting#check-for-available-parallel-jobs)), or GitHub Codespaces [included usage hours and storage](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts) ([check your usage](https://docs.github.com/billing/managing-billing-for-github-codespaces/viewing-your-github-codespaces-usage)). Be sure to do the cleanup steps even if you don't complete this module.

[!include[](../../shared/includes/project-visibility.md)]

## Move the work item to Doing

In this section, you'll assign a work item to yourself on Azure Boards that relates to this module. You'll also move the work item to the **Doing** state. In practice, you and your team would create work items at the start of each sprint, or work iteration.

Assigning work in this way gives you a checklist to work from. It gives others on your team the visibility into what you're working on and how much work is left. It also helps the team enforce Work in Progress limits, or WIP limits, so the team doesn't take on too much work at any given time.

Recall that the team settled on these seven top issues:

:::image type="content" source="../../shared/media/build-all-tasks.png" alt-text="Screenshot of Azure Boards showing a backlog of tasks.":::

> [!NOTE]
> Within an Azure DevOps organization, work items are numbered sequentially. In your project, the number that's assigned to each work item might not match what you see here.

You'll now move the first item, **Stabilize the build server** to the **Doing** column, and assign yourself to the work item.

Recall that **Stabilize the build server** relates to fixing the team's existing build server, which runs on spare hardware in the office. The goal is to see if build services on Azure Pipelines can simplify build server maintenance.

:::image type="content" source="../media/5-work-item-details.png" alt-text="Screenshot of Azure Boards showing work item details. Details include the state, area, and a description.":::

To set up the work item:

1. In Azure DevOps, go to **Boards**, and from the menu, select **Boards**:

    :::image type="content" source="../../shared/media/azure-devops-boards-menu.png" alt-text="Screenshot of Azure DevOps showing the location of the Boards menu.":::

1. Select the **Stabilize the build server** work item at the bottom of the list, and assign this work item to yourself:

    :::image type="content" source="../../shared/media/azure-boards-down-chevron.png" alt-text="Screenshot of Azure Boards showing the location of the down arrow.":::

1. Move the work item from the **To Do** column to the **Doing** column:

    :::image type="content" source="../media/5-azure-boards-wi1-doing.png" alt-text="Screenshot of Azure Boards showing the work item in the Doing column.":::

At the end of this module, you'll move the card to the **Done** column after you've completed the task.
