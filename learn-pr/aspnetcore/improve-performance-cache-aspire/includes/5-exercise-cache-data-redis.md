In this exercise, you'll add caching to the partially completed cloud-native app for your outdoor equipment retailer. You'll add Redis to the **AppHost** project, and then implement output caching in the **WebApp** project and distributed caching in the **Catalog.API** project.

## Install prerequisites

The prerequisites for .NET Aspire are:

- .NET 8
- Visual Studio 2022 Preview
- Docker Desktop
- .NET Aspire workload in Visual Studio

If you've already got these packages installed, you can skip ahead to begin working with a Redis cache.

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

    You should see a message that the Aspire workload has been installed.

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

    You should see the details of the `aspire` workload.

    ```console
    Installed Workload Id      Manifest Version      Installation Source
    ---------------------------------------------------------------------------------------------
    aspire                     8.0.0/8.0.100         SDK 8.0.300-preview.24203, VS 17.10.34902.84

    Use `dotnet workload search` to find additional workloads to install.
    ```

## Clone and modify the sample app

Let's use `git` to obtain a sample app built with .NET Aspire. The app doesn't yet have caching set up:

1. In the command line, browse to a folder of your choice where you can work with code.
1. Execute the following command to clone the **Northern Mountains eShop** sample application:

    ```dotnetcli
    git clone -b aspire-cache https://github.com/MicrosoftDocs/mslearn-aspire-starter
	```

1. Start Visual Studio and then select **Open a project or solution**.
1. Browse to the folder where you cloned the eShop, open the _start_ folder and select the _eShop.rediscache.sln_ file, and then select **Open**.
1. In **Solution Explorer**, browse to _WebApp/Components/Pages_ and then double-click _Catalog.razor_.
1. Locate the following line of code:

    ```razor
    <SectionContent SectionName="page-header-subtitle">Start the season with the latest in clothing and equipment.</SectionContent>
    ```

1. Replace that line with the following code:

    ```razor
    <SectionContent SectionName="page-header-subtitle">Start the season with the latest in clothing and equipment. It's @DateTime.Now</SectionContent>
    ```

1. To start the app, press <kbd>F5</kbd> or select **Debug** > **Start Debugging**.
1. If the **Start Docker Desktop** dialog appears, select **Yes**.
1. When the **eShop** .NET Aspire dashboard appears, for the **webapp** resource, select one of the endpoints:

    :::image type="content" source="../media/dashboard-select-web-app.png" lightbox="../media/dashboard-select-web-app.png" alt-text="Screenshot showing where to start the webapp in the .NET Aspire dashboard.":::

1. The endpoint displays the Northern Mountains homepage. Including the time on the server:

    :::image type="content" source="../media/home-page-time.png" lightbox="../media/home-page-time.png" alt-text="Screenshot showing the Northern Mountains homepage with the server-side time displayed.":::

1. Press <kbd>F5</kbd> to refresh the page. Because the page isn't cached, the time displayed changes every time you refresh it, as long as the second has changed.
1. Change to the browser tab that displays the .NET Aspire dashboard, and then in the left-hand navigation, select **Traces**.
1. Traces with the name **webapp: GET /** are requests for the homepage. Make a note of the typical **Duration** for these requests, then for one of them, select **View** in the **Details** column:

    :::image type="content" source="../media/traces-no-cache.png" lightbox="../media/traces-no-cache.png" alt-text="Screenshot with the .NET Aspire dashboard showing traces for requests to the Northern Mountain homepage with no caching.":::

1. In the timeline view, note that webapp calls multiple microservices to construct the response.
1. Close the Northern Mountains homepage and the .NET Aspire dashboard.
1. In Visual Studio, to stop debugging, press <kbd>SHIFT - F5</kbd> or select **Debug > Stop Debugging**.

## Add a caching backing service

Now that you've seen how the homepage performs without caching, let's add output caching to see if it improves responsiveness. Start by adding the output caching component to the **AppHost** project:

1. In Visual Studio, in **Solution Explorer**, right-click the **eShop.AppHost** project, select **Add**, and then select **.NET Aspire package**.
1. In the search textbox, at the end of the existing text, type **Redis**.
1. Select **Aspire.Hosting.Redis** package.
1. In the **Version** list, select the latest **8.0.0** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In **Solution Explorer**, expand the **AppHost** project and then double-click _Program.cs_.
1. Locate the following lines of code:

    ```csharp
    // Databases

    var postgres = builder.AddPostgres("postgres").WithPgAdmin();
    var catalogDb = postgres.AddDatabase("CatalogDB");
    ```

1. Immediately after those lines, add the following code:

    ```csharp
    // Cache
    var redis = builder.AddRedis("cache");
    ```

1. Locate the following line of code, which adds the **Catalog API** project to .NET Aspire orchestration:

    ```csharp
    var catalogApi = builder.AddProject<Catalog_API>("catalog-api")
        .WithReference(catalogDb);
    ```

1. To pass the Redis cache to the Catalog API project, replace that code with the following lines:

    ```csharp
    var catalogApi = builder.AddProject<Catalog_API>("catalog-api")
        .WithReference(catalogDb)
        .WithReference(redis);
    ```

    > [!NOTE]
    > We'll use the cache in the Catalog API to perform distributed caching.

1. Locate the following line of code, which adds the **WebApp** project to .NET Aspire orchestration:

    ```csharp
    builder.AddProject<WebApp>("webapp")
        .WithReference(catalogApi);
    ```

1. To pass the Redis cache to the WebApp project, replace that code with the following lines:

    ```csharp
    builder.AddProject<WebApp>("webapp")
        .WithReference(catalogApi)
        .WithReference(redis);
    ```

    > [!NOTE]
    > We'll use the cache in the WebApp to perform output caching.

1. To save the _Program.cs_ file, press <kbd>CTRL - S</kbd> or select **File > Save Program.cs**.

## Use output caching in the WebApp project

Now, let's use the Redis cache in the WebApp project to cache the homepage output:

1. In Visual Studio, in **Solution Explorer**, right-click the **WebApp** project, select **Add**, and then select **.NET Aspire package**.
1. In the search textbox, at the end of the existing text, type **Redis**.
1. Select **Aspire.StackExchange.Redis.OutputCaching** package.
1. In the **Version** list, select the latest **8.0.0** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. When the installation is complete, in **Solution Explorer**, expand **WebApp** and then double-click _Program.cs_.
1. Locate the following line of code:

    ```csharp
    var builder = WebApplication.CreateBuilder(args);
    ```

1. Immediately after that line, to add the output cache to the project, add this code:

    ```csharp
    builder.AddRedisOutputCache("cache");
    ```

1. Locate the following line of code:

    ```csharp
    var app = builder.Build();
    ```

1. Immediately after that line, to add the caching middleware to the request pipeline, add this code:

    ```csharp
    app.UseOutputCache();
    ```

1. In **Solution Explorer**, expand **WebApp > Components > Pages** and then double-click _Catalog.razor_.
1. Locate the following line of code:

    ```razor
    @attribute [StreamRendering]
    ```

1. Immediately after that line, to cache the homepage, add this code:

    ```razor
    @attribute [Microsoft.AspNetCore.OutputCaching.OutputCache(Duration = 10)]
    ```

## Test output caching

Output caching is now implemented in the Northern Mountains homepage. Let's test it:

1. In Visual Studio, to start the app, press <kbd>F5</kbd> or select **Debug > Start Debugging**.
1. When the **eShop** .NET Aspire dashboard appears, for the **webapp** resource, select one of the endpoints:

    :::image type="content" source="../media/dashboard-select-web-app.png" lightbox="../media/dashboard-select-web-app.png" alt-text="Screenshot showing where to start the webapp in the .NET Aspire dashboard.":::

1. The endpoint displays the Northern Mountains homepage, including the time on the server.
1. Press <kbd>F5</kbd> to refresh the page. Because the page is cached for 10 seconds, the time displayed changes only when it's more than 10 seconds after the cached request.
1. Change to the browser tab that displays the .NET Aspire dashboard, and then in the left-hand navigation, select **Traces**.
1. Traces with the name **webapp: GET /** are requests for the homepage. Some requests to the homepage, which couldn't be satisfied from the cache, have similar timings to the durations you noted previously. However, other requests, which are returned from the cache, have significantly shorter durations.
1. For one of the shorter request, select **View** in the **Details** column. Notice that the request was retrieved from the Redis cache:

    :::image type="content" source="../media/trace-cached.png" lightbox="../media/trace-cached.png" alt-text="Screenshot with the .NET Aspire dashboard showing a trace for a cached request.":::

1. Close the Northern Mountains homepage and the .NET Aspire dashboard.
1. In Visual Studio, to stop debugging, press <kbd>SHIFT - F5</kbd> or select **Debug > Stop Debugging**.

## Use distributed caching

We can also use Redis to perform distributed caching in the **Catalog.API** project:

1. In Visual Studio, in **Solution Explorer**, right-click the **Catalog.API** project, select **Add**, and then select **.NET Aspire package**.
1. In the search textbox, at the end of the existing text, type **Redis**.
1. Select **Aspire.StackExchange.Redis.DistributedCaching** package.
1. In the **Version** list, select the latest **8.0.0** version, and then select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. When the installation is complete, in **Solution Explorer**, expand **Catalog.API** and then double-click _Program.cs_.
1. Locate the following line of code:

    ```csharp
    var builder = WebApplication.CreateBuilder(args);
    ```

1. Immediately after that line, to add the output cache to the project, add this code:

    ```csharp
    builder.AddRedisDistributedCache("cache");
    ```

1. In **Solution Explorer** expand **Catalog.API > Apis** and then double-click _CatalogApi.cs_.
1. Locate the following code, which declares the `GetAllItems` method:

    ```csharp
    public static async Task<Results<Ok<PaginatedItems<CatalogItem>>, BadRequest<string>>> GetAllItems(
        [AsParameters] PaginationRequest paginationRequest,
        [AsParameters] CatalogServices services)
    {
    ```

1. To obtain the Redis cache through dependency injection, modify that code to add a new parameter to the method:

    ```csharp
    public static async Task<Results<Ok<PaginatedItems<CatalogItem>>, BadRequest<string>>> GetAllItems(
        [AsParameters] PaginationRequest paginationRequest,
        [AsParameters] CatalogServices services,
        IDistributedCache cache)
    {
    ```

1. Remove the entire contents of the `GetAllItems` method and replace it with the following code:

    ```csharp
    var pageSize = paginationRequest.PageSize;
    var pageIndex = paginationRequest.PageIndex;

    var totalItems = await services.DbContext.CatalogItems
        .LongCountAsync();

    // Check that there are cached items
    var cachedItems = await cache.GetAsync("catalogItems");

    if (cachedItems is null)
    {
        // There are no items in the cache. Get them from the database
        var itemsOnPage = await services.DbContext.CatalogItems
            .OrderBy(c => c.Name)
            .Skip(pageSize * pageIndex)
            .Take(pageSize)
            .AsNoTracking()
            .ToListAsync();

        // Store the items in the cache for 10 seconds
        await cache.SetAsync("catalogItems", Encoding.UTF8.GetBytes(System.Text.Json.JsonSerializer.Serialize(itemsOnPage)), new()
        {
            AbsoluteExpiration = DateTime.Now.AddSeconds(10)
        });

        ChangeUriPlaceholder(services.Options.Value, itemsOnPage);
        return TypedResults.Ok(new PaginatedItems<CatalogItem>(pageIndex, pageSize, totalItems, itemsOnPage));

    }
    else
    {
        // There are items in the cache. Deserialize them to display.
        var itemsOnPage = System.Text.Json.JsonSerializer.Deserialize<List<CatalogItem>>(cachedItems);
        // Make sure itemsOnPage is not null
        if (itemsOnPage is null)
        {
            itemsOnPage = new List<CatalogItem>();
        }

        ChangeUriPlaceholder(services.Options.Value, itemsOnPage);
        return TypedResults.Ok(new PaginatedItems<CatalogItem>(pageIndex, pageSize, totalItems, itemsOnPage));
    }
    ```

## Test distributed caching

Distributed caching is now implemented in the **Catalog.API** project. Let's test it:

1. In Visual Studio, to start the app, press <kbd>F5</kbd> or select **Debug > Start Debugging**.
1. When the **eShop** .NET Aspire dashboard appears, for the **catalog-api** resource, select the endpoint:

    :::image type="content" source="../media/dashboard-select-catalog.png" lightbox="../media/dashboard-select-catalog.png" alt-text="Screenshot showing where to start the Catalog API in the .NET Aspire dashboard.":::

1. The endpoint displays the Swagger interface for the **Catalog API** microservice. Next to the **/api/v1/catalog/items** method, select **GET**.
1. Select **Try it out** and then select **Execute**. Results are displayed in the **Response body** window:

    :::image type="content" source="../media/catalog-results.png" lightbox="../media/catalog-results.png" alt-text="Screenshot showing catalog results displayed in the Swagger user interface.":::

1. Click **Execute** several more times to call the API again. These requests should get the items from the cache, as long as the request is less than 10 seconds after the first one.
1. Change to the browser tab that displays the .NET Aspire dashboard, and then in the left-hand navigation, select **Traces**.
1. Traces with the name **catalog-api: GET /api/v1/catalog/items** are requests for the **items** method of the Catalog API. Notice that the first request to that method takes longer to formulate that subsequent requests, which the API obtains the items from the Redis cache:

    :::image type="content" source="../media/catalog-traces-cached.png" lightbox="../media/catalog-traces-cached.png" alt-text="Screenshot with the .NET Aspire dashboard Traces page with cached requests to the Catalog API.":::

1. Close the Swagger page and the .NET Aspire dashboard.
1. In Visual Studio, to stop debugging, press <kbd>SHIFT - F5</kbd> or select **Debug > Stop Debugging**.
