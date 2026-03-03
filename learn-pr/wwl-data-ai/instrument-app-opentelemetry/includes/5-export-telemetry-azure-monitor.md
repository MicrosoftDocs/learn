After you instrument your application with the OpenTelemetry SDK and create custom spans, the next step is ensuring that telemetry data flows reliably to Azure Monitor Application Insights. This unit covers how the export pipeline works, how to configure sampling to manage costs, and how to verify that your telemetry data arrives correctly.

> [!NOTE]
> All code examples in this module use the Azure Monitor OpenTelemetry Distro packages and follow patterns from official Azure SDK documentation. The packages are updated regularly, and the recommendation is to visit the [Azure Monitor OpenTelemetry documentation](/azure/azure-monitor/app/opentelemetry-configuration) for the most up-to-date information.

## Understand telemetry export to Application Insights

The telemetry export pipeline moves data from your application to Application Insights through a series of steps. The OpenTelemetry SDK collects telemetry from instrumentation libraries and custom spans. The Azure Monitor exporter serializes that data and sends it to the Application Insights ingestion endpoint identified by your connection string. This entire process happens in-process within your application.

The Azure Monitor OpenTelemetry Distro uses direct export by default. Direct export means the application sends telemetry directly to the Application Insights ingestion endpoint without an intermediary. This approach simplifies deployment because there's no additional infrastructure to manage. The alternative approach uses the OpenTelemetry Collector, a separate process that receives telemetry from applications, processes it, and forwards it to one or more backends. The Collector approach adds operational complexity but provides additional capabilities like centralized sampling, data transformation, and multi-backend routing.

When telemetry arrives in Application Insights, different signal types land in different tables. Understanding this mapping helps you write effective queries:

- **Server spans** (`SpanKind.SERVER` and `SpanKind.CONSUMER`) appear in the `requests` table.
- **Client, internal, and producer spans** (`SpanKind.CLIENT`, `SpanKind.INTERNAL`, and `SpanKind.PRODUCER`) appear in the `dependencies` table.
- **Log records** emitted through Python's `logging` module or the OpenTelemetry logging API appear in the `traces` table.
- **Exceptions** recorded on spans or captured through the `logging` module appear in the `exceptions` table.
- **Custom metrics** recorded through the OpenTelemetry Metrics API appear in the `customMetrics` table.

## Configure sampling to control telemetry volume

Sampling reduces the volume of telemetry data sent to Application Insights by collecting only a percentage of traces. For AI applications that handle high request volumes, sampling is essential for controlling ingestion costs. Without sampling, a service processing thousands of requests per minute generates significant telemetry data that can lead to unexpected costs.

The Azure Monitor OpenTelemetry Distro supports two sampling strategies for traces:

- **Fixed-percentage sampling:** Collects a fixed fraction of all traces. You specify a ratio between 0.0 and 1.0 where 0.1 means approximately 10% of traces are sampled.
- **Rate-limited sampling:** Caps the number of traces collected per second. You specify the maximum traces per second, such as 1.5 for approximately one and a half traces per second.

You can configure fixed-percentage sampling in code using the `sampling_ratio` parameter, or rate-limited sampling using `traces_per_second`:

```python
# Code fragment - focus on configuring sampling via configure_azure_monitor()
from azure.monitor.opentelemetry import configure_azure_monitor

# Fixed-percentage sampling: sample approximately 10% of traces
configure_azure_monitor(
    sampling_ratio=0.1,
)

# Rate-limited sampling: sample approximately 1.5 traces per second
# configure_azure_monitor(
#     traces_per_second=1.5,
# )
```

You can also configure sampling using environment variables, which is useful for adjusting sampling rates without redeploying your application:

```bash
# Fixed-percentage sampling at approximately 10%
export OTEL_TRACES_SAMPLER="microsoft.fixed_percentage"
export OTEL_TRACES_SAMPLER_ARG=0.1
```

```bash
# Rate-limited sampling at approximately 1.5 traces per second
export OTEL_TRACES_SAMPLER="microsoft.rate_limited"
export OTEL_TRACES_SAMPLER_ARG=1.5
```

When both code-level options and environment variables are configured, environment variables take precedence. If you don't configure a sampler at all, the Python Distro uses `RateLimitedSampler` by default.

The trade-off with sampling is important to understand. Lower sampling ratios reduce ingestion costs but decrease the accuracy of aggregated statistics shown in experiences like the Performance and Failures panes. The sampler attaches the sampling ratio to exported spans so Application Insights can adjust experience counts, but the fewer data points collected, the less precise these adjusted counts become. A good starting point is 5% (0.05), and you can adjust based on the accuracy shown in the failures and performance panes.

> [!NOTE]
> Sampling decisions apply to traces (spans) only. Metrics are never sampled. Logs that belong to unsampled traces are dropped by default, but you can opt out of trace-based sampling for logs if needed.

## Enable offline storage and automatic retries

The Azure Monitor exporter caches telemetry locally when the application loses connectivity to the Application Insights ingestion endpoint and retries sending for up to 48 hours. This built-in resilience ensures that temporary network issues or service outages don't result in permanent telemetry data loss.

For Python applications, the exporter uses a subdirectory under the system's temp directory by default. The path is derived from the instrumentation key, process name, username, and application directory. This gives each application on the same host its own isolated storage location: `<tempfile.gettempdir()>/Microsoft-AzureMonitor-<hash>/opentelemetry-python-<instrumentation-key>`.

You can override the default storage directory in production if you need telemetry cached to a specific location:

```python
# Code fragment - focus on configuring offline storage directory
from azure.monitor.opentelemetry import configure_azure_monitor

configure_azure_monitor(
    storage_directory="/var/telemetry/rag-pipeline",
)
```

When application load is high, the exporter might occasionally drop telemetry if the volume exceeds the allowable time window or the maximum file size. In these cases, the exporter prioritizes recent events over older ones. You can also disable offline storage entirely by setting `disable_offline_storage=True`, though this isn't recommended for production environments where connectivity interruptions are possible.

## Verify telemetry data flow

After initial setup, it's important to verify that telemetry data actually arrives in Application Insights. Data might not appear immediately because the SDK batches telemetry before sending and there can be an ingestion delay of a few minutes.

The first step is to check the Application Insights overview pane in the Azure portal. After running your application and generating some traffic, you should see server requests and response times on the overview charts. If these charts show data, your instrumentation is working correctly.

For real-time verification during development, Live Metrics provides a dashboard that displays telemetry data with minimal delay. Live Metrics bypasses the normal ingestion pipeline to show incoming requests, outgoing dependencies, and exceptions as they happen. This feature is useful for verifying that new custom spans and attributes appear correctly before deploying to production. Live Metrics is enabled by default in the Azure Monitor OpenTelemetry Distro.

You can also run a KQL query in the Application Insights Logs section to verify that trace data is available:

```kusto
requests
| where timestamp > ago(1h)
| project timestamp, name, duration, success, cloud_RoleName
| order by timestamp desc
| take 20
```

This query returns the 20 most recent requests from the last hour, showing the operation name, duration, success status, and the cloud role name of the service that handled the request. If you see results, your telemetry pipeline is working end to end. If you see requests from multiple services, context propagation is also functioning correctly, and you can proceed to analyze distributed traces.

## Additional resources

- [Configure Azure Monitor OpenTelemetry](/azure/azure-monitor/app/opentelemetry-configuration)
- [Sampling in Application Insights](/azure/azure-monitor/app/sampling)
