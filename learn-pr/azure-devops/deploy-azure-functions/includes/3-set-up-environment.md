In this unit, you'll make sure that your Azure DevOps organization is set up to complete the rest of this module. You'll also create the Azure App Service environments that you'll deploy to.

To accomplish these goals, you'll:

> [!div class="checklist"]
> * Add a user to ensure Azure DevOps can connect to your Azure subscription.
> * Set up an Azure DevOps project for this module.
> * On Azure Boards, move the work item for this module to the **Doing** column.
> * Make sure your project is set up locally so that you can push changes to the pipeline.
> * Create the Azure App Service and Azure Functions app using the Azure CLI in Azure Cloud Shell.
> * Create pipeline variables that define the names of your App Service and Azure Functions instance.
> * Create a service connection that enables Azure Pipelines to securely access your Azure subscription.

## Add a user to Azure DevOps

To complete this module, you need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true). You can get started with Azure for free.

Although you don't need an Azure subscription to work with Azure DevOps, this exercise is using Azure DevOps to deploy to Azure resources in your Azure subscription. To simplify the process, use the same Microsoft account to sign in to both your Azure subscription and your Azure DevOps organization.

> [!IMPORTANT]
> If you sign in with different accounts, then you should add a user to your DevOps organization under the Microsoft account that you use to sign in to Azure. For more information, see [Add users to your organization or project](/azure/devops/organizations/accounts/add-organization-users?azure-portal=true&tabs=browser). When you add the user, choose the **Basic** access level.

Then, sign out of Azure DevOps and sign in with the new user account. Use the Microsoft account that you use to sign in to your Azure subscription.

## Get the Azure DevOps project

Make sure that your Azure DevOps organization is set up to complete the rest of this module. To do so, you'll run a template that creates a project in Azure DevOps.

The modules in this learning path form a progression as you follow the Tailspin web team through their DevOps journey. For learning purposes, each module has its own Azure DevOps project.

### Run the template

1. Run a template that sets up your Azure DevOps organization:

   > [!div class="nextstepaction"]
   > [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?x-ms-routing-name=self&name=DeployAzureFunction&azure-portal=true)

1. From the Azure DevOps Demo Generator site, select **Sign In**. If prompted, accept the usage terms. The **Create New Project** page appears.

1. On the **Create New Project** page, enter a project name, such as *Space Game - web - Azure Functions*, and then for **Select Organization**, select the organization that you use for your Azure subscription.

    :::image type="content" source="../media/3-create-new-project.png" alt-text="A screenshot of the Azure DevOps Demo Generator showing how to create the project.":::

1. In the next section, select **Yes, I want to fork this repository**, and then select **Authorize**.

    If a window appears, authorize access to your GitHub account.

    > [!IMPORTANT]
    > The enabling this fork option is necessary for the template to connect to your GitHub repository. Select it even if you've already forked the *Space Game* website project. The template uses your existing fork.

1. Select **Create Project**.

    The template takes a few moments to run.

1. When the project is successfully provisioned, select **Navigate to project** to go to your project in Azure DevOps.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/deploy-azure-functions/5-clean-up-environment?azure-portal=true) page in this module contains **important steps** that you must complete, even if you don't complete this module. Cleaning up helps ensure that you don't run out of free build minutes. 

[!INCLUDE [](../../shared/includes/project-visibility.md)]

## Assign a work item and move it to the Doing state

Here, you'll assign a work item to yourself on Azure Boards and set the work item state to **Doing**. In practice, you and your team would create work items at the start of each *sprint*, or work iteration.

This exercise creates a checklist from which to work. It gives other team members visibility into what you're working on and how much work is left. The work item also helps enforce work-in-progress (WIP) limits so that the team doesn't take on too much work at one time.

1. From Azure DevOps, navigate to **Boards** category, and then select **Boards** from the menu.

    :::image type="content" source="../../shared/media/azure-devops-boards-menu.png" alt-text="Azure DevOps showing the location of the Boards menu.":::

1. Open the **Refactor leaderboard API as an Azure Function** work item by selecting the title. Assign this work item to yourself, and then select **Save & Close**.
 
1. Select the down arrow at the bottom of the card and select **Doing** *or* select the card and drag it to the Doing column.

    :::image type="content" source="../../shared/media/azure-boards-down-chevron.png" alt-text="Screenshot of work item card highlighting the location of the down arrow.":::

1. The work item is moved from the **To Do** column to the **Doing** column.

    :::image type="content" source="../media/3-azure-boards-wi1-doing.png" alt-text="Screenshot of Azure Boards highlighting the work item card in the Doing column.":::

At the end of this module, you'll move the card to the **Done** column after you complete the task.

## Create the Azure App Service and Azure Functions environments

Here, you'll create the App Service and Azure Functions app required to deploy the new version of the site and API.

In the [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true) Learn module, you brought up App Service through the Azure portal. Although the portal is a great way to explore what's available on Azure or to do basic tasks, bringing up components such as App Service can be tedious.

In this module, you use the Azure CLI to bring up an App Service instance. You can access the Azure CLI from a terminal or through Visual Studio Code. Here, we'll access the Azure CLI from Azure Cloud Shell. This browser-based shell experience is hosted in the cloud. In Cloud Shell, the Azure CLI is configured for use with your Azure subscription.

> [!IMPORTANT]
> You need your own Azure subscription to complete the exercises in this module.

### Bring up Cloud Shell through the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. From the global controls in the page header, select **Cloud Shell**.

    :::image type="content" source="../../shared/media/azure-portal-menu-cloud-shell.png" alt-text="A screenshot of the Azure portal showing the location of the Cloud Shell menu item.":::

    A terminal opens and connects to the Azure Cloud Shell. 

1. If necessary, select **Bash** from the terminal menu.

    > [!NOTE]
    > Cloud Shell requires an Azure storage resource to persist any files that you create in Cloud Shell. When you first open Cloud Shell, you're prompted to create a resource group, storage account, and Azure Files share. This setup is automatically used for all future Cloud Shell sessions.

### Select an Azure region

A *region* is one or more Azure datacenters within a geographic location. East US, West US, and North Europe are examples of regions. Every Azure resource, including an App Service instance, is assigned a region.

To make commands easier to run, let's start by setting a default region. After you specify the default region, commands you enter use that region until you specify a different region.

1. From Cloud Shell, run the following `az account list-locations` command to list the regions that are available from your Azure subscription:

    ```azurecli
    az account list-locations \
      --query "[].{Name: name, DisplayName: displayName}" \
      --output table
    ```

1. From the `Name` column in the output, choose a region that's close to you. For example, choose `eastasia` or `westus2`.

1. Run `az configure` to set your default region. Replace `<REGION>` with the name of the region you chose.

    ```azurecli
    az configure --defaults location=<REGION>
    ```

    This example sets `westus2` as the default region:

    ```azurecli
    az configure --defaults location=westus2
    ```

### Create Bash variables

Here, you'll create Bash variables to make the setup process more convenient and less error-prone. Using variables for shared text strings helps avoid accidental typos.

1. From Cloud Shell, generate a random number, which we will use to create globally unique names for certain services in the next step.

    ```bash
    resourceSuffix=$RANDOM
    ```

1. Create three globally unique names for your App Service, Azure Function, and storage accounts. These commands use double quotes, which instruct Bash to resolve the variables using inline syntax.

    ```bash
    webName="tailspin-space-game-web-${resourceSuffix}"
    leaderboardName="tailspin-space-game-leaderboard-${resourceSuffix}"
    storageName="tailspinspacegame${resourceSuffix}"
    ```

1. Create two more Bash variables to store the names of your resource group and service plan.

    ```bash
    rgName='tailspin-space-game-rg'
    planName='tailspin-space-game-asp'
    ```

### Create the Azure resources required

Our solution requires several Azure resources for deployment, which we'll create now.

   > [!NOTE]
   > This exercise uses the default network settings, so that your site is accessible from the internet. In practice, you could configure an Azure virtual network to put your website in a network that only you and your team can access. Later, you could reconfigure your virtual network to make the website available to your users.

1. Run the following `az group create` command to create a resource group using the name defined earlier:

    ```azurecli
    az group create --name $rgName
    ```

1. Run the following `az appservice plan create` command to create an App Service plan using the name defined in the previous task:

    ```azurecli
    az appservice plan create \
      --name $planName \
      --resource-group $rgName \
      --sku B1 \
      --is-linux
    ```

    The `--sku` parameter specifies the B1 plan. This plan runs on the Basic tier. The `--is-linux` parameter specifies Linux workers (threads used in events and task scheduling).

    > [!IMPORTANT]
    > If the B1 SKU isn't available in your Azure subscription, [choose a different plan](https://azure.microsoft.com/pricing/details/app-service/linux/?azure-portal=true), such as S1 (Standard).

1. Run the following `az webapp create` command to create the App Service instance:

    ```azurecli
    az webapp create \
      --name $webName \
      --resource-group $rgName \
      --plan $planName \
      --runtime "DOTNETCORE|6.0"
    ```

1. Azure Functions requires a storage account for deployment. Run the following `az storage account create` command to create it:

    ```azurecli
    az storage account create \
      --name $storageName \
      --resource-group $rgName \
      --sku Standard_LRS
    ```

1. Run the following `az functionapp create` command to create the Azure Functions app instance. Replace the `<region>` with your preferred region.

    ```azurecli
    az functionapp create \
      --name $leaderboardName \
      --resource-group $rgName \
      --storage-account $storageName \
      --functions-version 4 \
      --consumption-plan-location <region>
    ```

1. Run the following `az webapp list` command to list the host name and state of the App Service instance:

    ```azurecli
    az webapp list \
      --resource-group $rgName \
      --query "[].{hostName: defaultHostName, state: state}" \
      --output table
    ```

    Note the host name for your running service. It should look similar to the following, but the random-number identifier will differ. You'll need the web host name later when you verify your work.

    ```output
    HostName                                        State
    ----------------------------------------------  -------
    tailspin-space-game-web-4692.azurewebsites.net  Running
    ```

1. Run the following `az functionapp list` command to list the host name and state of the Azure Functions instance.

    ```azurecli
    az functionapp list \
      --resource-group $rgName \
      --query "[].{hostName: defaultHostName, state: state}" \
      --output table
    ```

    Note the host name for your running service. It should look similar to the following, but the random number identifier will differ. You'll need the leaderboard host name later when you verify your work.

    ```output
    HostName                                                State
    ------------------------------------------------------  -------
    tailspin-space-game-leaderboard-4692.azurewebsites.net  Running
    ```

1. Copy these two host names to a location you can easily access later.

1. As an optional step, open a browser and enter a host name to verify that it's running. The default home page appears.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/deploy-azure-functions/5-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you're not charged for Azure resources after you complete this module. Be sure to perform the cleanup steps even if you don't complete this module.

## Create pipeline variables in Azure Pipelines

In the [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true) module, you added a variable to your pipeline that stores the name of your web app in App Service. Here, you'll do the same. In addition, you'll add the name of your leaderboard app for the Azure Functions instance.

You could hard-code these names in your pipeline configuration, but if you define them as variables, your configuration will be more reusable. Plus, if the names of your instances change, you can update the variables and trigger your pipeline without modifying your configuration.

Let's add a variable group to your project.

1. Your **Space Game - web - Azure Functions** project should be open in Azure DevOps.

1. In the menu, select **Pipelines**, and then, under **Pipelines** select **Library**. The Library pane appears.

    :::image type="content" source="../media/3-pipelines-library.png" alt-text="Screenshot of Azure DevOps menu highlighting the Library option under Pipelines.":::

1. In the command bar or in the middle of the pane, select **Variable group**. The **New variable group** page appears.

1. For the variable group name, enter *Release*.

1. Under **Variables**, select **Add**.

1. For the name of your variable, enter *WebAppName*. For the value, enter the name of the App Service instance that was created for your web app, such as *tailspin-space-game-web-4692*.

    > [!IMPORTANT]
    > Set the name of the App Service instance, not its full host name. In this exercise, for example, *tailspin-space-game-web-4692* is the instance part of the host name *tailspin-space-game-web-4692.azurewebsites.net*.

1. Add another variable named *LeaderboardAppName* with the value of your leaderboard instance, for example, *tailspin-space-game-leaderboard-4692*.

1. Add a final variable named *ResourceGroupName* with the value *tailspin-space-game-rg*.

1. In the command bar near the top of the page, select **Save** to save your *Release* variable group to the pipeline.

    The variables in your variable group should be similar:

    :::image type="content" source="../media/3-library-variable-group.png" alt-text="A screenshot of Azure Pipelines showing the variable group. The group contains three variables.":::

## Create the spike environment

In previous modules, you created environments for **dev**, **test**, and **staging** environments. Here, you'll do the same. This time, you'll create an environment named **spike**.

1. From the Azure DevOps menu, under **Pipelines**, select **Environments**.

    :::image type="content" source="../../shared/media/pipelines-environments.png" alt-text="A screenshot of Azure Pipelines showing the location of the Environments menu option.":::

1. Select **Create environment**. The **New environment** pane appears.

1. For **Name**, enter *spike*.

1. Leave the remaining fields at their default values.

1. Select **Create**.

## Create a service connection

Here, you'll create a service connection that enables Azure Pipelines to access your Azure subscription. Azure Pipelines uses this service connection to deploy the website to App Service. You created a similar service connection in the previous module.

> [!IMPORTANT]
> Make sure that you're signed in to both the Azure portal and Azure DevOps under the same Microsoft account.

1. In Azure DevOps, **Space Game - web - Azure Functions** pipeline project, below the menu, select **Project settings**. The **Project details** pane appears.

1. In the menu, under **Pipelines**, select **Service connections**.

1. On the **Service connections** page, select **New service connection**, and then in the **New service connection** pane, select **Azure Resource Manager**, and then select **Next**.

1. In the **New service connection** pane, select **Service principal (automatic)**, and then select **Next**.

1. In the **New Azure service connection** pane, select or enter the following settings:

    | Field                   | Value                                      |
    |-------------------------|--------------------------------------------|
    | Scope level             | **Subscription**                           |
    | Subscription            | Select your Azure subscription                    |
    | Resource Group          | **tailspin-space-game-rg**                 |
    | Service connection name | *Resource Manager - Tailspin - Space Game* |

    During the process, you might be prompted to sign in to your Microsoft account.

1. Ensure that **Grant access permission to all pipelines** is selected.

1. Select **Save**.

Azure DevOps performs a test connection to verify that it can connect to your Azure subscription. If Azure DevOps can't connect, you have the chance to sign in a second time.
