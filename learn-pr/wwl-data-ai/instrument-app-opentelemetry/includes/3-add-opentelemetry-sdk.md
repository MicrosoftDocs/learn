Adding the OpenTelemetry SDK to your application is the first step toward capturing telemetry data. This unit covers installing the Azure Monitor OpenTelemetry Distro, understanding what it collects automatically, and configuring the essential settings that route telemetry to Application Insights.

> [!NOTE]
> All code examples in this module use the Azure Monitor OpenTelemetry Distro packages and follow patterns from official Azure SDK documentation. The packages are updated regularly, and the recommendation is to visit the [Azure Monitor OpenTelemetry documentation](/azure/azure-monitor/app/opentelemetry-enable) for the most up-to-date information.

## Choose an instrumentation approach

Azure Monitor supports two primary instrumentation approaches, and choosing the right one depends on your hosting environment and the level of control you need over telemetry collection. Understanding the trade-offs between these approaches helps you make the right decision for your AI application.

**Autoinstrumentation** enables telemetry collection through configuration without modifying application code. This approach works well for supported hosting environments like Azure App Service, Azure Functions, and Azure Virtual Machines, and it provides a quick path to basic observability. However, autoinstrumentation offers limited control over what other telemetry is collected and how you enrich it with custom data.

**Manual instrumentation** uses the OpenTelemetry SDK embedded in your application code. This approach gives you full control over telemetry collection, including the ability to create custom spans, add custom attributes, and configure sampling. For AI applications where you need to capture business-specific operations like embedding generation timing or LLM token usage, SDK-based instrumentation is the preferred choice.

The Azure Monitor OpenTelemetry Distro is the recommended SDK-based approach. It's an [OpenTelemetry distribution](https://opentelemetry.io/docs/concepts/distributions/#what-is-a-distribution) that bundles the OpenTelemetry SDK with Azure Monitor exporters and commonly used instrumentation libraries into a single package. The Distro simplifies setup by providing everything you need to start collecting and exporting telemetry to Application Insights with minimal configuration.

## Install the Azure Monitor OpenTelemetry Distro

The Azure Monitor OpenTelemetry Distro for Python is distributed as a single pip package that includes the OpenTelemetry SDK, the Azure Monitor exporter, and automatic instrumentation libraries for common frameworks. You can install it with the following command:

```bash
pip install azure-monitor-opentelemetry
```

The minimal setup calls `configure_azure_monitor()` once at application startup. This single call initializes the tracer provider, the meter provider, and the logger provider, and configures all of them to export to Application Insights:

```python
# Code fragment - focus on minimal OpenTelemetry setup with Azure Monitor
from azure.monitor.opentelemetry import configure_azure_monitor

configure_azure_monitor()
```

## Understand automatic data collection

The Azure Monitor OpenTelemetry Distro automatically collects telemetry from common frameworks and libraries without requiring you to write any instrumentation code. This automatic collection provides immediate visibility into your application's behavior as soon as you install and configure the Distro.

For Python applications, automatic collection includes the following instrumentation libraries:

- **`requests` library:** Captures outgoing HTTP calls as client spans. Each call to an external service or API, such as an embedding endpoint or an LLM API, is recorded as a dependency in Application Insights.
- **`urllib` / `urllib3`:** Captures outgoing HTTP calls made through Python's built-in `urllib` module and the `urllib3` library as client spans.
- **Flask / Django / FastAPI:** Captures incoming HTTP requests as server spans, including route, status code, and duration. These appear as requests in Application Insights.
- **`psycopg2`:** Captures PostgreSQL database queries as dependency spans, including the database name and query execution time.
- **Azure SDK:** Captures calls to Azure services made through Azure SDK client libraries. This provides visibility into operations like storage access, message queue interactions, and secret retrieval from Key Vault.

Python's standard `logging` module is also integrated automatically. The Distro connects the OpenTelemetry logging pipeline to Python's built-in logging infrastructure, which means logs produced through `logging.getLogger()` flow into Application Insights without extra configuration.

This automatic collection reduces boilerplate significantly. For many common scenarios in AI applications, such as capturing HTTP calls to embedding APIs, database queries for document retrieval, or Azure SDK calls to storage services, developers don't need to write any instrumentation code. The Distro handles these automatically.

## Configure the connection string

The connection string is the configuration value that tells the Azure Monitor exporter where to send telemetry data. It's unique to each Application Insights resource and contains the ingestion endpoint URL and an instrumentation key. Without a valid connection string, the exporter can't deliver telemetry to Application Insights.

You can configure the connection string using three approaches, listed here in order of preference for production environments:

**Environment variable (recommended for production):** You can set the `APPLICATIONINSIGHTS_CONNECTION_STRING` environment variable, and the Distro picks it up automatically without any code changes. This approach keeps sensitive configuration out of your source code and makes it easy to change per environment.

```bash
export APPLICATIONINSIGHTS_CONNECTION_STRING="InstrumentationKey=00000000-0000-0000-0000-000000000000;IngestionEndpoint=https://eastus-0.in.applicationinsights.azure.com/"
```

**Code-based configuration:** You can pass the connection string directly to `configure_azure_monitor()`. This approach is the least recommended for production because it embeds credentials in source code.

```python
# Code fragment - focus on code-based connection string configuration
from azure.monitor.opentelemetry import configure_azure_monitor

configure_azure_monitor(
    connection_string="InstrumentationKey=00000000-0000-0000-0000-000000000000;IngestionEndpoint=https://eastus-0.in.applicationinsights.azure.com/"
)
```

When you set the connection string in multiple places, the Distro follows this precedence order: code takes the highest priority, followed by environment variable.

## Set the cloud role name

When multiple services in a distributed application send telemetry to the same Application Insights resource, each service needs a distinct cloud role name to appear as a separate node on the Application Map. Without unique role names, all services appear as a single node, making it impossible to distinguish between them when debugging distributed request flows.

The cloud role name derives from the `service.name` and `service.namespace` OpenTelemetry resource attributes. Application Insights uses `service.namespace` combined with `service.name` to form the cloud role name. If `service.namespace` isn't set, Application Insights falls back to using `service.name` alone. You can also set the `service.instance.id` attribute to distinguish between multiple instances of the same service.

The following code fragment shows how to configure resource attributes in a Python application using `configure_azure_monitor()`:

```python
# Code fragment - focus on setting cloud role name via resource attributes
from azure.monitor.opentelemetry import configure_azure_monitor
from opentelemetry.sdk.resources import Resource

configure_azure_monitor(
    resource=Resource.create({
        "service.name": "embedding-service",
        "service.namespace": "rag-pipeline",
        "service.instance.id": "embedding-instance-1",
    })
)
```

In this example, the embedding service appears on the Application Map with the cloud role name "rag-pipeline.embedding-service". Each service in your RAG pipeline should use its own `service.name` value, such as "api-gateway", "embedding-service", "vector-search-service", and "llm-orchestrator". Using a consistent `service.namespace` across all services groups them together logically on the Application Map.

You can also set resource attributes through environment variables without modifying code:

```bash
export OTEL_SERVICE_NAME="embedding-service"
export OTEL_RESOURCE_ATTRIBUTES="service.namespace=rag-pipeline,service.instance.id=embedding-instance-1"
```

## Additional resources

- [Enable Azure Monitor OpenTelemetry](/azure/azure-monitor/app/opentelemetry-enable)
- [Add and modify Azure Monitor OpenTelemetry](/azure/azure-monitor/app/opentelemetry-add-modify)
