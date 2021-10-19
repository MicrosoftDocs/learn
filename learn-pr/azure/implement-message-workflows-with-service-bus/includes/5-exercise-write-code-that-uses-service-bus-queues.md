You've chosen to use a Service Bus queue to handle messages about individual sales between the mobile app, which  your sales personnel use and the web service hosted in Azure, which will store details about each sale in an Azure SQL Database instance.

You've already implemented the necessary objects in your Azure subscription. Now, you want to write code that sends messages to that queue and retrieves messages.

## Clone and open the starter application

In this unit, you'll build two console applications. The first application places messages into a Service Bus queue and the second application retrieves them. The applications are part of a single .NET Core solution.

1. Start by cloning the solution. In Azure Cloud Shell, run the following command.

    ```bash
    cd ~
    git clone https://github.com/MicrosoftDocs/mslearn-connect-services-together.git
    ```

1. Next, make the start folder your active directory, and then open Cloud Shell editor.

    ```bash
    cd ~/mslearn-connect-services-together/implement-message-workflows-with-service-bus/src/start
    code .
    ```

## Configure a connection string to a Service Bus namespace

To access a Service Bus namespace and use a queue within that namespace, you must configure two pieces of information in your console apps:

* Endpoint for your namespace
* Shared access key for authentication

Both of these values can be obtained from an Azure command that will return the complete connection string.

> [!NOTE]
> For simplicity, you will hard-code the connection string in the **Program.cs** file of both console applications. In a production application, you might use a configuration file or Azure Key Vault to store the connection string.

1. Run the following command in Cloud Shell to obtain the connection string for your Service Bus namespace. Replace `<namespace-name>` with the name of your Service Bus Namespace.

    ```azurecli
    az servicebus namespace authorization-rule keys list \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name RootManageSharedAccessKey \
        --query primaryConnectionString \
        --output tsv \
        --namespace-name <namespace-name>
    ```

    The last line in the response is the connection string, which includes the endpoint for your namespace and the shared access key. It should resemble the following example:

    ```
    Endpoint=sb://example.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=AbCdEfGhIjKlMnOpQrStUvWxYz==
    ```

1. Copy the connection string from Cloud Shell and save it. You'll need this connection string several times throughout this module, so you might want to paste it somewhere handy.

## Write code that sends a message to the queue

To complete the component that sends messages about sales:

1. In the editor, open **privatemessagesender/Program.cs** and locate the following line of code:

    ```C#
    const string ServiceBusConnectionString = "";
    ```

    Paste the connection string that you saved earlier between the quotation marks.

1. Locate the `SendSalesMessageAsync()` method. (Hint: it should be at or near line 23, `static async Task SendSalesMessageAsync()`.)

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
    Note that the editor automatically prepended **new** to the line of code you pasted.

1. Within that method, locate the following line of code.

    ```C#
    // Create a sender here
    ```
1. Replace that line of code with the following code.

    ```C#
    await using ServiceBusSender sender = client.CreateSender(QueueName);
    ```

1. Within the `try...catch` block, locate the following line of code.

    ```C#
    // Create and send a message here
    ```

1. Replace that line of code with the following lines of code.

    ```C#
    string messageBody = $"$10,000 order for bicycle parts from retailer Adventure Works.";
    var message = new ServiceBusMessage(Encoding.UTF8.GetBytes(messageBody));
    ```

1. Insert the following code on a new line directly below what you just added to display the message in the console.

    ```C#
    Console.WriteLine($"Sending message: {messageBody}");
    ```

1. Insert the following code on the next line to send the message to the queue.

    ```C#
    await sender.SendMessageAsync(message);
    ```
    
1. Your final code should resemble the following example:

    ```C#
    using System;
    using System.Text;
    using System.Threading.Tasks;
    using Azure.Messaging.ServiceBus;
    
    namespace privatemessagesender
    {
        class Program
        {
            const string ServiceBusConnectionString = "Endpoint=sb://example.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=AbCdEfGhIjKlMnOpQrStUvWxYz==";
            const string QueueName = "salesmessages";
    
            static void Main(string[] args)
            {
                Console.WriteLine("Sending a message to the Sales Messages queue...");
                SendSalesMessageAsync().GetAwaiter().GetResult();
                Console.WriteLine("Message was sent successfully.");
            }
    
            static async Task SendSalesMessageAsync()
            {
                await using var client = new ServiceBusClient(ServiceBusConnectionString);

                await using ServiceBusSender sender = client.CreateSender(QueueName);
                try
                {
                    string messageBody = $"$10,000 order for bicycle parts from retailer Adventure Works.";
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

1. Save the *Program.cs* file using either the **&#9776;** icon, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

## Send a message to the queue

1. To run the component that sends a message about a sale, run the following command in Cloud Shell.

    ```bash
    dotnet run -p ./privatemessagesender
    ```

    > [!NOTE]
    > The apps you run during this exercise may take a moment to start up; `dotnet` has to restore packages from remote sources and build the apps the first time they are run.

    As the program executes, you'll see messages printed indicating that it's sending a message. Each time you run the app, a new message will be added to the queue.

1. After it's finished, run the following command to see how many messages are in the queue. Replace \<namespace-name\> with the name of your Service Bus Namespace.

    ```azurecli
    az servicebus queue show \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name salesmessages \
        --query messageCount \
        --namespace-name <namespace-name>
    ```
    Run the dotnet command again, and then run the servicebus queue show command again. You'll see the messageCount increase each time you run the dotnet command.
    
## Write code that receives a message from the queue

1. In the editor, open **privatemessagereceiver/Program.cs** and locate the following line of code:

    ```C#
    const string ServiceBusConnectionString = "";
    ```

    Paste the connection string that you saved earlier between the quotation marks.

1. Locate the `ReceiveSalesMessageAsync()` method. (Hint, it should be on or near line 24.)

1. Within that method, locate the following line of code.

    ```C#
    // Create a Service Bus client that will authenticate using a connection string
    ```

1. To create a Service Bus client, replace that line with the following code.

    ```C#
    var client = new ServiceBusClient(ServiceBusConnectionString);
    ```

1. Locate the following line of code.

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
    await using ServiceBusProcessor processor = client.CreateProcessor(QueueName, processorOptions);
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

1. Locate the following line of code.

    ```C#
    // Close the processor here
    ```

1. To close the connection to Service Bus, replace that line with the following code:

    ```C#
    await processor.CloseAsync();
    ```

1. Locate the `ProcessMessagesAsync()` method. You have registered this method as the one that handles incoming messages.

1. To display incoming messages in the console, replace all the code within that method with the following code.

    ```C#
    Console.WriteLine($"Received message: SequenceNumber:{args.Message.SequenceNumber} Body:{args.Message.Body}");
    ```

1. To remove the received message from the queue, insert the following code on the next line.

    ```C#
    await args.CompleteMessageAsync(args.Message);
    ```

1. Your final code should resemble the following example.

    ```C#
    using System;
    using System.Text;
    using System.Threading.Tasks;
    using Azure.Messaging.ServiceBus;
    
    namespace privatemessagereceiver
    {
        class Program
        {
    
            const string ServiceBusConnectionString = "Endpoint=sb://example.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=AbCdEfGhIjKlMnOpQrStUvWxYz==";
            const string QueueName = "salesmessages";
    
            static void Main(string[] args)
            {
    
                ReceiveSalesMessageAsync().GetAwaiter().GetResult();
    
            }
    
            static async Task ReceiveSalesMessageAsync()
            {
                Console.WriteLine("======================================================");
                Console.WriteLine("Press ENTER on the keyboard to exit after receiving all the messages.");
                Console.WriteLine("======================================================");
    
                await using ServiceBusClient client = new ServiceBusClient(ServiceBusConnectionString);

                var processorOptions = new ServiceBusProcessorOptions
                {
                    MaxConcurrentCalls = 1,
                    AutoCompleteMessages = false
                };
                
                await using ServiceBusProcessor processor = client.CreateProcessor(QueueName, processorOptions);

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

1. Save the file either through the **&#9776;** menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

## Retrieve a message from the queue

1. To run the component that receives a message about a sale, run this command in Cloud Shell.

    ```bash
    dotnet run -p privatemessagereceiver
    ```

1. Check the notifications in Cloud Shell and in the Azure portal, navigate to your Service Bus Namespace and check your Messages chart. 

1. When you see that the messages have been received in the Cloud Shell, press <kbd>Enter</kbd> to stop the app. Then, run the following code to confirm that all of the messages have been removed from the queue. Remember to replace \<namespace-name\> with your Service Bus Namespace.

    ```azurecli
    az servicebus queue show \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name salesmessages \
        --query messageCount \
        --namespace-name <namespace-name>
    ```

    The output will be `0` if all the messages have been removed.

You have written code that sends a message about individual sales to a Service Bus queue. In the sales force distributed application, you should write this code in the mobile app that sales personnel use on devices.

You have also written code that receives a message from the Service Bus queue. In the sales force distributed application, you should write this code in the web service that runs in Azure and processes received messages.
