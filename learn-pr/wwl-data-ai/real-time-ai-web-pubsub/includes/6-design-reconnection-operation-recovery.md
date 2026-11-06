::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=b2e65f6f-af88-4070-92bc-140a8b90f38f]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

A responder's browser can lose its connection while an AI worker continues investigating an incident. Restoring the WebSocket is only part of restoring the experience: the browser also needs the correct group membership, current generated findings, and authoritative operation status. Python fragments illustrate the recovery decisions without requiring browser implementation code.

> [!NOTE]
> The Python examples in this unit are teaching patterns for client behavior, not Python code executed in the browser. They focus on notification sequencing and state reconciliation. Buffering, status requests, and displayed-state changes use application-defined helpers rather than a complete application.

## Distinguish session recovery from a new connection

The Python client SDK uses a [reliable Web PubSub subprotocol](/azure/azure-web-pubsub/howto-develop-reliable-clients) by default. The protocol supports acknowledgments and limited recovery of an interrupted connection session. That capability helps with brief network interruptions, but it doesn't make the service a durable application event log.

The SDK attempts recovery with the connection ID and recovery credentials. The service retains session information and unacknowledged messages within bounded conditions. Don't add manual protocol acknowledgments alongside the SDK.

If recovery fails, the SDK can attempt a new connection according to its configuration. That connection needs fresh negotiation and appropriate group membership.

A page reload loses in-memory text, the last applied application sequence, and SDK state. The new page reconstructs its view from durable operation state.

These distinctions lead to different outcomes:

- **Recovered session:** Protocol recovery can restore retained messages.
- **New connection:** The client reauthorizes, restores membership, and reconciles durable state.
- **Stopped client:** The UI offers retry, sign-in, or status-only access instead of claiming reconnection continues.

## Define an application sequence for each operation

Transport and application identifiers have different lifetimes. The reliable protocol's `sequenceId` belongs to a connection session, while an application sequence belongs to the operation stream shared by all authorized observers. A page that reconnects later needs the application sequence to relate a snapshot to live notifications.

The examples use contiguous, monotonically increasing sequences for one operation's entire client-visible stream. The next notification must have the previous value plus one.

Filtered subsets need separate sequences or a contract that explains intentional gaps. Don't apply contiguous-sequence checks to arbitrary subsets of a global stream.

Assign the event ID and sequence when recording the notification. Reuse both on publish retries so one logical update doesn't appear to be several.

Multiple workers need a durable sequence allocator or a single operation publisher. Allocation alone doesn't ensure publish order. A single ordered publisher simplifies delivery; otherwise clients need buffering or reconciliation for out-of-order arrivals.

## Apply each notification at most once in the current view

A repeated text delta duplicates words, even if repeated progress snapshots look harmless. A shared sequence guard rejects duplicates before changing the displayed state and identifies gaps in the generated findings.

Suppose the responder's browser displays all updates through sequence 14. It compares each arriving sequence with the last one it applies before changing the displayed findings.

| Last applied sequence | Incoming sequence | Decision | Effect on the displayed findings |
|---|---|---|---|
| 14 | 14 | Duplicate | Ignore the repeated update |
| 14 | 15 | Next expected update | Apply the update and remember sequence 15 |
| 15 | 17 | Gap; sequence 16 is missing | Hold the update and retrieve current operation state |

These decisions don't depend on a particular programming language. The Python SDK dispatches client callbacks on separate threads, so those callbacks and snapshot updates must serialize access to each operation's view state. The following Python fragment supplies the publishing unit's `accept_in_sequence()` helper and uses a per-operation lock for that serialization. The `apply` parameter is a callback: a function that updates local application state only after the sequence checks pass.

The `state` dictionary holds the last applied sequence and whether the view is synchronized. Until the initial state is loaded, arriving notifications go into a size-limited temporary buffer. Create one lock for each operation. Apply snapshot replacement and buffered-event reconciliation under the same lock. Keep network requests outside the critical section.

```python
# Code fragment - focus on duplicate and gap detection
from collections.abc import Callable
from threading import Lock

operation_lock = Lock()


def accept_in_sequence(
    state: dict,
    event: dict,
    apply: Callable[[], None],
    state_lock,
) -> str:
    with state_lock:
        if not state["synchronized"]:
            buffer_for_reconciliation(state, event)
            return "buffered"
        if event["sequence"] <= state["last_sequence"]:
            return "duplicate"
        if event["sequence"] == state["last_sequence"] + 1:
            apply()
            state["last_sequence"] = event["sequence"]
            return "applied"

        state["synchronized"] = False
        buffer_for_reconciliation(state, event)

    request_reconciliation(state)
    return "gap"
```

The callback validates its payload before changing the view. If the update fails, `last_sequence` doesn't advance. The application's error handler must show the failure and request a fresh copy of operation state. `buffer_for_reconciliation()` only changes local bounded state while the lock is held. `request_reconciliation()` runs after the lock is released so a network request doesn't block event processing.

The buffering and recovery-request helpers are application functions, not SDK methods. The buffer limits both notification count and total bytes. Only one recovery request should run at a time.

Client deduplication doesn't provide exactly-once backend processing. Business side effects still need idempotency.

## Reconcile a snapshot with live notifications

A snapshot is a copy of the operation's current durable text, progress, and status. Its `lastSequence` value is a watermark: the highest notification sequence whose effects the snapshot includes. The live stream supplies changes after that point.

For example, a snapshot with `lastSequence` set to 18 already includes the effects of notification 17. The browser can discard a buffered copy of notification 17, then apply notification 19. It doesn't need to reconstruct every missed text delta because the snapshot supplies the current text.

The client must subscribe before requesting the snapshot. That order lets it buffer updates that arrive while the HTTP request is in progress.

You can use the following recovery flow for an operation:

1. Register handlers and mark the view as unsynchronized.
1. Establish the connection and wait for operation-group membership.
1. Buffer notifications while requesting the authorized status snapshot.
1. Validate the operation ID, schema, and watermark. Snapshot state must consistently represent that watermark.
1. Replace the displayed text and status with the snapshot, then set the client state's `last_sequence` to the snapshot's `lastSequence`.
1. Discard buffered notifications at or below the watermark, then apply newer notifications in order.
1. Declare synchronization only when updates are contiguous. A remaining gap requires a newer snapshot or application-provided replay.

Keep incoming events buffered while replacing the view and applying the buffered updates under the same operation lock used by `accept_in_sequence()`. Don't let a new event change the old view halfway through replacement. Ignore late status responses from an earlier connection or recovery attempt.

A status response can be older than updates the browser already displays, such as when the backend reads from a lagging database replica. Don't replace newer output with that older snapshot. Keep the view marked as resynchronizing until a sufficiently recent response arrives, subject to a retry limit.

Without retained history, replace partial text from the snapshot rather than replay missed deltas. A completed snapshot restores the result even after a missed completion event.

## Restore group membership explicitly

Membership restoration depends on how the connection joins a group. The Python SDK's `auto_rejoin_groups` behavior tracks groups joined by client code. It doesn't automatically recreate every membership that a server previously assigns.

Automatic rejoin can fail if the new token lacks permission. A `connected` event doesn't prove that membership is restored.

Token-assigned groups need authorization and inclusion in the new token. Server-assigned groups need backend restoration for the new connection ID.

The following Python callback runs when the SDK reports a failed group rejoin. It marks the view as unsynchronized and reports a delivery error. The application-defined status-only mode retrieves current state through the authorized status endpoint with bounded polling.

```python
# Code fragment - focus on an explicit group-restoration failure
from azure.messaging.webpubsubclient.models import CallbackType


def on_rejoin_failed(event) -> None:
    view_state["synchronized"] = False
    show_delivery_error(f"Live updates are unavailable for group {event.group}")
    enter_status_only_mode()


client.subscribe(CallbackType.REJOIN_GROUP_FAILED, on_rejoin_failed)
```

Offer reauthentication or retry when appropriate. If access is revoked, stop requesting the denied stream.

## Recover when no later event reveals the gap

Sequence checks only reveal a missing notification when another notification arrives. If completion is the last event and the browser misses it, no later sequence necessarily exposes the loss. Recovery therefore needs triggers beyond gap detection.

Reconcile after new connections, page reloads, or unexpected inactivity. Account for normal model pauses rather than repeatedly reconnect during expected silence.

Show delivery state separately from business state. Reconnecting means uncertain delivery; resynchronizing means view recovery. Durable completed or failed status remains the operation's outcome.

::: zone-end

## Additional resources

These resources provide details for implementing the recovery contract with the client SDK. You can use them to check lifecycle events and protocol behavior without building a second protocol implementation in your application.

- [Web PubSub client specification](/azure/azure-web-pubsub/reference-client-specification) describes reliable protocol responsibilities.
- [Python client SDK](/azure/azure-web-pubsub/reference-client-sdk-python) explains connection callbacks, retry options, and automatic group rejoin.
