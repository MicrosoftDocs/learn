An Azure Spring Cloud cluster can be created either using [the Azure portal](https://portal.azure.com/?WT.mc_id=azurespringcloud-mslearn-judubois) or [the Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=azurespringcloud-mslearn-judubois). In this first module, we will configure the necessary tools, and create our first cluster.

## Set up the Azure CLI

If it isn't already installed on your machine, install [the Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=azurespringcloud-mslearn-judubois). You can check the version of your current Azure CLI installation by running:

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

Install the `spring-cloud` extension for Azure CLI, by running:

```bash
az extension add -n spring-cloud -y
```

**Congratulations, the Azure CLI is now ready to create your first cluster!**

## Create an Azure Spring Cloud instance

In this section, we will create our Azure Spring Cloud instance using Azure CLI. It is possible to do exactly the same configuration using the Azure portal.

First, you will need to come up with a name for your Azure Spring Cloud instance.

- __The name must be unique among all Azure Spring Cloud instances across all of Azure__. Consider using your username as part of the name.
- The name can contain only lowercase letters, numbers and hyphens. The first character must be a letter. The last character must be a letter or number. The value must be between 4 and 32 characters long.

To limit typing, set the variable `RESOURCE_GROUP_NAME` to the name of the resource group created in the previous section. Set the variable `SPRING_CLOUD_NAME` to the name of the Azure Spring Cloud instance to be created:

> [!NOTE]
> Be sure to substitute your own values for `RESOURCE_GROUP_NAME` and `SPRING_CLOUD_NAME` as described above. __`SPRING_CLOUD_NAME` must be globally unique.__

```bash
RESOURCE_GROUP_NAME=spring-cloud-workshop
SPRING_CLOUD_NAME=azure-spring-cloud-workshop
```

With these variables set, you can now create your resource group. In the following script, the resource group is located in the `eastus` region (using the `-l eastus` argument), but you can choose a region closer to you for better performance (use `az account list-locations` to list all available regions):

```bash
az group create \
    -g "$RESOURCE_GROUP_NAME" \
    -l eastus
```

And then create the Azure Spring Cloud instance:

```bash
az spring-cloud create \
    -g "$RESOURCE_GROUP_NAME" \
    -n "$SPRING_CLOUD_NAME" \
    --sku standard \
    --enable-java-agent
```

This command takes time to complete, you can continue reading while it completes.

For the remainder of this workshop, we will be running Azure CLI commands referencing the same resource group and Azure Spring Cloud instance. So let's set them as defaults, so we don't have to specify them again:

```bash
az configure --defaults group=${RESOURCE_GROUP_NAME}
az configure --defaults spring-cloud=${SPRING_CLOUD_NAME}
```
