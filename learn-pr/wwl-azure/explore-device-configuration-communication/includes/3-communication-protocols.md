The following table provides the high-level recommendations for your choice of protocol:

:::row:::
  :::column:::
    **Protocol**
  :::column-end:::
  :::column:::
    **When you should use this protocol**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MQTT
MQTT over WebSocket
  :::column-end:::
  :::column:::
    Use on all devices that do not require to connect multiple devices (each with its own per-device credentials) over the same TLS connection.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    AMQP
AMQP over Websocket
  :::column-end:::
  :::column:::
    Use on field and cloud gateways to take advantage of connection multiplexing across devices.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HTTPS
  :::column-end:::
  :::column:::
    Use for devices that cannot support other protocols.
  :::column-end:::
:::row-end:::


## Port numbers

Devices can communicate with IoT Hub in Azure using various protocols. Typically, the choice of protocol is driven by the specific requirements of the solution. The following table lists the outbound ports that must be open for a device to be able to use a specific protocol:

| **Protocol**         | **Port** |
|:-------------------- | --------:|
| MQTT                 |     8883 |
| MQTT over WebSockets |      443 |
| AMQP                 |     5671 |
| AMQP over WebSockets |      443 |
| HTTPS                |      443 |

## Considerations

Consider the following points when you choose your protocol for device-side communications:

 -  Cloud-to-device pattern. HTTPS does not have an efficient way to implement server push. As such, when you are using HTTPS, devices poll IoT Hub for cloud-to-device messages. This approach is inefficient for both the device and IoT Hub. Under current HTTPS guidelines, each device should poll for messages every 25 minutes or more. MQTT and AMQP support server push when receiving cloud-to-device messages. They enable immediate pushes of messages from IoT Hub to the device. If delivery latency is a concern, MQTT or AMQP are the best protocols to use. For rarely connected devices, HTTPS works as well.
 -  Field gateways. When using MQTT and HTTPS, you cannot connect multiple devices (each with its own per-device credentials) using the same TLS connection. For Field gateway scenarios that require one TLS connection between the field gateway and IoT Hub for each connected device, these protocols are suboptimal.
 -  Low resource devices. The MQTT and HTTPS libraries have a smaller footprint than the AMQP libraries. As such, if the device has limited resources (for example, less than 1-MB RAM), these protocols might be the only protocol implementation available.
 -  Network traversal. The standard AMQP protocol uses port 5671, and MQTT listens on port 8883. Use of these ports could cause problems in networks that are closed to non-HTTPS protocols. Use MQTT over WebSockets, AMQP over WebSockets, or HTTPS in this scenario.
 -  Payload size. MQTT and AMQP are binary protocols, which result in more compact payloads than HTTPS.
