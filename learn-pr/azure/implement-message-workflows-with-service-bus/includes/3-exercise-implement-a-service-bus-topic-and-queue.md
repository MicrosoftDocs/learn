You have an application for the sales team in your global company. Each team member has your app installed on a mobile device to use for sales. An Azure web service hosts the business logic implemented for your application and stores information in Azure SQL Database. Each geographical region has its own instance of the web service.

You've identified the following scenarios for message exchange between the mobile app and the web service:

- Messages that relate to individual sales must be sent to the web service instance in the user's region.
- Messages that relate to sales performance must be sent to all instances of the web service.

You've decided to implement a Service Bus queue for the first use case and a Service Bus topic for the second use case.

In this exercise, you'll create a Service Bus namespace that contains a queue, a topic, and subscriptions in the Azure portal.

## Create a Service Bus namespace

Start by creating the namespace. In Azure Service Bus, a namespace is a container for queues and topics. Each namespace has a unique, fully qualified domain name, with primary and secondary shared access signature (SAS) encryption keys. A sending or receiving component must provide an SAS key to gain access to objects in a namespace.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same credentials that you used to activate the sandbox.

1. Under **Azure services**, select **Create a resource**.

1. In the **Create a resource** pane, enter **Service Bus** in global search. In the search results, in **Service Bus** published by Microsoft for Azure, select **Create**.

1. In the **Create namespace** pane, on the **Basics** tab, enter or select the following values for each setting:

    | Setting | Value | Description |
    | ------- | --- | ---- |
    | **Project Details** |
    | Subscription | Concierge subscription | The subscription in which this new app is created. |
    | Resource group | <rgn>[Sandbox resource group name]</rgn> | The name of the resource group in which to create your Service Bus namespace. In this exercise, you'll create the namespace in the resource group that was assigned when you activated the sandbox. |
    | **Instance Details** |
    | Namespace name | [Globally unique name] | Enter a name that is unique in Azure.<br />If you want to use the format _salesteamapp_<_Company_><_year_>, your namespace name would look like the example _salesteamappContoso2022_. |
    | Location | Select from the dropdown | Choose from the free *sandbox regions* listed following this table. |
    | Pricing tier | Standard | The recommended pricing tier for this exercise. |

    [!INCLUDE[Sandbox regions](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Review + create**.

    :::image type="content" source="../media/3-create-namespace-2.png" alt-text="Screenshot of the Create namespace pane showing validation passed and with Review plus create button highlighted.":::

1. When validation succeeds, select **Create** to create your Service Bus namespace.

    :::image type="content" source="../media/3-create-namespace-3.png" alt-text="Screenshot of the Create namespace pane, showing validation succeeded and Create button highlighted.":::

## Create a Service Bus queue

Next, add a queue for messages about individual sales to your namespace:

1. When deployment is finished, select **Go to resource**.

1. On the **Service Bus Namespace** page, select **Queues** under **Entities** on the left menu.

1. Select **+ Queue** on the command bar.
  
    :::image type="content" source="../media/3-create-queue.png" alt-text="Screenshot of Service Bus namespace and Create queue panes with Queue and Create highlighted.":::

1. In the **Create queue** pane, for **Name**, enter **salesmessages**, then select **Create**.  
  
When the message queue has been created, **salesmessages** is listed under **Queues** at the bottom of the Service Bus namespace pane.

## Create a Service Bus topic and subscriptions

You also want to create a topic that will be used for messages that relate to sales performance. Each instance of the business logic web service subscribes to this topic, and each sales performance message will be delivered to all web service subscriptions.

Add a Service Bus topic and subscriptions:

1. On the left menu, select **Topics** under **Entities** in the left menu, then select **+ Topic** on the command bar.

    :::image type="content" source="../media/3-create-topic.png" alt-text="Screenshot of the Service Bus namespace and Create topic panes with Topic and Create highlighted.":::

1. In the **Create topic** pane, for **Name**, enter *salesperformancemessages*, then select **Create**.

   When the topic has been created, **salesperformancemessages** is listed under **Topics** at the bottom of the Service Bus namespace pane.

1. You can add or remove subscriptions in queues and topics by using the tabs in the Service Bus namespace, or you can use the Azure portal resource menu. To use the menu option, in the left menu, under **Entities**, select **Topics**, and then select **salesperformancemessages** in the list of topics.

1. In the **salesperformancemessages** Service Bus topic pane, in the command bar, select **+ Subscription**.

1. In the **Create subscription** pane, for **Name**, enter **Americas**. For **Max delivery count**, enter **100**. Select **Create**.

    The **salesperformancemessages** Service Bus topic appears with the **Americas** subscription listed in the **Subscriptions** section at the bottom of the pane.

1. Next, add a second subscription. In the command bar, select **Subscription**.

1. In the **Create subscription** pane, for **Name**, enter **EuropeAndAsia**. For **Max delivery count**, enter **100**. Select **Create**.

The **Subscriptions** section of the **salesperformancemessages** Service Bus topic for your sales team app now lists two subscriptions.
  
You've built the infrastructure to use Service Bus to increase the resilience of your distributed application. You've created a queue for messages about individual sales, and a topic for messages about sales performance. You've added multiple subscriptions to the topic, so topic messages can be delivered to multiple web services around the world.
