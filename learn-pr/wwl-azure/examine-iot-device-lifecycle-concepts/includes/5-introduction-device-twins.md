Device twins are JSON documents managed by IoT Hub that store device state information associated with a physical device. This information includes metadata, configurations, and conditions. Azure IoT Hub maintains a device twin for each registered device (for each device identity).

Device twins store device-related information that:

 -  A device and back-end resources can use to synchronize device conditions and configuration.
 -  Back-end resources can access in order to target long-running operations. Back-end resources access the device twin through IoT Hub.

The lifecycle of a device twin is linked to the corresponding device identity. Device twins are implicitly created and deleted when a device identity is created or deleted in IoT Hub.

A device twin is a JSON document that includes:

 -  Tags. A section of the JSON document that the solution back end can read from and write to. Tags are not visible to device apps.
 -  Desired properties. Used along with reported properties to synchronize device configuration or conditions. The solution back end can set desired properties, and the device app can read them. The device app can also receive notifications of changes in the desired properties.
 -  Reported properties. Used along with desired properties to synchronize device configuration or conditions. The device app can set reported properties, and the solution back end can read and query them.
 -  Device identity properties. The root of the device twin JSON document contains the read-only properties from the corresponding device identity stored in the identity registry.

:::image type="content" source="../media/m02-l01-device-twin-diagram-03c0f21f.png" alt-text="Diagram that shows the primary components of a device twin document.":::


## Example document

The following example shows a device twin JSON document:

```json
{
    "deviceId": "devA",
    "etag": "AAAAAAAAAAc=",
    "status": "enabled",
    "statusReason": "provisioned",
    "statusUpdateTime": "0001-01-01T00:00:00",
    "connectionState": "connected",
    "lastActivityTime": "2015-02-30T16:24:48.789Z",
    "cloudToDeviceMessageCount": 0,
    "authenticationType": "sas",
    "x509Thumbprint": { 
        "primaryThumbprint": null,
        "secondaryThumbprint": null
    },
    "version": 2,
    "tags": {
        "$etag": "123",
        "deploymentLocation": {
            "building": "43",
            "floor": "1"
        }
    },
    "properties": {
        "desired": {
            "telemetryConfig": {
                "sendFrequency": "5m"
            },
            "$metadata": {...},
            "$version": 1
        },
        "reported": {
            "telemetryConfig": {
                "sendFrequency": "5m",
                "status": "success"
            },
            "batteryLevel": 55,
            "$metadata": {...},
            "$version": 4
        }
    }
}

```

## Usage

Use device twins to:

 -  Store device-specific metadata in the cloud. For example, the deployment location of a vending machine.
 -  Report current state information such as available capabilities and conditions from your device app. For example, a device is connected to your IoT hub over cellular or WiFi.
 -  Synchronize the state of long-running workflows between device app and back-end app. For example, when the solution back end specifies the new firmware version to install, and the device app reports the various stages of the update process.
 -  Query your device metadata, configuration, or state.

## Purpose and best practices

Device twins enable synchronizing desired configuration from the cloud and for reporting current configuration and device properties. The best way to implement device twins within cloud solutions applications is through the Azure IoT SDKs. Device twins are best suited for configuration because they:

 -  Support bi-directional communication.
 -  Allow for both connected and disconnected device states.
 -  Follow the principle of eventual consistency.
 -  Are fully queryable in the cloud.

## Module identity and module twins

Each device identity in IoT Hub can include up to 20 module identities, and each module identity implicitly generates a module twin. Similar to device twins, module twins are JSON documents that store module state information including metadata, configurations, and conditions. Azure IoT Hub maintains a module twin for each module that you connect to IoT Hub.

On the device side, the IoT Hub device SDKs enable you to create modules where each one opens an independent connection to IoT Hub. This functionality enables you to use separate namespaces for different components on your device. For example, you have a vending machine that has three different sensors. Each sensor is controlled by different departments in your company. You can create a module for each sensor. This way, each department is only able to create jobs or direct methods for the sensor that they control, avoiding conflicts and user errors.

Module identity and module twin provide the same capabilities as device identity and device twin but at a finer granularity. This finer granularity enables capable devices, such as operating system-based devices or firmware devices managing multiple components, to isolate configuration and conditions for each of those components. Module identity and module twins provide a management separation of concerns when working with IoT devices that have modular software components.
