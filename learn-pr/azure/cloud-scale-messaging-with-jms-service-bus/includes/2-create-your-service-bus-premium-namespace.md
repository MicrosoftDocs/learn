In this unit, you learn how to create your Azure Service Bus Premium namespace.

## Introduction to Azure Service Bus

Azure Service Bus is a fully managed enterprise message broker with message queues and publish-subscribe topics. Service Bus is used to decouple applications and services from each other, and it provides the following benefits:

* Load balances work across competing workers
* Safely routes and transfers data and controls across service and application boundaries
* Coordinates transactional work that requires a high degree of reliability

## Messaging scenarios

Some common messaging scenarios are:

* **Messaging**: Transfer business data, such as sales or purchase orders, journals, or inventory movements.
* **Decouple applications**: Improve reliability and scalability of applications and services. Producer and consumer don't have to be online or readily available at the same time. The load is leveled such that traffic spikes don't overtax a service.
* **Load balancing**: Allow for multiple competing consumers to read from a queue at the same time, each safely obtaining exclusive ownership to specific messages.
* **Topics and subscriptions**: Enable 1:n relationships between publishers and subscribers, which allows subscribers to select particular messages from a published message stream.
* **Transactions**: Do several operations, all in the scope of an atomic transaction.
* **Message sessions**: Implement high-scale coordination of workflows and multiplexed transfers that require strict message ordering or message deferral.

If you're familiar with other message brokers like Apache ActiveMQ, Rabbit MQ, TIBCO EMS, and IBM MQ, then Service Bus concepts are similar to what you know.

## Create a Service Bus namespace

Start by creating the namespace. In Azure Service Bus, a namespace is a container for queues and topics. Each namespace has a unique, fully qualified domain name, with primary and secondary shared access signature (SAS) encryption keys. A sending or receiving component must provide an SAS key to gain access to objects in a namespace.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same credentials that you used to activate the sandbox. Open the link in a new tab or a new window, and keep it side-by-side with the Learn module content. 

1. Under **Azure services**, select **Create a resource**.

1. In the **Create a resource** pane, enter **Service Bus** in global search. In the search results, select **Service Bus** published by Microsoft for Azure, and then select **Create**.

1. In the **Create namespace** pane, on the **Basics** tab, enter or select the following values for each setting:

    | Setting | Value | Description |
    | ------- | --- | ---- |
    | **Project Details** |
    | Subscription | Concierge subscription | The subscription used for the exercises in this module. |
    | Resource group | <rgn>[Sandbox resource group name]</rgn> | The name of the resource group in which to create your Service Bus namespace. In this exercise, you create the namespace in the resource group that was assigned when you activated the sandbox. |
    | **Instance Details** |
    | Namespace name | [Globally unique name] | Enter a name that is unique in Azure.<br />If you want to use the format _salesteamapp_<_Company_><_year_>, your namespace name would look like the example _salesteamappContoso2022_. |
    | Location | Select from the dropdown | Choose from the free *sandbox regions* listed after this table. |
    | Pricing tier | **Premium** | Support for Java Message Service (JMS) 2.0 API is only available with the Premium tier. |

    [!INCLUDE[Sandbox regions](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Review + create**.

1. When validation succeeds, select **Create** to create your Service Bus namespace.
1. When deployment is finished, select **Go to resource**.

## Create a Service Bus queue

Next, add a queue for messages about individual sales to your namespace:

1. On the **Service Bus Namespace** page, select **Queues** under **Entities** on the left menu. 
1. Select **+ Queue** on the command bar.  
1. In the **Create queue** pane, for **Name**, enter **test-queue-jms**, and then select **Create**.  
  
When the message queue has been created, **test-queue-jms** is listed under **Queues** at the bottom of the Service Bus namespace pane.

## Get connection string to the namespace

You use the connection string for this namespace later in this training, to connect to the Service Bus namespace from a JMS app.

1. On the **Service Bus Namespace** page, select **Shared access policies** under **Settings** on the left menu.
1. Select **RootManageSharedAccessKey** on the **Shared access policies** page. 
1. On the **SAS Policy** page, select the **Copy** button next to **Primary connection string** field.
1. Copy it and save it so that you can use it later in the training.
