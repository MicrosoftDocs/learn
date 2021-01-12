
An Azure Cache for Redis instance can be created either using [the Azure portal](https://portal.azure.com/?WT.mc_id=java-11981-judubois) or [the Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=java-11981-judubois). As this resource takes a few minutes to create, we'll first run those commands and let them run in the background, before we explain more about Azure Cache for Redis.

## Set up the Azure CLI

If it isn't already installed on your machine, install [the Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=java-11981-judubois). You can check the version of your current Azure CLI installation by running:

```bash
az --version
```

Ensure your Azure CLI is logged into your Azure subscription.

```bash
az login # Sign into an azure account
az account show # See the currently signed-in account.
```

Ensure your default subscription is the one you intend to use for this lab, and if not, set the subscription using:

```bash
az account set --subscription <SUBSCRIPTION_ID>
```

**Congratulations, the Azure CLI is now ready to create your first Azure Cache for Redis instance!**

## Create an Azure Cache for Redis instance

In this section, you'll create our Azure Cache for Redis instance using Azure CLI. It's possible to do exactly the same configuration using the Azure portal. For this configuration, you'll need to set up three environment variables:

- You need to create a resource group. To limit typing, set the variable `AZ_RESOURCE_GROUP` to the name of the resource group you want to create.
- You also need to set the variable `AZ_LOCATION` to the name of the Azure region you want to use. Default location is `eastus`, but you can choose a region closer to you for better performance (use `az account list-locations` to list all available regions).
- Lastly, you'll need to come up with a name for your Azure Cache for Redis instance in the `AZ_REDIS_NAME` variable.

__The Azure Cache for Redis name must be unique among all Azure Cache for Redis instances across all of Azure__. Consider using your username as part of the name. The name can contain only lowercase letters, numbers, and hyphens. It must be between 1 and 63 characters long.

> [!NOTE]
> Be sure to substitute your own values for `AZ_RESOURCE_GROUP`, `AZ_LOCATION`, and `AZ_REDIS_NAME` as described above.

```bash
AZ_RESOURCE_GROUP=<xxxxxxx>
AZ_LOCATION=eastus
AZ_REDIS_NAME=<xxxxxxx>
```

With these variables set, you can now create your resource group and your Azure Cache for Redis instance:

```bash
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

This command takes time to complete, you can continue to the next unit while it completes.
