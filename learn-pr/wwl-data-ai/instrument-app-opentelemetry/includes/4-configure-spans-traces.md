Automatic instrumentation captures telemetry from common frameworks like HTTP clients and database libraries, but it can't observe the custom business logic that makes your AI application unique. Operations like embedding generation, vector similarity scoring, prompt assembly, and LLM response parsing are specific to your application and require custom spans to appear in your traces. This unit covers creating custom spans and traces to capture these application-specific operations.

> [!NOTE]
> All code examples in this module use the Azure Monitor OpenTelemetry Distro packages and follow patterns from official Azure SDK documentation. The packages are updated regularly, and the recommendation is to visit the [Azure Monitor OpenTelemetry documentation](/azure/azure-monitor/app/opentelemetry-add-modify) for the most up-to-date information.

## Create custom spans with a tracer

Custom spans let you represent business-specific operations in your trace data. In a RAG pipeline, you might create custom spans for operations like "generate embedding," "search vector index," "assemble prompt," or "call LLM API." These spans appear in the Application Insights end-to-end transaction view alongside automatically collected spans, giving you a complete picture of what your application does to fulfill each request.

In Python, the `opentelemetry.trace` module is the entry point for creating spans. You call `trace.get_tracer("name")` to obtain a tracer for your service or component. The name you provide identifies the instrumentation source in telemetry data. Unlike some other languages, Python requires no more registration steps. Calling `get_tracer()` after `configure_azure_monitor()` is all that's needed because the Distro configures the global tracer provider during setup.

The following code fragment shows how to create a tracer and start a custom span:

```python
# Code fragment - focus on creating a custom tracer and span
from azure.monitor.opentelemetry import configure_azure_monitor
from opentelemetry import trace

configure_azure_monitor()

# Equivalent to creating an instrumentation source — use once per service/component
tracer = trace.get_tracer("embedding-service")

# start_as_current_span is a context manager — the span ends automatically when the block exits
with tracer.start_as_current_span("GenerateEmbedding") as span:
    span.set_attribute("embedding.model", "text-embedding-ada-002")
    span.set_attribute("embedding.token_count", token_count)
    # Embedding generation logic
    embedding = generate_embedding(input_text)
```

The `start_as_current_span` context manager starts the span when the `with` block is entered and ends it automatically when the block exits, whether normally or due to an exception. The span reference inside the `with` block is always valid, so there's no need for null checks.

## Add attributes to spans

Span attributes enrich your trace data with contextual information that helps you filter, search, and analyze traces. For AI applications, attributes like model names, token counts, document IDs, result counts, and user intent categories provide meaningful context that makes traces actionable rather than structural only.

The difference between resource attributes and span attributes is important to understand. Resource attributes describe the service itself and apply to all telemetry from that service. You set resource attributes once during startup, as shown in the previous unit with `service.name` and `service.namespace`. Span attributes describe a specific operation and apply only to the individual span. You set span attributes within the scope of an active span to capture details about that particular operation.

You can set attributes on a span using the `set_attribute()` method. Each attribute is a key-value pair where the key is a string and the value can be a string, number, or boolean:

```python
# Code fragment - focus on adding meaningful attributes to a span
with tracer.start_as_current_span("SearchVectorIndex") as span:
    span.set_attribute("search.index_name", "product-docs")
    span.set_attribute("search.query_vector_dimension", 1536)
    span.set_attribute("search.top_k", 10)
    results = search_index(embedding)
    span.set_attribute("search.result_count", len(results))
    span.set_attribute("search.similarity_threshold", 0.78)
```

When these attributes are exported to Application Insights, they appear in the `customDimensions` column. You can query them using KQL to filter and analyze traces based on specific attribute values, such as finding all traces where the result count was zero or where a particular model was used.

You can follow these best practices when naming attributes. You can use namespaced, descriptive keys like `embedding.model`, `search.result_count`, or `llm.token_count` to avoid collisions with other attribute names. This naming pattern also improves searchability in Application Insights queries. You should avoid using generic keys like `value` or `data` that don't convey meaning when viewed in a trace explorer.

## Control span kinds and status

The span kind indicates what type of operation a span represents, and Application Insights uses this value to classify spans as either requests or dependencies. Choosing the correct span kind ensures your telemetry appears in the right tables and visualizations within Application Insights.

OpenTelemetry defines five span kinds through the `SpanKind` enum in the `opentelemetry.trace` module:

- **`SpanKind.SERVER`:** Represents an incoming request handled by the service. Application Insights maps these spans to the `requests` table.
- **`SpanKind.CLIENT`:** Represents an outgoing call to an external service or resource. Application Insights maps these spans to the `dependencies` table.
- **`SpanKind.INTERNAL`:** Represents an internal operation within the service that doesn't cross process boundaries. Application Insights maps these spans to the `dependencies` table. This is the default when no kind is specified.
- **`SpanKind.PRODUCER`:** Represents a span that initiates an asynchronous operation, such as sending a message to a queue. Application Insights maps these spans to the `dependencies` table.
- **`SpanKind.CONSUMER`:** Represents a span that processes an asynchronous operation, such as receiving a message from a queue. Application Insights maps these spans to the `requests` table.

You can specify the span kind using the `kind` parameter when starting a span:

```python
# Code fragment - focus on setting span kind for an outgoing LLM API call
from opentelemetry.trace import SpanKind

with tracer.start_as_current_span("CallLlmApi", kind=SpanKind.CLIENT) as span:
    span.set_attribute("llm.provider", "azure-openai")
    span.set_attribute("llm.model", "gpt-4o")
    # LLM API call logic
    response = call_llm(prompt)
    span.set_attribute("llm.response_tokens", response.usage.completion_tokens)
```

The Python SDK automatically records exceptions that propagate out of a `start_as_current_span` block and sets the span status to error. If you catch the exception yourself and want to provide a custom error description, you can call `span.record_exception()` and `span.set_status()` explicitly:

```python
# Code fragment - focus on recording errors and exceptions on a span
from opentelemetry.trace import Status, StatusCode

with tracer.start_as_current_span("GenerateEmbedding") as span:
    try:
        embedding = generate_embedding(input_text)
        span.set_status(Status(StatusCode.OK))
    except Exception as ex:
        span.record_exception(ex)
        span.set_status(Status(StatusCode.ERROR, "Embedding generation failed"))
        raise
```

## Model nested operations in a trace

Nested spans create a parent-child hierarchy that represents the logical flow of a request through your application. In Python, you achieve nesting by placing `start_as_current_span` context managers inside one another. When a new span starts while another span is active, the OpenTelemetry SDK automatically sets the active span as the parent of the new one. You don't need to pass parent references explicitly. The SDK tracks the current span for you using Python's context variable mechanism.

This hierarchy is valuable for AI applications because a single request typically involves multiple sequential operations. The parent-child structure shows you exactly which operations happen within the scope of another operation, how long each one takes relative to the total, and where time is spent.

The following code fragment shows how nested spans model a simplified RAG pipeline request flow:

```python
# Code fragment - focus on nested spans modeling a RAG pipeline request flow
from azure.monitor.opentelemetry import configure_azure_monitor
from opentelemetry import trace
from opentelemetry.trace import SpanKind

configure_azure_monitor()
tracer = trace.get_tracer("llm-orchestrator")

def process_query(query: str) -> str:
    with tracer.start_as_current_span("ProcessQuery", kind=SpanKind.SERVER) as root_span:
        root_span.set_attribute("query.length", len(query))

        # Child span: Generate embedding
        with tracer.start_as_current_span("GenerateEmbedding") as embed_span:
            embed_span.set_attribute("embedding.model", "text-embedding-ada-002")
            embedding = embedding_service.generate(query)
            embed_span.set_attribute("embedding.dimensions", len(embedding))

        # Child span: Search vector index
        with tracer.start_as_current_span("SearchVectorIndex") as search_span:
            search_span.set_attribute("search.top_k", 5)
            results = vector_search.search(embedding, top_k=5)
            search_span.set_attribute("search.result_count", len(results))

        # Child span: Call LLM
        with tracer.start_as_current_span("CallLlm", kind=SpanKind.CLIENT) as llm_span:
            prompt = build_prompt(query, results)
            llm_span.set_attribute("llm.prompt_tokens", count_tokens(prompt))
            response = llm_client.get_completion(prompt)
            llm_span.set_attribute("llm.response_tokens", response.usage.completion_tokens)
            return response.content
```

When you view this trace in the Application Insights end-to-end transaction view, you see a waterfall chart. `ProcessQuery` appears as the root span with `GenerateEmbedding`, `SearchVectorIndex`, and `CallLlm` as child spans nested underneath. The timeline shows each operation's duration and its relationship to the overall request time. If `CallLlm` takes eight seconds out of a ten-second total, the visualization makes this bottleneck immediately obvious.

## Additional resources

- [Add custom spans](/azure/azure-monitor/app/opentelemetry-add-modify#add-custom-spans)
- [Add and modify Azure Monitor OpenTelemetry](/azure/azure-monitor/app/opentelemetry-add-modify)
