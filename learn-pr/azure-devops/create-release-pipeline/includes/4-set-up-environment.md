Over the previous learning paths (Links here), the team has been slowly integrating an Azure DevOps strategy into their current processes. They have created Boards to help them begin using a more Agile aproach to development, and they have set up a build pipeline to automate their builds. 

Here you make sure that your environment reflects the team's efforts so far.

To do this, you:

> [!div class="checklist"]
> * Set up your Azure DevOps project
> * Add the build pipeline

## Get the Azure DevOps project

In this part, you'll make sure that your Azure DevOps organization is set up to complete the rest of this module.

The modules in this learning path form a progression, where you follow the Tailspin web team through their DevOps journey.

This learning path also builds on the [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true) learning path. There, you set up your Azure DevOps organization and created a task backlog on Azure Boards using the Basic process.

### Run the template

At this point, you have two options:

1. Run a template that sets up everything for you in your Azure DevOps organization.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?name=create-build-pipeline&azure-portal=true)

From the Azure DevOps Demo Generator site, perform these steps to run the template.

1. Click **Sign In** and accept the usage terms.
1. From the **Create New Project** page, select your Azure DevOps organization and enter a project name, such as **Space Game - web - Release**. Then click **Create Project**.

    ![Creating a project through the Azure DevOps Demo Generator](../media/4-create-new-project.png)

    It takes a few moments for the template to run.
1. Click **Navigate to project** to go to your project in Azure DevOps.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/learn/modules/create-a-build-pipeline/9-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps even if you don't complete this module.

## Create the initial build pipeline

TODO: Convert this to have the learner fetch and checkout an existing branch that we provide. Rough steps (for when we want them to run it.):

1. `git fetch upstream ...`
1. `git checkout ...`
1. `git commit --allow-empty` (look for an example in our other modules)
1. `git push origin ...`
1. Watch it run.

TODO: Use this in the steps below:

---

1. As an optional step, open **azure-pipelines.yml** from Visual Studio code and familiarize yourself with the initial configuration.

    The configuration resembles the basic one you created in the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline/6-create-the-pipeline?azure-portal=true) module. It builds only the application's Release configuration.

---

Here you create the same basic build pipeline we created in [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true). This gives you a place to start for your multistage release pipeline.

Mulitstage pipelines are a preview feature. This means that they will shortly become integrated into the standard Azure DevOps experience, but for now you need to turn on this feature.

### Turn on multistage pipelines in Azure DevOps

From your Azure DevOps portal:

  1. Right-click your profile
  1. Select Preview features
  1. Turn on **Multi Stage Pipelines** **TODO: (screenshot)**
  1. Notice that separate **Pipelines** menu entries for **Release** and **Build** are now gone. This is because you will now do your build and release from the same pipeline.

### Add the build pipeline

1. From the terminal create a new branch for your work.

    ```bash
    git checkout -b "release-pipeline"
    git push origin
    ```

1. From Visual Studio Code, select **File > New File**. Then select **File > Save** to save the blank file as **azure-pipelines.yml** in your project's root directory, such as `~/mslearn-tailspin-spacegame-web`.

    > [!IMPORTANT]
    > On Windows, ensure that you select **YAML** from the **Save as type** field.

1. From the terminal, add **azure-pipelines.yml** to the index, commit the change, and push the change up to GitHub.

    > [!TIP]
    > Remember to save **azure-pipelines.yml** before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add build pipeline"
    git push origin 
    ```

1. From Visual Studio Code, modify **azure-pipelines.yml** like this.

    [!code-yml[](code/5-azure-pipelines-1.yml?highlight=01-06)]
You'll notice that we have set it up to use stages and jobs. For now, we only have one stage, the build stage. Next, we'll add the deployment stage.

1. From the integrated terminal, add **azure-pipelines.yml** to the index, commit the change, and push the change up to GitHub.

    > [!TIP]
    > Remember to save **azure-pipelines.yml** before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add build pipeline"
    git push origin
    ```

1. From Azure Pipelines, trace the build through each of the steps.

    When the build completes, you see the **Artifacts** button appear. We'll use this artifact as our source for the deploy stage.

    ![Azure Pipelines showing the Artifacts button](../media/5-artifacts-button.png)

1. Click the **Artifacts** button, then click **drop**. The **Artifacts explorer** appears.
1. From the **Artifacts explorer**, expand the **drop** folder.

    You see a .zip file that contains your built application and its dependencies.

    ![The Artifacts explorer showing the packaged application](../media/5-artifacts-explorer.png)

You now have a build pipeline for the _Space Game_ web project. Next, you will add the deployment stage to this pipeline.

TODO: Emphasize this is the build artifact that gets deployed to App Service later.