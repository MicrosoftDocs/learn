Azure IoT Hub integrates with Azure Event Grid so that you can send event notifications to other services and trigger downstream processes. Configure your business applications to listen for IoT Hub events so that you can react to critical events in a reliable, scalable, and secure manner. For example, build an application that updates a database, creates a work ticket, and delivers an email notification every time a new IoT device is registered to your IoT hub.

Take a few minutes to watch this video that explains how the integration between IoT Hub and Event Grid works:

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RWxUkh]

## Event types and schema

IoT Hub publishes different types of events to Event Grid, including these:

| Event type | Description |
| ---------- | ----------- |
| Microsoft.Devices.DeviceCreated | Published when a device is registered to an IoT hub |
| Microsoft.Devices.DeviceDeleted | Published when a device is deleted from an IoT hub |
| Microsoft.Devices.DeviceConnected | Published when a device is connected to an IoT hub |
| Microsoft.Devices.DeviceDisconnected | Published when a device is disconnected from an IoT hub |
| Microsoft.Devices.DeviceTelemetry | Published when a device telemetry message is sent to an IoT hub |

You can use either the Azure portal or the Azure CLI to configure which events to publish from each IoT hub.

IoT Hub events contain all the information that you need to respond to changes in your device life cycle as well as telemetry conditions. You can identify an IoT Hub event by checking that the **eventType** property starts with **Microsoft.Devices**.

There are two types of schemas for IoT Hub events. One is for events related to device life cycle, and one is for telemetry events.

For more information about how to use the IoT Hub integration with Event Grid, visit the [documentation](https://docs.microsoft.com/azure/iot-hub/iot-hub-event-grid).

## Event filtering and enrichment

Depending on the type of events that you want to post to Event Grid for other services to be notified, you might want to implement some filtering. Some telemetry or device life-cycle events might not be relevant to the workflow that you want to implement. The IoT Hub event subscriptions can filter events based on event type, data content, and subject (which is the device name). To learn more about event filtering, refer to the [documentation](https://docs.microsoft.com/azure/iot-hub/iot-hub-event-grid#filter-events).

Before events are posted to Event Grid, you can enrich them by selecting the endpoint as Event Grid. For more information, see [Message enrichments overview](https://docs.microsoft.com/azure/iot-hub/iot-hub-message-enrichments-overview).

## Tips for consuming events

Applications that handle IoT Hub events should follow these suggested practices:

* Multiple subscriptions can be configured to route events to the same event handler, so don't assume that events are from a particular source. Always check the message topic to ensure that it comes from the IoT hub that you expect.

* Don't assume that all events you receive are the types that you expect. Always check the **eventType** property before processing the message.

* Messages can arrive out of order or after a delay. Use the **etag** field to understand if your information about objects is up to date for device creation or deletion events.

## Next steps

Now you have a better understanding of what Event Grid is and how IoT Hub and Event Grid can be integrated. The next unit will walk through connecting the dots between IoT Hub, Event Grid, and the email-sending logic app.
