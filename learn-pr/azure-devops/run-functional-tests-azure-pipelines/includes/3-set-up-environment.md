In this section, you'll make sure that your Azure DevOps organization is set up to complete the rest of this module. You also create the Azure App Service environments that you'll deploy.

To accomplish these tasks, you:

> [!div class="checklist"]
> * Add a user to ensure that Azure DevOps can connect to your Azure subscription.
> * Set up an Azure DevOps project for this module.
> * Move the work item for this module on Azure Boards to the **Doing** column.
> * Create the Azure App Service environments by using the Azure CLI in Azure Cloud Shell.
> * Create pipeline variables that define the names of your App Service environments.
> * Create a service connection that enables Azure Pipelines to access your Azure subscription securely.

## Add a user to Azure DevOps

To complete this module, you need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true). You can get started with Azure for free.

Although you don't need an Azure subscription to work with Azure DevOps, here, you'll use Azure DevOps to deploy to resources that exist in your Azure subscription. To simplify the process, sign in to both your Azure subscription and your Azure DevOps organization under the same Microsoft account.

If you use different Microsoft accounts to sign in to Azure and Azure DevOps, add a user to your DevOps organization under the Microsoft account that you use to sign in to Azure. For more information, see [Add users to your organization or project](/azure/devops/organizations/accounts/add-organization-users?azure-portal=true&tabs=browser). When you add the user, choose the **Basic** access level.

Then sign out of Azure DevOps. Then sign in again under the Microsoft account that you use to sign in to your Azure subscription.

## Get the Azure DevOps project

Here, you make sure that your Azure DevOps organization is set up to complete the rest of this module. You accomplish this task by running a template that creates a project in Azure DevOps.

The modules in this learning path form a progression as you follow the Tailspin web team through their DevOps journey. For learning purposes, each module has an associated Azure DevOps project.

### Run the template

Run a template that sets up your Azure DevOps organization.

1. [Get and run the ADOGenerator project](https://github.com/microsoft/AzDevOpsDemoGenerator/blob/main/docs/RunApplication.md) in Visual Studio or the IDE of your choice.

1. When prompted to **Enter the template number from the list of templates**, enter **32** for **Run functional tests in Azure Pipelines**, then press **Enter**.

1. Choose your authentication method. You can [set up and use a Personal Access Token (PAT)](/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate#create-a-pat) or use device login.

    > [!NOTE]
    > If you set up a PAT, If you set up a PAT, make sure to authorize the necessary [scopes](/azure/devops/integrate/get-started/authentication/oauth#scopes). For this module, you can use **Full access**, but in a real-world situation, you should ensure you grant only the necessary scopes.

1. Enter your Azure DevOps organization name, then press **Enter**.

1. If prompted, enter your Azure DevOps PAT, then press **Enter**.

1. Enter a project name such as *Space Game - web - Functional tests*, then press **Enter**.

1. Once your project is created, go to your Azure DevOps organization in your browser (at `https://dev.azure.com/<your-organization-name>/`) and select the project.

### Fork the repository

If you haven't already, create a fork of the **mslearn-tailspin-spacegame-web-deploy** repository.

1. On GitHub, go to the [mslearn-tailspin-spacegame-web-deploy](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web-deploy) repository.

1. Select **Fork** at the top-right of the screen.

1. Choose your GitHub account as the **Owner**, then select **Create fork**.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/run-functional-tests-azure-pipelines/7-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you don't run out of free build minutes. Be sure to perform the cleanup steps even if you don't complete this module.

[!include[](../../shared/includes/project-visibility.md)]

## Move the work item to Doing

In this part, you assign yourself a work item in Azure Boards that relates to this module. You also move the work item to the **Doing** state. In practice, your team would create work items at the start of each sprint or work iteration.

Assigning work in this way gives you a checklist from which to work. It gives your team visibility into what you're working on and how much work is left. It also helps the team enforce limits on work in progress (WIP) to avoid taking on too much work at one time.

Recall that the team settled on these top issues for the current sprint:

:::image type="content" source="../../shared/media/deploy-all-tasks.png" alt-text="A screenshot of Azure Boards, showing the tasks for this sprint.":::

> [!NOTE]
> Within an Azure DevOps organization, work items are numbered sequentially. In your project, the number for each work item might not match what you see here.

Here you move the third item, **Automate quality tests**, to the **Doing** column. Then you assign yourself to the work item. **Automate quality tests** relates to automating UI tests for the _Space Game_ website.

To set up the work item:

1. From Azure DevOps, go to **Boards**, and then select **Boards** from the menu.

    :::image type="content" source="../../shared/media/azure-devops-boards-menu.png" alt-text="A screenshot of Azure DevOps showing the location of the Boards menu.":::

1. On the **Automate quality tests** work item, select the down arrow at the bottom of the card. Then assign the work item to yourself.

    :::image type="content" source="../../shared/media/azure-boards-down-chevron.png" alt-text="A screenshot of Azure Boards showing the location of the down arrow.":::
1. Move the work item from the **To Do** column to the **Doing** column.

    :::image type="content" source="../media/3-azure-boards-wi3-doing.png" alt-text="A screenshot of Azure Boards, showing the card in the Doing column.":::

At the end of this module, after you complete the task, you'll move the card to the **Done** column.

[!include[](../../shared/includes/deploy-local-setup.md)]

## Create the Azure App Service environments

Here, you create the environments that define the pipeline stages. You create one App Service instance that corresponds to each stage: _Dev_, _Test_, and _Staging_.

In the [Create a multistage pipeline by using Azure Pipelines](/training/modules/create-multi-stage-pipeline?azure-portal=true) module, you used the Azure CLI to create your App Service instances. Here you'll do the same.

> [!IMPORTANT]
> You need your own Azure subscription to complete the exercises in this module.

### Bring up Cloud Shell through the Azure portal

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. From the menu bar, select **Cloud Shell**. When you're prompted, select the **Bash** experience.

### Select an Azure region

Here, you specify the default _region_, or geographic location, where your Azure resources are to be created.

1. From Cloud Shell, run the following `az account list-locations` command to list the regions that are available from your Azure subscription.

    ```azurecli
    az account list-locations \
      --query "[].{Name: name, DisplayName: displayName}" \
      --output table
    ```

1. From the **Name** column in the output, choose a region that's close to you. For example, choose **eastasia** or **westus2**.

1. Run `az configure` to set your default region. Replace **\<REGION>** with the name of the region you chose.

    ```azurecli
    az configure --defaults location=<REGION>
    ```

    Here's an example that sets **westus2** as the default region:

    ```azurecli
    az configure --defaults location=westus2
    ```

### Create the App Service instances

Here, you create the App Service instances for the three stages you'll deploy to: _Dev_, _Test_, and _Staging_.

> [!NOTE]
> For learning purposes, here, you use the default network settings. These settings make your site accessible from the internet. In practice, you could configure an Azure virtual network that places your website in a network that's not internet routable, and that's accessible only to you and your team. Later, when you're ready, you could reconfigure your network to make the website available to your users.

1. From Cloud Shell, generate a random number that makes your web app's domain name unique.

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
    > If the **B1** SKU isn't part of your Azure subscription, [choose a different plan](https://azure.microsoft.com/pricing/details/app-service/linux/?azure-portal=true), such as **S1** (**Standard**).

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

    For learning purposes, here, you apply the same App Service plan (**B1 Basic**) to each App Service instance. In practice, you'd assign a plan that matches your expected workload.

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

1. As an optional step, copy and paste one or more of the names into your browser to verify that they're running and that the default home page appears.

    You should get this page:

    :::image type="content" source="../../shared/media/app-service-default.png" alt-text="The default home page on Azure App Service.":::

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/run-functional-tests-azure-pipelines/7-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you're not charged for Azure resources after you complete this module. Be sure to perform the cleanup steps even if you don't complete this module.

## Create pipeline variables in Azure Pipelines

In the [Create a multistage pipeline by using Azure Pipelines](/training/modules/create-multi-stage-pipeline?azure-portal=true), you added one variable for each of the App Service instances, which correspond to the _Dev_, _Test_, and _Staging_ stages in your pipeline. Here, you do the same.

Each stage in your pipeline configuration uses these variables to identify which App Service instance to deploy to.

To add the variables:

1. In Azure DevOps, go to your **Space Game - web - Functional tests** project.
1. Under **Pipelines**, select **Library**.

    :::image type="content" source="../../create-release-pipeline/media/5-pipelines-library.png" alt-text="A screenshot of Azure Pipelines, showing the Library menu option.":::
1. Select **+ Variable group**.
1. Under **Properties**, for the variable group name, enter *Release*.
1. Under **Variables**, select **+ Add**.
1. For the name of your variable, enter *WebAppNameDev*. For its value, enter the name of the App Service instance that corresponds to your _Dev_ environment, such as *tailspin-space-game-web-dev-1234*.
1. Repeat steps 5 and 6 twice more to create variables for your _Test_ and _Staging_ environments, as shown in this table:

    | Variable name         | Example value                            |
    |-----------------------|------------------------------------------|
    | *WebAppNameTest*    | *tailspin-space-game-web-test-1234*    |
    | *WebAppNameStaging* | *tailspin-space-game-web-staging-1234* |

    Be sure to replace each example value with the App Service instance that corresponds to your environment.

    > [!IMPORTANT]
    > Set the name of the App Service instance, not its host name. In this example, you would enter *tailspin-space-game-web-dev-1234* and not *tailspin-space-game-web-dev-1234.azurewebsites.net*.

1. Near the top of the page, select **Save** to save your variable to the pipeline.

    Your variable group should resemble this one:

    :::image type="content" source="../media/3-library-variable-group.png" alt-text="A screenshot of Azure Pipelines, showing the variable group. The group contains three variables.":::

## Create the dev, test, and staging environments

In [Create a multistage pipeline by using Azure Pipelines](/training/modules/create-multi-stage-pipeline?azure-portal=true), you created environments for the **dev**, **test**, and **staging** environments. Here, you repeat the process. This time, however, you omit additional criteria such as the requirement for human approval to promote changes from one stage to the next.

To create the **dev**, **test**, and **staging** environments:

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
1. To create the **staging** environment:
    1. Return to the **Environments** page.
    1. Select **New environment**.
    1. Under **Name**, enter *staging*.
    1. Select **Create**.

## Create a service connection

Here, you create a service connection that enables Azure Pipelines to access your Azure subscription. Azure Pipelines uses this service connection to deploy the website to App Service. You created a similar service connection in the previous module.

> [!IMPORTANT]
> Make sure that you're signed in to both the Azure portal and Azure DevOps under the same Microsoft account.

1. In Azure DevOps, go to your **Space Game - web - Functional tests** project.
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
