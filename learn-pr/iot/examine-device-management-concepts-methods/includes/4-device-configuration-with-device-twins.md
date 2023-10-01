The ability to configure devices from your back-end service is a core component of most device management solutions.

To synchronize state information between a device and an IoT hub, you use device twins. A device twin is a JSON document that is associated with a specific device and stored by IoT Hub in the cloud where you can query it. A device twin contains the following information:

- A *desired property* is set by a back-end application and read by a device.
- A *reported property* is set by a device and read by a back-end application.
- A *tag* is set by a back-end application and is never sent to the device. Use tags to organize your devices. For example, a tag may contain a device location or category. You can assign more than one tag per device.

:::image type="content" source="../media/m08-l01-device-management-using-device-twin-properties-4defa110.png" alt-text="Diagram that shows the device twin properties used to synchronize state information between a device and an IoT hub.":::

## Device twin properties

Consider the following `properties` section of a device twin document:

```json
  "properties": {
      "desired": {
          "telemetryConfig": {
              "sendFrequency": "5m"
          },
          "$metadata" : {...},
          "$version": 1
      },
      "reported": {
          "telemetryConfig": {
              "sendFrequency": "5m",
              "status": "success"
          },
          "$metadata" : {...},
          "$version": 4
      }
  }

```

In this example, the `telemetryConfig` device twin desired and reported properties are used by the solution back end and the device app to synchronize the telemetry configuration for this device. An update to the device configuration could be implemented as follows:

1. The solution back end sets the `desired` property with the desired configuration value.
2. The device app is notified of the change immediately if connected, or at the first reconnect. The device app then reports the updated configuration (or an error condition using the `status` property).
3. The solution back end can track the results of the configuration operation across many devices by querying device twins.

## Back-end operations

The solution back end operates on the device twin using the following atomic operations, exposed through HTTPS:

- **Retrieve device twin by ID**. This operation returns the device twin document, including tags and desired and reported system properties.
- **Partially update device twin**. This operation enables the solution back end to partially update the tags or desired properties in a device twin. The partial update is expressed as a JSON document that adds or updates any property. Properties set to `null` are removed. The following example creates a new desired property with value `{"newProperty": "newValue"}`, overwrites the existing value of `existingProperty` with `"otherNewValue"`, and removes `otherOldProperty`. No other changes are made to existing desired properties or tags:

  ```json
    {
      "properties": {
          "desired": {
              "newProperty": {
                  "nestedProperty": "newValue"
              },
              "existingProperty": "otherNewValue",
              "otherOldProperty": null
          }
      }
    }

  ```

- **Replace desired properties**. This operation enables the solution back end to completely overwrite all existing desired properties and substitute a new JSON document for `properties/desired`.
- **Replace tags**. This operation enables the solution back end to completely overwrite all existing tags and substitute a new JSON document for `tags`.
- **Receive twin notifications**. This operation allows the solution back end to be notified when the twin is modified. To do so, your IoT solution needs to create a route and to set the Data Source equal to *twinChangeEvents*. By default, no such route exists, so no twin notifications are sent. If the rate of change is too high, or for other reasons such as internal failures, the IoT Hub might send only one notification that contains all changes. Therefore, if your application needs reliable auditing and logging of all intermediate states, you should use device-to-cloud messages. The twin notification message includes properties and body.

  - Properties. The properties for a twin notification message are shown in the following table. Message system properties are prefixed with the $ symbol.
  
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
          Date and time when the notification was sent.
        :::column-end:::
      :::row-end:::
      :::row:::
        :::column:::
          $iothub-message-source
        :::column-end:::
        :::column:::
          twinChangeEvents
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
          deviceId
        :::column-end:::
        :::column:::
          ID of the device.
        :::column-end:::
      :::row-end:::
      :::row:::
        :::column:::
          hubName
        :::column-end:::
        :::column:::
          Name of IoT Hub that generated the event.
        :::column-end:::
      :::row-end:::
      :::row:::
        :::column:::
          operationTimestamp
        :::column-end:::
        :::column:::
          ISO8601 timestamp of operation.
        :::column-end:::
      :::row-end:::
      :::row:::
        :::column:::
          iothub-message-schema
        :::column-end:::
        :::column:::
          The message schema associated with the event category; for example, deviceLifecycleNotification.
        :::column-end:::
      :::row-end:::
      :::row:::
        :::column:::
          moduleid
        :::column-end:::
        :::column:::
          The module ID. This property is output only for module lifecycle and twin change events.
        :::column-end:::
      :::row-end:::
      :::row:::
        :::column:::
          opType
        :::column-end:::
        :::column:::
          "replaceTwin" or "updateTwin"
        :::column-end:::
      :::row-end:::

  - Body. This section of a twin notification message includes all the twin changes in a JSON format. It uses the same format as a patch, with the difference that it can contain all twin sections: tags, properties.reported, properties.desired, and that it contains the `$metadata` elements.

In addition to these operations, the solution back end can:

- Query the device twins using the SQL-like IoT Hub query language.
- Perform operations on large sets of device twins using jobs.

## Device operations

The device app operates on the device twin using the following atomic operations:

- **Retrieve device twin**. This operation returns the device twin document (including desired and reported system properties) for the currently connected device.
    > [!NOTE]
    > Tags are not visible to device apps.
- **Partially update reported properties**. This operation enables the partial update of the reported properties of the currently connected device. This operation uses the same JSON update format that the solution back end uses for a partial update of desired properties.
- **Observe desired properties**. The currently connected device can choose to be notified of updates to the desired properties when they happen. The device receives the same form of update (partial or full replacement) executed by the solution back end.

All the preceding operations require the `DeviceConnect` permission.

The Azure IoT Hub device SDKs make it easy to use the preceding operations from many languages and platforms.

## Device twin metadata

IoT Hub maintains the timestamp of the last update for each JSON object in device twin desired and reported properties. The timestamps are in UTC and encoded in the ISO8601 format `YYYY-MM-DDTHH:MM:SS.mmmZ`.

For example:

```json
  "properties": {
      "desired": {
          "telemetryConfig": {
              "sendFrequency": "5m"
          },
          "$metadata": {
              "telemetryConfig": {
                  "sendFrequency": {
                      "$lastUpdated": "2019-08-30T16:24:48.789Z"
                  },
                  "$lastUpdated": "2019-08-30T16:24:48.789Z"
              },
              "$lastUpdated": "2019-08-30T16:24:48.789Z"
          },
          "$version": 23
      },
      "reported": {
          "telemetryConfig": {
              "sendFrequency": "5m",
              "status": "success"
          },
          "batteryLevel": "55%",
          "$metadata": {
              "telemetryConfig": {
                  "sendFrequency": "5m",
                  "status": {
                      "$lastUpdated": "2019-08-31T16:35:48.789Z"
                  },
                  "$lastUpdated": "2019-08-31T16:35:48.789Z"
              },
              "$lastUpdated": "2019-08-31T16:35:48.789Z"
          },
          "$version": 123
      }
  }

```

This information is kept at every level (not just the leaves of the JSON structure) to preserve updates that remove object keys.

## Optimistic concurrency

Tags, desired, and reported properties all support optimistic concurrency. Tags have an ETag, as per RFC7232, that represents the tag's JSON representation. You can use ETags in conditional update operations from the solution back end to ensure consistency.

Device twin desired and reported properties do not have ETags, but have a $version value that is guaranteed to be incremental. Similarly to an ETag, the version can be used by the updating party to enforce consistency of updates. For example, a device app for a reported property or the solution back end for a desired property.

Versions are also useful when an observing agent (such as the device app observing the desired properties) must reconcile races between the result of a retrieve operation and an update notification.

## Device reconnection flow

IoT Hub does not preserve desired properties update notifications for disconnected devices. It follows that a device that is connecting must retrieve the full desired properties document, in addition to subscribing for update notifications. Given the possibility of races between update notifications and full retrieval, the following flow must be ensured:

- Device app connects to an IoT hub.
- Device app subscribes for desired properties update notifications.
- Device app retrieves the full document for desired properties.

The device app can ignore all notifications with `$version` less or equal than the version of the full retrieved document. This approach is possible because IoT Hub guarantees that versions always increment.

> [!NOTE]
> This logic is already implemented in the Azure IoT Hub device SDKs. This description is useful only if the device app cannot use any of Azure IoT device SDKs and must program the MQTT interface directly.
