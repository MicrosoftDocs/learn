In this exercise, you add a new diagnostic project to your **:::no-loc text="eShopLite":::** solution. You'll see how to include the OpenTelemetry NuGet packages, and then add observability to the **Products** service.

## Open the development environment and create the Azure resources

You can choose to use a GitHub codespace that hosts the exercise or complete the exercise locally in Visual Studio Code.

To use a codespace, create a preconfigured GitHub codespace with this [Codespace creation template](https://codespaces.new/MicrosoftDocs/mslearn-dotnet-cloudnative?devcontainer_path=.devcontainer%2Fdotnet-observability%2Fdevcontainer.json).

This step takes several minutes while GitHub creates and configures the codespace. After the process is finished, you see the code files for the exercise. The code used for the rest of this module is in the */dotnet-observability* directory.

To use **Visual Studio Code**, clone the [https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative](https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative) repository to your local machine. Then:

1. Install any [system requiements](https://code.visualstudio.com/docs/devcontainers/containers) to run Dev Container in Visual Studio Code.
1. Make sure Docker is running. 
1. In a new Visual Studio Code window open the folder of the cloned repository
1. Press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the command palette.
1. Search: **>Dev Containers: Rebuild and Reopen in Container**
1. Select **eShopLite - dotnet-observability** from the drop down. Visual Studio Code creates your development container locally.
### Add a diagnostic project to the solution

The first step to adding observability to the **:::no-loc text="eShopLite":::** app is to introduce a new diagnostic project to the solution. This project contains all the OpenTelemetry packages and configurations that you'll use to add observability to the app.

1. In the Visual Studio Code command palette, enter **>.NET: Open Solution**.
1. Select **dotnet-observability/eShopLite/eShopLite.sln**.
1. In the **Solution Explorer**, at the bottom of the **EXPLORER** pane, right-click the **eShopLite** solution and then select **New Project**.
1. In the **Select a template to create a new .NET project** dialog, select **Class Library (Common, Library)**.
1. In the **Name** field, enter **Diagnostics**.
1. In the **Project will be created in** dropdown, select **Default directory**.

### Add OpenTelemetry packages

Now add the OpenTelemetry packages to the new diagnostic project.

1. By using the **TERMINAL** pane at the bottom of Visual Studio Code, go to the *Diagnostics* project folder:

    ```bash
    cd dotnet-observability/eShopLite/Diagnostics
    ```

1. Run these `dotnet add` commands:

    ```dotnetcli
    dotnet add package OpenTelemetry.Exporter.Console
    dotnet add package OpenTelemetry.Extensions.Hosting
    dotnet add package OpenTelemetry.Instrumentation.AspNetCore
    dotnet add package OpenTelemetry.Instrumentation.EventCounters --prerelease
    dotnet add package OpenTelemetry.Instrumentation.Runtime
    dotnet add package OpenTelemetry.Instrumentation.SqlClient --prerelease
    dotnet add package OpenTelemetry.Instrumentation.Http
    ```

1. On the **EXPLORER** pane, expand the *Diagnostics* folder and then select **Diagnostics.csproj**.
1. Change the `Project Sdk` at the top to:

    ```xml
    <Project Sdk="Microsoft.NET.Sdk.Web">
    ```

    The preceding code allows you to use the `IConfiguration` class in your code.
1. In the `<PropertyGroup>`, add the output type:

    ```xml
    <OutputType>Library</OutputType>
    ```

    The preceding code ensures that the project builds as a library. Otherwise, the compiler expects a `Program.cs` file with a `main` method.

### Add the code to use OpenTelemetry

With the OpenTelemetry packages added, you now introduce the code to make use of them.

1. On the **EXPLORER** pane, right-click the *Class1.cs* file and then select **Rename**.
1. Rename the file to **DiagnosticServiceCollectionExtensions.cs**.
1. Replace the code in the file with the following code:

    ```csharp
    using OpenTelemetry.Metrics;
    using OpenTelemetry.Resources;
    using OpenTelemetry.Trace;
    
    namespace Microsoft.Extensions.DependencyInjection;
    
    public static class DiagnosticServiceCollectionExtensions
    {
      public static IServiceCollection AddObservability(this IServiceCollection services,
          string serviceName,
          IConfiguration configuration)
      {
        // create the resource that references the service name passed in
        var resource = ResourceBuilder.CreateDefault().AddService(serviceName: serviceName, serviceVersion: "1.0");
    
        // add the OpenTelemetry services
        var otelBuilder = services.AddOpenTelemetry();
    
        otelBuilder
            // add the metrics providers
            .WithMetrics(metrics =>
            {
              metrics
                .SetResourceBuilder(resource)
                .AddRuntimeInstrumentation()
                .AddAspNetCoreInstrumentation()
                .AddHttpClientInstrumentation()
                .AddEventCountersInstrumentation(c =>
                {
                  c.AddEventSources(
                          "Microsoft.AspNetCore.Hosting",
                          "Microsoft-AspNetCore-Server-Kestrel",
                          "System.Net.Http",
                          "System.Net.Sockets");
                })
                .AddMeter("Microsoft.AspNetCore.Hosting", "Microsoft.AspNetCore.Server.Kestrel")
                .AddConsoleExporter();
    
            })
            // add the tracing providers
            .WithTracing(tracing =>
            {
              tracing.SetResourceBuilder(resource)
                          .AddAspNetCoreInstrumentation()
                          .AddHttpClientInstrumentation()
                          .AddSqlClientInstrumentation();
            });
    
        return services;
      }
    }
    ```

1. On the **TERMINAL** pane, run this command to build the project:

    ```dotnetcli
    dotnet build
    ```
  
    You should see output similar to this example:

    ```console
    Build succeeded.
        0 Warning(s)
        0 Error(s)
    ```
    
1. The **Diagnostics** project is now ready to be used by the **Products** service.
1. On the **EXPLORER** pane, under **SOLUTION EXPLORER**, right-click the **Products** project and then select **Add Project Reference**.
1. Select **Diagnostics**.
1. On the **EXPLORER** pane, expand the *Products* folder and then select **Program.cs**.
1. Under the code comment `// Add observability code here`, add a call to the Diagnostics method:

    ```csharp
    builder.Services.AddObservability("Products", builder.Configuration);
    ```

1. On the **TERMINAL** pane, go to the *Products* folder:

    ```bash
    cd ../Products
    ```

1. Run this command to build the project:

    ```dotnetcli
    dotnet build
    ```
  
    You should see output similar to this example:

    ```console
    Build succeeded.
        0 Warning(s)
        0 Error(s)
    ```

### Update Docker settings and run the app

1. On the **TERMINAL** pane, go to the root of the *dotnet-observability* folder:

    ```bash
    cd ..
    dotnet publish /p:PublishProfile=DefaultContainer
    ```

1. Run these Docker commands:

    ```docker
    cd /workspaces/mslearn-dotnet-cloudnative/dotnet-observability/
    docker compose up 
    ```

    The back-end (**Products** service) and front-end (**Store** service) containers should build. Then the app starts.

1. If you're doing this exercise in a codespace, select the **PORTS** tab at the bottom of the Visual Studio Code window. Select the **Open in browser** link next to the **Front End** service.

1. If you're doing this exercise locally in Visual Studio Code, in a new browser tab, go to the app at `http://localhost:32000`.

1. In the app, select **Products** in the navigation bar.

    :::image type="content" source="../media/eshoplite-products.png" alt-text="A screenshot that shows the Products page in the eShopLite app. The page shows a list of products with a name, description, and price and a button to update the stock." lightbox="../media/eshoplite-products.png":::

1. Select **Update Stock** for several of the products. Then, in the dialog, change the stock value and select **Update**.

1. Select the **TERMINAL** tab and scroll through the messages. Note there are messages from OpenTelemetry like:

    ```console
    backend-1   | Export ec.Microsoft-AspNetCore-Server-Kestrel.connection-queue-length, Meter: OpenTelemetry.Instrumentation.EventCounters/1.5.1.1
    backend-1   | (2023-11-09T19:55:14.8933518Z, 2023-11-09T20:04:44.8596671Z] http.request.method: PUT http.response.status_code: 200 http.route: /api/Stock/{id} network.protocol.name: http network.protocol.version: 1.1 url.scheme: http Histogram      
    backend-1   | Value: Sum: 0.05144170000000001 Count: 4 Min: 0.0039736 Max: 0.0359739
    ```

1. Press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the app.

You successfully added OpenTelemetry to the **Products** service. In the next unit, you'll see how to make better use of the telemetry data by viewing it on tools like Prometheus and Grafana.
