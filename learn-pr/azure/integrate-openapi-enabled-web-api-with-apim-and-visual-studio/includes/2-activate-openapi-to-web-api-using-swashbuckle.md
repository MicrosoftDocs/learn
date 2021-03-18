<!-- NOTE to REVIEWER - The code for this module can be found at https://github.com/justinyoo/inventory-management-demo-web-api, which will be transferred to the MicrosoftDocs org. -->

:::row:::
  :::column span="4":::
    Crystal is a full-stack developer and software architect specializing in C# and .NET. She has written and designed many of Green Leaf's applications but is getting stretched thin by all the new requests. Crystal is familiar with Power Apps at a high-level and is eager to learn how she can use her existing skills to empower Citizen Developers.
  :::column-end:::
  :::column:::
    ![Cartoon depiction of Crystal][meet crystal]
  :::column-end:::
:::row-end:::


Crystal and her development team have built Web APIs for inventory management. She wants to make sure the APIs are ready for [Azure API Management][az apim] to discover their endpoints through an Open API document easily.

This exercise will double-check whether the Open API document generation is ready by implementing Swagger UI and Swashbuckle into the Web API application.

## Download Web API Application to Cloud Shell ##

Crystal has published the source code of the Web API application to GitHub. In order to validate whether the Web API is Open API ready or not, run the following steps.

1. To clone the sample Web API Project from GitHub, in the Cloud Shell, run the following `git clone` command.

   <!-- NOTE to REVIEWER. REPLACE the repo URL with the MicrosoftDocs one once it's transferred. -->

    ```bash
    git clone https://github.com/justinyoo/inventory-management-demo-web-api \
        ~/code
    ```


## Open Web API Application on Cloud Shell ##

1. To navigate into the repository directory locally, run the following `cd` command.

    ```bash
    cd ~/code
    ```

1. To open the Cloud Shell editor for the project, run the following command.

    ```bash
    code .
    ```

   The built-in editor opens in the Cloud Shell, with all files belonging to the project in the editor's left-hand navigation pane.


## Confirm Open API Feature Readiness ##

1. Select `InventoryManagement.ApiApp.csproj` at the left-hand navigation pane of the editor.
1. Make sure that the following lines exist in the file.

    ```properties
    <ItemGroup>
      <PackageReference Include="Swashbuckle.AspNetCore" Version="6.1.1" />
    </ItemGroup>
    ```

   The `Version` value can vary, but the NuGet package of `Swashbuckle.AspNetCore` must exist.

1. If it doesn't exist, run the following command to add the NuGet package.

    ```azurecli
    dotnet add InventoryManagement.ApiApp package Swashbuckle.AspNetCore
    ```

   The latest version of `Swashbuckle.AspNetCore` has been installed.

1. Select `Startup.cs` at the left-hand navigation pane of the editor.
1. Find the `using` directive below at the top of the file. If it doesn't exist, add it.

    ```csharp
    using Microsoft.OpenApi.Models;
    ```

1. Find the code lines for the Swagger generator within the `ConfigureServices` method. If it doesn't exist, add it.

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

1. Find the code lines for the Swagger UI within the `Configure` method. If it doesn't exist, add it.

    ```csharp
    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        /* === SwaggerUI BEGIN === */
        app.UseSwagger(c =>
        {
            c.PreSerializeFilters.Add((swagger, httpReq) => {
                swagger.Servers = new List<OpenApiServer>() { new OpenApiServer() { Url = $"{httpReq.Scheme}://{httpReq.Host.Value}" } };
            });
        });
        app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "InventoryManagement.ApiApp v1"));
        /* === SwaggerUI END === */

        if (env.IsDevelopment())
        {
            app.UseDeveloperExceptionPage();
        }

        app.UseHttpsRedirection();

        app.UseRouting();

        app.UseAuthorization();

        app.UseEndpoints(endpoints =>
        {
            endpoints.MapControllers();
        });
    }
    ```

The Web API application is ready to generate the Open API document.


## Key Takeaways ##

After this unit, you are now able to:

* Add a NuGet package to your existing ASP.NET Core Web API application to activate the Open API feature, and
* Configure the Open API feature on the ASP.NET Core Web API application.


[meet crystal]: ../media/meet-crystal.png

[az apim]: https://docs.microsoft.com/azure/api-management/api-management-key-concepts
