::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=e8fb67ac-ee17-4be6-95e4-c39de82da67b]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

An AI model can generate incident findings faster than responders' browsers can usefully redraw the page. Publishing one notification per token adds message overhead, increases fan-out traffic, and makes slow clients harder to support. Batching and explicit buffer policies help an Azure Web PubSub application remain responsive without making live delivery the only record of progress.

> [!NOTE]
> The Python example in this unit is a pattern to adapt to your application. It uses a bounded asynchronous queue and an application-defined durable persistence helper. It doesn't implement a complete model client, outbox publisher, or production admission-control policy.

## Choose batch thresholds from the user experience

A text batch combines several generated fragments into one notification. A larger batch reduces publish operations but delays the first visible update and creates more work for one browser callback. Choose thresholds by measuring the full path from model output to visible text.

You can flush a batch when any of the following conditions occurs:

- **Time threshold:** The oldest buffered fragment reaches the allowed batching delay.
- **Item threshold:** The batch contains the maximum number of fragments.
- **Size threshold:** Adding another fragment would exceed the application's payload budget.
- **Operation boundary:** Generation finishes, fails, or pauses for a business decision.

For an initial evaluation, a 100-millisecond interval gives the batcher a concrete target without intentionally waiting for the complete investigation findings. That value isn't an Azure guarantee or a universal recommendation. Model output cadence, storage latency, publish latency, and rendering time all contribute to what the responder sees.

Message size means serialized bytes, not Python characters or model tokens. Escaped characters and envelope metadata add bytes. Validate the complete serialized envelope before publishing, even when the batcher separately limits its text payload.

## Flush on time even when no new fragment arrives

A batcher that checks elapsed time only when another token arrives can leave a short batch buffered during a model pause. A timer or timed queue wait avoids that problem. The batcher should also flush remaining text before the application records completion.

The following fragment reads from a bounded `asyncio.Queue`. A producer adds text with `await fragments.put(text)` and adds `None` after generation finishes. Empty fragments contain no new output, so the batcher doesn't create notifications for them.

The application-defined `persist_text_batch()` atomically appends text to durable operation state, allocates the next application sequence, and records the notification for publishing. An ordered outbox publisher then sends stored notifications using the service SDK pattern from the publishing unit. The persistence helper must use the same data serialization assumptions and enforce the complete-envelope budget.

```python
# Code fragment - focus on bounded time, count, and size batching
import asyncio
import json

FLUSH_INTERVAL = 0.1
MAX_ITEMS = 32
MAX_DATA_BYTES = 4096


def data_size(text: str) -> int:
    payload = json.dumps(
        {"text": text}, ensure_ascii=False, separators=(",", ":")
    )
    return len(payload.encode("utf-8"))


async def batch_text_updates(
    fragments: asyncio.Queue[str | None],
) -> None:
    if fragments.maxsize <= 0:
        raise ValueError("The fragment queue must be bounded")

    loop = asyncio.get_running_loop()
    pending = ""
    item_count = 0
    deadline = 0.0

    async def flush() -> None:
        nonlocal pending, item_count
        if pending:
            await persist_text_batch(pending)
            pending = ""
            item_count = 0

    while True:
        timeout = None
        if pending:
            timeout = max(0.0, deadline - loop.time())
            if timeout == 0:
                await flush()
                continue

        try:
            fragment = await asyncio.wait_for(
                fragments.get(), timeout=timeout
            )
        except TimeoutError:
            await flush()
            continue

        if fragment is None:
            await flush()
            return
        if fragment == "":
            continue
        if data_size(fragment) > MAX_DATA_BYTES:
            raise ValueError("A fragment exceeds the text payload budget")
        if pending and data_size(pending + fragment) > MAX_DATA_BYTES:
            await flush()

        if not pending:
            deadline = loop.time() + FLUSH_INTERVAL
        pending += fragment
        item_count += 1

        if item_count >= MAX_ITEMS or data_size(pending) >= MAX_DATA_BYTES:
            await flush()
```

The maximum data size in this example applies to the serialized `data` object, not the entire event envelope. The final publisher needs room for the operation ID, event ID, sequence, and other metadata. A producer should split oversized fragments safely before enqueueing them; the example raises an explicit error instead of truncating text.

The producer must await bounded queue insertion rather than create an unbounded number of pending tasks. The queue limits item count, so the producer also needs a bound on each fragment's size. Without both limits, one oversized queued item can still consume excessive memory.

The batching interval limits deliberate waiting while the event loop and persistence helper remain responsive. Slow storage can still delay flushing. The worker should await the batcher's final flush before persisting terminal status and recording completion. Unexpected batcher cancellation or persistence failure needs an explicit worker recovery path rather than a success notification.

## Match overflow behavior to the update type

Not every update has the same recovery requirements. A newer progress snapshot can replace an older one, but a text delta usually depends on earlier deltas. Define which updates can be coalesced before selecting an overflow policy.

Useful policies include:

- **Progress snapshots:** Keep the newest stage and percentage instead of retaining every intermediate value. The snapshot describes current state, so earlier values don't need to appear individually.
- **Generated-text deltas:** Preserve order and content. If the application abandons a backlog, mark the client view as incomplete and replace its text from durable state.
- **Approval requests:** Persist the pending decision and its version. A missed prompt must remain discoverable through the status API.
- **Terminal outcomes:** Persist completed or failed status independently of delivery. A returning user must see the final outcome even if every live notification is missed.

Coalescing also interacts with sequencing. If you remove a notification before assigning sequences, the published stream can remain contiguous. If you skip already assigned notifications, a client can see a gap. Either reconcile through a snapshot or use a contract that explicitly represents the skipped range; don't silently weaken the gap rule.

## Bound browser work separately from network delivery

A browser can receive messages successfully while rendering falls behind. Parsing, text layout, Markdown processing, and repeated DOM updates can consume more time than message delivery. Separate the receive rate from the visual update rate.

You can accumulate validated changes in an in-memory view model and schedule visual updates at a controlled cadence. A text node can render the latest accumulated text without rebuilding the whole document for each fragment. Keep that view model bounded and avoid repeatedly rendering all generated findings as rich content while the investigation continues.

The recovery buffer needs limits on both notification count and serialized bytes. If the buffer overflows, show a stale or resynchronizing state and request a fresh durable snapshot. Don't keep appending to an unlimited array while the status endpoint is unavailable.

The same policy applies to the outbox. A durable queue can absorb temporary delay, but it isn't an excuse for unlimited retention. Track publisher backlog age and size. Choose whether stale progress notifications can be compacted into a current-state notification without removing the durable approval or terminal record.

## Continue work without a connected browser

An AI operation shouldn't require every observer to remain online. A disconnected browser doesn't need an unlimited private backlog of progress updates. Preserve the operation state that the browser needs to recover, then use Web PubSub for clients that currently participate in delivery.

The reliable protocol provides only bounded session recovery. A slow client that can't keep up can lose its recoverable session. The application must still restore that client's current text, progress, and final outcome through its authorized status endpoint.

Notification publishing failures also need a separate policy from processing failures. You can use bounded retries for transient service errors and retain unresolved notifications for later dispatch. Every retry reuses the stored event ID and sequence.

Don't retry authorization errors indefinitely. A forbidden publish usually needs a role or configuration correction. Record the delivery failure and alert on persistent problems without changing an already completed AI operation into a failed model operation.

## Measure fan-out and visible update latency

One group publish can deliver data to many browser connections. The number of SDK calls therefore doesn't describe the total service traffic. Capacity planning needs the number of connected recipients as well as the size and rate of updates.

The [Web PubSub performance guide](/azure/azure-web-pubsub/concept-performance) describes how workload patterns affect throughput. The [billing model](/azure/azure-web-pubsub/concept-billing-model) explains outbound message accounting. Batching reduces envelope and operation overhead, but sending a large batch to many recipients still creates outbound traffic for those recipients.

> [!NOTE]
> Azure Web PubSub tiers, quotas, and pricing change regularly. For current details, see [Azure Web PubSub pricing](https://azure.microsoft.com/pricing/details/web-pubsub/) and the service's current capacity guidance in the linked performance guide.

Useful application measurements include batch payload bytes, fragments per batch, time to first visible update, and publish failures. You also need reconnect counts, snapshot reconciliation frequency, publisher backlog age, and browser backlog size. Define latency targets under an expected load rather than infer user experience from a successful publish response.

You can use operation IDs and event IDs to correlate delivery diagnostics. Don't log prompts, incident logs, generated findings, bearer tokens, or access URLs just to measure notification timing.

::: zone-end

## Additional resources

These resources help you observe behavior that application batching alone can't explain. You can use them to distinguish a service capacity problem from a slow publisher or browser.

- [Monitor Azure Web PubSub](/azure/azure-web-pubsub/howto-azure-monitor) describes metrics, diagnostics, and alerts.
- [Web PubSub monitoring data reference](/azure/azure-web-pubsub/howto-monitor-data-reference) lists the resource's available monitoring data.
