::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=8a797353-5298-4d2b-a412-71e0b29646a5]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

In this module, you learned how Azure Event Grid enables event-driven architectures for AI solutions by routing events from sources to handlers with low latency and high reliability. You explored the core Event Grid components, including topics, event subscriptions, and event handlers. You examined how these components work together to replace polling-based coordination with reactive triggers. You also learned how to design events using the CloudEvents v1.0 schema and define custom event types with reverse-DNS naming conventions. You configured event subscriptions with type filters, subject filters, and advanced data attribute filters to route events to the right handlers. You examined how Event Grid handles delivery failures through exponential backoff retries and customizable retry policies with TTL and maximum attempt settings. You also configured dead-letter destinations that capture undeliverable events for investigation. Finally, you learned how to publish custom events from AI applications using the Event Grid SDK and REST API. You constructed events that signal inference completions, model updates, and pipeline stage transitions so that downstream services can subscribe and react without modifying producers. These capabilities let you build AI systems that respond to state changes immediately, process events reliably, and scale by adding new event subscribers without modifying existing components.

::: zone-end

## Additional resources

- [Azure Event Grid documentation](/azure/event-grid/)
- [CloudEvents v1.0 schema with Azure Event Grid](/azure/event-grid/cloud-event-schema)
- [Event Grid message delivery and retry](/azure/event-grid/delivery-and-retry)
- [Publish events to Azure Event Grid custom topics](/azure/event-grid/post-to-custom-topic)
