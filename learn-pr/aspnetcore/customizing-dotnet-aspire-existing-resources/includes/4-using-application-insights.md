The .NET Aspire dashboard provides a functional view of telemetry data but if you're familiar with Azure Application Insights, you know that it provides a rich and ongoing analysis of an application's performance, structure, and behavior.

In your outdoor equipment retailer, your administrators, who already use Application Insights to support other important business systems, have requested that your new eShop sends telemetry to Application Insights.

In this unit, you'll learn how to configure a .NET Aspire solution to integrate with Azure Application Insights when it's deployed.

## OpenTelemetry and Application Insights

Observability is a key feature of cloud-native applications. Once they're deployed, your administration team needs to know how they behave and use resources to ensure timely responses to user requests. The .NET Aspire solution templates include the OpenTelemetry package and use it to generate behavior and performance telemetry data whenever a .NET Aspire solution runs. By default, this telemetry data is available in the .NET Aspire dashboard.

In Azure, you have other tools for analyzing and displaying telemetry. Azure Monitor is a comprehensive system that you can use to collect, display, and analyze the behavior of both your entire cloud and on-premises systems. Azure Monitor includes Application Insights, which provides rich visualizations to help you analyze the behavior of your solution.

:::image type="content" source="/azure/azure-monitor/app/media/app-insights-overview/app-insights-overview-screenshot.png" lightbox="/azure/azure-monitor/app/media/app-insights-overview/app-insights-overview-screenshot.png" alt-text="Screenshot showing a complex distributed app analyzed and displayed in Application Insights.":::

If you want to use Application Insights to analyze your .NET Aspire solution, you can configure it to send OpenTelemetry data to Application Insights on deployment.

> [!NOTE]
> There are two approaches to this configuration. You can either deploy a new instance of Application Insights with your .NET Aspire application or use an existing instance. Let's discuss these approaches separately.

## Provisioning Application Insights during .NET Aspire deployment

This approach is appropriate if you don't already have an instance of Application Insight in your Azure subscription. You can also use this technique if you want your .NET Aspire solution to have a dedicated instance of Application Insights.

Take the following steps:

1. Add the NuGet package **Aspire.Hosting.Azure.ApplicationInsights** to the app host project.
1. In the app host's _Program.cs_ file, create an Application Insights resource:

    ```csharp
    var insights = builder.AddAzureApplicationInsights("AppInsights");
    ```

1. Send a reference for that resource to every project that uses Application Insights:

    ```csharp
    var apiService = builder.AddProject<Projects.ApiService>("apiservice")
        .WithReference(insights);

    builder.AddProject<Projects.Web>("webfrontend")
        .WithReference(apiService)
        .WithReference(insights);
    ```

When you deploy the .NET Aspire solution by using Visual Studio or the Azure Developer CLI, the tool creates a new instance of Application Insights in your subscription and connects the .NET Aspire microservices to it. As users make requests, you see telemetry describing the solution's behavior in the Azure portal.

## Connecting to an existing Application Insights instance

If you already have an instance of Application Insights, then you need to configure your .NET Aspire solution with its location. Specify this location by adding a connection string to your app host project.

You can find the connection string on the **Overview** page for your Application Insight instance in the Azure portal:

:::image type="content" source="/dotnet/aspire/docs/deployment/media/app-insights-connection-string.png" lightbox="/dotnet/aspire/docs/deployment/media/app-insights-connection-string.png" alt-text="Screenshot showing where to find the Application Insights connection string in the Azure portal.":::

In your app host's _Program.cs_ file, create a connection string resource and pass it to each microservice:

```csharp
var builder = DistributedApplication.CreateBuilder(args);

var insightsConnectionString = builder.AddConnectionString(
    "myInsightsResource",
    "APPLICATIONINSIGHTS_CONNECTION_STRING");

var apiService = builder.AddProject<Projects.ApiService>("apiservice")
    .WithReference(insightsConnectionString);

builder.AddProject<Projects.Web>("webfrontend")
    .WithReference(apiService)
    .WithReference(insightsConnectionString);

builder.Build().Run();
```

When you deploy the .NET Aspire solution, the tool prompts for a value for this connection string. Copy and paste the correct value from the Azure portal.

## Using the Azure Monitor OpenTelemetry Exporter

The Azure Monitor Distro client library in a .NET library that you can use to make OpenTelemetry export to Application Insights easier. You can enable it by taking three steps in a .NET Aspire solution:

1. Add the client library to Service Defaults project:

    ```dotnetcli
    dotnet add package Azure.Monitor.OpenTelemetry.AspNetCore --version 1.2.0
    ```

1. In the _ServiceDefaults\Extensions.cs** file, add a `using` statement at the top:

    ```csharp
    using Azure.Monitor.OpenTelemetry.AspNetCore
    ```

1. In the `AddOpenTelemetryExporters()` method, uncomment these lines of code:

    ```csharp
    if (!string.IsNullOrEmpty(builder.Configuration["APPLICATIONINSIGHTS_CONNECTION_STRING"]))
    {
        builder.Services.AddOpenTelemetry()
        .UseAzureMonitor();
    }
    ```

## Learn more

- [Use Application Insights for .NET Aspire telemetry](/dotnet/aspire/deployment/azure/application-insights)
- [Azure Monitor Distro client library for .NET](https://www.nuget.org/packages/Azure.Monitor.OpenTelemetry.AspNetCore)
