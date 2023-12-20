Now you understand the importance of observability, you'll see how you can include it in your cloud native application. You'll do this by adding OpenTelemetry to your app.

### Add OpenTelemetry to your app

.NET has a rich ecosystem of built-in observability tools that produce logging, metrics, and tracing data. You can use these tools to add observability to your cloud native application. These libraries are:

- **Logging**: `Microsoft.Extensions.Logging.ILogger`
- **Metrics**: `System.Diagnostics.Metrics.Meter`
- **Tracing**: `System.Diagnostics.Activity` and `System.Diagnostics.ActivitySource`

OpenTelemetry consumes all the above telemetry, but first your cloud native app needs to add OpenTelemetry support via NuGet packages. These packages can be categorized into three groups:

|Category  |Package  |Description  |
|---------|---------|---------|
|**Core API**     | [OpenTelemetry](https://github.com/open-telemetry/opentelemetry-dotnet/blob/main/src/OpenTelemetry/README.md)      | The main library that provides the core OpenTelemetry functionality.        |
|**Core API** | [OpenTelemetry.Extensions.Hosting](https://github.com/open-telemetry/opentelemetry-dotnet/blob/main/src/OpenTelemetry.Extensions.Hosting/README.md) | Provides extension methods for automatically starting and stopping OpenTelemetry tracing in ASP.NET Core hosts. |
|**Instrumentation**     | [OpenTelemetry.Instrumentation.AspNetCore](https://github.com/open-telemetry/opentelemetry-dotnet/blob/main/src/OpenTelemetry.Instrumentation.AspNetCore/README.md)       | Instrumentation for ASP.NET Core applications. This collects a great number of metrics about your app without you having to write any code.        |
|**Exporter**     |  [OpenTelemetry.Exporter.Console](https://github.com/open-telemetry/opentelemetry-dotnet/tree/main/src/OpenTelemetry.Exporter.Console/README.md)       | Exporter for the console allows the app to write out telemetry to the console.  |

Many more instrumentation and exporter packages are available to include in your cloud native app. For more information, see [.NET observability with OpenTelemetry](/dotnet/core/diagnostics/observability-with-otel). Depending on the type of app you're building, you can add the packages that are most relevant to you.

This module focuses on using OpenTelemetry with the **eShopLite** cloud native app. As this app is built with .NET Core and Blazor WebAssembly, it means that all the code examples are based on taking advantage of dependency injection.

:::image type="content" source="../media/eshoplite-diagram.png" alt-text="A diagram showing the different components of the eShopLite app. The components are the Product service and Store service inside a block representing the app. There's a separate box that contains all the OpenTelemetry packages: OpenTelemetry.Exporter.Prometheus.AspNetCore, OpenTelemetry.Exporter.Zipkin, OpenTelemetry.Extensions.Hosting, OpenTelemetry.Instrumentation.AspNetCore, OpenTelemetry.Instrumentation.EventCounters, OpenTelemetry.Instrumentation.Runtime, OpenTelemetry.Instrumentation.Http, and Azure.Monitor.OpenTelemetry.AspNetCore." border="false":::

You could choose to include all of the `OpenTelemetry` packages to both the **Products** and **Store** services in the microservices app. However, in a real-world app you'll have many more services, and adding all these packages to each one involves unnecessary duplication. A better approach is to add a new diagnostics project to your solution that any microservice can reference to be observed.

Here's some example code that creates a method `AddObservability` that a microservice can call to use OpenTelemetry:

:::code language="csharp" source="../code/simple-diagnostics.cs" range="7-51" highlight="9-11,16-37,40-48":::

The method returns an `IServiceCollection` that can be added as a service to an ASP.NET Core `WebApplicationBuilder`.

This then creates a variable `var otelBuilder = services.AddOpenTelemetry()` to store the OpenTelemetry builder. The code can then add metrics and traces to `otelBuilder`.

For example, this configuration adds instrumentation for:

- ASP.NET Core
- C# Runtime
- HttpCLient
- Kestrel webserver

These metrics are displayed in the console. The `.AddConsoleExporter()` method adds the exporter to the builder.

It also adds tracing to the console for:

- ASP.NET Core
- HttpClient
- SQL Client

The last line returns the `IServiceCollection`.

With the diagnostic project completed, it's as simple as adding a reference to the project and a single line of code to the service. For example, to include OpenTelemetry in the **Product** service, add the project reference in your `Product.csproj` file:

  ```xml
  <ProjectReference Include="..\Diagnostics\Diagnostics.csproj" />
  ```

Then add the following line to the `Program.cs` file under your declaration of `builder`:

  ```csharp
  var builder = WebApplication.CreateBuilder(args);

  builder.Services.AddObservability("Products", builder.Configuration);
  ```

Let's add this code to the **Products** services in the **eShopLite** app.