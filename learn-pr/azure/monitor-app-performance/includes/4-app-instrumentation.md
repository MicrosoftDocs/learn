At a basic level, "instrumenting" is simply enabling an application to capture telemetry. There are two methods to instrument your application:

*   Automatic instrumentation (autoinstrumentation)
*   Manual instrumentation

**Autoinstrumentation** enables telemetry collection through configuration without touching the application's code. Although it's more convenient, it tends to be less configurable. It's also not available in all languages. See [Autoinstrumentation supported environments and languages](/azure/azure-monitor/app/codeless-overview). When autoinstrumentation is available, it's the easiest way to enable Azure Monitor Application Insights.

**Manual instrumentation** is coding against the Application Insights or OpenTelemetry API. In the context of a user, it typically refers to installing a language-specific SDK in an application. This means that you have to manage the updates to the latest package version by yourself. You can use this option if you need to make custom dependency calls or API calls that are not captured by default with autoinstrumentation. There are two options for manual instrumentation:

*   [Application Insights SDKs](/azure/azure-monitor/app/asp-net-core)
*   [Azure Monitor OpenTelemetry Distros](/azure/azure-monitor/app/opentelemetry-enable).

## Enabling via Application Insights SDKs

You only need to install the Application Insights SDK in the following circumstances:

* You require custom events and metrics
* You require control over the flow of telemetry
* Auto-Instrumentation isn't available (typically due to language or platform limitations)

To use the SDK, you install a small instrumentation package in your app and then instrument the web app, any background components, and JavaScript within the web pages. The app and its components don't have to be hosted in Azure. The instrumentation monitors your app and directs the telemetry data to an Application Insights resource by using a unique token.

A list of SDK versions and names is hosted on GitHub. For more information, visit [SDK Version](https://github.com/microsoft/ApplicationInsights-dotnet/blob/develop/docs/versions_and_names.md).

## Enable via OpenTelemetry

Microsoft worked with project stakeholders from two previously popular open-source telemetry projects, [OpenCensus](https://opencensus.io/) and [OpenTracing](https://opentracing.io/). Together, we helped to create a single project, OpenTelemetry. OpenTelemetry includes contributions from all major cloud and Application Performance Management (APM) vendors and lives within the [Cloud Native Computing Foundation (CNCF)](https://www.cncf.io/). Microsoft is a Platinum Member of the CNCF.

Some legacy terms in Application Insights are confusing because of the industry convergence on OpenTelemetry. The following table highlights these differences. OpenTelemetry terms are replacing Application Insights terms.

| Application Insights | OpenTelemetry |
| --- | --- |
| Autocollectors | Instrumentation libraries |
| Channel | Exporter |
| Codeless / Agent-based | Autoinstrumentation |
| Traces | Logs |
| Requests | Server Spans |
| Dependencies | Other Span Types (Client, Internal, etc.) |
| Operation ID | Trace ID |
| ID or Operation Parent ID | Span ID |

