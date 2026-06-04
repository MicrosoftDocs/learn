OpenTelemetry structured logging treats each log entry as a queryable data record with defined fields, enabling you to filter, aggregate, and correlate agent decisions across Azure Monitor at production scale.

Unstructured logs fail at scale. Suppose Adventure Works has 14 agents that each log free-text messages. This produces millions of log entries that the operations team can't systematically query. A log message saying "agent CRASHED" indicates something failed, but without structured fields identifying the agent, customer session, operation type, and error classification, the team can't answer critical questions: which agent fails most frequently, which customer tier experiences the most errors, or how error rates correlate with specific model versions.

Structured logging solves this by treating log entries as data records with defined schemas. Instead of parsing free text, you query structured fields—filtering by agent ID, grouping by error type, and joining with trace data to reconstruct complete interaction timelines.

## Design log schema for multi-agent systems

A standardized log schema shared across all agents enables systematic querying and correlation. Every log entry includes fields that identify the execution context, describe the operation, capture performance metrics, and link to distributed trace data.

| Field Category | Fields | Purpose |
|----------------|--------|---------|
| Trace correlation | `trace_id`, `span_id` | Links to distributed trace |
| Agent identity | `agent_id`, `agent_version` | Identifies the agent |
| Session context | `session_id`, `customer_tier` | Links to customer interaction |
| Operation details | `operation_type`, `model_id` | Classifies the work performed |
| Performance metrics | `input_token_count`, `output_token_count`, `latency_ms` | Quantifies resource usage |
| Outcome | `status`, `error_code` | Records success or failure |

This schema supports queries like "show all LLM calls for trace ID xyz" or "calculate P95 latency by agent and operation type for the last 24 hours." Without these structured fields, such queries require unreliable regex parsing of free-text logs.

## Log LLM decision points

LLM calls represent critical decision points in multi-agent systems, but logging the full conversation history for every call creates storage costs and privacy risks. Instead, log the **structured inputs and outputs** at each decision point: the parameters passed to the model, the selected response, and a brief reasoning summary.

For a routing decision, log the classified customer intent (the structured input), the selected target agent (the structured output), and the confidence score. For a tool invocation, log the tool name and parameters (input), the tool response summary (output), and any error codes. This approach captures what the agent decided and why, without storing thousands of tokens of conversation history.

```python
import logging
import json
from datetime import datetime, timezone
from opentelemetry import trace

# Configure structured logging with JSON formatter
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def log_llm_decision(operation_type: str, input_data: dict, output_data: dict, model_id: str):
    """Log structured LLM decision with trace correlation."""
    current_span = trace.get_current_span()
    span_context = current_span.get_span_context()
    
    log_entry = {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "trace_id": format(span_context.trace_id, "032x"),
        "span_id": format(span_context.span_id, "016x"),
        "agent_id": "orchestrator-agent",
        "agent_version": "2.1.0",
        "operation_type": operation_type,  # LLM_ROUTING, TOOL_INVOCATION, etc.
        "model_id": model_id,
        "input": input_data,
        "output": output_data,
        "latency_ms": 340,
        "status": "success"
    }
    
    logger.info(json.dumps(log_entry))

# Example: Log routing decision
log_llm_decision(
    operation_type="LLM_ROUTING",
    input_data={"intent": "product_search", "query": "chocolate truffles"},
    output_data={"target_agent": "product-search-agent", "confidence": 0.94},
    model_id="gpt-4o"
)

# Example: Log tool invocation
log_llm_decision(
    operation_type="TOOL_INVOCATION",
    input_data={"tool": "query_inventory", "sku": "CHOC-TRUF-001"},
    output_data={"available_quantity": 1250, "warehouse_location": "Seattle"},
    model_id="gpt-4o"
)
```

The structured format enables precise queries: "Show all routing decisions with confidence < 0.8 in the last hour" or "Find all tool invocations that took > 1 second."

## Correlate logs with distributed traces

Every log entry must include the current `trace_id` and `span_id` from the OpenTelemetry context. This correlation allows bidirectional navigation: from a span in the distributed trace to all related logs from any agent in the trace, or from a log entry backward to the complete trace timeline.

When debugging a failed customer interaction, you start with the trace ID from the error report. The distributed trace shows the sequence of agent calls and identifies which span reported the error. The correlated logs reveal the detailed decision history within that span—which tool calls failed, what the LLM output was, and how the agent attempted recovery.

```python
from datetime import datetime, timezone
from opentelemetry import trace
from opentelemetry.trace import Status, StatusCode
import logging
import json
import hashlib

logger = logging.getLogger(__name__)

class StructuredLogger:
    """Helper for structured logging with automatic trace correlation."""
    
    def __init__(self, agent_id: str, agent_version: str):
        self.agent_id = agent_id
        self.agent_version = agent_version
    
    def log(self, operation_type: str, status: str, session_id: str = None, 
            customer_tier: str = None, input_token_count: int = 0, 
            output_token_count: int = 0, latency_ms: int = 0, 
            error_code: str = None, **kwargs):
        """Create structured log entry with trace correlation."""
        
        # Get current span context
        current_span = trace.get_current_span()
        span_context = current_span.get_span_context()
        
        # Hash customer ID for privacy
        customer_id_hash = hashlib.sha256(
            session_id.encode()
        ).hexdigest()[:16] if session_id else None
        
        log_entry = {
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "trace_id": format(span_context.trace_id, "032x"),
            "span_id": format(span_context.span_id, "016x"),
            "agent_id": self.agent_id,
            "agent_version": self.agent_version,
            "operation_type": operation_type,
            "status": status,
            "session_id_hash": customer_id_hash,
            "customer_tier": customer_tier,
            "input_token_count": input_token_count,
            "output_token_count": output_token_count,
            "latency_ms": latency_ms,
            "error_code": error_code,
            **kwargs
        }
        
        # Remove None values
        log_entry = {k: v for k, v in log_entry.items() if v is not None}
        
        if status == "error":
            logger.error(json.dumps(log_entry))
        else:
            logger.info(json.dumps(log_entry))
        
        # Also add to span attributes for trace-level visibility
        current_span.set_attribute(f"log.{operation_type}.status", status)
        if error_code:
            current_span.set_status(Status(StatusCode.ERROR))
            current_span.set_attribute("error.code", error_code)

# Usage example
structured_logger = StructuredLogger(
    agent_id="payment-processor-agent",
    agent_version="1.8.2"
)

with trace.get_tracer(__name__).start_as_current_span("process_payment") as span:
    structured_logger.log(
        operation_type="LLM_CALL",
        status="success",
        session_id="session_abc123",
        customer_tier="premium",
        input_token_count=450,
        output_token_count=120,
        latency_ms=890,
        model_id="gpt-4o",
        transaction_amount=45.99
    )
```

## Implement privacy-aware logging

Customer identifiers must be hashed before logging to prevent PII exposure. The `session_id` gets hashed using SHA-256, creating a consistent identifier for querying without storing the actual customer ID. Never log email addresses, physical addresses, payment card numbers, or other regulated data in log entries.

Log only what you need for debugging: transaction amounts (numerical values, not card numbers), product quantities and categories (not customer names), order statuses and error codes (not shipping addresses). This discipline protects customer privacy while preserving diagnostic capability.

> [!TIP]
> Include `trace_id` and `span_id` in every log entry—even entries that don't seem span-related. When an on-call engineer starts with a trace ID from an error report, these fields turn a keyword search into a precise join: one query returns all structured log entries from every agent that touched the same customer interaction, in chronological order. Without them, correlating logs across agents requires guessing at timestamps and session IDs that may not be consistent.

For Adventure Works, the logging policy requires: all customer identifiers hashed with SHA-256, no PII fields in any log entry, and automatic log retention limited to 90 days. The structured logging helper enforces these rules automatically, reducing the risk of accidental PII logging by individual developers.

## Key takeaways

- **Structured log schemas** define consistent fields across all agents—trace correlation, agent identity, session context, operation details, performance metrics, and outcome—enabling systematic querying.
- **LLM decision logging** captures structured inputs and outputs at each decision point rather than full conversation history, balancing diagnostic value with storage costs.
- **Trace correlation** embeds `trace_id` and `span_id` in every log entry, enabling bidirectional navigation between distributed traces and detailed agent decision logs.
- **Privacy-aware logging** hashes customer identifiers with SHA-256 and enforces policies against logging PII, protecting customer data while preserving diagnostic capability.
