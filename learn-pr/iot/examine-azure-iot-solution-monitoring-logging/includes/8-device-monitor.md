Azure IoT Hub supports several methods for monitoring the status of your devices. While Azure Monitor is the preferred *aggregate* device monitoring solution, typically for large numbers of devices, this unit presents device monitoring methods better suited to respond to individual device outages. It provides guidance to help you choose the best option for your IoT solution.

The following table introduces three ways to monitor your device connection status:

| Method | Status frequency | Cost | Effort to build |
| --- | --- | --- | --- |
| Event Grid | 60 seconds | Low | Low |
| Device twin connectionState property | Intermittent | Low | Low |
| Custom device heartbeat pattern | Custom | High | High |

Because of its reliability, low cost, and ease of use, we recommend [Event Grid](/azure/event-grid/overview) as the preferred individual device monitoring solution for most customers.

However, there are certain limitations to monitoring with Event Grid that may disqualify it for some IoT solutions. This unit discusses the benefits and limitations of each option.

## Event Grid

[Event Grid](/azure/event-grid/overview) is a fully managed event routing service that uses a publish-subscribe model. Event Grid has built-in support for Azure services like Azure Functions and Azure Logic Apps, and can deliver event alerts to non-Azure services using webhooks. For a complete list of the event handlers that Event Grid supports, see [Event Handlers](/azure/event-grid/overview#event-handlers).

Subscribe to the **deviceConnected** and **deviceDisconnected** events on Event Grid to get alerts and monitor the device connection state.

Use the following articles to learn how to integrate device connected and disconnected events in your IoT Hub solution:

* [React to IoT Hub events by using Event Grid to trigger actions](/azure/iot-hub/iot-hub-event-grid)
* [Order device connection events by using Cosmos DB](/azure/iot-hub/iot-hub-how-to-order-connection-state-events)

Device connection state events are available for devices connecting using either the MQTT or AMQP protocol, or using either of these protocols over WebSockets. Requests made only with HTTPS won't trigger device connection state notifications.

* For devices connecting using the Azure IoT SDKs for Java, Node, or Python:
  * MQTT: connection state events are sent automatically.
  * AMQP: a [cloud-to-device link](/azure/iot-hub/iot-hub-amqp-support#invoke-cloud-to-device-messages-service-client) should be created to reduce delays in reporting connection states.

For devices connecting using the Azure IoT SDKs for .NET or C, connection state events won't be reported until an initial device-to-cloud message is sent or a cloud-to-device message is received.

Outside of the Azure IoT SDKs, in MQTT these operations equate to SUBSCRIBE or PUBLISH operations on the appropriate messaging topics. Over AMQP these operations equate to attaching or transferring a message on the appropriate link paths.

### Event Grid limitations

Using Event Grid to monitor your device status comes with the following limitations:

* Event Grid doesn't report each individual device connect and disconnect event. Instead, it polls for device status every 60 seconds and publishes the most recent connection state if there was a state change. For this reason, state change reports may be delayed up to one minute and individual state changes may be unreported if multiple events happen within the 60-second window.
* Devices that use AMQP need [cloud-to-device link](/azure/iot-hub/iot-hub-amqp-support#invoke-cloud-to-device-messages-service-client) before they can report device status.
* Event Grid exposes a public endpoint that can't be hidden.

If any of these limitations affect your ability to use Event Grid for device status monitoring, then you should consider building a custom device heartbeat pattern instead.

## Device twin connectionState

Every IoT Hub device identity contains a property called **connectionState** that reports either connected or disconnected. This property represents IoT Hub's understanding of a device's connection status.

The connection state property has several limitations:

* The connection state is updated only for devices that use MQTT or AMQP.
* Updates to this property rely on protocol-level pings and may be delayed as much as five minutes.

For these reasons, we recommend that you only use the **connectionState** field during development and debugging. IoT solutions shouldn't query the field at run time. For example, don't query the **connectionState** field to check if a device is connected before you send a cloud-to-device message or an SMS.

## Device heartbeat pattern

If you need to know the connection state of your devices but the limitations of Event Grid are too restricting for your solution, you can implement the *heartbeat pattern*. In the heartbeat pattern, the device sends device-to-cloud messages at least once every fixed amount of time (for example, at least once every hour). Even if a device doesn't have any data to send, it still sends an empty device-to-cloud message, usually with a property that identifies it as a heartbeat message. On the service side, the solution maintains a map with the last heartbeat received for each device. If the solution doesn't receive a heartbeat message within the expected time from the device, it assumes that there's a problem with the device.

### Device heartbeat limitations

Since heartbeat messages are implemented as device-to-cloud messages, they count against your [IoT Hub message quota and throttling limits](/azure/iot-hub/iot-hub-devguide-quotas-throttling).

### Short expiry time pattern

If an IoT solution uses the connection state solely to determine whether to send cloud-to-device messages to a device, and messages aren't broadcast to large sets of devices, consider using the *short expiry time pattern* as a simpler alternative to the heartbeat pattern. The short expiry time pattern is a way to determine whether to send cloud-to-device messages by sending messages with a short message expiration time and requesting message acknowledgments from the devices.

For more information, see [Message expiration (time to live)](/azure/iot-hub/iot-hub-devguide-messages-c2d#message-expiration-time-to-live).

## Monitor devices using multiple methods

You can use multiple methods to monitor devices. A more complex implementation could include the information from Azure Monitor and Azure Resource Health to identify devices that are trying to connect or communicate but failing. Azure Monitor dashboards are helpful for seeing the aggregate health of your devices, while Event Grid and heartbeat patterns make it easier to respond to individual device outages.
