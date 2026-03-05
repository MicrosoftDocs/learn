The structure of your events determines how Event Grid routes, filters, and delivers them to subscribers. This unit covers how to design events using the CloudEvents schema for AI operations, define custom event types that represent meaningful state changes, and configure event subscription filters to route events based on type, subject, or data attributes.

> [!NOTE]
> All code examples in this module are based on the most recent version of the `azure-eventgrid` library at the time of writing. The library is updated often and the recommendation is to visit the [Azure Event Grid SDK for Python](https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/eventgrid/azure-eventgrid) site for the most up-to-date information.

## Choose between Event Grid schema and CloudEvents schema

Event Grid supports two event schemas: the proprietary Event Grid schema and the open [CloudEvents v1.0 schema](/azure/event-grid/cloud-event-schema). CloudEvents is the recommended format for new implementations because it provides a standardized, protocol-agnostic event structure backed by the Cloud Native Computing Foundation (CNCF). The standardization means that events produced by your AI services can interoperate with any system that supports CloudEvents, not just Azure Event Grid.

CloudEvents simplifies multi-platform integration with a minimal set of required attributes and a well-defined extension mechanism. If your AI pipeline involves components outside of Azure, CloudEvents ensures consistency across boundaries. Event Grid natively supports CloudEvents JSON format and HTTP protocol binding, so you don't need to transform events before publishing or consuming them.

The proprietary Event Grid schema remains available for backward compatibility. Existing Azure [system events](/azure/event-grid/system-topics) can be delivered in CloudEvents format by configuring the output schema on the event subscription. However, CloudEvents-to-Event Grid schema conversion isn't supported because CloudEvents supports extension attributes that the Event Grid schema doesn't accommodate.

## Understand the CloudEvents schema structure

A CloudEvents event contains required attributes that identify the event and optional attributes that provide additional context. For AI operations, each attribute plays a specific role in routing and filtering decisions.

The following example shows a CloudEvents JSON event for a completed inference operation in a content moderation pipeline:

```json
{
    "specversion": "1.0",
    "type": "com.contoso.ai.InferenceCompleted",
    "source": "/services/content-moderation",
    "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "time": "2025-09-15T14:30:00Z",
    "subject": "/pipelines/moderation/batch-42",
    "datacontenttype": "application/json",
    "data": {
        "modelName": "content-classifier-v3",
        "requestId": "req-78901",
        "resultLocation": "https://storage.blob.core.windows.net/results/batch-42.json",
        "processingDurationMs": 1250,
        "status": "success",
        "itemsProcessed": 150
    }
}
```

The required attributes serve the following purposes:

- **`specversion`:** Identifies the CloudEvents specification version. Always set this to `"1.0"`.
- **`type`:** Categorizes the event. This field drives event type filtering. Use a reverse-DNS naming convention to avoid collisions across organizations and services.
- **`source`:** Identifies the originating system or component. Combine with `type` to uniquely identify the context in which the event happened.
- **`id`:** Provides a unique identifier for this specific event. Subscribers use this field to detect and deduplicate repeated deliveries.

The optional attributes add context that enables more granular routing:

- **`subject`:** Provides a path for filtering. Set this to a hierarchical value that reflects the event context, enabling prefix and suffix filtering on subscriptions.
- **`time`:** Records when the event occurred in UTC. Useful for monitoring and debugging.
- **`datacontenttype`:** Describes the format of the data payload, typically `"application/json"`.
- **`data`:** Carries the event payload with operation-specific details.

## Design custom event types for AI workflows

Well-designed event types make your event-driven AI pipeline easier to filter, monitor, and extend. Each event type should represent a meaningful state change that at least one subscriber needs to know about. Define types using a reverse-DNS naming convention to avoid collisions with events from other teams or services.

Common event types for AI applications include:

- **`com.contoso.ai.InferenceCompleted`:** Published when an inference request finishes processing
- **`com.contoso.ai.EmbeddingsRefreshed`:** Published when a vector embedding index is updated
- **`com.contoso.ai.BatchProcessingStarted`:** Published when a batch processing job begins
- **`com.contoso.ai.AnomalyDetected`:** Published when the system identifies an anomaly in incoming data
- **`com.contoso.ai.ModelRetrained`:** Published when a model completes a retraining cycle
- **`com.contoso.ai.ContentClassified`:** Published when a content moderation classification finishes

Keep the event payload small and focused. Include enough context for the subscriber to begin processing, such as a resource URI, model name, processing duration, and a result summary. Don't embed full inference results in the event data. Instead, include a reference (like a storage URL) that the subscriber uses to retrieve detailed results from a data store.

## Configure event type filtering

Event subscriptions can filter events by type to ensure that each handler receives only the events it needs. This approach keeps handlers focused and avoids unnecessary invocations. For AI workflows where different services process different event types, type filtering routes each event to the right handler without custom routing logic in your code.

You can configure event type filtering when you create an event subscription. The `--included-event-types` parameter accepts a list of event types that the subscription delivers. Events with types not in the list are filtered out before delivery. The following example creates an event subscription that only receives inference completion events:

```azurecli
az eventgrid event-subscription create \
    --name inference-handler-sub \
    --source-resource-id /subscriptions/{sub-id}/resourceGroups/{rg}/providers/Microsoft.EventGrid/topics/ai-events \
    --endpoint https://inference-handler.azurewebsites.net/api/events \
    --included-event-types com.contoso.ai.InferenceCompleted
```

You can include multiple event types in a single subscription by listing them separated by spaces. A monitoring service that tracks both inference completions and anomaly detections would include both types in its subscription filter.

## Apply subject filtering for granular routing

The `subject` field enables path-based filtering using prefix and suffix matches. For AI applications, set the subject to a hierarchical path that reflects the event context, such as `/pipelines/embeddings/batch-42` or `/models/classification/v3`. Subscribers can then filter events based on where in the hierarchy the event originated.

Subject filtering uses two parameters on the event subscription:

- **`subjectBeginsWith`:** Matches events whose subject starts with the specified prefix. Use this to route events from a specific pipeline or service category.
- **`subjectEndsWith`:** Matches events whose subject ends with the specified suffix. Use this to filter by file type, version, or status.

The following example creates a subscription that receives only events from the embeddings pipeline:

```azurecli
az eventgrid event-subscription create \
    --name embeddings-sub \
    --source-resource-id /subscriptions/{sub-id}/resourceGroups/{rg}/providers/Microsoft.EventGrid/topics/ai-events \
    --endpoint https://embeddings-handler.azurewebsites.net/api/events \
    --subject-begins-with /pipelines/embeddings
```

You can combine subject filtering with event type filtering on the same subscription. An event subscription that filters on both type and subject prefix only receives events matching all specified criteria.

## Use advanced filtering on data attributes

Event Grid supports [advanced filters](/azure/event-grid/event-filtering#advanced-filtering) that match on values within the event body or extension attributes. Advanced filters let you make routing decisions based on the content of the event data, such as confidence scores, model names, or processing statuses. This capability is particularly useful for AI events where the routing decision depends on the event's payload.

Advanced filters use operators such as `StringContains`, `NumberGreaterThan`, `StringBeginsWith`, `BoolEquals`, and `IsNotNull`. You can define up to 25 filter conditions per subscription. Multiple conditions use AND logic between conditions and OR logic within each condition's values.

The following example creates a subscription that receives only events where the `data.status` field equals `"flagged"`. A moderation review service would use this filter to receive only content that needs human review:

```azurecli
az eventgrid event-subscription create \
    --name flagged-content-sub \
    --source-resource-id /subscriptions/{sub-id}/resourceGroups/{rg}/providers/Microsoft.EventGrid/topics/ai-events \
    --endpoint https://review-service.azurewebsites.net/api/events \
    --advanced-filter data.status StringIn flagged
```

For AI events, advanced filters enable targeted routing scenarios such as:

- **Confidence-based routing:** Route events to different handlers based on a confidence score threshold, such as `data.confidence NumberGreaterThan 0.9` for high-confidence results and a separate subscription for lower scores
- **Model-specific subscriptions:** Filter on `data.modelName` to subscribe to events from a particular model version
- **Status-based workflows:** Route only failed or flagged events to a review queue while completed events flow to a dashboard service

## Configure the input and output schema

When creating a custom topic, the `input-schema` parameter controls which schema the topic accepts. Set this to `cloudeventschemav1_0` to accept events in CloudEvents format:

```azurecli
az eventgrid topic create \
    --name ai-events \
    --resource-group ai-platform-rg \
    --location eastus \
    --input-schema cloudeventschemav1_0
```

When creating an event subscription, the `event-delivery-schema` parameter controls the format delivered to the handler. Event Grid can convert between Event Grid schema and CloudEvents schema during delivery. If your topic uses the Event Grid schema but your handler expects CloudEvents, you can set the output schema accordingly. However, CloudEvents-to-Event Grid conversion isn't supported because CloudEvents supports extension attributes that the Event Grid schema can't represent. For new implementations using CloudEvents throughout, you can omit this parameter and the events deliver in the same format they were published.

## Additional resources

- [CloudEvents v1.0 schema with Azure Event Grid](/azure/event-grid/cloud-event-schema)
- [Azure Event Grid event schema](/azure/event-grid/event-schema)
- [Understand event filtering for Event Grid subscriptions](/azure/event-grid/event-filtering)
