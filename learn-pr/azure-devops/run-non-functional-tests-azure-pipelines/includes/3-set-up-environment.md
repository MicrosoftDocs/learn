In this section, you'll make sure that your Azure DevOps organization is set up to complete the rest of this module. You'll also create the Azure App Service environments to which you'll deploy.

To set up your system, you'll:

> [!div class="checklist"]
> * Add a user to ensure that Azure DevOps can connect to your Azure subscription.
> * Set up an Azure DevOps project for this module.
> * On Azure Boards, move the work item for this module to the **Doing** column.
> * Create the Azure App Service environments by using the Azure CLI in Azure Cloud Shell.
> * Create pipeline variables that define the names of your App Service environments.
> * Create a service connection that enables Azure Pipelines to access your Azure subscription securely.

## Add a user to Azure DevOps

To complete this module, you need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true). You can get started with Azure for free.

Although you don't need an Azure subscription to work with Azure DevOps, in this module you'll use Azure DevOps to deploy to resources that exist in your Azure subscription. To simplify the process, you should use the same Microsoft account to sign in to both your Azure subscription and your Azure DevOps organization.

If you use different Microsoft accounts to sign in to Azure and Azure DevOps, add a user to your DevOps organization under the Microsoft account that you use to sign in to Azure. For more information, see [Add users to your organization or project](/azure/devops/organizations/accounts/add-organization-users?azure-portal=true&tabs=browser). When you add the user, choose the **Basic** access level.

Then, sign out of Azure DevOps and sign in again under the Microsoft account that you use to sign in to your Azure subscription.

## Get the Azure DevOps project

Here, you'll make sure that your Azure DevOps organization is set up to complete the rest of this module. You'll start by running a template that creates your project in Azure DevOps.

The modules in this learning path are part of a progression that follows the Tailspin web team through their DevOps journey. For learning purposes, each module has an associated Azure DevOps project.

### Run the template

Run a template that sets up your Azure DevOps organization.

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?x-ms-routing-name=self&name=run-non-functional-tests&azure-portal=true)

On the Azure DevOps Demo Generator site, follow these steps to run the template.

1. Select **Sign In** and accept the usage terms.
1. On the **Create New Project** page, select your Azure DevOps organization, then enter a project name such as *Space Game - web - Nonfunctional tests*.

    :::image type="content" source="../media/3-create-new-project.png" alt-text="Screenshot for Creating a project through the Azure DevOps Demo Generator.":::

1. Select **Yes, I want to fork this repository**, then select **Authorize**.
1. Select **Create Project**.

    The template takes a few moments to run.
1. Select **Navigate to project** to go to your project in Azure DevOps.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/run-non-functional-tests-azure-pipelines/6-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps even if you don't complete this module.

[!include[](../../shared/includes/project-visibility.md)]

[!include[](../../shared/includes/deploy-local-setup.md)]

## Create the Azure App Service environments

Here, you'll create the environments that define the pipeline stages. You'll create one App Service instance that corresponds to each stage: _Dev_, _Test_, and _Staging_.

In previous modules, you used the Azure CLI to create your App Service instances. Here, you'll do the same.

> [!IMPORTANT]
> Remember that you need your own Azure subscription to complete the exercises in this module.

### Bring up Cloud Shell through the Azure portal

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. On the menu bar, select **Cloud Shell**. When you're prompted, select the **Bash** experience.

### Select an Azure region

Here you specify the default _region_, or geographic location, where your Azure resources are to be created.

1. In Cloud Shell, run the following `az account list-locations` command to list the regions that are available from your Azure subscription.

    ```azurecli
    az account list-locations \
      --query "[].{Name: name, DisplayName: displayName}" \
      --output table
    ```

1. From the **Name** column in the output, choose a region that's close to you. For example, choose **eastasia** or **westus2**.

1. Run `az configure` to set your default region. Replace **\<REGION>** with the name of the region that you chose.

    ```azurecli
    az configure --defaults location=<REGION>
    ```

    Here's an example that sets **westus2** as the default region:

    ```azurecli
    az configure --defaults location=westus2
    ```

### Create the App Service instances

Here, you'll create the App Service instances for the three stages to which you'll deploy: _Dev_, _Test_, and _Staging_.

> [!NOTE]
> For learning purposes, use the default network settings. These settings make your site accessible from the internet. In practice, you could configure an Azure virtual network that places your website in a network that's not routable from the internet, and that's accessible to only your team. Later, when you're ready, you could reconfigure your network to make the website available to your users.

1. In Cloud Shell, generate a random number that makes your web app's domain name unique.

    ```bash
    webappsuffix=$RANDOM
    ```

1. Run the following `az group create` command to create a resource group that's named **tailspin-space-game-rg**.

    ```azurecli
    az group create --name tailspin-space-game-rg
    ```

1. Run the following `az appservice plan create` command to create an App Service plan that's named **tailspin-space-game-asp**.

    ```azurecli
    az appservice plan create \
      --name tailspin-space-game-asp \
      --resource-group tailspin-space-game-rg \
      --sku B1 \
      --is-linux
    ```

    The `--sku` argument specifies the **B1** plan, which runs on the **Basic** tier. The `--is-linux` argument specifies to use Linux workers.

    > [!IMPORTANT]
    > If the **B1** SKU isn't available as part of your Azure subscription, [choose a different plan](https://azure.microsoft.com/pricing/details/app-service/linux/?azure-portal=true), such as **S1** (**Standard**).

1. Run the following `az webapp create` commands to create the three App Service instances, one for each of the  _Dev_, _Test_, and _Staging_ environments.

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

    For learning purposes, here, you apply the same App Service plan, **B1 Basic**, to each App Service instance. In practice, you'd assign a plan that matches your expected workload.

1. Run the following `az webapp list` command to list the host name and state of each App Service instance.

    ```azurecli
    az webapp list \
      --resource-group tailspin-space-game-rg \
      --query "[].{hostName: defaultHostName, state: state}" \
      --output table
    ```

    Note the hostname for each running service. You'll need these host names later when you verify your work. Here's an example:

    ```output
    HostName                                                 State
    -------------------------------------------------------  -------
    tailspin-space-game-web-dev-21017.azurewebsites.net      Running
    tailspin-space-game-web-test-21017.azurewebsites.net     Running
    tailspin-space-game-web-staging-21017.azurewebsites.net  Running
    ```

1. As an optional step, go to one or more of the listed names to verify that they're running and that the default home page appears.

    You see this page:

    :::image type="content" source="../../shared/media/app-service-default.png" alt-text="Screenshot of the default home page on Azure App Service.":::

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/run-non-functional-tests-azure-pipelines/6-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you're not charged for Azure resources after you complete this module. Be sure to follow the cleanup steps even if you don't complete this module.

## Create pipeline variables in Azure Pipelines

In [Run functional tests in Azure Pipelines](/training/modules/run-functional-tests-azure-pipelines?azure-portal=true), you added one variable for each of the App Service instances. The instances correspond to the _Dev_, _Test_, and _Staging_ stages in your pipeline. Here, you'll follow the same pattern.

Each stage in your pipeline configuration uses the variables to identify which App Service instance to deploy to.

To add the variables:

1. In Azure DevOps, go to your **Space Game - web - Nonfunctional tests** project.
1. Under **Pipelines**, select **Library**.

    :::image type="content" source="../../create-release-pipeline/media/5-pipelines-library.png" alt-text="Screenshot of Azure Pipelines, showing the Library menu option.":::
1. Select **+ Variable group**.
1. For the variable group name, under **Properties**, enter *Release*.
1. Under **Variables**, select **+ Add**.
1. For the name of your variable, enter *WebAppNameDev*. For its value, enter the name of the App Service instance that corresponds to your _Dev_ environment, such as *tailspin-space-game-web-dev-1234*.
1. Repeat steps 5 and 6 twice more to create variables for your _Test_ and _Staging_ environments, as shown in this table:

    | Variable name         | Example value                            |
    |-----------------------|------------------------------------------|
    | *WebAppNameTest*    | *tailspin-space-game-web-test-1234*    |
    | *WebAppNameStaging* | *tailspin-space-game-web-staging-1234* |

    Be sure to replace each example value with the App Service instance that corresponds to your environment.

    > [!IMPORTANT]
    > Make sure that you set the name of the App Service instance, not its host name. In this example, you would enter *tailspin-space-game-web-dev-1234* and not *tailspin-space-game-web-dev-1234.azurewebsites.net*.

1. To save your variable to the pipeline, select **Save** near the top of the page.

    Your variable group resembles this one:

    :::image type="content" source="../media/3-library-variable-group.png" alt-text="Screenshot of Azure Pipelines, showing the variable group. The group contains three variables.":::

## Create the dev, test, and staging environments

In [Run functional tests in Azure Pipelines](/training/modules/run-functional-tests-azure-pipelines?azure-portal=true), you created environments for the **dev**, **test**, and **staging** environments. Here, you'll repeat the process.

To create the **dev**, **test**, and **staging** environments:

1. From Azure Pipelines, select **Environments**.

    :::image type="content" source="../../shared/media/pipelines-environments.png" alt-text="Screenshot of Azure Pipelines showing the location of the Environments menu option.":::

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
1. To create the **staging** environment:
    1. Return to the **Environments** page.
    1. Select **New environment**.
    1. Under **Name**, enter *staging*.
    1. Select **Create**.

## Create a service connection

Here, you'll create a service connection that enables Azure Pipelines to access your Azure subscription. Azure Pipelines uses this service connection to deploy the website to App Service. You created a similar service connection in the previous module.

> [!IMPORTANT]
> Make sure that you're signed in to both the Azure portal and Azure DevOps under the same Microsoft account.

1. In Azure DevOps, go to your **Space Game - web - Nonfunctional tests** project.
1. From the bottom corner of the page, select **Project settings**.
1. Under **Pipelines**, select **Service connections**.
1. Select **New service connection**, then choose **Azure Resource Manager**, then select **Next**.
1. Near the top of the page, **Service principal (automatic)**. Then select **Next**.
1. Fill in these fields:

    | Field                   | Value                                      |
    |-------------------------|--------------------------------------------|
    | Scope level             | **Subscription**                           |
    | Subscription            | Your Azure subscription                    |
    | Resource Group          | **tailspin-space-game-rg**                 |
    | Service connection name | *Resource Manager - Tailspin - Space Game* |

    During the process, you might be prompted to sign in to your Microsoft account.

1. Ensure that **Grant access permission to all pipelines** is selected.

1. Select **Save**.

    Azure DevOps performs a test connection to verify that it can connect to your Azure subscription. If Azure DevOps can't connect, you have the chance to sign in a second time.
