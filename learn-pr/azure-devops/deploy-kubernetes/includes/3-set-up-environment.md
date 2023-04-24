In this section, you will configure your Azure DevOps organization to proceed with the rest of this module and create an Azure Kubernetes Service environment to deploy your application to.

To achieve these objectives, you will:

> [!div class="checklist"]
> * Add a user to your Azure DevOps organization.
> * Set up your Azure DevOps project.
> * Manage your workflow with Azure Boards.
> * Create Azure resources using Azure CLI.
> * Create pipeline variables in Azure Pipelines.
> * Create a service connection tto authenticate with Azure.
> * Update your Kubernetes deployment manifest.

## Add a user to your organization

To complete this module, an [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) is required, which can be obtained for free. you need your own . You can get started with Azure for free.

Although not necessary to work with Azure DevOps, an Azure subscription is necessary to deploy to Azure resources via Azure DevOps. To make the process more straightforward, use the same Microsoft account to sign in to both your Azure subscription and your Azure DevOps organization.

If you sign in to Azure and Azure DevOps using different Microsoft accounts, you can still proceed by adding a user to your DevOps organization under the Microsoft account associated with your Azure subscription.
See [Add users to your organization or project](/azure/devops/organizations/accounts/add-organization-users?azure-portal=true&tabs=browser) for more details. WWhile adding the user, select the **Basic** access level.

After adding the user with Basic access level, sign out of Azure DevOps and sign back in using the Microsoft account associated with your Azure subscription.

## Get the Azure DevOps project

In this section, you will run a template to create your project in Azure DevOps.

### Run the template

Run the template to set up your Azure DevOps project for this module:

> [!div class="nextstepaction"]
> [Run the template](https://azuredevopsdemogenerator.azurewebsites.net/?x-ms-routing-name=self&name=Deploymulti-containersolutionstoKubernetes&azure-portal=true)

From the Azure DevOps Demo Generator portal, follow these steps to run the template:

1. Select **Sign In** and agree to the terms of use.

1. On the **Create New Project** page, select your Azure DevOps organization and provide a project name, such as *Space Game - web - Kubernetes*.

    :::image type="content" source="../media/3-create-new-project.png" alt-text="Screenshot of the Azure DevOps Demo Generator showing the process to create the project.":::

1. Select **Yes, I want to import this repository**, and then **Authorize**. If a window pops up, grant permission to access your GitHub account.

    > [!IMPORTANT]
    > Selecting this option is necessary for the template to connect to your GitHub repository. Please choose it even if you have already forked the *Space Game* repository as the template will use your existing fork.

1. Select **Create Project** and wait for the template to finish running, which may take a few minutes.

1. Select **Navigate to project** to access your project in Azure DevOps.

> [!IMPORTANT]
> The unit [Clean up your Azure DevOps environment](/training/modules/deploy-kubernetes/5-clean-up-environment?azure-portal=true) in this module includes crucial steps for cleanup. It is recommended to perform these steps to avoid running out of free build minutes. Even if you don't finish this module, it is important to follow the cleanup steps.

[!include[](../../shared/includes/project-visibility.md)]

## Move the work item to Doing

In this step, you will assign a work item to yourself on Azure Boards and move it to the Doing state. In real-world scenarios, you and your team would create work items at the beginning of each sprint or work iteration.

Assigning work items provides you with a checklist to work from and gives other team members visibility into your progress and remaining work. It also helps enforce work-in-progress (WIP) limits to prevent the team from taking on too much work at once.

1. Navigate to **Boards** in Azure DevOps, and then select **Boards** from the menu.

    :::image type="content" source="../../shared/media/azure-devops-boards-menu.png" alt-text="Screenshot of Azure DevOps showing the location of the Boards menu.":::

1. Assign the **Create multi-container version of web site orchestrated with Kubernetes** work item to yourself by selecting the down arrow located at the bottom of the card.

    :::image type="content" source="../../shared/media/azure-boards-down-chevron.png" alt-text="Screenshot of Azure Boards showing the location of the down arrow.":::

1. Drag and drop the work item from the **To Do** column to the **Doing** column. You will move the task to the Done column at the end of this module when you have completed it.

    :::image type="content" source="../media/3-azure-boards-wi1-doing.png" alt-text="Screenshot of Azure Boards showing the card in the Doing column.":::

## Create the Azure Kubernetes Service environment

Here you create the Azure Kubernetes Service resources that are required to deploy the new container version of the site.

In [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true), you brought up Azure resources through the Azure portal. Although the portal is a great way to explore what's available on Azure or to do basic tasks, bringing up components such as Azure Kubernetes Service can be tedious.

In this module, you use the Azure CLI to bring up the resources needed to deploy and run your app on Azure Kubernetes Service. You can access the Azure CLI from a terminal or through Visual Studio Code. Here you access the Azure CLI from Azure Cloud Shell. This browser-based shell experience is hosted in the cloud. In Cloud Shell, the Azure CLI is configured for use with your Azure subscription.

> [!IMPORTANT]
> You need your own Azure subscription to complete the exercises in this module.

### Bring up Cloud Shell through the Azure portal

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true), and sign in.

1. From the menu, select **Cloud Shell**. When prompted, select the **Bash** experience.

    :::image type="content" source="../../shared/media/azure-portal-menu-cloud-shell.png" alt-text="Screenshot of the Azure portal showing the location of the Cloud Shell menu item.":::

    > [!NOTE]
    > Cloud Shell requires an Azure storage resource to persist any files that you create in Cloud Shell. When you first open Cloud Shell, you're prompted to create a resource group, storage account, and Azure Files share. This setup is automatically used for all future Cloud Shell sessions.

### Select an Azure region

A _region_ is one or more Azure datacenters within a geographic location. East US, West US, and North Europe are examples of regions. Every Azure resource, including an App Service instance, is assigned a region.

To make commands easier to run, start by selecting a default region. After you specify the default region, later commands use that region unless you specify a different region.

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

    This example sets `westus2` as the default region.

    ```azurecli
    az configure --defaults location=westus2
    ```

### Create Bash variables

Create Bash variables to make the setup process more convenient and less error-prone. Using variables for shared text strings helps avoid accidental typos.

1. From Cloud Shell, generate a random number. This will make it easier to create globally unique names for certain services in the next step.

    ```bash
    resourceSuffix=$RANDOM
    ```

1. Create globally unique names for your Azure Container Registry and Azure Kubernetes Service instance. Note that these commands use double quotes, which instructs Bash to interpolate the variables using the inline syntax.

    ```bash
    registryName="tailspinspacegame${resourceSuffix}"
    aksName="tailspinspacegame-${resourceSuffix}"
    ```

1. Create another Bash variable to store the name of your resource group.

    ```bash
    rgName='tailspin-space-game-rg'
    ```

1. Create a variable to hold the latest AKS version available in your default region.

    ```azurecli
    aksVersion=$(az aks get-versions \
      --query 'orchestrators[-1].orchestratorVersion' \
      --output tsv)
    ```

### Create the Azure resources

This solution requires several Azure resources for deployment, which you create now.

   > [!NOTE]
   > For learning purposes, here you use the default network settings. These settings make your site accessible from the internet. In practice, you could configure an Azure virtual network that places your website in a network that's not internet routable, and that only you and your team can access. Later, you could reconfigure your network to make the website available to your users.

1. Run the following `az group create` command to create a resource group using the name defined earlier:

    ```azurecli
    az group create --name $rgName
    ```

1. Run the following `az acr create` command to create an Azure Container Registry using the name defined earlier:

    ```azurecli
    az acr create \
      --name $registryName \
      --resource-group $rgName \
      --sku Standard
    ```

1. Run the following `az aks create` command to create an AKS instance using the name defined earlier:

    ```azurecli
    az aks create \
      --name $aksName \
      --resource-group $rgName \
      --enable-addons monitoring \
      --kubernetes-version $aksVersion \
      --generate-ssh-keys
    ```

   > [!NOTE]
   > It may take 10-15 minutes for the AKS deployment to complete.

1. Create a variable to store the ID of the service principal configured for the AKS instance:

    ```azurecli
    clientId=$(az aks show \
      --resource-group $rgName \
      --name $aksName \
      --query "identityProfile.kubeletidentity.clientId" \
      --output tsv)
    ```

1. Create a variable to store the ID of the Azure Container Registry:

    ```azurecli
    acrId=$(az acr show \
      --name $registryName \
      --resource-group $rgName \
      --query "id" \
      --output tsv)
    ```

1. Run the following `az acr list` command to print the login server for your ACR instance:

    ```azurecli
    az acr list \
     --resource-group $rgName \
     --query "[].{loginServer: loginServer}" \
     --output table
    ```

    Note the login server for your container registry. You'll need this when configuring the pipeline and environment in upcoming steps. Here's an example:

    ```output
    LoginServer                      
    --------------------------------
    tailspinspacegame4692.azurecr.io
    ```

1. Run the following `az role assignment create` command to create a role assignment to authorize the AKS cluster to connect to the Azure Container Registry:

    ```azurecli
    az role assignment create \
      --assignee $clientId \
      --role AcrPull \
      --scope $acrId
    ```

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/deploy-kubernetes/5-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you're not charged for Azure resources after you complete this module. Be sure to perform the cleanup steps even if you don't complete this module.

## Create pipeline variables in Azure Pipelines

In [Automate Docker container deployments with Azure Pipelines](/training/modules/deploy-docker?azure-portal=true), you added a variable to your pipeline that stores the name of your Azure Container Registry. Here you do the same.

You could hard-code this name in your pipeline configuration, but if you define it as a variable, your configuration will be more reusable. Plus, if the name of your instance changes, you can update the variable and trigger your pipeline without modifying your configuration.

To add the variables:

1. In Azure DevOps, go to your **Space Game - web - Kubernetes** project.

1. Under **Pipelines**, select **Library**.

    :::image type="content" source="../media/3-pipelines-library.png" alt-text="Screenshot of Azure Pipelines showing the Library menu option.":::

1. Select **+ Variable group**.

1. Under **Properties**, enter *Release* for the variable group name.

1. Under **Variables**, select **Add**.

1. For the name of your variable, enter *RegistryName*. For the value, enter the login server for your Azure Container Registry, such as *tailspinspacegame4692.azurecr.io*.

1. Near the top of the page, select **Save** to save your variable to the pipeline.

    Your variable group resembles this one:

    :::image type="content" source="../media/3-library-variable-group.png" alt-text="Screenshot of Azure Pipeline showing the variable group. The group contains one variable.":::

## Create required service connections

Here, you create service connections that enable Azure Pipelines to access your Azure Container Registry and Azure Kubernetes Service instances. Azure Pipelines uses these service connections to push your containers, as well as to instruct your AKS cluster to pull them in to update the deployed service.

> [!IMPORTANT]
> Ensure that you're signed in to both the Azure portal and Azure DevOps under the same Microsoft account.

1. In Azure DevOps, go to your **Space Game - web - Kubernetes** project.

1. From the lower corner of the page, select **Project settings**.

1. Under **Pipelines**, select **Service connections**.

1. Select **New service connection**, then select **Docker Registry**, and then select **Next**.

1. Near the top of the page, select **Azure Container Registry**.

1. Enter the following values for each setting:

    | Setting               | Value                                        |
    |---------------------|----------------------------------------------|
    | Subscription    | Your Azure subscription                          |
    | Azure container registry  | **Select the one you created earlier** |
    | Service connection name | *Container Registry Connection*          |

1. Ensure that **Grant access permission to all pipelines** is selected.

1. Select **Save**.

1. Select **New service connection**, then select **Kubernetes**, and then select **Next**.

1. Near the top of the page, select **Azure Subscription**.

1. Enter the following values for each setting.

    | Setting               | Value                                        |
    |---------------------|----------------------------------------------|
    | Subscription    | Your Azure subscription                          |
    | Cluster  | *Select the one you created earlier* |
    | Namespace | *default*          |
    | Service connection name | *Kubernetes Cluster Connection*          |

1. Ensure that **Grant access permission to all pipelines** is selected.

1. Select **Save**.

### Create the environment

1. Under **Pipelines**, select **Environments**.

    :::image type="content" source="../media/3-pipelines-environments.png" alt-text="Screenshot of Azure Pipelines showing the Environments menu option.":::

1. Select **Create environment**.
1. Under **Name**, enter *spike*.
1. Under **Resource**, select **Kubernetes**.
1. Select **Next**.
1. Under **Provider**, select **Azure Kubernetes Service**.
1. Under **Azure subscription**, select your subscription.
1. Under **Cluster**, select the AKS cluster you created earlier.
1. Under **Namespace**, **Existing** and **default**.
1. Select **Validate and create**.

## Update the Kubernetes deployment manifest in your GitHub source project

Here you update the Kubernetes *deployment.yml* manifest to point to the container registry you created earlier.

1. Go to the GitHub project created for this module. The project is named *mslearn-tailspin-spacegame-web-kubernetes* in your GitHub account.

1. Open the file at *manifests/deployment.yml* in edit mode.

    :::image type="content" source="../media/3-github-edit-mode.png" alt-text="Screenshot of GitHub showing the location of the edit mode icon.":::

1. Change the container image references to use your ACR login server. The following code uses *tailspinspacegame2439.azurecr.io* as an example.

    [!code-yml[](code/3-1-deployment.yml?highlight=17,37)]

1. Commit the changes to the `main` branch.
