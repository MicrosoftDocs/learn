The hosting plan you choose for your Azure Functions app determines how instances start, how the app scales under load, and how much memory each instance provides. These decisions directly affect the latency, throughput, and cost of an AI backend. This unit focuses on the two hosting plans most relevant to serverless AI workloads, the Flex Consumption plan and the Premium plan, and explains how to configure scaling and handle long-running tasks.

## Understand cold start and why it matters for AI

Cold start is the delay that occurs when the Azure Functions platform allocates a new instance, loads the runtime, and initializes your application's dependencies before the instance can handle its first request. Every serverless hosting plan that scales to zero experiences cold start because no preallocated compute exists to serve the initial invocation. Understanding cold start behavior helps you make informed hosting decisions for latency-sensitive AI endpoints.

AI workloads tend to amplify cold start latency beyond what simpler applications experience. Large dependency graphs from machine learning libraries and SDK packages increase the time the platform spends loading modules into memory. Model configuration loading, connection warm up to downstream services like Azure AI Services or databases, and initialization of HTTP clients all add seconds of latency on top of the base platform delay. For example, a Python function that imports `azure-ai-documentintelligence` and `azure-cosmos` adds measurably more startup time than a function with minimal dependencies.

Cold start is a per-instance event. It affects only the first request routed to a new instance, not every request. Once an instance is warm, subsequent requests execute without the startup overhead. This distinction matters for AI workloads because consistent traffic to warm instances delivers predictable low latency, while bursty traffic that triggers new instance creation introduces intermittent delays.

## Choose between Flex Consumption and Premium

Azure Functions offers several hosting plans, but two stand out for serverless AI backends: the Flex Consumption plan and the Premium plan. Each takes a different approach to managing cold starts and scaling, and the right choice depends on your workload's traffic patterns and latency requirements.

The **Flex Consumption plan** is the recommended default for new serverless function apps. It's a Linux-only plan that provides per-function scaling, configurable instance memory sizes (512 MB, 2,048 MB, or 4,096 MB), virtual network integration, and always-ready instances. Flex Consumption scales up to 1,000 instances and charges based on active execution time plus any always-ready baseline. The always-ready feature lets you keep a minimum number of warm instances for latency-sensitive functions while other functions in the same app remain fully serverless and scale to zero. This approach gives you fine-grained control over the trade-off between cold start mitigation and cost, because you pay only for the always-ready instances you configure.

The **Premium plan** eliminates cold starts entirely by keeping at least one pre-warmed worker always running. Premium provides event-driven scaling with pre-warmed instances, custom Linux image support, and virtual network connectivity. Choose Premium when your functions run continuously or nearly continuously and the always-on cost is justified, when you need larger compute sizes than Flex Consumption offers, or when you need to deploy functions using custom container images.

The following list summarizes when to consider other hosting options beyond these two plans:

- **Dedicated (App Service) plan:** Makes sense when underutilized App Service capacity already exists and you want to run functions on those instances without additional cost.
- **Container Apps hosting:** Appropriate when functions need GPU access for model inference, custom OS-level packages, or need to run alongside other containerized microservices in the same environment.
- **Consumption plan (Linux):** The legacy serverless plan. The ability to run function apps on Linux in a Consumption plan retires after September 2028. New projects should use the Flex Consumption plan instead.

## Configure scaling and concurrency

The Flex Consumption plan introduces per-function scaling, which provides more deterministic resource allocation than plans that scale the entire function app as a single unit. Understanding how scaling works helps you tune throughput and cost for AI backends that handle multiple trigger types.

In per-function scaling, each trigger type scales independently based on its own event-driven demand. All HTTP triggers in a function app scale together as a group on the same instances because HTTP traffic typically shares similar resource requirements. All other trigger types, such as queue triggers, Service Bus triggers, and timer triggers, each scale on their own independent set of instances. This separation means a surge in queue processing doesn't compete with HTTP request handling for compute resources.

Concurrency settings control the maximum number of parallel executions that each instance handles simultaneously. Lower concurrency values spread load across more instances, which isolates resource consumption per invocation. Higher concurrency values use fewer instances but require more memory per instance to handle multiple executions in parallel. For AI workloads that perform CPU-intensive or memory-intensive inference, lower concurrency often produces more predictable performance because each invocation has more dedicated resources.

Instance memory selection determines the compute resources available to each instance. The 2,048-MB instance size is the default and suits most scenarios. Use the 4,096-MB size when functions load large models, process memory-intensive data, or require higher CPU allocation, because CPU cores scale proportionally with memory (2,048 MB provides one vCPU, 4,096 MB provides two vCPU). The 512-MB tier suits lightweight, high-volume event processors that don't require significant memory or CPU per invocation.

## Handle long-running AI tasks

HTTP-triggered functions face a 230-second timeout imposed by the Azure Load Balancer, regardless of the hosting plan or the `functionTimeout` setting in `host.json`. AI inference, document processing, and model training tasks that exceed this limit cause a timeout error for the caller even though the function might still be executing on the backend. Planning for this constraint is essential when building AI backends that process complex or batch workloads.

The recommended approach uses the async request-reply pattern. The HTTP-triggered function accepts the incoming request, validates the input, writes a message to a Service Bus queue, and immediately returns a `202 Accepted` response with a status endpoint URL. A separate Service Bus-triggered function picks up the message and performs the long-running processing without any HTTP timeout constraint, because Service Bus-triggered functions can run for an unbounded duration on the Flex Consumption and Premium plans.

```python
# Code fragment - focus on async request-reply pattern
import azure.functions as func
import json
import uuid

app = func.FunctionApp()

@app.route(route="process-document", methods=["POST"], auth_level=func.AuthLevel.FUNCTION)
@app.service_bus_queue_output(arg_name="queue_msg", queue_name="document-jobs", connection="ServiceBusConnection")
def accept_document(req: func.HttpRequest, queue_msg: func.Out[str]) -> func.HttpResponse:
    job_id = str(uuid.uuid4())
    document_url = req.get_json().get("document_url")

    queue_msg.set(json.dumps({"job_id": job_id, "document_url": document_url}))

    return func.HttpResponse(
        json.dumps({"job_id": job_id, "status_url": f"/api/job-status/{job_id}"}),
        status_code=202,
        mimetype="application/json"
    )
```

This pattern also decouples ingestion throughput from processing throughput. The HTTP endpoint can accept hundreds of requests per second, while the Service Bus-triggered processor scales independently based on queue depth. Each component scales to its own optimal instance count without affecting the other.

## Additional resources

- [Azure Functions Flex Consumption plan](/azure/azure-functions/flex-consumption-plan)
- [Azure Functions hosting options](/azure/azure-functions/functions-scale)
- [Improve Azure Functions performance and reliability](/azure/azure-functions/performance-reliability)
