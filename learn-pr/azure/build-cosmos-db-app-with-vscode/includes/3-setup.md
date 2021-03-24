Visual Studio Code enables you to create a console application by using the integrated terminal and a few short commands.

In this unit, you will create a basic console app using the integrated terminal, retrieve your Azure Cosmos DB connection string from the extension, and then configure the connection from your application to Azure Cosmos DB.

## Create a console app

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a new folder named `learning-module` in the location of your choice, and then select **Select Folder**.

1. Ensure that file auto-save is enabled by selecting the File menu and checking **Auto Save** if it is blank. You will be copying in several blocks of code, and this will ensure you are always operating against the latest edits of your files.

1. Open the integrated terminal from Visual Studio Code by selecting **View** > **Terminal** from the main menu.

1. In the terminal window, copy and paste the following command.

    ```bash
    dotnet new console
    ```

    This command creates a **Program.cs** file in your folder with a basic "Hello World" program already written, along with a C# project file named **learning-module.csproj**.

1. In the terminal window, copy and paste the following command to run the "Hello World" program.

    ```bash
    dotnet run
    ```

    The terminal window displays "Hello world!" as output.

## Connect the app to Azure Cosmos DB

1. At the terminal prompt, copy and paste the following command block to install the required NuGet packages.

    ```bash
    dotnet add package System.Net.Http
    dotnet add package System.Configuration
    dotnet add package System.Configuration.ConfigurationManager
    dotnet add package Microsoft.Azure.DocumentDB.Core
    dotnet add package Newtonsoft.Json
    dotnet add package System.Threading.Tasks
    dotnet add package System.Linq
    dotnet restore
    ```

1. At the top of the Explorer pane, select **Program.cs** to open the file.

> [!NOTE] 
>  If you do not show the **Program.cs** in Explorer pane, click file > open file > and open it from file explorer.  


1. Add the following using statements after `using System;`.

    ```csharp
    using System.Configuration;
    using System.Linq;
    using System.Threading.Tasks;
    using System.Net;
    using Microsoft.Azure.Documents;
    using Microsoft.Azure.Documents.Client;
    using Newtonsoft.Json;
    ```

1. If you get a message about adding required missing assets, select **Yes**.

1. Create a new file named App.config in the `learning-module` folder, and add the following code.

    ```xml
    <?xml version="1.0" encoding="utf-8"?>
        <configuration>
          <appSettings>
            <add key="accountEndpoint" value="<replace with your Account Endpoint URL>" />
            <add key="accountKey" value="<replace with your Account Key>" />
          </appSettings>
    </configuration>
    ```

1. Copy your connection string by selecting the Azure icon on the left, expanding your Concierge Subscription, right-clicking your new Azure Cosmos DB account, and then selecting **Copy Connection String**.

1. Paste the connection string into the end of the App.config file, and then copy the **AccountEndpoint** portion from the connection string into the **accountEndpoint** value in App.config.

    The **accountEndpoint** should look like the following:

    ```xml
    <add key="accountEndpoint" value="https://<account-name>.documents.azure.com:443/" />
    ```

    Your final App.config file looks similar to this.

    ```xml
    <?xml version="1.0" encoding="utf-8"?>
        <configuration>
          <appSettings>
            <add key="accountEndpoint" value="https://my-account.documents.azure.com:443/" />
            <add key="accountKey" value="6e7sRxunccGEeO7IVlMdeFt5BdsllfSGLYc28KyjzkESiCu7tfWbTaZXAErt2v88gOcMbOYgwp1q4NYDifD7ew==" />
          </appSettings>
    </configuration>
    ```

1. At the terminal prompt, copy and paste the following command to run the program.

    ```bash
    dotnet run
    ```

    The program displays Hello World! in the terminal.

## Create the DocumentClient

Now it's time to create an instance of the `DocumentClient`, which is the client-side representation of the Azure Cosmos DB service. This client is used to configure and execute requests against the service.

1. In Program.cs, add the following to the beginning of the `Program` class.

    ```csharp
    private DocumentClient client;
    ```

1. Add a new asynchronous task to create a new client, and check whether the **Users** database exists by adding the following method after the `Main` method.

    ```csharp
    private async Task BasicOperations()
    {
        this.client = new DocumentClient(new Uri(ConfigurationManager.AppSettings["accountEndpoint"]), ConfigurationManager.AppSettings["accountKey"]);

        await this.client.CreateDatabaseIfNotExistsAsync(new Database { Id = "Users" });

        await this.client.CreateDocumentCollectionIfNotExistsAsync(UriFactory.CreateDatabaseUri("Users"), new DocumentCollection { Id = "WebCustomers" });

        Console.WriteLine("Database and collection validation complete");
    }
    ```

1. In the integrated terminal, again, copy and paste the following command to run the program to ensure it runs.

    ```bash
    dotnet run
    ```

1. Copy and paste the following code into the **Main** method, overwriting the current `Console.WriteLine("Hello World!");` line.

    ```csharp
    try
    {
        Program p = new Program();
        p.BasicOperations().Wait();
    }
    catch (DocumentClientException de)
    {
        Exception baseException = de.GetBaseException();
        Console.WriteLine("{0} error occurred: {1}, Message: {2}", de.StatusCode, de.Message, baseException.Message);
    }
    catch (Exception e)
    {
        Exception baseException = e.GetBaseException();
        Console.WriteLine("Error: {0}, Message: {1}", e.Message, baseException.Message);
    }
    finally
    {
        Console.WriteLine("End of demo, press any key to exit.");
        Console.ReadKey();
    }
    ```

1. In the integrated terminal, again, run the following command to ensure the program runs.

    ```bash
    dotnet run
    ```

    The console displays the following output.

    ```output
    Database and collection validation complete
    End of demo, press any key to exit.
    ```

In this unit, you set up the groundwork for your Azure Cosmos DB application. You set up your development environment in Visual Studio Code, created a basic "Hello World" project, connected the project to the Azure Cosmos DB endpoint, and ensured your database and collection exist.
