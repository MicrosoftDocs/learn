::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=0088ccb2-c76c-4e70-abd1-598b18593000]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Some AI workflow decisions require input from a person or another system after automated processing finishes. Durable Functions can suspend an orchestration while it waits for an external event, then resume from durable state when the event arrives. The suspended orchestration doesn't hold a worker or an active function invocation, which makes the pattern suitable for approval windows that last hours or days.

> [!NOTE]
> The code examples in this unit are patterns to adapt to your application. A production approval endpoint must authenticate callers, authorize the approval action, validate the payload, and protect sensitive workflow data.

## Model an approval as an external event

An external event is a named, one-way message sent to a specific orchestration instance. The orchestrator creates a durable task with `wait_for_external_event()` and yields that task when it needs the event data. The Durable Functions extension persists an event that arrives before the orchestrator begins waiting, so the workflow can consume the buffered event later.

For a document-processing workflow, an activity first creates an approval record and notifies the assigned adjuster. The orchestrator then waits for an `ApprovalResponse` event that contains the decision and reviewer identity. Keeping notification delivery in an activity preserves the orchestrator's deterministic behavior.

Design the event contract around the workflow decision rather than a user-interface action. A compact approval payload can contain:

- **Decision:** A constrained value such as `Approved` or `Rejected`.
- **Reviewer ID:** An identifier that the application can correlate with its audit record.
- **Document ID:** The work item that the reviewer evaluated.
- **Approval version:** A value that helps the workflow reject a response for an outdated review request.
- **Comment reference:** A URL or record ID for detailed notes stored outside orchestration history.

The orchestration instance ID is the routing address for the event. Store that ID with the approval record when you notify the reviewer. Don't expose a status or event endpoint without access control, because anyone who can raise the event could influence the workflow.

## Combine an external event with a durable timer

An approval process needs a deadline so a workflow doesn't wait indefinitely. Use `context.create_timer()` with `context.current_utc_datetime` instead of `time.sleep()` or another blocking API. A durable timer records the deadline in orchestration history and doesn't require a worker to remain active while no work is ready.

The human interaction pattern races the event task against the timer task with `context.task_any()`. If the event wins, the orchestrator reads the event result and cancels the pending timer. If the timer wins, the orchestrator follows the timeout path. The orchestrator must wait for or cancel every pending timer before it exits.

The following fragment implements approval, rejection, and timeout outcomes. It uses stable input and orchestration-safe time so replay produces the same durable actions.

```python
# Code fragment - focus on the event-and-timer race
from datetime import timedelta
import azure.durable_functions as df


def orchestrator(
    context: df.DurableOrchestrationContext,
):
    review_request = context.get_input()

    yield context.call_activity("notify_approver", review_request)

    approval_task = context.wait_for_external_event("ApprovalResponse")
    deadline = context.current_utc_datetime + timedelta(hours=24)
    timeout_task = context.create_timer(deadline)

    winner = yield context.task_any([approval_task, timeout_task])

    if winner == approval_task:
        if not timeout_task.is_completed:
            timeout_task.cancel()

        response = approval_task.result
        if response["decision"] == "Approved":
            return {"status": "Approved"}

        return {"status": "Rejected"}

    return {"status": "TimedOut"}
```

An external event task doesn't require cancellation after the timer wins. If the workflow can receive another event with the same name later, define whether the application ignores the late event, records it for audit, or routes it to a new orchestration instance. Clear terminal-state rules prevent a late approval from changing a document that the application already marked as timed out.

## Send an event to the correct instance

A client function uses the Durable Functions orchestration client binding to send an event. The client must know the orchestration instance ID and use the same event name that the orchestrator awaits. Event names should be stable application contracts, not display text that changes with a user interface.

The following HTTP-trigger fragment shows the Durable Functions call after application-specific authorization and validation succeed. The endpoint returns `202 Accepted` because event delivery resumes the orchestration asynchronously. The example uses the Python v2 programming model.

```python
# Code fragment - focus on raising an external event
import json
import azure.functions as func
import azure.durable_functions as df

app = df.DFApp(http_auth_level=func.AuthLevel.FUNCTION)


@app.route(route="approvals/{instance_id}", methods=["POST"])
@app.durable_client_input(client_name="client")
async def submit_approval(
    req: func.HttpRequest,
    client: df.DurableOrchestrationClient,
) -> func.HttpResponse:
    instance_id = req.route_params["instance_id"]
    response = req.get_json()

    reviewer = authorize_reviewer(req)
    validated_event = validate_approval_response(response, reviewer)

    await client.raise_event(
        instance_id,
        "ApprovalResponse",
        validated_event,
    )

    return func.HttpResponse(
        json.dumps({"status": "Accepted"}),
        status_code=202,
        mimetype="application/json",
    )
```

Function-level authorization is only one layer of protection. For an enterprise approval workflow, authenticate users with Microsoft Entra ID, verify that the caller can review the target document, and record the decision in an audit store. Treat the route instance ID as an identifier rather than proof of authorization.

## Handle duplicate and out-of-order responses

Networks, webhook senders, and user interfaces can submit the same decision more than once. External events have an at-least-once delivery guarantee, so restarts, scaling, or failures can also produce duplicate delivery. The business operation still needs idempotency because a duplicate event shouldn't create a second approval record, repeat a downstream write, or reverse a terminal decision.

Include a stable approval request ID and version in the event. An activity can atomically record the first valid decision and report whether the operation already exists. The orchestrator should only accept an event that matches the current document and approval version. Store detailed comments and audit evidence outside the event payload, then pass a compact reference through the orchestration.

Out-of-order responses require an explicit policy. You might reject an event for an expired approval version, preserve it for audit, or start a new review. Avoid using arrival order alone when several systems can raise events. The event payload and durable approval record should provide enough information to determine whether a response is current.

## Choose a timeout outcome

A timeout is a business outcome, not necessarily a technical failure. An insurance workflow might mark the claim for manual follow-up, escalate to another queue, or reject the generated summary. The orchestrator should choose one terminal path and schedule any required external updates through activities.

Long approval windows also affect operational design. Use custom orchestration status or an external application record to show that the workflow is waiting for review. Monitor the age and count of pending approvals so support teams can distinguish normal durable suspension from a stalled integration. Don't repeatedly poll from inside the orchestrator, because an external event provides a more efficient resume signal.

::: zone-end

## Additional resources

These resources provide the full human interaction and external-event patterns for Durable Functions. You can use them to compare language-specific APIs and extend the approval flow with instance-management operations.

- [Human interaction pattern](/azure/durable-task/common/durable-task-human-interaction)
- [Handle external events in durable orchestrations](/azure/durable-task/common/durable-task-external-events)
- [Timers in Durable Functions](/azure/durable-task/common/durable-task-timers)
