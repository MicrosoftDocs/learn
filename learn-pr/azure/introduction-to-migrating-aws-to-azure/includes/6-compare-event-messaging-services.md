Cloud-native solutions often consist of components, sometimes termed microservices, that each implement part of the functionality required. To satisfy any single user request, these components must communicate reliably and scalability. Event-driven and messaging architectures provide services that enable this communication.

In your global clothing retailer, you have two public-facing web sites. One in Amazon Web Services (AWS) that you created before the merger, and one developed by the competitor you acquired which is in Azure. Both web sites are implemented as cloud-native applications with loosely coupled microservices communicating through message queues and event busses. You want to create a single company web site from these two web sites. So, you need to know how you can migrate the messaging services and event busses.

In this unit, you explore event-driven and messaging architectures and compare how you can implement them in AWS and Azure.

:::image type="content" source="../media/events-messaging-overview.png" alt-text="A diagram showing the types of service provided by Microsoft Azure and Amazon AWS." border="false":::

## What are event-driven and messaging architectures?

Event-driven architectures:

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

In both AWS and Azure, event-driven and messaging architectures are crucial for building scalable systems. Both platforms offer services that tightly integrate with other components, enabling complex event-driven workflows and seamless event handling.

There are, however, conceptual differences between the architectures in AWS and Azure.

## Event-driven architecture

In AWS, **EventBridge** and **SNS** are primarily used for event distribution, while **Lambda** is used for handling events. In Azure, **Event Grid** is the main service for event routing, while **Azure Functions** can be used to handle event processing.

| Purpose | Azure | AWS | Comments |
|---------|---------|---------|---------|
| Event routing | [Event Grid](/azure/event-grid/overview) | Amazon EventBridge | Event Grid is a fully managed event routing service that uses a publish and subscribe model with near real-time processing. It enables you to build event-based architectures by routing events from any source to any destination. By comparison, EventBridge is also a serverless event bus service that connects applications using data, integrated Software-as-a-Service (SaaS) applications, and AWS services. |
| Responding to events | [Azure Functions](/azure/azure-functions/functions-overview) | Lambda | Azure Functions is a serverless compute service that enables you to run code on-demand, triggered by events from various sources. AWS Lambda also enables you to run serverless, on-demand code. Lambda overlaps with [Azure WebJob](/azure/app-service/webjobs-create) functionality, which enables you to schedule or continuously run background tasks. |
| Event handling | [Azure Event Hubs](/azure/event-hubs/event-hubs-about) | Amazon Kinesis Streams | Azure Event Hubs is a big data streaming platform and event ingestion service, capable of processing millions of events per second. |

## Messaging Architecture

In AWS, **SQS** is used for point-to-point messaging, whereas **SNS** provides a publish and subscribe model. In Azure, **Service Bus** supports both queue and publish and subscribe messaging patterns, while **Queue Storage** is used for simpler queueing requirements.

| Service | Azure | AWS | Comments |
|---------|---------|---------|---------|
| Message queuing | [Queue Storage](/azure/storage/queues/storage-queues-introduction) | SQS (Simple Queue Service) Amazon MQ | Azure Queue Storage is a simple queue service for large-volume messaging between application components. |
| Message broker | [Service Bus](/azure/service-bus-messaging/service-bus-messaging-overview) | Simple Notification service (SNS) | Azure Service Bus is an enterprise message broker with message queues and publish-subscribe topics. Azure Service Bus is a messaging service, however, and doesn't create notifications. Amazon MQ is a message broker service for Apache ActiveMQ and RabbitMQ. Amazon SNS is used to send notifications in an event-driven architecture, often used alongside Lambda. |

## Learn more

- [Use a message broker and events to integrate enterprise systems](/azure/architecture/example-scenario/integration/queues-events)
- [Explore Azure Event Grid](/training/modules/azure-event-grid/)
- [Discover Azure message queues](/training/modules/discover-azure-message-queue/)
- [Explore Azure Event Hubs](/training/modules/azure-event-hubs/)
