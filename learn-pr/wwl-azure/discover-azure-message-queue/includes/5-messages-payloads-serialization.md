



Messages carry a payload and metadata. The metadata is in the form of key-value pair properties, and describes the payload, and gives handling instructions to Service Bus and applications. Occasionally, that metadata alone is sufficient to carry the information that the sender wants to communicate to receivers, and the payload remains empty.

The object model of the official Service Bus clients for .NET and Java maps to and from the wire protocols Service Bus supports.

A Service Bus message consists of a binary payload section that Service Bus never handles in any form on the service-side, and two sets of properties. The *broker properties* are system defined. These predefined properties either control message-level functionality inside the broker, or they map to common and standardized metadata items. The *user properties* are a collection of key-value pairs defined and set by the application.

## Message routing and correlation

A subset of the broker properties, specifically `To`, `ReplyTo`, `ReplyToSessionId`, `MessageId`, `CorrelationId`, and `SessionId`, help applications route messages to particular destinations. The following patterns describe the routing:

* **Simple request/reply:** A publisher sends a message into a queue and expects a reply from the message consumer. The publisher owns a queue to receive the replies. The address of that queue is contained in the `ReplyTo` property of the outbound message. When the consumer responds, it copies the `MessageId` of the handled message into the `CorrelationId` property of the reply message and delivers the message to the destination indicated by the `ReplyTo` property. One message can yield multiple replies, depending on the application context.

* **Multicast request/reply:** As a variation of the prior pattern, a publisher sends the message into a topic and multiple subscribers become eligible to consume the message. Each of the subscribers might respond in the fashion described previously. If `ReplyTo` points to a topic, such a set of discovery responses can be distributed to an audience.

* **Multiplexing:** This session feature enables multiplexing of streams of related messages through a single queue or subscription such that each session (or group) of related messages, identified by matching `SessionId` values, are routed to a specific receiver while the receiver holds the session under lock. Learn more about the details of sessions [here](/azure/service-bus-messaging/message-sessions).

* **Multiplexed request/reply:** This session feature enables multiplexed replies, allowing several publishers to share a reply queue. By setting `ReplyToSessionId`, the publisher can instruct the consumer(s) to copy that value into the `SessionId` property of the reply message. The publishing queue or topic doesn't need to be session-aware. When the message is sent the publisher can wait for a session with the given `SessionId` to materialize on the queue by conditionally accepting a session receiver.

Routing inside of a Service Bus namespace uses autoforward chaining and topic subscription rules. Routing across namespaces can be performed using Azure LogicApps. The `To` property is reserved for future use. Applications that implement routing should do so based on user properties and not lean on the `To` property; however, doing so now won't cause compatibility issues.

## Payload serialization

When in transit or stored inside of Service Bus, the payload is always an opaque, binary block. The `ContentType` property enables applications to describe the payload, with the suggested format for the property values being a MIME content-type description according to IETF RFC2045; for example, `application/json;charset=utf-8`.

Unlike the Java or .NET Standard variants, the .NET Framework version of the Service Bus API supports creating `BrokeredMessage` instances by passing arbitrary .NET objects into the constructor.

The legacy SBMP protocol serializes objects with the default binary serializer, or with a serializer that is externally supplied. The AMQP protocol serializes objects into an AMQP object. The receiver can retrieve those objects with the `GetBody<T>()` method, supplying the expected type. With AMQP, the objects are serialized into an AMQP graph of `ArrayList` and `IDictionary<string,object>` objects, and any AMQP client can decode them.

While this hidden serialization magic is convenient, if applications should take explicit control of object serialization and turn their object graphs into streams before including them into a message, they should do the reverse operation on the receiver side. While AMQP has a powerful binary encoding model, it's tied to the AMQP messaging ecosystem and HTTP clients have trouble decoding such payloads.

