In this exercise, you're going to add Swagger and Swagger UI to an ASP.NET Core web API application. The Swagger tooling assists you in creating the OpenAPI document that describes your web API.

> [!NOTE]
> Download the source code to your local computer to complete this exercise. After downloading the file, you will need to unzip it.
> 
> [Download: ASP.NET Core Web API Application][exercise].
> 
> 1. Select the download button on the middle-right of the screen.
> 1. Unzip the `exercise.zip` file.


## Add the Swagger tooling ##

1. Open Visual Studio and find the ASP.NET Core Web API app.

    :::image type="content" source="../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-01.png" alt-text="Visual Studio Solution Opening.":::

2. In **Solution Explorer**, right-click the project and select the **Manage NuGet Packages** menu.

    :::image type="content" source="../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-02.png" alt-text="Right-click Manage NuGet Packages.":::

3. In **NuGet Package Manager**, search `Swashbuckle.AspNetCore`. Select the package and install it.

    :::image type="content" source="../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-03.png" alt-text="NuGet Package Manager.":::

   The NuGet package has now been installed. Close the **NuGet Package Manager** tab.


## Configure Swashbuckle to generate an OpenAPI document ##

1. Open the `Startup.cs` file.

    :::image type="content" source="../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-04.png" alt-text="File: Startup.cs":::

1. Add the following directive just above the line, `namespace InventoryManagement.ApiApp`.

    ```csharp
    /* === using directive BEGIN === */
    using Microsoft.OpenApi.Models;
    /* === using directive END === */
    ```

1. Replace all of the code inside of the `ConfigureServices(IServiceCollection)` method, with the following code:

    ```csharp
        services.AddControllers();

        /* === SwaggerGen BEGIN === */
        services.AddSwaggerGen(c =>
        {
            c.SwaggerDoc("v1", new OpenApiInfo { Title = "Inventory Management", Version = "v1" });
        });
        /* === SwaggerGen END === */
    ```

1. Within the `Configure(IApplicationBuilder, IWebHostEnvironment)` method, find the `if (env.IsDevelopment())` conditional statement and replace everything above that statement with the following code:

    ```csharp
        /* === SwaggerUI BEGIN === */
        app.UseSwagger(c =>
        {
            c.PreSerializeFilters.Add((swagger, httpReq) => {
                var server = new OpenApiServer() { Url = $"{httpReq.Scheme}://{httpReq.Host.Value}" };
                swagger.Servers = new List<OpenApiServer>() { server };
            });
        });
        app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "InventoryManagement.ApiApp v1"));
        /* === SwaggerUI END === */
    ```

   You've now completed activating the OpenAPI document feature to your ASP.NET Core Web API app. Save the `Startup.cs` file. Your changes might look like the following screenshot.

    :::image type="content" source="../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-05.png" alt-text="File Modified: Startup.cs":::


## Generate the OpenAPI document file ##

1. Select the debug button at the top-middle of Visual Studio.

    :::image type="content" source="../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-06.png" alt-text="Debug in Visual Studio.":::

   It automatically opens your web browser and shows the Swagger UI page.

    :::image type="content" source="../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-07.png" alt-text="Swagger UI Page.":::

   You may see the 404 error page. In this case, enter the URL, `https://localhost:<port_number>/swagger`, to your browser's address bar. In the following screenshot, the URL is `https://localhost:44371/swagger`, for example.

    :::image type="content" source="../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-08.png" alt-text="Page Not Found.":::

1. Select the link to open the OpenAPI document page.

    :::image type="content" source="../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-09.png" alt-text="Swagger UI Page for OpenAPI.":::

1. The OpenAPI document is rendered on-the-fly.

    :::image type="content" source="../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-10.png" alt-text="OpenAPI Document.":::

Your ASP.NET Core Web API app is now ready to produce the OpenAPI document.

[az apim]: /azure/api-management/api-management-key-concepts

[exercise]: https://github.com/MicrosoftDocs/mslearn-developer-tools-power-platform/blob/master/fusion-developers/exercise.zip