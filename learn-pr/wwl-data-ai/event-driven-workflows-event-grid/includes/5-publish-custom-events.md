The previous units covered how Event Grid routes events from sources to handlers and how to configure filtering and delivery policies. This unit focuses on the other side of the equation: publishing custom events from your AI applications. You learn how to create custom topics, construct well-structured events for AI operations, and use the Event Grid SDK and REST API to emit events that signal completed inferences, model updates, and pipeline stage transitions.

> [!NOTE]
> All code examples in this module are based on the most recent version of the `azure-eventgrid` library at the time of writing. The library is updated often and the recommendation is to visit the [Azure Event Grid SDK for Python](https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/eventgrid/azure-eventgrid) site for the most up-to-date information.

## Create a custom topic for AI events

A custom topic provides a user-defined endpoint where your application posts events. Before your AI application can publish events, you need to create the topic and configure it to accept the schema your events use. Set the input schema to `cloudeventschemav1_0` when creating the topic so events follow the standardized CloudEvents format.

```azurecli
az eventgrid topic create \
    --name ai-pipeline-events \
    --resource-group ai-platform-rg \
    --location eastus \
    --input-schema cloudeventschemav1_0
```

After creating the topic, you need credentials to publish events. You can retrieve the topic endpoint and access key using the Azure CLI:

```azurecli
az eventgrid topic show \
    --name ai-pipeline-events \
    --resource-group ai-platform-rg \
    --query "endpoint" \
    --output tsv

az eventgrid topic key list \
    --name ai-pipeline-events \
    --resource-group ai-platform-rg \
    --query "key1" \
    --output tsv
```

Event Grid supports three authentication methods: access key authentication (using the `aeg-sas-key` header), SAS token authentication, and Microsoft Entra ID. For production AI applications, [Microsoft Entra ID authentication](/azure/event-grid/authenticate-with-microsoft-entra-id) is the recommended approach. It eliminates the need to manage and rotate shared secrets, supports managed identities, and benefits from features such as Conditional Access policies. When your application runs on Azure services such as Azure Functions, Azure Container Apps, or Azure Kubernetes Service, you can assign a managed identity to the hosting service and grant it the **Event Grid Data Sender** role on the custom topic.

## Construct events for AI operations

Each custom event describes a meaningful state change in your AI system. A well-constructed event includes enough context for the subscriber to start processing without embedding the full operation results. Subscribers retrieve detailed outputs from a data store using identifiers in the event data.

The following structure shows a CloudEvents event for an inference completion. The `type` field categorizes the operation, the `source` identifies the originating service, and the `subject` provides a filterable path. The `data` payload includes metadata about the operation and a reference to where the subscriber can find the detailed results:

```json
{
    "specversion": "1.0",
    "type": "com.contoso.ai.InferenceCompleted",
    "source": "/services/content-moderation",
    "id": "evt-20250915-143000-001",
    "time": "2025-09-15T14:30:00Z",
    "subject": "/pipelines/moderation/image-classifier",
    "datacontenttype": "application/json",
    "data": {
        "requestId": "req-78901",
        "modelName": "content-classifier-v3",
        "modelVersion": "3.2.1",
        "processingDurationMs": 1250,
        "resultLocation": "https://results.blob.core.windows.net/output/req-78901.json",
        "status": "completed",
        "itemsProcessed": 1,
        "summary": {
            "classification": "safe",
            "confidence": 0.97
        }
    }
}
```

When designing the data payload, keep the following principles in mind:

- **Include identifiers for correlation:** The `requestId` or pipeline run ID lets subscribers trace the event back to the original request across distributed services.
- **Reference results instead of embedding them:** Store detailed outputs (inference results, embeddings, generated text) in Blob Storage or a database. Include the location in the event so subscribers can retrieve them when needed.
- **Add operational metadata:** Fields like `processingDurationMs` and `modelVersion` help monitoring services track performance trends and model usage without querying application logs.
- **Provide a summary for fast decisions:** Include a brief summary of the result so subscribers can make routing decisions (flag for review, proceed to next stage) without downloading the full output.

## Publish events using the Event Grid SDK

The `EventGridPublisherClient` from the `azure-eventgrid` library handles event serialization, authentication, and retries. You can authenticate with an access key using `AzureKeyCredential` or with Microsoft Entra ID using `DefaultAzureCredential`. The following example shows how to create a client and publish a CloudEvent to a custom topic:

```python
# Code fragment - focus on creating and sending a CloudEvent
from azure.core.credentials import AzureKeyCredential
from azure.core.messaging import CloudEvent
from azure.eventgrid import EventGridPublisherClient

endpoint = os.environ["EVENTGRID_TOPIC_ENDPOINT"]
key = os.environ["EVENTGRID_TOPIC_KEY"]

credential = AzureKeyCredential(key)
client = EventGridPublisherClient(endpoint, credential)

event = CloudEvent(
    type="com.contoso.ai.InferenceCompleted",
    source="/services/content-moderation",
    data={
        "requestId": "req-78901",
        "modelName": "content-classifier-v3",
        "processingDurationMs": 1250,
        "resultLocation": "https://results.blob.core.windows.net/output/req-78901.json",
        "status": "completed"
    },
    subject="/pipelines/moderation/image-classifier"
)

client.send(event)
```

For production deployments, use `DefaultAzureCredential` to authenticate with a managed identity instead of access keys:

```python
# Code fragment - focus on managed identity authentication
from azure.identity import DefaultAzureCredential
from azure.core.messaging import CloudEvent
from azure.eventgrid import EventGridPublisherClient

endpoint = os.environ["EVENTGRID_TOPIC_ENDPOINT"]

credential = DefaultAzureCredential()
client = EventGridPublisherClient(endpoint, credential)
```

You can publish events in batches for improved performance. When you publish a list of events, the SDK sends them in a single HTTP request. This approach reduces network overhead for AI applications that emit multiple events during a processing run, such as publishing stage-transition events for each step in a pipeline:

```python
# Code fragment - focus on batch publishing
events = [
    CloudEvent(
        type="com.contoso.ai.StageCompleted",
        source="/services/embeddings",
        data={"pipelineRunId": "run-42", "stage": "embeddings", "status": "completed"},
        subject="/pipelines/rag/run-42"
    ),
    CloudEvent(
        type="com.contoso.ai.StageCompleted",
        source="/services/indexing",
        data={"pipelineRunId": "run-42", "stage": "indexing", "status": "completed"},
        subject="/pipelines/rag/run-42"
    )
]

client.send(events)
```

Publish events at natural checkpoint boundaries in your AI workflow. Good publish points include after an inference completes, when a pipeline stage transitions, when an anomaly is detected, or when a model finishes validation. Don't publish events for internal state changes that no external subscriber needs to know about.

## Publish events using the REST API

You can also publish events by sending an HTTP POST request directly to the custom topic endpoint. This approach is useful when publishing from languages without an official Event Grid SDK, from lightweight services that don't need the full SDK dependency, or from non-application systems such as CI/CD pipelines.

For a custom topic configured with the CloudEvents input schema, send a single CloudEvent as a JSON object with the `content-type` header set to `application/cloudevents+json; charset=utf-8`. Authenticate using the `aeg-sas-key` header:

```bash
curl -X POST \
    -H "Content-Type: application/cloudevents+json; charset=utf-8" \
    -H "aeg-sas-key: $EVENTGRID_TOPIC_KEY" \
    -d '{
        "specversion": "1.0",
        "type": "com.contoso.ai.ModelRetrained",
        "source": "/services/training",
        "id": "evt-20250915-160000-001",
        "time": "2025-09-15T16:00:00Z",
        "subject": "/models/sentiment-v2",
        "datacontenttype": "application/json",
        "data": {
            "modelName": "sentiment-v2",
            "modelVersion": "2.1.0",
            "accuracy": 0.94,
            "trainingDurationMinutes": 45,
            "artifactLocation": "https://models.blob.core.windows.net/trained/sentiment-v2.1.0.tar.gz"
        }
    }' \
    "$EVENTGRID_TOPIC_ENDPOINT"
```

The REST API returns 200 OK when the event is accepted for routing. A non-200 response indicates an error in the request, such as a malformed event, an invalid key, or a schema mismatch.

## Apply event design patterns for AI applications

Different AI operations call for different event structures. The following patterns cover common scenarios in AI-powered systems.

### Inference completion events

Publish after each inference request completes. Include the request correlation ID, model name, processing duration, result location, and a summary status. Downstream subscribers can trigger notification workflows, update dashboards, or initiate follow-up processing steps.

### Model update events

Publish when a model is retrained, validated, or promoted to production. Include the model version, key training metrics, and the deployment target. Subscribers can refresh model caches in serving endpoints, update routing tables to direct traffic to the new model, or trigger integration tests against the updated version.

### Pipeline stage transition events

Publish at each stage boundary in a multi-step pipeline. Include the pipeline run ID, stage name, stage status, and input and output references. A monitoring service subscribes to these events to build a real-time view of pipeline progress and detect bottlenecks. An orchestration service uses them to trigger the next stage when the previous one completes.

Each of these patterns follows the same core principle: the event describes what happened and provides enough context for subscribers to act. The event producer doesn't need to know who subscribes or what they do with the information. This decoupling is what makes event-driven AI architectures extensible. Adding a new consumer is a matter of creating a new event subscription, not modifying the producer.

## Additional resources

- [Publish events to Azure Event Grid custom topics](/azure/event-grid/post-to-custom-topic)
- [Authenticate publishing clients using Microsoft Entra ID](/azure/event-grid/authenticate-with-microsoft-entra-id)
- [Azure Event Grid client library for Python](https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/eventgrid/azure-eventgrid)
