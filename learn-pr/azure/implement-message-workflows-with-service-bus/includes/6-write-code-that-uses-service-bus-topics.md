In a distributed application, some messages need to be sent to a single recipient component. Other messages need to reach more than one destination.

Consider what happens when a user cancels a bicycle order. Canceling an order is a little different from placing an initial order. When an order is placed, the workflow waited until the order cleared payment processing before sending the order to the local storefront. For the cancel operation, you'll notify the storefront *and* the payment processor at the same time. This approach minimizes the chances of wasting delivery driver time.

To allow multiple components to receive the same message, you'll use an Azure Service Bus *topic*. Next, you'll look at the process and considerations in writing the code.

## Code with topics vs. code with queues

If you want every message sent to be delivered to all subscribing components, use topics. Writing code that uses topics is a way to replace queues. You'll use the same **Azure.Messaging.ServiceBus** NuGet package, configure connection strings, and use asynchronous programming patterns.

You'll also use the same `ServiceBusClient` class and `ServiceBusSender` classes to send messages and the `ServiceBusProcessor` class to receive messages.

## Set filters on subscriptions

If you want specific messages that are sent to the topic to be delivered to a specific subscription, you can place one or more filters on the subscription in the topic. In the bicycle application, for example, your storefronts are running Universal Windows Platform (UWP) applications. Each store can subscribe to the `OrderCancellation` topic and filter for its own `StoreId`. You save internet bandwidth because you aren't sending unnecessary messages to multiple store locations. Meanwhile, the payment-processing component subscribes to all `OrderCancellation` messages.

Filters can be one of three types:

- **Boolean filters**: The `TrueFilter` ensures that all messages sent to the topic are delivered to the current subscription. The `FalseFilter` ensures that none of the messages are delivered to the current subscription. (This effectively blocks or switches off the subscription.)
- **SQL filters**: A SQL filter specifies a condition by using the same syntax as a `WHERE` clause in a SQL query. Only messages that return `True` when they're evaluated against this filter are delivered to the subscribers.
- **Correlation filters**: A correlation filter holds a set of conditions that are matched against the properties of each message. If the property in the filter and the property on the message have the same value, it's considered a match.

For your `StoreId` filter, you *could* use a SQL filter. SQL filters are the most flexible, but they're also the most computationally expensive, and the filter might slow down your Service Bus throughput. In this case, you choose a correlation filter.

## To send a message to a topic

To send a message to a topic, you'll complete the following steps.

In any sending or receiving component, add the following `using` statements to any code file that calls a Service Bus topic.

```csharp
using System.Threading;
using System.Threading.Tasks;
using Azure.Messaging.ServiceBus;
```

To send a message, start by creating a new `ServiceBusClient` object, and passing it the connection string and the name of the topic.

```csharp
await using var client = new ServiceBusClient(connectionString);
```

Then, create a `ServiceBusSender` object by invoking the `CreateSender` method on the `ServiceBusClient` object, and specifying the topic name.

```csharp
ServiceBusSender sender = client.CreateSender(topicName);
```

You can send a message to the topic by calling the `ServiceBusSender.SendMessageAsync()` method and passing a `ServiceBusMessage`. Like in a queue, the message must be in the form of a UTF-8 encoded string.

```csharp
string message = "Cancel! I have changed my mind!";
var message = new ServiceBusMessage(message);

// Send the message to the topic.
await sender.SendMessageAsync(message);
```

## To receive messages from a subscription

To receive a message from a subscription, you must create a `ServiceBusProcessor` object, and pass it the topic name and the subscription name.

```csharp
processor = client.CreateProcessor(topicName, subscriptionName, options);
```

Then, register a message handler and an error handler.

```csharp
// Specify the handler method for messages.
processor.ProcessMessageAsync += MessageHandler;

// Specify the handler method for errors.
processor.ProcessErrorAsync += ErrorHandler;
```

Do your processing work within the message handler, then call the `ProcessMessageEventArgs.CompleteMessageAsync()` method to remove the message from the subscription.

```csharp
// Complete the message. The message is deleted from the subscription. 
await args.CompleteMessageAsync(args.Message);
```
