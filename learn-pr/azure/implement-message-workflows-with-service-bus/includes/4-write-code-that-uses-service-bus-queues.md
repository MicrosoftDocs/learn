Distributed applications use Service Bus queues as temporary storage locations for messages that are awaiting delivery to a destination component. To send and receive messages through a queue, you must write code in both the source and destination components.

Consider the Contoso Bicycles application. The customer can place an order through a website or mobile app. Because websites and mobile apps run on customer devices, there really is no limit to how many orders can be made at the same time. By having the mobile app and website deposit the orders in a Service Bus queue, the back-end component (a web app) is able to process orders from that queue at its own pace.

The Contoso Bicycles application actually has several steps to handle a new order. All the steps are dependent on first authorizing payment, so you decide to use a queue. The receiving component's first job is processing the payment.

In the mobile app and website, Contoso needs to write code that adds a message to the queue. In the back-end web app, Contoso writes code that picks up messages from the queue.

Here, you'll look at the process and considerations in writing code to send and receive messages by using a Service Bus queue.

## Azure.Messaging.ServiceBus NuGet package

To make it easy to write code that sends and receives messages through Service Bus, Microsoft provides a library of .NET classes. You can use in any .NET language to interact with a Service Bus queue or topic. You can include this library in your application by adding the **Azure.Messaging.ServiceBus** NuGet package.

## Connection strings and keys

Source components and destination components both need two pieces of information to connect to a queue in a Service Bus namespace:

- The location of the Service Bus namespace, also known as an *endpoint*. The location is specified as a fully qualified domain name within the **servicebus.windows.net** domain. For example: **bicycleService.servicebus.windows.net**.
- An access key. Service Bus restricts access to queues or topics by requiring a valid access key.

Both these pieces of information are provided to the [ServiceBusClient](/dotnet/api/azure.messaging.servicebus.servicebusclient) object in the form of a connection string. You can get the correct connection string for your namespace from the Azure portal.

## Call methods asynchronously

The queue in Azure might be located thousands of miles away from sending and receiving components. Even if it's physically close, slow connections and bandwidth contention might cause delays when a component calls a method on the queue. For this reason, the Service Bus client library makes `async` methods available for interacting with queues. We'll use these methods to avoid blocking a thread while waiting for calls to complete.

When you send a message to a queue, for example, use the [SendMessageAsync](/dotnet/api/azure.messaging.servicebus.servicebussender.sendmessageasync) method with the `await` keyword.

## To send a message to a queue

To send a message to a queue, you'll complete the following steps.

In any sending or receiving component, add the following `using` statements to any code file that calls a Service Bus queue.

```csharp
using System.Threading;
using System.Threading.Tasks;
using Azure.Messaging.ServiceBus;
```

Next, create a new `ServiceBusClient` object, and pass it the connection string and the name of the queue.

```csharp
// Create a ServiceBusClient object using the connection string to the namespace.
await using var client = new ServiceBusClient(connectionString);
    
// Create a ServiceBusSender object by invoking the CreateSender method on the ServiceBusClient object, and specifying the queue name. 
ServiceBusSender sender = client.CreateSender(queueName);
```
  
You can send a message to the queue by calling the `ServiceBusSender.SendMessageAsync()` method and passing a `ServiceBusMessage`.

```csharp
// Create a new message to send to the queue.
string messageContent = "Order new crankshaft for eBike.";
var message = new ServiceBusMessage(messageContent);

// Send the message to the queue.
await sender.SendMessageAsync(message);
```

## To receive messages from a queue

To receive messages, you must first register a message handler. The message handler is the method in your code that is invoked when a message is available on the queue.

```csharp
// Create a ServiceBusProcessor for the queue.
await using ServiceBusProcessor processor = client.CreateProcessor(queueName, options);
    
// Specify handler methods for messages and errors.
processor.ProcessMessageAsync += MessageHandler;
processor.ProcessErrorAsync += ErrorHandler;
```

Do your processing work. Then, within the message handler, call the `ProcessMessageEventArgs.CompleteMessageAsync()` method to remove the message from the queue.

```csharp
await args.CompleteMessageAsync(args.Message);
```
