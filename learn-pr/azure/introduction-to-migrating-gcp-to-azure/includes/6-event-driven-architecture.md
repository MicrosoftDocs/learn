Most complex systems in recent years are implemented as a set of separate services rather than a single monolithic application. This approach helps make the systems manageable, scalable, and versatile. With cloud-native microservices, the approach reaches an advanced level that works well on cloud hosts. However, microservices must communicate with each other to formulate responses to user requests. You can make those communications more robust by using message queues or event buses.

In the global cycling retailer, the customer-facing website is a cloud-native application built via microservices. It uses Google Pub/Sub, Google Eventarc, and Google Cloud Functions to guarantee service reliability. You're assessing whether to migrate the system to Azure, and you want to understand the equivalent message-handling services.

In this unit, you learn about message queue systems and event-driven architectures in Azure and Google Cloud.

:::image type="content" source="../media/events-messaging-overview.png" alt-text="Diagram that shows the types of services provided by Microsoft Azure and Google Cloud, with events messaging highlighted." border="false":::

## What are event-driven and messaging architectures?

In a distributed system, components are often decoupled services that must collaborate to formulate responses to user requests.

For example, your developers might create a web front-end service that presents a catalog of cycling products to customers. When a user adds a bike to the shopping basket, the front end might send a message to the basket service with the product ID and number to add. When the user completes the purchase, the basket service might alert the stock management service to decrement stock numbers and request a dispatch. The completed system requires many more services and communications between them.

You can choose to call other services directly, but this approach can become difficult to manage at times of high demand or when services face a temporary interruption. Messaging services and event hubs handle such difficulties smoothly. Messaging services and event hubs maintain a queue of messages or a stream of events.

These two approaches are similar but have a different emphasis. Event-driven architectures:

- Promote the production, detection, consumption of, and reaction to events. Events are state changes or significant occurrences in a component.
- Include event producers that publish events and their characteristics.
- Have event consumers that listen for and respond to events.
- Use an event store to manage the stream of events.
- Support real-time data processing and immediate responses.

Messaging architectures:

- Focus on communication between components with messages. A message can be any portion of data transmitted between services.
- Include message producers that send messages and their contents.
- Have message consumers that receive and process messages.
- Use a message broker to maintain queues of messages for consumers to pick up.
- Support reliable communications between decoupled components such as microservices.

## Compare event-driven architecture services

Google Cloud's event-driven services include Pub/Sub for event ingestion and delivery. Eventarc is a service for routing events from various sources to Cloud Run, Cloud Functions, or Workflows. Let's compare these services with Azure equivalents:

| Purpose | Azure | Google Cloud | Comments |
|---------|---------|---------|---------|
| Event routing | [Azure Event Grid](/azure/event-grid/overview) | Eventarc | Event Grid is a fully managed event-routing service that uses a publish and subscribe model with near real-time processing. You can use it to build event-based architectures by routing events from any source to any destination. Event Grid offers a more integrated experience with Azure services. |
| Responding to events | [Azure Functions](/azure/azure-functions/functions-overview) | Cloud Functions | Azure Functions is a serverless compute service that enables you to run code on demand, triggered by events from various sources. Google Cloud Functions also enables you to run serverless, on-demand code. |
| Event handling | [Azure Event Hubs](/azure/event-hubs/event-hubs-about) | Pub/Sub or Managed Service for Apache Kafka | Event Hubs is a big-data streaming platform and an event ingestion service that can process millions of events per second. Event Hubs offers an API that has compatibility and parity with Apache Kafka.|

## Compare messaging services

You can use the Google Cloud Pub/Sub service to host both event-driven and messaging architecture. Azure doesn't take this approach. To build messaging in Azure, use the following services instead of Event Grid:

| Purpose | Azure service | Comments |
|---------|---------|---------|
| Message queue | [Azure Queue Storage](/azure/storage/queues/storage-queues-introduction) | Azure Queue Storage is a simple queue service for large-volume messaging between application components. |
| Message broker | [Azure Service Bus](/azure/service-bus-messaging/service-bus-messaging-overview) | Azure Service Bus is an enterprise message broker with message queues and publish/subscribe topics. |

## Learn more

- [Use a message broker and events to integrate enterprise systems](/azure/architecture/example-scenario/integration/queues-events)
- [Explore Azure Event Grid](/training/modules/azure-event-grid/)
- [Discover Azure message queues](/training/modules/discover-azure-message-queue/)
- [Explore Azure Event Hubs](/training/modules/azure-event-hubs/)
