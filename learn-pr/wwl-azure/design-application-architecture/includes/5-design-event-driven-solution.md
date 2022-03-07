Event driven architecture enables you to connect to the core application without needing to modify the existing code. When an event occurs, you can react with your own code to these events. Event-driven applications use the send and forget principle. The event gets sent toward the next system, which can be another service, an event hub, a stream, or a message broker.

Let’s consider that music-sharing application again, this time with a Web API that runs in Azure. When a user uploads a new song, you must notify all the mobile apps installed on user devices around the world that are interested in that genre of music. In this requirement. Azure Event Grid is a perfect solution for this sort of requirement.

- The publisher of the sound file doesn't need to know about any of the subscribers interested in the shared music. 

- We want to have a one-to-many relationship where we can have multiple subscribers. Subscribers who can optionally decide whether they’re interested in this new song.

## What is Azure Event Grid?

[Azure Event Grid](/azure/event-grid/overview) is a fully managed event routing service running on top of Azure Service Fabric. Event Grid distributes events from sources such as Azure blob storage accounts and Azure media services. These events are distributed to handlers such as Azure Functions and Webhooks. Event Grid exists to make it easier to build event-based and serverless applications on Azure.

- Aggregates all your events and provides routing from any source to any destination. 

- Is a service that manages the routing and delivery of events from many sources and subscribers. This process eliminates the need for polling and results in minimized cost and latency.

The following illustration displays an Azure Event Grid positioned between multiple event sources and multiple event handlers. The event sources send events to the Event Grid and the Event Grid forwards relevant events to the subscribers. Event Grid use topics to decide which events to send to which handlers. Events sources tag each event with one or more topics, and event handlers subscribe to the topics they’re interested in.

:::image type="content" source="../media/event-grid.png" alt-text="A graphic displays Event Sources linked to Event Handlers by topics, and event grid, and event subscriptions.":::

Event Grid sends an event to indicate something has happened or changed. However, the actual object that was changed isn’t part of the event data. Instead, a URL or identifier is often passed to reference the changed object.

## Comparison of services

Let’s take a few minutes to review the message and event solutions we have covered.

| Service| Purpose| Type| When to use |
| - | - | - | - |
| **Event Grid**| Reactive programming| Event distribution (discrete)| React to status changes |
| **Event Hubs**| Big data pipeline| Event streaming (series)| Telemetry and distributed data streaming |
| **Service Bus**| High-value enterprise messaging| Message| Order processing and financial transactions |


 

## Use the services together

In some cases, you use the services side by side to fulfill distinct roles. For example, an e-commerce site can use Service Bus to process the order, Event Hubs to capture site telemetry, and Event Grid to respond to events like an item was shipped. In other cases, you link them together to form an event and data pipeline. You use Event Grid to respond to events in the other services. The following image shows the workflow for streaming the data.

:::image type="content" source="../media/services-integration.png" alt-text="Event Hubs, Event Grid, Functions are working together.":::