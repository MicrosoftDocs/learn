::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=61071175-000d-45df-80bb-7a673a7cb88c]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Durable Functions coordinates stateful workflows by recording each scheduled operation and replaying orchestrator code to rebuild local state. This execution model lets an AI workflow survive host restarts and long delays, but it also requires a clear boundary between coordination logic and work that interacts with external systems. You keep deterministic decisions in an orchestrator function and place model calls, storage access, and other input/output operations in activity functions.

> [!NOTE]
> The code examples in this unit are patterns to adapt to your application. They focus on the Durable Functions Python programming model and omit production concerns that aren't relevant to the orchestration concept.

## Understand the durable function roles

A durable workflow usually combines a client function, an orchestrator function, and one or more activity functions. Each function type has a distinct responsibility, which helps you reason about scaling, retries, and side effects in an AI solution.

- **Client function:** Starts an orchestration, queries its status, terminates it, or sends an external event. An HTTP-triggered client often returns status URLs that a caller can use to track a long-running workflow.
- **Orchestrator function:** Defines the workflow sequence, branching rules, parallel tasks, durable waits, and result aggregation. The orchestrator schedules durable work rather than performing external work itself.
- **Activity function:** Performs one unit of nondeterministic work, such as reading a blob, calling a model endpoint, sending a notification, or updating a database. Activities can use standard language libraries and Azure SDK clients.
- **Entity function:** Manages a small piece of durable state through explicit operations. Entities can help coordinate shared state, but an orchestrator and activities are sufficient for the document-processing scenario in this module.

When a client starts an orchestration, the Durable Task runtime records the input and every durable action in the orchestration history. The runtime checkpoints progress whenever the orchestrator schedules work or receives a result. If the host restarts, the runtime replays the history through the orchestrator until it reaches the next unfinished action. This event-sourcing model restores local variables and workflow position without requiring you to write checkpoint code.

## Keep orchestrator logic deterministic

An orchestrator can replay many times during one workflow instance. Deterministic code produces the same sequence of durable actions from the same orchestration history, so the runtime can match replayed actions to completed work. A nondeterministic branch can schedule different activities during replay and cause the workflow to fail or behave unpredictably.

You can safely use local calculations, conditional statements, loops over stable input, and results returned by durable tasks. Use orchestration context APIs when a decision requires the current time or a unique identifier. For example, `context.current_utc_datetime` returns replay-safe time, while `context.new_uuid()` creates a deterministic identifier for the orchestration history.

Avoid the following operations in orchestrator functions:

- Direct HTTP, database, file system, or Azure SDK calls.
- Model inference or embedding requests.
- Random-number generators and nondeterministic UUID APIs.
- Language-native current-time APIs such as `datetime.now()`.
- Blocking waits such as `time.sleep()`.
- Threads, multiprocessing, and asynchronous operations that the Durable Task runtime doesn't schedule.
- Environment-dependent decisions that can change between replays.

The following fragment uses orchestration-safe time to calculate a review deadline. During replay, `context.current_utc_datetime` returns the same value, so the orchestrator schedules the same timer every time it rebuilds state.

```python
# Code fragment - focus on deterministic orchestration time
from datetime import timedelta
import azure.durable_functions as df


def orchestrator(
    context: df.DurableOrchestrationContext,
):
    review_deadline = context.current_utc_datetime + timedelta(hours=24)
    review_timer = context.create_timer(review_deadline)

    yield review_timer
    return {"status": "ReviewTimedOut"}
```

## Move model calls and input/output to activities

Activity functions don't replay under the orchestrator's deterministic execution rules. They can call Azure services, use SDK clients, generate random values, and perform other external operations. Activities are also the unit that Durable Functions distributes across available workers and retries according to orchestration policy.

The separation matters for AI workloads because model responses are nondeterministic and service calls can be slow or transiently fail. The orchestrator passes a stable request to an activity and records only the activity result. The activity owns model-specific authentication, request construction, response validation, and error reporting.

The following Python v2 programming-model fragments show the boundary. The orchestrator schedules an activity with a compact blob reference. The activity then reads the document and calls the configured model client.

```python
# Code fragment - focus on orchestration and activity boundaries
import azure.durable_functions as df

app = df.DFApp()


@app.orchestration_trigger(context_name="context")
def document_orchestrator(
    context: df.DurableOrchestrationContext,
):
    document = context.get_input()
    result = yield context.call_activity("analyze_document", document)
    return result


@app.activity_trigger(input_name="document")
def analyze_document(document: dict) -> dict:
    document_text = read_blob_text(document["blob_url"])
    model_result = call_classification_model(document_text)
    return {
        "document_id": document["document_id"],
        "category": model_result["category"],
        "confidence": model_result["confidence"],
    }
```

Calling `read_blob_text()` or `call_classification_model()` from the orchestrator would violate the deterministic execution constraint. Keeping those operations in `analyze_document` keeps external side effects out of replaying orchestrator code and lets you apply a retry policy specifically to the external work. Activity functions still have at-least-once execution semantics, so you must make their external side effects idempotent.

## Control data in orchestration history

Durable Functions serializes orchestration inputs, activity inputs, activity outputs, and other workflow state into the configured durable store. Large payloads increase storage operations, replay time, memory use, and the amount of sensitive data retained in history. AI applications should avoid passing complete documents, images, prompts, embeddings, or model responses through an orchestration.

For new Durable Functions applications, Microsoft recommends [Durable Task Scheduler](/azure/durable-task/scheduler/durable-task-scheduler) as the managed storage provider. You can continue to use the Azure Storage provider for existing applications or when you need to manage the durable storage resources yourself. The payload and security guidance in this unit applies to either provider.

Store large content in an appropriate data service such as Azure Blob Storage. Pass a reference and the compact metadata needed for workflow decisions, such as a document ID, blob URL, content type, confidence score, or result location. An activity can read the source content and write a detailed result, while the orchestrator receives only the status and fields required for its next branch.

You should also consider the security impact of durable data. Don't place secrets, access tokens, or confidential model credentials in orchestration inputs or outputs. Use managed identities and a service such as Azure Key Vault for credentials. For more information about handling sensitive inputs and outputs, see [Data persistence and serialization in Durable Functions](/azure/azure-functions/durable/durable-functions-serialization-and-persistence).

## Account for replay in telemetry

Replay can execute an orchestrator's logging statements more than once even though an activity runs only when the history says that work is pending. Duplicate log messages can make one workflow step appear to run repeatedly and can distort custom metrics. Activity logs remain appropriate for attempts and external operations because each activity execution represents actual work.

Use replay-safe logging support where the language SDK provides it, or check `context.is_replaying` before emitting orchestrator logs that should appear once. Include the orchestration instance ID and document operation ID in activity telemetry so you can correlate each external call with its workflow. Application Insights distributed tracing can then show the relationship between the client, orchestrator, and activity executions.

The following fragment suppresses a custom orchestrator message during replay. It doesn't suppress errors from activities or replace end-to-end tracing.

```python
# Code fragment - focus on replay-aware orchestrator logging
import logging

if not context.is_replaying:
    logging.info(
        "Scheduling document analysis for orchestration %s",
        context.instance_id,
    )
```

::: zone-end

## Additional resources

These resources provide deeper guidance for the orchestration boundaries introduced in this unit. You can use them to verify language-specific constraints and binding behavior as you design a production workflow.

- [Orchestrator function code constraints](/azure/durable-task/common/durable-task-code-constraints)
- [Durable Functions types and features](/azure/azure-functions/durable/durable-functions-types-features-overview)
- [Bindings for Durable Functions](/azure/azure-functions/durable/durable-functions-bindings)
