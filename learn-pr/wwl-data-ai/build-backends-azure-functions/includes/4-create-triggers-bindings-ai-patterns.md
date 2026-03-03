Azure Functions triggers and bindings provide a declarative way to connect functions to external services without writing boilerplate connection and serialization code. Triggers determine how a function is invoked, while bindings move data into and out of functions through configuration rather than explicit SDK calls. For AI backends, triggers and bindings simplify the integration between inference endpoints, message queues, storage services, and databases. This unit covers how to create HTTP triggers for inference endpoints, queue triggers for batch processing, and output bindings for storing results.

## Understand triggers and bindings

A trigger defines how a function starts executing. Every function has exactly one trigger, and the trigger type determines the event source that invokes the function. Common triggers include HTTP requests, queue messages, timer schedules, and database change feeds. The trigger also serves as an input binding, providing the event data to your function code as a parameter.

Bindings connect a function to other services through input bindings (data flowing into the function) and output bindings (data flowing out). Bindings are optional, and a function can have zero or multiple bindings of either type. The runtime handles authentication to the target service and data serialization, so your code focuses on business logic rather than connection management.

The combination of triggers and bindings eliminates the need to hardcode connection logic for Azure services that the runtime supports. For services without binding support, you create SDK clients directly in your function code. The [supported bindings reference](/azure/azure-functions/functions-triggers-bindings#supported-bindings) lists all available binding extensions, including Blob Storage, Cosmos DB, Event Hubs, Service Bus, Queue Storage, and more.

## Create HTTP triggers for inference endpoints

HTTP triggers turn a function into a REST API endpoint that responds to HTTP requests. They support GET, POST, and other HTTP methods, making them the primary pattern for building inference endpoints that clients call synchronously. HTTP triggers are the most common entry point for AI backends that serve predictions, classifications, or transformations in real time.

In the Python v2 programming model, you define HTTP triggers using the `@app.route()` decorator. The decorator specifies the route path, accepted HTTP methods, and authorization level. The function receives an `HttpRequest` object containing headers, query parameters, and the request body, and returns an `HttpResponse` with the result.

```python
# Code fragment - focus on HTTP trigger for an inference endpoint
import azure.functions as func
import json

app = func.FunctionApp()

@app.route(route="classify", methods=["POST"], auth_level=func.AuthLevel.FUNCTION)
def classify_document(req: func.HttpRequest) -> func.HttpResponse:
    payload = req.get_json()
    document_text = payload.get("text")

    # Call inference logic or Azure AI service
    classification = perform_classification(document_text)

    return func.HttpResponse(
        json.dumps({"category": classification}),
        status_code=200,
        mimetype="application/json"
    )
```

Authorization levels control who can invoke an HTTP-triggered function. The `anonymous` level requires no key, which suits development and internal health check endpoints. The `function` level requires a function-specific key sent in the `x-functions-key` header or `code` query parameter, and is the recommended baseline for production inference endpoints. The `admin` level requires the master key and should be reserved for administrative operations. Authorization keys provide a basic access barrier but don't replace caller identity verification using Microsoft Entra ID or API Management.

HTTP-triggered functions face a 230-second timeout imposed by the Azure Load Balancer. For AI tasks that take longer than this limit, such as large document processing or complex model inference, return a `202 Accepted` response with a status endpoint URL and process the work asynchronously using a Service Bus trigger. This async request-reply pattern was covered in the previous unit on hosting and scaling.

## Create Service Bus triggers for batch processing

Service Bus queue triggers start a function when a message arrives in an Azure Service Bus queue. This trigger type is the foundation for asynchronous AI processing patterns where work items are submitted through one interface and processed independently at a rate determined by available compute resources. Service Bus triggers handle retry logic, dead-letter management, and concurrency scaling automatically. Service Bus also provides features beyond basic queuing, such as message sessions, duplicate detection, and scheduled delivery, which are valuable for coordinating complex AI processing pipelines.

A common AI pattern pairs an HTTP endpoint with a Service Bus trigger. The HTTP function accepts a batch request, validates the input, writes individual work items to a Service Bus queue, and returns immediately. A separate Service Bus-triggered function processes each item independently, performing inference, calling Azure AI services, and writing results to storage. This separation decouples ingestion throughput from processing throughput, letting each scale to its own optimal instance count.

In the Python v2 model, you define Service Bus queue triggers using the `@app.service_bus_queue_trigger()` decorator. The decorator specifies the queue name and the connection setting that resolves to the Service Bus namespace connection string or identity-based connection.

```python
# Code fragment - focus on Service Bus queue trigger for processing work items
@app.service_bus_queue_trigger(arg_name="msg", queue_name="document-jobs", connection="ServiceBusConnection")
def process_document(msg: func.ServiceBusMessage) -> None:
    job = json.loads(msg.get_body().decode("utf-8"))
    document_url = job["document_url"]
    job_id = job["job_id"]

    # Perform document processing and classification
    result = extract_and_classify(document_url)

    # Store result (using output binding or SDK client)
    save_result(job_id, result)
```

You can configure concurrency behavior for Service Bus triggers in `host.json`. The `maxConcurrentCalls` property controls how many messages each instance processes simultaneously, and `maxAutoLockRenewalDuration` sets how long the runtime renews the message lock while processing continues. For AI workloads that perform resource-intensive processing per message, setting `maxConcurrentCalls` to `1` ensures each message gets the full instance resources. The `maxAutoLockRenewalDuration` should be set high enough to cover your longest expected processing time, so the lock doesn't expire while an AI service call is still in progress.

```json
{
    "version": "2.0",
    "extensions": {
        "serviceBus": {
            "maxConcurrentCalls": 1,
            "maxAutoLockRenewalDuration": "00:05:00"
        }
    }
}
```

When a message exceeds the queue's `maxDeliveryCount` (configured on the Service Bus queue resource itself, with a default of 10), the Service Bus broker automatically moves it to the queue's built-in dead-letter sub-queue. You can monitor this dead-letter queue for messages that repeatedly fail processing, which helps identify issues with specific input data, downstream service outages, or bugs in your processing logic. The dead-letter queue includes metadata such as the dead-letter reason and description, providing richer diagnostic context than a simple failed message.

## Use output bindings to store results

Output bindings write data to external services without requiring explicit SDK client code in your function. The runtime handles connection management, authentication, and serialization based on the binding configuration. For AI backends, output bindings provide a concise way to persist inference results, processed documents, and derived data to storage services.

Common output binding targets for AI workloads include Azure Blob Storage for storing processed documents and binary artifacts, Azure Cosmos DB for writing structured inference results, and Azure Service Bus for fanning out work to downstream processors. The following example shows a Service Bus-triggered function that uses a Blob Storage output binding to save processed text:

```python
# Code fragment - focus on output binding for storing results
@app.service_bus_queue_trigger(arg_name="msg", queue_name="document-jobs", connection="ServiceBusConnection")
@app.blob_output(arg_name="output_blob", path="results/{rand-guid}.json", connection="AzureWebJobsStorage")
def process_and_store(msg: func.ServiceBusMessage, output_blob: func.Out[str]) -> None:
    job = json.loads(msg.get_body().decode("utf-8"))

    result = extract_and_classify(job["document_url"])

    output_blob.set(json.dumps({
        "job_id": job["job_id"],
        "classification": result["category"],
        "confidence": result["score"]
    }))
```

When a function needs to return an HTTP response and write to an output binding simultaneously, the Python v2 model supports multiple outputs through a custom return type. You can define the HTTP response and the output binding as separate properties, allowing the function to respond to the caller and persist data in a single invocation.

Cosmos DB output bindings write JSON documents directly to a container. You can specify the database name, container name, and connection setting in the decorator. The runtime serializes your output object and inserts or upserts it into the target container.

```python
# Code fragment - focus on Cosmos DB output binding
@app.service_bus_queue_trigger(arg_name="msg", queue_name="classification-results", connection="ServiceBusConnection")
@app.cosmos_db_output(
    arg_name="output_doc",
    database_name="ai-results",
    container_name="classifications",
    connection="CosmosDBConnection"
)
def store_classification(msg: func.ServiceBusMessage, output_doc: func.Out[func.Document]) -> None:
    result = json.loads(msg.get_body().decode("utf-8"))

    output_doc.set(func.Document.from_dict({
        "id": result["job_id"],
        "category": result["category"],
        "confidence": result["score"],
        "processed_at": datetime.utcnow().isoformat()
    }))
```

## Connect to Azure AI services from a function

The triggers and bindings model doesn't cover every Azure service. For services without dedicated bindings, such as Azure AI Document Intelligence, Azure OpenAI Service, or Azure AI Search, you create SDK clients directly in your function code. This approach gives you full access to the service's API surface while still benefiting from the Functions hosting and scaling infrastructure.

When creating SDK clients, initialize the client object outside the function handler so it persists across invocations on the same instance. Client initialization typically involves establishing connections, loading configuration, and caching authentication tokens. By placing this initialization at the module level, you avoid repeating this overhead on every function invocation.

```python
# Code fragment - focus on SDK client initialization and reuse
from azure.identity import DefaultAzureCredential
from azure.ai.documentintelligence import DocumentIntelligenceClient
import os

credential = DefaultAzureCredential()

doc_intelligence_client = DocumentIntelligenceClient(
    endpoint=os.environ["DOCUMENT_INTELLIGENCE_ENDPOINT"],
    credential=credential
)

@app.service_bus_queue_trigger(arg_name="msg", queue_name="document-jobs", connection="ServiceBusConnection")
def analyze_document(msg: func.ServiceBusMessage) -> None:
    job = json.loads(msg.get_body().decode("utf-8"))

    poller = doc_intelligence_client.begin_analyze_document(
        "prebuilt-layout",
        analyze_request={"url_source": job["document_url"]},
        content_type="application/json"
    )
    result = poller.result()
    # Process extraction results...
```

Using `DefaultAzureCredential` for authentication allows the same code to work both locally (using developer credentials from Azure CLI or Visual Studio Code) and in production (using the function app's managed identity). This credential chain is covered in detail in a later unit on identity and access configuration.

## Additional resources

- [Azure Functions triggers and bindings](/azure/azure-functions/functions-triggers-bindings)
- [Azure Service Bus trigger for Azure Functions](/azure/azure-functions/functions-bindings-service-bus-trigger)
- [Azure Blob Storage output binding for Azure Functions](/azure/azure-functions/functions-bindings-storage-blob-output)
