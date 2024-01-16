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

To complete this module, an [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) is required. You can get started with Azure for free.

Although not necessary to work with Azure DevOps, an Azure subscription is necessary to deploy to Azure resources via Azure DevOps. To make the process more straightforward, use the same Microsoft account to sign in to both your Azure subscription and your Azure DevOps organization.

If you sign in to Azure and Azure DevOps using different Microsoft accounts, you can still proceed by adding a user to your DevOps organization under the Microsoft account associated with your Azure subscription.
See [Add users to your organization or project](/azure/devops/organizations/accounts/add-organization-users?azure-portal=true&tabs=browser) for more details. While adding the user, select the **Basic** access level.

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

In this step, you will create the necessary Azure Kubernetes Service resources to deploy the new container version of the website.

In the previous module, [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true), you used the Azure portal to create Azure resources. While the portal is useful for exploring Azure capabilities and performing basic tasks, creating components like Azure Kubernetes Service can be a time-consuming process.

In this module, you will be using the Azure CLI to create the resources required to deploy and run your application on Azure Kubernetes Service. The Azure CLI can be accessed from a terminal or through Visual Studio Code. However, in this module, you will be accessing the Azure CLI from Azure Cloud Shell. Cloud Shell is a browser-based shell experience hosted in the cloud, which comes preconfigured with the Azure CLI for use with your Azure subscription.

> [!IMPORTANT]
> To complete the exercises in this module, you need your own Azure subscription.

### Launch Cloud Shell

1. Navigate to [Azure portal](https://portal.azure.com?azure-portal=true) and log in.

1. Select **Cloud Shell** option from the menu, and then choose the **Bash** experience when prompted.

    :::image type="content" source="../../shared/media/azure-portal-menu-cloud-shell.png" alt-text="Screenshot of the Azure portal showing the location of the Cloud Shell menu item.":::

> [!NOTE]
> Cloud Shell requires an Azure storage resource to persist any files that you create in Cloud Shell. When you first open Cloud Shell, you're prompted to create a resource group, storage account, and Azure Files share. This setup is automatically used for all future Cloud Shell sessions.

### Select an Azure region

A region refers to one or more Azure datacenters located in a geographic area. Regions such as East US, West US, and North Europe are examples of such areas. Each Azure resource, including an App Service instance, is associated with a region.

To simplify the execution of commands, begin by setting a default region. Once you set a default region, subsequent commands will use that region by default, unless you explicitly specify a different region.

1. From Cloud Shell, run the following command to list the regions available in your Azure subscription:

    ```azurecli
    az account list-locations \
      --query "[].{Name: name, DisplayName: displayName}" \
      --output table
    ```

1. Select a **region** from the Name column in the output that is geographically close to you. For instance, you could choose *eastasia* or *westus2*.

1. Run the following command to set your default region. Replace *REGION* with the name of the region you chose earlier.

    ```azurecli
    az configure --defaults location=<REGION>
    ```

This example sets `westus2` as the default region.

```azurecli
az configure --defaults location=westus2
```

### Create Bash variables

Using Bash variables can make the setup process more convenient and less error-prone. This approach helps avoid accidental typos by defining shared text strings as variables that can be used throughout your script.

1. From Cloud Shell, generate a random number to simplify the creation of globally unique names for certain services in the next step.

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

### Create Azure resources

> [!NOTE]
> In this tutorial, default network settings are used for learning purposes. These settings enable your website to be accessed from the internet. However, in practice, you may choose to configure an Azure virtual network that places your website in a network that is not internet-routable and is only accessible by you and your team. Later, you could reconfigure your network to make the website available to your users.

1. Run the following command to create a resource group with the name you defined earlier:

    ```azurecli
    az group create --name $rgName
    ```

1. Run the `az acr create` command to create an Azure Container Registry with the name you defined earlier:

    ```azurecli
    az acr create \
      --name $registryName \
      --resource-group $rgName \
      --sku Standard
    ```

1. Run the `az aks create` command to create an AKS instance with the name you defined earlier:

    ```azurecli
    az aks create \
      --name $aksName \
      --resource-group $rgName \
      --enable-addons monitoring \
      --kubernetes-version $aksVersion \
      --generate-ssh-keys
    ```

   > [!NOTE]
   > AKS deployment completion may take 10-15 minutes.

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

1. Run the `az acr list` command to retrieve the login server URL for your Azure Container Registry (ACR) instance:

    ```azurecli
    az acr list \
     --resource-group $rgName \
     --query "[].{loginServer: loginServer}" \
     --output table
    ```

    Make sure to take note of the login server for your container registry. You will need this information later when configuring your pipeline. Here's an example:

    ```output
    LoginServer                      
    --------------------------------
    tailspinspacegame4692.azurecr.io
    ```

1. Run the `az role assignment create` command to create a role assignment to authorize the AKS cluster to connect to the Azure Container Registry:

    ```azurecli
    az role assignment create \
      --assignee $clientId \
      --role AcrPull \
      --scope $acrId
    ```

> [!IMPORTANT]
> The unit [Clean up your Azure DevOps environment](/training/modules/deploy-kubernetes/5-clean-up-environment?azure-portal=true) in this module includes crucial steps for cleanup. It is recommended to perform these steps to avoid running out of free build minutes. Even if you don't finish this module, it is important to follow the cleanup steps.

## Create a variable group

In this section you will be adding a variable to your pipeline to store the name of your Azure Container Registry. Defining the name of your Azure Container Registry instance as a variable in your pipeline configuration is recommended over hard-coding it. This makes your configuration more reusable and in case the name of your instance changes, you can easily update the variable and trigger your pipeline without having to modify your configuration.

1. Log in to your Azure DevOps organization, and then navigate to your project.

1. Select **Pipelines**, and then select **Library** from the left navigation pane.

    :::image type="content" source="../media/3-pipelines-library.png" alt-text="Screenshot of Azure Pipelines showing the Library menu option.":::

1. Select **Variable groups**, and then select **+ Variable group** to add a new variable group.

1. In the **Properties** section, enter *Release* for the variable group name.

1. Under the **Variables** section, select **Add**.

1. Enter *RegistryName* for the variable name, and for the value, enter the login server of your Azure Container Registry, such as *tailspinspacegame4692.azurecr.io*.

1. At the top of the page, select **Save** to save your pipeline variable. This is an example of what your variable group might look like

    :::image type="content" source="../media/3-library-variable-group.png" alt-text="Screenshot of Azure Pipeline showing the variable group. The group contains one variable.":::

## Create service connections

The next step is to create service connections that allow Azure Pipelines to access your Azure Container Registry and Azure Kubernetes Service instances. By creating these service connections, Azure Pipelines can push your containers and instruct your AKS cluster to pull them in to update the deployed service.

> [!IMPORTANT]
> Make sure that you are signed in to the Azure portal and Azure DevOps with the same Microsoft account.

### Create a Docker Registry service connection

1. Log in to your Azure DevOps organization, and then navigate to your project.

1. Select **Project settings** from the bottom corner of the page.

1. Select **Service connections** under the **Pipelines** section.

1. Select **New service connection**, then select **Docker Registry**, and then select **Next**.

1. Near the top of the page, select **Azure Container Registry**, and then select **Service Principal** for authentication type.

1. Enter the following values for each setting:

    | Setting                   | Value                                      |
    |---------------------------|--------------------------------------------|
    | Subscription              | Your Azure subscription                    |
    | Azure container registry  | *Select the one you created earlier*       |
    | Service connection name   | *Container Registry Connection*            |

1. Make sure that the checkbox for **Grant access permission to all pipelines** is selected.

1. Select **Save** when you're done.

### Create ARM service connection

Now you will create an Azure Resource Manager service connection to authenticate with your AKS cluster. We're using an ARM service connection instead of Kubernetes because long-lived tokens are no longer created by default since Kubernetes 1.24. Check out this DevOps blog post for more details: [Service Connection guidance for AKS customers using Kubernetes tasks](https://devblogs.microsoft.com/devops/service-connection-guidance-for-aks-customers-using-kubernetes-tasks/).

1. Select **New service connection**, select **Azure Resource Manager**, and then select **Next**.

1. Select **Service Principal (automatic)**, and then select **Next**.

1. Select **Subscription** for scope level.

1. Enter the following values for each setting.

    | Setting                 | Value                                      |
    |-------------------------|--------------------------------------------|
    | Subscription            | Your Azure subscription                    |
    | Resource group          | *Select the one you created earlier*       |
    | Service connection name | *Kubernetes Cluster Connection*            |

1. Make sure that the checkbox for **Grant access permission to all pipelines** is selected.

1. Select **Save** when you're done.

### Create a pipeline environment

1. Select **Pipelines**, and then select **Environments**.

    :::image type="content" source="../media/3-pipelines-environments.png" alt-text="Screenshot of Azure Pipelines showing the Environments menu option.":::

1. Select **Create environment** to create a new environment.
1. In the **Name** field, enter *Dev*.
1. Select **None** from the **Resource** section, and then select **Create** to create your pipeline environment.

## Update the Kubernetes deployment manifest

In this section you will be updating the Kubernetes manifest *deployment.yml* to point to the container registry you created earlier.

1. Navigate to your GitHub account and select the repository you forked for this module: "mslearn-tailspin-spacegame-web-kubernetes".

1. Open the *manifests/deployment.yml* file in edit mode.

    :::image type="content" source="../media/3-github-edit-mode.png" alt-text="Screenshot of GitHub showing the location of the edit mode icon.":::

1. Change the container image references to use your ACR login server. The following manifest uses *tailspinspacegame2439.azurecr.io* as an example.

    [!code-yml[](code/3-1-deployment.yml?highlight=17,37)]

1. Commit the changes to your `main` branch.
