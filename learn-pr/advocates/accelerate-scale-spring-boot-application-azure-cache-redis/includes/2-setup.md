
You can create an Azure Cache for Redis instance by using either [the Azure portal](https://portal.azure.com/?WT.mc_id=java-11981-judubois) or [the Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=java-11981-judubois). Because this resource takes a few minutes to create, we'll run those commands (and let them continue running in the background) before we explain more about Azure Cache for Redis.

## Set up the Azure CLI

If the Azure CLI isn't already installed on your machine, [install it now](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=java-11981-judubois). You can check the version of your current Azure CLI installation by running:

```bash
az --version
```

Ensure that your Azure CLI installation is signed in to your Azure subscription.

```bash
az login # Sign in to an Azure account.
az account show # See the currently signed-in account.
```

Ensure that your default subscription is the one you want to use for this lab. If not, set the subscription by using:

```bash
az account set --subscription <SUBSCRIPTION_ID>
```

Congratulations, the Azure CLI is now ready to create your first Azure Cache for Redis instance!

## Create an Azure Cache for Redis instance

In this section, you'll create an Azure Cache for Redis instance by using the Azure CLI. It's possible to do exactly the same configuration by using the Azure portal. For this configuration, you'll need to set up three environment variables:

- Create a resource group. To limit typing, set the variable `AZ_RESOURCE_GROUP` to the name of the resource group that you want to create.
- Set the variable `AZ_LOCATION` to the name of the Azure region that you want to use. The default location is `eastus`, but you can choose a region closer to you for better performance. (Use `az account list-locations` to list all available regions.)
- Choose a name for your Azure Cache for Redis instance in the `AZ_REDIS_NAME` variable.

The Azure Cache for Redis name must be unique among all Azure Cache for Redis instances across all of Azure. Consider using your username as part of the name. The name can contain only lowercase letters, numbers, and hyphens. It must be 1 to 63 characters long.

> [!NOTE]
> Be sure to substitute your own values for `AZ_RESOURCE_GROUP`, `AZ_LOCATION`, and `AZ_REDIS_NAME` in the following example configuration.

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

This command takes time to finish. You can continue to the next unit while it finishes.
