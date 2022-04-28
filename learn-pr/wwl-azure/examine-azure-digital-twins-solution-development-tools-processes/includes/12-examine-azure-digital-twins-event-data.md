Different events in Azure Digital Twins produce notifications. These notifications make the solution backend aware of different actions when they happen. The event information is then routed to different locations inside and outside of Azure Digital Twins. The locations that receive the event information that can use it to take action.

There are several types of notifications that can be generated. Notification messages may look different depending on which type of event generated them. This following section provides details about different types of messages, and what they might look like.

This chart shows the different notification types:

:::row:::
  :::column:::
    **Notification type**
  :::column-end:::
  :::column:::
    **Routing source name**
  :::column-end:::
  :::column:::
    **Generated from...**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Digital Twin Change Notification
  :::column-end:::
  :::column:::
    Digital Twin Change Notification
  :::column-end:::
  :::column:::
    Any Digital Twin property change.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Digital Twin Lifecycle Notification
  :::column-end:::
  :::column:::
    Digital Twin Lifecycle Notification
  :::column-end:::
  :::column:::
    Any Digital Twin create or delete operation.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Digital Twin Relationship Change Notification
  :::column-end:::
  :::column:::
    Digital Twin Relationship Change Notification
  :::column-end:::
  :::column:::
    Any Digital Twin relationship change.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Digital Twin Telemetry Messages
  :::column-end:::
  :::column:::
    Telemetry Messages
  :::column-end:::
  :::column:::
    Any telemetry message.
  :::column-end:::
:::row-end:::


In general, notifications are made up of two parts: the header and the body.

## Event notification headers

Notification message headers are represented with key-value pairs. Depending on the protocol used (MQTT, AMQP, or HTTP), message headers will be serialized differently. The following section provides general header information for notification messages, regardless of the specific protocol (and serialization) chosen.

Some notifications conform to the CloudEvents standard. CloudEvents conformance is as follows.

 -  Notifications emitted from devices continue to follow the existing specifications for notifications.
 -  Notifications processed and emitted by IoT Hub continue to follow the existing specifications for notification, except where IoT Hub chooses to support CloudEvents, such as through Event Grid.
 -  Notifications emitted from digital twins with a model conform to CloudEvents.
 -  Notifications processed and emitted by Azure Digital Twins conform to CloudEvents.

Services will maintain the sequential order of notifications. For example, a sequence number could be added to the notifications to maintain the order. Services can use other systems to maintain the order of notifications. Notifications emitted by Azure Digital Twins to Event Grid will be automatically formatted using either the CloudEvents schema or EventGridEvent schema. The schema used will depend on the schema type defined in the Event Grid Topic.

Extension attributes on headers will be added as properties on the Event Grid schema inside of the payload.

## Event notification bodies

The bodies of notification messages are described here in JSON. Depending on the serialization desired for the message body (such as with JSON, CBOR, Protobuf, etc.), the message body may be serialized differently.

The set of fields that the body contains vary with different notification types. Here are two sample message bodies, to get an idea of what they generally look like and may include.

### Telemetry message:

```json
{
  "specversion": "1.0",
  "id": "df5a5992-817b-4e8a-b12c-e0b18d4bf8fb",
  "type": "microsoft.iot.telemetry",
  "source": "contoso-adt.api.wus2.digitaltwins.azure.net/digitaltwins/room1",
  "data": {
    "Temperature": 10
  },
  "dataschema": "dtmi:example:com:floor4;2",
  "datacontenttype": "application/json",
  "traceparent": "00-7e3081c6d3edfb4eaf7d3244b2036baa-23d762f4d9f81741-01"
}

```

### Life-cycle notification message:

```json
{
  "specversion": "1.0",
  "id": "d047e992-dddc-4a5a-b0af-fa79832235f8",
  "type": "Microsoft.DigitalTwins.Twin.Create",
  "source": "contoso-adt.api.wus2.digitaltwins.azure.net",
  "data": {
    "$dtId": "floor1",
    "$etag": "W/\"e398dbf4-8214-4483-9d52-880b61e491ec\"",
    "$metadata": {
      "$model": "dtmi:example:Floor;1"
    }
  },
  "subject": "floor1",
  "time": "2020-06-23T19:03:48.9700792Z",
  "datacontenttype": "application/json",
  "traceparent": "00-18f4e34b3e4a784aadf5913917537e7d-691a71e0a220d642-01"
}

```

## Message-format detail for different event types

IoT Hub and Azure Digital Twins emit many different types of notifications. It is important for you to understand event parameters before you implement monitoring. The following items describe event details that you should study:

 -  The triggers for each notification type.
 -  The set of fields included with each type of notification body.

### Life-cycle notifications

All digital twins have life-cycle events and emit the associated notifications.

Life-cycle notifications are triggered when:

 -  A digital twin is created.
 -  A digital twin is deleted.

#### Properties

Here are the fields in the body of a life-cycle notification.

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
    `id`
  :::column-end:::
  :::column:::
    Identifier of the notification, such as a UUID or a counter maintained by the service. The `source` \+ `id` is unique for each distinct event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `source`
  :::column-end:::
  :::column:::
    Name of the IoT hub or Azure Digital Twins instance, like myhub.azure-devices.net or mydigitaltwins.westus2.azuredigitaltwins.net
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `specversion`
  :::column-end:::
  :::column:::
    1.0
The message conforms to this version of the CloudEvents spec.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `type`
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins.Twin.Create
Microsoft.DigitalTwins.Twin.Delete
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `datacontenttype`
  :::column-end:::
  :::column:::
    application/json
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `subject`
  :::column-end:::
  :::column:::
    ID of the digital twin
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `time`
  :::column-end:::
  :::column:::
    Timestamp for when the operation occurred on the twin.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `traceparent`
  :::column-end:::
  :::column:::
    A W3C trace context for the event.
  :::column-end:::
:::row-end:::


#### Body details

The body of the notification provides information about the digital twin. The message body is formatted as JSON.

For creation events, the payload reflects the state of the twin after the resource is created, so it should include all system generated-elements just like a GET call.

Here is an example for a digital twin.

```json
{
  "$dtId": "logical-digitaltwin-01",
  "$etag": "W/\"e59ce8f5-03c0-4356-aea9-249ecbdc07f9\"",
  "avgTemperature": 70,
  "comfortIndex": 85,
  "$metadata": {
    "$model": "dtmi:com:contoso:Building;1",
    "avgTemperature": {
      "desiredValue": 72,
      "desiredVersion": 5,
      "ackVersion": 4,
      "ackCode": 200,
      "ackDescription": "OK"
    },
    "comfortIndex": {
      "desiredValue": 90,
      "desiredVersion": 1,
      "ackVersion": 3,
      "ackCode": 200,
      "ackDescription": "OK"
    }
  }
}

```

### Relationship change notifications

Digital twins have relationships to other digital twins. Relationship change notifications are triggered when any relationship is created, updated, or deleted.

#### Properties

Here are the fields in the body of an edge change notification.

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
    `id`
  :::column-end:::
  :::column:::
    Identifier of the notification, such as a UUID or a counter maintained by the service. The `source` \+ `id` is unique for each distinct event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `source`
  :::column-end:::
  :::column:::
    Name of the IoT Hub or Azure Digital Twins instance, like myhub.azure-devices.net or mydigitaltwins.westus2.azuredigitaltwins.net.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `specversion`
  :::column-end:::
  :::column:::
    1.0
The message conforms to this version of the CloudEvents spec.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `type`
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins.Relationship.Create
Microsoft.DigitalTwins.Relationship.Update
Microsoft.DigitalTwins.Relationship.Delete
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `datacontenttype`
  :::column-end:::
  :::column:::
    application/json
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `subject`
  :::column-end:::
  :::column:::
    ID of the relationship, like `<twinID>/relationships/<relationshipID>`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `time`
  :::column-end:::
  :::column:::
    Timestamp for when the operation occurred on the relationship.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `traceparent`
  :::column-end:::
  :::column:::
    A W3C trace context for the event.
  :::column-end:::
:::row-end:::


#### Body details

The body is the payload of a relationship, also in JSON format. It uses the same format as a GET request for a relationship via the DigitalTwins API. "Updating a relationship" means properties of the relationship have changed.

Here is an example of an update relationship notification to update a property:

```json
{
    "modelId": "dtmi:example:Floor;1",
    "patch": [
      {
        "value": "user3",
        "path": "/ownershipUser",
        "op": "replace"
      }
    ]
  }

```

For `Relationship.Delete`, the body is the same as the GET request, and it gets the latest state before deletion.

Here is an example of a create or delete relationship notification:

```json
{
    "$relationshipId": "device_to_device",
    "$etag": "W/\"72479873-0083-41a8-83e2-caedb932d881\"",
    "$relationshipName": "Connected",
    "$targetId": "device2",
    "connectionType": "WIFI"
}

```

### Change notifications

Change notifications are triggered when a digital twin is being updated, like:

 -  When property values or metadata changes.
 -  When digital twin or component metadata changes. An example of this scenario is changing the model of a digital twin.

#### Properties

Here are the fields in the body of an edge change notification.

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
    `id`
  :::column-end:::
  :::column:::
    Identifier of the notification, such as a UUID or a counter maintained by the service. The `source` \+ `id` is unique for each distinct event.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `source`
  :::column-end:::
  :::column:::
    Name of the IoT Hub or Azure Digital Twins instance, like myhub.azure-devices.net or mydigitaltwins.westus2.azuredigitaltwins.net.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `specversion`
  :::column-end:::
  :::column:::
    1.0
The message conforms to this version of the CloudEvents spec.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `type`
  :::column-end:::
  :::column:::
    Microsoft.DigitalTwins.Twin.Update
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `datacontenttype`
  :::column-end:::
  :::column:::
    application/json
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `subject`
  :::column-end:::
  :::column:::
    ID of the digital twin.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `time`
  :::column-end:::
  :::column:::
    Timestamp for when the operation occurred on the digital twin.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    `traceparent`
  :::column-end:::
  :::column:::
    A W3C trace context for the event.
  :::column-end:::
:::row-end:::


#### Body details

The body for the `Twin.Update` notification is a JSON Patch document containing the update to the digital twin.

For example, say that a digital twin was updated using the following patch.

```json
[
  {
      "op": "replace",
      "value": 40,
      "path": "/Temperature"
  },
  {
      "op": "add",
      "value": 30,
      "path": "/comp1/prop1"
  }
]

```

The corresponding notification (if synchronously executed by the service, such as Azure Digital Twins updating a digital twin) would have a body like:

```json
{
    "modelId": "dtmi:example:com:floor4;2",
    "patch": [
      {
        "value": 40,
        "path": "/Temperature",
        "op": "replace"
      },
      {
        "value": 30,
        "path": "/comp1/prop1",
        "op": "add"
      }
    ]
  }

```
