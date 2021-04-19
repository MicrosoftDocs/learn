In this unit, we look at Monitoring Distributed applications with OpenTelemetry.

## What is OpenTelemetry?

OpenTelemetry is an open source, vendor-agnostic, single distribution of libraries to provide metrics collection and distributed tracing for services.
The Azure core tracing package provides:

- Context propagation, used to correlate activities and requests between services with an initial customer action.
- Tracing user requests to the system, allowing to pinpoint failures and performance issues.

## Getting started with the core tracing

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

# Azure Monitor OpenTelemetry Exporter client library for Java

This client library provides support for exporting OpenTelemetry data to Azure Monitor. This package assumes your
application is already instrumented with the [OpenTelemetry SDK][opentelemetry_sdk] following the [OpenTelemetry Specification][opentelemetry_specification].

## Getting started with the Exporter Library

### Include the Package

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-opentelemetry-exporter-azuremonitor</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>
```

### Authentication

#### Get the instrumentation key from the portal

In order to export telemetry data to Azure Monitor, you will need the instrumentation key to your [Application
 Insights resource][application_insights_resource]. To get your instrumentation key, go to [Azure portal][azure_portal],
search for your resource. On the overview page of your resource, you will find the instrumentation key on the top-right corner.

### Creating exporter for Azure Monitor

```java
AzureMonitorExporter azureMonitorExporter = new AzureMonitorExporterBuilder()
    .connectionString("{connection-string}")
    .buildExporter();
```

#### Exporting span data

The following example shows how to export a collection of available [Spans][span_data] to Azure Monitor through the
 `AzureMonitorExporter`

```java
AzureMonitorExporter azureMonitorExporter = new AzureMonitorExporterBuilder()
    .connectionString("{connection-string}")
    .buildExporter();

CompletableResultCode resultCode = azureMonitorExporter.export(getSpanDataCollection());
System.out.println(resultCode.isSuccess());
```

## Key concepts of the Exporter API

Some of the key concepts for the Azure Monitor exporter include:

- [Opentelemetry][opentelemtry_spec]: OpenTelemetry is a set of libraries used to collect and export telemetry data
 (metrics, logs, and traces) for analysis in order to understand your software's performance and behavior.

- [Instrumentation][instrumentation_library]: The ability to call the OpenTelemetry API directly by any application is
 facilitated by instrumentation. A library that enables OpenTelemetry observability for another library is called an Instrumentation Library.

- [Trace][trace_concept]: Trace refers to distributed tracing. It can be thought of as a directed acyclic graph (DAG) of Spans, where the edges between Spans are defined as parent/child relationship.

- [Tracer Provider][tracer_provider]: Provides a `Tracer` for use by the given instrumentation library.

- [Span Processor][span_processor]: A span processor allows hooks for SDK's `Span` start and end method invocations. Follow the link for more information.

- [Sampling][sampler_ref]: Sampling is a mechanism to control the noise and overhead introduced by OpenTelemetry by reducing the number of samples of traces collected and sent to the backend.

For more information on the OpenTelemetry project, please review the [OpenTelemetry Specifications][opentelemetry_specification].

In the next exercise, we'll configure a sample application and set it up for OpenTelemetry.
