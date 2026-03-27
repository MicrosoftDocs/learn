Distributed AI applications present unique observability challenges because a single user request often spans multiple services, each with its own runtime, dependencies, and failure modes. Understanding how OpenTelemetry addresses these challenges gives you the foundation to instrument your applications effectively and gain the visibility needed to maintain performance and reliability.

## Understand observability for distributed AI applications

Observability is the ability to understand the internal state of a system by examining its external outputs. For distributed AI workloads that span multiple services, observability is essential because issues like latency spikes, failed requests, or degraded model performance can originate in any service along the request path. Without observability, diagnosing these issues requires guesswork and manual log correlation across separate systems.

Consider what happens when a single user query enters a RAG pipeline. The request touches an API gateway, an embedding generation service, a vector search service, and an LLM orchestration service. If the overall response takes ten seconds instead of two, you need to determine which service contributed the most latency. Was it the embedding generation? The vector search? The LLM API call? Without correlated telemetry, answering this question means opening four separate log outputs, searching for timestamps that roughly align, and hoping the logs capture enough detail to reconstruct the request flow.

Observability rests on three pillars that each provide a different perspective on system behavior:

- **Distributed tracing:** Captures the full path of a request as it moves through services. Traces show you the sequence and timing of operations, making it possible to identify exactly where delays or errors occur. Tracing is the primary focus of this module.
- **Metrics:** Provide aggregate numerical measurements over time, such as request counts, error rates, and response-time percentiles. Metrics help you detect trends and set alerting thresholds for service-level objectives.
- **Logs:** Capture detailed, timestamped records of discrete events within a service. Logs provide the granular detail needed to understand why a specific operation behaved the way it did.

Each pillar complements the others. Metrics tell you that something changed, traces tell you where the problem occurs, and logs tell you why it happened. Together, they provide the comprehensive visibility that AI applications require to meet performance targets and reliability expectations.

## Explore OpenTelemetry as a standard

OpenTelemetry is a vendor-neutral, open-source observability framework maintained by the Cloud Native Computing Foundation (CNCF). It provides a unified set of APIs, SDKs, and tools for generating, collecting, and exporting telemetry data. Microsoft is a Platinum Member of the CNCF and an active contributor to the OpenTelemetry project.

The framework consists of several key components that work together to enable observability:

- **APIs:** Define the interfaces for creating and managing telemetry data. These APIs are stable and designed to be embedded directly in application code and libraries.
- **SDKs:** Implement the APIs and provide configuration options for processing and exporting telemetry. The SDK handles batching, sampling, and resource detection.
- **Instrumentation libraries:** Automatically capture telemetry from common frameworks and libraries without requiring you to write instrumentation code. For example, an HTTP instrumentation library captures incoming and outgoing HTTP request details automatically.
- **Exporters:** Serialize and transmit collected telemetry to backend analysis tools. Different exporters send data to different backends.

Vendor neutrality is a core design principle of OpenTelemetry. You instrument your code once using the OpenTelemetry APIs, and you can export that telemetry to any compatible backend. This means you aren't locked into a specific monitoring vendor. You can send the same telemetry data to Azure Monitor, Jaeger, Prometheus, Grafana, or any other OpenTelemetry-compatible system without changing your instrumentation code.

Microsoft provides the Azure Monitor OpenTelemetry Distro, which bundles the OpenTelemetry SDK with Azure Monitor-specific exporters and commonly used instrumentation libraries. The Distro simplifies setup by packaging everything you need to send telemetry to Application Insights into a single package. It includes automatic instrumentation for popular frameworks, Azure-specific resource detectors, and the Azure Monitor exporter. The exporter handles serialization and transport to the Application Insights ingestion endpoint.

## Understand traces, spans, and context propagation

A trace represents the complete record of a request's journey through a distributed system. Each trace consists of one or more spans that represent individual operations along the request path. Together, the spans in a trace form a tree structure that shows the full sequence and timing of work performed to handle a request.

A span is a named, timed operation within a trace. Each span captures information about a specific unit of work, such as an HTTP request, a database query, or a call to an external API. Every span contains the following key elements:

- **Trace ID:** A globally unique identifier shared by all spans in the same trace. This ID links every operation in the request flow together.
- **Span ID:** A unique identifier for this specific span within the trace.
- **Parent span ID:** The span ID of the parent operation that initiated this span. Root spans don't have a parent.
- **Name:** A descriptive label for the operation the span represents.
- **Start and end timestamps:** The precise timing of the operation, which determines its duration.
- **Attributes:** Key-value pairs that provide additional context about the operation, such as the HTTP method, URL, status code, or custom data like a model name.
- **Status:** Indicates whether the operation succeeded or failed.

The span hierarchy defines the structure of a trace. The root span represents the entry point into the system, such as an incoming HTTP request to the API gateway. Child spans represent downstream operations triggered by the root request. When the API gateway calls the embedding service, that call creates a child span. When the embedding service calls the vector search service, another child span is created under the embedding span. This parent-child relationship forms a tree that visually represents the work done to fulfill the original request.

Context propagation is the mechanism that carries trace and span IDs across service boundaries. Without context propagation, each service would create independent traces with no way to correlate them. OpenTelemetry uses the W3C TraceContext standard to propagate context through HTTP headers. When one service calls another, it includes a `traceparent` header that contains the trace ID and the calling span's ID:

```http
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
```

The `traceparent` header contains four fields separated by hyphens:

- **Version (`00`):** The trace context format version.
- **Trace ID:** A 32-character hexadecimal string that uniquely identifies the trace.
- **Parent span ID:** A 16-character hexadecimal string identifying the calling span.
- **Trace flags (`01`):** Indicates the trace is sampled.

The receiving service reads this header, creates a new span with the same trace ID and the caller's span ID as its parent, and continues the trace. This process ensures that all spans across all services connect into a single, correlated trace.

## Compare OpenTelemetry terminology with Application Insights

When you work with both OpenTelemetry and Azure Monitor Application Insights, understanding how terminology maps between the two systems helps you navigate documentation, write queries, and interpret telemetry data correctly. OpenTelemetry uses its own vocabulary rooted in the open standard, while Application Insights uses terms established before OpenTelemetry became the industry standard.

The following table shows the key term mappings:

| OpenTelemetry concept | Python equivalent | Application Insights term |
|---|---|---|
| Tracer | `trace.get_tracer("name")` | N/A (instrumentation source) |
| Span | `opentelemetry.trace.Span` | Request or Dependency |
| Server Span | `SpanKind.SERVER` | Request |
| Client Span | `SpanKind.CLIENT` | Dependency |
| Internal Span | `SpanKind.INTERNAL` | Dependency |
| Consumer Span | `SpanKind.CONSUMER` | Request |
| Producer Span | `SpanKind.PRODUCER` | Dependency |
| Trace ID | `span.get_span_context().trace_id` | Operation ID |
| Span ID | `span.get_span_context().span_id` | ID or Operation Parent ID |
| Span Attributes | `span.set_attribute()` | `customDimensions` |

Understanding this mapping matters in practice. When you write a KQL query in Application Insights, you search the `requests` table for server spans and the `dependencies` table for client and internal spans. The `operation_Id` field in Application Insights corresponds to the OpenTelemetry trace ID. When you set attributes on a span using `span.set_attribute()` in Python, those values appear in the `customDimensions` column in Application Insights query results. Knowing these mappings prevents confusion and helps you build effective queries and dashboards.

## Additional resources

- [OpenTelemetry overview for Application Insights](/azure/azure-monitor/app/opentelemetry-overview)
- [W3C Trace Context specification](https://www.w3.org/TR/trace-context/)
