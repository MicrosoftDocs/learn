::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=20911b0f-03ac-44ea-af72-475c97bb3cf2]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

In this module, you learned how to choose a client delivery approach for an AI application on Azure. You compared direct HTTP streaming, SSE, polling, and Azure Web PubSub based on communication direction, fan-out, and connection ownership. You explored how durable queues and workflows coordinate backend processing while Web PubSub delivers updates to connected clients. You kept operation ownership, current output, approval state, and terminal outcomes in a durable source of truth. You also explored authenticated negotiation that verifies operation access before issuing a scoped client access URL. You separated backend Azure RBAC permissions from the group permissions granted to a browser connection. You defined an application event envelope for text batches, progress, approval requests, and terminal notifications. You used operation groups to share one AI investigation's progress and findings with authorized incident responders without making the worker manage individual browser sockets. Additionally, you distinguished bounded SDK session recovery from application-state recovery after a new connection or page reload. You used application sequence values, deduplication, and snapshot watermarks to restore a consistent view. Finally, you explored batching thresholds and bounded buffers for high-frequency output. You defined explicit behavior for slow or disconnected clients so delivery problems don't erase successful backend work.

::: zone-end

## Additional resources

These resources provide implementation and operational details for a production delivery channel. You can use them to verify current SDK behavior and investigate the connection path independently of your AI processing workflow.

- [Web PubSub authentication and authorization](/azure/azure-web-pubsub/concept-client-protocols#authorization) describes connection tokens and client permissions.
- [Python client SDK](/azure/azure-web-pubsub/reference-client-sdk-python) explains connection lifecycle callbacks, message handlers, and group rejoin.
- [Web PubSub resource log troubleshooting](/azure/azure-web-pubsub/howto-troubleshoot-resource-logs) describes resource logs and live tracing.
- [Monitor Azure Web PubSub](/azure/azure-web-pubsub/howto-azure-monitor) explains metrics, alerts, and diagnostic integration with Azure Monitor.
