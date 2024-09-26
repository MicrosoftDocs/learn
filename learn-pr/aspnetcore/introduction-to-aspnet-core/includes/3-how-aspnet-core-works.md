Now that you know what ASP.NET Core is and what it can do, let’s overview how the modular architecture of ASP.NET Core allows you to quickly construct a modern web app to fit your specific needs.

## Project templates

ASP.NET Core provides project templates to create new ASP.NET Core projects with the necessary files, folders, and configurations to get a project up and running efficiently. For example, you can select a template that creates a ready to run web API or Blazor web app.

All .NET project templates offer customization options to tailor the generated project to specific needs and extend it with additional services. For instance, you can add Entity Framework Core for database access, authentication, OpenAPI, caching, logging, and more, enabling the application to effectively meet specific requirements.

## Key architecture components

### Front-end development

ASP.NET Core supports a variety of front-end development approaches, allowing you to choose the best tools and frameworks for your project. Whether you prefer traditional server-side rendering or modern client-side frameworks.

#### Blazor

Blazor is a framework for building interactive web UI components using C# instead of JavaScript. Blazor can run on WebAssembly (client-side) or on the server, allowing you to create rich, interactive web applications with a single codebase. Blazor offers two integrated hosting models that span both the front end and the server-side:

- Blazor WebAssembly: Runs on WebAssembly (client-side), allowing you to create rich, interactive web applications with a single codebase.
- Blazor Server: Runs on the server, providing a rich, interactive user experience with real-time updates over a SignalR connection.

#### MVC and more:

- **MVC**: For server-side rendering, ASP.NET Core also offers MVC (Model-View-Controller). MVC provides a powerful pattern for building dynamic web applications with a clear separation of concerns. 
- **Integration with Front-End Frameworks**: ASP.NET Core seamlessly integrates with popular client-side frameworks like React, Angular, and Vue. This allows you to build modern, single-page applications (SPAs) while applying ASP.NET Core’s robust backend capabilities. ASP.NET Core provides project templates for React, Angular, and Vue making it easy to get started.

### The middleware pipeline

The middleware pipeline in ASP.NET Core is a series of components that process HTTP requests and responses. This modular approach allows you to customize and extend the functionality of your application by adding or removing middleware components as needed:

- **Request handling**: Middleware components handle various aspects of request processing, such as authentication, authorization, logging, and error handling. Each middleware component can either process the request and pass it to the next component or short-circuit the pipeline and generate a response.
- **Built-in middleware**: ASP.NET Core includes a variety of built-in middleware components for common tasks, such as serving static files, enabling CORS (Cross-Origin Resource Sharing), and supporting WebSockets for real-time communication.
- **Custom middleware**: You can create custom middleware to handle specific requirements of your application. For example, you might create middleware to handle custom logging, request validation, or response modification.
- **Real-time communication with SignalR**: SignalR is one of the many services that can be added to the ASP.NET Core modular middleware pipeline. It enables real-time web functionality by allowing server-side code to push updates to clients instantly. It's used for real-time interactions, such as chat applications, live dashboards, and collaborative tools.

### Adding Built-in Components

ASP.NET Core’s modular architecture allows you to easily add built-in components and services to your application. For example, you can add and configure the built-in logging service to capture and manage logs.

In the following example logging services are added in an ASP.NET Core *Program.cs* file. The *Program.cs file* is the entry point of your ASP.NET Core application. It sets up the application host, configures services, and defines the request handling pipeline. This demonstrates how to quickly plug in a built-in service like logging into your ASP.NET Core application. You can add other built-in services such as authentication, Entity Framework Core, or middleware components by following a similar pattern:

```csharp
var builder = WebApplication.CreateBuilder(args);

// Add built-in logging service
builder.Logging.ClearProviders();
builder.Logging.AddConsole();
builder.Logging.AddDebug();

var app = builder.Build();

app.MapGet("/", () => "Hello World!");

app.Run();
```

In the previous sample in the *Program.cs*:

- `builder.Logging` is used to add and configure built-in logging providers. In this example, we clear any existing providers and add the *Console* and *Debug* logging providers.
- `app.MapGet`: This is a simple endpoint to demonstrate that the application is running.

### Server-side development

ASP.NET Core provides a robust and flexible backend for building a wide range of applications, from simple web apps to complex, distributed systems.

- **Dependency injection**: ASP.NET Core has built-in support for dependency injection, a design pattern that promotes loose coupling and testability. This makes it easier to manage dependencies and configure services in your application.
- Data Access: ASP.NET Core supports various data access technologies, including Entity Framework Core (EF Core) for ORM (Object-Relational Mapping) and Dapper for lightweight data access. These tools help you interact with databases and manage data efficiently.
- **API development**: ASP.NET Core is well-suited for building APIs, with support for both RESTful APIs and gRPC. RESTful APIs are ideal for web-based communication, while gRPC offers high performance and efficient communication for real-time applications and microservices.
- **Background Tasks**: ASP.NET Core allows you to run background tasks using hosted services. This is useful for tasks that need to run independently of user requests, such as processing messages from a queue or performing scheduled maintenance.

### Add libraries and tools with NuGet Package Management

[NuGet](https://www.nuget.org/) is the primary tool for managing .NET packages, including those for ASP.NET Core. It allows you to easily add additional libraries and tools to your projects, facilitating code reuse and collaboration.

- **Adding functionality**: Use NuGet packages to integrate libraries like Entity Framework Core, logging frameworks, or authentication tools into your ASP.NET Core projects.
- **Package repository**: NuGet provides a central repository for discovering and integrating third-party libraries.  You can also create and share your own NuGet packages with your team or the .NET community.

### Monitoring and maintenance

ASP.NET Core provides a comprehensive suite of tools for monitoring and maintaining the health and performance of your applications. These features can be easily added to your application as middleware components, integrating specific functionalities into your project:

- **Application Insights**: Integrated with Azure Monitor, this tool collects request rates, response times, failure rates, and exceptions. It provides powerful analytics and visualization tools to help you understand your application’s performance and usage patterns.
- **Built-in metrics**: ASP.NET Core includes built-in metrics that track various aspects of your application’s performance, such as request rates, response times, and error rates. 
- **Flexible logging framework**: A flexible logging framework is built in, and supports various logging providers, including console, debug, and event source. This helps in capturing detailed logs for diagnostics and monitoring.
- **Tracing**: ASP.NET Core supports distributed tracing, which helps you track the flow of requests across different services and components. This is useful for diagnosing performance issues and understanding the interactions between different parts of your application.
- **Health Checks**: The health checks API allows you to monitor the health of your application and its dependencies. You can configure health checks to report the status of various components, such as databases, external services, and more.
Diagnostics Tools: ASP.NET Core provides various diagnostic tools, such as dotnet-trace, dotnet-dump, and dotnet-gcdump, which help you collect and analyze diagnostic data from your application.
