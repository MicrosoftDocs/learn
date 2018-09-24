Let's create a client application to work with a queue. Then we'll add our connection string to the code.

> [!NOTE]
> You can create the client application on your local computer if you have .NET Core installed, or directly in the Cloud Shell environment.

## Create the application

We'll create a .NET Core application that you can run on Linux, macOS, or Windows. Let's name it **QueueApp**. For simplicity, we'll use a single app that will both send and receive messages through our queue.

1. Use the `dotnet new` command to create a new console app with the name **QueueApp**. You can type commands into the Cloud Shell on the right, or if you are working locally, in a terminal/console window. This command creates a simple app with a single source file: `Program.cs`.

    ```azurecli
    dotnet new console -n QueueApp
    ```

1. Switch to the newly created `QueueApp` folder and build the app to verify that all is well.

    ```azurecli
    cd QueueApp
    ```

    ```azurecli
    dotnet build
    ```

## Get your connection string

Recall that your connection string is available in the Azure portal **Settings > Access keys** section of your storage account.

You can also retrieve it through the Azure CLI or PowerShell tools. Let's use the Azure CLI command. Remember to replace the `<name>` with the specific name of the storage account you created. You can use `az storage account list` if you need a reminder.

```azurecli
az storage account show-connection-string --name <name> --resource-group <rgn>[sandbox resource group name]</rgn>
```

This command will return a JSON block with your connection string. It will include the storage account name and the account key:

```json
{
  "connectionString": "DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=<name>;AccountKey=vyw6aKz2PtSAgQ4ljJQgJFgxbCETdXt39ZyYQ5fLqoBJj/gT+43TbrhoVco7Rqj/AAJVlvFORRfnYqGHiX9QcQ=="
}
```

## Add the connection string to the application

Finally, let's add the connection string into our app so it can access the storage account.

> [!WARNING]
> For simplicity, you will place the connection string in the **Program.cs** file. In a production application, you should store it in a secure location. For server side use, we recommend using Azure Key Vault.

1. Type `code .` in the terminal to open the online code editor. Alternatively, if you are working on your own you can use the IDE of your choice. We recommend Visual Studio Code, which is an excellent cross-platform IDE.

1. Open the `Program.cs` source file in the project.

1. In the `Program` class, add a `const string` value to hold the connection string. You only need the value (it starts with the text **DefaultEndpointsProtocol**).

1. Save the file. You can click the ellipse "..." in the right corner of the cloud editor, or use the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

Your code should look something like this (the string value will be unique to your account).

```csharp
...
namespace QueueApp
{
    class Program
    {
        private const string ConnectionString = "DefaultEndpointsProtocol=https; ...";
        
        ...
    }
}
```

Now that we have this starter project setup, let's look at how to work with a queue in code. It all starts with _messages_.