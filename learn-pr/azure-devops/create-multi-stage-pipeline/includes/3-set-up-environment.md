In this section, you make sure that your Azure DevOps organization is set up to complete the rest of this module. You also create the Azure App Service environments that you deploy to later.

To accomplish these goals, you:

> [!div class="checklist"]
> - Add a user to ensure Azure DevOps can connect to your Azure subscription.
> - Set up an Azure DevOps project for this module.
> - On Azure Boards, move the work item for this module to the **Doing** column.
> - Make sure your project is set up locally so that you can push changes to the pipeline.
> - Create the Azure App Service environments by using the Azure CLI in Azure Cloud Shell.
> - Create pipeline variables that define the names of your App Service environments.
> - Create a service connection that enables Azure Pipelines to securely access your Azure subscription.

## Add a user to Azure DevOps

To complete this module, you need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true). You can get started with Azure for free.

You don't need an Azure subscription to use Azure DevOps, but here you use Azure DevOps to deploy to Azure resources that exist in your Azure subscription. To simplify the process, use the same Microsoft account to sign in to both your Azure subscription and your Azure DevOps organization.

If you use different Microsoft accounts to sign in to Azure and Azure DevOps, add a user to your DevOps organization under the Microsoft account that you use to sign in to Azure. For more information, see [Add users to your organization or project](/azure/devops/organizations/accounts/add-organization-users?azure-portal=true&tabs=browser). When you add the user, select the **Basic** access level.

Next, sign out of Azure DevOps and sign in. Use the Microsoft account that you use to sign in to your Azure subscription.

## Get the Azure DevOps project

Here, you make sure that your Azure DevOps organization is set up to complete the rest of this module. To do so, you run a template that creates a project in Azure DevOps.

The modules in this learning path form a progression. You follow the Tailspin web team through their DevOps journey. For learning purposes, each module has its own Azure DevOps project.

### Run the template

Run a template that sets up your Azure DevOps organization:

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?x-ms-routing-name=self&name=create-multi-stage-pipeline&azure-portal=true)

From the Azure DevOps Demo Generator site, to run the template, follow these steps.

1. Select **Sign In**, and accept the usage terms.
1. On the **Create New Project** page, select your Azure DevOps organization. Enter a project name, such as *Space Game - web - Multistage*.

    :::image type="content" source="../media/4-create-new-project.png" alt-text="A screenshot of the Azure DevOps Demo Generator showing the process for creating the project.":::

1. Select **Yes, I want to fork this repository** > **Authorize**.

    If a window appears, authorize access to your GitHub account.

    > [!IMPORTANT]
    > You need to select this option so the template will connect to your GitHub repository. Select it even if you've already forked the *Space Game* website project. The template uses your existing fork.

1. Select **Create Project**.

    The template takes a few moments to run.

1. To go to your project in Azure DevOps, select **Navigate to project**.

> [!IMPORTANT]
> In this module, the [Clean up your Azure DevOps environment](/training/modules/create-multi-stage-pipeline/7-clean-up-environment?azure-portal=true) page contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Even if you don't complete this module, be sure to follow the cleanup steps.

[!include[](../../shared/includes/project-visibility.md)]

## Move the work item to Doing

Here, you assign a work item to yourself on Azure Boards. You also move the work item to the **Doing** state. In practice, you and your team would create work items at the start of each *sprint* or work iteration.

This work assignment gives you a checklist to work from. It gives other team members visibility into what you're working on and how much work is left. The work item also helps enforce work-in-progress (WIP) limits so that the team doesn't take on too much work at one time.

Recall that the team settled on the following top issues for the current sprint.

:::image type="content" source="../../shared/media/deploy-all-tasks.png" alt-text="A screenshot of Azure Boards showing the five tasks for this sprint.":::

> [!NOTE]
> Within an Azure DevOps organization, work items are numbered sequentially. In your project, the number for each work item might not match what you see here.

Here you move the first item, **Create a multistage pipeline**, to the **Doing** column. Then you assign yourself to the work item. **Create a multistage pipeline** relates to defining each stage of deploying the *Space Game* website.

To set up the work item:

1. From Azure DevOps, go to **Boards**. Then, from the menu, select **Boards**.

    :::image type="content" source="../../shared/media/azure-devops-boards-menu.png" alt-text="A screenshot of Azure DevOps showing the location of the Boards menu.":::

1. In the **Create a multistage pipeline** card, select the down arrow. Then, assign the work item to yourself.

    :::image type="content" source="../../shared/media/azure-boards-down-chevron.png" alt-text="Screenshot of Azure Boards showing the location of the down arrow.":::

1. Move the work item from the **To Do** column to the **Doing** column.

    :::image type="content" source="../media/3-azure-boards-wi1-doing.png" alt-text="A screenshot of Azure Boards showing the card in the Doing column.":::

At the end of this module, you'll move the card to the **Done** column, after you complete the task.

[!include[](../../shared/includes/deploy-local-setup.md)]

## Create the Azure App Service environments

Here, you create the environments that define the pipeline stages. You create one App Service instance for each stage: *Dev*, *Test*, and *Staging*.

In [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true), you brought up App Service through the Azure portal. Although the portal is a great way to explore what's available on Azure or to do basic tasks, bringing up components such as App Service can be tedious.

In this module, you use the Azure CLI to bring up three App Service instances. You can access the Azure CLI from a terminal or through Visual Studio Code. Here, you access the Azure CLI from Azure Cloud Shell. This browser-based shell experience is hosted in the cloud. In Cloud Shell, the Azure CLI is configured for use with your Azure subscription.

> [!IMPORTANT]
> To complete the exercises in this module, you need your own Azure subscription.

### Bring up Cloud Shell through the Azure portal

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true), and sign in.
1. From the menu, select **Cloud Shell**. When prompted, select the **Bash** experience.

    :::image type="content" source="../../shared/media/azure-portal-menu-cloud-shell.png" alt-text="A screenshot of the Azure portal showing the location of the Cloud Shell menu item.":::

    > [!NOTE]
    > Cloud Shell requires an Azure storage resource to persist any files that you create in the Cloud Shell. When you first open the Cloud Shell, you're prompted to create a resource group, storage account, and Azure Files share. This setup is automatically used for all future Cloud Shell sessions.

### Select an Azure region

A *region* is one or more Azure datacenters within a geographic location. East US, West US, and North Europe are examples of regions. Every Azure resource, including an App Service instance, is assigned a region.

To make commands easier to run, start by selecting a default region. After you specify the default region, later commands use that region unless you specify a different region.

1. From the Cloud Shell, to list the regions that are available from your Azure subscription, run the following `az account list-locations` command.

    ```azurecli
    az account list-locations \
      --query "[].{Name: name, DisplayName: displayName}" \
      --output table
    ```

1. From the `Name` column in the output, select a region that's close to you. For example, choose `eastasia` or `westus2`.

1. Run `az configure` to set your default region. Replace `<REGION>` with the name of the region you selected.

    ```azurecli
    az configure --defaults location=<REGION>
    ```

    This example sets `westus2` as the default region:

    ```azurecli
    az configure --defaults location=westus2
    ```

### Create the App Service instances

Here, you create the App Service instances for the three stages you deploy to: *Dev*, *Test*, and *Staging*. Here's a brief overview of the process you follow:

1. Generate a random number that makes your web app's domain name unique.

    This step is for learning purposes. In practice, you would choose a domain name that matches the name of your app or service.
1. Create a resource group that contains all of your App Service instances.

    For learning purposes, here you create one resource group that contains all of your App Service instances. In practice, you might create a separate resource group for each App Service instance so that you can better control the life cycle of each instance.

1. Create an App Service plan.

    An App Service plan defines the CPU, memory, and storage resources for your web app. Here, you use the **B1 Basic** plan. This plan is intended for apps that have low traffic requirements. The **Standard** and **Premium** plans are for production workloads. These plans run on dedicated virtual machine instances.

1. For each of the  *Dev*, *Test*, and *Staging* environments, create an App Service instance.
1. Get the host name for each environment.
1. Verify that each environment is running, and that the home page is accessible.

   > [!NOTE]
   > For learning purposes, here, you use the default network settings. These settings make your site accessible from the internet. In practice, you could configure an Azure virtual network that places your website in a network that's not internet routable, and that only you and your team can access. Later, you could reconfigure your network to make the website available to your users.

To create your App Service instances, follow these steps:

1. From the Cloud Shell, generate a random number that makes your web app's domain name unique.

    ```bash
    webappsuffix=$RANDOM
    ```

1. To create a resource group named *tailspin-space-game-rg*, run the following `az group create` command.

    ```azurecli
    az group create --name tailspin-space-game-rg
    ```

1. To create the App Service plan named *tailspin-space-game-asp*, run the following `az appservice plan create` command.

    ```azurecli
    az appservice plan create \
      --name tailspin-space-game-asp \
      --resource-group tailspin-space-game-rg \
      --sku B1 \
      --is-linux
    ```

    The `--sku` argument specifies the B1 plan. This plan runs on the Basic tier. The `--is-linux` argument specifies to use Linux workers.

    > [!IMPORTANT]
    > If the B1 SKU isn't available in your Azure subscription, [select a different plan](https://azure.microsoft.com/pricing/details/app-service/linux/?azure-portal=true), such as S1 (Standard).

1. To create the three App Service instances, one for each environment (*Dev*, *Test*, and *Staging*), run the following `az webapp create` commands.

    ```azurecli
    az webapp create \
      --name tailspin-space-game-web-dev-$webappsuffix \
      --resource-group tailspin-space-game-rg \
      --plan tailspin-space-game-asp \
      --runtime "DOTNET|6.0"

    az webapp create \
      --name tailspin-space-game-web-test-$webappsuffix \
      --resource-group tailspin-space-game-rg \
      --plan tailspin-space-game-asp \
      --runtime "DOTNET|6.0"

    az webapp create \
      --name tailspin-space-game-web-staging-$webappsuffix \
      --resource-group tailspin-space-game-rg \
      --plan tailspin-space-game-asp \
      --runtime "DOTNET|6.0"
    ```

    For learning purposes, here, you apply the same App Service plan, B1 Basic, to each App Service instance. In practice, you would assign a plan that matches your expected workload.

    For example, for the environments that map to the *Dev* and *Test* stages, B1 Basic might be appropriate because you want only your team to access the environments.

    For the *Staging* environment, you would select a plan that matches your production environment. That plan would likely provide greater CPU, memory, and storage resources. Under the plan, you can run performance tests, like load tests, in an environment that resembles your production environment. You can run the tests without affecting live traffic to your site.

1. To list the host name and state of each App Service instance, run the following `az webapp list` command.

    ```azurecli
    az webapp list \
      --resource-group tailspin-space-game-rg \
      --query "[].{hostName: defaultHostName, state: state}" \
      --output table
    ```

    Note the host name for each running service. You need these host names later when you verify your work. Here's an example:

    ```output
    HostName                                                 State
    -------------------------------------------------------  -------
    tailspin-space-game-web-dev-21017.azurewebsites.net      Running
    tailspin-space-game-web-test-21017.azurewebsites.net     Running
    tailspin-space-game-web-staging-21017.azurewebsites.net  Running
    ```

1. As an optional step, go to one or more of the host names. Verify that they're running, and that the default home page appears.

    Here's what you see:

    :::image type="content" source="../../shared/media/app-service-default.png" alt-text="A screenshot of a web browser showing the default home page on Azure App Service.":::

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/create-multi-stage-pipeline/7-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you're not charged for Azure resources after you complete this module. Be sure to perform the cleanup steps even if you don't complete this module.

## Create pipeline variables in Azure Pipelines

In [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true), you added a variable to your pipeline that stores the name of your web app in App Service. Here you do the same. But this time, you add one variable for each App Service instance that corresponds to a *Dev*, *Test*, or *Staging* stage in your pipeline.

You could hard-code these names in your pipeline configuration, but if you define them as variables, your configuration is more reusable. Additionally, if the names of your App Service instances change, you can update the variables and trigger your pipeline without modifying your configuration.

To add the variables:

1. In Azure DevOps, go to your **Space Game - web - Multistage** project.
1. Under **Pipelines**, select **Library**.

    :::image type="content" source="../../create-release-pipeline/media/5-pipelines-library.png" alt-text="A screenshot of Azure Pipelines showing the location of the Library menu option.":::
1. Select **+ Variable group**.
1. Under **Properties**, enter **Release** for the variable group name.
1. Under **Variables**, select **+ Add**.
1. For the name of your variable, enter *WebAppNameDev*. For the value, enter the name of the App Service instance that corresponds to your *Dev* environment, such as *tailspin-space-game-web-dev-1234*.
1. Repeat the previous two steps twice more to create variables for your *Test* and *Staging* environments. Here are examples:

    | Variable name         | Example value                            |
    |-----------------------|------------------------------------------|
    | *WebAppNameTest*    | *tailspin-space-game-web-test-1234*    |
    | *WebAppNameStaging* | *tailspin-space-game-web-staging-1234* |

    Be sure to replace each example value with the App Service instance that corresponds to your environment.

    > [!IMPORTANT]
    > Set the name of the App Service instance, not its host name. In this example, you would enter *tailspin-space-game-web-dev-1234* and not *tailspin-space-game-web-dev-1234.azurewebsites.net*.

1. Near the beginning of the page, select **Save** to save your variable in the pipeline.

    Your variable group resembles this one:

    :::image type="content" source="../media/3-library-variable-group.png" alt-text="A screenshot of Azure Pipelines showing the variable group. The group contains three variables.":::

## Create the dev and test environments

In [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true), you created an environment for the **dev** environment. Here, you repeat the process for both the **dev** and **test** environments. Later, you set up the **staging** environment, which includes more criteria.

To create the **dev** and **test** environments:

1. From Azure Pipelines, select **Environments**.

    :::image type="content" source="../../shared/media/pipelines-environments.png" alt-text="A screenshot of Azure Pipelines showing the location of the Environments menu option.":::

1. To create the **dev** environment:
    1. Select **Create environment**.
    1. Under **Name**, enter *dev*.
    1. Leave the remaining fields at their default values.
    1. Select **Create**.
1. To create the **test** environment:
    1. Return to the **Environments** page.
    1. Select **New environment**.
    1. Under **Name**, enter *test*.
    1. Select **Create**.

## Create a service connection

Here, you create a service connection that enables Azure Pipelines to access your Azure subscription. Azure Pipelines uses this service connection to deploy the website to App Service. You created a similar service connection in the previous module.

> [!IMPORTANT]
> Make sure that you're signed in to both the Azure portal and Azure DevOps under the same Microsoft account.

1. In Azure DevOps, go to your **Space Game - web - Multistage** project.
1. From the lower-left corner of the page, select **Project settings**.
1. Under **Pipelines**, select **Service connections**.
1. Select **New service connection**, then select **Azure Resource Manager**, and then select **Next**.
1. At the beginning of the page, select **Service principal (automatic)**. Then, select **Next**.
1. Fill in these fields:

    | Field                   | Value                                      |
    |-------------------------|--------------------------------------------|
    | Scope level             | **Subscription**                           |
    | Subscription            | Your Azure subscription                    |
    | Resource Group          | **tailspin-space-game-rg**                 |
    | Service connection name | *Resource Manager - Tailspin - Space Game* |

    During the process, you might be prompted to sign in to your Microsoft account.

1. Ensure that you select **Grant access permission to all pipelines**.

1. Select **Save**.

    To verify that it can connect to your Azure subscription, Azure DevOps performs a test connection. If Azure DevOps can't connect, you have the chance to sign in a second time.
