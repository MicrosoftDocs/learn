In this unit, we look at Monitoring Distributed spplications with OpenTelemetry.

## What is OpenTelemetry?

OpenTelemetry is an open source, vendor-agnostic, single distribution of libraries to provide metrics collection and distributed tracing for services.
The Azure core tracing package provides:

- Context propagation, used to correlate activities and requests between services with an initial customer action.
- Tracing user requests to the system, allowing to pinpoint failures and performance issues.

## Getting started

### Include the package

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opentelemetry</artifactId>
  <version>1.0.0-beta.9</version>
</dependency>
```

## Key concepts

### Trace

A trace is a tree of spans showing the path of work through a system. A trace on its own is distinguishable by a unique 16-byte sequence called a TraceID.

### Span

A span represents a single operation in a trace. A span could be representative of an HTTP request, a remote procedure call (RPC), a database query, or even the path that a code takes.

## Examples

The following sections provide examples of using the azure-core-tracing-opentelemetry plugin with some of the Azure Java SDK libraries:

### Using the plugin package with HTTP client libraries

- Synchronously create a secret using [azure-security-keyvault-secrets][azure-security-keyvault-secrets] with tracing enabled.

    Users can additionally pass the value of the current tracing span to the SDKs using key **PARENT_SPAN_KEY** on the [Context][context] parameter of the calling method.
    The plugin package creates a root span to encapsulate all the child spans created in the calling methods when no parent span is passed in the context.
    This [sample][sample_key_vault] provides an example when no user parent span is passed.

    ```java
    // Get the Tracer Provider
    static TracerSdkProvider tracerProvider = OpenTelemetrySdk.getTracerProvider();
    private static final Tracer TRACER = configureOpenTelemetryAndLoggingExporter();

    public static void main(String[] args) {
       doClientWork();
    }

    public static void doClientWork() {
       SecretClient client = new SecretClientBuilder()
         .endpoint("<your-vault-url>")
         .credential(new DefaultAzureCredentialBuilder().build())
         .buildClient();

       Span span = TRACER.spanBuilder("user-parent-span").startSpan();
       try (Scope scope = TRACER.withSpan(span)) {

           // Thread bound (sync) calls will automatically pick up the parent span and you don't need to pass it explicitly.
           secretClient.setSecret(new Secret("secret_name", "secret_value));

           // Optionally, to specify the context you can use
           // final Context traceContext = new Context(PARENT_SPAN_KEY, span);
           // secretClient.setSecretWithResponse(new Secret("secret_name", "secret_value", traceContext));
       } finally {
           span.end();
       }
    }
    ```

### Using the plugin package with AMQP client libraries

Send a single event/message using [azure-messaging-eventhubs][azure-messaging-eventhubs] with tracing enabled.

Users can additionally pass the value of the current tracing span to the EventData object with key **PARENT_SPAN_KEY** on the [Context][context] object:

```java
// Get the Tracer Provider
private static TracerSdkProvider tracerProvider = OpenTelemetrySdk.getTracerProvider();
private static final Tracer TRACER = configureOpenTelemetryAndLoggingExporter();

private static void doClientWork() {
    EventHubProducerClient producer = new EventHubClientBuilder()
        .connectionString(CONNECTION_STRING)
        .buildProducerClient();

    Span span = TRACER.spanBuilder("user-parent-span").startSpan();
    try (Scope scope = TRACER.withSpan(span)) {
        EventData event1 = new EventData("1".getBytes(UTF_8));
        event1.addContext(PARENT_SPAN_KEY, span);

        EventDataBatch eventDataBatch = producer.createBatch();

        if (!eventDataBatch.tryAdd(eventData)) {
            producer.send(eventDataBatch);
            eventDataBatch = producer.createBatch();
        }
    } finally {
        span.end();
    }
}
```

In the next exercise, we'll configure a sample application and set it up for OpenTelemetry.
