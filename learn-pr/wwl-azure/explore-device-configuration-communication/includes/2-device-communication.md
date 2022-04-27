IoT Hub allows for bi-directional communication with your devices. Use IoT Hub messaging to communicate with your devices by sending messages from your devices to your solutions back end and sending commands from your IoT solutions back end to your devices. The two most basic forms of device communication are as follows:

 -  Sending device-to-cloud messages to IoT Hub: IoT Hub has a built-in service endpoint that can be used by back-end services to read telemetry messages from your devices. This endpoint is compatible with Event Hubs and you can use standard IoT Hub SDKs to read from this built-in endpoint.
 -  Sending cloud-to-device messages from IoT Hub: You can send cloud-to-device messages from the solution back end to your devices. Cloud-to-device messaging is only available in the standard tier of IoT Hub.

Core properties of IoT Hub messaging functionality are the reliability and durability of messages. These properties enable resilience to intermittent connectivity on the device side, and to load spikes in event processing on the cloud side. IoT Hub implements at least once delivery guarantees for both device-to-cloud and cloud-to-device messaging.

## Device-to-Cloud communications

When sending information from the device app to the solution back end, IoT Hub exposes three options:

 -  Device-to-cloud messages for time series telemetry and alerts.
 -  Device twin's reported properties for reporting device state information such as available capabilities, conditions, or the state of long-running workflows. For example, configuration and software updates.
 -  File uploads for media files and large telemetry batches uploaded by intermittently connected devices or compressed to save bandwidth.

## Cloud-to-Device communications

IoT Hub provides three options for communicating to a device from a back-end app:

 -  Direct methods for communications that require immediate confirmation of the result. Direct methods are often used for interactive control of devices such as turning on a fan.
 -  Twin's desired properties for long-running commands intended to put the device into a certain desired state. For example, set the telemetry send interval to 30 minutes.
 -  Cloud-to-device messages for one-way notifications to the device app.
