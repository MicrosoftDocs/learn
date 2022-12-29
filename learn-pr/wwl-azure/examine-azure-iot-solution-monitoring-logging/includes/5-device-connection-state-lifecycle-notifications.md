Device events enable you to keep your solution healthy. Some parameters are easy to check or verify, while others can be more difficult to track.

## Device heartbeat

Knowing whether a device is connected at a particular moment is not as easy as you may think. Continuously testing the connection would be a waste of resources and in some cases, such as low power devices that enter a sleep mode for extended intervals, could be impossible.

The IoT Hub identity registry contains a field called **connectionState**, but IoT solutions should not query this field at run time. Only use the **connectionState** field during development and debugging. For example, do not query the **connectionState** field to check if a device is connected before you send a cloud-to-device message or an SMS. We recommend subscribing to the device disconnected event on Event Grid to get alerts and monitor the device connection state.

If your IoT solution needs to know if a device is connected, you can implement the *heartbeat pattern*. In the heartbeat pattern, the device sends device-to-cloud messages at least once every fixed amount of time (for example, at least once every hour). When this pattern is implemented, even if a device does not have any data to send, it still sends an empty device-to-cloud message (usually with a property that identifies it as a heartbeat). On the service side, the solution maintains a map with the last heartbeat received for each device. If the solution does not receive a heartbeat message within the expected time from the device, it assumes that there is a problem with the device.

A more complex implementation could include the information from Azure Monitor and Azure Resource Health to identify devices that are trying to connect or communicate but failing. When you implement the heartbeat pattern, make sure to check IoT Hub Quotas and Throttles.

> [!NOTE]
> If an IoT solution uses the connection state solely to determine whether to send cloud-to-device messages, and messages are not broadcast to large sets of devices, consider using the simpler short expiry time pattern. This pattern achieves the same result as maintaining a device connection state registry using the heartbeat pattern, while being more efficient. If you request message acknowledgments, IoT Hub can notify you about which devices are able to receive messages and which are not.

## Device and module lifecycle notifications

IoT Hub can notify your IoT solution when an identity is created or deleted by sending lifecycle notifications. To do so, your IoT solution needs to create a route and to set the Data Source equal to **DeviceLifecycleEvents** or **ModuleLifecycleEvents**. By default, no lifecycle notifications are sent, that is, no such routes pre-exist. The notification message includes properties, and body.

Properties: Message system properties are prefixed with the /$ symbol.

Notification message for device:

:::row:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **Value**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    $content-type
  :::column-end:::
  :::column:::
    application/json
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    $iothub-enqueuedtime
  :::column-end:::
  :::column:::
    Time when the notification was sent.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    $iothub-message-source
  :::column-end:::
  :::column:::
    deviceLifecycleEvents
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    $content-encoding
  :::column-end:::
  :::column:::
    utf-8
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    opType
  :::column-end:::
  :::column:::
    createDeviceIdentity or deleteDeviceIdentity
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    hubName
  :::column-end:::
  :::column:::
    Name of IoT Hub
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    deviceId
  :::column-end:::
  :::column:::
    ID of the device
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    operationTimestamp
  :::column-end:::
  :::column:::
    ISO8601 timestamp of operation
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    iothub-message-schema
  :::column-end:::
  :::column:::
    deviceLifecycleNotification
  :::column-end:::
:::row-end:::


Body: This section is in JSON format and represents the twin of the created device identity. For example,

```json
{
    "deviceId":"11576-ailn-test-0-67333793211",
    "etag":"AAAAAAAAAAE=",
    "properties": {
        "desired": {
            "$metadata": {
                "$lastUpdated": "2016-02-30T16:24:48.789Z"
            },
            "$version": 1
        },
        "reported": {
            "$metadata": {
                "$lastUpdated": "2016-02-30T16:24:48.789Z"
            },
            "$version": 1
        }
    }
}

```

Notification message for module:

:::row:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **Value**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    $content-type
  :::column-end:::
  :::column:::
    application/json
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    $iothub-enqueuedtime
  :::column-end:::
  :::column:::
    Time when the notification was sent.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    $iothub-message-source
  :::column-end:::
  :::column:::
    moduleLifecycleEvents
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    $content-encoding
  :::column-end:::
  :::column:::
    utf-8
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    opType
  :::column-end:::
  :::column:::
    createModuleIdentity or deleteModuleIdentity
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    hubName
  :::column-end:::
  :::column:::
    Name of IoT Hub
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    moduleId
  :::column-end:::
  :::column:::
    ID of the module
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    operationTimestamp
  :::column-end:::
  :::column:::
    ISO8601 timestamp of operation
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    othub-message-schema
  :::column-end:::
  :::column:::
    moduleLifecycleNotification
  :::column-end:::
:::row-end:::


Body: This section is in JSON format and represents the twin of the created module identity. For example,

```json
{
    "deviceId":"11576-ailn-test-0-67333793211",
    "moduleId":"tempSensor",
    "etag":"AAAAAAAAAAE=",
    "properties": {
        "desired": {
            "$metadata": {
                "$lastUpdated": "2016-02-30T16:24:48.789Z"
            },
            "$version": 1
        },
        "reported": {
            "$metadata": {
                "$lastUpdated": "2016-02-30T16:24:48.789Z"
            },
            "$version": 1
        }
    }
}

```

## Device identity properties

Device identities are represented as JSON documents with the following properties:

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Options**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    deviceId
  :::column-end:::
  :::column:::
    required, read-only on updates
  :::column-end:::
  :::column:::
    A case-sensitive string (up to 128 characters long) of ASCII 7-bit alphanumeric characters plus certain special characters: - . + % \_ \# \* ? ! ( ) , = @ $ '
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    generationId
  :::column-end:::
  :::column:::
    required, read-only
  :::column-end:::
  :::column:::
    An IoT hub-generated, case-sensitive string up to 128 characters long. This value is used to distinguish devices with the same **deviceId**, when they have been deleted and re-created.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    etag
  :::column-end:::
  :::column:::
    required, read-only
  :::column-end:::
  :::column:::
    A string representing a weak ETag for the device identity, as per RFC7232.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    auth
  :::column-end:::
  :::column:::
    optional
  :::column-end:::
  :::column:::
    A composite object containing authentication information and security materials.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    auth.symkey
  :::column-end:::
  :::column:::
    optional
  :::column-end:::
  :::column:::
    A composite object containing a primary and a secondary key, stored in base64 format.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    status
  :::column-end:::
  :::column:::
    required
  :::column-end:::
  :::column:::
    An access indicator. Can be **Enabled** or **Disabled**. If **Enabled**, the device is allowed to connect. If **Disabled**, this device cannot access any device-facing endpoint.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    statusReason
  :::column-end:::
  :::column:::
    optional
  :::column-end:::
  :::column:::
    A 128 character-long string that stores the reason for the device identity status. All UTF-8 characters are allowed.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    statusUpdateTime
  :::column-end:::
  :::column:::
    read-only
  :::column-end:::
  :::column:::
    A temporal indicator, showing the date and time of the last status update.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    connectionState
  :::column-end:::
  :::column:::
    read-only
  :::column-end:::
  :::column:::
    A field indicating connection status: either **Connected** or **Disconnected**. This field represents the IoT Hub view of the device connection status.

*Important:* This field should be used only for development/debugging purposes. The connection state is updated only for devices using MQTT or AMQP. Also, it is based on protocol-level pings (MQTT pings, or AMQP pings), and it can have a maximum delay of only 5 minutes. For these reasons, there can be false positives, such as devices reported as connected but that are disconnected.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    connectionStateUpdatedTime
  :::column-end:::
  :::column:::
    read-only
  :::column-end:::
  :::column:::
    A temporal indicator, showing the date and last time the connection state was updated.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    lastActivityTime
  :::column-end:::
  :::column:::
    read-only
  :::column-end:::
  :::column:::
    A temporal indicator, showing the date and last time the device connected, received, or sent a message.
  :::column-end:::
:::row-end:::


> [!NOTE]
> Connection state can only represent the IoT Hub view of the status of the connection. Updates to this state may be delayed, depending on network conditions and configurations.

> [!NOTE]
> Currently the device SDKs do not support using the + and \# characters in the deviceId.

## Module identity properties

Module identities are represented as JSON documents with the following properties:

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Options**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    deviceId
  :::column-end:::
  :::column:::
    required, read-only on updates
  :::column-end:::
  :::column:::
    A case-sensitive string (up to 128 characters long) of ASCII 7-bit alphanumeric characters plus certain special characters: - . + % \_ \# \* ? ! ( ) , = @ $ '
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    moduleId
  :::column-end:::
  :::column:::
    required, read-only on updates
  :::column-end:::
  :::column:::
    A case-sensitive string (up to 128 characters long) of ASCII 7-bit alphanumeric characters plus certain special characters: - . + % \_ \# \* ? ! ( ) , = @ $ '
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    generationId
  :::column-end:::
  :::column:::
    required, read-only
  :::column-end:::
  :::column:::
    An IoT hub-generated, case-sensitive string up to 128 characters long. This value is used to distinguish devices with the same **deviceId**, when they have been deleted and re-created.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    etag
  :::column-end:::
  :::column:::
    required, read-only
  :::column-end:::
  :::column:::
    A string representing a weak ETag for the device identity, as per RFC7232.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    auth
  :::column-end:::
  :::column:::
    optional
  :::column-end:::
  :::column:::
    A composite object containing authentication information and security materials.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    auth.symkey
  :::column-end:::
  :::column:::
    optional
  :::column-end:::
  :::column:::
    A composite object containing a primary and a secondary key, stored in base64 format.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    status
  :::column-end:::
  :::column:::
    required
  :::column-end:::
  :::column:::
    An access indicator. Can be **Enabled** or **Disabled**. If **Enabled**, the device is allowed to connect. If **Disabled**, this device cannot access any device-facing endpoint.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    statusReason
  :::column-end:::
  :::column:::
    optional
  :::column-end:::
  :::column:::
    A 128 character-long string that stores the reason for the device identity status. All UTF-8 characters are allowed.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    statusUpdateTime
  :::column-end:::
  :::column:::
    read-only
  :::column-end:::
  :::column:::
    A temporal indicator, showing the date and time of the last status update.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    connectionState
  :::column-end:::
  :::column:::
    read-only
  :::column-end:::
  :::column:::
    A field indicating connection status: either **Connected** or **Disconnected**. This field represents the IoT Hub view of the device connection status.

*Important:* This field should be used only for development/debugging purposes. The connection state is updated only for devices using MQTT or AMQP. Also, it is based on protocol-level pings (MQTT pings, or AMQP pings), and it can have a maximum delay of only 5 minutes. For these reasons, there can be false positives, such as devices reported as connected but that are disconnected.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    connectionStateUpdatedTime
  :::column-end:::
  :::column:::
    read-only
  :::column-end:::
  :::column:::
    A temporal indicator, showing the date and last time the connection state was updated.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    lastActivityTime
  :::column-end:::
  :::column:::
    read-only
  :::column-end:::
  :::column:::
    A temporal indicator, showing the date and last time the device connected, received, or sent a message.
  :::column-end:::
:::row-end:::


> [!NOTE]
> Currently the device SDKs do not support using the \\+ and \\\# characters in the \*\*deviceId\*\* and \*\*moduleId\*\*.
