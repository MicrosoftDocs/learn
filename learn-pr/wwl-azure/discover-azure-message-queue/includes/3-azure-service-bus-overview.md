



Microsoft Azure Service Bus is a fully managed enterprise integration message broker. Service Bus can decouple applications and services. Data is transferred between different applications and services using **messages**. A message is a container decorated with metadata, and contains data. The data can be any kind of information, including structured data encoded with the common formats such as the following ones: JSON, XML, Apache Avro, Plain Text.

Some common messaging scenarios are:

* *Messaging*. Transfer business data, such as sales or purchase orders, journals, or inventory movements.
* *Decouple applications*. Improve reliability and scalability of applications and services. Client and service don't have to be online at the same time.
* *Topics and subscriptions*. Enable 1:*n* relationships between publishers and subscribers.
* *Message sessions*. Implement workflows that require message ordering or message deferral.

##  Service Bus tiers

Service Bus offers a standard and premium tier. The *premium* tier of Service Bus Messaging addresses common customer requests around scale, performance, and availability for mission-critical applications. The premium tier is recommended for production scenarios. Although the feature sets are nearly identical, these two tiers of Service Bus Messaging are designed to serve different use cases.

Some high-level differences are highlighted in the following table.

| Premium | Standard |
|--|--|
| High throughput | Variable throughput |
| Predictable performance | Variable latency |
| Fixed pricing | Pay as you go variable pricing |
| Ability to scale workload up and down | N/A |
| Message size up to 100 MB | Message size up to 256 KB |


## Advanced features

Service Bus includes advanced features that enable you to solve more complex messaging problems. The following table describes several of these features.

| Feature | Description |
|--|--|
| Message sessions | To create a first-in, first-out (FIFO) guarantee in Service Bus, use sessions. Message sessions enable exclusive, ordered handling of unbounded sequences of related messages. |
| Autoforwarding | The autoforwarding feature chains a queue or subscription to another queue or topic that is in the same namespace. |
| Dead-letter queue | Service Bus supports a dead-letter queue (DLQ). A DLQ holds messages that can't be delivered to any receiver. Service Bus lets you remove messages from the DLQ and inspect them. |
| Scheduled delivery | You can submit messages to a queue or topic for delayed processing. You can schedule a job to become available for processing by a system at a certain time. |
| Message deferral | A queue or subscription client can defer retrieval of a message until a later time. The message remains in the queue or subscription, but it's set aside. |
| Batching | Client-side batching enables a queue or topic client to delay sending a message for a certain period of time. |
| Transactions | A transaction groups two or more operations together into an *execution scope*. Service Bus supports grouping operations against a single messaging entity within the scope of a single transaction. A message entity can be a queue, topic, or subscription. |
| Filtering and actions | Subscribers can define which messages they want to receive from a topic. These messages are specified in the form of one or more named subscription rules. |
| Autodelete on idle | Autodelete on idle enables you to specify an idle interval after which a queue is automatically deleted. The minimum duration is 5 minutes. |
| Duplicate detection | An error could cause the client to have a doubt about the outcome of a send operation. Duplicate detection enables the sender to resend the same message, or for the queue or topic to discard any duplicate copies. |
| Security protocols | Service Bus supports security protocols such as Shared Access Signatures (SAS), Role Based Access Control (RBAC) and Managed identities for Azure resources. |
| Geo-disaster recovery | When Azure regions or datacenters experience downtime, Geo-disaster recovery enables data processing to continue operating in a different region or datacenter. |
| Security | Service Bus supports standard AMQP 1.0 and HTTP/REST protocols. |

## Compliance with standards and protocols

The primary wire protocol for Service Bus is [Advanced Messaging Queueing Protocol (AMQP) 1.0](/azure/service-bus-messaging/service-bus-amqp-overview), an open ISO/IEC standard. It allows customers to write applications that work against Service Bus and on-premises brokers such as ActiveMQ or RabbitMQ. The [AMQP protocol guide](/azure/service-bus-messaging/service-bus-amqp-protocol-guide) provides detailed information in case you want to build such an abstraction.

Service Bus Premium is fully compliant with the Java/Jakarta EE [Java Message Service (JMS) 2.0](/azure/service-bus-messaging/how-to-use-java-message-service-20) API.

## Client libraries

Fully supported Service Bus client libraries are available via the Azure SDK.

* [Azure Service Bus for .NET](/dotnet/api/overview/azure/service-bus)
* [Azure Service Bus libraries for Java](/java/api/overview/azure/servicebus)
* [Azure Service Bus provider for Java JMS 2.0](/azure/service-bus-messaging/how-to-use-java-message-service-20)
* [Azure Service Bus Modules for JavaScript and TypeScript](/javascript/api/overview/azure/service-bus)
* [Azure Service Bus libraries for Python](/python/api/overview/azure/servicebus)

