Building an API can be complex because it needs to support many features like routing, reading and writing to data storage, and authentication. To save time, you begin with the frameworks and templates built into .NET, which deliver many of the features you need. However, those frameworks might require considerable setup before you have a basic API up and running. With minimal API for .NET 6, that's not the case. You can get started with just a few lines.

To get started with minimal API, the main requirement is to use at least .NET 6. Then, you need a text editor, such as Visual Studio or Visual Studio Code, or any other text editor of your choice. Finally, you can use either a Windows, macOS, or Linux operating system.

## What is minimal API?

If you've developed a .NET web API, you've used an approach that uses controllers. The idea is to have a controller class method, which represents various HTTP verbs, perform an operation to complete a specific task. For example, `GetProducts()` would return products by using GET as an HTTP verb.

What's the difference between the controller-based approach and minimal API?

- **Streamlined *Program.cs*:** The template for the controller-based web API wires up the controllers using the `AddControllers` method. In addition, it wires up Swagger to provide OpenAPI support. Minimal APIs don't have this wiring by default, though you can add Swagger if you wish.
- **Routing looks a little different:** The routing looks slightly different compared to a controller-based web API. In a web API, for routing you write code as shown:

   ```csharp
   app.UseRouting();
   app.UseEndpoints(endpoints =>
   {
      endpoints.MapControllers();
      // add my own routes
   });
   ```

   With minimal API, you add the route right away on the `app` instance:

   ```csharp
   app.MapGet("/todos", await (TodoDb db) => db.Todos.ToListAsync());
   app.MapPost("/todos", await (Todo todo) => {});
   app.MapPut("/todos", (Todo todo) => {});
   app.MapDelete("/todos/{id}", (int id) => {});
   ```

The same functionality is still there. You still configure a database, set up CORS, and add authentication in much the same way that you're used to.

So, how do you get started?

## Creating an API with minimal API

Let's walkthrough what you're going to learn in this module. This is just an explanation of how it works. Don't do anything yourself yet! 

New projects are created with the `dotnet new` command:

```bash
dotnet new web -o PizzaStore -f net8.0
```

The newly created *PizzaStore* folder contains the API project.

### Generated files

The files generated are much like those you would get with a controller-based API:

```output
bin/
obj/
appsettings.Development.json
appsettings.json
PizzaStore.csproj
Program.cs
```

Inside *PizzaStore.csproj*, there's an entry like this one:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
  <Nullable>enable</Nullable>
</PropertyGroup>
```

This code tells you that you're using .NET 8.

### Understand the code

*Program.cs* contains your API code. Here's an example of what that code looks like:

```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
app.MapGet("/", () => "Hello World!");
app.Run();
```

If you've used earlier versions of .NET, you'll notice the lack of `using` statements. With .NET 6, the compiler figures out `using` statements for you. It's not something you need to care about.

In the first two lines of code, you create a builder. From the `builder`, you construct an application instance `app`:

```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
```

The builder has a `Services` property. By using the `Services` property, you can add features like CORS, Entity Framework, or Swagger. Here's an example:

```csharp
builder.Services.AddCors(options => {});
```

In the `Services` property, you tell the API that here's a capability to use. Conversely, the `app` instance is used to actually use it. So you can use the `app` instance to set up routing:

```csharp
app.MapGet("/", () => "Hello World!");
```

You can also use `app` instance to add middleware. Here's an example of how you would use a capability like CORS:

```csharp
app.UseCors("some unique string");
```

> [!NOTE]
> Middleware is usually code that intercepts the request and carries out checks like checking for authentication or ensuring the client is allowed to perform this operation according to CORS. After the middleware is done executing, the actual request is carried out. Data is either read or written to the store and a response is sent back to the calling client.

Finally, `app.Run()` starts your API and makes it listen for requests from the client.

To run your code, you start your project, like any .NET project, with `dotnet run`. By default, that means you have a project running on *http://localhost:{PORT}*, where `PORT` is a value between 5000 and 5300.

## Adding documentation with Swagger

Documentation is something you want for your API. You want it for yourself, your colleagues, and any third-party developers who might want to use your API. It's key to keep the documentation in sync with your API as it changes. A good approach is to describe your API in a standardized way and ensure it's self-documenting. By *self-documenting*, we mean that if the code changes, the documentation changes with it.

Swagger implements the OpenAPI specification. This format describes your routes but also what data they accept and produce. Swagger UI is a collection of tools that render the OpenAPI specification as a website and let you interact with your API via the website.

To use Swagger and the Swagger UI in your API, you do two things:

- **Install a package.** To install Swagger, you specify to install a package called Swashbuckle, like this:

    ```bash
    dotnet add package Swashbuckle.AspNetCore --version 6.1.4   
    ```

- **Configure it.** After the package is installed, you configure it via your code. You add a few different entries:

   - Add a namespace. You need this namespace when you later call `SwaggerDoc()` and provide the header information for your API.
   
     ```csharp
     using Microsoft.OpenApi.Models;
      ```

   - Add `AddSwaggerGen()`. This method sets up header information on your API, like what it's called and the version number. Note that Swagger should be limited to development time, as it can be a security risk if it's available in production.

     ```csharp
     builder.Services.AddEndpointsApiExplorer();
     if (app.Environment.IsDevelopment())
     {
       builder.Services.AddSwaggerGen(c =>
         {
           c.SwaggerDoc("v1", new OpenApiInfo { Title = "Todo API", Description = "Keep track of your tasks", Version = "v1" });
         });
     ```

   - Add `UseSwagger()` and `UseSwaggerUI()`. These two code lines tell the API project to use Swagger and also where to find the specification file *swagger.json*.

     ```csharp
       app.UseSwagger();
       app.UseSwaggerUI(c =>
        {
          c.SwaggerEndpoint("/swagger/v1/swagger.json", "Todo API V1");
        });
     } // end of if (app.Environment.IsDevelopment()) block
     ```

That's all that's involved with building a minimal API! Starting the project and navigation to *http://localhost:5000/swagger* displays something like this:

:::image type="content" source="../media/swagger-todo-api.png" alt-text="Screenshot of a Swagger example that shows a to-do A P I.":::

Are you ready for some hands-on activities? In the next unit, you'll build your own minimal API!
