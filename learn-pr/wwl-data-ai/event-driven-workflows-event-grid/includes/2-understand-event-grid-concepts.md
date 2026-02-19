Azure Event Grid is a fully managed event-routing service that connects event sources to event handlers with low latency and per-event pricing. For AI solutions, Event Grid eliminates the need to poll for state changes by delivering events directly to your application endpoints as those changes occur. This unit introduces the core Event Grid components and explains how event-driven architecture addresses common challenges in AI backends.

## Understand what Azure Event Grid provides

Azure Event Grid operates as a publish-subscribe service that routes events from sources to handlers without requiring you to manage messaging infrastructure. The service ingests events from Azure services, custom applications, and partner systems, then delivers those events to subscriber endpoints based on subscription filters. Event Grid handles millions of events per second with subsecond latency and charges on a per-event basis, so you pay only for the events your system processes.

Event Grid supports two delivery models. Push delivery sends events to an endpoint that you specify, such as a webhook, Azure Function, or Service Bus queue. Pull delivery lets your consumer application connect to Event Grid and read events at its own pace. Both models serve different architectural needs, and you choose the right one based on whether your handler can accept incoming HTTP requests or prefers to consume events on demand.

Event Grid natively integrates with Azure services through [system topics](/azure/event-grid/system-topics) and supports custom application events through [custom topics](/azure/event-grid/custom-topics). This combination means that your AI solution can react to both infrastructure-level events (a blob appears in storage, a container image is pushed to a registry) and application-level events (an inference completes, a model finishes training) using the same routing infrastructure.

## Identify the core components of Event Grid architecture

Event Grid architecture consists of five core components that work together to route events from producers to consumers. Understanding each component helps you design event-driven pipelines that scale and adapt as you add new AI capabilities.

### Events

An event is a lightweight notification that describes a state change. Events indicate that something happened, such as "blob created" or "model training completed," without carrying the full changed resource. The subscriber retrieves the resource separately if it needs the complete data. This design keeps events small and fast to deliver, which is important for AI workflows that generate thousands of events during batch processing runs.

Each event contains metadata that identifies what happened, where it happened, and when it happened. The event body includes a data payload with operation-specific details, but the payload should remain compact. For example, a blob creation event includes the blob URL and content type but doesn't embed the blob content itself.

### Event sources

Event sources are Azure services or custom applications that emit events. Azure services such as Blob Storage, Azure Key Vault, Azure Container Registry, and Azure Event Hubs automatically publish events as system topics. Custom applications publish events to custom topics that you create. An AI application might act as both a consumer and a source. It subscribes to storage events to detect new training data and publishes its own events when model training completes.

### Topics

Topics are endpoints that receive events from sources. Event Grid uses three types of topics:

- **System topics:** Event Grid creates these automatically for Azure service events. When you create an event subscription for a supported Azure resource, the system topic appears without any manual setup. You can't publish directly to system topics because only the Azure service itself emits events to them.
- **Custom topics:** These are user-defined endpoints where your applications post events. You create a custom topic, configure its input schema, and then publish events to its endpoint using the Event Grid SDK or REST API.
- **Namespace topics:** These are part of the Event Grid namespace resource and support both push and pull delivery. Namespace topics offer additional capabilities such as MQTT support and are suited for scenarios where you need more control over event consumption.

### Event subscriptions

An event subscription is a configuration resource that defines which events to receive from a topic and where to send them. Each subscription specifies a topic to listen on, optional filters to select specific events, and a destination endpoint (the event handler). You can create multiple subscriptions on the same topic to fan out events to different handlers. Filters let you narrow the events each subscription receives by event type, subject path, or data attributes.

### Event handlers

Event handlers are destinations that receive and process events. Event Grid supports several handler types for push delivery:

- **Azure Functions:** Processes events using serverless compute with automatic scaling
- **Azure Event Hubs:** Ingests events into a high-throughput streaming pipeline
- **Azure Service Bus queues and topics:** Delivers events to enterprise messaging infrastructure
- **Webhooks:** Sends events to any HTTP endpoint, including custom services
- **Azure Storage queues:** Queues events for asynchronous processing by worker applications

The handler you choose depends on your processing requirements. Azure Functions works well for lightweight, stateless event processing. Service Bus queues suit scenarios where you need guaranteed ordering or transactional processing. Webhooks provide flexibility to route events to any HTTP-capable service, including AI inference endpoints.

## Explore how AI architectures benefit from event-driven patterns

AI workflows involve multiple loosely coupled components that need to coordinate without tight dependencies. Traditional polling-based architectures introduce latency, waste compute on empty checks, and create coupling between producer and consumer services. Event-driven architecture addresses each of these problems by pushing notifications to interested parties as state changes occur.

When a new dataset arrives in Blob Storage, Event Grid immediately notifies the embeddings pipeline rather than waiting for a polling interval to elapse. This approach reduces end-to-end latency from minutes to seconds. When a model finishes retraining, a custom event can trigger downstream validation and deployment services without any service needing to know about the others. Components subscribe to only the events they care about, and new consumers can be added without modifying producers.

Event-driven patterns also improve fault isolation. If one consumer experiences an outage, other consumers continue to receive and process events independently. Event Grid's retry mechanism automatically redelivers failed events, so transient issues in a single AI service don't create data loss across the pipeline.

## Apply event-driven patterns to AI workloads

Several event-driven patterns apply directly to AI systems. Each pattern addresses a specific coordination challenge that arises when building multi-stage AI processing pipelines.

### Reactive data processing

You can subscribe to Blob Storage events (`Microsoft.Storage.BlobCreated`) to trigger an AI pipeline whenever new training data, documents, or images arrive. The pipeline receives the event, retrieves the blob using the URL in the event data, and processes it without maintaining a polling loop. This pattern works for scenarios such as document ingestion in a RAG pipeline, image classification from an upload queue, or dataset preparation for model retraining.

### Pipeline stage coordination

Multi-step AI pipelines benefit from custom events that signal stage transitions. When an embeddings generation step completes, it publishes an event that triggers the indexing step. Each stage operates independently and scales based on its own workload. This decoupling allows you to replace or upgrade individual stages without disrupting the entire pipeline. It also provides natural observability boundaries because each stage transition creates a trackable event.

### Model lifecycle management

You can publish custom events for model training completion, validation results, and deployment promotions. Downstream services subscribe to these events to update serving endpoints, refresh model caches, or notify stakeholders. For example, when a model's validation accuracy exceeds a threshold, a custom event triggers a deployment workflow that promotes the model to production.

## Compare system topics and custom topics

For most AI workflows, you use both system topics and custom topics. System topics handle infrastructure events that originate from Azure services. Custom topics handle application-level events that your code produces. The following table summarizes when to use each type.

| Aspect | System topics | Custom topics |
|---|---|---|
| **Event source** | Azure services (Blob Storage, Key Vault, Container Registry) | Your application code |
| **Creation** | Created automatically when you subscribe to an Azure resource's events | Created explicitly by you before publishing |
| **Publishing** | Only the Azure service publishes events | Your application publishes events via SDK or REST API |
| **Use cases** | React to data arrivals, secret rotations, image pushes | Signal inference completion, pipeline transitions, anomaly detection |
| **Schema** | Predefined by the Azure service | You define the event type and data schema |

In a content moderation platform, you would use a system topic to receive `Microsoft.Storage.BlobCreated` events when users upload content. Your classification service would then consume these events, process the content, and publish a custom event like `com.contoso.ai.ContentClassified` to a custom topic. Downstream services such as the notification service and the analytics dashboard would subscribe to that custom topic independently.

## Additional resources

- [What is Azure Event Grid?](/azure/event-grid/overview)
- [Concepts in Azure Event Grid](/azure/event-grid/concepts)
- [System topics in Azure Event Grid](/azure/event-grid/system-topics)
