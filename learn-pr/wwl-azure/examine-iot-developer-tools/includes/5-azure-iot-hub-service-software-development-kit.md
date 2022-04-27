The IoT Hub Service SDKs enable you to build backend applications that interact directly with IoT Hub. The service SDKs contain code that facilitates building applications to manage your IoT hub, send C2D messages, schedule jobs, invoke direct methods, or send desired property updates to your IoT devices or modules.

> [!NOTE]
> Microsoft provides separate SDKs for IoT Hub Device Provisioning Service (DPS) and the Azure Digital Twins service.

## Coding language support

Five languages are currently supported: C, C\#, Java, Node.js, and Python.

## Backend app scenarios

 -  Identity registry (CRUD): Use your backend app to perform CRUD operation for individual device or in bulk.
 -  Cloud-to-device messaging: Use your backend app to send cloud-to-device messages in AMQP and AMQP-WS, and set up cloud-to-device message receivers.
 -  Direct Methods operations: Use your backend app to invoke direct method on device.
 -  Device Twins operations: Use your backend app to perform twin operations. The .NET (C\#) SDK only supports Get Twin at the moment.
 -  Query: Use your backend app to perform query for information.
 -  Jobs: Use your backend app to perform job operation.
 -  File Upload: Set up your backend app to send file upload notification receiver.

Here is a detailed comparison of the various cloud-to-device communication options.

:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    **Direct methods**
  :::column-end:::
  :::column:::
    **Twin's desired properties**
  :::column-end:::
  :::column:::
    **Cloud-to-device messages**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Scenario
  :::column-end:::
  :::column:::
    Commands that require immediate confirmation, such as turning on a fan.
  :::column-end:::
  :::column:::
    Long-running commands intended to put the device into a certain desired state. For example, set the telemetry send interval to 30 minutes.
  :::column-end:::
  :::column:::
    One-way notifications to the device app.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Data flow
  :::column-end:::
  :::column:::
    Two-way. The device app can respond to the method right away. The solution back end receives the outcome contextually to the request.
  :::column-end:::
  :::column:::
    One-way. The device app receives a notification with the property change.
  :::column-end:::
  :::column:::
    One-way. The device app receives the message.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Durability
  :::column-end:::
  :::column:::
    Disconnected devices are not contacted. The solution back end is notified that the device is not connected.
  :::column-end:::
  :::column:::
    Property values are preserved in the device twin. Device will read it at next reconnection. Property values are retrievable with the IoT Hub query language.
  :::column-end:::
  :::column:::
    Messages can be retained by IoT Hub for up to 48 hours.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Targets
  :::column-end:::
  :::column:::
    Single device using deviceId, or multiple devices using jobs.
  :::column-end:::
  :::column:::
    Single device using deviceId, or multiple devices using jobs.
  :::column-end:::
  :::column:::
    Single device by deviceId.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Size
  :::column-end:::
  :::column:::
    Maximum direct method payload size is 128 KB.
  :::column-end:::
  :::column:::
    Maximum desired properties size is 8 KB.
  :::column-end:::
  :::column:::
    Up to 64 KB messages.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Frequency
  :::column-end:::
  :::column:::
    High. For more information, see IoT Hub limits.
  :::column-end:::
  :::column:::
    Medium. For more information, see IoT Hub limits.
  :::column-end:::
  :::column:::
    Low. For more information, see IoT Hub limits.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Protocol
  :::column-end:::
  :::column:::
    Available using MQTT or AMQP.
  :::column-end:::
  :::column:::
    Available using MQTT or AMQP.
  :::column-end:::
  :::column:::
    Available on all protocols. Device must poll when using HTTPS.
  :::column-end:::
:::row-end:::
