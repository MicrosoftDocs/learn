::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=59ae60ab-612b-41bd-8033-d3a4ec7dba87]

::: zone-end

::: zone pivot="text"

AI applications often need to share live updates from one background operation with several users. Azure Functions, Service Bus, Event Grid, and Durable Functions address backend execution and coordination, while [Azure Web PubSub](/azure/azure-web-pubsub/overview) manages persistent client connections and group-based message delivery. This module guides you through using that client-facing fan-out to deliver progress updates, generated findings, and completion notifications in an AI solution on Azure.

Imagine you're a developer building an AI incident-investigation assistant for a production application on Azure. During an outage, the assistant analyzes logs to identify likely causes. The on-call developer, incident commander, and database specialist follow the same investigation from separate browsers. Each responder needs the latest progress and generated findings before the final report is ready. A response streamed only to the developer who starts the investigation doesn't reach the other responders. With Web PubSub, a worker publishes each update once to the investigation's authorized group. The service distributes the update to every connected group member without the worker managing individual browser connections. If a responder disconnects, the investigation continues. Durable backend state lets returning responders recover the current findings and final report. The assistant supports shared investigation rather than executing remediation actions.

After completing this module, you'll be able to:

- Choose a client delivery approach based on communication direction, fan-out, and connection-scale requirements.
- Explain how Azure Web PubSub complements durable backend messaging and workflow coordination.
- Implement authenticated client negotiation with operation-scoped group access.
- Build group-based delivery for AI updates from backend workers.
- Implement recovery and bounded update delivery for slow or disconnected clients.

> [!NOTE]
> All Python code examples and Python-related content in this module target Python 3.12 or later. The examples use the most recent versions of the `azure-messaging-webpubsubservice` and `azure-messaging-webpubsubclient` libraries at the time of writing. The libraries are updated often. Visit the [Azure Web PubSub service library for Python](/python/api/overview/azure/messaging-webpubsubservice-readme) and the [Azure Web PubSub client library for Python](/python/api/overview/azure/messaging-webpubsubclient-readme) for the most up-to-date information.
>
> Client-side algorithms use Python for teaching consistency, not because Python runs in the browser.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
