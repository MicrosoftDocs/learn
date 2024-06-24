In this lab, you'll use the .NET Aspire Azure Cosmos DB component to connect to and add data to a Cosmos DB database. You'll use the **Azure Cosmos DB Emulator**, running on your local computer, to simulate a Cosmos DB database in an Azure subscription in the cloud.

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
    --------------------------------------------------------------------------------
    aspire                     8.0.1/8.0.100         SDK 8.0.300, VS 17.11.34929.205

    Use `dotnet workload search` to find additional workloads to install.
    ```

## Install and run the Azure Cosmos DB Emulator

In this exercise, you'll use the Cosmos DB Emulator running on your local computer to simulate a Cosmos DB deployment in Azure. Let's install and run the emulator:

1. In a web browser, navigate to [Release notes for the Azure Cosmos DB Windows (local) emulator](/azure/cosmos-db/emulator-release-notes) and then select **Download latest version**.
1. When the download is complete, execute the installer file you downloaded.
1. Select **I accept the terms in the License Agreement** and then select **Install**.
1. If the **User Account Control** dialog appears, select **Yes**.
1. When the installation is complete, ensure that the **Launch Azure Cosmos DB Emulator** checkbox is selected, and then select **Finish**.

    :::image type="content" source="../media/emulator-install-complete.png" lightbox="../media/emulator-install-complete.png" alt-text="Screenshot showing the completed Azure Cosmos DB Emulator setup wizard.":::

1. If the **User Account Control** dialog appears a second time, select **Yes**.

## Clone project

Let's use `git` to obtain a sample app, which doesn't yet use Azure Storage:

1. In the command line, browse to a folder of your choice where you can work with code.
1. Execute the following command to clone the **eShop** sample application:

    ```dotnetcli
    git clone -b aspire-azure-cosmos-db https://github.com/MicrosoftDocs/mslearn-aspire-starter
    ```

1. Start Visual Studio, and select **Open a project or solution**.
1. Navigate to the folder where you cloned the project.
1. Double-click the **Start** folder, select the _eShop.azurecosmosdb.sln_ solution, and then select **Open**.
1. To start the app in debugging mode press <kbd>F5</kbd> or select **Debug > Start Debugging**.
1. If the **Start Docker Desktop** message appears, select **Yes**. The app starts and displays the .NET Aspire dashboard in a browser tab.
1. In the list of **Resources**, select one of the endpoints for the **webapp** project:

    :::image type="content" source="../media/dashboard-open-webapp.png" lightbox="../media/dashboard-open-webapp.png" alt-text="Screenshot showing the .NET Aspire dashboard with the location where you can access the endpoint for the webapp project.":::

1. When the web app's homepage appears, explore the site:

    :::image type="content" source="../media/webapp-homepage.png" lightbox="../media/webapp-homepage.png" alt-text="Screenshot showing the .NET Aspire web app homepage.":::

1. Close the web browser tabs and then, in Visual Studio, stop debugging.

## Add a Cosmos DB service to the app host

Next, let's add a Cosmos DB backing service to the .NET Aspire app:

1. In Visual Studio, in the **Solution Explorer**, right-click the **eShop.AppHost** project, select **Add**, and then select **.NET Aspire package**.
1. In the search textbox, at the end of the existing text, type **Cosmos**.
1. Select **Aspire.Hosting.Azure.CosmosDB** package.
1. In the **Version** list, select the latest **8.0.1** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In **Solution Explorer**, expand **eShop.AppHost** and then double-click _Program.cs_.
1. Locate the following code:

    ```csharp
    var builder = DistributedApplication.CreateBuilder(args);
    ```

1. Immediately after that code, to add a Cosmos DB service and a databse, add this code:

    ```csharp
    var cosmos = builder.AddAzureCosmosDB("cosmos").RunAsEmulator();
    var cosmosdb = cosmos.AddDatabase("catalogcosmosdb");
    ```

1. Locate the following code, which registers the **Catalog.API** project for .NET Aspire orchestration:

    ```csharp
    var catalogApi = builder.AddProject<Catalog_API>("catalog-api")
        .WithReference(catalogDb);
    ```

1. To pass the Azure Cosmos DB service to the **Catalog.API** project, alter that code to match this code:

    ```csharp
    var catalogApi = builder.AddProject<Catalog_API>("catalog-api")
        .WithReference(catalogDb)
        .WithReference(cosmosdb);
    ```

## Configure the connection string

For development, we want to use the Cosmos DB Emulator to run the database service. You must configure a connection string so that the .NET Aspire solution can find the service:

1. Open a new web browser tab and navigate to **https://localhost:8081/_explorer/index.html**.
1. In the **Azure Cosmos DB Emulator** homepage, to copy the connection string to the clipboard, select the entire string in the **Primary Connection String** textbox, and then press <kbd>CTRL</kbd> + <kbd>C</kbd>.

    :::image type="content" source="../media/emulator-homepage.png" lightbox="../media/emulator-homepage.png" alt-text="Screenshot showing the homepage for the Azure Cosmos DB Emulator and where to find the connection string.":::

1. Switch to Visual Studio.
1. In the **Solution Explorer**, expand the **eShop.AppHost** project, and then double-click the __appsettings.json_ file.
1. On a new line, immediately after the opening `{`, add this code:

    ```json
    "ConnectionStrings": {
      "localcosmosdb": "<connectionstring>"
    },
    ```

1. In the new code, delete the `<connectionstring>` place holder and then press <kbd>CTRL</kbd> + <kbd>V</kbd> to replace it with the connection string your previously copied to the clipboard.
1. In **Solution Explorer**, in the **eShop.AppHost** project, double-click the **Program.cs** file.
1. Locate the following code:

    ```csharp
    var builder = DistributedApplication.CreateBuilder(args);
    ```

1. Immediately after that code, to add a connection string, add this code:

    ```csharp
    var connectionstring = builder.AddConnectionString("localcosmosdb");
    ```

1. Locate the following code, which registers the **Catalog.API** project for .NET Aspire orchestration:

    ```csharp
    var catalogApi = builder.AddProject<Catalog_API>("catalog-api")
        .WithReference(catalogDb)
        .WithReference(cosmosdb);
    ```

1. To pass the connection string to the **Catalog.API** project, alter that code to match this code:

    ```csharp
    var catalogApi = builder.AddProject<Catalog_API>("catalog-api")
        .WithReference(catalogDb)
        .WithReference(connectionString)
        .WithReference(cosmosdb);
    ```

## Configure the catalog microservice

Now that the app host creates the Cosmos DB backing service, you can use it in the Catalog API microservice:

1. In Visual Studio, in the **Solution Explorer**, right-click the **Catalog.API** project, select **Add**, and then select **.NET Aspire package**.
1. In the search textbox, at the end of the existing text, type **Cosmos**.
1. Select **Aspire.Microsoft.Azure.CosmosDB** package.
1. In the **Version** list, select the latest **8.0.1** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In **Solution Explorer**, expand **Catalog.API** and then double-click the _Program.cs_ file.
1. Locate the following code:

    ```csharp
    builder.AddApplicationServices();
    ```

1. Immediately after that code, to register the Cosmos DB service for dependency injection, add this code:

    ```csharp
    builder.AddAzureCosmosClient("localcosmosdb");
    ```

## Create an item in Cosmos DB

Now you can write code that creates objects in the Cosmos DB service.

1. In Visual Studio, in the **Solution Explorer**, expand **Catalog.API > Apis**, and then double-click the _Catalog.Api_ file.
1. Locate the following code, which declares the `GetAllItems()` method:

    ```csharp
    public static async Task<Results<Ok<PaginatedItems<CatalogItem>>, BadRequest<string>>> GetAllItems(
        [AsParameters] PaginationRequest paginationRequest,
        [AsParameters] CatalogServices services)
    {
    ```

1. To obtain the `CosmosClient` object from dependency injection, modify that code to match this code:

    ```csharp
    public static async Task<Results<Ok<PaginatedItems<CatalogItem>>, BadRequest<string>>> GetAllItems(
        [AsParameters] PaginationRequest paginationRequest,
        [AsParameters] CatalogServices services,
        CosmosClient cosmosClient)
    {
    ```

1. Within the `GetAllItems()` method, to create a database, add this code:

    ```csharp
    Database db = await cosmosClient.CreateDatabaseIfNotExistsAsync(
        id: "catalogcosmosdb",
        throughput: 400);
    ```

1. Immediately after that code, to create a container, add this code:

    ```csharp
    Container container = await db.CreateContainerIfNotExistsAsync(
        id: "products",
        partitionKeyPath: "/id"
    );
    ```

1. Immediately after that code, to create a new item, add this code:

    ```csharp
    var item = new
    {
        id = "68649263",
        name = "Large backpack"
    };

    await container.CreateItemAsync(item);
    ```

## Test the eShop

You code is now complete. Let's test the eShop:

1. In Visual Studio, to start the app in debugging mode press <kbd>F5</kbd> or select **Debug > Start Debugging**.
1. If the **Start Docker Desktop** message appears, select **Yes**. The app starts and displays the .NET Aspire dashboard in a browser tab.
1. In the Aspire dashboard, notice that the list of **Resources** includes a container named **cosmos**.
1. Switch to the browser tab that displays the Azure Cosmos DB Emulator, or open a new browser tab and navigate to **https://localhost:8081/_explorer/index.html**.
1. In the navigation on the left, select **Explorer**. No databases, containers, or items are listed.
1. Return to the browser tab that displays the .NET Aspire dashboard.
1. In the list of **Resources**, select one of the endpoints for the **webapp** project:

    :::image type="content" source="../media/dashboard-open-webapp.png" lightbox="../media/dashboard-open-webapp.png" alt-text="Screenshot showing the .NET Aspire dashboard with the location where you can access the endpoint for the webapp project.":::

1. The web app's homepage displays items from the catalog. This action requires a call to the `GetAllItems()` method:

    :::image type="content" source="../media/webapp-homepage.png" lightbox="../media/webapp-homepage.png" alt-text="Screenshot showing the .NET Aspire web app homepage.":::

1. Return to the browser tab that displays the Azure Cosmos DB Explorer, and press <kbd>F5</kbd> to refresh the page.
1. In the navigation on the left, select **Explorer**.
1. Under **NoSQL**, expand **catalogcosmosdb > products** and then select **Items**.
1. In the list of items, select **68649263**. The page displays the details of the **Large backpack** item you added in code:

    :::image type="content" source="../media/item-in-cosmos-db.png" lightbox="../media/item-in-cosmos-db.png" alt-text="Screenshot showing a new item in the Azure Cosmos DB Emulator.":::

1. Close all browser tabs and, in Visual Studio, stop debugging.

## Learn more

- [.NET Aspire Azure Cosmos DB component](/dotnet/aspire/database/azure-cosmos-db-component)
- [What is the Azure Cosmos DB emulator?](/azure/cosmos-db/emulator)
