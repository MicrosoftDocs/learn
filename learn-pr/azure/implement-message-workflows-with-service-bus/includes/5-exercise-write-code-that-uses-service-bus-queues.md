You've chosen to use a Service Bus queue to exchange messages about individual sales between the mobile app that your sales personnel use and the web service, hosted in Azure, that will store details about each sale in an Azure SQL Database instance.

You've already implemented the necessary objects in your Azure subscription. Now, you want to write code that sends messages to that queue and retrieves messages.

## Clone and open the starter application

In this unit, you'll build two console applications. The first application places messages into a Service Bus queue and the second retrieves them. The applications are part of a single .NET Core solution.

1. Start by cloning the solution. Run the following commands in the Cloud Shell.

```bash
cd ~
git clone https://github.com/MicrosoftDocs/mslearn-connect-services-together.git
```

1. Next, change directories into the starter folder, and open the Cloud Shell editor.

```bash
cd mslearn-connect-services-together/implement-message-workflows-with-service-bus/src/start
code .
```

## Configure a connection string to a Service Bus namespace

To access a Service Bus namespace and use a queue, you must configure two pieces of information in your console apps:

* Endpoint for your namespace
* Shared access key for authentication

Both of these values can be obtained from the Azure portal in the form of a complete connection string.

> [!NOTE]
> For simplicity, you will hard-code the connection string in the **Program.cs** file of both console applications. In a production application, you might use a configuration file or even Azure Key Vault to store the connection string.

1. Run the following command in the Cloud Shell to display the primary connection string for your Service Bus namespace. Replace `<namespace-name>` with the name of your Service Bus namespace.

    ```azurecli
    az servicebus namespace authorization-rule keys list \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name RootManageSharedAccessKey \
        --query primaryConnectionString \
        --output tsv \
        --namespace-name <namespace-name>
    ```

    You'll need this connection string multiple times throughout this module, so you might want to paste it somewhere handy.

1. Copy the key from Cloud Shell. In the editor, open **privatemessagesender/Program.cs** and locate the following line of code:

    ```C#
    const string ServiceBusConnectionString = "";
    ```

    Paste the connection string between the quotation marks. Save the file using the <kbd>Ctrl+S</kbd> keys.

1. Repeat the previous step in **privatemessagereceiver/Program.cs**, pasting in the same connection string value. Save the file either through the "..." menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

## Write code that sends a message to the queue

To complete the component that sends messages about sales, follow these steps:

1. Open **privatemessagesender/Program.cs** in the editor.

1. Locate the `SendSalesMessageAsync()` method.

1. Within that method, locate the following line of code:

    ```C#
    // Create a queue client here
    ```

1. To create a queue client, replace that line of code with the following code:

    ```C#
    queueClient = new QueueClient(ServiceBusConnectionString, QueueName);
    ```

1. Within the `try...catch` block, locate the following line of code:

    ```C#
    // Create and send a message here
    ```

1. To create and format a message for the queue, replace that line of code with the following code:

    ```C#
    string messageBody = $"$10,000 order for bicycle parts from retailer Adventure Works.";
    var message = new Message(Encoding.UTF8.GetBytes(messageBody));
    ```

1. To display the message in the console, on the next line, add the following code:

    ```C#
    Console.WriteLine($"Sending message: {messageBody}");
    ```

1. To send the message to the queue, on the next line, add the following code:

    ```C#
    await queueClient.SendAsync(message);
    ```

1. Locate the following line of code:

    ```C#
    // Close the connection to the queue here
    ```

1. To close the connection to the Service Bus, replace that line of code with the following code:

    ```C#
    await queueClient.CloseAsync();
    ```

1. Save the file.

## Send a message to the queue

To run the component that sends a message about a sale, run the following command in the Cloud Shell:

```bash
dotnet run -p privatemessagesender
```

> [!NOTE]
> The apps you run during this exercise may take a moment to start up, as `dotnet` has to restore packages from remote sources and build the apps the first time they are run.

As the program executes, you'll see messages printed indicating that it's sending a message. Each time you run the app, one additional message will be added to the queue.

Once it's finished, run the following command to see how many messages are in the queue:

```azurecli
az servicebus queue show \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name salesmessages \
    --query messageCount \
    --namespace-name <namespace-name>
```

## Write code that receives a message from the queue

1. Open **privatemessagereceiver/Program.cs** in the editor

1. Locate the `ReceiveSalesMessageAsync()` method.

1. Within that method, locate the following line of code:

    ```C#
    // Create a queue client here
    ```

1. To create a queue client, replace that line with the following code:

    ```C#
    queueClient = new QueueClient(ServiceBusConnectionString, QueueName);
    ```

1. Locate the `RegisterMessageHandler()` method.

1. To configure message handling options, replace all the code within that method with the following code:

    ```C#
    var messageHandlerOptions = new MessageHandlerOptions(ExceptionReceivedHandler)
    {
        MaxConcurrentCalls = 1,
        AutoComplete = false
    };
    ```

1. To register the message handler, on the next line, add the following code:

    ```C#
    queueClient.RegisterMessageHandler(ProcessMessagesAsync, messageHandlerOptions);
    ```

1. Locate the `ProcessMessagesAsync()` method. You have registered this method as the one that handles incoming messages.

1. To display incoming messages in the console, replace all the code within that method with the following code:

    ```C#
    Console.WriteLine($"Received message: SequenceNumber:{message.SystemProperties.SequenceNumber} Body:{Encoding.UTF8.GetString(message.Body)}");
    ```

1. To remove the received message from the queue, on the next line, add the following code:

    ```C#
    await queueClient.CompleteAsync(message.SystemProperties.LockToken);
    ```

1. Return to the `ReceiveSalesMessageAsync()` method and locate the following line of code:

    ```C#
    // Close the queue here
    ```

1. To close the connection to Service Bus, replace that line with the following code:

    ```C#
    await queueClient.CloseAsync();
    ```

1. Save the file.

## Retrieve a message from the queue

To run the component that receives a message about a sale, run this command in the Cloud Shell:

```bash
dotnet run -p privatemessagereceiver
```

When you see that the message has been received and displayed in the console, press `Enter` to stop the app. Then, run the same command as before to confirm that all of the messages have been removed from the queue:

```azurecli
az servicebus queue show \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name salesmessages \
    --query messageCount \
    --namespace-name <namespace-name>
```

This will show `0` if all the messages have been removed.

You have written code that sends a message about individual sales to a Service Bus queue. In the sales force distributed application, you should write this code in the mobile app that sales personnel use on devices.

You have also written code that receives a message from the Service Bus queue. In the sales force distributed application, you should write this code in the web service that runs in Azure and processes received messages.
