Here you create the App Service environment for deployment. An App Service Environment is a single-tenant deployment of Azure App Service that runs on your virtual network. Applications are hosted in App Service plans, which are created in an App Service Environment.

In this module, you use the Azure CLI to add the resources needed to deploy and run an App Service instance. You can access the Azure CLI from a terminal or through Visual Studio Code.

Here you access the Azure CLI from Azure Cloud Shell. This browser-based shell experience is hosted in the cloud. In Cloud Shell, the Azure CLI is configured for use with your Azure subscription.

> [!IMPORTANT]
> You need your own Azure subscription to complete the exercises in this module.

### Bring up Cloud Shell through the Azure portal

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. From the menu, select **Cloud Shell**. When prompted, select the **Bash** experience.

   :::image type="content" source="../../shared/media/azure-portal-menu-cloud-shell.png" alt-text="A screenshot of the Azure portal showing the location of the Cloud Shell menu item.":::

   > [!NOTE]
   > Cloud Shell requires an Azure storage resource to persist any files that you create in Cloud Shell. When you first open Cloud Shell, you're prompted to create a resource group, storage account, and Azure Files share. This setup is automatically used for all future Cloud Shell sessions.

### Select an Azure region

A *region* is one or more Azure data centers within a geographic location. East US, West US, and North Europe are examples of regions. Every Azure resource, including an App Service instance, is assigned a region.

To make commands easier to run, start by selecting a default region. After you specify the default region, later commands use that region unless you specify a different region.

1. From Cloud Shell, run the following [az account list-locations](/cli/azure/account#az-account-list-locations) command to list the regions that are available from your Azure subscription.

   ```azurecli
   az account list-locations \
     --query "[].{Name: name, DisplayName: displayName}" \
     --output table
   ```

1. From the `Name` column in the output, choose a region that's close to you. For example, choose `eastasia` or `westus2`.

1. Run [az configure](/cli/azure/reference-index#az-configure) to set your default region. Replace `<REGION>` with the name of the region you chose.

   ```azurecli
   az configure --defaults location=<REGION>
   ```

   This example sets `westus2` as the default region:

   ```azurecli
   az configure --defaults location=westus2
   ```

### Create Bash variables

Create Bash variables to make the setup process more convenient and less error-prone. Using variables for shared text strings helps avoid accidental typos.

1. From Cloud Shell, generate a random number. Using a random number makes it easier to create globally unique names for certain services in the next step.

   ```bash
   resourceSuffix=$RANDOM
   ```

1. Create a globally unique name for your App Service Web App. This command uses double quotes. Bash interprets the variables using the inline syntax.

   ```bash
   webName="helloworld-nodejs-${resourceSuffix}"
   ```

1. Create two more Bash variables to store the names of your resource group and App Service plan.

   ```bash
   rgName='hello-world-nodejs-rg'
   planName='helloworld-nodejs-plan'
   ```

### Create the Azure resources

This solution requires several Azure resources for deployment, which you create now.

> [!NOTE]
> For learning purposes, here you use the default network settings. These settings make your site accessible from the internet. In practice, you could configure an Azure virtual network that places your website in a network that's not internet routable and that only you and your team can access. Later, you could reconfigure your network to make the website available to your users.

1. Run the following [az group create](/cli/azure/group#az-group-create) command to create a resource group using the name defined earlier.

   ```azurecli
   az group create --name $rgName
   ```

1. Run the following [az appservice plan create](/cli/azure/appservice/plan#az-appservice-plan-create) command to create an App Service plan using the name defined earlier.

   ```azurecli
   az appservice plan create \
     --name $planName \
     --resource-group $rgName \
     --sku B1 \
     --is-linux
   ```

   The `--sku` argument specifies the B1 plan. This plan runs on the Basic tier. The `--is-linux` argument specifies to use Linux workers.

   > [!IMPORTANT]
   > If the B1 SKU isn't available in your Azure subscription, [choose a different plan](https://azure.microsoft.com/pricing/details/app-service/linux/?azure-portal=true), such as S1 (Standard).

1. Run the following [az webapp create](/cli/azure/webapp#az-webapp-create) command to create the App Service instance.

   ```azurecli
   az webapp create \
     --name $webName \
     --resource-group $rgName \
     --plan $planName \
     --runtime "node|16-lts"
   ```

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/deploy-nodejs/6-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you're not charged for Azure resources after you complete this module. Be sure to perform the cleanup steps even if you don't complete this module.

## Check your work

1. Run the following [az webapp list](/cli/azure/webapp#az-webapp-list) command to list the host name and state of the App Service instance.

   ```azurecli
   az webapp list \
     --resource-group $rgName \
     --query "[].{hostName: defaultHostName, state: state}" \
     --output table
   ```

   Note the host name for your running service. You need the web host name later when you verify your work. Here's an example:

   ```output
   HostName                                   State
   -----------------------------------------  -------
   helloworld-nodejs-16353.azurewebsites.net  Running
   ```

1. Navigate your browser to the hostname. Verify that it's running and that the default home page appears.

   Here's what you should see:

   :::image type="content" source="../media/4-app-service-default.png" alt-text="Screenshot shows the default home page on Azure App Service.":::
