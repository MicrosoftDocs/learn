::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=c4251ee0-4548-44ff-8c33-8333f772abc0]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

An AI incident investigation can produce progress updates and generated findings before its final report is ready. Azure Web PubSub groups let a backend worker deliver those updates to authorized responders' browser connections without tracking every socket. A consistent event contract helps clients interpret generated text, progress, approvals, and terminal outcomes.

> [!NOTE]
> The code examples in this unit are patterns to adapt to your application. They reuse the Python service and connection clients from the negotiation unit. Client fragments illustrate message-handling decisions, not browser rendering code. Persistence, state updates, and authorization use application-defined helpers.

## Organize recipients with hubs and groups

A [hub](/azure/azure-web-pubsub/key-concepts) is a logical boundary for a set of Web PubSub connections. A group is a subset of connections within that hub. Use a stable hub for the application scenario and operation groups for changing audiences.

The incident-investigation assistant uses the `incident_updates` hub and a stable, opaque group name derived from the tenant and operation IDs. The on-call developer, incident commander, and database specialist join that group when authorized for the investigation. The worker doesn't need their connection IDs.

One user can have several connections across tabs or devices. A group can include different users. Assigning a user ID doesn't automatically subscribe its connections to operation groups.

Group membership isn't a durable audience record. Store operation ownership and incident-responder assignments separately to authorize later connections.

## Define an event contract for the client

A notification needs enough context to identify its operation and apply the right UI change. It also needs stable identifiers for deduplication and recovery. Define that contract before connecting worker output directly to the browser.

The following envelope represents one batch of generated findings about database connection failures. The sequence belongs to the application's operation stream, not to the transport protocol.

```json
{
    "schemaVersion": 1,
    "operationId": "op42",
    "eventId": "op42-event-15",
    "sequence": 15,
    "type": "text.batch",
    "data": {
        "text": " exhausted connections during the incident."
    }
}
```

Each envelope field has a distinct purpose:

- **Schema version:** Identifies the contract. Reject unsupported versions explicitly.
- **Operation ID:** Associates the update with the displayed operation.
- **Event ID:** Identifies the logical notification across retries.
- **Sequence:** Defines the position for duplicate and gap detection.
- **Type:** Selects the client behavior.
- **Data:** Contains the compact, type-specific update.

The event types in this module use the following payloads:

| Type | Payload fields | Client behavior |
|---|---|---|
| `text.batch` | `text` | Append a generated-text delta after sequence checks |
| `progress` | `stage`, `percent` | Replace the displayed progress snapshot |
| `approval.requested` | `approvalId` | Show that an authorized decision is required |
| `operation.completed` | `resultPath` | Show completion and enable result retrieval |
| `operation.failed` | `message` | Show a sanitized business-facing failure message |

Approval IDs and result paths identify resources, not access rights. Their backend endpoints still authorize each request.

## Publish stored notifications from the worker

The worker publishes a notification after the corresponding durable update succeeds. This order lets a receiving client immediately verify progress or retrieve the referenced result. A stored event envelope also lets a retry preserve the same event ID and sequence.

The [Python service client](/python/api/azure-messaging-webpubsubservice/azure.messaging.webpubsubservice.webpubsubserviceclient#azure-messaging-webpubsubservice-webpubsubserviceclient-send-to-group) sends JSON to a group through `send_to_group()`. The following fragment assumes the worker loads an already persisted notification and its authorized destination from application storage. It reuses the service client initialized in the negotiation unit.

```python
# Code fragment - focus on publishing a persisted operation notification
operation_group = load_notification_group("op42-event-15")
notification = load_pending_notification("op42-event-15")

service_client.send_to_group(
    group=operation_group,
    message=notification,
    content_type="application/json",
)
mark_notification_sent(notification["eventId"])
```

The storage helpers aren't SDK methods. A publish error leaves the notification pending. A crash after sending but before marking success can produce a duplicate on retry.

For completion, the worker flushes the remaining text, stores the final report, and records the terminal operation state. It then publishes completion with an operation-relative result path. The client shouldn't treat the last text batch as proof that the operation succeeds because validation or result persistence can still fail afterward.

A successful publish doesn't prove browser processing or human receipt. Business acknowledgments need a separate application action when required.

## Route worker messages to validated client handlers

The Python client SDK delivers service-published group notifications through `CallbackType.GROUP_MESSAGE`. `CallbackType.SERVER_MESSAGE` applies to messages the server sends directly to a connection or user, not to group broadcasts. Client callbacks can run on separate threads, so route notifications through the operation-scoped lock described in the recovery unit before mutating shared view state.

The following Python fragment illustrates validation and routing before any displayed state changes. The application-defined handlers stand in for the provided client's behavior; their implementations aren't part of the lesson. The shared `accept_in_sequence()` guard invokes the selected handler only when its event is ready to apply.

```python
# Code fragment - focus on envelope validation and event routing
from azure.messaging.webpubsubclient.models import CallbackType
from threading import Lock

operation_lock = Lock()
view_state = {"last_sequence": 0, "synchronized": False}
handlers = {
    "text.batch": append_generated_text,
    "progress": replace_progress,
    "approval.requested": show_approval_request,
    "operation.completed": show_completed_result,
    "operation.failed": show_operation_failure,
}


def on_group_message(message) -> None:
    if message.group != connection_details["group"]:
        show_delivery_error("Notification arrived from an unexpected group")
        return

    event = message.data
    valid_envelope = (
        isinstance(event, dict)
        and type(event.get("schemaVersion")) is int
        and event["schemaVersion"] == 1
        and event.get("operationId") == operation_id
        and isinstance(event.get("eventId"), str)
        and bool(event["eventId"])
        and type(event.get("sequence")) is int
        and 0 < event["sequence"] <= 2**53 - 1
        and isinstance(event.get("type"), str)
        and isinstance(event.get("data"), dict)
    )
    handler = handlers.get(event["type"]) if valid_envelope else None
    if handler is None:
        show_delivery_error("Invalid or unsupported operation notification")
        return

    accept_in_sequence(
        view_state,
        event,
        lambda: handler(event["data"]),
        operation_lock,
    )


client.subscribe(CallbackType.GROUP_MESSAGE, on_group_message)
```

Handlers validate payloads before mutation: text must be a string, progress must be in range, and result paths must be permitted application-relative references. The sequence limit keeps JSON numbers interoperable with browser clients.

Render generated text as text. Sanitize any Markdown-to-HTML output because model output isn't trusted browser markup.

## Wait for membership before trusting live updates

Connection establishment and group membership are separate milestones. A browser can connect successfully but fail to join the operation group. The UI mustn't present the live subscription as ready until the authorized join succeeds.

After registering the handlers, you can open the client and join the group returned by negotiation. The following Python fragment illustrates the order that the provided browser client also follows. A failed connection or join must reach an application error handler instead of declaring live delivery ready.

```python
# Code fragment - focus on initial subscription readiness
client.open()
client.join_group(connection_details["group"])
synchronize_operation(view_state)
```

The application-defined `synchronize_operation()` fetches durable state and reconciles events that arrive during startup. A worker might publish before the browser joins, so joining alone can't provide the complete initial state. The next unit explains how a snapshot watermark closes that gap.

A database specialist who joins an existing investigation uses negotiation, group membership, and status recovery to see the same findings as the other responders. Joining doesn't start duplicate AI work. Another tab belonging to an authorized responder can follow the same path.

::: zone-end

## Additional resources

These resources cover other server delivery targets and client message APIs. You can use them to extend the operation-group design without changing its durable-state boundary.

- [Push messages from a server](/azure/azure-web-pubsub/quickstarts-push-messages-from-server) introduces service SDK publishing.
- [Python client API reference](/python/api/azure-messaging-webpubsubclient/azure.messaging.webpubsubclient.webpubsubclient) documents message callbacks, joins, and client lifecycle methods.
