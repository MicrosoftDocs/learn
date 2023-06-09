Gateways in IoT Edge solutions provide device connectivity and edge analytics to IoT devices that otherwise wouldn't have those capabilities. Azure IoT Edge can be used to satisfy all needs for an IoT gateway regardless of whether they are related to connectivity, identity, or edge analytics.

In this training, gateway patterns refer to characteristics of downstream device connectivity and device identity, not how device data is processed on the gateway.

## Patterns

There are three patterns for using an IoT Edge device as a gateway: transparent, protocol translation, and identity translation:

 -  Transparent – Devices that theoretically could connect to IoT Hub can connect to a gateway device instead. The downstream devices have their own IoT Hub identities and are using any of the MQTT, AMQP, or HTTP protocols. The gateway simply passes communications between the devices and IoT Hub. The devices are unaware that they are communicating with the cloud via a gateway, and a user interacting with the devices in IoT Hub is unaware of the intermediate gateway device. Thus, the gateway is transparent.
 -  Protocol translation – Also known as an opaque gateway pattern, devices that do not support MQTT, AMQP, or HTTP can use a gateway device to send data to IoT Hub on their behalf. The gateway understands the protocol used by the downstream devices and is the only device that has an identity in IoT Hub. All information looks like it is coming from one device, the gateway. Downstream devices must embed extra identifying information in their messages if cloud applications want to analyze the data on a per-device basis. Additionally, IoT Hub primitives like twins and methods are only available for the gateway device, not downstream devices.
 -  Identity translation - Devices that cannot connect to IoT Hub directly can connect to a gateway device instead. The gateway provides IoT Hub identity and protocol translation on behalf of the downstream devices. The gateway is smart enough to understand the protocol used by the downstream devices, provide them identity, and translate IoT Hub primitives. Downstream devices appear in IoT Hub as first-class devices with twins and methods. A user can interact with the devices in IoT Hub and is unaware of the intermediate gateway device.

:::image type="content" source="../media/m06-l03-iot-edge-gateway-8836b3a3.png" alt-text="Diagram that shows the three patterns for using an IoT Edge device as a gateway.":::


## Use cases

All gateway patterns provide the following benefits:

 -  Analytics at the edge – Use AI services locally to process data coming from downstream devices without sending full-fidelity telemetry to the cloud. Find and react to insights locally and only send a subset of data to IoT Hub.
 -  Downstream device isolation – The gateway device can shield all downstream devices from exposure to the Internet. It can sit in between an OT network that does not have connectivity and an IT network that provides access to the web.
 -  Connection multiplexing - All devices connecting to IoT Hub through an IoT Edge gateway use the same underlying connection.
 -  Traffic smoothing - The IoT Edge device will automatically implement exponential backoff if IoT Hub throttles traffic, while persisting the messages locally. This benefit makes your solution resilient to spikes in traffic.
 -  Offline support - The gateway device stores messages and twin updates that cannot be delivered to IoT Hub.

A gateway that does protocol translation can also perform edge analytics, device isolation, traffic smoothing, and offline support to existing devices and new devices that are resource constrained. Many existing devices are producing data that can power business insights; however they were not designed with cloud connectivity in mind. Opaque gateways allow this data to be unlocked and used in an IoT solution.

A gateway that does identity translation provides the benefits of protocol translation and additionally allows for full manageability of downstream devices from the cloud. All devices in your IoT solution show up in IoT Hub regardless of the protocol they use.

## Cheat sheet

Here is a quick cheat sheet that compares IoT Hub primitives when using transparent, opaque (protocol), and proxy gateways.

:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    **Transparent gateway**
  :::column-end:::
  :::column:::
    **Protocol translation**
  :::column-end:::
  :::column:::
    **Identity translation**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Identities stored in the IoT Hub identity registry.
  :::column-end:::
  :::column:::
    Identities of all connected devices.
  :::column-end:::
  :::column:::
    Only the identity of the gateway device.
  :::column-end:::
  :::column:::
    Identities of all connected devices.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device twin.
  :::column-end:::
  :::column:::
    Each connected device has its own device twin.
  :::column-end:::
  :::column:::
    Only the gateway has a device and module twins.
  :::column-end:::
  :::column:::
    Each connected device has its own device twin.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Direct methods and cloud-to-device messages.
  :::column-end:::
  :::column:::
    The cloud can address each connected device individually.
  :::column-end:::
  :::column:::
    The cloud can only address the gateway device.
  :::column-end:::
  :::column:::
    The cloud can address each connected device individually.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Hub throttles and quotas.
  :::column-end:::
  :::column:::
    Apply to each device.
  :::column-end:::
  :::column:::
    Apply to the gateway device.
  :::column-end:::
  :::column:::
    Apply to each device.
  :::column-end:::
:::row-end:::


When using an opaque gateway (protocol translation) pattern, all devices connecting through that gateway share the same cloud-to-device queue, which can contain at most 50 messages. It follows that the opaque gateway pattern should be used only when few devices are connecting through each field gateway, and their cloud-to-device traffic is low.

## IoT Plug and Play bridge

The IoT Plug and Play bridge is an open-source application for connecting existing devices attached to Windows or Linux gateway as IoT Plug and Play devices. After installing and configuring the application on your Windows or Linux machine, you can use it to connect attached devices to an IoT hub. You can use the bridge to map IoT Plug and Play interfaces to the telemetry the attached devices are sending, work with device properties, and invoke commands.

IoT Plug and Play bridge can be deployed as a standalone executable on any IoT device, industrial PC, server, or gateway running Windows 10 or Linux. It can also be compiled into your application code. A simple configuration JSON file tells the IoT Plug and Play bridge which attached devices/peripherals should be exposed up to Azure.

You can find more information about IoT Plug and Play bridge here: [IoT Plug and Play bridge](/azure/iot-develop/concepts-iot-pnp-bridge).