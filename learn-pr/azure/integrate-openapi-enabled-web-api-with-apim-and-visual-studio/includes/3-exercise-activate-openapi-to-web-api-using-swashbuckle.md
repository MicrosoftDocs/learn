In this module you're going to double-check whether the OpenAPI document generation is ready by implementing Swagger UI and Swashbuckle into the ASP.NET Core Web API application.


<!-- NOTE to REVIEWER - The download link for this module can be found at https://github.com/justinyoo/inventory-management-demo-web-api, which will be transferred to the MicrosoftDocs org. -->

> [!NOTE]
> Download the source code to your local computer to complete this exercise. After downloading the file, you will need to unzip it.
> 
> [Download: ASP.NET Core Web API Application][exercise].


## Configure ASP.NET Core Web API for OpenAPI Ready ##

1. Open Visual Studio and find the ASP.NET Core Web API app.

    ![Visual Studio Solution Opening][image-01]

1. In **Solution Explorer**, right-click the project and select the **Manage NuGet Packages** menu.

    ![Right-click Manage NuGet Packages][image-02]

1. In **NuGet Package Manager**, search `Swashbuckle.AspNetCore`. Select the package and install it.

    ![NuGet Package Manager][image-03]

   The NuGet package has now been installed. Then close the **NuGet Package Manager** tab.

1. Open the `Startup.cs` file.

    ![File: Startup.cs][image-04]

1. Add the following directive just above the line, `namespace InventoryManagement.ApiApp`.

    ```csharp
    /* === using directive BEGIN === */
    using Microsoft.OpenApi.Models;
    /* === using directive END === */

    namespace InventoryManagement.ApiApp
    {
    ```

1. Add the following code lines into the `ConfigureServices(IServiceCollection)` method.

    ```csharp
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddControllers();

        /* === SwaggerGen BEGIN === */
        services.AddSwaggerGen(c =>
        {
            c.SwaggerDoc("v1", new OpenApiInfo { Title = "Inventory Management", Version = "v1" });
        });
        /* === SwaggerGen END === */
    }
    ```

1. Add the following code lines into the `Configure(IApplicationBuilder, IWebHostEnvironment)` method.

    ```csharp
    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
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

        if (env.IsDevelopment())
        {
    ```

   You've just completed activating the OpenAPI document feature to your ASP.NET Core Web API app. Save the `Startup.cs` file. Your changes might look like the following screenshot.

    ![File Modified: Startup.cs][image-05]

1. Click the debug button at the top-middle of Visual Studio.

    ![Debug in Visual Studio][image-06]

   It automatically opens your web browser and shows the Swagger UI page.

    ![Swagger UI Page][image-07]

   You may see the 404 error page. In this case, enter the URL, `https://localhost:<port_number>/swagger`, to your browser's address bar. In the screenshot below, the URL is `https://localhost:44371/swagger`, for example.

    ![Page Not Found][image-08]

1. Click the link to open the OpenAPI document page.

    ![Swagger UI Page for OpenAPI][image-09]

1. The OpenAPI document is rendered on-the-fly.

    ![OpenAPI Document][image-10]

Your ASP.NET Core Web API app is now ready to produce the OpenAPI document.


[image-01]: ../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-01.png
[image-02]: ../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-02.png
[image-03]: ../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-03.png
[image-04]: ../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-04.png
[image-05]: ../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-05.png
[image-06]: ../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-06.png
[image-07]: ../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-07.png
[image-08]: ../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-08.png
[image-09]: ../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-09.png
[image-10]: ../media/3-exercise-activate-openapi-to-web-api-using-swashbuckle-10.png


[az apim]: https://docs.microsoft.com/azure/api-management/api-management-key-concepts

[exercise]: https://github.com/justinyoo/inventory-management-demo-web-api/archive/refs/tags/exercise.zip
