You're now ready to create a new Event Hub. After creating the Event Hub, you'll use the Azure portal to view your new hub.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Set some defaults in the Azure CLI

1. Sign into the [Azure portal](https://portal.azure.com/?azure-portal=true) with your Azure subscription.

1. Click on the Cloud Shell button to open it. When prompted, choose the Bash command-line option.

    ![Screenshot showing Cloud Shell access button](../media/3-portal-cloudshell-access.png)

1. Create a new resource group with the name **learn-big-data-messaging-rg** so that it will be easier to clean up these resources when you are finished with the module. If you choose a different resource group name, remember it for the rest of the exercises in this module.

    ```azurecli
    az group create --name learn-big-data-messaging-rg --location westus2
    ```

1. You can also set default values for the Azure CLI in the Cloud Shell. This will keep you from having to type these in every time. In particular, let's set the _resource group_ and _location_. Type the following command into the Azure CLI, make sure to replace the location with one close to you.

    ```azurecli
    az configure --defaults group=learn-big-data-messaging-rg location=westus2
    ```

## Create an Event Hubs namespace

Use the following steps to create an Event Hubs namespace using bash shell supported by Azure Cloud shell:

1. Create the Event Hubs namespace using the `az eventhubs namespace create` command. Use the following parameters.

    > [!div class="mx-tableFixed"]
    > |Parameter      |Description|
    > |---------------|-----------|
    > |--name (required)      |Enter a 6-50 characters-long unique name for your Event Hubs namespace. The name should contain only letters, numbers, and hyphens. It should start with a letter and end with a letter or number.|
    > |--resource-group (required) | This will be the **learn-big-data-messaging-rg** resource group supplied from the defaults. |
    > |--l (optional)     |Enter the location of your nearest Azure datacenter, this will use your default.|
    > |--sku (optional) | The pricing tier for the namespace [Basic | Standard], defaults to _Standard_. This determines the connections and consumer thresholds. |

    Set the name into an environment variable so we can reuse it.

    ```azurecli
    NS_NAME=[name]
    ````

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    ```azurecli
    az eventhubs namespace create --name $NS_NAME
    ```

    > [!NOTE]
    > Azure is very picky about the name and the CLI returns **Bad Request** if the name exists or is invalid. Try a different name by changing your environment variable and reissuing the command.


1. Fetch the connection string for your Event Hubs namespace using the following command. You'll need this to configure applications to send and receive messages using your Event Hub.

    ```azurecli
    az eventhubs namespace authorization-rule keys list --name RootManageSharedAccessKey --namespace-name $NS_NAME
    ```

    > [!div class="mx-tableFixed"]
    > |Parameter      |Description|
    > |---------------|-----------|
    > |--resource-group (required)  | This will be the **learn-big-data-messaging-rg** resource group configured from the defaults. |
    > |--namespace-name (required)  | Enter the name of the namespace you created. |

    This command returns a JSON block with the connection string for your Event Hubs namespace that you'll use later to configure your publisher and consumer applications. Save the value of the following keys for later use.

    - **primaryConnectionString**
    - **primaryKey**

## Create an Event Hub

Use the following steps to create your new Event Hub:

1. Create a new Event Hub using the `eventhub create` command. It needs the following parameters:

    > [!div class="mx-tableFixed"]
    > |Parameter      |Description|
    > |---------------|-----------|
    > |--name (required)  |Enter a name for your Event Hub.|
    > |--resource-group (required)  |Resource group owner.|
    > |--namespace-name (required)      |Enter the namespace you created.|

    Let's define the Event Hub name in an environment variable first.

    ```azurecli
    HUB_NAME=[name]
    ```

    ```azurecli
    az eventhubs eventhub create --name $HUB_NAME --namespace-name $NS_NAME
    ```

1. View the details of your Event Hub using the `eventhub show` command. It takes:

    > [!div class="mx-tableFixed"]
    > |Parameter      |Description|
    > |---------------|-----------|
    > |--resource-group (required)  |Resource group owner.|
    > |--namespace-name (required)      |Enter the namespace you created.|
    > |--name  (required)|Name of the Event Hub.|

    ```azurecli
    az eventhubs eventhub show --namespace-name $NS_NAME --name $HUB_NAME
    ```

## View the Event Hub in the Azure portal

Next, let's see what this looks like in the Azure portal.

1. Find your Event Hubs namespace using the Search bar at the top of portal.

1. Select your namespace to open it.

1. Select **Event Hubs namespace** under the **ENTITIES** section.

1. Click **Event Hubs**.

    Your Event Hub displays with a status of **Active**, and default values for **Message Retention** (*7*) and **Partition Count** of (*4*).

    ![Event Hub displayed in the Azure Portal](../media/3-event-hub.png)

## Summary

You've now created a new Event Hub, and you've all the necessary information ready to configure your publisher and consumer applications.
