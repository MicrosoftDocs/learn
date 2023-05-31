In this unit, you create an Azure Cache for Redis instance by using either the [Azure CLI](/cli/azure/install-azure-cli). You can do the same configuration by using the [Azure portal](https://portal.azure.com). The resource takes a few minutes to create, so run the following commands to let the resource deploy while you go on to learn more about Azure Cache for Redis.

## Set up the Azure CLI

Make sure you have the Azure CLI installed per the prerequisite.

1. In a command shell, run `az login` to sign in to your Azure subscription.
1. After you sign in, run `az account show` to see your signed-in Azure subscription. If you want to use a different subscription, run `az account set --subscription <subscription name or id you want>`.

## Create an Azure Cache for Redis instance

1. To standardize input and limit typing, set up three environment variables.

   - `AZ_RESOURCE_GROUP`: The name for a resource group to contain your Azure resources.
   - `AZ_LOCATION`: The name of the Azure region that you want to use. The default location is `eastus`, but you can choose a region closer to you for better performance. Use `az account list-locations` to list all available regions.
   - `AZ_REDIS_NAME`: A name for your Azure Cache for Redis instance. The name must be unique for all Azure Cache for Redis instances across Azure. Consider using your username as part of the name. The name must be 1 to 63 characters long and can contain only lowercase letters, numbers, and hyphens.

   Substitute your own values in the following example configuration:

   ```azcli
   AZ_RESOURCE_GROUP=myResourceGroup
   AZ_LOCATION=eastus
   AZ_REDIS_NAME=myUsernameRedis
   ```

1. With the variables set, run the following commands to create a resource group and Azure Cache for Redis instance:

   ```azcli
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

This command takes awhile to complete. You can continue to the next unit while it finishes.