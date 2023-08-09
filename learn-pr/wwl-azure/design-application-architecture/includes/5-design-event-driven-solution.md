
An event-driven architecture enables you to connect to the core application without needing to modify the existing code. When an event occurs, you can react with specific code to respond to the event. An event-driven application uses the _send and forget_ principle. An event is sent toward the next system, which can be another service, an event hub, a stream, or a message broker.

Let's reconsider our design for the Tailwind Traders product demo application, and examine how to use a Web API that runs in Azure. When a new product review or demo video is uploaded, we need to notify all mobile apps on user devices around the world that are interested in the products. Azure Event Grid is an ideal solution for this requirement.
- The publisher of the review or video doesn't need to know about any subscribers who are interested in the affected products. 
- We want to have a one-to-many relationship where we can have multiple subscribers. Subscribers can optionally decide whether they're interested in the affected products.

### Things to know about Azure Event Grid

[Azure Event Grid](/azure/event-grid/overview) is a fully managed event routing service that runs on [Azure Service Fabric](/azure/service-fabric/service-fabric-overview). Event Grid exists to make it easier to build event-based and serverless applications on Azure. Examine the following characteristics of the service.

- Azure Event Grid aggregates all your events and provides routing from any source to any destination. 

- Event Grid distributes events from sources like Azure Blob Storage accounts and Azure Media Services.

- Events are distributed to handlers like Azure Functions and Azure DevOps Webhooks.

- The service manages the routing and delivery of events from many sources. The management helps to minimize cost and latency by eliminating the need for polling. 

#### How Azure Event Grid works

The following illustration shows how Azure Event Grid manages the event process from multiple event sources to multiple event handlers.

:::image type="content" source="../media/event-grid.png" alt-text="Ilustrationg shows how Azure Event Grid manages the event process from multiple event sources to multiple event handlers." border="false":::

- An event source such as Azure Blob Storage tags events with one or more topics, and sends events to Azure Event Grid.

- An event handler such as Azure Functions subscribes to topics they're interested in.

- Event Grid examines topic tags to decide which events to send to which handlers.

- Event Grid forwards relevant events to subscribers.

- Event Grid sends an event to indicate something has happened or changed. However, the actual object that was changed (text file, video, audio, and so on) isn't part of the event data. Instead, Event Grid passes a URL or identifier to reference the changed object.

### Things to consider when using Azure Event Grid

Azure Event Grid can be an ideal solution for an event-driven application architecture. As you review the following considerations, think about how Event Grid can benefit the Tailwind Traders application architecture.

- **Consider multiple services**. Choose one or multiple Azure services to fulfill your design requirements.

   | Azure service | Purpose | Message or Event | Usage scenario |
   | --- | --- | --- | --- |
   | **Azure Event Grid**| Reactive programming | Event distribution (discrete)| _React to status changes_ |
   | **Azure Event Hubs**| Big data pipeline | Event streaming (series) | _Conduct telemetry and distributed data streaming_ |
   | **Azure Service Bus**| High-value enterprise messaging | Message | _Fulfill order processing and financial transactions_ |

- **Consider distinct roles for services**. Investigate using Azure services side by side to fulfill distinct roles. An e-commerce site can use Azure Service Bus to process an order, Azure Event Hubs to capture site telemetry, and Azure Event Grid to respond to events like an item being shipped.

- **Consider linking services**. Link Azure services together to form an event and data pipeline stream. In this scenario, Azure Event Grid responds to events in other services. The following illustration demonstrates how several Azure services can be linked together as an event and data pipeline to stream data.
   
   :::image type="content" source="../media/services-integration.png" alt-text="Illustration that shows how Azure Event Hubs, Event Grid, and Functions link together to respond to events and stream data." border="false":::