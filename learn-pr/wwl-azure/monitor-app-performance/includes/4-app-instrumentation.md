
Application Insights is enabled through either Auto-Instrumentation (agent) or by adding the Application Insights SDK to your application code.

## Auto-instrumentation

Auto-instrumentation is the preferred instrumentation method. It requires no developer investment and eliminates future overhead related to updating the SDK. It's also the only way to instrument an application in which you don't have access to the source code.

In essence, all you have to do is enable and - in some cases - configure the agent, which collects the telemetry automatically.

The list of services supported by auto-instrumentation changes rapidly, visit this [page](/azure/azure-monitor/app/codeless-overview#supported-environments-languages-and-resource-providers) for a list of what is currently supported.

## Enabling via Application Insights SDKs

You only need to install the Application Insights SDK in the following circumstances:

* You require custom events and metrics
* You require control over the flow of telemetry
* Auto-Instrumentation isn't available (typically due to language or platform limitations)

To use the SDK, you install a small instrumentation package in your app and then instrument the web app, any background components, and JavaScript within the web pages. The app and its components don't have to be hosted in Azure. The instrumentation monitors your app and directs the telemetry data to an Application Insights resource by using a unique token.

The Application Insights SDKs for .NET, .NET Core, Java, Node.js, and JavaScript all support distributed tracing natively.

Additionally, any technology can be tracked manually with a call to `TrackDependency` on the `TelemetryClient`.

## Enable via OpenCensus

In addition to the Application Insights SDKs, Application Insights also supports distributed tracing through OpenCensus. OpenCensus is an open source, vendor-agnostic, single distribution of libraries to provide metrics collection and distributed tracing for services. It also enables the open source community to enable distributed tracing with popular technologies like Redis, Memcached, or MongoDB.
