You've decided to use an Azure Service Bus topic to distribute sales performance messages in your salesforce application. Sales personnel will use the app on their mobile devices to send messages that summarize sales figures for each area and time period. Those messages are distributed to web services that are located in the company's operational regions, including the Americas and Europe.

You've already implemented the necessary infrastructure in your Azure subscriptions for the topic. Now, you want to write the code that sends messages to the topic and write code that retrieves messages from a subscription. Then, you'll send a message to a topic and retrieve the message for a specific subscription.

Make sure you're working in the correct directory by running the following commands in Azure Cloud Shell:

```bash
cd ~/mslearn-connect-services-together/implement-message-workflows-with-service-bus/src/start
code .
```

## Write code to send a message to a topic

To complete the component that sends messages about sales performance, complete these steps:

1. In the Azure Cloud Shell editor, open *performancemessagesender/Program.cs* and find the following line of code:

    ```csharp
    const string ServiceBusConnectionString = "";
    ```

    Between the quotation marks, paste the connection string you saved in the previous exercise.

1. If you used a name different from **salesperformancemessages** for the queue name, update the value for `TopicName` property in the code.

    ```csharp
    const string TopicName = "salesperformancemessages";
    ```

1. Find the `SendPerformanceMessageAsync()` method. (*Hint*: It's at or near line 26.) Within that method, find the following line of code:

    ```csharp
    // Create a Service Bus client here
    ```

   Replace that line of code with this code:

    ```csharp
    // By leveraging "await using", the DisposeAsync method will be called automatically when the client variable goes out of scope.
    // In more realistic scenarios, you would store off a class reference to the client (rather than to a local variable) so that it can be used throughout your program.
    await using var client = new ServiceBusClient(ServiceBusConnectionString);
    ```

1. Within the `SendPerformanceMessageAsync()` method, find the following line of code:

    ```csharp
    // Create a sender here
    ```

   Replace that line of code with this code:

    ```csharp
    await using ServiceBusSender sender = client.CreateSender(TopicName);
    ```

1. In the `try...catch` block, find the following line of code:

    ```csharp
    // Create and send a message here
    ```

   Replace that line of code with this code:

    ```csharp
    string messageBody = "Total sales for Brazil in August: $13m.";
    var message = new ServiceBusMessage(messageBody);
    ```

1. To display the message in the console, insert the following code on the next line:

    ```csharp
    Console.WriteLine($"Sending message: {messageBody}");
    ```

1. To send the message to the topic, insert the following code on the next line:

    ```csharp
    await sender.SendMessageAsync(message);
    ```

1. Check that your final code resembles the following example:

    ```csharp
    using System;
    using System.Threading.Tasks;
    using Azure.Messaging.ServiceBus;
    
    namespace performancemessagesender
    {
        class Program
        {
            const string ServiceBusConnectionString = "Endpoint=sb://example.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=AbCdEfGhIjKlMnOpQrStUvWxYz==";
            const string TopicName = "salesperformancemessages";
    
            static void Main(string[] args)
            {
                Console.WriteLine("Sending a message to the Sales Performance topic...");
                SendPerformanceMessageAsync().GetAwaiter().GetResult();
                Console.WriteLine("Message was sent successfully.");
            }
    
            static async Task SendPerformanceMessageAsync()
            {
                // By leveraging "await using", the DisposeAsync method will be called automatically once the client variable goes out of scope.
                // In more realistic scenarios, you would store off a class reference to the client (rather than to a local variable) so that it can be used throughout your program.
                await using var client = new ServiceBusClient(ServiceBusConnectionString);

                await using ServiceBusSender sender = client.CreateSender(TopicName);
    
                try
                {
                    string messageBody = "Total sales for Brazil in August: $13m.";
                    var message = new ServiceBusMessage(messageBody);
                    Console.WriteLine($"Sending message: {messageBody}");
                    await sender.SendMessageAsync(message);
                }
                catch (Exception exception)
                {
                    Console.WriteLine($"{DateTime.Now} :: Exception: {exception.Message}");
                }
            }
        }
    }
    ```

1. To save your changes, select <kbd>Ctrl+S</kbd>, and then select <kbd>Ctrl+Q</kbd> to close the editor.

## Send a message to the topic

1. To run the component that sends a message about a sale, run the following command in Cloud Shell:

    ```bash
    dotnet run --project performancemessagesender
    ```

1. As the program executes, watch for notifications in Cloud Shell that indicate that a message is being sent. Each time you run the app, another message is added to the topic, and a copy becomes available for each subscription.
  
    ```command
    Sending a message to the Sales Performance topic...
    Sending message: Total sales for Brazil in August: $13m.
    Message was sent successfully.
    ```

### Check the message count before you retrieve messages for a subscription

When you see `Message was sent successfully`, run the following command to see how many messages are in the `Americas` subscription. Remember to replace \<namespace-name\> with your Service Bus namespace.

```azurecli
az servicebus topic subscription show \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --topic-name salesperformancemessages \
    --name Americas \
    --query messageCount \
    --namespace-name <namespace-name>
```

If you replace `Americas` with `EuropeAndAsia` and run the command again, you'll see that both subscriptions have the same number of messages.

## Write code to retrieve a topic message for a subscription

To create the component that retrieves messages about sales performance, complete these steps:

1. Run `code .` to launch the editor.

1. In the editor, open *performancemessagereceiver/Program.cs* and find the following line of code:

    ```csharp
    const string ServiceBusConnectionString = "";
    ```

    Between the quotation marks, paste the connection string that you saved in the previous exercise.

1. To create a Service Bus client, find the `MainAsync()` method. Within that method, locate the following line of code:

    ```csharp
    // Create a Service Bus client that will authenticate using a connection string
    ```

   Replace that line with this code:

    ```csharp
    var client = new ServiceBusClient(ServiceBusConnectionString);
    ```

1. To configure message handling options, find the following line of code:

    ```csharp
    // Create the options to use for configuring the processor
    ```

   Replace that line with this code:

    ```csharp
    var processorOptions = new ServiceBusProcessorOptions
    {
        MaxConcurrentCalls = 1,
        AutoCompleteMessages = false
    };
    ```

1. To create a processor, find the following line of code:

    ```csharp
    // Create a processor that we can use to process the messages
    ```

   Replace that line with this code:

    ```csharp
    ServiceBusProcessor processor = client.CreateProcessor(TopicName, SubscriptionName, processorOptions);
    ```

1. To configure the handler, find the following line of code:

    ```csharp
    // Configure the message and error handler to use
    ```

   Replace that line with this code:

    ```csharp
    processor.ProcessMessageAsync += MessageHandler;
    processor.ProcessErrorAsync += ErrorHandler;
    ```

1. To start processing, find the following line of code:

    ```csharp
    // Start processing
    ```

   Replace that line with this code:

    ```csharp
    await processor.StartProcessingAsync();
    ```

1. Look for the following line of code:

    ```csharp
    // Since we didn't use the "await using" syntax here, we need to explicitly dispose the processor and client    
    ```

   Replace the line with this code:

    ```csharp
    await processor.DisposeAsync();
    await client.DisposeAsync();    
    ```

1. To display incoming messages in the console, find the `MessageHandler()` method. You've registered this method to handle incoming messages.

    Replace all the code within that method with the following code:

    ```csharp
    Console.WriteLine($"Received message: SequenceNumber:{args.Message.SequenceNumber} Body:{args.Message.Body}");
    ```

1. To remove the received message from the subscription, on the next line, add the following code:

    ```csharp
    await args.CompleteMessageAsync(args.Message);
    ```

1. Check that your final code resembles the following example:

    ```csharp
    using System;
    using System.Text;
    using System.Threading;
    using System.Threading.Tasks;
    using Azure.Messaging.ServiceBus;
    
    namespace performancemessagereceiver
    {
        class Program
        {
            const string ServiceBusConnectionString = "Endpoint=sb://alexgeddyneil.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=LIWIyxs8baqQ0bRf5zJLef6OTfrv0kBEDxFM/ML37Zs=";
            const string TopicName = "salesperformancemessages";
            const string SubscriptionName = "Americas";
    
            static void Main(string[] args)
            {
                MainAsync().GetAwaiter().GetResult();
            }
    
            static async Task MainAsync()
            {
                var client = new ServiceBusClient(ServiceBusConnectionString);
    
                Console.WriteLine("======================================================");
                Console.WriteLine("Press ENTER key to exit after receiving all the messages.");
                Console.WriteLine("======================================================");
    
                var processorOptions = new ServiceBusProcessorOptions
                {
                    MaxConcurrentCalls = 1,
                    AutoCompleteMessages = false
                };

                ServiceBusProcessor processor = client.CreateProcessor(TopicName, SubscriptionName, processorOptions);

                processor.ProcessMessageAsync += MessageHandler;
                processor.ProcessErrorAsync += ErrorHandler;

                await processor.StartProcessingAsync();
                
                Console.Read();

                await processor.DisposeAsync();
                await client.DisposeAsync();
            }
    
            static async Task MessageHandler(ProcessMessageEventArgs args)
            {
                Console.WriteLine($"Received message: SequenceNumber:{args.Message.SequenceNumber} Body:{args.Message.Body}");
                await args.CompleteMessageAsync(args.Message);
            }

            static Task ErrorHandler(ProcessErrorEventArgs args)
            {
                Console.WriteLine($"Message handler encountered an exception {args.Exception}.");
                Console.WriteLine("Exception context for troubleshooting:");
                Console.WriteLine($"- Endpoint: {args.FullyQualifiedNamespace}");
                Console.WriteLine($"- Entity Path: {args.EntityPath}");
                Console.WriteLine($"- Executing Action: {args.ErrorSource}");
                return Task.CompletedTask;
            }
        }
    }
    ```

1. To save your changes, select <kbd>Ctrl+S</kbd>, and then select <kbd>Ctrl+Q</kbd> to close the editor.

## Retrieve a topic message for a subscription

1. To run the component that retrieves a message about sales performance for a subscription, run the following command:

    ```bash
    dotnet run --project performancemessagereceiver
    ```

    You'll see output similar to the following example:

    ```command
    Received message: SequenceNumber:1 Body:Total sales for Brazil in August: $13m.
    ```

1. When the program has returned notifications that it's receiving messages, press <kbd>Enter</kbd> to stop the app.

### Check the message count after you retrieve a message for a subscription

Run the following command to confirm that there are no remaining messages in the `Americas` subscription. Be sure to replace \<namespace-name\> with your Service Bus namespace.

```azurecli
az servicebus topic subscription show \
     --resource-group <rgn>[sandbox resource group name]</rgn> \
     --topic-name salesperformancemessages \
     --name Americas \
     --query messageCount \
     --namespace-name <namespace-name> 
```

If you replace `Americas` with `EuropeAndAsia` in this code to see the current message count for the `EuropeAndAsia` subscription, you'll see that the message count is `1`. In the preceding code, only `Americas` was set to retrieve topic messages, so that message is still waiting for `EuropeAndAsia` to retrieve it.
