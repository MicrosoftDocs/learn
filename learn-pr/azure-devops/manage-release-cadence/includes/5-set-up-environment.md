Roberta, ignore this file, it is just to get your environment set up to do the lab.

Here we will need to get the learner to the place they left off in the [Create a release management workflow](/learn/modules/create-a-release-management-workflow?azure-portal=true) module.

> [!div class="checklist"]
> * Get the new branch with azure-pipelines.yml that deploys to dev, test, and staging
> * Create web app on Azure using AppService (CLI) with dev, test, staging, production slots - TODO: See what the previous module has.
> * Edit pipeline yml with your variable names
> * Get the Azure DevOps project from the template
> * Verify the app is deployed.

## Get the source code

1. From the terminal, run the following `git` commands to fetch a branch named `release-cadence` from Microsoft's repository and switch to that branch. (branch will have dev, test, staging deployment in yml)

    ```bash
    git fetch upstream release-cadence
    git checkout release-cadence
    ```

    As you did in previous modules, the format of this command enables you to get starter code from Microsoft's GitHub repository, known as `upstream`. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

## Create an Azure AppService with deployment slots

TODO: See what previous module has

```bash
webappname=TailspinGame$RANDOM
az group create --location westus --name TailspinResourceGroup
az appservice plan create --name myAppServicePlan --resource-group TailspinResourceGroup --sku P2V2
az webapp create --name $webappname --resource-group TailspinResourceGroup --plan myAppServicePlan
az webapp deployment slot create --name $webappname --resource-group TailspinResourceGroup --slot Dev
az webapp deployment slot create --name $webappname --resource-group TailspinResourceGroup --slot Test
az webapp deployment slot create --name $webappname --resource-group TailspinResourceGroup --slot Staging
```

```bash
az webapp deployment slot list --name $webappname --resource-group TailspinResourceGroup --query [].name --output tsv
```

```bash
az webapp deployment slot list --name $webappname --resource-group TailspinResourceGroup --query [].hostNames --output tsv
```

### Create the service connection

TODO: Get the service connection creation part from Module 1 and replace this

* Select **Service Principal Authentication**.

  * **Connection name**: Sandbox
  * **Scope level**: Subscription
  * **Subscription**: Concierge Subscription
  * **Resource Group**: <rgn>[Resource Group Name]</rgn>

TODO: SET VARIABLE FOR WEB APP NAME (and update reference code!)

### Edit your pipeline to use your AppService name

1. Open the **azure-pipelines.yml** file and edit the **WebAppName** to be the WebApp you created above. It should be **TailspinGame** with some numbers after it. TODO: Make a variable instead.
    [!code-yml[](code/5-azure-pipelines.yml?highlight=100,131)]

## Get the Azure DevOps project

In this part, you'll make sure that your Azure DevOps organization is set up to complete the rest of this module.

The modules in this learning path form a progression, where you follow the Tailspin web team through their DevOps journey.

This learning path also builds on the [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true) learning path. There, you set up your Azure DevOps organization and created a task backlog on Azure Boards using the Basic process.

### Run the template

At this point, you have two options:

1. Continue with the Azure DevOps project you created in the _Evolve your DevOps practices_ learning path.
1. Run a template that sets up everything for you in your Azure DevOps organization.

You can continue using your existing project if you completed the previous modules and have the Tailspin project set up in Azure DevOps. Run the template if you don't have the project set up or want to repeat this module from a fresh environment.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?name=create-build-pipeline&azure-portal=true)

From the Azure DevOps Demo Generator site, perform these steps to run the template.

1. Click **Sign In** and accept the usage terms.
1. From the **Create New Project** page, select your Azure DevOps organization and enter a project name, such as **Space Game - web - Pipeline**. Then click **Create Project**.

    ![Creating a project through the Azure DevOps Demo Generator](../media/4-create-new-project.png)

    It takes a few moments for the template to run.
1. Click **Navigate to project** to go to your project in Azure DevOps.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/learn/modules/create-a-build-pipeline/9-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps even if you don't complete this module.

### Move the work item to Doing

In this part, you'll assign a work item to yourself that relates to this module on Azure Boards. You'll also move the work item to the **Doing** state. In practice, you and your team would assign work items at the start of each Sprint, or work iteration.

Assigning work in this way gives you a checklist to work from. It gives others on your team visibility into what you're working on and how much work is left. It also helps the team enforce Work in Progress, or WIP, limits so that the team doesn't take on too much work at one time.

Recall that the team settled on these seven top issues.

![Backlog of tasks](../../shared/media/build-all-tasks.png)

Here you'll move the first item, **Deploy to a test environment** to the **Doing** column and assign yourself to the work item.

Recall that **Deploy to a test environment** relates to fixing the team's existing build server, which runs on spare hardware in their office. The goal is to see if build services on Azure Pipelines can simplify build server maintenance.

![Work item details](../media/4-work-item-details.png)

To set up the work item:

1. From Azure DevOps, navigate to **Boards** and then select **Boards** from the menu.

    ![Azure DevOps showing the Boards menu](../../shared/media/azure-devops-boards-menu.png)

1. From the **Stabilize the build server** work item, click the down arrow at the bottom of the card. Then assign the work item to yourself.

    ![Assigning the work item to yourself](../../shared/media/azure-boards-down-chevron.png)
1. Move the work item from the **To Do** to the **Doing** column.

    ![Azure Boards showing the card in the Doing column](../media/4-azure-boards-wi1-doing.png)

At the end of this module, you'll move the card to the **Done** column after you've completed the task.

## Create the initial build pipeline

Here we will make sure that we have the same pipeline we left off with in the [Create a release management workflow](/learn/modules/create-a-release-management-workflow?azure-portal=true) module. In that module, we set up our pipeline to build, then deploy to the *Dev* environment, then to *Test*, and finally to *Staging*. Deploying to Staging from Test was done manually. For brevity here, we will automate the Staging deployment task.

### Turn on multistage pipelines in Azure DevOps

 From your Azure DevOps portal:

  1. Right-click your profile
  1. Select Preview features
  1. Turn on Multi Stage Pipelines **(screenshot)**
  1. Notice that separate **Pipelines** menu entries for **Release** and **Build** are now gone. This is because we will do our build and release from the same pipeline.

## Run the pipeline and see it is deployed

1. From the integrated terminal, add **azure-pipelines.yml** to the index, commit the change, and push the change up to GitHub.

    > [!TIP]
    > Remember to save **azure-pipelines.yml** before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add the pipeline"
    git push origin release-cadence
    ```

1. From Azure Pipelines, trace the build through each of the steps. (Screenshot)
1. Navigate to each of the URLs for each of the stages, you will see the web site deployed.

```bash
az webapp deployment slot list --name $webappname --resource-group TailspinResourceGroup --query [].hostNames --output tsv
```

(Screenshot)
