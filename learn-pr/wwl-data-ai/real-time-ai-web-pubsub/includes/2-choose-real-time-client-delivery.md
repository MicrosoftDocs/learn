::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=01d90eb8-37cb-4fcb-9ec6-7b6cd64287a6]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

An AI application doesn't need a managed WebSocket service for every incremental response. An assistant that streams one log summary to one developer has different requirements from an incident workspace where several responders observe the same background investigation. You can choose among HTTP streaming, Server-Sent Events (SSE), polling, and Azure Web PubSub by examining the communication direction, number of recipients, and lifetime of the work.

## Match the response channel to the operation

A response channel determines how the browser receives updates, not how reliably the backend processes work. Begin with the client experience you need rather than with a preferred protocol. The simplest design is often sufficient when one caller waits for one result.

With **direct HTTP streaming**, the server writes portions of a response before the entire result is available. For example, an incident-investigation assistant can stream a generated log summary through the HTTP response to one developer's request. The browser reads the response incrementally through a streaming API instead of waiting for the complete body.

The output channel remains tied to that HTTP request. Another tab needs a separate subscription or relay to observe the same operation. After a disconnect, the application decides whether to restart, resume retained output, or query the result.

An HTTP stream isn't automatically visible to the user as soon as the backend writes a chunk. A reverse proxy, compression layer, or application framework can buffer the response. You need to verify incremental delivery through the actual hosting path, not just through a direct local connection. Connection idle timeouts also matter when model processing pauses between updates.

## Use Server-Sent Events for a one-way event stream

Server-Sent Events (SSE) adds an event format to a long-lived HTTP response with the `text/event-stream` content type. Unlike an arbitrary stream of text or bytes, the SSE format defines fields for event data, event names, and event identifiers. SSE fits an AI application that needs server-to-browser progress events but doesn't need client messages on the same channel.

The browser's `EventSource` API manages an SSE connection and normally attempts to reconnect after an interruption. An SSE server can assign event IDs, and the browser can send the last received ID when it reconnects. However, the server still needs retained events and resume logic to make those IDs useful. Automatic reconnection doesn't reconstruct output that the server never stores.

SSE is one-way at the application-message level. A user can submit an approval or cancellation through a separate authenticated HTTP request. That separation is often desirable because the command needs input validation, authorization, and a durable business outcome regardless of the update transport.

For Azure hosting paths that include Application Gateway, the [SSE guidance](/azure/application-gateway/use-server-sent-events) explains response buffering and timeout considerations. Those settings affect whether the browser receives events promptly even when the application emits them correctly.

## Use polling when updates are infrequent

Polling asks an authorized status endpoint for the current operation state at an application-defined interval. The server reads a durable record rather than maintaining a continuous delivery connection for the browser. Polling is a practical choice when operations change state infrequently or users only need a final result.

For example, an archived-log analysis might take several minutes but expose only queued, processing, and completed states. A periodic status request can meet that experience without a live messaging channel. The same status endpoint also supports recovery when a streaming connection fails.

Shorter polling intervals improve freshness but increase requests, including checks that return unchanged state. Longer intervals reduce traffic but delay visible completion. More observers multiply that request load.

You can use retry delays and bounded backoff during outages. An asynchronous API can return a status URL with `202 Accepted` and provide `Retry-After` guidance. The browser must still stop or reduce polling after a terminal outcome rather than continue checking a completed operation indefinitely.

## Use Azure Web PubSub for independent connections and fan-out

[Azure Web PubSub](/azure/azure-web-pubsub/overview) manages WebSocket connections between the service and application clients. A backend worker can publish an update once to a group that contains several authorized browser connections. The delivery channel can remain independent of the HTTP request that starts the AI operation.

This model fits an incident workspace where the on-call developer, incident commander, and database specialist observe the same AI investigation. One worker update, such as "Log analysis complete" or "Likely cause: database connection exhaustion," reaches each authorized responder through the operation group. The worker doesn't need to hold each browser socket or run inside the web API process. Web PubSub handles connection distribution while your application defines who can join each group.

WebSockets support bidirectional communication, but your application doesn't have to expose client broadcasting. A receive-only browser can observe worker notifications while commands continue to use authenticated HTTP APIs. If you use client-to-server WebSocket events, the backend still needs an authorized handler that validates the requested action.

Managed connections still require capacity planning for concurrent connections, message volume, fan-out, and backend publishing.

> [!NOTE]
> Azure Web PubSub tiers, quotas, and pricing change regularly. For current capacity and cost information, see [Azure Web PubSub pricing](https://azure.microsoft.com/pricing/details/web-pubsub/).

## Compare delivery choices before adding infrastructure

Transport selection works best when you compare concrete requirements rather than label one option as more advanced. A single-recipient response and a shared operation dashboard can both be real-time experiences, but they place different demands on your application. The following comparison summarizes those differences.

| Approach | Application-message direction | Relationship to the request | Fan-out | Live connection owner | Recovery responsibility |
|---|---|---|---|---|---|
| Direct HTTP streaming | Response flows to caller | Uses the response to the initiating or subscription request | Application implements shared delivery | Application hosting stack | Application defines resume or replacement |
| SSE | Server to client | Uses a long-lived subscription response | Application serves or distributes streams | Application hosting stack | Browser reconnects; server implements retained-event replay |
| Polling | Client requests; server responds | Separate short status requests | Each client queries status | No continuous application delivery connection | Durable state supplies the latest status |
| Web PubSub | Bidirectional capability with explicit permissions | Separate WebSocket connection | Groups distribute updates to connected members | Managed service | SDK handles bounded session recovery; application restores durable state |

For a single generated answer, start by evaluating HTTP streaming or SSE. For infrequent background status changes, evaluate polling. Choose Web PubSub when independently connected recipients, group-based delivery, or connection-scale requirements justify the additional service.

Azure SignalR Service is a related but distinct choice. SignalR provides an application programming model with hubs, client method invocation, and transport negotiation. Web PubSub is suited to WebSocket-oriented applications that define their own messaging contract. Existing SignalR applications should evaluate the SignalR integration rather than assume a Web PubSub client is a drop-in replacement.

::: zone-end

## Additional resources

These resources expand on transport and application-design choices beyond the comparison in this unit. You can use them to evaluate an existing client stack before changing your architecture.

- [Choose between Azure Web PubSub and Azure SignalR Service](/azure/azure-web-pubsub/resource-faq#how-do-i-choose-between-azure-signalr-service-and-azure-web-pubsub-service) explains how the services differ.
- [Asynchronous request-reply pattern](/azure/architecture/patterns/async-request-reply) describes an API contract for long-running work and status retrieval.
