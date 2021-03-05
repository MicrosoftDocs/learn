In this unit, you'll learn how to create your Azure Service Bus Premium namespace.

## Introduction to Azure Service Bus

Azure Service Bus is a fully managed enterprise message broker with message queues and publish-subscribe topics. Service Bus is used to decouple applications and services from each other, providing the following benefits:

   * Load-balancing work across competing workers
   * Safely routing and transferring data and control across service and application boundaries
   * Coordinating transactional work that requires a high-degree of reliability

## Messaging scenarios

Some common messaging scenarios are:

   * *Messaging* Transfer business data, such as sales or purchase orders, journals, or inventory movements.
   * *Decouple applications*. Improve reliability and scalability of applications and services. Producer and consumer don't have to be online or readily available at the same time. The load is leveled such that traffic spikes don't overtax a service.
   * *Load Balancing*. Allow for multiple competing consumers to read from a queue at the same time, each safely obtaining exclusive ownership to specific messages.
   * *Topics and subscriptions*. Enable 1:n relationships between publishers and subscribers, allowing subscribers to select particular messages from a published message stream.
   * *Transactions*. Allows you to do several operations, all in the scope of an atomic transaction.
   * *Message sessions*. Implement high-scale coordination of workflows and multiplexed transfers that require strict message ordering or message deferral.

If you're familiar with other message brokers like **Apache ActiveMQ**,**Rabbit MQ**, **TIBCO EMS**, and **IBM MQ**, Service Bus concepts are similar to what you know.


## Create your Azure Service Bus Premium namespace using the Azure CLI

You can use the Azure CLI to create and manage Azure resources. The CLI allows administrators and developers to run commands using a terminal or command-line promt (or script) instead of a web browser.

To utilize the Azure CLI to create an Azure Service Bus Premium namespace use the below commands:

### Set up the Azure CLI

You will need the Azure CLI to create your service bus premium namespace. You can check the version of your current Azure CLI installation by running:

```bash
az --version
```

Ensure that the Azure CLI installation is signed into your Azure subscription.

```bash
az login
az account show --output table
```

Ensure that your default subscription is the one you want to use for this lab. If not, set the subscription by using:

```bash
az account set --subscription SUBSCRIPTION_ID
```

Congratulations, the Azure CLI is now ready to create your first Azure Service Bus Premium namespace.

### Create a resource group

For the purpose of this course, we will proceed to place the Azure Service Bus namespace under the resource group `MSLearn_JMS_ServiceBus_Course` in the East US region.

```bash
az group create --name MSLearn_JMS_ServiceBus_Course --location eastus
```

### Create an Azure Service Bus namespace

In this section, you'll create an Azure Service Bus namespace by using the Azure CLI. It's possible to do exactly the same configuration by using the Azure portal. For this configuration, you will need to setup the three environment variables.

   * Create a resource group. To limit typing, set the variable `AZ_RESOURCE_GROUP` to the name of the resource group that you want to create.
   * Set the variable `AZ_LOCATION` to the name of the Azure region that you want to use. The default location is eastus, but you can choose a region closer to you for better performance. (Use az account list-locations to list all available regions.)
   * Choose a name for your Azure Service Bus Premium namespace in the `AZ_SB_PREMIUM_NAMESPACE` variable.

> [!NOTE]
> Be sure to substitute your own values for `AZ_RESOURCE_GROUP`, `AZ_LOCATION`, and `AZ_SB_PREMIUM_NAMESPACE` in the following example configuration.
>

```bash
AZ_RESOURCE_GROUP=<xxxxxxx>
AZ_LOCATION=eastus
AZ_SB_PREMIUM_NAMESPACE=<xxxxxxx>
```

With these variables set, you can now create your Azure Service Bus Premium namespace.

```bash
az group create \
    --name $AZ_RESOURCE_GROUP \
    --location $AZ_LOCATION

az servicebus namespace create \
    --resource-group $AZ_RESOURCE_GROUP \
    --namespace-name $AZ_SB_PREMIUM_NAMESPACE \
    --sku Premium \
    --capacity 1
```

This command takes a few minutes to finish. You can continue to the next unit while it finishes.

> [!IMPORTANT]
> There is a nominal fee to use the Azure Service Bus Premium namespace - please review [Service Bus Pricing](https://azure.microsoft.com/pricing/details/service-bus/) for more details.
>
> Please be sure to delete the namespace and the resource group you created in the above steps to avoid being billed for the resources, by using the steps mentioned in the Summary unit at the end of this module.
>
