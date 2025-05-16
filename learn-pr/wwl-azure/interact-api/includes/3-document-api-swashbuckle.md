Swashbuckle is a NuGet package that provides a way to automatically generate Swagger documentation for ASP.NET Web API projects. Swagger is a tool that helps developers design, build, document, and consume RESTful APIs. With Swashbuckle, you can easily add Swagger documentation to your Web API project by annotating your code with attributes that describe your API endpoints, parameters, and responses. Swashbuckle then uses this information to generate a Swagger JSON file, which can be used to generate interactive API documentation, client SDKs, and more.

There are three main components to Swashbuckle:

* [Swashbuckle.AspNetCore.Swagger](https://www.nuget.org/packages/Swashbuckle.AspNetCore.Swagger/): a Swagger object model and middleware to expose SwaggerDocument objects as JSON endpoints.

* [Swashbuckle.AspNetCore.SwaggerGen](https://www.nuget.org/packages/Swashbuckle.AspNetCore.SwaggerGen/): a Swagger generator that builds SwaggerDocument objects directly from your routes, controllers, and models. It's typically combined with the Swagger endpoint middleware to automatically expose Swagger JSON.

* [Swashbuckle.AspNetCore.SwaggerUI](https://www.nuget.org/packages/Swashbuckle.AspNetCore.SwaggerUI/): an embedded version of the Swagger UI tool. It interprets Swagger JSON to build a rich, customizable experience for describing the web API functionality. It includes built-in test harnesses for the public methods.

The following `dotnet add` command installs the Swashbuckle NuGet package:

```dotnetcli
dotnet add <name>.csproj package Swashbuckle.AspNetCore -v 6.5.0
```

## Add and configure Swagger middleware

Add the Swagger generator to the services collection in `Program.cs`. 

```csharp
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
```

> [!NOTE]
> The call to `AddEndpointsApiExplorer` shown in the previous example is only required for minimal APIs.

Enable the middleware for serving the generated JSON document and the Swagger UI, also in `Program.cs`:

```csharp
app.UseSwagger();
if (app.Environment.IsDevelopment())
{
    app.UseSwaggerUI();
}
```

The default endpoint for the Swagger UI is `http:<hostname>:<port>/swagger`.

[!INCLUDE[SwaggerUI Note](../../../includes/swaggerui-security-note.md)]

## Customize and extend the Swagger documentation

Swagger provides options for documenting the object model and customizing the UI. The configuration action passed to the `AddSwaggerGen` method can include additional information through the `OpenApiInfo` class.

The following code sample shows how to add information to display in the API documentation.

```csharp
// Add using statement for the OpenApiInfo class
using Microsoft.OpenApi.Models;

builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Version = "v1",
        Title = "Fruit API",
        Description = "API for managing a list of fruit their stock status.",
        TermsOfService = new Uri("https://example.com/terms")
    });
});

```

The Swagger UI displays the version and the added information:

:::image type="content" source="../media/api-information.png" alt-text="Screenshot showing additional descriptive information added to an API.":::

You can group operations in your API with the `.WithTags` option. You can also add descriptive text describing the operation with the `.WithSummary` option. The following sample code shows using `.WithTags` to group the POST operation into both a *post* group, and a *fruit* group. It also adds the summary specified in the `.WithSummary` option to the operation.

```csharp
app.MapPost("/fruits", async (Fruit fruit, FruitDb db) =>
{
    db.Fruits.Add(fruit);
    await db.SaveChangesAsync();

    return Results.Created($"/{fruit.Id}", fruit);
})
    .Produces<Fruit>(201)
    .WithTags("post", "fruits")
    .WithSummary("Create a new fruit");
```

The Swagger UI displays the specified grouping and summary description. 

:::image type="content" source="../media/api-options-example.png" alt-text="Screenshot of the Swagger UI displaying the post operation in two groups with a summary description.":::

