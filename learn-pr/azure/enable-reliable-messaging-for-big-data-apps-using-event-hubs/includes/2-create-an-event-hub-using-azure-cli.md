Your team makes a decision to use the capabilities of Azure Event Hubs to manage and process the increasing transaction volumes coming through your system.

An event hub is an Azure resource, so your first step is to create a new hub in Azure, and configure it to meet the specific requirements of your apps.

## What is Azure Event Hubs?

Azure [Event Hubs](https://azure.microsoft.com/services/event-hubs/) is a cloud-based, event-processing service that can receive and process millions of events per second. Event Hubs acts as a front door for an event pipeline, it receives incoming data and stores this data until processing resources are available.

An entity that sends data to your event hub is called a *publisher*, and an entity that reads data from an event hub is called a *consumer*, or a *subscriber*. Your event hub sits between the publisher and subscriber to divide the production (from the publisher) and consumption (to a subscriber) of an event data stream. This decoupling helps to manage scenarios where the rate of event production is considerably higher than the consumption. The following illustration shows the role of an event hub.

![An illustration showing an Azure event hub placed between four publishers and two subscribers. The event hub receives multiple events from the publishers, serializes the events into data streams, and makes the data streams available to subscribers.](../media/2-event-hub-overview.png)

### Events

An **event** is a small packet of information (a *datagram*) that contains a notification. Events can be published individually or in batches, but a single publication (individual or batch) can't exceed 1 MB.

### Publishers and subscribers

Event publishers are any app or device that can send out events using either HTTPS, Advanced Message Queuing Protocol (AMQP) 1.0, or Apache Kafka.

- For publishers that send data frequently, **AMQP** has better performance. However, it has a higher initial session overhead, because a persistent bidirectional socket and transport-level security (TLS), or SSL/TLS, has to be set up first.
- For more intermittent publishing, **HTTPS** is the better option. Though HTTPS requires more overhead for each request, there's no session initialization overhead.
- Event Hubs provides an endpoint compatible with the **Apache Kafka** producer and consumer APIs that can be used by most existing Apache Kafka client applications as an alternative to running your own Apache Kafka cluster. Event Hubs supports Apache Kafka's producer and consumer APIs clients at version 1.0 and above. For more information, see [Event Hubs for Apache Kafka](/azure/event-hubs/event-hubs-for-kafka-ecosystem-overview).

Event subscribers are apps that use one of two supported programmatic methods to receive and process events from an event hub.

- **EventHubReceiver** - A simple method that provides limited management options.
- **EventProcessorHost** - An efficient method that we use later in this module.

### Consumer groups

An event hub **consumer group** represents a specific view of an event hub data stream. When you use separate consumer groups, multiple subscriber apps can process an event data stream independently, and without affecting other apps. However, the use of many consumer groups isn't a requirement, and for many apps, the single default consumer group is sufficient.

### Pricing

There are four pricing tiers for Azure Event Hubs: Basic, Standard, Premium, and Dedicated. The tiers differ in terms of supported connections, the number of available consumer groups, and throughput. When using Azure CLI to create an Event Hubs namespace, if you don't specify a pricing tier, the default **Standard** (20 Consumer groups, 1000 Brokered connections) is assigned. For the main differences between these tiers, see [Azure Event Hubs - Pricing](https://azure.microsoft.com/pricing/details/event-hubs/).

## Create and configure an event hub

There are two main steps to create a new event hub. The first step is to define the Event Hubs **namespace**. The second step is to create an event hub in that namespace.

### Define an Event Hubs namespace

An Event Hubs namespace is a container for managing one or more event hubs. Creating an Event Hubs namespace typically involves the following configuration:

### Define namespace-level settings

Namespace capacity (configured using **throughput units** for the standard tier), pricing tier, and performance metrics are defined at the namespace level. These settings apply to all the event hubs within that namespace. If you don't define these settings, a default value is used: `1` for capacity and `Standard` for pricing tier.

Keep the following aspects in mind:

- You must balance your configuration against your Azure budget expectations.

- You might consider configuring different event hubs for different throughput requirements. For example, if you have a sales data app, and you're planning for two event hubs, it would make sense to use a separate namespace for each hub.  

  You configure one namespace for high throughput collection of real-time sales data and one namespace for infrequent event log collection. This way, you only need to configure (and pay for) high throughput capacity on the real-time sales data hub.

  1. Select a unique name for the namespace. The namespace is accessible through this URL: *_namespace_.servicebus.windows.net*

  1. Define the following optional properties:

     - Make this namespace zone redundant. Zone-redundancy replicates data across separate data centers, which have independent power, networking, and cooling infrastructures.

     - Enable the automatic scaling up of throughput units (standard tier). Autoinflate provides an automatic scale-up option by increasing the number of throughput units up to a maximum value. This option is useful to avoid throttling in situations when incoming or outgoing data rates exceed the currently set number of throughput units.

### Azure CLI commands to create an Event Hubs namespace

To create a new Event Hubs namespace, use `az eventhubs namespace` commands. Here's a brief description of the commands we use in the exercise.

| Command | Description |
|---------|-------------|
| `create` | Creates an Event Hubs namespace. |
| `authorization-rule` | All event hubs within the same namespace share common connection credentials. You need these credentials when you configure apps to send and receive messages using the event hub. This command returns the connection string for your Event Hubs namespace. |

### Configure a new event hub

After you create an Event Hubs namespace, you can create an event hub. When you create an event Hub, there are several mandatory parameters.

The following parameters are required to create an event hub:

- **Event hub name** - An event hub name that is unique within your subscription and:
  - Is between 1 and 50 characters.
  - Contains only letters, numbers, periods, hyphens, and underscores.
  - Starts and ends with a letter or number.
- **Partition count** -  The number of partitions required in an event hub (between 2 and 32 for the standard tier). The partition count should be directly related to the expected number of concurrent consumers and can't be changed after the hub is created. The partition separates the message stream so that consumer or receiver apps only need to read a specific subset of the data stream. If not defined, the value defaults to *4*.
- **Message retention** - The number of days (1 to 7 for the standard tier) that messages remain available if the data stream needs to be replayed for any reason. If not defined, this value defaults to *7*.

You can also optionally configure an event hub to stream data to Azure Blob Storage or an Azure Data Lake Storage.

### Azure CLI commands to create an event hub

To create a new event hub with the Azure CLI, you run the `az eventhubs eventhub` command set. Here's a brief description of the commands we use in the exercise.

| Command | Description |
|---------|-------------|
| `create` | Creates the event hub in a specified namespace. |
| `show` | Displays the details of your event hub. |

> [!NOTE]
> For quotas and limits for different tiers of Event Hubs, see [Azure Event Hubs quotas and limits](/azure/event-hubs/event-hubs-quotas).

## Summary

To deploy Azure Event Hubs, you must configure an Event Hubs namespace, and then configure the event hub itself. In the next unit, you go through the detailed steps to create a new namespace and event hub.
