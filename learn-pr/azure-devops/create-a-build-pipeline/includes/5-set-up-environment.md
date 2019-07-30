In this section, you'll make sure that your Azure DevOps organization is set up to complete the rest of this module.

The modules in this learning path form a progression in which you follow the Tailspin web team through its DevOps journey.

This learning path also builds on the [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true) learning path. There, you set up your Azure DevOps organization and created a task backlog on Azure Boards by using the Basic process.

## Run the template

At this point, you have two options:

1. Continue with the Azure DevOps project that you created in the **Evolve your DevOps practices** learning path.
1. Run a template that sets up everything for you in your Azure DevOps organization.

You can continue using your existing project if you completed the previous modules and have the Tailspin project set up in Azure DevOps. Run the template if you don't have the project set up or want to repeat this module in a fresh environment.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?name=create-build-pipeline&azure-portal=true)

On the Azure DevOps Demo Generator site, perform these steps to run the template:

1. Select **Sign In** and accept the usage terms.
1. On the **Create New Project** page, select your Azure DevOps organization and enter a project name, like **Space Game - web - Pipeline**. Then select **Create Project**.

    ![Creating a project through the Azure DevOps Demo Generator](../media/5-create-new-project.png)

    It takes a moment for the template to run.
1. Select **Navigate to project** to go to your project in Azure DevOps.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/learn/modules/create-a-build-pipeline/9-clean-up-environment?azure-portal=true) unit in this module provides important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps even if you don't complete this module.

## Move the work item to Doing

In this section, you'll assign a work item to yourself on Azure Boards that relates to this module. You'll also move the work item to the **Doing** state. In practice, you and your team would assign work items at the start of each sprint, or work iteration.

Assigning work in this way gives you a checklist to work from. It gives others on your team visibility into what you're working on and how much work is left. It also helps the team enforce Work in Progress limits, or WIP limits, so the team doesn't take on too much work at any given time.

Recall that the team settled on these seven top issues:

![Backlog of tasks](../../shared/media/build-all-tasks.png)

You'll now move the first item, **Stabilize the build server** to the **Doing** column and assign yourself to the work item.

Recall that **Stabilize the build server** relates to fixing the team's existing build server, which runs on spare hardware in the office. The goal is to see if build services on Azure Pipelines can simplify build server maintenance.

![Work item details](../media/5-work-item-details.png)

To set up the work item:

1. In Azure DevOps, navigate to **Boards** and then select **Boards** from the menu:

    ![Azure DevOps showing the Boards menu](../../shared/media/azure-devops-boards-menu.png)

1. In the **Stabilize the build server** work item, select the down arrow at the bottom of the card. Then assign the work item to yourself.

    ![Assigning the work item to yourself](../../shared/media/azure-boards-down-chevron.png)
1. Move the work item from the **To Do** column to the **Doing** column:

    ![Azure Boards showing the card in the Doing column](../media/5-azure-boards-wi1-doing.png)

At the end of this module, you'll move the card to the **Done** column after you've completed the task.