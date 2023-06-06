In this unit, you create an Azure Cache for Redis instance by using the [Azure CLI](/cli/azure/install-azure-cli). You can use the [Azure portal](https://portal.azure.com) to do the same configuration. The Azure Cache for Redis instance takes a while to create, so you can run the following commands and let the deployment proceed while you learn more about Azure Cache for Redis.

## Set up the Azure CLI

Make sure you have the Azure CLI installed. You can check your Azure CLI version by running `az --version`.

1. In a Bash shell, run `az login` to sign in to your Azure subscription.
1. After you sign in, run `az account show` to see the subscription you're signed in to. If you want to use a different subscription, run `az account set --subscription <preferred subscription>`.

## Create an Azure Cache for Redis instance

1. To standardize input and limit typing, set up three environment variables.

   - `AZ_RESOURCE_GROUP`: The name for a resource group to contain your Azure resources.
   - `AZ_LOCATION`: The name of the Azure region that you want to use. The default location is `eastus`, but you can choose a region closer to you for better performance. Use `az account list-locations` to list all available regions.
   - `AZ_REDIS_NAME`: A name for your Azure Cache for Redis instance. The name must be unique across all Azure Cache for Redis instances. Consider using your username as part of the name. The name must be 1 to 63 characters long and can contain only lowercase letters, numbers, and hyphens.

   Substitute your own values for the following example values:

   ```azurecli
   AZ_RESOURCE_GROUP=myResourceGroup
   AZ_LOCATION=eastus
   AZ_REDIS_NAME=myUsernameRedis
   ```

1. After you set the variables, run the following commands to create an Azure resource group and Azure Cache for Redis instance:

   ```azurecli
   az group create \
       --name $AZ_RESOURCE_GROUP \
       --location $AZ_LOCATION
   
   az redis create \
       --resource-group $AZ_RESOURCE_GROUP \
       --name $AZ_REDIS_NAME \
       --location $AZ_LOCATION \
       --sku Basic \
       --vm-size c0
   ```

This command takes a while to complete. Continue to the next unit to learn more about Azure Cache for Redis while the deployment finishes.