In this unit, you set up the GitHub repo and Azure resources you need to deploy your Java application. Some of the Azure resources take a few minutes to deploy. While you wait, you can read ahead to the next unit for background information about the services, tools, and platforms this module uses.

In this unit, you do the following tasks:

> [!div class="checklist"]
> - Fork the GitHub repo for this module.
> - Create the App Service instance and other Azure resources by using the Azure CLI in Azure Cloud Shell.

## Prerequisites

To complete this unit, you need the following prerequisites. For more information about the prerequisites, see the module [Introduction](/training/modules/deploy-java-containers/1-introduction?azure-portal=true).

- A GitHub account.
- Access to an Azure subscription with **Owner** role.

## Fork the GitHub repo

The GitHub repository for this project contains a basic Java web app that you build and deploy as a Docker container. To fork the repo:

1. Go to the [Java Containers repo](https://github.com/MicrosoftDocs/mslearn-java-containers?azure-portal=true).
1. Select **Fork**, select your GitHub account to fork into, and then select **Create fork**.

## Create the Azure App Service environment

You use the Azure CLI to create the App Service instance that hosts the containerized Java app. You also create the Azure Container Registry instance and Azure Database for MySQL server that the app uses.

You can run Azure CLI commands from a terminal or through Visual Studio Code. In this module, you use the browser-based Azure Cloud Shell in the Azure portal.

### Open Cloud Shell in the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true) and select the **Cloud Shell** icon in the top menu bar.

   :::image type="content" source="../../shared/media/azure-portal-menu-cloud-shell.png" alt-text="A screenshot of the Azure portal showing the location of the Cloud Shell menu item.":::

1. When the Cloud Shell interface appears, select **Bash** for the interface.

1. Cloud Shell requires an Azure storage resource to persist any files that you create in Cloud Shell. When prompted, create the storage account to use for Cloud Shell. You only need to create the Cloud Shell storage the first time you use Cloud Shell. All your future Cloud Shell sessions automatically use this storage account.

Azure CLI in the Cloud Shell is configured to use your Azure subscription. If you have more than one subscription, you can use the Azure CLI command `az account show` to see which subscription you're signed in to, and `az account set` to change the signed-in subscription.

### Select an Azure region

An Azure _region_ is a geographic location that contains one or more Azure datacenters, for example East US, West US, or Brazil Southeast. Every Azure resource is assigned a region. To make commands easier to enter, you can specify a default region for all your resources. All commands use that region unless you specify a different one.

1. From Cloud Shell, run `az account list-locations` to list the regions available in your Azure subscription.

   ```azurecli
   az account list-locations \
     --query "[].{Name: name, DisplayName: displayName}" \
     --output table
   ```

1. From the `Name` column in the output, choose a region that's close to you, for example `eastasia` or `westus2`, and run `az configure` to set your default region. Replace `westus2` in the following example with the region name you choose.

   ```azurecli
   az configure --defaults location=westus2
   ```

### Create Bash variables

To make the setup process more convenient and less prone to errors and typos, create Bash variables for shared text strings.

1. From Cloud Shell, generate a random number, which makes it easier to create globally unique names for certain services.

   ```bash
   resourceSuffix=$RANDOM
   ```

1. Create globally unique names that use the random number for your App Service Web App, Container Registry, and Azure Database for MySQL server. The double quotes in these commands instruct Bash to interpolate the variables by using the inline syntax.

   ```bash
   webName="java-container-cicd-${resourceSuffix}"
   registryName="javacontainercicd${resourceSuffix}"
   dbServerName="java-container-cicd-${resourceSuffix}"
   ```

1. Also create the following two Bash variables to store the names of your resource group and service plan.

   ```bash
   rgName='java-containers-cicd-rg'
   planName='java-container-cicd-asp'
   ```

### Create the Azure resources

Now create the Azure resources for deploying this solution.

> [!NOTE]
> For learning purposes, you use the default network settings, which make your site accessible from the internet. In actual practice, you could configure an Azure virtual network that places your website in a network that's not internet routable and that only you and your team can access. Later, you could reconfigure your network to make the website available to your users.

1. Run the following `az group create` command to create a resource group with the name you defined earlier.

   ```azurecli
   az group create --name $rgName
   ```

1. Run the following `az mysql server create` command to create an Azure Database for MySQL server that uses the name you defined earlier. You can change the administrator user name and password shown here, but be sure to note them for later reference.

   ```azurecli
   az mysql server create \
     --name $dbServerName \
     --resource-group $rgName \
     --admin-user sysadmin \
     --admin-password P@ssw0rd \
     --sku-name GP_Gen5_2 \
     --version 5.7
   ```

   The deployment can take several minutes to complete. While you wait, you can read the next unit about the resources and services in this module.

1. By default, all incoming connections to the MySQL server are blocked, so you have to add at least one rule for the server to be accessible. Run the following `mysql server firewall-rule create` command to create a firewall rule that allows Azure services to access the MySQL server.

   ```azurecli
   az mysql server firewall-rule create \
     --name AllowAzureServices \
     --resource-group $rgName \
     --server-name $dbServerName \
     --start-ip-address 0.0.0.0 \
     --end-ip-address 0.0.0.0
   ```

1. Run the following `az acr create` command to create a Container Registry instance that uses the name you defined earlier.

   ```azurecli
   az acr create \
     --name $registryName \
     --resource-group $rgName \
     --sku Standard \
     --admin-enabled true
   ```

1. Run the following `az appservice plan create` command to create an App Service plan that uses the name you defined earlier. The `--is-linux` argument specifies to use Linux worker nodes.

   ```azurecli
   az appservice plan create \
     --name $planName \
     --resource-group $rgName \
     --sku B1 \
     --is-linux
   ```

   > [!IMPORTANT]
   > The `--sku` argument specifies the `B1` plan that runs on the Basic tier. If the B1 SKU isn't available in your Azure subscription, [choose a different plan](https://azure.microsoft.com/pricing/details/app-service/linux/?azure-portal=true), such as S1 (Standard).

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

   In the output, note the host name for the running service, similar to the following example. You use the name later to verify the deployment.

   ```output
   HostName                                        State
   ----------------------------------------------  -------
   java-container-cicd-18116.azurewebsites.net     Running
   ```

1. Run the following `az acr list` command to list the login server of the Container Registry instance.

   ```azurecli
   az acr list \
     --resource-group $rgName \
     --query "[].{loginServer: loginServer}" \
     --output table
   ```

   In the output, note the login server, similar to the following example. You need this server name later to create pipeline variables.

   ```output
   LoginServer
   ---------------------------------
   javacontainercicd18116.azurecr.io    
   ```

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/deploy-java-containers/5-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps to remove the resources you created in this unit. Cleaning up the Azure resources ensures that you're not charged for the resources after you finish this module. If you created the resources in this unit, be sure to do the cleanup steps even if you don't complete the rest of the module.
