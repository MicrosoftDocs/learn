It's simple to write code that creates queues, sends messages, and receives messages from RabbitMQ. In a .NET Aspire solution, you also have help to create the RabbitMQ container and make connections to it from microservices.

In your outdoor equipment retailer, you've decided to implement RabbitMQ as a centralized message broker for your customer-facing product catalog website. You want to use the .NET Aspire RabbitMQ component to manage this broker and its queues.

In this unit, you'll learn how to create a RabbitMQ container and use it to send and receive messages.

## Using the .NET Aspire RabbitMQ component

When you use RabbitMQ from .NET, you usually have to create a `ConnectionFactory` object with a connection string and then use it to make connections to the service. In a .NET Aspire project, it's easier to manage RabbitMQ connection because:

- You register a connection and connection string in the **AppHost** project.
- When you pass a reference to the service to consuming projects, they can use dependency injection to get a connection to RabbitMQ. They don't need to create and configure their own connections.

### Configuring RabbitMQ in the app host

In .NET Aspire, you must install the Rabbit MQ hosting component in the app host:

```dotnetcli
dotnet add package Aspire.Hosting.RabbitMQ
```

Now, you can register the RabbitMQ service and pass it to projects that use it:

```csharp
// Service registration
var rabbit = builder.AddRabbitMQ("messaging");

// Service consumption
builder.AddProject<Projects.CatalogAPI>()
       .WithReference(rabbit);
```

The `AppHost` manages the connection for all projects in the solution.


### Configuring Rab

Next, add the .NET Aspire RabbitMQ component to each project that uses it:

```dotnetcli
dotnet add package Aspire.RabbitMQ.Client
```

To obtain a reference to the RabbitMQ message broker, call the `AddRabbitMQClient()` method:

```csharp
builder.AddRabbitMQClient("messaging");
```

Now, you can use dependency injection to obtain the connection to RabbitMQ:

```csharp
public class CatalogAPI(IConnection rabbitConnection)
{
    // Send and receive messages here
}
```

With the connection, the next step is to create a messaging channel, like this:

```csharp
var channel = connection.CreateModel();
```

## Sending messages

Once you have the messaging channel, you can use it to set up queues, exchanges, and other components of your messaging topology. For example, to create a queue, use this code:

```csharp
channel.QueueDeclare(queue: "catalogEvents",
    durable: false,
    exclusive: false,
    autoDelete: false,
    arguments: null);
```

You use the `BasicPublish` method to send a message to this queue, but the message expects the body to be a byte array:

```csharp
var body = Encoding.UTF8.GetBytes("Getting all items in the catalog.");

channel.BasicPublish(exchange: string.Empty,
    routingKey: "catalogEvents",
    basicProperties: null,
    body: body);
```

## Receiving messages

In the receiving component, you create the messaging channel and the queue in the same way as for the sender. Make sure the queue name matches the one you created in the sending component. Otherwise you'll create two separate queues and messages won't arrive at the correct destination.

You must create a new `EventingBasicConsumer()` method and register a method to handle the `Received` event:

```csharp
var consumer = new EventingBasicConsumer(channel);
consumer.Received += ProcessMessageAsync;
```

The message handler uses a `BasicDeliverEventArgs` object to obtain the properties of the message, including the message body. You must remember to deserialize the message body:

```csharp
private void ProcessMessageAsync(object? sender, BasicDeliverEventArgs args)
{
    string messagetext = Encoding.UTF8.GetString(args.Body.ToArray());
    logger.LogInformation("The message is: {text}", messagetext);
}
```

Finally, to check the queue for new messages, call the `BasicConsume()` method;

```csharp
channel.BasicConsume(queue:  queueName,
                    autoAck: true, 
                    consumer: consumer);
```

## Learn more

- [.NET Aspire RabbitMQ component](/dotnet/aspire/messaging/rabbitmq-client-component)
- [RabbitMQ Tutorials](https://www.rabbitmq.com/tutorials)
