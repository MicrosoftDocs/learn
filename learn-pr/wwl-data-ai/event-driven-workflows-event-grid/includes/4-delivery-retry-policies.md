AI pipeline endpoints don't always respond successfully on the first attempt. Model services restart, serverless functions experience cold starts, and downstream dependencies go offline temporarily. This unit covers how Event Grid handles delivery failures through its retry mechanism, how to customize retry policies for different AI workload patterns, how to configure dead-letter destinations for events that can't be delivered, and how to monitor delivery outcomes.

## Understand how Event Grid delivers events

Event Grid delivers events by sending an HTTP POST request to the subscriber's endpoint. The subscriber must respond with a success status code (200, 201, 202, 203, or 204) to acknowledge receipt. Any other response code, or no response within the timeout period, triggers a retry. Event Grid waits 30 seconds for a response after delivering a message. If the endpoint hasn't responded within that window, Event Grid queues the message for retry.

Event Grid delivers one event at a time by default, with the payload as an array containing a single event. This default behavior ensures that each event is independently acknowledged and retried. For high-throughput AI workloads, you can enable output batching to group multiple events per delivery request, which reduces HTTP overhead and improves throughput.

Event Grid provides at-least-once delivery, which means that subscribers might receive the same event more than once. This guarantee matters for AI pipelines because it means your handler endpoints must be [idempotent](/azure/architecture/building-blocks/idempotency). Use the event `id` field to detect and deduplicate repeated deliveries. For example, if your inference service receives the same event twice, it should check whether it already processed a result for that event ID before starting a new inference run.

## Examine the retry schedule and error handling

When Event Grid receives an error response, it evaluates the error type to decide whether to retry. Configuration-related errors that can't be fixed with retries are handled differently from transient errors.

The following errors aren't retried because they indicate permanent issues:

- **400 Bad Request:** The event payload is malformed or the endpoint can't process it
- **413 Request Entity Too Large:** The event exceeds the endpoint's size limit
- **403 Forbidden:** The endpoint explicitly rejects the delivery

For webhook endpoints, a 401 Unauthorized response is also not retried. For Azure resource endpoints, 401 and 404 responses trigger a retry after five minutes or more because these errors might resolve as the resource finishes provisioning.

For all other errors, Event Grid applies an exponential backoff retry schedule:

1. 10 seconds
1. 30 seconds
1. One minute
1. Five minutes
1. 10 minutes
1. 30 minutes
1. One hour
1. Three hours
1. Six hours
1. Every 12 hours up to 24 hours

Event Grid adds randomization to retry intervals to spread load and might skip retries if an endpoint appears consistently unhealthy. If the endpoint responds within three minutes, Event Grid attempts to remove the event from the retry queue on a best-effort basis, but duplicates might still be received.

## Customize retry policy settings

You can adjust two parameters when creating an event subscription to control retry behavior. Event Grid uses whichever limit is reached first to stop retrying and either drop or dead-letter the event.

- **Maximum number of attempts:** An integer between one and 30 (default: 30). Event Grid stops retrying after this many delivery attempts.
- **Event time-to-live (TTL):** An integer between one and 1,440 minutes (default: 1,440 minutes, or 24 hours). Event Grid stops retrying after this time elapses from the event's original publish time.

The right configuration depends on your AI workload's latency tolerance. For time-sensitive operations such as real-time content classification, set a shorter TTL so stale events don't consume handler resources when the window for useful processing has passed. For batch processing pipelines that can tolerate delays, use longer TTL values with more retry attempts to maximize the chance of successful delivery.

The following example creates an event subscription with a 30-minute TTL and a maximum of five delivery attempts:

```azurecli
az eventgrid event-subscription create \
    --name moderation-sub \
    --source-resource-id /subscriptions/{sub-id}/resourceGroups/{rg}/providers/Microsoft.EventGrid/topics/ai-events \
    --endpoint https://moderation-service.azurewebsites.net/api/events \
    --max-delivery-attempts 5 \
    --event-ttl 30
```

Keep in mind that the exponential backoff schedule interacts with your TTL setting. With the default retry schedule, only about six delivery attempts complete within the first 30 minutes. Setting max delivery attempts to 10 with a 30-minute TTL has no additional effect because the TTL expires first.

## Configure dead-letter destinations for undeliverable events

When Event Grid exhausts all retry attempts or the event TTL expires, it can send the undelivered event to a [dead-letter destination](/azure/event-grid/manage-event-delivery). Dead-lettering is disabled by default. To enable it, you specify an Azure Blob Storage container as the dead-letter endpoint when creating the event subscription. You must create the storage account and container before configuring dead-lettering.

```azurecli
az eventgrid event-subscription create \
    --name moderation-sub \
    --source-resource-id /subscriptions/{sub-id}/resourceGroups/{rg}/providers/Microsoft.EventGrid/topics/ai-events \
    --endpoint https://moderation-service.azurewebsites.net/api/events \
    --max-delivery-attempts 5 \
    --event-ttl 30 \
    --deadletter-endpoint /subscriptions/{sub-id}/resourceGroups/{rg}/providers/Microsoft.Storage/storageAccounts/{storage-account}/blobServices/default/containers/dead-letters
```

Each dead-lettered event includes diagnostic properties that help you understand why delivery failed. These properties appear alongside the original event data in the dead-letter blob:

- **`deadLetterReason`:** The reason the event was dead-lettered (for example, `MaxDeliveryAttemptsExceeded` or `MaxRetryDurationExceeded`)
- **`deliveryAttempts`:** The number of delivery attempts before the event was dead-lettered
- **`lastDeliveryOutcome`:** The result of the last delivery attempt (for example, `NotFound`, `TimedOut`, `Busy`, or `Forbidden`)
- **`publishTime`:** The UTC time when Event Grid accepted the event
- **`lastDeliveryAttemptTime`:** The UTC time of the last delivery attempt

For AI pipelines, dead-lettered events often indicate systemic issues that need investigation. A batch of dead-lettered events with `lastDeliveryOutcome` of `NotFound` might mean your handler endpoint URL changed. A cluster of `TimedOut` outcomes might indicate that your inference service is overloaded and needs scaling adjustments.

You can also set up an event subscription on the dead-letter Blob Storage container itself. This approach notifies a monitoring service whenever a new dead-lettered event arrives, enabling automated alerting or reprocessing workflows.

## Handle transient failures in AI pipelines

AI handler endpoints experience several categories of transient failures that Event Grid's retry mechanism handles automatically. Model service restarts cause brief periods of unavailability. Serverless functions on consumption plans experience [cold-start latency](/azure/azure-functions/event-driven-scaling#cold-start) that can exceed Event Grid's 30-second response timeout. GPU memory pressure during peak inference loads can cause temporary request failures. Downstream dependency outages, such as a vector database being temporarily unavailable, cause the handler to return error codes.

Event Grid's exponential backoff and retry behavior addresses these transient failures without requiring you to build custom retry logic. However, you should design your handler endpoints to support this pattern:

- **Return appropriate status codes:** Return 200-204 for successful processing. Return 503 if your service is temporarily overloaded. Don't return 400 for transient issues because Event Grid won't retry 400 responses.
- **Implement idempotent processing:** Keep track of event IDs you've already processed. Event Grid's at-least-once guarantee means your handler might receive the same event more than once.
- **Process quickly or acknowledge early:** If your inference operation takes longer than 30 seconds, return 202 (Accepted) immediately and process the event asynchronously. Event Grid interprets a 202 response as successful delivery.

## Enable output batching for high-throughput AI workloads

For AI systems that generate or consume events at high volume, such as processing thousands of document uploads or image classifications, output batching reduces the number of HTTP requests to the handler. You configure batching on the event subscription with two parameters:

- **Maximum events per batch:** An integer between one and 5,000. Event Grid won't exceed this number, but might deliver fewer events if less are available.
- **Preferred batch size in kilobytes:** An integer between one and 1,024. Event Grid targets this batch size, but a single event larger than the preferred size still delivers in its own batch.

```azurecli
az eventgrid event-subscription create \
    --name batch-processor-sub \
    --source-resource-id /subscriptions/{sub-id}/resourceGroups/{rg}/providers/Microsoft.EventGrid/topics/ai-events \
    --endpoint https://batch-processor.azurewebsites.net/api/events \
    --max-events-per-batch 100 \
    --preferred-batch-size-in-kilobytes 512
```

Batching uses all-or-none delivery semantics. The handler must return a success code for the entire batch. If any event in the batch fails, the entire batch is retried. Design your handler to process all events in a batch or reject the entire batch by returning an appropriate error code. Don't set the batch size larger than what your handler can reliably process within the 30-second response timeout.

## Monitor delivery outcomes

Event Grid publishes delivery metrics through [Azure Monitor](/azure/event-grid/monitor-event-delivery) that give you visibility into how events flow through your AI pipeline. Key metrics include:

- **Delivery success count:** Events successfully delivered to handler endpoints
- **Delivery failure count:** Events that failed delivery (individual attempt failures, not final failures)
- **Matched events:** Events that matched at least one subscription filter
- **Dropped events:** Events that matched a subscription but exceeded retry limits without dead-lettering
- **Dead-lettered events:** Events sent to the dead-letter destination after exhausting retries

You can set alerts on these metrics to detect systemic issues in your pipeline. A sudden increase in dead-lettered events might indicate that a model service is down, a handler endpoint URL changed, or a deployment introduced a bug. A drop in matched events might mean that your event source stopped publishing or that a filter configuration changed unexpectedly. Monitoring these metrics alongside your application logs provides a complete picture of event flow health across your AI solution.

## Additional resources

- [Event Grid message delivery and retry](/azure/event-grid/delivery-and-retry)
- [Dead letter and retry policies](/azure/event-grid/manage-event-delivery)
- [Monitor Event Grid message delivery](/azure/event-grid/monitor-event-delivery)
