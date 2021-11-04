Building an API can be complex as it needs to support many features like routing, reading and writing to a data storage, authentication and more. To save time, you begin with the .NET frameworks, which deliver many of the features you need. Even those frameworks might require a fair bit of setup before you even have a basic API up and running. With minimal API for .NET 6, that's not the case, it's just a few lines to get started.

What do I need to get started with minimal API? There's only one major requirement, at least use .NET 6. After that you need a text editor like for example, Visual Studio, Visual Studio Code or any text editor of your choice. For operating system, you can be on either Windows, macOS or Linux.

## What is minimal API?

If you've developed a .NET Core web API, you've been using an approach using controllers. The idea is to have a controller class which methods represent various an HTTP verb and a specific task, for example `GetProducts()` would return products using GET as HTTP Verb.

So what's the difference between this controller-based approach and the minimal API?

- **No _Startup.cs_**. When you build a minimal API, you don't need a _Startup.cs_, instead, all the things you are used to doing, happens in _Program.cs_, like setting up routes, configuring dependency injections, security, CORS, and so on.
- **Top level statements**. Because minimal API uses .NET 6, you can use top-level statements. Here's what a program looks like that doesn't use it:

   ```csharp
   using System;

    namespace Application
    {
        class Program
        {
            static void Main(string[] args)
            {
                Console.WriteLine("Hello World!");
            }
        }
    }   
   ```

   Note the use of a program class, a `Main()` method, and even a `using` statement. With a top-level statement, all of that disappears and you are left with only this line of code:

   ```csharp
   Console.WriteLine("Hello World!");
   ```

   The minimal API uses this technique to bring down the number of lines you need to type. To create an API, there's only these lines that you need to use:

   ```csharp
   var builder = WebApplication.CreateBuilder(args);
   var app = builder.Build();
   app.MapGet("/", () => "Hello World!");
   app.Run();
   ```

   There's no `usings`, no `Main()` method, no class, just four lines of code.

- **Routing looks a little different**. You may have noticed from the above that routing looks slightly different, compare to a controller-based web API. In a web API, you would write code like so, for routing:

   ```csharp
   app.UseRouting();
   app.UseEndpoints(endpoints =>
   {
      endpoints.MapControllers();
      // add my own routes
   });
   ```

   In minimal API, you add the route straight away on the `app` instance like so:

   ```csharp
   app.MapGet("/todos", await (TodoDb db) => db.Todos.ToListAsync());
   app.MapPost("/todos", await (Todo todo) => {});
   app.MapPut("/todos", (Todo todo) => {});
   app.MapDelete("/todos/{id}", (int id) => {}});
   ```

Worth saying again, the same functionality is still there, you still configure a database, set up CORS, add authentication in much the same that you are used to.

So how to get started?

## Create an API with minimal API

The first thing you need to do is to install .NET 6. One you have it installed, you are ready to create a minimal API project. On the command line, you would then run this code to create a minimal API project:

```bash
dotnet new web -o PizzaStore -f net6.0
```

It will create a folder _PizzaStore_ containing your API project.

### Inspect the files

You get much the same files as you would a controller-based API like:

```output
bin/
obj/
appsettings.Development.json
appsettings.json
PizzaStore.csproj
Program.cs
```

Looking inside of _PizzaStore.csproj_ you see an entry like so:

```xml
<PropertyGroup>
  <TargetFramework>net6.0</TargetFramework>
  <Nullable>enable</Nullable>
</PropertyGroup>
```

This code tells you that you are using .NET 6.

_Program.cs_ is what holds your API, lets look at the content of this file next.

### Understand the code

_Program.cs_ contains your API code, let's have a closer look at a program example:

```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
app.MapGet("/", () => "Hello World!");
app.Run();
```

If you have used earlier versions of .NET, you will note the lack of using statements. With .NET 6, the compiler figures out using statements for you; it's not something you need to care about.

> [!NOTE]
> As you add more features, like Entity Framework for example, you will need to add `using` statements, but for a simple API like the above, you don't need them yet.

In the first two lines of code, you create a builder, and from the `builder` as well as constructing an application instance `app`:

```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
```

The builder has a `Services` property. By using said property, you can add features like CORS, Entity Framework, or Swagger for example. Here's an example:

```csharp
builder.Services.AddCors(options => {});
```

In the `Services` property, you tell the API that here's a capability to use. Conversely, the `app` instance is more used to say "let's actually use it." So you can use the `app` instance to set up routing for example:

```csharp
app.MapGet("/", () => "Hello World!");
```

You can also use `app` instance to add middleware, here's an example of how you would use a capability like CORS:

```csharp
app.UseCors("some unique string");
```

> [!NOTE]
> Middleware is usually code that intercepts the request and carries out some checks like checking for authentication, or ensuring the client is allowed to perform this operation according to CORS and so on. After the middleware is done executing, the actual request is carried out and data is either read or written to the store and some response is sent back to the calling client.

Finally, `app.Run()` starts your API and makes it listen for requests from the client.

To run your code, you start your project, like any .NET Core project with `dotnet run`. By default, that means you have a project running on `http://localhost:5000` and `https://localhost:5001`.

## Add documentation with Swagger

Documentation is something you want for your API, for the sake of you and your colleagues but also for any eventual third-party developers that might want to use your API. It's key to keep the documentation in sync with your API as it changes. A good approach is to describe your API in a standardized way and ensure it's self-documenting. By _self-documenting_, we mean that if the code changes, the documentation changes with it. 

Swagger implements the Open API specification, a format that describes your routes but also what data they accept and produces. Swagger UI is a collection of tools, which renders the Open API specification as website and lets you interact with your API via said website.

To use Swagger and Swagger UI in your API, you need to do two things:

- **Install a package**. To install Swagger, you specify to install a package called Swashbuckle, like so:

   ```bash
   dotnet add package Swashbuckle.AspNetCore --version 6.1.4   
   ```

- **Configure it**. Once you have the package installed, it's time to configure the package via your code. There are few different entries you need to add:

   - Add namespace. You need this namespace when you later call `SwaggerDoc()` and provide the header information for your API.
   
       ```csharp
       using Microsoft.OpenApi.Models;
       ```

   - `AddSwaggerGen()`. This method will set up some header information on your API, what it's called, its version number and so on.

   ```csharp
   builder.Services.AddEndpointsApiExplorer();
   builder.Services.AddSwaggerGen(c =>
    {
        c.SwaggerDoc("v1", new OpenApiInfo { Title = "Todo API", Description = "Keep track of your tasks", Version = "v1" });
    });
   ```

   - `UseSwagger()` and `UseSwaggerUI()`. These two code lines will tell the API project to use Swagger and also where to find the specification file _swagger.json_

   ```csharp
   app.UseSwagger();
   app.UseSwaggerUI(c =>
    {
       c.SwaggerEndpoint("/swagger/v1/swagger.json", "Todo API V1");
    });
   ```

At this point, you are set up and you are able to start your project and go to `http://localhost:5000/swagger` and you should see something like this:

:::image type="content" source="../media/swagger-todo-api.png" alt-text="Screenshot of a Swagger example that shows a to do A P I.":::
