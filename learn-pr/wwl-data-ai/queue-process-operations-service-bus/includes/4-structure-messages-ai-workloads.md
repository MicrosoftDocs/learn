How you structure a Service Bus message determines how efficiently your AI pipeline processes requests, how effectively you can trace failures, and how well your system handles payloads of varying sizes. A well-structured message carries all the information the processor needs, includes metadata for routing and tracking, and stays within the size limits of your Service Bus tier. This unit covers message anatomy, payload serialization, correlation tracking, large payload handling, TTL configuration, and batch sending.

## Understand message anatomy

A Service Bus message consists of three parts: the body, application properties, and system properties. The body carries the message payload, which is the primary data you want to transmit. Application properties are custom key-value metadata that you define, useful for routing, filtering, and tracking. System properties are set by Service Bus or the SDK and include values such as `message_id`, `correlation_id`, `content_type`, `time_to_live`, `session_id`, and `sequence_number`.

For AI workloads, the body typically carries serialized inference request data, such as a JSON object containing a prompt, model parameters, and context documents. Application properties carry metadata that processors and subscriptions use for routing decisions and operational tracking, such as the model name, priority level, and document type. System properties provide delivery infrastructure like unique message identification and TTL enforcement.

## Serialize prompts and model parameters

The most common serialization format for AI workload messages is JSON, because it's human-readable, widely supported across languages, and integrates naturally with REST APIs and model serving frameworks. You can structure the message body as a JSON payload containing the fields the processor needs: the prompt text, model name, temperature, maximum tokens, and any context documents or reference data.

Setting the `content_type` property to `application/json` signals clients and processors about the encoding format. The processor deserializes the body on receipt using standard JSON parsing and passes the extracted parameters to the model inference call.

```python
# Code fragment - focus on creating a message with a JSON payload
import json
import uuid
from azure.servicebus import ServiceBusMessage

request_payload = {
    "prompt": "Extract the contract parties and effective date from this document.",
    "model": "gpt-4o",
    "temperature": 0.1,
    "max_tokens": 2000,
    "document_id": "doc-2025-0142"
}

message = ServiceBusMessage(
    body=json.dumps(request_payload),
    content_type="application/json",
    message_id=str(uuid.uuid4()),
    correlation_id="req-abc-12345",
    application_properties={
        "model_name": "gpt-4o",
        "priority": "standard",
        "document_type": "contract"
    }
)
```

> [!NOTE]
> Code examples in this module are patterns to adapt to your specific requirements. They illustrate the SDK's API surface and aren't intended for direct copy-paste into production applications.

The `message_id` uniquely identifies the message within Service Bus. If you enable duplicate detection on the queue, Service Bus uses this ID to discard duplicate submissions within the detection window. Always generate a unique `message_id` per message to avoid accidental deduplication of distinct requests.

## Track requests with correlation IDs

The `correlation_id` property provides end-to-end request tracking across your entire AI pipeline. You can set this property to a unique identifier that the client generates when it submits the original request, such as a UUID or a request ID from the API layer. This same ID follows the request from the API that enqueues it, through the processor that runs inference, into any downstream services that handle results, and back to the results store that the client polls.

When troubleshooting a failed inference, you can search logs, dead-letter queues, and result stores by correlation ID to trace the full lifecycle of a request. This is especially valuable in AI systems where requests flow through multiple asynchronous stages and a failure at any stage can be difficult to correlate with the original request without a consistent tracking ID.

If your system uses distributed tracing with OpenTelemetry, you can propagate the trace context as application properties. This approach connects the message processing span to the originating request span in your tracing backend, providing a unified view of the request's journey across synchronous and asynchronous boundaries.

```python
# Code fragment - focus on propagating trace context in application properties
from opentelemetry import trace

current_span = trace.get_current_span()
span_context = current_span.get_span_context()

message = ServiceBusMessage(
    body=json.dumps(request_payload),
    correlation_id=correlation_id,
    application_properties={
        "traceparent": f"00-{format(span_context.trace_id, '032x')}-{format(span_context.span_id, '016x')}-01",
        "model_name": "gpt-4o"
    }
)
```

## Handle large payloads with the claim-check pattern

Service Bus Standard tier supports messages up to 256 KB, and Premium tier supports up to 100 MB. AI workloads sometimes need to send payloads that exceed these limits, such as full document text for summarization, images for classification, or large batches of embedding vectors. The claim-check pattern addresses this constraint by separating the payload from the message.

With the claim-check pattern, the producer uploads the large payload to Azure Blob Storage (or another durable store) and sends a Service Bus message that contains only the blob URI as a reference. The message body stays small, typically just a JSON object with the storage location and metadata. The processor retrieves the full payload from storage using the URI, processes it, and optionally deletes the blob after successful processing.

```python
# Code fragment - focus on the claim-check pattern for large payloads
import json
from azure.storage.blob import BlobServiceClient
from azure.servicebus import ServiceBusMessage

# Producer: upload the large payload to Blob Storage
blob_service = BlobServiceClient(
    account_url="https://<storage-account>.blob.core.windows.net",
    credential=credential
)
container_client = blob_service.get_container_client("documents")
blob_client = container_client.get_blob_client("doc-2025-0142.pdf")
blob_client.upload_blob(large_document_bytes)

# Send a claim-check message with the blob URI
claim_check = {
    "blob_uri": f"https://<storage-account>.blob.core.windows.net/documents/doc-2025-0142.pdf",
    "document_id": "doc-2025-0142",
    "model": "gpt-4o",
    "operation": "extract"
}

message = ServiceBusMessage(
    body=json.dumps(claim_check),
    content_type="application/json",
    correlation_id="req-abc-12345",
    application_properties={"pattern": "claim-check"}
)
```

The claim-check pattern offers several benefits beyond working within message size limits. It reduces broker throughput costs because the broker transfers only small reference messages rather than large payloads. It works within any tier's size limits, so you don't need to upgrade to Premium solely for large message sizes. It also lets you apply separate access controls to the message metadata and the actual payload, since Blob Storage access can be scoped independently from Service Bus access.

## Set message time-to-live

The `time_to_live` property defines how long a message remains in the queue before expiring. For time-sensitive AI requests, such as real-time classification where a stale result doesn't have value, you can set a shorter TTL so that the message disappears if the processor doesn't reach it in time. Expired messages can be routed to the dead-letter queue when dead-lettering on message expiration is enabled on the queue, providing visibility into messages that weren't processed in time.

```python
# Code fragment - focus on setting time-to-live
from datetime import timedelta
from azure.servicebus import ServiceBusMessage

# Real-time classification: expire after five minutes
urgent_message = ServiceBusMessage(
    body=json.dumps(request_payload),
    time_to_live=timedelta(minutes=5)
)

# Batch processing: expire after 24 hours
batch_message = ServiceBusMessage(
    body=json.dumps(batch_payload),
    time_to_live=timedelta(hours=24)
)
```

For batch processing with relaxed latency requirements, set a longer TTL or omit the property to use the queue's default TTL. The appropriate TTL depends on how time-sensitive the request is and how long the client is willing to wait for a result. Setting TTL values thoughtfully prevents stale requests from consuming processing resources while ensuring legitimate requests have enough time to be processed during load spikes.

## Batch messages for throughput

When you need to send multiple inference requests at once, use `ServiceBusMessageBatch` to group messages into a single send operation. Batching reduces the number of network round trips between your application and the Service Bus broker, which improves throughput when you're sending a large volume of messages. The SDK manages the batch size automatically, ensuring that the total batch doesn't exceed the maximum message size for your tier.

```python
# Code fragment - focus on batch message sending
from azure.servicebus import ServiceBusClient, ServiceBusMessage
from azure.servicebus.exceptions import MessageSizeExceededError
import json

with client.get_queue_sender("inference-requests") as sender:
    batch = sender.create_message_batch()

    for request in pending_requests:
        message = ServiceBusMessage(
            body=json.dumps(request),
            content_type="application/json"
        )
        try:
            batch.add_message(message)
        except MessageSizeExceededError:
            # Batch is full, send the current batch and start a new one
            sender.send_messages(batch)
            batch = sender.create_message_batch()
            batch.add_message(message)

    # Send any remaining messages in the last batch
    if len(batch) > 0:
        sender.send_messages(batch)
```

The `add_message()` method raises a `MessageSizeExceededError` when the message would exceed the batch's size limit. The previous pattern handles this by sending the full batch and starting a new one. This approach ensures that all messages are sent even when the full list doesn't fit in a single batch. For AI workloads that generate many small inference requests in a short period, such as a document processing pipeline that splits a large document into page-level requests, batching significantly reduces send latency.

## Additional resources

- [Service Bus messages, payloads, and serialization](/azure/service-bus-messaging/service-bus-messages-payloads)
- [Claim-check pattern](/azure/architecture/patterns/claim-check)
- [Service Bus quotas](/azure/service-bus-messaging/service-bus-quotas)
