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

In the next exercise, we'll configure a sample application and set it up for OpenTelemetry.
