In this section, you make sure that your Azure DevOps organization is set up to complete the rest of this module. You also create the Azure App Service environments that you'll deploy to.

To accomplish these goals, you:

> [!div class="checklist"]
> * Add a user to ensure Azure DevOps can connect to your Azure subscription.
> * Fork the GitHub repo for this module.
> * Create the Azure App Service using the Azure CLI in Azure Cloud Shell.

## Add a user to Azure DevOps

To complete this module, you need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true). You can get started with Azure for free.

You don't need an Azure subscription to work with Azure DevOps, but here you'll use Azure DevOps to deploy to Azure resources that exist in your Azure subscription. To simplify the process, use the same Microsoft account to sign in to both your Azure subscription and your Azure DevOps organization.

If you use different Microsoft accounts to sign in to Azure and Azure DevOps, add a user to your DevOps organization under the Microsoft account that you use to sign in to Azure. For more information, see [Add users to your organization or project](https://docs.microsoft.com/azure/devops/organizations/accounts/add-organization-users?tabs=browser&azure-portal=true). When you add the user, choose the **Basic** access level.

Then sign out of Azure DevOps and sign in. Use the Microsoft account that you use to sign in to your Azure subscription.

## Fork the GitHub repo

Here you fork the GitHub repo required for this project. It's a basic Java web app designed to be built and deployed as a Docker container.

1. Go to the [Java Containers repo](https://github.com/MicrosoftDocs/mslearn-java-containers?azure-portal=true).
1. Select **Fork** and select an account to fork into.

## Create the Azure App Service environment

Here you create the App Service resources required to deploy the Java container app.

In this module, you use the Azure CLI to spin up the Azure App Service that will host the Java container app, which includes an Azure Container Registry and an Azure Database for MySQL instance. You can access the Azure CLI from a terminal or through Visual Studio Code. Here you access the Azure CLI from Azure Cloud Shell. This browser-based shell experience is hosted in the cloud. In Cloud Shell, the Azure CLI is configured for use with your Azure subscription.

> [!IMPORTANT]
> You need your own Azure subscription to complete the exercises in this module.

### Bring up Cloud Shell through the Azure portal

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. From the menu, select **Cloud Shell**. When prompted, select the **Bash** experience.

    ![Selecting Cloud Shell from the menu bar](../../shared/media/azure-portal-menu-cloud-shell.png)

    > [!NOTE]
    > Cloud Shell requires an Azure storage resource to persist any files that you create in Cloud Shell. When you first open Cloud Shell, you're prompted to create a resource group, storage account, and Azure Files share. This setup is automatically used for all future Cloud Shell sessions.

### Select an Azure region

A _region_ is one or more Azure datacenters within a geographic location. East US, West US, and North Europe are examples of regions. Every Azure resource, including an App Service instance, is assigned a region.

To make commands easier to run, start by selecting a default region. After you specify the default region, later commands use that region unless you specify a different region.

1. From Cloud Shell, run the following `az account list-locations` command to list the regions that are available from your Azure subscription.

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

Here, create Bash variables to make the setup process more convenient and less error-prone. Using variables for shared text strings helps avoid accidental typos.

1. From Cloud Shell, generate a random number. This will make it easier to create globally unique names for certain services in the next step.

    ```bash
    resourceSuffix=$RANDOM
    ```

1. Create globally unique names for your App Service Web App, Azure Container Registry, and Azure Database for MySQL server. Note that these commands use double quotes, which instructs Bash to interpolate the variables using the inline syntax.

    ```bash
    webName="java-container-cicd-${resourceSuffix}"
    registryName="javacontainercicd${resourceSuffix}"
    dbServerName="java-container-cicd-${resourceSuffix}"
    ```

1. Create two more Bash variables to store the names of your resource group and service plan.

    ```bash
    rgName='java-containers-cicd-rg'
    planName='java-container-cicd-asp'
    ```

### Create the Azure resources

This solution requires several Azure resources for deployment, which you create now.

   > [!NOTE]
   > For learning purposes, here you use the default network settings. These settings make your site accessible from the internet. In practice, you could configure an Azure virtual network that places your website in a network that's not internet routable and that only you and your team can access. Later, you could reconfigure your network to make the website available to your users.

1. Run the following `az group create` command to create a resource group using the name defined earlier.

    ```azurecli
    az group create --name $rgName
    ```

1. Run the following `az mysql server create` command to create an Azure Database for MySQL server using the name defined earlier. You can change the administrator username and password shown here; just remember them for later reference.

    ```azurecli
    az mysql server create \
      --name $dbServerName \
      --resource-group $rgName \
      --admin-user sysadmin \
      --admin-password P@ssw0rd \
      --sku-name GP_Gen5_2 \
      --version 5.7
    ```

    The deployment can take several minutes to complete.

1. By default, all incoming connections to the MySQL server are blocked, so it is necessary to add at least one rule for it to be accessible. Run the following `az mysql server firewall-rule create` command to create a firewall rule to allow services hosted in Azure (like the one you are deploying) to access the server.

    ```azurecli
    az mysql server firewall-rule create \
      --name AllowAzureServices \
      --resource-group $rgName \
      --server $dbServerName \
      --start-ip-address 0.0.0.0 \
      --end-ip-address 0.0.0.0
    ```

1. Run the following `az acr create` command to create an Azure Container Registry by using the name defined earlier.

    ```azurecli
    az acr create \
      --name $registryName \
      --resource-group $rgName \
      --sku Standard \
      --admin-enabled true
    ```

1. Run the following `az appservice plan create` command to create an App Service plan using the name defined earlier.

    ```azurecli
    az appservice plan create \
      --name $planName \
      --resource-group $rgName \
      --sku B1 \
      --is-linux
    ```

    The `--sku` argument specifies the B1 plan. This plan runs on the Basic tier.

    > [!IMPORTANT]
    > If the B1 SKU isn't available in your Azure subscription, [choose a different plan](https://azure.microsoft.com/pricing/details/app-service/linux/?azure-portal=true), such as S1 (Standard).

1. Run the following `az webapp create` command to create the App Service instance.

    ```azurecli
    az webapp create \
      --name $webName \
      --resource-group $rgName \
      --plan $planName \
      --deployment-container-image-name $registryName.azurecr.io/web:latest
    ```

1. Run the following `az webapp list` command to show the host name and state of the App Service instance.

    ```azurecli
    az webapp list \
      --resource-group $rgName \
      --query "[].{hostName: defaultHostName, state: state}" \
      --output table
    ```

    Note the host name for the running service. You'll need it later when you verify your work. Here's an example:

    ```output
    HostName                                        State
    ----------------------------------------------  -------
    java-container-cicd-18116.azurewebsites.net     Running
    ```

1. Run the following `az acr list` command to list the login server of the Azure Container Registry instance. You will need this server name when creating pipeline variables later.

    ```azurecli
    az acr list \
      --resource-group $rgName \
      --query "[].{loginServer: loginServer}" \
      --output table
    ```

    Note the login server. You'll need it later when you configure the pipeline. Here's an example:

    ```output
    LoginServer
    ---------------------------------
    javacontainercicd18116.azurecr.io    
    ```

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/learn/modules/deploy-java-containers/5-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you're not charged for Azure resources after you complete this module. Be sure to perform the cleanup steps even if you don't complete this module.
