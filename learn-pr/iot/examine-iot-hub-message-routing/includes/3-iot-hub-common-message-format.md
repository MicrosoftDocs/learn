To support seamless interoperability across protocols, Azure IoT Hub defines a common set of messaging features that are available in all device-facing protocols. These messaging features can be used in both device-to-cloud message routing and cloud-to-device messages.

Azure IoT Hub implements device-to-cloud messaging using a streaming messaging pattern. Azure IoT Hub's device-to-cloud messages are more like Event Hubs events than Service Bus messages because there's a high volume of events that pass through the service that can be read by multiple readers.

An Azure IoT Hub message consists of:

* A predetermined set of *system properties* as described later in this unit.
* A set of *application properties*. A dictionary of string properties that the application can define and access, without needing to deserialize the message body. Azure IoT Hub never modifies these properties.
* A message body, which can be any type of data.

Property names and values can only contain ASCII alphanumeric characters and `! # $ % & ' * + - . ^ _  ``` | ~` when you send device-to-cloud messages using the HTTPS protocol or send cloud-to-device messages.

Device-to-cloud messaging with Azure IoT Hub has the following characteristics:

* Device-to-cloud messages are durable and retained in an Azure IoT Hub's default messages/events endpoint for up to seven days.
* Device-to-cloud messages can be at most 256 KB, and can be grouped in batches to optimize sends. Batches can be at most 256 KB.
* Azure IoT Hub doesn't allow arbitrary partitioning. Device-to-cloud messages are partitioned based on their originating **deviceId**.
* Azure IoT Hub enables per-device authentication and access control.
* You can stamp messages with information that goes into the application properties.

For more information about how to encode and decode messages sent using different protocols, see [Azure IoT SDKs](/azure/iot-hub/iot-hub-devguide-sdks).

Each IoT Hub protocol provides a message content type property, which is respected when routing data to custom endpoints. To have your data properly handled at the destination (for example, JSON being treated as a parsable string instead of Base64 encoded binary data), provide the appropriate content type and charset for the message.

To use your message body in an IoT Hub routing query, provide a valid JSON object for the message and set the content type property of the message to `application/json;charset=utf-8`.

A valid, routable message body may look like the following definition:

```json
{
    "timestamp": "2022-02-08T20:10:46Z",
    "tag_name": "spindle_speed",
    "tag_value": 100
}
```

## System properties of D2C Azure IoT Hub messages

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **User Settable?**
  :::column-end:::
  :::column:::
    Keyword for
routing query
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    message-id
  :::column-end:::
  :::column:::
    A user-settable identifier for the message used for request-reply patterns. Format: A case-sensitive string (up to 128 characters long) of ASCII 7-bit alphanumeric characters. The following other characters can also be used `- : . + % \ # * ? ! ( ) , = @ ; $ '`.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    messageId
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    iothub-enqueuedtime
  :::column-end:::
  :::column:::
    The date and time the device-to-cloud message was received by Azure IoT Hub.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    enqueuedTime
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    user-id
  :::column-end:::
  :::column:::
    An ID used to specify the origin of messages. When messages are generated by Azure IoT Hub, it's set to `{Azure IoT Hub name}`.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    userId
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    iothub-connection-device-id
  :::column-end:::
  :::column:::
    An ID set by Azure IoT Hub on device-to-cloud messages. It contains the **deviceId** of the device that sent the message.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    connectionDeviceId
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    iothub-connection-module-id
  :::column-end:::
  :::column:::
    An ID set by Azure IoT Hub on device-to-cloud messages. It contains the **moduleId** of the device that sent the message.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    connectionModuleId
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    iothub-connection-auth-generation-id
  :::column-end:::
  :::column:::
    An ID set by Azure IoT Hub on device-to-cloud messages. It contains the **connectionDeviceGenerationId** (as per Device identity properties) of the device that sent the message.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    connectionDeviceGenerationId
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    iothub-connection-auth-method
  :::column-end:::
  :::column:::
    An authentication method set by Azure IoT Hub on device-to-cloud messages. This property contains information about the authentication method used to authenticate the device sending the message.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    connectionAuthMethod
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    iothub-app-iothub-creation-time-utc
  :::column-end:::
  :::column:::
    Allows the device to send event creation time when sending data in a batch.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    creation-time-utc
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    iothub-creation-time-utc
  :::column-end:::
  :::column:::
    Allows the device to send event creation time when sending one message at a time.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    creation-time-utc
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    dt-dataschema
  :::column-end:::
  :::column:::
    This value is set by Azure IoT Hub on device-to-cloud messages. It contains the device model ID set in the device connection.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    $dt-dataschema
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    dt-subject
  :::column-end:::
  :::column:::
    The name of the component that is sending the device-to-cloud messages.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    $dt-subject
  :::column-end:::
:::row-end:::

## System properties of C2D Azure IoT Hub messages

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **User Settable?**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    message-id
  :::column-end:::
  :::column:::
    A user-settable identifier for the message used for request-reply patterns. Format: A case-sensitive string (up to 128 characters long) of ASCII 7-bit alphanumeric characters. The following other characters can also be used  `- : . + % _ # * ? ! ( ) , = @ ; $ '`.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    sequence-number
  :::column-end:::
  :::column:::
    A number (unique per device-queue) assigned by Azure IoT Hub to each cloud-to-device message.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    to
  :::column-end:::
  :::column:::
    A destination specified in cloud-to-device messages.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    absolute-expiry-time
  :::column-end:::
  :::column:::
    Date and time of message expiration.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    correlation-id
  :::column-end:::
  :::column:::
    A string property in a response message that typically contains the MessageId of the request, in request-reply patterns.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    user-id
  :::column-end:::
  :::column:::
    An ID used to specify the origin of messages. When messages are generated by Azure IoT Hub, it's set to \{Azure IoT Hub name\}.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    iothub-ack
  :::column-end:::
  :::column:::
    A feedback message generator. This property is used in cloud-to-device messages to request Azure IoT Hub to generate feedback messages as a result of the consumption of the message by the device. Possible values: **none** (default): no feedback message is generated, **positive**: receive a feedback message if the message was completed, **negative**: receive a feedback message if the message expired (or maximum delivery count was reached) without being completed by the device, or **full**: both positive and negative.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::

## System property names

The system property names vary based on the endpoint to which the messages are being routed. See the following table for details.

| System property name | Event Hubs | Azure Storage | Service Bus | Event Grid |
| --- | --- | --- | --- | --- |
| Message ID | message-id | messageId | MessageId | message-id |
| User ID | user-id | userId | UserId | user-id |
| Connection device ID | iothub-connection-device-id | connectionDeviceId | iothub-connection-device-id | iothub-connection-device-id |
| Connection module ID | iothub-connection-module-id | connectionModuleId | iothub-connection-module-id | iothub-connection-module-id |
| Connection auth generation ID | iothub-connection-auth-generation-id | connectionDeviceGenerationId | iothub-connection-auth-generation-id | iothub-connection-auth-generation-id |
| Connection auth method | iothub-connection-auth-method | connectionAuthMethod | iothub-connection-auth-method | iothub-connection-auth-method |
| contentType | content-type | contentType | ContentType | iothub-content-type |
| contentEncoding | content-encoding | contentEncoding | ContentEncoding | iothub-content-encoding |
| iothub-enqueuedtime | iothub-enqueuedtime | enqueuedTime | N/A | iothub-enqueuedtime |
| CorrelationId | correlation-id | correlationId | CorrelationId | correlation-id |
| dt-dataschema | dt-dataschema | dt-dataschema | dt-dataschema | dt-dataschema |
| dt-subject | dt-subject | dt-subject | dt-subject | dt-subject |

## Message size

Azure IoT Hub measures message size in a protocol-agnostic way, considering only the actual payload. The size in bytes is calculated as the sum of the following values:

* The body size in bytes.
* The size in bytes of all the values of the message system properties.
* The size in bytes of all user property names and values.

Property names and values are limited to ASCII characters, so the length of the strings equals the size in bytes.

## Anti-spoofing properties

To avoid device spoofing in device-to-cloud messages, Azure IoT Hub stamps all messages with the following properties:

* **iothub-connection-device-id**
* **iothub-connection-auth-generation-id**
* **iothub-connection-auth-method**

The first two contain the **deviceId** and **generationId** of the originating device as per [device identity properties](/azure/iot-hub/iot-hub-devguide-identity-registry#device-identity-properties).

The **iothub-connection-auth-method** property contains a JSON serialized object, with the following properties:

```json
{
  "scope": "{ hub | device }",
  "type": "{ symkey | sas | x509 }",
  "issuer": "iothub"
}

```
