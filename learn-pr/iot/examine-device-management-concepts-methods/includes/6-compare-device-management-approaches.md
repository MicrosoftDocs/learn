IoT Hub provides three options for device apps to expose functionality to a back-end app:

- **Direct methods** for communications that require immediate confirmation of the result. Direct methods are often used for interactive control of devices such as turning on a fan.
- **Twin's desired properties** for commands that put the device into a certain desired state. For example, set the telemetry send interval to 30 minutes.
- **Cloud-to-device messages** for one-way notifications to the device app.

Of these options, direct methods and device twin properties are good choices for device management.

## Choosing between device twin and direct method approaches

Here's a detailed comparison of the various cloud-to-device communication options.

:::row:::
  :::column:::
    **Category**
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
    Disconnected devices aren't contacted. The solution back end is notified that the device isn't connected.
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
    Single device using **deviceId**, or multiple devices using jobs.
  :::column-end:::
  :::column:::
    Single device using **deviceId**, or multiple devices using jobs.
  :::column-end:::
  :::column:::
    Single device by **deviceId**.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Size
  :::column-end:::
  :::column:::
    Maximum direct method payload size is 128 KB for the request and 128 KB for the response.
  :::column-end:::
  :::column:::
    Maximum desired properties size is 32 KB.
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
    High
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Low
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
