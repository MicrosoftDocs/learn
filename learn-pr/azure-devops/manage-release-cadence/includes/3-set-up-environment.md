In this section, you make sure that your Azure DevOps organization is set up to complete the rest of this module. You also create the Azure App Service environments that you will deploy to.

To do this, you:

> [!div class="checklist"]
> * Add a user to ensure Azure DevOps can connect to your Azure subscription.
> * Set up an Azure DevOps project for this module.
> * Move the work item for this module on Azure Boards to the **Doing** column.
> * Make sure your project is set up locally so that you can push changes to the pipeline.
> * Create the Azure App Service environments by using the Azure CLI in Azure Cloud Shell.
> * Create pipeline variables that define the names of your App Service environments.
> * Create a service connection that enables Azure Pipelines to securely access your Azure subscription.
> * Perform an initial deployment.

## Add a user to Azure DevOps

To complete this module, you need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true). You can get started with Azure for free.

Although you don't need an Azure subscription to work with Azure DevOps, here you'll use Azure DevOps to deploy to Azure resources that exist in your Azure subscription. To simplify the process, you need to sign in to both your Azure subscription and your Azure DevOps organization under the same Microsoft account.

If you use different Microsoft accounts to sign into Azure and Azure DevOps, add a user to your DevOps organization under the Microsoft account you use to sign in to Azure. [Add users to your organization or project](https://docs.microsoft.com/azure/devops/organizations/accounts/add-organization-users?view=azure-devops&tabs=browser&azure-portal=true) explains how to add a user. When you add the user, choose the **Basic** access level.

Then sign out of Azure DevOps and sign in again under the Microsoft account you use to sign in to your Azure subscription.

## Get the Azure DevOps project

Here, you make sure that your Azure DevOps organization is set up to complete the rest of this module. You do this by running a template that creates a project for you in Azure DevOps.

The modules in this learning path form a progression, where you follow the Tailspin web team through their DevOps journey. For learning purposes, each module has an associated Azure DevOps project.

### Run the template

Run a template that sets up everything for you in your Azure DevOps organization.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?name=manage-release-cadence&azure-portal=true)

From the Azure DevOps Demo Generator site, perform these steps to run the template.

1. Select **Sign In** and accept the usage terms.
1. From the **Create New Project** page, select your Azure DevOps organization and enter a project name, such as **Space Game - web - Deployment patterns**.

    ![Creating a project through the Azure DevOps Demo Generator](../media/3-create-new-project.png)

1. Select **Yes, I want to fork this repository** and then select **Authorize**.
1. Select **Create Project**.

    It takes a few moments for the template to run.
1. Select **Navigate to project** to go to your project in Azure DevOps.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/learn/modules/manage-release-cadence/5-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps even if you don't complete this module.

[!include[](../../shared/includes/project-visibility.md)]

## Move the work item to Doing

In this part, you assign a work item to yourself on Azure Boards that relates to this module. You also move the work item to the **Doing** state. In practice, you and your team would assign work items at the start of each sprint, or work iteration.

Assigning work in this way gives you a checklist to work from. It gives others on your team visibility into what you're working on and how much work is left. It also helps the team enforce Work in Progress (WIP) limits so that the team doesn't take on too much work at one time.

Recall that the team settled on these top issues for the current sprint.

![Azure Boards showing the tasks for this sprint](../../shared/media/deploy-all-tasks.png)

> [!NOTE]
> Within an Azure DevOps organization, work items are numbered sequentially. In your project, the number that's assigned to each work item might not match what you see here.

Here you move the fifth item, **Improve release cadence** to the **Doing** column and assign yourself to the work item. **Improve release cadence** relates to choosing an deployment pattern that enables you to release changes more quickly to your users.

To set up the work item:

1. From Azure DevOps, navigate to **Boards** and then select **Boards** from the menu.

    ![Azure DevOps showing the Boards menu](../../shared/media/azure-devops-boards-menu.png)

1. From the **Improve release cadence** work item, click the down arrow at the bottom of the card. Then assign the work item to yourself.

    ![Assigning the work item to yourself](../../shared/media/azure-boards-down-chevron.png)
1. Move the work item from the **To Do** to the **Doing** column.

    ![Azure Boards showing the card in the Doing column](../media/3-azure-boards-wi5-doing.png)

At the end of this module, you move the card to the **Done** column after you've completed the task.

[!include[](../../shared/includes/enable-multi-stage-pipelines.md)]

[!include[](../../shared/includes/deploy-local-setup.md)]

## Create the Azure App Service environments

Here, you create the environments that define the pipeline stages. You create one App Service instance that corresponds to each stage: _Dev_, _Test_, and _Staging_.

In previous modules, you used the Azure command-line interface (CLI) to create your App Service instances. Here, you'll do the same.

> [!IMPORTANT]
> Remember that you need your own Azure subscription to complete the exercises in this module.

### Bring up Cloud Shell through the Azure portal

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. From the menu bar, select Cloud Shell. When prompted, select the **Bash** experience.

### Select an Azure region

Here you specify the default _region_, or geographic location, where your Azure resources are to be created.

1. From Cloud Shell, run the following `az account list-locations` command to list the regions that are available from your Azure subscription.

    ```azurecli
    az account list-locations \
      --query "[].{Name: name, DisplayName: displayName}" \
      --output table
    ```

1. From the **Name** column in the output, choose a region that's close to you, for example, **eastasia** or **westus2**.

1. Run `az configure` to set your default region. Replace **\<REGION>** with the name of the region you chose.

    ```azurecli
    az configure --defaults location=<REGION>
    ```

    Here's an example that sets **westus2** as the default region.

    ```azurecli
    az configure --defaults location=westus2
    ```

### Create the App Service instances

Here, you create the App Service instances for the three stages you'll deploy to: _Dev_, _Test_, and _Staging_. You'll add a deployment slot to _Staging_ later in this module.

> [!NOTE]
> For learning purposes, here you use the default network settings, which makes your site accessible from the internet. In practice, you could configure an Azure virtual network that places your website in a non-internet routable network that's accessible only to you and your team. Later, when you're ready, you could reconfigure your network to make the website available to your users.

1. From Cloud Shell, generate a random number that makes your web app's domain name unique

    ```bash
    webappsuffix=$RANDOM
    ```

1. Run the following `az group create` command to create a resource group that's named **tailspin-space-game-rg**.

    ```azurecli
    az group create --name tailspin-space-game-rg
    ```

1. Run the following commands to create two App Service plans.

    ```azurecli
    az appservice plan create \
      --name tailspin-space-game-test-asp \
      --resource-group tailspin-space-game-rg \
      --sku B1

    az appservice plan create \
      --name tailspin-space-game-prod-asp \
      --resource-group tailspin-space-game-rg \
      --sku P1V2
    ```

    > [!IMPORTANT]
    > If the **B1** SKU is not available as part of your Azure subscription, [choose a different plan](https://azure.microsoft.com/pricing/details/app-service/linux/?azure-portal=true), such as **S1** (**Standard**).

    Recall that an App Service plan defines the CPU, memory, and storage resources that are provided for your web app to run. 

    The first command specifies the **B1** plan, which runs on the **Basic** tier, and is used by the App Service environments for the _Dev_ and _Test_ stages. The **B1 Basic** plan is intended for apps that have lower traffic requirements, such as a development or test environment.

    The second command specifies the **P1V2** plan, which runs on the **Premium** tier. This plan is used for _Staging_. The **Premium P1V2** plan is for production workloads and runs on dedicated virtual machine instances.

    The **Basic** plan tier does not offer additional deployment slots. However, the **Premium** plan does. That's why you need it for your _Staging_ environment.

1. Run the following `az webapp create` commands to create the three App Service instances, one for each of the  _Dev_, _Test_, and _Staging_ environments.

    ```azurecli
    az webapp create \
      --name tailspin-space-game-web-dev-$webappsuffix \
      --resource-group tailspin-space-game-rg \
      --plan tailspin-space-game-test-asp

    az webapp create \
      --name tailspin-space-game-web-test-$webappsuffix \
      --resource-group tailspin-space-game-rg \
      --plan tailspin-space-game-test-asp

    az webapp create \
      --name tailspin-space-game-web-staging-$webappsuffix \
      --resource-group tailspin-space-game-rg \
      --plan tailspin-space-game-prod-asp
    ```

    Notice that here you apply the same App Service plan, **B1 Basic**, to the App Service instances for _Dev_ and _Test_. You apply the App Service plan **Premium P1V2** to the App Service instance for _Staging_.

1. Run the following `az webapp list` command to list the hostname and state of each App Service instance.

    ```azurecli
    az webapp list \
      --resource-group tailspin-space-game-rg \
      --query "[].{hostName: defaultHostName, state: state}" \
      --output table
    ```

    Note the hostname for each running service. You'll need these hostnames later when you verify your work. Here's an example:

    ```output
    HostName                                                 State
    -------------------------------------------------------  -------
    tailspin-space-game-web-dev-21017.azurewebsites.net      Running
    tailspin-space-game-web-test-21017.azurewebsites.net     Running
    tailspin-space-game-web-staging-21017.azurewebsites.net  Running
    ```

1. As an optional step, go to one or more of the names listed to verify they are running and that the default home page appears.

    You see this in each environment:

    ![The default home page on Azure App Service](../../shared/media/app-service-default.png)

> [!IMPORTANT]
> Remember, the [Clean up your Azure DevOps environment](/learn/modules/manage-release-cadence/5-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you're not charged for Azure resources after you complete this module. Be sure to perform the cleanup steps even if you don't complete this module.

## Create pipeline variables in Azure Pipelines

In [Create a multi-stage pipeline with Azure Pipelines](/learn/modules/create-multi-stage-pipeline?azure-portal=true), you added one variable for each of the App Service instances that corresponds to the _Dev_, _Test_, and _Staging_ stages in your pipeline. Here, you do the same.

Each stage in your pipeline configuration uses these variables to identify which App Service instance to deploy to.

To add the variables:

1. In Azure DevOps, go to your **Space Game - web - Deployment patterns** project.
1. Under **Pipelines**, select **Library**.

    ![Azure Pipelines showing the Library menu option](../../create-release-pipeline/media/5-pipelines-library.png)
1. Select **+ Variable group**.
1. Under **Properties**, enter **Release** for the variable group name.
1. Under **Variables**, select **+ Add**.
1. Enter **WebAppNameDev** as the name of your variable. Enter the name of the App Service instance that corresponds do your _Dev_ environment, such as **tailspin-space-game-web-dev-1234**, as its value.
1. Repeat steps 5 and 6 two more times to create variables for your _Test_ and _Staging_ environments, as shown in this table:

    | Variable name         | Example value                            |
    |-----------------------|------------------------------------------|
    | **WebAppNameTest**    | **tailspin-space-game-web-test-1234**    |
    | **WebAppNameStaging** | **tailspin-space-game-web-staging-1234** |

    Be sure to replace each example value with the App Service instance that corresponds to your environment.

    > [!IMPORTANT]
    > Make sure you set the name of the App Service instance, and not its hostname. In this example, you would enter **tailspin-space-game-web-dev-1234** and not **tailspin-space-game-web-dev-1234.azurewebsites.net**.

1. Select **Save** near the top of the page to save your variable to the pipeline.

    Your variable group resembles this one:

    ![Azure Pipeline showing the variable group](../media/3-library-variable-group.png)

## Create a service connection

Here, you create a service connection that enables Azure Pipelines to access your Azure subscription. Azure Pipelines uses this service connection to deploy the website to App Service. You created a similar service connection in the previous module.

> [!IMPORTANT]
> Make sure that you're signed in to both the Azure portal and Azure DevOps under the same Microsoft account.

1. In Azure DevOps, go to your **Space Game - web - Deployment patterns** project.
1. Select **Project settings** from the bottom corner of the page.
1. Under **Pipelines**, select **Service connections**.
1. Select **+ New service connection** and then choose **Azure Resource Manager**.

    The **Add an Azure Resource Manager service connection** dialog appears.
1. From the dialog, ensure **Service Principal Authentication** is selected. Then fill in these fields:

    | Field               | Value                                        |
    |---------------------|----------------------------------------------|
    | **Connection name** | **Resource Manager - Tailspin - Space Game** |
    | **Scope level**     | **Subscription**                             |
    | **Subscription**    | Your Azure subscription                      |
    | **Resource Group**  | **tailspin-space-game-rg**                   |

    During the process, you might be prompted to sign in to your Microsoft account.

1. Select **OK**.

    Azure DevOps performs a test connection to verify that it can connect to your Azure subscription. If Azure DevOps is unable to connect, you'll have the chance to sign in a second time.

## Fetch the branch from GitHub

Here, you fetch the `blue-green` branch from GitHub and checkout, or switch to, that branch.

This branch contains the _Space Game_ project you worked with in the previous modules and an Azure Pipelines configuration to start with.

1. In Visual Studio Code, open the integrated terminal.
1. Run the following `git` commands to fetch a branch named `blue-green` from Microsoft's repository and switch to that branch.

    ```bash
    git fetch upstream blue-green
    git checkout -b blue-green upstream/blue-green
    ```

    The format of these commands enables you to get starter code from Microsoft's GitHub repository, known as `upstream`. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

1. As an optional step, open *azure-pipelines.yml* from Visual Studio Code and familiarize yourself with the initial configuration.

    The configuration resembles the ones that you created in the previous modules in this learning path. It builds only the application's **Release** configuration. For brevity, it also omits the triggers, manual approvals, and tests you set up in previous modules.

    For learning purposes, this configuration promotes changes from any branch to _Dev_, _Test_, and _Staging_. A more robust approach might promote only changes from a release branch or `master`, like you set up in the [Create a multi-stage pipeline with Azure Pipelines](/learn/modules/create-multi-stage-pipeline?azure-portal=true) module.

## Run the pipeline and see the deployed website

Here, you push the initial configuration to GitHub so that you're up to date with the team. Later, you'll add a slot to the _Staging_ environment so that you can implement a blue-green deployment.

1. In Visual Studio Code, open the integrated terminal.
1. Run the following `git commit` command to add an empty entry to your commit history.

    ```bash
    git commit --allow-empty -m "Trigger the pipeline"
    ```

    This step is for learning purposes and is not typical. We provide starter code that you don't need to modify now. The `--allow-empty` flag ensures that the next step successfully pushes the branch to GitHub and triggers Azure Pipelines to run.

    If you omitted this step, the `git push` command you run in the next step wouldn't take any action, and therefore wouldn't trigger Azure Pipelines to run.

1. Run the following `git push` command to upload the branch to your GitHub repository.

    ```bash
    git push origin blue-green
    ```

1. In Azure Pipelines, go to the build and trace the build as it runs.
1. After the build completes, go to the summary page.

    ![Azure Pipelines showing the completed stages](../media/3-stages-complete.png)

    You see that each stage of the pipeline succeeded.
1. Navigate to the URL that corresponds to each stage.

    You see that the _Space Game_ website successfully deployed to each App Service environment.

    ![A browser showing the Space Game website in the Dev environment](../media/3-app-service-dev.png)