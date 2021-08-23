You have decided to use an Azure Service Bus topic to distribute sales performance messages in your salesforce application. Sales personnel will use the app on their mobile devices to send messages that summarize sales figures for each area and time period. Those messages will be distributed to web services located in the company's operational regions, including the Americas and Europe.

You have already implemented the necessary infrastructure in your Azure subscriptions for the topic. Now, you want to write the code that sends messages to the topic and retrieves messages from a subscription. 

Make sure you are working in the correct directory by running the following commands in the Azure Cloud Shell:

```bash
cd ~/mslearn-connect-services-together/implement-message-workflows-with-service-bus/src/start
code .
```

## Write code that sends a message to the topic

To complete the component that sends messages about sales performance, follow these steps:

1. In the editor, open **performancemessagesender/Program.cs** and locate the following line of code.

    ```C#
    const string ServiceBusConnectionString = "";
    ```

    Paste the connection string that you saved in the previous exercise between the quotation marks.

1. Locate the `SendPerformanceMessageAsync()` method.

1. Within that method, locate the following line of code.

    ```C#
    // Create a Topic Client here
    ```

1. To create a topic client, replace that line of code with the following code.

    ```C#
    topicClient = new TopicClient(ServiceBusConnectionString, TopicName);
    ```

1. Within the `try...catch` block, locate the following line of code.

    ```C#
    // Create and send a message here
    ```

1. To create and format a message for the queue, replace that line of code with the following code.

    ```C#
    string messageBody = $"Total sales for Brazil in August: $13m.";
    var message = new Message(Encoding.UTF8.GetBytes(messageBody));
    ```

1. To display the message in the console, on the next line, add the following code.

    ```C#
    Console.WriteLine($"Sending message: {messageBody}");
    ```

1. To send the message to the queue, on the next line, add the following code.

    ```C#
    await topicClient.SendAsync(message);
    ```

1. Locate the following line of code.

    ```C#
    // Close the connection to the topic here
    ```

1. To close the connection to Service Bus, replace that line of code with the following code.

    ```C#
    await topicClient.CloseAsync();
    ```

1. Your final code should resemble the following example:

    ```C#
    using System;
    using System.Text;
    using System.Threading;
    using System.Threading.Tasks;
    using Microsoft.Azure.ServiceBus;
    
    namespace performancemessagesender
    {
        class Program
        {
            const string ServiceBusConnectionString = "Endpoint=sb://example.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=AbCdEfGhIjKlMnOpQrStUvWxYz==";
            const string TopicName = "salesperformancemessages";
            static ITopicClient topicClient;
    
            static void Main(string[] args)
            {
                Console.WriteLine("Sending a message to the Sales Performance topic...");
                SendPerformanceMessageAsync().GetAwaiter().GetResult();
                Console.WriteLine("Message was sent successfully.");
            }
    
            static async Task SendPerformanceMessageAsync()
            {
                topicClient = new TopicClient(ServiceBusConnectionString, TopicName);
    
                try
                {
                    string messageBody = $"Total sales for Brazil in August: $13m.";
                    var message = new Message(Encoding.UTF8.GetBytes(messageBody));
                    Console.WriteLine($"Sending message: {messageBody}");
                    await topicClient.SendAsync(message);
                }
                catch (Exception exception)
                {
                    Console.WriteLine($"{DateTime.Now} :: Exception: {exception.Message}");
                }
    
                await topicClient.CloseAsync();
            }
        }
    }
    ```

1. Save the file either through the "..." menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

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

    If you replace `Americas`with `EuropeAndAfrica`, you should see that both subscriptions have the same number of messages.

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
    // Create a subscription client here
    ```

1. To create a subscription client, replace that line with the following code.

    ```C#
    subscriptionClient = new SubscriptionClient(ServiceBusConnectionString, TopicName, SubscriptionName);
    ```

1. Locate the following line of code:

    ```C#
    // Close the subscription here
    ```

1. To close the connection to Service Bus, replace that code with the following code:

    ```C#
    await subscriptionClient.CloseAsync();
    ```

1. Locate the `RegisterMessageHandler()` method.

1. To configure message handling options, replace all the code within that method with the following code.

    ```C#
    var messageHandlerOptions = new MessageHandlerOptions(ExceptionReceivedHandler)
    {
        MaxConcurrentCalls = 1,
        AutoComplete = false
    };
    ```

1. To register the message handler, on the next line, add the following code.

    ```C#
    subscriptionClient.RegisterMessageHandler(ProcessMessagesAsync, messageHandlerOptions);
    ```

1. Locate the `ProcessMessagesAsync()` method. You have registered this method to handle incoming messages.

1. To display incoming messages in the console, replace all the code within that method with the following code.

    ```C#
    Console.WriteLine($"Received sale performance message: SequenceNumber:{message.SystemProperties.SequenceNumber} Body:{Encoding.UTF8.GetString(message.Body)}");
    ```

1. To remove the received message from the subscription, on the next line, add the following code.

    ```C#
    await subscriptionClient.CompleteAsync(message.SystemProperties.LockToken);
    ```

1. Your final code should resemble the following example.

    ```C#
    using System;
    using System.Text;
    using System.Threading;
    using System.Threading.Tasks;
    using Microsoft.Azure.ServiceBus;
    
    namespace performancemessagereceiver
    {
        class Program
        {
            const string ServiceBusConnectionString = "Endpoint=sb://alexgeddyneil.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=LIWIyxs8baqQ0bRf5zJLef6OTfrv0kBEDxFM/ML37Zs=";
            const string TopicName = "salesperformancemessages";
            const string SubscriptionName = "Americas";
            static ISubscriptionClient subscriptionClient;
    
            static void Main(string[] args)
            {
                MainAsync().GetAwaiter().GetResult();
            }
    
            static async Task MainAsync()
            {
                subscriptionClient = new SubscriptionClient(ServiceBusConnectionString, TopicName, SubscriptionName);
    
                Console.WriteLine("======================================================");
                Console.WriteLine("Press ENTER key to exit after receiving all the messages.");
                Console.WriteLine("======================================================");
    
                RegisterMessageHandler();
    
                Console.Read();
    
                await subscriptionClient.CloseAsync();
            }
    
            static void RegisterMessageHandler()
            {
                var messageHandlerOptions = new MessageHandlerOptions(ExceptionReceivedHandler)
                {
                    MaxConcurrentCalls = 1,
                    AutoComplete = false
                };
                subscriptionClient.RegisterMessageHandler(ProcessMessagesAsync, messageHandlerOptions);
            }
    
            static async Task ProcessMessagesAsync(Message message, CancellationToken token)
            {
                Console.WriteLine($"Received sale performance message: SequenceNumber:{message.SystemProperties.SequenceNumber} Body:{Encoding.UTF8.GetString(message.Body)}");
                await subscriptionClient.CompleteAsync(message.SystemProperties.LockToken);
            }
    
            static Task ExceptionReceivedHandler(ExceptionReceivedEventArgs exceptionReceivedEventArgs)
            {
                Console.WriteLine($"Message handler encountered an exception {exceptionReceivedEventArgs.Exception}.");
                var context = exceptionReceivedEventArgs.ExceptionReceivedContext;
                Console.WriteLine("Exception context for troubleshooting:");
                Console.WriteLine($"- Endpoint: {context.Endpoint}");
                Console.WriteLine($"- Entity Path: {context.EntityPath}");
                Console.WriteLine($"- Executing Action: {context.Action}");
                return Task.CompletedTask;
            }  
        }
    }
    ```

1. Save the file either through the "..." menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

## Retrieve a message from a topic subscription

1. To run the component that retrieves a message about sales performance, run the following command.

    ```bash
    dotnet run -p performancemessagereceiver
    ```

1. When the program has printed notifications that it is receiving messages, press <kbd>Enter</kbd> to stop the app. Then, run the following command to confirm that there are zero remaining messages in the `Americas` subscription. Be sure to replace \<namespace-name\> with your Service Bus Namespace.

    ```azurecli
    az servicebus topic subscription show \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --namespace-name <namespace-name> \
        --topic-name salesperformancemessages \
        --name Americas \
        --query messageCount
    ```

1. If you replace `Americas` with `EuropeAndAfrica`, you'll see that the message count has not changed. The application only received messages from the `Americas` subscription.
