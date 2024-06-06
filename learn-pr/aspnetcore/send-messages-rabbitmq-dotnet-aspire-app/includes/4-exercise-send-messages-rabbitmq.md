RabbitMQ is a reliable message broker that provides flexible messaging exchanges and queues. To send and receive messages through RabbitMQ in a .NET Aspire project, you must add a RabbitMQ container, and then create code that sends messages from one microservice and receives it in another.

In this exercise, you'll send messages to a queue from the Catalog.API project. You'll add a new background service project that receives those messages from the queue and sends them to the console log for display.

## Install prerequisites

The prerequisites for .NET Aspire are:

- .NET 8
- Visual Studio 2022 Preview
- Docker Desktop or Podman
- .NET Aspire workload in Visual Studio

If you've already got these packages installed, you can skip ahead to begin working with RabbitMQ.

### Install .NET 8

Follow this [.NET 8](https://dotnet.microsoft.com/download/dotnet/8.0) link, and select the correct installer for your operating system. For example, if you're using Windows 11, and a modern processor, select the x64 .NET 8 SDK for Windows.

After the download is complete, run the installer and follow the instructions. In a terminal window, run the following command to verify that the installation was successful:

```powershell
dotnet --version
```

You should see the version number of the .NET SDK you installed. For example:

```console
8.0.300-preview.24203.14
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

    You should see a message that the Aspire workload is installed.

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
    ---------------------------------------------------------------------------------------------
    aspire                     8.0.0/8.0.100         SDK 8.0.300-preview.24203, VS 17.10.34902.84
    
    Use `dotnet workload search` to find additional workloads to install.
    ```

## Clone project

Let's use `git` to obtain a sample app, which doesn't yet use a message broker:

1. In the command line, browse to a folder of your choice where you can work with code.
1. Execute the following command to clone the sample application:

    ```dotnetcli
    git clone -b aspire-rabbitmq  https://github.com/MicrosoftDocs/mslearn-aspire-starter
    ```

## Create the RabbitMQ container

Let's start by adding RabbitMQ to the app host project. When we start the solution, .NET Aspire adds a RabbitMQ container to the app and passes references to the projects that use it:

1. Start Visual Studio, and select **Open a project or solution**.
1. Navigate to the folder where you cloned the project.
1. Double-click the **start** folder, select the _eShop.rabbitmq.sln_ solution, and then select **Open**.
1. In **Solution Explorer**, right-click the **eShop.AppHost** project, select **Add**, and then select **.NET Aspire package**.
1. In the search textbox, at the end of the existing text, type **RabbitMQ**.
1. Select **Aspire.Hosting.RabbitMQ** package.
1. In the **Version** list, select the latest **8.0.0** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In **Solution Explorer**, expand **eShop.AppHost** and then double-click _Program.cs_.
1. Locate the following line of code:

    ```csharp
    var builder = DistributedApplication.CreateBuilder(args);
    ```

1. Immediately after that code, to register a RabbitMQ server, add this code:

    ```csharp
    var messaging = builder.AddRabbitMQ("messaging");
    ```

1. Locate the following code, which registers the **Catalog.API** project for .NET Aspire orchestration:

    ```csharp
    var catalogApi = builder.AddProject<Catalog_API>("catalog-api")
        .WithReference(catalogDb);
    ```

1. To pass the RabbitMQ service to the **Catalog.API** project, alter that code to match this code:

    ```csharp
    var catalogApi = builder.AddProject<Catalog_API>("catalog-api")
        .WithReference(catalogDb)
        .WithReference(messaging);
    ```

## Add RabbitMQ to the Catalog.API project

Now, we can install and configure RabbitMQ in the Catalog.API project:

1. In Visual Studio, in **Solution Explorer**, right-click the **Catalog.API** project, select **Add**, and then select **.NET Aspire package**.
1. In the search textbox, at the end of the existing text, type **RabbitMQ**.
1. Select the **Aspire.RabbitMQ.Client** package.
1. In the **Version** list, select the latest **8.0.0** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In **Solution Explorer**, expand the **Catalog.API** project, and then double-click _Program.cs_.
1. In the _Program.cs_ file, locate the following line of code:

    ```csharp
    var builder = WebApplication.CreateBuilder(args);
    ```

1. Immediately after that line, to register the RabbitMQ connection, add this code:

    ```csharp
    builder.AddRabbitMQClient("messaging");
    ```

## Send a message to a RabbitMQ queue

When a user requests the items in the catalog, we want to send a message to a RabbitMQ queue that describes the request details. Let's add that code now:

1. In the **Solution Explorer**, expand **Catalog.API > Apis** and then double-click **CatalogApi.cs**.
1. Locate the following code, which declares the `GetAllItems()` method:

    ```csharp
    public static async Task<Results<Ok<PaginatedItems<CatalogItem>>, BadRequest<string>>> GetAllItems(
        [AsParameters] PaginationRequest paginationRequest,
        [AsParameters] CatalogServices services)
    {
    ```

1. To use dependency injection to obtain the connection to RabbitMQ, modify the code to match the following lines:

    ```csharp
    public static async Task<Results<Ok<PaginatedItems<CatalogItem>>, BadRequest<string>>> GetAllItems(
        [AsParameters] PaginationRequest paginationRequest,
        [AsParameters] CatalogServices services,
        RabbitMQ.Client.IConnection connection)
    {
    ```

1. Locate the following line of code:

    ```csharp
    var totalItems = await services.DbContext.CatalogItems
        .LongCountAsync();
    ```

1. Immediately after that line, to create a RabbitMQ messaging channel, add this code:

    ```csharp
    var channel = connection.CreateModel();
    ```

1. On the next line, to create a message queue, add this code:

    ```csharp
    channel.QueueDeclare(queue: "catalogEvents",
                         durable: false,
                         exclusive: false,
                         autoDelete: false,
                         arguments: null);
    ```

1. On the next line, to send the message, add this code:

    ```csharp
    var body = Encoding.UTF8.GetBytes("Getting all items in the catalog.");

    channel.BasicPublish(exchange: string.Empty,
                         routingKey: "catalogEvents",
						 mandatory: false,
                         basicProperties: null,
                         body: body);
    ```

## Add a message consumer project

To receive messages from the RabbitMQ queue, let's create a new project:

1. In **Solution Explorer**, right-click the solution, point to **Add**, and then select **New Project**.
1. In the **Search for templates** textbox, type **Console**.
1. Select the C# **Console App** template and then select **Next**.
1. In the **Project name** textbox, type **RabbitConsumer** and then select **Next**.
1. In the **Framework** list, ensure that **.NET 8.0** is selected, and then select **Create**.
1. In **Solution Explorer**, right-click the **AppHost** project, point to **Add**, and then select **Project Reference**.
1. In the list of projects, ensure that **RabbitConsumer** is selected, and then select **OK**.

    :::image type="content" source="../media/app-host-reference-consumer.png" lightbox="../media/app-host-reference-consumer.png" alt-text="Screenshot showing how to add a reference to the AppHost project that references the RabbitConsumer project.":::

1. In **Solution Explorer**, expand **AppHost** and then double-click **Program.cs**.
1. Locate the following code:

    ```csharp
    builder.AddProject<WebApp>("webapp")
        .WithReference(catalogApi);
    ```

1. Immediately after that code, to add the **RabbitConsumer** project to .NET Aspire orchestration, add the following code:

    ```csharp
    builder.AddProject<Projects.RabbitConsumer>("consumers")
        .WithReference(messaging);
    ```

## Configure the message consumer project

Before we can receive messages in the new message consumer project, we must configure it to use the RabbitMQ backing service from the AppHost:

1. In Visual Studio, in **Solution Explorer**, right-click the **RabbitConsumer** project, select **Add**, and then select **.NET Aspire package**.
1. In the search textbox, at the end of the existing text, type **RabbitMQ**.
1. Select the **Aspire.RabbitMQ.Client** package.
1. In the **Version** list, select the latest **8.0.0** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In **Solution Explorer**, right-click the **RabbitConsumer** project, point to **Add**, and then select **Project Reference**.
1. In the list of projects, ensure that **eShop.ServiceDefaults** is selected, and then select **OK**.

    :::image type="content" source="../media/consumer-reference-service-defaults.png" lightbox="../media/consumer-reference-service-defaults.png" alt-text="Screenshot showing how to add a reference to the RabbitConsumer project that references the ServiceDefaults project.":::

1. In **Solution Explorer**, expand the **RabbitConsumer** project, and then double-click **Program.cs**.
1. Remove all the default code and replace it with the following lines:

    ```csharp
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.Extensions.Hosting;

    var builder = Host.CreateApplicationBuilder(args);

    builder.AddServiceDefaults();

    builder.AddRabbitMQClient("messaging");

    var host = builder.Build();

    host.Run();
    ```

    Notice that the code uses .NET Aspire orchestration to add the RabbitMQ service to the consumer project. You'll use that service to retrieve messages.

## Receive a RabbitMQ message

To receive a message, we must create a component that runs in the background waiting for messages to arrive. Use a `BackgroundService` class for this task:

1. In **Solution Explorer**, right-click the **RabbitConsumer** project, point to **Add** and then select **Class**.
1. In the **Name** textbox, type **CatalogProcessingJob** and then select **Add**.
1. In the **CatalogProcessingJob.cs** class, remove all the default code, and replace it with the following lines:

    ```csharp
	namespace RabbitConsumer;
	
    using System.Text;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.Extensions.Hosting;
    using Microsoft.Extensions.Logging;
    using RabbitMQ.Client;
    using RabbitMQ.Client.Events;

    public class CatalogProcessingJob : BackgroundService
    {
        private readonly ILogger<CatalogProcessingJob> _logger;
        private readonly IConfiguration _config;
        private readonly IServiceProvider _serviceProvider;
        private IConnection? _messageConnection;
        private IModel? _messageChannel;
		private EventingBasicConsumer consumer;

        public CatalogProcessingJob(ILogger<CatalogProcessingJob> logger, IConfiguration config, IServiceProvider serviceProvider, IConnection? messageConnection)
        {
            _logger = logger;
            _config = config;
            _serviceProvider = serviceProvider;
        }

        protected override Task ExecuteAsync(CancellationToken stoppingToken)
        {
            string queueName = "catalogEvents";

            _messageConnection = _serviceProvider.GetRequiredService<IConnection>();

            _messageChannel = _messageConnection.CreateModel();
            _messageChannel.QueueDeclare(queue: queueName,
                durable: false,
                exclusive: false,
                autoDelete: false,
                arguments: null);

            consumer = new EventingBasicConsumer(_messageChannel);
            consumer.Received += ProcessMessageAsync;

            _messageChannel.BasicConsume(queue:  queueName,
                autoAck: true, 
                consumer: consumer);

            return Task.CompletedTask;
        }

        public override async Task StopAsync(CancellationToken cancellationToken)
        {
            await base.StopAsync(cancellationToken);
            consumer.Received -= ProcessMessageAsync;
            _messageChannel?.Dispose();
        }

        private void ProcessMessageAsync(object? sender, BasicDeliverEventArgs args)
        {
            
            string messagetext = Encoding.UTF8.GetString(args.Body.ToArray());
            _logger.LogInformation("All products retrieved from the catalog at {now}. Message Text: {text}", DateTime.Now, messagetext);

            var message = args.Body;
        }
    }
    ```

1. In **Solution Explorer**, in the **RabbitConsumer** project, double-click **Program.cs**.
1. Locate the following code:

    ```csharp
    builder.AddRabbitMQClient("messaging");
    ```

1. Immediately after that line, add the following code:

    ```csharp
    builder.Services.AddHostedService<CatalogProcessingJob>();
    ```

## Test the solution

Let's test our RabbitMQ backing service and the microservices that send and receive messages:

1. In Visual Studio, to start the app in debugging mode, press <kbd>F5</kbd> or select **Debug > Start Debugging**.
1. If the **Start Docker Desktop** message appears, select **Yes**. The app starts and displays the .NET Aspire dashboard in a browser tab.
1. In the .NET Aspire dashboard, in the list of **Resources**, notice that the list includes a new container with the name **messaging**. The source includes **rabbitmq:3**. This container runs the RabbitMQ message broker.

    :::image type="content" source="../media/dashboard-running-rabbitmq.png" lightbox="../media/dashboard-running-rabbitmq.png" alt-text="Screenshot showing a RabbitMQ container displayed in the .NET Aspire dashboard.":::

1. In the navigation on the left, select **Console**.
1. In the **Select a resource** list, select **messaging**. The page displays the console logs for the RabbitMQ broker. Notice that the last few messages indicate that RabbitMQ completed its startup and accepted one connection. This connection is from the receiving **RabbitConsumer** project.
1. In the navigation on the left, select **Resources**.
1. In the line for the **webapp** project, in the **Endpoints** column, select one of the links. The Northern Traders homepage opens and displays the product catalog. This page sends a message to the RabbitMQ queue.

    :::image type="content" source="../media/dashboard-select-webapp-endpoint.png" lightbox="../media/dashboard-select-webapp-endpoint.png" alt-text="Screenshot showing how to access the WebApp project endpoint from the .NET Aspire dashboard.":::

1. Switch back to the .NET Aspire dashboard. In the navigation on the left, select **Console**.
1. In the **Select a resource** list, select **messaging**. Notice that RabbitQ has accepted a second connection. This connection is from the **Catalog.API** project.
1. In the **Select a resource** list, select **consumers**. This log is for the **RabbitConsumer** project. The final entry displays the message "Getting all items in the catalog." This message has been retrieved from the RabbitMQ and logged.

    :::image type="content" source="../media/retrieved-message.png" lightbox="../media/retrieved-message.png" alt-text="Screenshot showing the message retrieved from the RabbitMQ queue and displayed in the console logs for the consumer project.":::
