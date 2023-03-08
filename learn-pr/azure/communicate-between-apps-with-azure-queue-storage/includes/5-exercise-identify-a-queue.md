Let's create a client application to work with a queue. Then we'll add our connection string to the code, create a `QueueClient` object and create the queue.

> [!NOTE]
> You can create the client application on your local computer if you have .NET Core installed, or directly in the Cloud Shell environment.

## Clone and open the starter application

In this unit, you'll build a console application to interact with Azure storage queue that will send and receive messages to a queue. The GitHub repository associated with this module contains a starter version of the application you will be building.

1. Start by cloning the solution. In Azure Cloud Shell, run the following command.

    ```bash
    cd ~
    git clone https://github.com/MicrosoftDocs/mslearn-communicate-with-storage-queues.git
    ```

1. Next, change directories into the starter folder, and open Cloud Shell editor.

    ```bash
    cd ~/mslearn-communicate-with-storage-queues/start
    code .
    ```

## Azure.Storage.Queues NuGet package

To access storage queues from a .NET application, the Azure SDK for .NET provides the `Azure.Storage.Queues` package on NuGet.

The [Azure.Storage.Queues](https://www.nuget.org/packages/Azure.Storage.Queues/) package is already installed in the starter application.  To use Azure Storage Queues from one of your applications, install this package from NuGet.

## Get your connection string

Your application needs a connection string to be able to connect to your storage queue in Azure. The connection string is available in the Azure portal under the **Settings > Access keys** section of the storage account summary page or it can be retrieved using the Azure CLI or Azure PowerShell.

The following code uses the Azure CLI to retrieve the storage connection string and place it in an environment variable. The application will then read this environment variable to get the connection string and connect to the storage queue. Be sure to substitute in the name of your storage account in the command below.

```bash
export MY_STORAGE_CONNECTION_STRING=`az storage account show-connection-string -g <rgn>[sandbox resource group name]</rgn> -n <storage account name> --output tsv`
```

You can verify that you have a connection string set in your environment variable by running the following command to view the connection string:

```bash
echo $MY_STORAGE_CONNECTION_STRING
```

## Add code to create a QueueClient

The `QueueClient` class manages the interactions with a storage queue. The `QueueClient` class can be used to create a queue as well as sending and receive messages from the queue.

To create a `QueueClient` object, you need both the storage connection string and the name of the queue your application will use. In this sample application, the connection string will be read from an environment variable.

1. Type `code .` in the terminal to open the online code editor. Alternatively, if you are working on your own you can use the IDE of your choice.

1. Open the `Program.cs` file in your code editor.

1. At the beginning of the main method, add the following code.

    ```csharp
    string connectionString = Environment.GetEnvironmentVariable("MY_STORAGE_CONNECTION_STRING");
    QueueClient queueClient = new QueueClient(connectionString, "newsqueue");
    ```

## Create your storage account queue

Before you can send or receive messages from your queue, you need to create the queue itself.  The queue can be created from the Azure portal, Azure CLI, Azure PowerShell or in code.  For our example application, we are going to create the queue from code.

The `CreateIfNotExistsAsync` method on the `QueueClient` class is used to create a queue.  This method will first check to see if the named queue for the `QueueClient` object exists and if not, create it.

Add the following line of code to the main method of your `Program.cs` file just after the line that creates the `QueueClient` object
The `QueueClient` contains a method `CreateIfNotExistsAsync`

```csharp
await queueClient.CreateIfNotExistsAsync();
```

The full main method should now look like this:

```csharp
static async Task Main(string[] args)
{
    // Add code to create QueueClient and Storage Queue Here
    string connectionString = Environment.GetEnvironmentVariable("MY_STORAGE_CONNECTION_STRING");
    QueueClient queueClient = new QueueClient(connectionString, "newsqueue");
    await queueClient.CreateIfNotExistsAsync();

    bool exitProgram = false;
    while (exitProgram == false)
    {
        Console.WriteLine("What operation would you like to perform?");
        Console.WriteLine("  1 - Send message");
        Console.WriteLine("  2 - Peek at the next message");
        Console.WriteLine("  3 - Receive message");
        Console.WriteLine("  X - Exit program");

        ConsoleKeyInfo option = Console.ReadKey();
        Console.WriteLine();  // ReadKey does not got the the next line, so this does
        Console.WriteLine();  // Provide some whitespace between the menu and the action

        if (option.KeyChar == '1')
            await SendMessageAsync(queueClient);
        else if (option.KeyChar == '2')
            await PeekMessageAsync(queueClient);
        else if (option.KeyChar == '3')
            await ReceiveMessageAsync(queueClient);
        else if (option.KeyChar == 'X')
            exitProgram = true;
        else
            Console.WriteLine("invalid choice");
    }
}
```

Now that the application is connecting to Azure and creating a storage queue, we can work on implementing code to send and receive messages from the queue next.
