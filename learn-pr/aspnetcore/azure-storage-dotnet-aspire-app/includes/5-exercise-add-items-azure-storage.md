In this exercise, you'll use the .NET Aspire Azure Queue Storage component to send a message to a queue.

> [!NOTE]
> Visual Studio includes the Azurite emulator. In this lab, you'll use this tool to emulate an Azure Storage account on your local computer.

## Install prerequisites

The prerequisites for .NET Aspire are:

- .NET 8
- Visual Studio 2022 Preview
- Docker Desktop or Podman
- .NET Aspire workload in Visual Studio

If you've already got these packages installed, you can skip ahead to begin working with Azure Storage.

### Install .NET 8

Follow this [.NET 8](https://dotnet.microsoft.com/download/dotnet/8.0) link, and select the correct installer for your operating system. For example, if you're using Windows 11, and a modern processor, select the x64 .NET 8 SDK for Windows.

After the download is complete, run the installer and follow the instructions. In a terminal window, run the following command to verify that the installation was successful:

```powershell
dotnet --version
```

You should see the version number of the .NET SDK you installed. For example:

```console
8.0.300
```

### Install Visual Studio 2022 Preview

Follow this [Visual Studio 2022 Preview](https://visualstudio.microsoft.com/vs/preview/) link, and select **Download Preview**. After the download is complete, run the installer and follow the instructions.

### Install Docker Desktop

Follow this [Docker Desktop](https://www.docker.com/products/docker-desktop/) link, and select the correct installer for your operating system. After the download is complete, run the installer and follow the instructions. For the best performance and compatibility, use the WSL 2 backend.

Open the Docker Desktop application and accept the service agreement.

### Install the .NET Aspire workload in Visual Studio

Install the .NET Aspire workload using the .NET CLI:

1. Open a terminal.
1. Update .NET workloads with this command:

    ```dotnetcli
    dotnet workload update
    ```

    You should see a message that the workloads are updated successfully.

    ```console
    No workloads installed for this feature band. To update workloads installed with earlier SDK versions, include the --from-previous-sdk option.
    Updated advertising manifest microsoft.net.sdk.ios.
    Updated advertising manifest microsoft.net.workload.mono.toolchain.net6.
    Updated advertising manifest microsoft.net.sdk.android.
    Updated advertising manifest microsoft.net.workload.emscripten.net7.
    Updated advertising manifest microsoft.net.workload.emscripten.net6.
    Updated advertising manifest microsoft.net.sdk.macos.
    Updated advertising manifest microsoft.net.workload.emscripten.current.
    Updated advertising manifest microsoft.net.workload.mono.toolchain.current.
    Updated advertising manifest microsoft.net.sdk.maui.
    Updated advertising manifest microsoft.net.workload.mono.toolchain.net7.
    Updated advertising manifest microsoft.net.sdk.maccatalyst.
    Updated advertising manifest microsoft.net.sdk.tvos.
    Updated advertising manifest microsoft.net.sdk.aspire.
    No workloads installed for this feature band. To update workloads installed with earlier SDK versions, include the --from-previous-sdk option.
    
    Successfully updated workload(s): .
    ```

1. Install the .NET Aspire workload with this command:

    ```dotnetcli
    dotnet workload install aspire
    ```

    You should see a message that the .NET Aspire workload has been installed.

    ```console
    Installing Aspire.Hosting.Sdk.Msi.x64 ...... Done
    Installing Aspire.ProjectTemplates.Msi.x64 ..... Done
    Installing Aspire.Hosting.Orchestration.win-x64.Msi.x64 ............. Done
    Installing Aspire.Hosting.Msi.x64 ..... Done
    Installing Aspire.Dashboard.Sdk.win-x64.Msi.x64 ....... Done
    
    Successfully installed workload(s) aspire.
    ```

1. Verify that the .NET Aspire workload is installed with this command:

    ```dotnetcli
    dotnet workload list
    ```

    You should see the details of the .NET Aspire workload.

    ```console
    Installed Workload Id      Manifest Version      Installation Source
    --------------------------------------------------------------------
    aspire                     8.0.0/8.0.100         VS 17.11.34929.205

    Use `dotnet workload search` to find additional workloads to install.
    ```

## Clone project

Let's use `git` to obtain a sample app, which doesn't yet use Azure Storage:

1. In the command line, browse to a folder of your choice where you can work with code.
1. Execute the following command to clone the **Northern Mountains eShop** sample application:

    ```dotnetcli
    git clone -b aspire-azure-storage https://github.com/MicrosoftDocs/mslearn-aspire-starter
    ```

## Add the Azure Storage backing service

Next, let's add the Azure Storage components to the .NET Aspire app host project:

1. Start Visual Studio, and select **Open a project or solution**.
1. Navigate to the folder where you cloned the project.
1. Double-click the **start** folder, select the _eShop.azurestorage.sln_ solution, and then select **Open**.
1. In **Solution Explorer**, right-click the **eShop.AppHost** project, select **Add**, and then select **.NET Aspire package**.
1. In the search textbox, at the end of the existing text, type **Storage**.
1. Select **Aspire.Hosting.Azure.Storage** package.
1. In the **Version** list, select the latest **8.0.0** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In **Solution Explorer**, expand **eShop.AppHost** and then double-click _Program.cs_.
1. Locate the following code:

    ```csharp
    var builder = DistributedApplication.CreateBuilder(args);
    ```

1. Immediately after that code, to register a storage account and configure it use the local Azurite emulator, add this code:

    ```csharp
    var storage = builder.AddAzureStorage("storage");

    if (builder.Environment.IsDevelopment())
    {
        storage.RunAsEmulator();
    }

    var queues = storage.AddQueues("queueConnection");
    ```

1. Locate the following code, which registers the **Catalog.API** project for .NET Aspire orchestration:

    ```csharp
    var catalogApi = builder.AddProject<Catalog_API>("catalog-api")
        .WithReference(catalogDb);
    ```

1. To pass the Azure Storage queue service to the **Catalog.API** project, alter that code to match this code:

    ```csharp
    var catalogApi = builder.AddProject<Catalog_API>("catalog-api")
        .WithReference(catalogDb)
        .WithReference(queues);
    ```

## Store a message in a queue

Now, let's modify the **Catalog.API** project to use an Azure Storage Queue. You must start by installing the correct Aspire component:

1. In **Solution Explorer**, right-click the **Catalog.API** project, select **Add**, and then select **.NET Aspire package**.
1. In the search textbox, at the end of the existing text, type **Storage**.
1. Select **Aspire.Azure.Storage.Queues** package.
1. In the **Version** list, select the latest **8.0.0** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In **Solution Explorer**, expand **Catalog.API** and then double-click _Program.cs_.
1. Locate the following line of code:

    ```csharp
    var builder = WebApplication.CreateBuilder(args);
    ```

1. Immediately after that code, to add the queues backing service, add this code:

    ```csharp
    builder.AddAzureQueueClient("queueConnection");
    ```

1. Now you can retrieve the queues service by using dependency injection. In **Solution Explorer**, expand **Catalog.API > Apis** and then double-click _CatalogApi.cs_.
1. Locate the following code:

    ```csharp
    public static async Task<Results<Ok<PaginatedItems<CatalogItem>>, BadRequest<string>>> GetAllItems(
        [AsParameters] PaginationRequest paginationRequest,
        [AsParameters] CatalogServices services)
    {
    ```

1. To retrieve the queues service, modify that code to the following code:

    ```csharp
    public static async Task<Results<Ok<PaginatedItems<CatalogItem>>, BadRequest<string>>> GetAllItems(
        [AsParameters] PaginationRequest paginationRequest,
        [AsParameters] CatalogServices services,
        Azure.Storage.Queues.QueueServiceClient client)
    {
    ```

1. Immediately after that code, add the following code:

    ```csharp
    var queueClient = client.GetQueueClient("catalogrequests");
    CancellationToken stoppingToken = new CancellationToken();
    await queueClient.CreateIfNotExistsAsync(cancellationToken: stoppingToken);

    await queueClient.SendMessageAsync("Catalog Request - All items requested");
    ```

## Create a new Worker Service

Now that we've stored a message, let's retrieve it from the Azure Storage queue and use OpenTelemetry to log it. We'll use a **Worker Service** project to run in the background and periodically check the queue:

1. In Visual Studio, in **Solution Explorer**, right-click the **eShop.azurestorage** solution, point to **Add** and then select **New Project**.
1. In the **Search for templates** textbox type **Worker Service**.
1. Select the **Worker Service** C# project template and then select **Next**.
1. In the **Project name** textbox, type **eShop.MessageProcessor** and then select **Next**.
1. On the **Additional Information** page, ensure that the **.NET 8.0** framework is selected and that the **Enlist in .NET Aspire orchestration** checkbox is selected, and then select **Create**.
1. In **Solution Explorer**, expand **eShop.AppHost** and then double-click _Program.cs_.
1. Notice that, because we enrolled the worker service project in .NET Aspire orchestration, Visual Studio has added this line of code:

    ```csharp
    builder.AddProject<Projects.eShop_MessageProcessor>("eshop-messageprocessor");
    ```

1. To pass the Azure Storage queues service to the worker process, modify that code to this:

    ```csharp
    builder.AddProject<Projects.eShop_MessageProcessor>("eshop-messageprocessor")
        .WithReference(queues);
    ```

## Process messages in the Worker Service

.NET Aspire now creates an Azure queues backing service and passes it to both the Catalog API and the worker service. The Catalog API stores a message in a queue. We must configure the worker process and write code in it to retrieve messages:

1. In **Solution Explorer**, right-click **eShop.MessageProcessor**, point to **Add** and then select **.NET Aspire Package**.
1. In the search textbox, at the end of the existing text, type **Storage**.
1. Select **Aspire.Azure.Storage.Queues** package.
1. In the **Version** list, select the latest **8.0.0** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In **Solution Explorer**, expand **eShop.MessageProcessor** and then double-click the _Program.cs_ file.
1. Locate the following line of code:

    ```csharp
    var builder = Host.CreateApplicationBuilder(args);
    ```

1. Immediately after that line, add this code:

    ```csharp
    builder.AddAzureQueueClient("queueConnection");
    ```

1. In **Solution Explorer**, in the **eShop.MessageProcessor** project, double-click the _Worker.cs_ file.
1. Remove all the existing code. Replace with this code, which opens the queue and checks it for new messages every 15 seconds:

    ```csharp
    using Azure.Storage.Queues;
    using Azure.Storage.Queues.Models;

    namespace eShop.MessageProcessor;

    public sealed class WorkerService(
        QueueServiceClient client,
        ILogger<WorkerService> logger) : BackgroundService
    {
        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            var queueClient = client.GetQueueClient("catalogrequests");
            await queueClient.CreateIfNotExistsAsync(cancellationToken: stoppingToken);

            while (!stoppingToken.IsCancellationRequested)
            {
                QueueMessage[] messages =
                    await queueClient.ReceiveMessagesAsync(
                        maxMessages: 25, cancellationToken: stoppingToken);

                foreach (var message in messages)
                {
                    logger.LogInformation(
                        "Received catalog request: {Message}", message.MessageText);

                    await queueClient.DeleteMessageAsync(
                        message.MessageId,
                        message.PopReceipt,
                        cancellationToken: stoppingToken);
                }

                await Task.Delay(TimeSpan.FromSeconds(15), stoppingToken);
            }
        }
    }
    ```

## Test the solution

Let's test the Azure Storage service that you added.

1. In Visual Studio, to start the app in debugging mode press <kbd>F5</kbd> or select **Debug > Start Debugging**.
1. If the **Start Docker Desktop** message appears, select **Yes**. The app starts and displays the .NET Aspire dashboard in a browser tab.
1. In the Aspire dashboard, notice that the list of **Resources** includes a container named **storage** and an **AzureQueueStorageResource** named **queueConnection**.
1. Locate the line for the **eshop_messageprocessor** project and then in the **Logs** column, select **View**.

    :::image type="content" source="../media/dotnet-aspire-dashboard-resources.png" lightbox="../media/dotnet-aspire-dashboard-resources.png" alt-text="Screenshot showing the .NET Aspire dashboard with storage resources and the message processer worker process.":::

1. In the **Console logs** for the **eshop-messageprocessor** project, notice that a new request and response is added every 15 seconds.
1. In the navigation on the left, select **Resources**, and then select one of the endpoints for the **webapp** project:

    :::image type="content" source="../media/dotnet-aspire-dashboard-webapp.png" lightbox="../media/dotnet-aspire-dashboard-webapp.png" alt-text="Screenshot showing the .NET Aspire dashboard with the web app project's endpoints highlighted.":::

1. A new browser tab appears and displays the Northern Mountains homepage. The catalog is displayed with pictures of products. When this happens, the Catalog API requests all items in the catalog.
1. Return to the browser tab that displays the .NET Aspire dashboard.
1. Locate the line for the **eshop_messageprocessor** project and then in the **Logs** column, select **View**.
1. The log displays an extra entry with a message about the catalog request. This message was added to the Azure Storage queue by the Catalog API and retrieved by the worker process.

    :::image type="content" source="../media/retrieved-message.png" lightbox="../media/retrieved-message.png" alt-text="Screenshot showing the .NET Aspire concole log for the worker process with a message text displayed.":::

1. Close the browser tabs and in Visual Studio, press <kbd>SHIFT + F5</kbd> or select **Debug > Stop Debugging**.
1. Close Visual Studio.
