Message enrichment is the ability of the IoT Hub to stamp messages with additional information before the messages are sent to the designated endpoint. One reason to use message enrichments is to include data that can be used to simplify downstream processing. For example, enriching device telemetry messages with a device twin tag can reduce load on customers to make device twin API calls for this information.

:::image type="content" source="../media/m04-l01-message-enrichments-flow-804be88e.png" alt-text="Diagram that shows an optional message processing path that include a message enrichment being added to a device message.":::


A message enrichment has three key elements:

 -  Enrichment name or key
 -  A value
 -  One or more endpoints for which the enrichment should be applied.

The key is a string. A key can only contain alphanumeric characters or these special characters: hyphen (-), underscore (\_), and period (.).

The value can be any of the following examples:

 -  Any static string. Dynamic values such as conditions, logic, operations, and functions are not allowed. For example, if you develop a SaaS application that is used by several customers, you can assign an identifier to each customer and make that identifier available in the application. When the application runs, IoT Hub will stamp the device telemetry messages with the customer's identifier, making it possible to process the messages differently for each customer.
 -  The name of the IoT hub sending the message. This value is `$iothubname`.
 -  Information from the device twin, such as its path. Examples would be $twin.tags.field and $twin.tags.latitude.

> [!NOTE]
> At this time, only `$iothubname`, `$twin.tags`, `$twin.properties.desired`, and `$twin.properties.reported` are supported variables for message enrichment.

Message Enrichments are added as application properties to messages sent to chosen endpoint(s).

## Applying enrichments

The messages can come from any data source supported by IoT Hub message routing, including the following examples:

 -  Device telemetry, such as temperature or pressure.
 -  Device twin change notifications -- changes in the device twin.
 -  Device lifecycle events, such as when the device is created or deleted.

You can add enrichments to messages that are going to the built-in endpoint of an IoT Hub, or messages that are being routed to custom endpoints such as Azure Blob storage, a Service Bus queue, or a Service Bus topic.

You can also add enrichments to messages that are being published to Event Grid by selecting the endpoint as Event Grid.

Enrichments are applied per endpoint. If you specify five enrichments to be stamped for a specific endpoint, all messages going to that endpoint are stamped with the same five enrichments.

## Limitations

 -  You can add up to 10 enrichments per IoT Hub for those hubs in the standard or basic tier. For IoT Hubs in the free tier, you can add up to 2 enrichments.
 -  In some cases, if you are applying an enrichment with a value set to a tag or property in the device twin, the value will be stamped as a string value. For example, if an enrichment value is set to `$twin.tags.field`, the messages will be stamped with the string "`$twin.tags.field`" rather than the value of that field from the twin. This happens in the following cases:
     -  Your IoT Hub is in the basic tier. Basic tier IoT hubs do not support device twins.
     -  Your IoT Hub is in the standard tier, but the device sending the message has no device twin.
     -  Your IoT Hub is in the standard tier, but the device twin path used for the value of the enrichment does not exist. For example, if the enrichment value is set to `$twin.tags.location`, and the device twin does not have a `location` property under `tags`, the message is stamped with the string "`$twin.tags.location`".
 -  Updates to a device twin can take up to five minutes to be reflected in the corresponding enrichment value.
 -  The total message size, including the enrichments, can't exceed 256 KB. If a message size exceeds 256 KB, the IoT Hub will drop the message. You can use IoT Hub metrics to identify and debug errors when messages are dropped. For example, you can monitor `d2c.telemetry.egress.invalid`.
 -  Message enrichments don't apply to digital twin change events (part of the IoT Plug and Play public preview).

## Pricing

Message enrichments are available at no extra charge. Currently, you are charged when you send a message to an IoT Hub. You are only charged once for that message, even if the message goes to multiple endpoints.
