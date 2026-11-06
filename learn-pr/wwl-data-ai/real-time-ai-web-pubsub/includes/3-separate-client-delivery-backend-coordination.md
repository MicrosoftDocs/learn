::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=99b7de4d-0e8a-4af3-84c4-5943d518b248]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

An AI incident investigation can outlive the browser tab that starts it. The application needs a durable record of the work even when no responder receives live updates. Azure Web PubSub supplies the client-facing delivery channel, while backend messaging, workflow services, and data stores retain responsibility for processing.

> [!NOTE]
> The examples in this unit are architecture and data-contract patterns to adapt to your application. They don't define a complete queue processor, database schema, or authentication implementation.

## Separate work submission from progress delivery

The API that accepts an AI request shouldn't require a browser connection to remain open until processing finishes. An [asynchronous request-reply design](/azure/architecture/patterns/async-request-reply) returns an operation identifier and a status URL while work continues independently. Web PubSub adds a live observation channel to that design rather than replacing the durable status endpoint.

For the incident-investigation assistant, the API authenticates the responder and validates the requested log-analysis scope. The application records the investigation operation before making the work available to a backend processor. The worker retrieves authorized logs and calls the model to generate findings. It writes current progress and findings to durable storage. A notification describes each meaningful change to connected responders.

The following diagram separates the work path from the observation path. The status API remains available even when the live channel is disconnected.

```text
Work path
Browser -> Authenticated API -> Durable operation record
                            -> Queue or workflow -> Worker -> AI services

Observation path
Worker -> Durable state update -> Web PubSub operation group -> Browsers
Browser -> Authorized status API -> Durable operation record
```

A production design must also account for failure between recording an operation and submitting its work. A durable workflow or an outbox-based handoff can prevent an accepted operation from remaining permanently unscheduled. The same principle applies later when state changes must produce notifications.

## Keep backend coordination in the appropriate service

Backend coordination determines which component performs work, when a step can run, and what happens after failure. Client delivery determines which connected users see the resulting updates. Treating those responsibilities separately avoids making a transient browser connection part of a durable business transaction.

Different Azure services address different backend needs:

- **Azure Service Bus:** A queue buffers submitted work for backend consumers. Message settlement and application idempotency support safe processing when workers fail or retry.
- **Azure Event Grid:** Event subscriptions route notifications about backend state changes to interested handlers. An application handler can translate a backend event into a client-facing update.
- **Azure Durable Functions:** An orchestration coordinates long-running steps, durable waits, and human decisions. An activity can publish a client notification without putting external calls inside replaying orchestrator logic.
- **Azure Web PubSub:** A worker or notification component sends updates to connected clients. Groups organize recipients, not work ownership or durable execution history.

A Web PubSub group isn't a Service Bus subscription or a competing-consumer queue. Publishing an investigation request to a group doesn't assign that task to one reliable worker. Group members receive broadcasts while they participate in the group; the application still needs a backend processing mechanism.

You don't need all three backend services for every solution. An existing queue-based application can add Web PubSub without adopting Durable Functions. A durable workflow can notify clients without introducing Event Grid solely to forward each progress update.

## Make the operation record authoritative

A durable operation record gives clients a reliable answer to "What is happening now?" even after missed notifications. The record must contain enough state to reconstruct the user experience, not just a flag that says a worker started. Decide which fields the browser needs before defining the live event contract.

For example, an authorized status response can expose the following snapshot. The backend retains ownership and tenant information for access checks; the response includes only fields the authorized client needs.

```json
{
    "operationId": "op42",
    "status": "processing",
    "progress": {
        "stage": "analyze-database-logs",
        "percent": 60
    },
    "currentText": "The database logs indicate",
    "pendingApproval": null,
    "resultPath": null,
    "stateVersion": 18,
    "lastSequence": 14
}
```

The `stateVersion` identifies a revision of durable application state. The `lastSequence` identifies the latest notification sequence represented by the snapshot. Those values don't have to match because some internal state changes don't produce client notifications.

The watermark must be consistent with the snapshot. A response that claims to include sequence 14 must actually contain the effects of updates through sequence 14. Otherwise, a recovering client might discard a notification for output that the snapshot doesn't contain. You can maintain the state and sequence together in a database transaction or use an equivalent consistency mechanism.

The owner, tenant, assigned incident responders, and operation ID belong to the authorization model. Identifiers aren't passwords. Every status, result, negotiation, approval, and cancellation endpoint checks the caller's access to the referenced operation.

## Persist state before notification delivery

A notification should describe a change that clients can already verify through the status API. Persisting state first prevents a browser from receiving "completed" and then discovering that the result doesn't exist. However, a database write and a Web PubSub publish aren't one atomic transaction.

Consider a worker that stores a completed report and then crashes before publishing completion. The work succeeds, but connected browsers might continue showing an older progress value. Recovery through the status endpoint resolves that stale view without repeating the AI operation.

When eventual notification publishing is a requirement, you can record a notification alongside the state change in a transactional outbox. A separate publisher reads pending notifications, sends them to Web PubSub, and marks them as sent. A failure after sending but before recording success can cause a duplicate, so the publisher reuses the same event ID and sequence on retry.

An outbox improves the reliability of the handoff to the delivery service. It doesn't prove that every browser receives or displays the event. Disconnected clients still need state recovery, and connected clients still need deduplication.

For text generation, the durable snapshot must include the text covered by its sequence watermark. If the application checkpoints text less often than it publishes deltas, it needs retained deltas or a recovery policy that explicitly handles that difference. Don't advertise a complete snapshot while silently omitting acknowledged output.

## Treat approvals and cancellation as backend commands

An approval prompt tells an authorized decision-maker that a decision is required; it isn't the decision itself. For example, the incident commander might need to approve draft findings before the assistant finalizes its investigation report. The application must validate the decision-maker and the current approval version before changing durable state. This boundary remains necessary even when Web PubSub supports bidirectional messaging.

You can include an approval request ID and an operation-relative action path in the notification. The browser submits the decision to an authenticated backend endpoint. The backend verifies the decision-maker, rejects stale decisions, and records an audit entry before resuming report preparation.

The same rule applies to cancellation. Closing a tab or losing a connection doesn't automatically cancel backend work. A deliberate cancellation request needs its own authorization and business policy, including what happens if the AI call already finishes.

Client-visible outcomes should distinguish processing success from delivery problems. A completed report remains completed even if a progress notification fails. The UI can show that live updates are unavailable while the status endpoint continues to expose the authoritative result.

::: zone-end

## Additional resources

These resources provide deeper implementation guidance for the durability boundaries in this unit. You can use them when a notification must survive a worker restart or a workflow requires a human decision.

- [Transactional outbox pattern with Azure Cosmos DB](/azure/architecture/databases/guide/transactional-outbox-cosmos) describes a durable state-to-message handoff.
- [Durable Functions human interaction pattern](/azure/durable-task/common/durable-task-human-interaction) explains persistent approval waits and timeout decisions.
