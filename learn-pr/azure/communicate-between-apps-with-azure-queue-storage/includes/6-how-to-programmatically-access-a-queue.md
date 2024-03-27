Queues hold messages - packets of data whose shape is known to the sender application and receiver application. The sender creates the queue and adds a message. The receiver retrieves a message, processes it, and then deletes the message from the queue. The following illustration shows a typical flow of this process.

![An illustration showing a typical message flow through the Azure Queue.](../media/6-message-flow.png)

Notice that `get` and `delete` are separate operations. This arrangement handles potential failures in the receiver and implements a concept called _at-least-once delivery_. After the receiver gets a message, that message remains in the queue but is invisible for 30 seconds. If the receiver crashes or experiences a power failure during processing, then it never deletes the message from the queue. After 30 seconds, the message reappears in the queue and another instance of the receiver can process it to completion.

## How to connect to a queue

You already saw how to connect to a queue in the last unit using the `QueueClient` class. The `QueueClient` constructor takes the connection string and name of the queue that your application wants to connect to. Then the `QueueClient` class contains methods to send messages to, peek at messages on, and receive messages from the queue.

```csharp
QueueClient queueClient = new QueueClient(connectionString, queueName);
```

You create one `QueueClient` object for each queue that your application talks to. You then pass the `QueueClient` instance to any methods in your code that need to access the queue. The `QueueClient` class is thread-safe so a single instance can be used throughout your application.

## How to send a message

To send a message, you call the `SendMessageAsync` method on a `QueueClient` object. The simplest way to send a message is to just pass a string to the `SendMessageAsync` method.

```csharp
Response<SendReceipt> response = await queueClient.SendMessageAsync("This is a message");
```

Typically though, when exchanging data between applications, a message needs to contain multiple fields of data. For this reason, messages are often passed in a structured format like JSON to the queue. That means you need to first serialize an object representing the message to JSON and then pass the resulting JSON to the queue.

```csharp
string messageJson = JsonSerializer.Serialize(objectData);
Response<SendReceipt> response = await queueClient.SendMessageAsync(messageJson);
```

To include binary data in the message, first Base64-encode the binary data into a string. Then, the Base64-encoded string can then be sent to the storage queue, either directly or as a property on a JSON object.

> [!NOTE]
> While the total queue size can be up to 500 TB, the individual messages in it can only be up to 64 KB in size (48 KB when using Base64 encoding). If you need a larger payload you can combine queues and blobs by passing the URL to the actual data (stored as a Blob) in the message. This approach allows you to enqueue up to 4.77 TB in a Block Blob. The increased blob size better supports a diverse range of scenarios, from media companies storing and processing 4K and 8K videos to cancer researchers sequencing DNA.

## How to peek at messages

Sometimes your application might need to peek at a message in the queue without dequeuing the message. Peeking is done by calling the `PeekMessageAsync` method on the `QueueClient` class. Accessing the `Value` property of the `Response` class gives you access to the `PeekedMessage` object.

```csharp
Response<PeekedMessage> response = await queueClient.PeekMessageAsync();
PeekedMessage message = response.Value;

Console.WriteLine($"Message id  : {message.MessageId}");
Console.WriteLine($"Inserted on : {message.InsertedOn}");
```

## How to receive and delete a message

When the receiver application is ready to process a message, it calls the `ReceiveMessageAsync` method on the `QueueClient` object to pull the next message off of the queue. A `QueueMessage` object represents the message and can be accessed By using the `Value` property on the `Response` object.

The `QueueMessage` class contains properties to get the message ID, when the message was inserted into the queue and several others. The most important property though is the `Body` property, which contains the contents of the message. If the message was formatted as JSON, you can use the `ToObjectFromJson` method to convert the message into the appropriate object type.

```csharp
Response<QueueMessage> response = await queueClient.ReceiveMessageAsync();
QueueMessage message = response.Value;
NewsArticle article = message.Body.ToObjectFromJson<NewsArticle>();
```

When you're finished processing this message, you need to delete it from the queue. Doing so insures no other consumers pick up this message and process it. To delete the message, call the `DeleteMessageAsync` method on the `QueueClient` object. You need to provide the values of the `MessageId` and `PopReceipt` properties of the `QueueMessage` that you want to be deleted from the queue.

```csharp
await queueClient.DeleteMessageAsync(message.MessageId, message.PopReceipt);
```

Now let's apply this new knowledge to our application!
