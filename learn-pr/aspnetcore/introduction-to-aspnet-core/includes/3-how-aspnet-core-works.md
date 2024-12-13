An ASP.NET Core app is essentially a .NET app with a Program.cs file that sets up the web app component features you need and gets it running.

The most basic ASP.NET Core app's Program.cs file:

```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello World!");

app.Run();
```

With the previous code:

- A basic ASP.NET Core web application is set up that listens for HTTP GET requests at the root URL ("/") and responds with "Hello World!".
- The app is initialized, configures a single route, and starts the web server.

### Blazor

You can build interactive web UI with ASP.NET Core using Blazor. Blazor is a component-based web UI framework integrated with ASP.NET Core, used for building interactive web UIs using HTML, CSS, and C#.

A reusable Blazor component, such as the following `Counter` component is defined in a *Counter.razor* file:

```razor
@page "/counter"
@rendermode InteractiveServer

<PageTitle>Counter</PageTitle>

<h1>Counter</h1>

<p role="status">Current count: @currentCount</p>

<button class="btn btn-primary" @onclick="IncrementCount">Click me</button>

@code {
    private int currentCount = 0;

    private void IncrementCount()
    {
        currentCount++;
    }
}
```

With the previous code:

- A component is created that displays a counter.
- The @code block contains the component's logic using C#, including a method to increment the counter.
- The counter value is displayed and updated each time the button is clicked.
- A component approach allows for code reuse across different parts of the application and has the flexibility to be run either in the browser or on the server in a Blazor app.

The `Counter` component can be added to any web page in the app by adding the `<Counter />` element.

```razor
@page "/"

<PageTitle>Home</PageTitle>

<h1>Hello, world!</h1>

<Counter />
```

### APIs

ASP.NET Core provides frameworks for building APIs, gRPC services, and real-time apps with SignalR to instantly push data updates to clients.

Basic Minimal API:

```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/hello", () => "Hello, World!");

app.Run();
```

With the previous code:

- A minimal API is set up that listens for HTTP GET requests at the /hello URL and responds with "Hello, World!".
- The `WebApplicationBuilder` is used to configure the app.
- The `MapGet` method defines a route and a handler for GET requests.

### Middleware

ASP.NET Core uses a pipeline of middleware components to handle HTTP requests and responses. This modular approach provides flexibility, allowing you to customize and extend your application's functionality by adding or removing middleware components as needed.

The middleware pipeline processes HTTP requests in a sequential manner, ensuring that each component can perform its designated task before passing the request to the next component in the pipeline.

Adding built-in middleware in the *Program.cs* file:

```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.UseHttpsRedirection();

app.UseRouting();

app.MapStaticAssets();

app.UseAuthentication();

app.UseAuthorization();

app.MapGet("/", () => "Hello World!");

app.Run();
```

In the previous code, several common middleware components were added:

- `UseHttpsRedirection`: Redirects HTTP requests to HTTPS.
- `UseRouting`: Enables routing to map requests to endpoints.
- `MapStaticAssets`: Optimizes the delivery of static files such as HTML, CSS, JavaScript, images and other assets.
- `UseAuthentication`: Adds authentication capabilities.
- `UseAuthorization`: Adds authorization capabilities.
- `app.MapGet`: This is a simple endpoint to demonstrate that the application is running.

### Dependency Injection

ASP.NET Core includes built-in support for dependency injection (DI) for configuring services that are used by the app and its various framework components.

For example, you might want to centrally configure a service using a framework like EntityFramework Core that other parts of your app depend on to access a database. You can configure a database context from EntityFramework Core as a service using dependency injection like this:

```csharp
public class MyDbContext : DbContext
{
    public MyDbContext(DbContextOptions<MyDbContext> options) : base(options) { }
    
    public DbSet<Product> Products { get; set; } = default!;
}

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<MyDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

app.Run();
```

With the previous code:

- A `DbContext` is configured as a service using dependency injection.
- The `WebApplicationBuilder` is used to configure the app.
- The `AddDbContext` method registers the `DbContext` with the dependency injection container.
- The connection string is retrieved from the configuration and used to set up the database context.

### Configuration

ASP.NET Core supports accessing configuration data from a variety of sources, like JSON files, environment variables, and command-line arguments.

Configuring a connection string in an *appsetting.json* file:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=MyDatabase;Trusted_Connection=True;"
  }
}
```

In the Program.cs file:

```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<MyDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

app.Run();
```

With the previous code:

- The connection string is configured in the *appsettings.json* file.
- The `WebApplicationBuilder` is used to configure the app.
- The `AddDbContext` method registers the `DbContext` with the dependency injection container.
- The connection string is retrieved from the configuration and used to set up the database context.

### Monitoring and diagnostics

ASP.NET Core provides a comprehensive suite of tools for monitoring and maintaining the health and performance of your applications. These features can be easily added to your application as middleware components, integrating specific functionalities into your project:

- **Built-in metrics**: ASP.NET Core includes built-in metrics that track various aspects of your application’s performance, such as request rates, response times, and error rates. 
- **Flexible logging framework**: A flexible logging framework is built in, and supports various logging providers, including console, debug, and event source. This helps in capturing detailed logs for diagnostics and monitoring.
- **Tracing**: ASP.NET Core supports distributed tracing, which helps you track the flow of requests across different services and components. This is useful for diagnosing performance issues and understanding the interactions between different parts of your application.
- **OpenTelemetry**: ASP.NET Core integrates with OpenTelemetry, an open-source observability framework for cloud-native software. OpenTelemetry provides standardized APIs and instrumentation for collecting metrics, logs, and traces, enabling you to monitor and diagnose your applications more effectively.
- **Health Checks**: The health checks API allows you to monitor the health of your application and its dependencies. You can configure health checks to report the status of various components, such as databases, external services, and more.
- **Diagnostics Tools**: ASP.NET Core provides various diagnostic tools, such as dotnet-trace, dotnet-dump, and dotnet-gcdump, which help you collect and analyze diagnostic data from your application.
