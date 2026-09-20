::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=b61931ca-f31a-4ab7-8948-60ead26bfdc7]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Durable orchestration preserves workflow progress, but persistence alone doesn't make every external operation safe. Model endpoints can throttle requests, storage writes can time out after succeeding, and a host can restart before the durable runtime records an activity result. Reliable AI workflows combine retry and timeout policies with idempotent activities, explicit failure routing, and business compensation.

> [!NOTE]
> The code examples in this unit are patterns to adapt to your application. Retry capabilities differ among Durable Functions language SDKs, so verify the controls available in the SDK version that your function app uses.

## Classify failures before retrying

Retries help when another attempt can succeed without changing the request. They consume time, model quota, and function resources, so indiscriminate retries can amplify an outage or repeat a costly model call. Classify failures according to whether time or a dependency-state change can resolve them.

- **Transient failure:** A network interruption, service throttling response, or temporary dependency outage can succeed later. Apply a bounded retry policy.
- **Permanent failure:** Another attempt can't resolve invalid input, an unsupported content type, or a missing required field. Validate early and route the item to a terminal business outcome.
- **Authorization failure:** An expired credential might be transient in some architectures, but a forbidden operation usually requires configuration or permission changes. Don't repeatedly retry a request that the identity can't perform.
- **Timeout:** A workflow deadline expires before a required result arrives. Choose whether to compensate, escalate, or preserve the work for later inspection.
- **Business-rule failure:** A low confidence score or rejected approval is an expected decision rather than an infrastructure error. Route it through an explicit workflow branch.

Activity functions should raise failures that the orchestrator needs to treat as technical errors. They can return structured business outcomes when the call succeeds but the content doesn't meet an application rule. This distinction prevents a low-confidence classification from consuming infrastructure retry attempts.

## Apply bounded activity retries

Durable Functions can schedule an activity with a retry policy. The durable runtime records each attempt and waits between attempts without requiring you to build a queue or a retry loop. Set a maximum attempt count so a persistent dependency failure eventually reaches the orchestrator.

The Python `RetryOptions` API accepts the first retry interval in milliseconds and the maximum number of attempts. Other language SDKs expose additional retry controls, such as backoff coefficients and maximum retry intervals. Select a cadence that respects the dependency's retry guidance and service quotas. Add randomized delay inside an activity only when the client SDK and operation support that strategy safely, because random behavior doesn't belong in orchestrator code.

The following fragment retries a model-processing activity up to three total attempts, with 5 seconds before the first retry. The activity input includes a stable operation ID so another attempt can identify work that already completed.

```python
# Code fragment - focus on a bounded activity retry
import azure.durable_functions as df

retry_options = df.RetryOptions(
    first_retry_interval_in_milliseconds=5_000,
    max_number_of_attempts=3,
)

result = yield context.call_activity_with_retry(
    "process_document",
    retry_options,
    {
        "operation_id": operation_id,
        "document_id": document["document_id"],
        "blob_url": document["blob_url"],
    },
)
```

Don't nest several uncontrolled retry layers. For example, a model SDK might retry internally while Durable Functions retries the entire activity. Calculate the combined maximum attempts and elapsed time, then configure both layers intentionally. Use service-provided retry delay information when the client SDK supports it.

## Enforce durable timeouts

A retry policy limits attempts, while a timeout limits how long the workflow waits for an outcome. Durable timers let an orchestrator express a deadline without keeping compute resources active. Race the durable work against a timer when the application must continue after a fixed workflow deadline.

A timer winning a `task_any()` race doesn't automatically cancel an activity that already started. The activity might still finish and produce an external side effect. Use an operation record or cancellation flag that the activity checks when practical, make any eventual write idempotent, and design the workflow to ignore a late result after its terminal deadline.

You can apply timeouts at different scopes:

- **Client request timeout:** Bounds one HTTP or SDK call inside an activity.
- **Activity retry window:** Bounds the attempts and delays for one durable step.
- **Workflow step timeout:** Races a durable task against a durable timer.
- **End-to-end deadline:** Stops or compensates the workflow when the business process exceeds its allowed duration.

Choose the narrowest timeout that represents the requirement. A model-call timeout shouldn't automatically imply that an entire claim is invalid. The orchestrator can retry the activity, use a fallback route, or send the document to manual review.

## Make activity side effects idempotent

Durable Functions provides at-least-once activity execution. An activity can complete an external write and then run again if the host fails before the runtime records its result. Idempotency ensures that repeating the same operation produces the same durable business result instead of creating a duplicate.

Derive a stable operation ID from orchestration input, or create one with `context.new_uuid()` and pass it to the activity. Use that ID as a database key, blob name, deduplication record, or service idempotency key. Don't create the operation ID with `uuid.uuid4()` inside a retried activity, because each attempt would appear to be new work.

The following activity uses the operation ID as a blob name and creates the result only when it doesn't already exist. If an earlier attempt wrote the blob but its activity result was lost, the retry recognizes the existing result and returns the same URL.

```python
# Code fragment - focus on an idempotent result write
import json
from azure.core.exceptions import ResourceExistsError


def persist_result(request: dict) -> dict:
    blob_name = f"results/{request['operation_id']}.json"
    blob_client = results_container.get_blob_client(blob_name)
    payload = json.dumps(request["result"])

    try:
        blob_client.upload_blob(payload, overwrite=False)
        write_status = "Created"
    except ResourceExistsError:
        write_status = "AlreadyExists"

    return {
        "operation_id": request["operation_id"],
        "result_url": blob_client.url,
        "write_status": write_status,
    }
```

An existing key is only safe when the same operation ID always represents the same request. Store a request hash or immutable document version with the result when accidental key reuse is possible. A conflict between the stored request and the retry input should produce an explicit failure instead of silently returning unrelated data.

## Compensate completed side effects

Distributed workflows can't usually roll back several services as one transaction. Compensation performs a new business action that addresses an earlier successful side effect. For example, a compensation activity might mark a rejected claim summary as invalid, move it to a quarantine container, or hide it from downstream consumers.

Compensation should be idempotent because the compensation activity can also run more than once. Record which forward operations completed, then compensate only those operations in the appropriate reverse order. Preserve an audit trail rather than deleting evidence that a regulated workflow might require.

The following fragment schedules compensation when document processing exhausts its retries. The exception is rethrown after compensation so the orchestration retains a failed terminal status rather than presenting the recovery action as normal success.

```python
# Code fragment - focus on compensation after a failed durable step
try:
    result = yield context.call_activity_with_retry(
        "process_document",
        retry_options,
        process_request,
    )
except Exception:
    yield context.call_activity(
        "compensate_document",
        {
            "operation_id": process_request["operation_id"],
            "reason": "ProcessingFailed",
        },
    )
    raise
```

The broad exception boundary is intentional at the orchestration step because Durable Functions marshals activity failures to the orchestrator. The compensation activity should still distinguish a missing provisional result from a dependency failure and surface unexpected errors. Don't catch and discard the original failure after compensation.

## Expose terminal status and diagnostics

Every workflow branch should reach an explicit status such as `Completed`, `Rejected`, `TimedOut`, `Compensated`, or `Failed`. A client can query the orchestration runtime status, while an application record can expose business status without revealing orchestration internals. Keep these status models related but distinct.

Include the orchestration instance ID, operation ID, document ID, activity name, and attempt information in telemetry. Application Insights distributed tracing can correlate orchestrator and activity executions, while replay-safe logging prevents duplicate orchestrator messages from obscuring actual attempts. Never log document contents, prompts, model credentials, or approval tokens.

Use custom orchestration status for a compact progress indicator when clients need it. Store detailed per-document results in an external data service and return references from the workflow. This design keeps orchestration history manageable and gives operations teams enough context to investigate a terminal failure.

::: zone-end

## Additional resources

These resources explain Durable Functions error behavior and operational diagnostics in more detail. You can use them to align retry, compensation, and monitoring choices with your selected language SDK and storage provider.

- [Handle errors and retries in orchestrations](/azure/durable-task/common/durable-task-error-handling)
- [Durable Functions diagnostics](/azure/azure-functions/durable/durable-functions-diagnostics)
- [Instance management in Durable Functions](/azure/azure-functions/durable/durable-functions-instance-management)
