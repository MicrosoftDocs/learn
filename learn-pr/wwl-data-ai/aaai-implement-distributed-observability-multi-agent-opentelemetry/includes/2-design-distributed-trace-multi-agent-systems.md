OpenTelemetry provides distributed tracing primitives that propagate a shared trace ID across every agent in a multi-agent system, giving you a single correlated view of each customer interaction in Azure Monitor.

Single-service tracing creates one span per operation with parent-child relationships contained within the service boundary. A multi-agent system changes the challenge: a single customer request creates a trace that spans many services, each representing a different agent. Without correlation, you have 14 separate logs with no way to link them. Distributed tracing solves this by propagating trace IDs across all agents, creating a unified view of the entire customer journey.

| Tracing Type | Scope | Challenge | Solution |
|--------------|-------|-----------|----------|
| Single-service | One agent | Track operations within boundaries | Parent-child spans |
| Multi-agent distributed | 14+ agents | Correlate across service boundaries | Trace context propagation |

## Understand OpenTelemetry concepts for multi-agent systems

OpenTelemetry provides the primitives you need to trace distributed multi-agent interactions. A **trace** represents the entire customer interaction from initial request to final response, spanning all agents involved. A **span** captures one agent's contribution to that trace—for example, the product search agent's work or the payment processing agent's transaction. Each span contains timing information, status, attributes describing the operation, and crucially, a **span context** that includes both a trace ID and span ID.

The span context gets propagated across agent boundaries using the W3C Trace Context standard. When the orchestrator agent calls the product search agent, it includes a `traceparent` HTTP header carrying the trace context: `00-{trace-id}-{parent-span-id}-{trace-flags}`. The receiving agent extracts this context, creates a child span with the same trace ID but a new span ID, performs its work, and propagates the context forward to any downstream agents it calls.

Without explicit propagation, each agent creates a new trace ID and you lose the correlation. With proper propagation, all 14 agents' spans share the same trace ID, allowing you to reconstruct the complete interaction flow.

## Propagate trace context in Microsoft Foundry agents

When one Microsoft Foundry agent calls another using the SDK, the trace context doesn't propagate automatically—you must inject it explicitly. The OpenTelemetry API provides context extraction and injection methods that work across HTTP boundaries.

At the calling agent, you extract the current span context from the active span and inject it into the outgoing request headers. The receiving agent's entry point extracts the trace context from incoming headers and sets it as the active context before processing begins. This ensures that all operations within the receiving agent create child spans under the same trace.

```python
from opentelemetry import trace
from opentelemetry.trace.propagation.tracecontext import TraceContextTextMapPropagator
import httpx
import os

tracer = trace.get_tracer(__name__)
propagator = TraceContextTextMapPropagator()

# Calling agent: inject trace context into HTTP call to downstream agent endpoint
def call_product_search_agent(query: str):
    with tracer.start_as_current_span("orchestrator_to_product_search") as span:
        # Inject current span context into outgoing HTTP headers
        headers = {}
        propagator.inject(headers)
        
        # Call downstream agent's A2A endpoint with propagated trace context
        response = httpx.post(
            url=os.environ["PRODUCT_SEARCH_AGENT_ENDPOINT"],
            json={"input": query},
            headers=headers,
            timeout=30.0
        )
        response.raise_for_status()
        
        span.set_attribute("agent.downstream", "product-search-agent")
        span.set_attribute("query.length", len(query))
        
        return response.json()

# Receiving agent: extract trace context from incoming headers
def product_search_entry(request):
    # Extract parent context from headers
    context = propagator.extract(request.headers)
    
    # Start span as child of extracted context
    with tracer.start_as_current_span("product_search_execution", context=context) as span:
        span.set_attribute("agent.id", "product-search-agent")
        result = execute_search(request.query)
        return result
```

This pattern ensures that the orchestrator's span and the product search agent's span share the same trace ID and form a parent-child relationship in the distributed trace.

## Configure Azure Monitor as the OpenTelemetry backend

Azure Monitor serves as the centralized backend for all OpenTelemetry telemetry data. The Azure Monitor OpenTelemetry Distro for Python automatically configures exporters that send traces, metrics, and logs to your Application Insights resource. Once configured, all spans from all agents appear in the Application Insights distributed trace view.

The Application Insights transaction details page renders the full trace as a waterfall diagram, showing each agent's span in sequence with timing information and parent-child relationships visualized. When a customer interaction fails, you select the trace ID from error logs and view the complete end-to-end flow, identifying exactly which agent span reported an error and how long each agent took to process its portion of the request.

```python
from azure.monitor.opentelemetry import configure_azure_monitor
from opentelemetry import trace

# Configure Azure Monitor exporter
configure_azure_monitor(
    connection_string="InstrumentationKey=<your-key>;IngestionEndpoint=https://..."
)

tracer = trace.get_tracer(__name__)

# All spans automatically export to Azure Monitor
with tracer.start_as_current_span("agent_operation") as span:
    span.set_attribute("agent.id", "order-management")
    span.set_attribute("operation.type", "place_order")
    # Span automatically exported on completion
```

## Design an instrumentation strategy

You can't instrument every line of code—the cost in storage and the noise in trace visualization make it impractical. Instead, instrument at **semantic boundaries**: points where meaningful work transitions between components or where failures have distinct operational implications.

Focus instrumentation on agent entry and exit points, LLM API calls, tool invocations, and agent-to-agent calls. Each of these boundaries represents a distinct operation with its own latency characteristics and failure modes. Don't instrument individual loop iterations, variable assignments, or internal helper functions—these create span clutter without adding diagnostic value.

For Adventure Works' 14-agent system, this strategy creates approximately 40-60 spans per typical customer interaction: one entry span per agent, 2-4 LLM calls per agent, 1-2 tool invocations per agent, and orchestration spans linking them together.

## Apply sampling strategies

Full-fidelity tracing for every request becomes expensive at Adventure Works' scale—millions of daily interactions mean millions of traces. Sampling reduces cost while preserving diagnostic capability. **Head-based sampling** makes the sampling decision at trace start: sample 1% of all requests randomly. This approach works well for volume reduction but can miss rare error cases.

**Tail-based sampling** makes the decision after seeing the complete trace: sample 100% of error traces, 10% of high-latency traces (>5 seconds), and 1% of successful traces. This approach preserves all diagnostic information for failures while reducing storage costs for routine operations. Azure Monitor's OpenTelemetry Distro supports custom sampling configurations through the `OTEL_TRACES_SAMPLER` environment variable.

```python
import os
from opentelemetry.sdk.trace import SpanProcessor, ReadableSpan
from opentelemetry.trace import StatusCode

# Head-based sampling: 5% of all traces
os.environ["OTEL_TRACES_SAMPLER"] = "traceidratio"
os.environ["OTEL_TRACES_SAMPLER_ARG"] = "0.05"

# For tail-based behavior, use a SpanProcessor — NOT a Sampler.
# Sampler.should_sample() fires at span START before execution,
# so error status and duration attributes are not yet available.
# SpanProcessor.on_end() fires AFTER the span completes, making
# all final attributes accessible.
class ErrorAndLatencyProcessor(SpanProcessor):
    """
    Post-execution span processor for tail-based alerting and filtering.
    Evaluates spans after completion when error status and duration are set.
    For full tail-based drop/keep sampling at scale, use the
    OpenTelemetry Collector tail-sampling processor.
    """

    def on_start(self, span, parent_context=None):
        pass

    def on_end(self, span: ReadableSpan):
        duration_ns = (span.end_time or 0) - (span.start_time or 0)
        duration_ms = duration_ns / 1_000_000

        is_error = span.status.status_code == StatusCode.ERROR
        is_high_latency = duration_ms > 5000

        if is_error or is_high_latency:
            # Forward to alerting system, custom exporter, or incident pipeline
            pass  # Always retain these spans

    def shutdown(self):
        pass

    def force_flush(self, timeout_millis: int = 30000):
        return True
```

Sampling configuration balances cost control with diagnostic completeness. For production multi-agent systems, tail-based sampling provides the best trade-off: complete visibility into failures while managing storage costs for successful interactions.

## Distributed tracing as a Microsoft Foundry capability

The distributed tracing architecture you've built \u2014 W3C trace context propagated across agent boundaries, OpenTelemetry spans for every LLM call and tool invocation, Azure Monitor as the centralized backend \u2014 maps to the tracing capability named in Microsoft Foundry. Microsoft Foundry's tracing capability provides the observability surface where you can view end-to-end execution flows across all agents in a workflow.

Azure Monitor and Application Insights are the underlying implementation: OpenTelemetry SDKs in each agent export spans to Azure Monitor, which renders them as waterfall diagrams in Application Insights. Foundry's observability UI surfaces these same traces within the Foundry project context, enabling you to correlate agent execution with the model invocations, tool calls, and thread-level events that Foundry manages.

**Alerting** is a core element of the tracing capability. Beyond passive trace visualization, your tracing implementation should configure Azure Monitor alert rules that fire when key trace metrics breach thresholds: P95 span duration exceeding SLO targets, error-rate SLIs crossing alert thresholds, or anomalous agent-to-agent call patterns detected by the anomaly detection policies in Unit 5. Alerting converts passive observability into active incident detection \u2014 without it, you only discover problems when customers report them.

## Key takeaways

- **W3C Trace Context** propagates trace IDs across agent boundaries via `traceparent` headers, linking all agents' spans into a single unified trace.
- **Explicit context injection** — Microsoft Foundry agent-to-agent calls don't propagate trace context automatically, so you must inject it explicitly.
- **Azure Monitor** serves as the centralized OpenTelemetry backend, rendering full traces as waterfall diagrams in Application Insights.
- **Semantic boundary instrumentation** focuses spans on agent entry/exit points, LLM calls, tool invocations, and agent-to-agent calls rather than internal operations.
- **Sampling strategies** balance cost and diagnostic completeness—tail-based sampling captures 100% of errors while reducing storage for successful traces.
