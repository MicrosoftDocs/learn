Azure IoT Edge modules can connect with other Azure services and contribute to your larger cloud data pipeline.

## IoT Edge runtime environment

The IoT Edge runtime provides the infrastructure to integrate the functionality of multiple IoT Edge modules and to deploy them onto IoT Edge devices. At a high level, any program can be packaged as an IoT Edge module. However, to take full advantage of IoT Edge communication and management functionalities, a program running in a module can use the Azure IoT Device SDK to connect to the local IoT Edge hub.

> [!NOTE]
> IoT Edge 1.2 introduces the MQTT broker, which enables modules to use any MQTT client to connect to the local IoT Edge hub. This feature provides an alternative to using the SDK.

## Using the IoT Edge hub

The IoT Edge hub provides two main functionalities - proxy to IoT Hub, and local communications.

### Connecting to IoT Edge hub from a module

Connecting to the local IoT Edge hub from a module involves two steps:

1.  Create a ModuleClient instance in your application.
2.  Make sure your application accepts the certificate presented by the IoT Edge hub on that device.

To use IoT Edge routing over AMQP or MQTT, you can use the ModuleClient from the Azure IoT SDK. Create a ModuleClient instance to connect your module to the IoT Edge hub running on the device, similar to how DeviceClient instances connect IoT devices to IoT Hub. For more information about the ModuleClient class and its communication methods, see the API reference for your preferred SDK language: C\#, C, Python, Java, or Node.js.

> [!NOTE]
> To use IoT Edge MQTT broker introduced with IoT Edge 1.2, you need to bring your own MQTT client and initiate the connection yourself with information that you retrieve from the IoT Edge daemon workload API.

### IoT Hub primitives

IoT Hub sees a module instance analogously to a device, in the sense that:

 -  It has a module twin that is distinct and isolated from the device twin and the other module twins of that device.
 -  It can send device-to-cloud messages.
 -  It can receive direct methods targeted specifically at its identity.

Currently, modules cannot receive cloud-to-device messages or use the file upload feature.

When writing a module, you can connect to the IoT Edge hub and use IoT Hub primitives as you would when using IoT Hub with a device application. The only difference between IoT Edge modules and IoT device applications is that you have to refer to the module identity instead of the device identity.

### Device-to-cloud messages

An IoT Edge module can send messages to the cloud via the IoT Edge hub that acts as a local broker and propagates messages to the cloud. To enable complex processing of device-to-cloud messages, an IoT Edge module can also intercept and process messages sent by other modules or devices to its local IoT Edge hub and send new messages with processed data. Chains of IoT Edge modules can thus be created to build local processing pipelines.

To send device-to-cloud telemetry messages using routing, use the ModuleClient of the Azure IoT SDK. With the Azure IoT SDK, each module has the concept of module input and output endpoints, which map to special MQTT topics. Use the ModuleClient.sendMessageAsync method and it will send messages on the output endpoint of your module. Then configure a route in edgeHub to send this output endpoint to IoT Hub.

> [!NOTE]
> Sending device-to-cloud telemetry messages with the MQTT broker is similar to publishing messages on user-defined topics, but using the following IoT Hub special topic for your module: devices/&lt;device\_name&gt;/&lt;module\_name&gt;/messages/events. Authorizations must be set up appropriately. The MQTT bridge must also be configured to forward the messages on this topic to the cloud.

To process messages using routing, first set up a route to send messages coming from another endpoint (module or device) to the input endpoint of your module, then listen for messages on the input endpoint of your module. Each time a new message comes back, a callback function is triggered by the Azure IoT SDK. Process your message with this callback function and optionally send new messages on your module endpoint queue.

### Twins

Twins are one of the primitives provided by IoT Hub. There are JSON documents that store state information including metadata, configurations, and conditions. Each module or device has its own twin.

To get a module twin with the Azure IoT SDK, call the ModuleClient.getTwin method.

To get a module twin with any MQTT client, slightly more work is involved since getting a twin is not a typical MQTT pattern. The module must first subscribe to IoT Hub special topic $iothub/twin/res/\#. This topic name is inherited from IoT Hub, and all devices/modules need to subscribe to the same topic. It does not mean that devices receive the twin of each other. IoT Hub and edgeHub know which twin should be delivered where, even if all devices listen to the same topic name. Once the subscription is made, the module needs to ask for the twin by publishing a message to the following IoT Hub special topic with a request ID $iothub/twin/GET/?$rid=1234. This request ID is an arbitrary ID (that is, a GUID), which will be sent back by IoT Hub along with the requested data. This is how a client can pair its requests with the responses. The result code is a HTTP-like status code, where successful is encoded as 200.

To receive a module twin patch with the Azure IoT SDK, implement a callback function and register it with the ModuleClient.moduleTwinCallback method from the Azure IoT SDK so that your callback function is triggered each time that a twin patch comes in.

To receive a module twin patch with any MQTT client, the process is similar to receiving full twins: a client needs to subscribe to special IoT Hub topic $iothub/twin/PATCH/properties/desired/\#. After the subscription is made, when IoT Hub sends a change of the desired section of the twin, the client receives it.

### Receive direct methods

To receive a direct method with the Azure IoT SDK, implement a callback function and register it with the ModuleClient.methodCallback method from the Azure IoT SDK so that your callback function is triggered each time that a direct method comes in.

To receive a direct method with any MQTT client, the process is similar to receiving twin patches. The client needs to confirm back that it has received the call and can send back some information at the same time.
