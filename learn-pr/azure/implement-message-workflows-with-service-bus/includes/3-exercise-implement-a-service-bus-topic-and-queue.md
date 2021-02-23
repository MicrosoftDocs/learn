Suppose you have an application for the sales team in your global company. Each team member has a mobile phone where your app will be installed. A web service hosted in Azure implements the business logic for your application and stores information in Azure SQL Database. There is one instance of the web service for each geographical region. You have identified the following purposes for sending messages between the mobile app and the web service:

- Messages that relate to individual sales must be sent only to the web service instance in the user's region.
- Messages that relate to sales performance must be sent to all instances of the web service.

You have decided to implement a Service Bus queue for the first use case, and the Service Bus topic for the second use case.

In this exercise, you will create a Service Bus namespace, which will contain both a queue and a topic with subscriptions.

## Create a Service Bus namespace

In Azure Service Bus, a namespace is a container, with a unique fully qualified domain name, for queues, topics, and relays. You must start by creating the namespace.

Each namespace has primary and secondary shared access signature encryption keys. To gain access to the objects within the namespace, a sending or receiving component must provide these keys when it connects.

To create a Service Bus namespace using the Azure portal, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. Select **+ Create a resource**.

1. Enter **Service Bus** in the search box, then select **Service Bus**, and then select **Create**.

1. In the **Basics** tab, specify the following settings in the **PROJECT DETAILS** section.

    | Setting | Value |
    |---|---|
    | **Subscription** | Concierge Subscription |
    | **Resource group** | Select <rgn>[Sandbox resource group]</rgn> from the dropdown. |

1. Specify the following settings in the **INSTANCE DETAILS** section.

    | Setting | Value |
    |---|---|
    | **Namespace Name** | *Enter a unique name*, for example, "salesteamapp" + *your initials* + *current date*. |
    | **Location** | Location near you from the following list. |
    | **Pricing tier** | Standard |

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Review + create** to have an opportunity to review the Service Bus namespace details.

    :::image type="content" source="../media/3-create-namespace-2.png" alt-text="Screenshot of the Service bus Create namespace pane with the Review + create button highlighted":::

1. Review the details, and select **Create** to create the Service Bus namespace.

    :::image type="content" source="../media/3-create-namespace-3.png" alt-text="Screenshot of the Service bus Review namespace pane with the Create button highlighted":::

## Create a Service Bus queue

Now that you have a namespace, you can create a queue for messages about individual sales. To do this, follow these steps:

1. Under the **Deployment** pane, select **Go to resource**. The namespace you just created appears.

1. In the top left of the namespace pane, select **+ Queue**.

1. In the **Create queue** pane, in the **Name** text box, enter **salesmessages**, and then select **Create**. Azure creates the queue in your namespace.

    :::image type="content" source="../media/3-create-queue.png" alt-text="Screenshot of the Create queue pane with the Create button highlighted":::

## Create a Service Bus topic and subscriptions

You also want to create a topic that will be used for messages that relate to sales performance. Multiple instances of the business logic web service will subscribe to this topic from different countries. Each message will be delivered to multiple instances.

Follow these steps:

1. In the **Service Bus Namespace** pane, select **+ Topic**.

1. In the **Create topic** pane, in the **Name** text box, enter **salesperformancemessages**, and then select **Create**. Azure creates the topic in your namespace.

    :::image type="content" source="../media/3-create-topic.png" alt-text="Screenshot of the Create topic pane with the Create button highlighted":::

1. When the topic has been created, at the bottom of the page, **Queues** and **Topics** tabs appear. Select **Topics**.

1. In the list of topics, select **salesperformancemessages**, and then select **+ Subscription**.

1. Enter **Americas** for the **Name**, then **100** for the **Max delivery count**, and then select **Create**.

1. Select **+ Subscription**.

1. Enter **EuropeAndAfrica** for the **Name**, then **100** for the **Max delivery count**, and then select **Create**.

You have built the infrastructure required to use Service Bus to increase the resilience of your sales force distributed application. You have created a queue for messages about individual sales, and a topic for messages about sales performance. The topic includes multiple subscriptions because messages sent to that topic can be delivered to multiple recipient web services around the world.
