You have decided to use an Azure Service Bus topic to distribute sales performance messages in your salesforce application. Sales personnel will use the app on their mobile devices to send messages that summarize sales figures for each area and time period. Those messages will be distributed to web services located in the company's operational regions, including the Americas and Europe.

You have already implemented the necessary infrastructure in your Azure subscriptions for the topic. Now, you want to write the code that sends messages to the topic and retrieves messages from a subscription. 

Make sure you are working in the correct directory by running the following commands in the Azure Cloud Shell:

```bash
cd ~/mslearn-connect-services-together/implement-message-workflows-with-service-bus/src/start
code .
```

## Write code that sends a message to the topic

To complete the component that sends messages about sales performance, follow these steps:

1. In the Azure Cloud Shell editor, open **performancemessagesender/Program.cs** and locate the following line of code.

    ```C#
    const string ServiceBusConnectionString = "";
    ```

    Paste the connection string that you saved in the previous exercise between the quotation marks.

1. Locate the `SendPerformanceMessageAsync()` method. (Hint: located at or near line 26.)

1. Within that method, locate the following line of code.

    ```C#
    // Create a Service Bus client here
    ```

1. Replace that line of code with the following code.

    ```C#
    // By leveraging "await using", the DisposeAsync method will be called automatically once the client variable goes out of scope.
    // In more realistic scenarios, you would want to store off a class reference to the client (rather than a local variable) so that it can be used throughout your program.
    await using var client = new ServiceBusClient(ServiceBusConnectionString);
    ```
1. Within that method, locate the following line of code.

    ```C#
    // Create a sender here
    ```

1. Replace that line of code with the following code.

    ```C#
    await using ServiceBusSender sender = client.CreateSender(TopicName);
    ```

1. Within the `try...catch` block, locate the following line of code.

    ```C#
    // Create and send a message here
    ```

1. Replace that line of code with the following code.

    ```C#
    string messageBody = "Total sales for Brazil in August: $13m.";
    var message = new ServiceBusMessage(messageBody);
    ```

1. To display the message in the console, insert the following code on the next line.

    ```C#
    Console.WriteLine($"Sending message: {messageBody}");
    ```

1. To send the message to the topic, insert the following code on the next line.

    ```C#
    await sender.SendMessageAsync(message);
    ```

1. Your final code should resemble the following example:

    ```C#
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

1. Save the file using the editor's **&#9776;** menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

## Send a message to the topic

1. To run the component that sends a message about a sale, run the following command in Cloud Shell.

    ```bash
    dotnet run -p performancemessagesender
    ```

    As the program executes, you'll see notifications in the Azure Cloud Shell indicating that it's sending a message. Each time you run the app, one more message will be added to the topic and each subscriber will receive a copy.

1. When you see **Message was sent successfully**, run the following command to see how many messages are in the Americas subscription. Remember to replace \<namespace-name\> with your Service Bus Namespace.

    ```azurecli
    az servicebus topic subscription show \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --namespace-name <namespace-name> \
        --topic-name salesperformancemessages \
        --name Americas \
        --query messageCount
    ```

    If you replace `Americas` with `EuropeAndAsia`, and run the command again, you should see that both subscriptions have the same number of messages.

## Write code that receives a message from a topic subscription

To complete the component that retrieves messages about sales performance, follow these steps:

1. In the editor, open **performancemessagereceiver/Program.cs** and locate the following line of code:

    ```C#
    const string ServiceBusConnectionString = "";
    ```

    Paste the connection string that you saved in the previous exercise between the quotation marks.

1. Locate the `MainAsync()` method.

1. Within that method, locate the following line of code.

    ```C#
    // Create a Service Bus client that will authenticate using a connection string
    ```

1. To create a Service Bus client, replace that line with the following code.

    ```C#
    var client = new ServiceBusClient(ServiceBusConnectionString);
    ```

1. Locate the following line of code:

    ```C#
    // Create the options to use for configuring the processor
    ```

1. To configure message handling options, replace that line with the following code.

    ```C#
    var processorOptions = new ServiceBusProcessorOptions
    {
        MaxConcurrentCalls = 1,
        AutoCompleteMessages = false
    };
    ```
1. Locate the following line of code.

    ```C#
    // Create a processor that we can use to process the messages
    ```

1. To create a processor, replace that line with the following code.

    ```C#
    ServiceBusProcessor processor = client.CreateProcessor(TopicName, SubscriptionName, processorOptions);
    ```

1. Locate the following line of code.

    ```C#
    // Configure the message and error handler to use
    ```

1. To configure the handler, replace that line with the following code.

    ```C#
    processor.ProcessMessageAsync += MessageHandler;
    processor.ProcessErrorAsync += ErrorHandler;
    ```

1. Locate the following line of code.
    ```C#
    // Start processing
    ```

1. To start processing, replace that line with the following code.

    ```C#
    await processor.StartProcessingAsync();
    ```

1. Locate the `MessageHandler()` method. You have registered this method to handle incoming messages.

1. To display incoming messages in the console, replace all the code within that method with the following code.

    ```C#
    Console.WriteLine($"Received message: SequenceNumber:{args.Message.SequenceNumber} Body:{args.Message.Body}");
    ```

1. To remove the received message from the subscription, on the next line, add the following code.

    ```C#
    await args.CompleteMessageAsync(args.Message);
    ```

1. Your final code should resemble the following example.

    ```C#
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

                // Since we didn't use the "await using" syntax here, we need to explicitly dispose the processor and client
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

1. Save the file using either the **&#9776;** menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

## Retrieve a message from a topic subscription

1. To run the component that retrieves a message about sales performance, run the following command.

    ```bash
    dotnet run -p performancemessagereceiver
    ```

1. When the program has returned notifications that it is receiving messages, press <kbd>Enter</kbd> to stop the app. Then, run the following command to confirm that there are zero remaining messages in the `Americas` subscription. Be sure to replace \<namespace-name\> with your Service Bus Namespace.

    ```azurecli
    az servicebus topic subscription show \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --namespace-name <namespace-name> \
        --topic-name salesperformancemessages \
        --name Americas \
        --query messageCount
    ```

1. If you replace `Americas` with `EuropeAndAsia`, you'll see that the message count has not changed. The application only received messages from the `Americas` subscription.
