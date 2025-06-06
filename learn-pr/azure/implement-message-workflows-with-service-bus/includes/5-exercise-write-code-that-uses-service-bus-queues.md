You've chosen to use a Service Bus queue to handle messages about individual sales between the mobile app, which your sales personnel use, and the web service hosted in Azure, which stores details about each sale in an Azure SQL Database instance.

In the previous exercise, you implemented the necessary objects in your Azure subscription. Now, you want to write code that sends messages to that queue and retrieves messages.

In this unit, you build two console applications: one application places messages into a Service Bus queue, and one application retrieves messages from a Service Bus queue. The applications are part of a single .NET Core solution.

## Prerequisites
You must have the following prerequisites installed on your computer:

- [GitBash](https://git-scm.com/downloads).
- [Visual Studio Code](https://code.visualstudio.com/) installed on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms)
- The [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) for Visual Studio Code.

## Clone and open the starter application

> [!NOTE]
> For simplicity, the following tasks instruct you to hard-code the connection string in the *Program.cs* file of both console applications. In a production application, you should use role-based access control authentication supported by Azure Service Bus. 

1. Launch GitBash on your computer. 
1. Run the following command to clone the Git project solution:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-connect-services-together.git
    ```
1. Launch VS Code on your computer. 
1. Select **File** -> **Open Folder ...**, and then select the folder: C:\Program Files\Git\mslearn-connect-services-together\implement-message-workflows-with-service-bus\src (assuming that C:\Program Files\Git is the Git folder). You should see **final** and **start** subfolders. You work with code in the **start** folder to write code to send and receive messages. The **final** folder contains the code that's complete. 


## Write code to send a message to a queue

1. In the Code Explorer window to the left, expand **privatemessagesender**. 
1. Open **Program.cs**, and locate the following line of code:

    ```csharp
    const string ServiceBusConnectionString = "";
    ```

   Paste the connection string between the quotation marks.
1. If you used a name different from `salesmessages` for the queue name, update the value for `QueueName` property in the code:

    ```csharp
    const string QueueName = "salesmessages";
    ```
1. To complete the component that sends messages about sales, you must add an `await` operator to suspend evaluation of the async method until the asynchronous operation completes. Find the `SendSalesMessageAsync()` method. Within that method, locate the following line of code:

    ```csharp
    // Create a Service Bus client here
    ```

   Replace that line of code with the following code:

    ```csharp
    // By leveraging "await using", the DisposeAsync method will be called automatically once the client variable goes out of scope. 
    // In more realistic scenarios, you would want to store off a class reference to the client (rather than a local variable) so that it can be used throughout your program.
    
    await using var client = new ServiceBusClient(ServiceBusConnectionString);
    ```  
1. Within the `SendSalesMessageAsync()` method, find the following line of code:

    ```csharp
    // Create a sender here
    ```

   Replace that comment with the following code:

    ```csharp
    await using ServiceBusSender sender = client.CreateSender(QueueName);
    ```
1. Within the `try...catch` block, find the following line of code:

    ```csharp
    // Create and send a message here
    ```

   Replace that line of code with the following lines of code:

    ```csharp
    string messageBody = $"$10,000 order for bicycle parts from retailer Adventure Works.";
    var message = new ServiceBusMessage(messageBody);
    ```
1. Insert the following code on a new line directly below what you just added to display the message in the console:

    ```csharp
    Console.WriteLine($"Sending message: {messageBody}");
    ```
1. Insert the following code on the next line:

    ```csharp
    await sender.SendMessageAsync(message);
    ```
1. To dispose sender and client objects, near the end of the file, find the following comment:

    ```csharp
    // Close the connection to the sender here
    ```

   Replace that line with the following code:

    ```csharp
    finally
    {
        // Calling DisposeAsync on client types is required to ensure that network
        // resources and other unmanaged objects are properly cleaned up.
        await sender.DisposeAsync();
        await client.DisposeAsync();
    }
    ```  
1. Check that your final code for **Program.cs** resembles the following example:

    ```csharp
    using System;
    using System.Text;
    using System.Threading.Tasks;
    using Azure.Messaging.ServiceBus;
    
    namespace privatemessagesender
    {
        class Program
        {
            const string ServiceBusConnectionString = "Endpoint=sb://example.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=xxxxxx";
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
                finally
                {
                    // Calling DisposeAsync on client types is required to ensure that network
                    // resources and other unmanaged objects are properly cleaned up.
                    await sender.DisposeAsync();
                    await client.DisposeAsync();
                }
            }
        }
    }
    ```

1. To save your changes, select **File** -> **Save** on the menu or enter <kbd>Ctrl+S</kbd>.

## Send a message to the queue

1. In the Code Explorer, right-click **privatemessagesender**, and then select **Open in Integrated Terminal**. 
1. In the terminal pane, at the command prompt, confirm that you are in the **privatemessagesender** folder, and then enter the following command: `dotnet build`.  
1. Now, run the application by running the following command: `dotnet run`. As the program runs, messages are printed to the console indicating that the app is sending a message:
  
    ```output
    Sending a message to the Sales Messages queue...
    Sending message: $10,000 order for bicycle parts from retailer Adventure Works.
    Message was sent successfully.    ```
  
## Write code to receive messages from the queue

1. In the Code Explorer page, expand **privatemessagereceiver**. 
1. Open **Program.cs**, and find the following line of code:

    ```csharp
    const string ServiceBusConnectionString = "";
    ```

   Between the quotation marks, paste the connection string that you saved earlier.
1. Find the `ReceiveSalesMessageAsync()` method. Within that method, locate the following line of code:

    ```csharp
    // Create a Service Bus client that will authenticate using a connection string
    ```

   Replace that line with the following code:

    ```csharp
    var client = new ServiceBusClient(ServiceBusConnectionString);
    ```
1. To configure message handling options, find the following line of code:

    ```csharp
    // Create the options to use for configuring the processor
    ```

   Replace that line with the following lines of code:

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

   Replace that line with the following code:

    ```csharp
    await using ServiceBusProcessor processor = client.CreateProcessor(QueueName, processorOptions);
    ```
1. To configure the handlers, find the following line of code:

    ```csharp
    // Configure the message and error handler to use
    ```

   Replace that line with the following code:

    ```csharp
    processor.ProcessMessageAsync += MessageHandler;
    processor.ProcessErrorAsync += ErrorHandler;
    ```
1. To start processing, find the following line of code:

    ```csharp
    // Start processing
    ```

   Replace that line with the following code:

    ```csharp
    await processor.StartProcessingAsync();
    ```
1. To close the connection to Service Bus, find the following line of code:

    ```csharp
    // Close the processor here
    ```

   Replace that line with the following code:

    ```csharp
    await processor.CloseAsync();
    ```
1. Review code in the `MessageHandler` method:

    ```csharp
    // handle received messages
    static async Task MessageHandler(ProcessMessageEventArgs args)
    {
        // extract the message
        string body = args.Message.Body.ToString();
        
        // print the message
        Console.WriteLine($"Received: {body}");

        // complete the message so that message is deleted from the queue. 
        await args.CompleteMessageAsync(args.Message);
    }
    ```
1. Review code in the `ErrorHandler` method:

    ```csharp
    // handle any errors when receiving messages
    static Task ErrorHandler(ProcessErrorEventArgs args)
    {
        // print the exception message
        Console.WriteLine(args.Exception.ToString());
        return Task.CompletedTask;
    }    
    ```
1. Check that your final code for *privatemessagereceiver/Program.cs* resembles the following example:

    ```csharp
    using System;
    using System.Text;
    using System.Threading.Tasks;
    using Azure.Messaging.ServiceBus;

    namespace privatemessagereceiver
    {
        class Program
        {

            const string ServiceBusConnectionString = "Endpoint=sb://<examplenamespace.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
            const string QueueName = "salesmessages";

            static void Main(string[] args)
            {

                ReceiveSalesMessageAsync().GetAwaiter().GetResult();

            }

            static async Task ReceiveSalesMessageAsync()
            {

                Console.WriteLine("======================================================");
                Console.WriteLine("Press ENTER key to exit after receiving all the messages.");
                Console.WriteLine("======================================================");


                var client = new ServiceBusClient(ServiceBusConnectionString);

                var processorOptions = new ServiceBusProcessorOptions
                {
                    MaxConcurrentCalls = 1,
                    AutoCompleteMessages = false
                };

                await using ServiceBusProcessor processor = client.CreateProcessor(QueueName, processorOptions);

                processor.ProcessMessageAsync += MessageHandler;
                processor.ProcessErrorAsync += ErrorHandler;


                await processor.StartProcessingAsync();

                Console.Read();

                await processor.CloseAsync();

            }

            // handle received messages
            static async Task MessageHandler(ProcessMessageEventArgs args)
            {
                string body = args.Message.Body.ToString();
                Console.WriteLine($"Received: {body}");

                // complete the message. messages is deleted from the queue. 
                await args.CompleteMessageAsync(args.Message);
            }

            // handle any errors when receiving messages
            static Task ErrorHandler(ProcessErrorEventArgs args)
            {
                Console.WriteLine(args.Exception.ToString());
                return Task.CompletedTask;
            }
        }
    }
    
    ```
1. To save your changes, select **File** -> **Save** on the menu, or enter <kbd>Ctrl+S</kbd>.

## Receive a message from the queue

1. In the Code Explorer, right-click **privatemessagereceiver**, and then select **Open in Integrated Terminal**. 
1. In the terminal pane, at the command prompt, confirm that you are in the **privatemessagereceiver** folder, and then enter the following command: `dotnet build`.  
1. Now, run the application by running the following command: `dotnet run`. 

    ```output
    ======================================================
    Press ENTER key to exit after receiving all the messages.
    ======================================================
    Received: $10,000 order for bicycle parts from retailer Adventure Works.
    ```
1. When you see that the messages have been received in the Cloud Shell, <kbd>ENTER</kbd> to stop the app.

You've written code that sends a message about individual sales to a Service Bus queue. In the salesforce distributed application, you should write this code in the mobile app that sales personnel use on devices.

You've also written code that receives a message from the Service Bus queue. In the salesforce distributed application, you should write this code in the web service that runs in Azure and processes received messages.
