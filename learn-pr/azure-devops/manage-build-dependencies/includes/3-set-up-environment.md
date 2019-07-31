In this part, you'll make sure that your Azure DevOps organization is set up to complete the rest of this module.

The modules in this learning path form a progression, where you follow the Tailspin web team through their DevOps journey.

This learning path also builds on the [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true) learning path. There, you set up your Azure DevOps organization and created a task backlog on Azure Boards, by using the Basic process.

## Run the template

At this point, you have two options:

- Continue with the Azure DevOps project you created in the "Evolve your DevOps practices" learning path.
- Run a template that sets up everything for you in your Azure DevOps organization.

You can continue using your existing project if you completed the previous modules, and have the Tailspin project set up in Azure DevOps. Run the template if you don't have the project set up, or you want to repeat this module from a fresh environment.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?name=manage-build-dependencies&azure-portal=true)

From the Azure DevOps demo generator site, perform these steps to run the template.

1. Select **Sign In**, and accept the usage terms.
1. From the **Create New Project** page, select your Azure DevOps organization, and enter a project name. For example, enter **Space Game - web - Dependencies**.
1. Select **Fork repository on GitHub**, and then select **Authorize**. If a window appears, authorize access to your GitHub account.

    > [!IMPORTANT]
    > You need to select this option for the template to connect to your GitHub repository. Select this option even if you've already forked the _Space Game_ website project. The template uses your existing fork.
1. Select **Create Project**.

    ![Screenshot of Create New Project page](../media/3-create-new-project.png)

    It takes a few moments for the template to run.
1. Select **Navigate to project** to go to your project in Azure DevOps.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/learn/modules/manage-build-dependencies/8-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps even if you don't complete this module.

## Move the work item to Doing

In this part, you'll assign a work item to yourself that relates to this module on Azure Boards. You'll also move the work item to the **Doing** state. In practice, you and your team would assign work items at the start of each sprint, or work iteration.

Assigning work in this way gives you a checklist to work from. It gives others on your team visibility into what you're working on and how much work is left. It also helps the team enforce work-in-progress limits, so that the team doesn't take on too much work at one time.

Recall that the team settled on these seven top issues:

![Backlog of tasks](../../shared/media/build-all-tasks.png)

Here you'll move the sixth item, **Move model data to its own package** to the **Doing** column, and assign yourself to the work item.

Recall that **Move model data to its own package** relates to moving reusable code to its own NuGet package, so that package can be shared among multiple applications.

![Screenshot of work item details](../media/3-work-item-details.png)

To set up the work item:

1. From Azure DevOps, go to **Boards**, and select **Boards** from the menu.

    ![Screenshot of Azure DevOps, showing the Azure Boards menu](../../shared/media/azure-devops-boards-menu.png)

1. From the **Move model data to its own package** work item, select the down arrow at the bottom of the card. Then assign the work item to yourself.

    ![Screenshot of Azure Boards, showing assigning the work item to yourself](../../shared/media/azure-boards-down-chevron.png)
1. Move the work item from the **To Do** to the **Doing** column.

    ![Screenshot of Azure Boards, showing the card in the Doing column](../media/3-azure-boards-wi6-doing.png)

At the end of this module, you'll move the card to the **Done** column after you've completed the task.